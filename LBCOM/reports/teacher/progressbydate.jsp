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
				System.out.println(s2);
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
<BODY  topmargin=4 leftmargin=0 >
<form method="POST" action="">
	<table border="1" cellspacing="0" style="border-collapse: collapse" id="table1" bgcolor='#EFEFF7'>
		<tr width='337'  bordercolor='#EFEFF7'>
			<TD class=table_rows style="PADDING-LEFT: 10px" noWrap >From Date: (m/d/yy)</TD>
			<TD style="PADDING-LEFT: 10px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" >
				<INPUT style="COLOR: #27408b" maxLength=10 size=10 name=from_date id=from_date value="<%=(String)session.getAttribute("reg_date")%>">
			</TD>
			<TD class=table_rows style="PADDING-LEFT: 10px" noWrap >To Date: (m/d/yy)</TD>
                <TD style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" >
				<INPUT style="COLOR: #27408b" maxLength=10 size=10 name=to_date id=to_date value="<%=s1%>">
			</TD>
			<TD class=table_rows style="PADDING-LEFT: 10px" noWrap ></TD>
			<td>
				<select id="report" name="report" onchange="goReport()">
					<option value="none" selected>Select Report</option>
					<option value="Summary">Summary</option>
					<option value="SSView">Activity</option>
				<!-- 	<option value="Byclass.jsp">By Class</option>  -->
				<!-- 	<option value="Bycourse.jsp">By Course</option> -->
				</select>
			</td>
			<td width=100% align="right"></td>
	</tr>
</table>
</form>
</BODY>
</HTML>
