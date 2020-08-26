<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@page language="java" import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String schoolId="",studentId="",nbId="",msg="";
int i=0;
%>
<%!

private String check4Opostrophe(String str){
	str=str.replaceAll("\'","\\\\\'");
	str=str.replaceAll("\"","\\&quot;");
	return(str);
}

%>

<%
try
{
		msg=request.getParameter("msg");
		nbId=request.getParameter("nbid");
		con=con1.getConnection();
		st=con.createStatement();
		studentId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");

		System.out.println("Top.jsp........studentId..."+studentId+"......schoolId.."+schoolId+"...nbid..."+nbId);

		// This is for all users
		//i=st.executeUpdate("insert into student_notice_boards values('"+nbId+"','"+schoolId+"','"+studentId+"')");

if((msg==null)||msg.equals(""))
	msg="No Message";
else
	msg="'"+check4Opostrophe(msg)+"'";

%>
<html><head>

</head><body>
<script language="javascript">
 
  var mes= <%=msg%>;
  if (mes==null){
        mes="No Message";
} if ((mes=="")||(mes=="null")){
        mes="No Message";
}
  document.write("<font face='Arial' size='2' color='blue'><b>Message</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- <a href='self.close ()'>Close this Window</a> --> ");
  document.write("<font face='Arial' size='2' >&nbsp;&nbsp;&nbsp;</font><br>");
  document.write("<font face='Arial' size='2' >"+mes+"</font><br>");
</script>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("Top.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}
finally
{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null)
			con.close();
			
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("Top.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}
%>
</body>
</html>
