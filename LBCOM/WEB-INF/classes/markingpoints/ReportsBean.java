package markingpoints;   
import java.io.*;
import java.sql.*;
import java.util.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
import common.CommonBean;
public class ReportsBean{
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null; 
	public void setConnection(Connection con1) {
			try{	
				con = con1;
				st=con.createStatement();
				st1=con.createStatement();
			}catch(Exception e){
				ExceptionsFile.postException("ReportsBean.java","constructor","Exception",e.getMessage());
			}
	}
	public String[] getMarkingDates(String schoolid,String marking_id,String courseId){
		String[] result = new String[2];
		CommonBean common=new CommonBean();
		try{
			String namearr[]=marking_id.split(",");
			if(namearr.length>1){				
				result[0]=common.convertDate(namearr[1]);		//Converting m/d/yy to yyyy-mm-dd
				result[1]=common.convertDate(namearr[2]);
			}else{			
				String query="SELECT s_date,e_date FROM marking_course WHERE schoolid='"+schoolid+"' and courseid='"+courseId+"' and m_id='"+marking_id+"'";
				rs1=st1.executeQuery(query);
				if(rs1.next()){
					result[0]=rs1.getString("s_date");
					result[1]=rs1.getString("e_date");	
				}else{
					query="SELECT s_date,e_date FROM marking_admin WHERE schoolid='"+schoolid+"' and m_id='"+marking_id+"'";
					rs1=st1.executeQuery(query);
					if(rs1.next()){
						result[0]=rs1.getString("s_date");
						result[1]=rs1.getString("e_date");
					}
				}
			}
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result;

	}	
	//////// END OF getMarkingDates


	/// ///  THIS IS FOR SUMMARY REPORT IN STUDENT AND TEACHER
	public Hashtable getActivityTypeGrade(String courseId,String classId,String user_id,String schoolid,String[] dates,boolean wb,boolean ba){   
		Hashtable result = new Hashtable();
		String weight="",byattempt="";
		if(wb==true)				//if weightage based
			weight="AND weightage>0";
		if(ba==true)				//if By attempt based
			byattempt="(att.t_date between '"+dates[0]+"' and '"+dates[1]+"' and (c.status=1 ||c.status=2))or(c.submit_date between '"+dates[0]+"' and '"+dates[1]+"')";	 
		else
			byattempt="att.t_date between '"+dates[0]+"' and '"+dates[1]+"'";
		try{
			float marks_secred=0,maxmarks=0;
			result.put("ex","0");
			result.put("as","0");
			String query=null;
			query="select IFNULL(sum(c.acount),0) as a_count,cim.category_type,sum(c.totalmarks) as max_marks,sum(c.marks_secured) as marks_secured from (select item_id,weightage,category_type,item_des from category_item_master where course_id='"+courseId+"' and category_type!='CM'and category_type!='CO' and grading_system!=0 and  school_id='"+schoolid+"'"+weight+") as cim LEFT OUTER JOIN (select COUNT(activity_id) as acount, c.category_id,sum(CASE WHEN c.category_id='EC' THEN 0 ELSE c.total_marks END) as totalmarks,sum(c.marks_secured) as marks_secured from "+schoolid+"_cescores c ,"+schoolid+"_activities att where total_marks>0 and c.report_status=1 and (c.status=1 ||c.status=2) and c.school_id='"+schoolid+"' and c.course_id='"+courseId+"' and att.activity_id=c.work_id and c.user_id='"+user_id+"' and ("+byattempt+") GROUP BY c.category_id) as c on c.category_id=cim.item_id GROUP BY cim.category_type";
			rs1=st1.executeQuery(query);
			while(rs1.next()){
				String a_count=rs1.getString("a_count");				
				if(rs1.getString("category_type").equals("EX"))
					result.put("ex",a_count);
				else
					result.put("as",a_count);
				marks_secred=marks_secred+rs1.getFloat("marks_secured");
				maxmarks=maxmarks+rs1.getFloat("max_marks");				
			}			
			result.put("marks_secred",new Float(marks_secred));
			result.put("maxmarks",new Float(maxmarks));
			result.put("percent",trimFloat((marks_secred/maxmarks)*100));
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java"+e);
		}
		return(result);
	}// END of Get course grade		

	//THIS IS FOR REPORT BY COURSE IN STUDENT

	public Vector getCountByACategoryType(String schoolid,String user_id,String courseId,String[] dates,boolean wb,boolean ba){
		Vector result=new Vector(10,5);
		String weight="",byattempt="";
		if(wb==true) //if weightage based
			weight="AND weightage>0";
		if(ba==true) //if By attempt based
			byattempt="(att.t_date between '"+dates[0]+"' and '"+dates[1]+"' and c.status>0)or(c.submit_date between '"+dates[0]+"' and '"+dates[1]+"')";//OR c.status>0 
		else
			byattempt="att.t_date between '"+dates[0]+"' and '"+dates[1]+"'";//OR  
		float total_Points=0.0f,total_waitages=0.0f;
		String query="select cim.item_id,cim.weightage,cim.category_type,cim.item_des,IFNULL(c.totalmarks,0) totalmarks, IFNULL(c.marks_secured,0) marks_secured from (select item_id,weightage,category_type,item_des from category_item_master where course_id='"+courseId+"' and category_type!='CM'and category_type!='CO' and grading_system!=0 and   school_id='"+schoolid+"'"+weight+") as cim LEFT OUTER JOIN (select c.category_id,sum(c.total_marks) as totalmarks,sum(c.marks_secured) as marks_secured from "+schoolid+"_cescores c ,"+schoolid+"_activities att where c.school_id='"+schoolid+"' and c.report_status=1 and c.course_id='"+courseId+"' and att.activity_id=c.work_id and c.user_id='"+user_id+"' and ("+byattempt+") GROUP BY c.category_id) as c on c.category_id=cim.item_id ORDER BY cim.item_id";
		try{			
				rs=st.executeQuery(query);  
				// Add "and weightage>0" to get the weighted reports
				while(rs.next()){
					String max_marks="0",sec_marks="0";
					String[] result_str = new String[8];  // {a_type,cat_type,cat_name,max_points,sec_points,w_points,waitages}
					float wt=0.0f,percent=0.0f;
					max_marks=rs.getString("totalmarks");
					sec_marks=rs.getString("marks_secured");
					//if(max_marks==null)max_marks="0";
					//if(sec_marks==null)sec_marks="0";						
					if(max_marks!="0"){	
						percent=(Float.parseFloat(sec_marks)/Float.parseFloat(max_marks))*100;
						wt=(Float.parseFloat(sec_marks)*Integer.parseInt(rs.getString("weightage")))/Integer.parseInt(max_marks);
					}
					total_Points=total_Points+wt;
					total_waitages=total_waitages+Integer.parseInt(rs.getString("weightage"));
					result_str[0]=rs.getString("category_type");// AS/EX
					result_str[1]=rs.getString("item_id");		//WA/HW
					result_str[2]=rs.getString("item_des");		//Home work cat_name
					result_str[3]=max_marks;					//max marks
					result_str[4]=sec_marks;					//secured marks
					result_str[5]=rs.getString("weightage");	//weightage
					result_str[6]=""+wt+"";//.toString();		//weightage Marks		
					result_str[7]=trimFloat(percent);
					result.add(result_str);
				}
					float percent=total_Points*100/total_waitages;
					result.add(""+getGrade(percent,schoolid,courseId)+"");
					//result.add(total_waitages);
					
						
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
			e.printStackTrace();
		}
		return result;

	}  // END OF getCountByACategoryType

	// THIS IS FOR REPORT BY CLASS IN TEACHER AND ADMIN
	public String[] getcoursepercentandgrade(String schoolid,String user_id,String courseId,String marking_id){
		String[] result=new String[4];
		String[] dates=getMarkingDates(schoolid,marking_id,courseId);
		float total_Points=0.0f,total_waitages=0.0f;
		boolean flag=false;
		try{			
				rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and weightage=>0 and grading_system!=0 and school_id='"+schoolid+"' order by category_type");  //
				while(rs.next()){
					String max_marks="0",sec_marks="0";
					String[] result_str = new String[7];  // {a_type,cat_type,cat_name,max_points,sec_points,w_points,waitages}
					float wt=0.0f,percent=0.0f;
					String query="select sum(c.total_marks) as totalmarks,sum(c.marks_secured) as marks_secured from "+schoolid+"_cescores c,"+schoolid+"_activities att where c.school_id='"+schoolid+"' and c.report_status=1 and c.course_id='"+courseId+"' and  att.activity_id=c.work_id and c.user_id='"+user_id+"' and att.t_date between '"+dates[0]+"' and '"+dates[1]+"' and c.category_id='"+rs.getString("item_id")+"' GROUP BY c.category_id";
					rs1=st1.executeQuery(query); 
					if(rs1.next()){
						max_marks=rs1.getString("totalmarks");
						sec_marks=rs1.getString("marks_secured");
						if(max_marks==null)max_marks="0";
						if(sec_marks==null)sec_marks="0";
						if(Integer.parseInt(max_marks)>0)flag=true;
							if((max_marks!=null)&&(sec_marks!=null)&&(max_marks!="0")){	
								percent=(Float.parseFloat(sec_marks)/Float.parseFloat(max_marks))*100;
								wt=(Float.parseFloat(sec_marks)*Integer.parseInt(rs.getString("weightage")))/Integer.parseInt(max_marks);
						}
					}
					total_Points=total_Points+wt;
					total_waitages=total_waitages+Integer.parseInt(rs.getString("weightage"));				
				}
					float percent=total_Points*100/total_waitages;					
					result[0]=trimFloat(percent);					
					result[1]=getGrade(percent,schoolid,courseId);
					result[2]=trimFloat(percent);
					if(flag==false){
						result[0]="--";					
						result[1]=null;						
					}
					//result.add(total_waitages);						
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result; 

	}  // END OF getCountByACategoryType


	public String[] getcategorymaxmin(String schoolid,String user_id,String courseId,String marking_id,String cat_id){
		String[] result=new String[4];
		String[] dates=getMarkingDates(schoolid,marking_id,courseId);
		float total_Points=0.0f,total_waitages=0.0f;
		try{			
				rs=st.executeQuery("select * from category_item_master where item_id='"+cat_id+"' and course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and weightage>=0 and grading_system!=0 and school_id='"+schoolid+"' order by category_type"); int i=0;
				float wt=0.0f,percent=0.0f;
				String max_marks="0",sec_marks="0";
				while(rs.next()){
					String[] result_str = new String[7];  // {a_type,cat_type,cat_name,max_points,sec_points,w_points,waitages}
					String query="select sum(c.total_marks) as totalmarks,sum(c.marks_secured) as marks_secured from "+schoolid+"_cescores c,"+schoolid+"_activities att where c.school_id='"+schoolid+"' and c.report_status=1 and c.course_id='"+courseId+"' and  att.activity_id=c.work_id and c.user_id='"+user_id+"' and att.t_date between '"+dates[0]+"' and '"+dates[1]+"' and c.category_id='"+rs.getString("item_id")+"' GROUP BY c.category_id";
					rs1=st1.executeQuery(query); 
					if(rs1.next()){
						max_marks=rs1.getString("totalmarks");
						sec_marks=rs1.getString("marks_secured");
						if(max_marks==null)max_marks="0";
						if(sec_marks==null)sec_marks="0";	
						if((max_marks!=null)&&(sec_marks!=null)&&(max_marks!="0")){	
							percent=(Float.parseFloat(sec_marks)/Float.parseFloat(max_marks))*100;
							wt=(Float.parseFloat(sec_marks)*Integer.parseInt(rs.getString("weightage")))/Integer.parseInt(max_marks);
						}
					}
					total_Points=total_Points+wt;
					total_waitages=total_waitages+Integer.parseInt(rs.getString("weightage"));
				}
					result[0]=trimFloat(total_Points);					
					result[1]=trimFloat(total_waitages);
					if(Float.parseFloat(max_marks)>0)
						result[2]=trimFloat(percent)+"%";
					else
						result[2]="--";

					//result.add(total_waitages);						
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result;

	}  // END OF getCountByACategoryType

	public String getGrade(float percent,String schoolid,String courseId){
		String result="No"; 
		try{						
			rs1=st1.executeQuery("select grade_code from course_grades where schoolid='"+schoolid+"' and courseid='"+courseId+"' and minimum <='"+percent+"' and maximum >'"+percent+"'");
			if(rs1.next())
				result=rs1.getString("grade_code");
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result;
	}  // END OF getCountByACategoryType
	public String trimFloat(float f){
		f *= 100;
		f = (float)Math.round(f)/100;
		String temp=""+f+"";
		if(f==0)temp="0";
		return temp;
	}  
	
//////////////////////////////////////////////////////////       ADMIN          ///////////////////////////////////////////////////////








///////////////////////////////////////////////////////////TEST//////////////////////////////////////////////////

// getCountByAType is for getting count of activity depending on Activity type

	public String[] getCountByAType(String schoolid,String courseId,String[] dates){
		String[] result = new String[2];
		try{
			String query="SELECT count('activity_id'),activity_type FROM "+schoolid+"_activities where course_id='"+courseId+"' and t_date between '"+dates[0]+"' and '"+dates[1]+"' group by activity_type";
			rs1=st1.executeQuery(query);
			while(rs1.next())
			{
				if(rs1.getString(2).equals("EX")){
					result[0]=rs1.getString(1);
				}
				if(rs1.getString(2).equals("AS")){
					result[1]=rs1.getString(1);
				}
			}	
			if(result[0]==null)result[0]="0";
			if(result[1]==null)result[1]="0";


		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result;

	}  // END OF getCountByAType

	public Vector getCountByACategoryTypeold(String schoolid,String user_id,String courseId,String[] dates){
		Vector result=new Vector(10,5); 
		float total_Points=0.0f,total_waitages=0.0f;
		try{			
				rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and weightage>=0 and grading_system!=0 and school_id='"+schoolid+"' order by category_type");  
				// Add "and weightage>0" to get the weighted reports
				while(rs.next()){
					String max_marks="0",sec_marks="0";
					String[] result_str = new String[8];  // {a_type,cat_type,cat_name,max_points,sec_points,w_points,waitages}
					float wt=0.0f,percent=0.0f;
					String query="select sum(c.total_marks) as totalmarks,sum(c.marks_secured) as marks_secured from "+schoolid+"_cescores c,"+schoolid+"_activities att where c.school_id='"+schoolid+"' and c.report_status=1 and c.course_id='"+courseId+"' and  att.activity_id=c.work_id and c.user_id='"+user_id+"' and att.t_date between '"+dates[0]+"' and '"+dates[1]+"' and c.category_id='"+rs.getString("item_id")+"' GROUP BY c.category_id";
					rs1=st1.executeQuery(query); 
					if(rs1.next()){
						max_marks=rs1.getString("totalmarks");
						sec_marks=rs1.getString("marks_secured");
						if(max_marks==null)max_marks="0";
						if(sec_marks==null)sec_marks="0";						
						if((max_marks!=null)&&(sec_marks!=null)&&(max_marks!="0")){	
							percent=(Float.parseFloat(sec_marks)/Float.parseFloat(max_marks))*100;
							wt=(Float.parseFloat(sec_marks)*Integer.parseInt(rs.getString("weightage")))/Integer.parseInt(max_marks);
						}
					}
					total_Points=total_Points+wt;
					total_waitages=total_waitages+Integer.parseInt(rs.getString("weightage"));
					result_str[0]=rs.getString("category_type");// AS/EX
					result_str[1]=rs.getString("item_id");		//WA/HW
					result_str[2]=rs.getString("item_des");		//Home work cat_name
					result_str[3]=max_marks;					//max marks
					result_str[4]=sec_marks;					//secured marks
					result_str[5]=rs.getString("weightage");	//weightage
					result_str[6]=""+wt+"";//.toString();		//weightage Marks		
					result_str[7]=trimFloat(percent);
					result.add(result_str);
				}
					float percent=total_Points*100/total_waitages;
					result.add(""+getGrade(percent,schoolid,courseId)+"");
					//result.add(total_waitages);
					
						
		}catch(Exception e){
			System.out.println("Exception in ReportsBean.java in getMarkingDates "+e);
		}
		return result;

	}  // END OF getCountByACategoryType
}

