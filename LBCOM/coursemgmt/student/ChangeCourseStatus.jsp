<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page errorPage="/ErrorPage.jsp" %>
<%

  Connection con=null;
  Statement st=null;
  String schoolId="",studentId="",workId="",path="",courseName="",categoryId="",docName="",teacherId="";



%>
<%
	try{
		session=request.getSession();
	    String sessid=(String)session.getAttribute("sessid");
		
	    if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}	     
		schoolId  = (String)session.getAttribute("schoolid");
		studentId = (String)session.getAttribute("emailid");		
		workId=request.getParameter("workid");
		courseName=request.getParameter("coursename");
		categoryId=request.getParameter("cat");
		teacherId=request.getParameter("teacherid");
		docName=request.getParameter("docname");
		con=con1.getConnection();
		st=con.createStatement();		
		int i=st.executeUpdate("update course_docs_dropbox set status= 1 where student_id='"+studentId+"' and status= 0 and work_id= any(select work_id from course_docs where school_id='"+schoolId+"' and work_id='"+workId+"')" );

		if (i==0) 
			System.out.println("The status  updation is failed in cmgmt/student/changecoursestatus.jsp");
 }catch(Exception e){
	ExceptionsFile.postException("ChangeCourseStatus.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
	System.out.println("Exception raised "+e);
 }finally{
	try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("ShowHistory.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}

}

%>



<html>
<head>
<script language="javascript">
parent.contents.location.href="ViewMaterial.jsp?workid=<%=workId%>&teacherid=<%=teacherId%>&docname=<%=docName%>&coursename=<%=courseName%>&cat=<%=categoryId%>";

</script>
</head>
<body>
</body>
</html>