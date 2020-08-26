<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",mode="",query="",classid="",subquery="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
mode=request.getParameter("mode");
classid=request.getParameter("classid");
schoolId=(String)session.getAttribute("schoolid");

if(!classid.equals("All"))
	if(mode.equals("teacher"))
		subquery=" and p.class_id='"+classid+"'";
	else
		subquery=" and p.grade='"+classid+"'";
		
%>
<%try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement();
%>
<html>
<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<script>
var x=null;
function details(mode,user_id,schoolId)
{
 x=window.open ('/LBCOM/reports/UserDetails.jsp?schoolid='+schoolId+'&userid='+user_id+'&mode='+mode+'','mywindow','width=600,height=200');
 x.focus();
}
function closepopup(){
	if(x!=null)
	if(window.x.closed!=true){
		x.close();
	}
}
</script>
</head>
<body onunload=closepopup();>
	<BR>
	<table border="1" cellspacing="0" width="100%" id="AutoNumber1" bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
	<%
		if(mode.equals("teacher")){
			query="select user_id,DATE_FORMAT(call_time,'%h:%i:%p ') call_time1,p.firstname as fname,p.lastname as lname from session_details sd,teachprofile p where sd.user_id=p.email and sd.school_id=p.schoolid and sd.school_id='"+schoolId+"' "+subquery+"";
		}else{
			query="select *, DATE_FORMAT(sd.call_time,'%h:%i:%p ') call_time1,p.fname as fname,p.lname as lname from session_details sd,studentprofile p where sd.user_id=p.username and sd.school_id=p.schoolid and sd.school_id='"+schoolId+"'"+subquery+"";
		}
		rs=st.executeQuery(query);
		if(!rs.next()){%>	
		<tr>
			<td  height="10%" align="center" colspan='3'>
			<p align="left"><font face="Verdana" size="2" color=red>There are no <%=mode%>s online now</font>
			</td>
		</tr>
		<%}else{%>	
			<tr>
				<td width="200" bgcolor="#EEE0A1">
				<b><font face="Verdana" size="2">&nbsp;&nbsp;User&nbsp;ID</font></b></td>
				<td width="200" bgcolor="#EEE0A1">
				<p > <b> <font face="Verdana"size="2">&nbsp;First&nbsp;name</font></b></td>
				<td width="200" bgcolor="#EEE0A1">
				<b><font face="Verdana" size="2">&nbsp;Last&nbsp;Name</font></b></td>
				<td width="156" bgcolor="#EEE0A1">
				<p > <b> <font face="Verdana"size="2">&nbsp;Login&nbsp;Time</font></b></td>
			</tr>
			<%do{%>	
			<tr>
				<td width=200 align="left">&nbsp;
				<a href="javascript:details('<%=mode%>','<%=rs.getString("user_id")%>','<%=schoolId%>');"><%=rs.getString("user_id")%></a>
				</td>
				<td width=200 align="left">&nbsp;<%=rs.getString("fname")%>
				</td>
				<td width=200 align="left">&nbsp;<%=rs.getString("lname")%>
				</td>
				<td >&nbsp;<font size="2" face="Verdana"><%=rs.getString("call_time1")%></font></td>
			</tr>
			<%}while (rs.next());  //END of WHILE LOOP
		
		}%>		
		</table>
</body>
</html>
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