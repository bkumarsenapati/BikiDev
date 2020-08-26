<%@ page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	String studentId = (String)session.getAttribute("emailid");
	String classId = (String)session.getAttribute("classid");	
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>
</head>
<body topmargin=2 leftmargin=0>
<form name="qtnselectfrm" id='qt_sel_id'>
<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>
	<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>
             <td align="center"> Periodicity	
	         <select id='grade_id' name='gradeid'  onchange='call(this)'>
	           <option value='select'>Select</option>
                   <option value='session'>By Session</option>
		   <option value='day'>By Day</option>
		   <option value='week'>By Week</option>
		   <option value='month'>By Month</option>
		 </select>
	      </td>
	</tr>
</table>	      		
</form>
</body>

<script language="javascript">

	function call(obj){
        	var mode=obj.value;
		if (mode=="session")
			parent.sec.location.href="/LBCOM/reports/BySession.jsp?studentid=<%=studentId%>&classid=<%=classId%>";
	        if (mode=="day")
			parent.sec.location.href="/LBCOM/reports/ByDay.jsp?studentid=<%=studentId%>&classid=<%=classId%>";
		if (mode=="week")
			parent.sec.location.href="/LBCOM/reports/ByWeek.jsp?studentid=<%=studentId%>&classid=<%=classId%>";
		if (mode=="month")
			parent.sec.location.href="/LBCOM/reports/ByMonth.jsp?studentid=<%=studentId%>&classid=<%=classId%>";
	}
</script>
</html>
