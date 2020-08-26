<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",mode="",query="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
mode=request.getParameter("mode");
schoolId=(String)session.getAttribute("schoolid");
%>
<%try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement();
%>
<html>
<head>
<title></title>
<script>
var x=null;
function details(mode,user_id,schoolId)
{
 x=window.open ('/LBCOM/reports/UserDetails.jsp?schoolid='+schoolId+'&userid='+user_id+'&mode='+mode+'','mywindow','width=600,height=300');
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
			query="select user_id,DATE_FORMAT(call_time,'%h:%i:%p ') call_time1 from session_details sd,teachprofile tp where sd.user_id=tp.email and sd.school_id=tp.schoolid and sd.school_id='"+schoolId+"'";
			// sd, where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+classId+"'"";
		}else{
			query="select *, DATE_FORMAT(sd.call_time,'%h:%i:%p ') call_time1 from session_details sd,studentprofile sp where sd.user_id=sp.username and sd.school_id=sp.schoolid and sd.school_id='"+schoolId+"'";
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
				<td width="700" bgcolor="#EEE0A1">
				<b><font face="Verdana" size="2">&nbsp;&nbsp;&nbsp;User&nbsp;ID</font></b></td>
				<td width="156" bgcolor="#EEE0A1">
				<p > <b> <font face="Verdana"size="2">&nbsp;Login&nbsp;Time</font></b></td>
			</tr>
			<%do{%>	
			<tr>
				<td width=700 align="center">&nbsp;&nbsp;
				<a href="javascript:details('<%=mode%>','<%=rs.getString("user_id")%>','<%=schoolId%>');"><p align="left"> &nbsp;<%=rs.getString("user_id")%></a>
				</td>
				<td ><font size="2" face="Verdana">&nbsp;<%=rs.getString("call_time1")%></font></td>
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