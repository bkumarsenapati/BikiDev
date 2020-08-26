<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",mode="",query="",classid="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
mode=request.getParameter("mode");
classid=request.getParameter("classid");
schoolId=(String)session.getAttribute("schoolid");
%>
<%try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement();
	if(classid==null)
		classid="All";
	if(mode==null)
		mode="none";
%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<script language="javascript">
var mode="<%=mode%>";
var classid="<%=classid%>";
function goReport(mode1)
{
	mode=mode1;
	parent.sec.location="onlineusers.jsp?mode="+mode1+"&classid="+classid+"";
}
function goclass(classid1)
{
	classid=classid1;
	window.location="online.jsp?mode="+mode+"&classid="+classid1+"";
	if(mode!="none")
		parent.sec.location="onlineusers.jsp?mode="+mode+"&classid="+classid1+"";
	
}
</script>
</HEAD>
<BODY  topmargin=4 leftmargin=4>
<form method="POST" action="">
	<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr>
		<td width="110">
		<INPUT TYPE="button" value="Online Students" style="border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px" onclick="goReport('student')">
		</td ><td width="10"></td>
		<td width="110" valign="top">
		<INPUT TYPE="button" value="Online Teachers" style="border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px" onclick="goReport('teacher')"></td>
		<td width="10"></td>
		<td width="100" valign="middle">&nbsp;&nbsp;Select&nbsp;Class</td>
		<td width="100" valign="top">		
		<select name="class" size="1" id="class" onchange="goclass(this.value)">
		<option selected value="All">-----ALL-----</option>
		<%
		query="select class_id,class_des from class_master where school_id='"+schoolId+"'";
		rs=st.executeQuery(query);
		while(rs.next()){
		%>
			<option value="<%=rs.getString("class_id")%>"><%=rs.getString("class_des")%></option>

		<%}%>			
		</select>		
		</td>
		
		<td></td>
	</tr>
	</table>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
document.getElementById("class").value="<%=classid%>";
//-->
</SCRIPT>
</BODY>
</HTML>
<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/byclass.jsp"+e);
}finally{
		try
			{	if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception ex){
				ExceptionsFile.postException("Reports/Byclass.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
				
			}
}%>