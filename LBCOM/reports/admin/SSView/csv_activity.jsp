<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %><%@ include file="/common/checksession.jsp"%><%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/><jsp:useBean id="common" class="common.CommonBean" scope="page"/><jsp:useBean id="db" class="sqlbean.DbBean" scope="page"><jsp:setProperty name="db" property="*"/></jsp:useBean><%
response.setContentType("text/csv");
response.setHeader("Content-Disposition","filename=\"Activity.csv\"");
ArrayList actlist = new ArrayList();
String[][] marksarray=null;
ResultSet  rs=null,rs0=null,rs1=null,rs2=null;
Connection con=null;
Statement st=null,st1=null,st2=null;
String schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="",teacherId="",linkStr="";
int start=0,end=0,currentPage=0,status=0,no_students=0,pageSize=10,no_activity=0;
if(request.getParameter("start")!=null)start=Integer.parseInt(request.getParameter("start"));
if(request.getParameter("nrec")!=null)pageSize=Integer.parseInt(request.getParameter("nrec"));
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
	String workdocsTbl=schoolId+"_"+classId+"_"+courseid+"_workdocs";	
	Hashtable works=null,worksType=null;
	works=new Hashtable();
	Enumeration workids=null,studentids=null,enum=null;
	String workId="";
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
	rs=st.executeQuery("select * from "+schoolId+"_activities where  course_id='"+courseid+"' order by Activity_name" );
	while(rs.next()){
		actlist.add(rs.getString("Activity_name"));					
	}
	if(actlist.size()==0){
		out.println("No Assessments Available");
		return;
	}else{
			no_activity=actlist.size();
	}
	rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname LIMIT "+start+","+pageSize+"");
	if(!rs1.next()){
		out.println("No Assessments Available");
		return;
	}else{
		marksarray=new String[actlist.size()+5][end];
		String studentid="",sschoolid="",fname="",lname="",temp_str="";
		int no_st=0,no_act=0;
		do{						
			studentid=rs1.getString("student_id");
			sschoolid=rs1.getString("schoolid");
			fname=rs1.getString("fname");
			lname=rs1.getString("lname");
			marksarray[0][no_st]=studentid;
			marksarray[1][no_st]=fname;
			marksarray[2][no_st]=lname;
			marksarray[3][no_st]=sschoolid;
			temp_str="\"&nbsp;"+lname+"&nbsp;"+fname+"\",\""+studentid+"\"";			
			String qu="select act.activity_id as activity_id,IFNULL(ces.marks_secured,\"-UA-\") as marks_secured from (select activity_id from "+sschoolid+"_activities where course_id='"+courseid+"' order by Activity_name)as act LEFT OUTER JOIN (select cescores.school_id as school_id,cescores.user_id as user_id ,cescores.course_id as uourse_id,cescores.category_id as category_id,cescores.work_id as work_id,cescores.submit_date as submit_date,CASE when category_item_master.grading_system=0 then \"-NG-\" WHEN cescores.report_status=\"1\" and cescores.status=0  THEN \"-NA-\" WHEN cescores.report_status=\"1\" and cescores.status=2  THEN cescores.marks_secured WHEN cescores.report_status=\"1\" and cescores.status=1  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.report_status=\"1\" and cescores.status=3  THEN '*' WHEN cescores.report_status=\"0\" THEN \"-UA-\" END AS marks_secured,cescores.total_marks as total_marks,cescores.status as status,cescores.report_status as report_status from "+sschoolid+"_cescores as cescores,category_item_master where cescores.school_id='"+sschoolid+"' and cescores.user_id='"+studentid+"' and cescores.course_id='"+courseid+"' and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id ) as ces on  act.activity_id=ces.work_id";
			rs2=st2.executeQuery(qu);	
			while(rs2.next()){
				marksarray[no_act+4][no_st]=rs2.getString("marks_secured");
				no_act++;
			}
			no_act=0;
			no_st++;							
		}while(rs1.next());					
	}	
	String tmp="Title,";
	for(int i=0;i<end-start;i++){
		tmp=tmp+marksarray[2][i]+",";	
	}
	tmp=tmp+"\n";
	for(int i=0;i<no_activity;i++){
		tmp=tmp+actlist.get(i)+",";
		for(int j=0;j<end-start;j++){
			tmp=tmp+marksarray[i+4][j]+",";
		}tmp=tmp+"\n";
	}
	out.print(tmp);
}catch(Exception e){
	System.out.println("Exception in reports/teacher/ssview/Print_Body.jsp"+e);
}finally{
	try{	
		if(st!=null)
			st.close();
		if(st1!=null)
			st.close();
		if(st2!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/teacher/ssview/Print_Body.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}
%>