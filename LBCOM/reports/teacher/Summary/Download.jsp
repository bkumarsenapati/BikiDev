<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %><%@ include file="/common/checksession.jsp" %><%@ page errorPage="/ErrorPage.jsp" %><jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/><jsp:useBean id="common" class="common.CommonBean" scope="page" /><jsp:useBean id="db" class="sqlbean.DbBean" scope="page"><jsp:setProperty name="db" property="*"/></jsp:useBean><%
ResultSet  rs=null,rs0=null,rs1=null,rs2=null;
Connection con=null;
Statement st=null,st1=null,st2;
String schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="";
// for page 15
String teacherId="",linkStr="";
int start=0,end=0,currentPage=0,status=0,no_students=0,pageSize=15;
if(request.getParameter("start")!=null)start=Integer.parseInt(request.getParameter("start"));
if(request.getParameter("nrec")!=null)pageSize=Integer.parseInt(request.getParameter("nrec"));
response.setContentType("text/csv");
response.setHeader("Content-Disposition","filename=\"Summaryy.csv\"");
//for page 15
try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	st2=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	teacher_classId=(String)session.getAttribute("grade");
	classId=request.getParameter("classid");
	classdes=request.getParameter("classdes");
	courseid=request.getParameter("courseid");
	coursedes=request.getParameter("coursedes");
	String marking_id=request.getParameter("m_id");
	boolean wb=true,ba=true;
	String sel_wb=request.getParameter("wb");
	String sel_ba=request.getParameter("ba");
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
	String[] dates=new String[2];					
	dates=report.getMarkingDates(schoolId,marking_id,courseid);
	rs0=st1.executeQuery("select count(*) from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname ");
	rs0.next();
	no_students=rs0.getInt(1);	
	end=start+pageSize;
	if (end>no_students)
	   end=no_students;
	String tmp="";
	tmp=coursedes+",";
	tmp=tmp+""+",";
	tmp=tmp+"From"+",";
	tmp=tmp+common.convertoDisplayDate(dates[0])+",";
	tmp=tmp+"To"+",";
	tmp=tmp+common.convertoDisplayDate(dates[1])+"\n\n";
	tmp=tmp+"Student Name,Student ID,Assignments,Assessments,Points Possible,Points Secured,Percentage (%)\n";
	rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname LIMIT "+start+","+pageSize+"");
	if(!rs1.next()){
		tmp="No students";
	}else{
		Hashtable result = new Hashtable();
		String studentid="",sschoolid="",fname="",lname="";
		do{						
			studentid=rs1.getString("student_id");
			sschoolid=rs1.getString("schoolid");
			fname=rs1.getString("fname");
			lname=rs1.getString("lname");
			result=report.getActivityTypeGrade(courseid,classId,studentid,sschoolid,dates,wb,ba);	
			tmp=tmp+lname+" "+fname+","+studentid+","+result.get("as")+","+result.get("ex")+","+result.get("maxmarks")+","+result.get("marks_secred")+","+result.get("percent")+"\n";
		}while(rs1.next());
	}
	out.println(tmp);
}catch(Exception e){
	System.out.println("Exception in reports/teacher/Summary/Body.jsp"+e);
}finally{
	try{	
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/teacher/Summary/Body.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}%>
