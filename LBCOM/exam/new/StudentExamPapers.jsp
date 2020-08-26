<%@ page language="Java" import="java.sql.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	String examId=null;
	String studentId=null;
	String schoolId=null;
	String teacherId=null;
	String courseId=null;
	String stuTblName="";

	Connection con=null;
	Statement st=null;
	ResultSet rs=null;


	int version=0;
	int attempts=0;
	

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try{

	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");
	examId=request.getParameter("examid");
	studentId=request.getParameter("studentid");
	version=Integer.parseInt(request.getParameter("version"));
	attempts=Integer.parseInt(request.getParameter("attempts"));

	stuTblName=request.getParameter("stuTblName");




	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select count,status from "+stuTblName+" where student_id='"+studentId+"' order by count");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
   function showFile(attempt){
		var filePath="<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/"+fname;
		parent.mid_f.location.href=filePath;		
		parent.top_f.location.href="<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/top.html";
		parent.btm_f.location.href="<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/responses/<%=studentId%>/"+attempt+"/"+attempt+".html";
		return false;
	}
//-->
</SCRIPT>
</HEAD>

<BODY>
	<%
		out.println("<table width=\"84\" height=\"19\"><tr><td width=\"78\" bgcolor=\"#C2CCE0\" height=\"20\"><p align=\"center\"><b><font face=\"Arial\" size=\"2\">Attempts</font></b></td></tr>");

		
		/*for(int i=attempts;i>0;i--){
			out.println("<tr><td width='78' height='19'><p align='center'><b><a href='javascript://' onclick=\" return showFile('"+i+"');\"><font color='#800000'>"+i+"</font></a><b></td></tr>");
		}*/

		int status=0,count=0;
		String bgColor="";
		
		while(rs.next()){
			count=rs.getInt("count");
			status=rs.getInt("status");

			if(status==3)
				bgColor="#F3F3F3";
			else if(status==2)
				bgColor="#EAFFEA";
			else
				bgColor="#FFDDDD";

			out.println("<tr><td width='78' height='19' bgColor='"+bgColor+"'><p align='center'><b><a href='javascript://' onclick=\" return showFile('"+count+"');\"><font color='#800000'>"+count+"</font></a><b></td></tr>");
		}
		
		
		
		if(attempts>=1){
			out.println("<script language='javascript'> \n showFile(\'"+attempts+"\'); \n </script>");
		}
	%>
</BODY>
</HTML>
<%
}catch(SQLException se){
		System.out.println("SQLException in ShowSubmittedFiles.jsp is "+se);
	}catch(Exception e){
		System.out.println("Exception in ShowSubmittedFiles.jsp is "+e);

	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			System.out.println("SQLException in ShowSubmittedFiles.jsp while closing the connection is "+se);
		}
	}

%>
