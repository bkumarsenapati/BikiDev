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
	var report=document.getElementById("report");
	if(report.selectedIndex!=0){
		parent.sec.location=""+report.options[report.selectedIndex].value+"";
	}else{
		parent.sec.location="about:blank"
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
<body topmargin=4 leftmargin=0 >
<form name="ReportForm" id="ReportForm">
<table border="1" cellspacing="0" style="border-collapse: collapse" id="table1" bgcolor='#EFEFF7' width="100%">
	<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
		<td align=left width="100%" >
		  <b><font face="Verdana">
			<select id="report" name="report" onchange="goReport()">	
				<option value="none" selected>Select Report</option>
				<option value="studentlist.jsp">Student Profile</option> 
				<!--
				<option value="assignments">Assignments</option>
			    <option value="duedate">Assignments By Due Date</option>
				-->
			</select> </font></b></td>
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