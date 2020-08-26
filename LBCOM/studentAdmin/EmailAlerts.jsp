<%@page language="java" %>
<%@page import="java.sql.*,java.io.*,java.util.Date,java.util.*,java.text.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
	String studentId="", schoolId="",emailId="";
	int newMail=0;
%>
<%

try
{
					studentId = (String)session.getAttribute("emailid");
					schoolId = (String)session.getAttribute("schoolid");
					emailId = studentId + "@" + schoolId;
					//System.out.println("san");
					con=con1.getConnection();
					st=con.createStatement();
					rs = st.executeQuery("select count(*) newmail from mail_box where user_id='"+emailId+"' and folder='Inbox' and mark_read='0'");
					if(rs.next())
					{
						newMail = rs.getInt("newmail");
					}
					rs.close();
					st.close();
%>
					<!-- <script>
						$(document).ready(function(){
						noty({layout : 'bottomRight', theme : 'noty_theme_default', type : 'alert', text: 'Hello Santhosh, you have <%=newMail%> new email!', timeout : true });
  
});
  </script> -->
<%
	if(newMail==0)
	{
%>
		EMAIL
<%
	}
else
	{
	%>
		EMAIL (<font color="red"><%=newMail%> </font>New)
		<!-- <script>
						$(document).ready(function(){
						noty({layout : 'bottomRight', theme : 'noty_theme_default', type : 'alert', text: 'Hello Santhosh, you have <%=newMail%> new email!', timeout : false });
  
});
  </script> -->
	<%
		
	}
		  
}
	  catch(Exception e){
		ExceptionsFile.postException("Event.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			
			if(st!=null)
			st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("Event.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
	%>

