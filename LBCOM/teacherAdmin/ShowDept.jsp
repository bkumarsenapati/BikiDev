<%@page language="java" import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String userName="",schoolId="",dirName="";
boolean flag=false;
%>
<%
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}

userName=request.getParameter("emailid");
schoolId=request.getParameter("schoolid");
try{
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"'");
%>
<html>
<head>
<title></title>
<style>
<!--
a{text-decoration:none}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
function showFile(dir){
	parent.two.location.href="ShowDeptFiles.jsp?dirname="+dir;
	return false;
}
//-->
</SCRIPT>
</head>
<body>
<center>
<TABLE width="100%" border="0" cellspacing="2" cellpadding="0">
<%
	if(rs.next()){
		out.println("<TR><TD colspan='2'><font face='arial' size='2'><b><u>Notice Boards</u></TD></TR>");
		rs.beforeFirst();
	}
	else
		out.println("<TR><TD colspan='2'><font face='arial' size='2' color='maroon'><b>No Notice Boards Available</TD></TR>");
%>

<TR>
	<TD colspan="2">&nbsp;</TD>
</TR>
<%
	while(rs.next()){
		dirName=rs.getString("nboard_name");
		flag=true;
%>
<TR>
	<TD width="10%">&nbsp;</TD>
	<TD width="90%"><a href="javascript://" onclick="return showFile('<%=dirName%>');"><font face="arial" size="2"><b><%=dirName%></a></TD>
</TR>
<%
	}
	if(flag==false)
		out.println("<tr><td colspan='2' align='center'><font face='Arial' size='2'>No Departments Available</td></tr>");
}
catch(Exception e){
	ExceptionsFile.postException("ShowDept.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowDept.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }

%>
</TABLE>
</body>
</html>
