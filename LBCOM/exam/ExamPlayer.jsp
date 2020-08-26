<!-- creats two frames -->
<%@ page import="java.io.*,java.sql.*,java.util.*,exam.CalTotalMarks,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<% 
	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	CalTotalMarks calc=null;

	String schoolId="",courseId="",teacherId="",exmInsTbl="",examId="",studentId="",vsn="",stuPassword="";
	String exmFPath="",tFrPath="",mFrPath="",bFrPath="",pswrd="",examPassword="",examType="",quesList="";
	String subNo="",subAllowed="",chances="";
	
	float examTotal=0.0f,marks=0.0f;

	int markScheme=0;
%>

<%
	response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
	
	session=request.getSession(true);

	String s=(String)session.getValue("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/HSNRT/NoSession.html'; \n </script></html>");
			return;
	}
	String schoolpath=(String)session.getValue("schoolpath");
	String reassign="";
	String start="";
	String totRecords="";
	
	try{
	schoolId=(String)session.getValue("schoolid");
	courseId=(String)session.getValue("courseid");
	studentId=(String)session.getValue("emailid");

	teacherId=request.getParameter("teacherid");
	examId=request.getParameter("examid");
	exmInsTbl=request.getParameter("tblname");
	examPassword=request.getParameter("exampassword");
	examType=request.getParameter("examtype");
	start=request.getParameter("start");
	totRecords=request.getParameter("totrecords");

//	subNo=request.getParameter("subno");
//	subAllowed=request.getParameter("suballowed");
	chances=request.getParameter("chances");
	
	markScheme=Integer.parseInt(request.getParameter("markscheme"));
	reassign=request.getParameter("reassign");
	if(reassign==null)
		reassign="false";
	con=con1.getConnection();
	st=con.createStatement();
	
	calc= new CalTotalMarks();
	
	examTotal=calc.calculate(examId,schoolId);
	
	rs=st.executeQuery("Select ques_list,version,password from "+exmInsTbl+" where student_id='"+studentId+"' and (count=0 or count=1)");
	
	if (rs.next()){
		
		quesList=rs.getString("ques_list");
		vsn=rs.getString("version").trim();
        pswrd=rs.getString("password").trim();
	}
	
	if(examPassword.equals("1")){

		stuPassword=request.getParameter("password").trim();
		if(!stuPassword.equalsIgnoreCase(pswrd)){
			if(reassign.equals("false")){
				out.println("<script> parent.window.opener.location.href='ExamPassword.jsp?examtype="+examType+"&status=1&examid="+examId+"&tblname="+exmInsTbl+"&teacherid="+teacherId+"&exampassword="+examPassword+"&markscheme="+markScheme+"&durationinsecs="+request.getParameter("durationinsecs")+"';window.close();</script>");
			}else if(reassign.equals("true")){
				out.println("<script>document.location.href='ExamPassword.jsp?examtype="+examType+"&status=1&examid="+examId+"&tblname="+exmInsTbl+"&teacherid="+teacherId+"&exampassword="+examPassword+"&markscheme="+markScheme+"&durationinsecs="+request.getParameter("durationinsecs")+"&reassign=true';</script>");

			}
			return;
		}
	}
    int no=0;
	/*float totalMarks=0;
	StringTokenizer stk,stk1;
	stk=new StringTokenizer(quesList,"#");
	while(stk.hasMoreTokens()){
		stk1=new StringTokenizer(stk.nextToken(),":");
		if(stk1.hasMoreTokens()){
			stk1.nextToken();
			totalMarks+=Float.parseFloat(stk1.nextToken());
		}
	}*/
	
	rs=st.executeQuery("select max(count) from "+exmInsTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
	if (rs.next()) {
		no=rs.getInt(1);	
	}
	
    if(no==0){
		st.executeUpdate("update "+exmInsTbl+" set count=1,status='3',submit_date=curdate(),marks_secured=0 where exam_id='"+examId+"' and student_id='"+studentId+"'");
	 }else{
		st.executeUpdate("insert into "+exmInsTbl+" (exam_id,student_id,ques_list,count,status,version,submit_date,marks_secured) values('"+examId+"','"+studentId+"','"+quesList+"',"+(no+1)+",'3',"+vsn+",curdate(),0)");	
	 }
	 /**
	     This code is newly written to add a new table for each student and insert the details fo the exam in the table
	**/
	String tableName=schoolId+"_"+studentId;
	st.executeUpdate("update "+tableName+" set exam_status=1,count="+(no+1)+" where exam_id='"+examId+"'");
	//End of New Code
     if(!examType.equalsIgnoreCase("ST")){
		
		if (markScheme==0){
			rs=st.executeQuery("select max(marks_secured) marks from "+exmInsTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
		}else if(markScheme==1){
			rs=st.executeQuery("select marks_secured marks from "+exmInsTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"' order by count desc");
		}else{
			rs=st.executeQuery("select avg(marks_secured) marks from "+exmInsTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
		}
		if(rs.next()) {
			marks=rs.getFloat("marks");
			
		}
		
		st.executeUpdate("update "+schoolId+"_cescores set marks_secured='"+marks+"',total_marks='"+examTotal+"',submit_date=curdate(),status=CASE WHEN status=1 || status=3 THEN 1 ELSE 2 END where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'");
	}

	exmFPath=schoolpath+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
	tFrPath=exmFPath+"/top.html?1";
	mFrPath=exmFPath+"/"+vsn+".html?1";
	bFrPath=exmFPath+"/bottom.html?1";
	if((request.getParameter("durationinsecs")!=null)&&(!request.getParameter("durationinsecs").equals("")))
		{
			int durationInSecs=Integer.parseInt(request.getParameter("durationinsecs"));
			if(durationInSecs==0)
				session .setMaxInactiveInterval(3*60*60);
			if(durationInSecs>30*60)
				session.setMaxInactiveInterval(durationInSecs+300);
		}
		else
		{
			session.setMaxInactiveInterval(3*60*60);
		}
		
	}catch(Exception e){
		ExceptionsFile.postException("ExamPlayer.jsp","operations on database","Exception",e.getMessage());
   	 }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ExamPlayer.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

	//puts the values of classid,coursename,courseid in the session
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
<title><%=application.getInitParameter("title")%></title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'>
<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>

<SCRIPT LANGUAGE="JavaScript">
 <!--
 var versn='<%=vsn%>';
 var chances='<%=chances%>';
 var subAllowed='<%=subAllowed%>';



 //-->
 </SCRIPT>
</HEAD>
<!--<script>window.opener.location.href="StudentExamsList.jsp?examtype=<%=examType%>&start=<%=start%>&totrecords=<%=totRecords%>"</script>-->
<%if (reassign.equals("false")){%>
<FRAMESET ROWS="20%,70%,*" BORDER=0>
	<FRAME NAME='top_f' src="<%=tFrPath %>" scrolling=no>
	<FRAME NAME='mid_f' src="<%=mFrPath %>">
	<FRAME NAME='btm_f' src="<%=bFrPath %>" scrolling=no>
</FRAMESET>
<noframes>
<body topmargin="0" leftmargin="0">

<p>This page uses frames, but your browser doesn't support them.</p>

</body>
</noframes>
<%}else if(reassign.equals("true")){%>
	<script>parent.btm_f.location.href='<%=bFrPath%>';</script>
<%}%>

</html>
