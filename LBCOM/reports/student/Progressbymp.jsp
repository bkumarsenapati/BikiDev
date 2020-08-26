<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<%
	String bgclr="#E1DED5";
	String mid_des="",to_dates="";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/reports/script.js"></SCRIPT>
<title></title>
<script language="javascript">
var mids =null;
var todates =null;


function goReport()
{
	var mp=document.getElementById("mp");
	var report=document.getElementById("report");
	if((mp.selectedIndex!=0)&&(report.selectedIndex!=0)){
		for(i=0;i<mids.length;i++){
			if(mids[i]==mp.value){
				//if(isFeatureDate(todates[i])){
				//	parent.sec.location="../future_date.html";
				//	return false;
				//}
			}
		}
		parent.sec.location=""+report.options[report.selectedIndex].value+"?m_id="+mp.options[mp.selectedIndex].value+"";
	}else{
		parent.sec.location="about:blank";
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
				//2010,0,14
				rs=st.executeQuery("SELECT m_id,m_name,des,DATE_FORMAT(e_date, '%Y/%m/%d') as e_date FROM marking_admin where schoolid='"+schoolid+"'");
				if(!rs.next()){
			%>
				<option value="none" selected>No Marking Period</option>
			<%}else{%>
				<option value="none" selected>Select Marking Period</option>
			<%do{
				mid_des=mid_des+"\""+rs.getString("m_id")+"\",";
				to_dates=to_dates+"\""+rs.getString("e_date")+"\",";			
			%>				
				<option value="<%=rs.getString("m_id")%>"><%=rs.getString("m_name")%></option>
			<%
			}while(rs.next());
				mid_des=mid_des+"\"\"";
				to_dates=to_dates+"\"\"";			
			%>
			<%}%>
			</select>&nbsp;&nbsp;
			<SCRIPT LANGUAGE="JavaScript">
			<!--
				mids=new Array(<%=mid_des%>);
				todates=new Array(<%=to_dates%>)
			//-->
			</SCRIPT>
			<select id="report" name="report" onchange="goReport()">	
			<option value="none" selected>Select Report</option>
			<option value="summary.jsp">Summary Report</option>
			<option value="Bycourse.jsp">Course Report</option>
			<option value="ByActivity.jsp">Activity Report</option>
			<!--
					<option value="assignments">Assignments</option>
			    	<option value="duedate">Assignments By Due Date</option>
		    -->
			</select>
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