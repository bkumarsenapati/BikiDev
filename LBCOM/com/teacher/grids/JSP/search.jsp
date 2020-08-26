<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
		<script language="JavaScript">
		function validName()
		{
			var name=document.ff.f_name.value;
			
			if(name!="" || name.length>0)
			{
				return true;
			}
			else {
				alert("Enter the File name");
				return false;
			}

		}
		</script>
</head>
<body>
<form name="ff" method="get" action="list.jsp" onsubmit="return validName();">
<font face="Arial"><span style="font-size:10pt;">Enter File Name <input type="text" name="f_name">
 <input type="submit" value="Search">
</span></font>
<input type="button" name="cancel" value="Cancel" onclick="javascript:history.back()"></span></font></p>
</form>
</body>
</html>