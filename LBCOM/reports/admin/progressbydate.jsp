<%@page import="java.io.*,java.text.*,java.util.*"%>
<%@ include file="/common/checksession.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<LINK media=screen href="../images/default.css" type=text/css rel=stylesheet>
<LINK media=print href="../images/print.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="../common/Calendar/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src='/LBCOM/common/Validations.js'>	</script>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/reports/script.js"></SCRIPT>
<script language="javascript">
function checkdateformat(format,dtstring){
	if(format==="mm/dd/yy"){
		var date_array=dtstring.split("/");
		if(isNaN(date_array[0])||isNaN(date_array[1])||isNaN(date_array[2]))
			return false;
		if((date_array[0]>12)||(date_array[1]>31))
			return false;
		return true;
	}
}

function goReport()
{
	var report=document.getElementById("report");
	var from_date=document.getElementById("from_date").value;
	var to_date=document.getElementById("to_date").value;
	if(!checkdateformat("mm/dd/yy",from_date)){
		alert("Format of From date is not correct");
		return false;
	}
	if(!checkdateformat("mm/dd/yy",to_date)){
		alert("Format of From date is not correct");
		return false;
	}
	if((report.selectedIndex!=0)){
		if(isFeatureDate(to_date)){
			<%
				Date now = new Date();
				Format formatter;
				formatter = new SimpleDateFormat("MM/DD/yyyy");
				String s2 = formatter.format(now);
				DateFormat df1 = DateFormat.getDateInstance(DateFormat.SHORT);
				String s1 = df1.format(now);
			%>
			to_date="<%=s1%>";
			document.getElementById("to_date").value="<%=s1%>"
			alert("You can view reports upto today only");	
			
		}	
		parent.sec.location=""+report.options[report.selectedIndex].value+"?m_id=no,"+from_date+","+to_date;
	}else{
		parent.sec.location="about:blank";	
	}
	
}
</script>
</HEAD>
<BODY  topmargin=4 leftmargin=4>
<form method="POST" action="">
	<table border="1" cellspacing="0" style="border-collapse: collapse" id="table1">
		<tr>
			<TD class=table_rows style="PADDING-LEFT: 10px" noWrap >From Date: (m/d/yy)</TD>
			<TD style="PADDING-LEFT: 10px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" >
				<INPUT style="COLOR: #27408b" maxLength=10 size=10 name=from_date id=from_date value="<%=(String)session.getAttribute("reg_date")%>">
			</TD>
			<TD class=table_rows style="PADDING-LEFT: 10px" noWrap >To Date: (m/d/yy)</TD>
                <TD style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" >
				<INPUT style="COLOR: #27408b" maxLength=10 size=10 name=to_date id=to_date value="<%=s1%>">
			</TD>
		<td>
			<select id="report" name="report" onchange="goReport()">	
				<option value="none" selected>Select Report</option>
				<option value="studentsummary.jsp">Student&nbsp;Summary</option>
				<option value="SSView">Activity</option>
				<!-- <option value="Byclass.jsp">Report By Class</option>
				<option value="Bystudent.jsp">Report By Student</option> -->
			</select>
		</td>
		<td width=100%>&nbsp;</td>
	</tr>
</table>
</form>
</BODY>
</HTML>
