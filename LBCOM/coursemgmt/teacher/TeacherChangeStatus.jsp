<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<head>
</head>
<BODY>
<%
    Connection con=null;
	Statement st=null;
	String workFile="",workId="",studentId="",categoryId="",schoolId="",dropboxTable="",classId="",courseId="";
	int i=0,count=0;

%>
<%
   
   try
   {	

       session=request.getSession();
	   String sessid=(String)session.getAttribute("sessid");
	   if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	   }
   	   schoolId=(String)session.getAttribute("schoolid");
	   classId=(String)session.getAttribute("classid");
	   courseId=(String)session.getAttribute("courseid");
	   studentId=request.getParameter("studentid");
       categoryId=request.getParameter("cat");
	   count =Integer.parseInt(request.getParameter("count"));	   
       
	   dropboxTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";

	   con=con1.getConnection();	  
	   st=con.createStatement();

	  
	   workFile=request.getParameter("workfile");
   	   workId=request.getParameter("workid");
	   	 
	   i=st.executeUpdate("update "+dropboxTable+" set status=3 where work_id='"+workId+"' and student_id='"+studentId+"' and submit_count="+count);

  }
  catch(Exception e)
  {
	  ExceptionsFile.postException("TeacherChangeStatus.jsp","Operations on database and reading parameters","Exception",e.getMessage());
	  System.out.println("The error is: "+e);
  }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("TeacherChangeStatus.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
<script>

window.location.href="<%=workFile%>";

</script>

</BODY>
</HTML>
