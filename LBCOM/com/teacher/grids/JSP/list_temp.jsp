<%
String path=request.getParameter("path");
path=path.replace('\\','/');

String fol_name=request.getParameter("fol_name");
%>
<html>
<head>
<script language="javascript">
function temp(ppt,folname)
{
	
	window.open(ppt);
	document.location.href="./list.jsp?fol_name="+folname;
}

</script>
</head>

<body onload="temp('<%=path%>','<%=fol_name%>')">

</body>
</html>