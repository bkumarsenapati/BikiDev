package exam;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import java.util.ArrayList;
public class  CourseUtility
{
	public ArrayList asmtIds;
	public ArrayList asmtCrtDates;
	public ArrayList asmtTypes;
	public Connection con;
	public void setDBCon(Connection con){
		this.con=con;
	}
	public int setAsmtIds(String schoolId,String courseId,String[] examIds, int status){
		Statement st=null;
		ResultSet rs=null;
		int count=0;
		asmtIds=new ArrayList();
		asmtCrtDates=new ArrayList();
		asmtTypes=new ArrayList();
		String selAsmtIds="";
		try{
			st=con.createStatement();
			if(examIds!=null){
				for(int j=0;j<examIds.length;j++){
					if(selAsmtIds.equals(""))
						selAsmtIds="'"+examIds[j]+"'";
					else
						selAsmtIds=selAsmtIds+",'"+examIds[j]+"'";
				} 
				rs=st.executeQuery("select exam_id,exam_type,create_date from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and status!="+status+" and exam_id in ("+selAsmtIds+")");
			}else{
				rs=st.executeQuery("select exam_id,exam_type,create_date from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and status!="+status);
			}
			while(rs.next()){
				asmtIds.add(count,rs.getString("exam_id"));
				asmtCrtDates.add(count,rs.getString("create_date"));
				asmtTypes.add(count,rs.getString("exam_type"));
				count=count+1;
			}
			rs.close();
			st.close();		
		}catch(SQLException se){
			System.out.println("CourseUtility.setAsmtIds("+se.getMessage());
		}
		return count;
	}
	public void	setAsmtIds(ArrayList asmtIds){
		this.asmtIds=asmtIds;
	}
	public void asmtBdleMakeAvailabe(String schoolId,String teacherId,String courseId,String fromDate,String toDate,String fromTime,String toTime,int grading ,int maxAttempts){
		String examId,examType;
		float examTotal=0.0f; 
		String examInstTbl="",dbString;
		Statement st=null;
		ResultSet rs=null;
		boolean flag=false,act=false;
		try
		{
			st=con.createStatement();
			Statement st1=con.createStatement();
			ResultSet rs1=null;
			for(int i=0;i<asmtIds.size();i++){
				examId=asmtIds.get(i).toString();
				examType=asmtTypes.get(i).toString();
				examInstTbl=schoolId+"_"+examId+"_"+asmtCrtDates.get(i).toString().replace('-','_');
				CalTotalMarks calc=new CalTotalMarks();
				examTotal=calc.calculate(examId,schoolId);
				rs=st.executeQuery("select activity_id from "+schoolId+"_activities where course_id='"+courseId+"' and activity_id='"+examId+"'");				
				if(rs.next()){
					act=true;
				}else{
					act=false;
				}
				rs.close();
				st.clearBatch();
				dbString="update exam_tbl set password=0,from_date='"+fromDate+"',to_date='"+toDate+"',from_time='"+fromTime+"',to_time='"+toTime+"',mul_attempts="+maxAttempts+",grading="+grading+",status=1 where exam_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);				
				if(act==false){
					dbString="insert into "+schoolId+"_activities (SELECT exam_id,exam_name,'EX' as exam_type,'QZ' as exam_sub_type,course_id,from_date,to_date FROM exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"')";
					st.addBatch(dbString);
				}else{
					dbString="update "+schoolId+"_activities set s_date='"+fromDate+"',t_date='"+toDate+"' where activity_id='"+examId+"'" ;
					st.addBatch(dbString);				
				}
				// Individual dates start here
					dbString="update "+schoolId+"_"+rs.getString("student_id")+" set start_date='"+fromDate+"',end_date='"+toDate+"' where exam_id='"+examId+"'";
					st.addBatch(dbString);
					// Upto here
				rs=st.executeQuery("select * from coursewareinfo_det as cd inner join "+examInstTbl+" as eInst on cd.student_id=eInst.student_id where school_id='"+schoolId+"' and course_id='"+courseId+"'");
				while(rs.next()){
					if(maxAttempts==-1)
						st.addBatch("update "+schoolId+"_"+rs.getString("student_id")+" set max_attempts="+maxAttempts+" where exam_id='"+examId+"'");
					else
						st.addBatch("update "+schoolId+"_"+rs.getString("student_id")+" set max_attempts="+maxAttempts+" where exam_id='"+examId+"' and count<="+maxAttempts);					
					
					
					rs1=st1.executeQuery("select work_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and course_id='"+courseId+"' and work_id='"+examId+"' and user_id='"+rs.getString("student_id")+"'");				
					if(!rs1.next()){
						st.addBatch("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+rs.getString("student_id")+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,1)");
					}
					rs1.close();
				}
				rs.close();
				dbString="update "+schoolId+"_cescores set report_status=1 where work_id='"+examId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and report_status!=2" ;
				st.addBatch(dbString);	
				st.executeBatch();
			}
		}catch(SQLException se){
			System.out.println("CourseUtility.asmtBdleMakeAvailabe()"+se.getMessage());
		}		
	}// end of AsmtBdleMakeAvailabe
	public void asmtBdleMakeUnAvailabe(String schoolId,String courseId){
		String examId;
		String dbString;
		Statement st=null;
		ResultSet rs=null;
		try
		{
			st=con.createStatement();
			st.clearBatch();
			for(int i=0;i<asmtIds.size();i++){
				examId=asmtIds.get(i).toString();			
				dbString="update exam_tbl set status=0 where exam_id='"+examId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"'" ;
				st.addBatch(dbString);				
				dbString="update "+schoolId+"_cescores set report_status=0 where work_id='"+examId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and report_status!=2 " ;
				st.addBatch(dbString);
			}
			st.executeBatch();
		}catch(SQLException se){
			System.out.println("CourseUtility.asmtBdleMakeAvailabe()"+se.getMessage());
		}
	}// end of AsmtBdleMakeAvailabe
}
