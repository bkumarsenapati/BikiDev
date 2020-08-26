<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%><jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/><jsp:useBean id="common" class="common.CommonBean" scope="page" /><jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" /><%@ include file="/common/checksession.jsp"%><%
Connection con=null;
Statement st=null,st1=null;
ResultSet  rs=null,rs1=null;
response.setContentType("text/csv");
response.setHeader("Content-Disposition","filename=\"StudentSummary.csv\"");
try{
	String marking_id=request.getParameter("m_id");
	String courseId=request.getParameter("courseid");
	String courseName=request.getParameter("courseName");
	String act=request.getParameter("act");
	String user_id=request.getParameter("user");
	String act_schoolid=(String)session.getAttribute("schoolid");
	String schoolid=request.getParameter("schoolid");
	String classId=request.getParameter("classid");
	String classname=(String)session.getAttribute("classname");
	String query=null,ex="0",as="0",tmpusr="";
	String sel_na=request.getParameter("na");    //based on attempted
	String sel_showall=request.getParameter("showall");    //based on attempted
	boolean na=true,showall=true;
	float total_Points=0.0f,total_waitages=0.0f,percent=0.0f;
	con=con1.getConnection();	
	st=con.createStatement();
	st1=con.createStatement();
	report.setConnection(con);  // This function will send connection to the reports bean	
	if(sel_na==null||sel_na.equals("false"))
		na=false;
	if(sel_showall==null||sel_showall.equals("false"))
		showall=false;
	String tmp="";
	String[] dates=new String[2];
	dates=report.getMarkingDates(act_schoolid,marking_id,courseId);	 
	tmp="Student Name "+request.getParameter("lname")+" "+request.getParameter("fname")+",Student ID :"+user_id+",Course :"+courseName+"";
	if(showall==false){
		tmp=tmp+"From:"+common.convertoDisplayDate(dates[0])+",To :"+common.convertoDisplayDate(dates[1])+"\n\n";
	}else
		tmp=tmp+"\n\n";

	tmp=tmp+"Name,Last Attempted On,Points Possible,Secured Points,To Date\n";
	float pp=0.0f,sp=0.0f,percentage=0.0f;
	if(!schoolid.equals(act_schoolid))
		tmpusr=act_schoolid+"_"+user_id;
	else
		tmpusr=user_id;
	String nas="",pretest="category_item_master.grading_system!=0 and ";								
	if(na==false)				//if By attempt based
		nas="and ((act.t_date between '"+dates[0]+"' and '"+dates[1]+"')or(cescores.submit_date between '"+dates[0]+"' and '"+dates[1]+"'))";
	else
		nas="and act.t_date between '"+dates[0]+"' and '"+dates[1]+"'";
	if(showall==true){
		pretest="";
		nas="";
	}
	
	query="SELECT act.activity_id,act.Activity_name, CASE WHEN category_item_master.grading_system=0 then '#A9A9A9' else 'Black' end as grading_system,CASE WHEN cescores.category_id='EC' THEN 'Extra Credit' WHEN cescores.status='3' THEN 'Pending' else cescores.total_marks end as total_marks123,CASE WHEN DATE_FORMAT(cescores.submit_date,'%m/%d/%Y')= '00/00/0000'  THEN '---' WHEN cescores.status='1'  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.status='3'  THEN '*' ELSE cescores.marks_secured  END AS marks_secured,IF(DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')='00/00/0000' ,'Not Attempted',DATE_FORMAT(cescores.submit_date, '%m/%d/%Y')) as s_date,DATE_FORMAT(act.t_date, '%m/%d/%Y') as t_date  FROM "+schoolid+"_cescores as cescores,"+schoolid+"_activities act ,category_item_master WHERE cescores.work_id=act.activity_id and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id and "+pretest+"  cescores.course_id=act.course_id and cescores.user_id='"+tmpusr+"' and cescores.course_id='"+courseId+"' and cescores.report_status=1 and cescores.school_id='"+schoolid+"' "+nas+" order by category_item_master.grading_system,act.Activity_name";
	rs1=st1.executeQuery(query);			
	if(!rs1.next()){
		out.println("No Activity is available in this course");
		return;
	}else{
		do{	
			if(showall==false){
				try{
					pp=pp+Float.parseFloat(rs1.getString("total_marks123"));
				}catch(Exception e){}
				try{
					sp=sp+Float.parseFloat(rs1.getString("marks_secured").replace('*','\0'));	
				}catch(Exception e){}
			}
			tmp=tmp+rs1.getString("Activity_name")+","+rs1.getString("s_date")+","+rs1.getString("total_marks123")+","+rs1.getString("marks_secured")+","+rs1.getString("t_date")+"\n";	
		}while(rs1.next());
		if(showall==false){
			percentage=(sp/pp)*100;
		}
	}
	if(showall==false)		
		tmp=tmp+"\nSUM,"+","+pp+","+sp+","+report.trimFloat(percentage)+"\n";				
	out.println(tmp);
}catch(Exception e){
	System.out.println("Exception in ByActivity.jsp "+e);	
}
finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
				con.close();
			}
			catch(Exception ee){
				 ExceptionsFile.postException("reports/student/over_all.jsp","closing statement,resultset and connection objects","Exception",ee.getMessage());
			}
		}

%>