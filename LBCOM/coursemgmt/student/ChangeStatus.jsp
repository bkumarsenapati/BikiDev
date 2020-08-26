<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page errorPage="/ErrorPage.jsp" %>

<head>
</head>
<BODY>
<%
    Connection con=null;
	Statement st=null;
	String studentId="",workId="",categoryId="",workFile="",schoolId="",courseId="",classId="";
	int i=0;

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
	   studentId=(String)session.getAttribute("emailid");
	   courseId  = (String)session.getAttribute("courseid");
       classId  = (String)session.getAttribute("classid");
	   schoolId  = (String)session.getAttribute("schoolid");
	   con=con1.getConnection();
	   st=con.createStatement();	  
	   workFile=request.getParameter("workfile");
	   workId=request.getParameter("workid");
	   categoryId=request.getParameter("categoryid in cmgmt/student/change status.jsp");	 

	   i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status='1' where student_id='"+studentId+"' and work_id='"+workId+"'");
	   if (i==0)
            	System.out.println("The record is not updated");
  }catch(SQLException se){
	    ExceptionsFile.postException("ChangeStatus.jsp","Operations on database","SQLException",se.getMessage());
	
  }catch(Exception e){
		    ExceptionsFile.postException("ChangeStatus.jsp","Operations on database","Exception",e.getMessage());
			System.out.println("Error:  -" + e.getMessage());

		}

	finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(SQLException se){
				ExceptionsFile.postException("ChangeStatus.jsp","closing statement objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		  }

%>

<script>
parent.second.location.href='<%=workFile%>';
</script>

</BODY>
</HTML>
