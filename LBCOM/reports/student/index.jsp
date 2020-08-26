<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<%
	String bgclr="#E1DED5";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv='Pragma' content='no-cache'>
<title></title>
<script language="javascript">
function goReport()
{
	var mp=document.getElementById("mp");
	var report=document.getElementById("report");
	if((mp.selectedIndex!=0)&&(report.selectedIndex!=0)){
		parent.sec.location=""+report.options[report.selectedIndex].value+"?m_id="+mp.options[mp.selectedIndex].value+"";
	}
}
</script>
<%
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			String schoolid=(String)session.getAttribute("schoolid");
			try{   
				con=con1.getConnection();
				st=con.createStatement();

%>
</head>
<body topmargin=4 leftmargin=4>
<form name="ReportForm" id="ReportForm">
<table border='0' width='912' cellspacing='0' bordercolordark='#DDEEFF'>
	<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
		<td align=left width="100%" bgcolor="<%=bgclr%>">
		  <b><font face="Verdana">
			&nbsp;&nbsp;
			<select id="mp" name="mp" onchange="goReport()">	
			<%
				rs=st.executeQuery("SELECT m_id,m_name,des,DATE_FORMAT(s_date, '%m/%d/%Y') as s_date,DATE_FORMAT(e_date, '%m/%d/%Y') as e_date FROM marking_admin where schoolid='"+schoolid+"'");
				if(!rs.next()){
			%>
				<option value="none" selected>No Marking Points</option>
			<%}else{%>
				<option value="none" selected>Select Marking Point</option>
			<%do{%>				
				<option value="<%=rs.getString("m_id")%>"><%=rs.getString("m_name")%></option>
			<%}while(rs.next());%>
			<!-- 	<option value="all">All Marking Points</option> -->
			<%}%>
			</select>&nbsp;&nbsp;
			<select id="report" name="report" onchange="goReport()">	
				<option value="none" selected>Select Report</option>
				<option value="over_all.jsp">Summary</option>
				<option value="Bycourse.jsp">Report By Course</option>
				<!--
					<option value="assignments">Assignments</option>
			    	<option value="duedate">Assignments By Due Date</option>
			    -->
			</select>
			<!--<font size="1"><a target="sec" href="StudentReport1.html">
	          Report1</a>&nbsp;&nbsp; <a target="sec" href="StudentReport2.html">
	          Report2</a>&nbsp;&nbsp; <a target="sec" href="StudentReport3.html">
	          Report3</a>&nbsp;&nbsp; <a target="sec" href="StudentReport4.html">
	          Report4</a></font>
          -->
          </font></b></td>
   </table>
</form>
</body>
<%
con.close();
		}catch(Exception e){
			ExceptionsFile.postException("markingpoints/index.jsp","closing connection","Exception",e.getMessage());
			System.out.println(e);
			if (con!=null && ! con.isClosed())
				con.close();
		}finally{
			if (con!=null && ! con.isClosed())
				con.close();
		}
		%>
</html>