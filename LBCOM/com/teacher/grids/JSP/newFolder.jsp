<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
	<script language="Javascript" src="../JS/mainpage.js"></script>
	<script language="Javascript">
	function valid_name()
	{
		var name=document.newForm.folder_name.value;
		if(name<=0 || name=="")
		{
			alert("Please Enter Folder Name");
			return false;
		}
		else return true;
	}
	</script>
</head>
<body>
<form method="post" name="newForm" action="../../addFolder" onsubmit="return valid_name();">
<table width="352">
<tr>
	<td width="346"><font face="Arial"><span style="font-size:10pt;">Enter the Folder Name to create a folder.<br><br></span></font></td>
	</tr>
	<tr>
	<td width="346"><font face="Arial"><span style="font-size:10pt;">Folder Name <input type="text" name="folder_name"></span></font></td>
	</tr>
	<tr>
        <td width="346">
            <p align="center"><input type="submit" style="width: 70pt;" value="Create Folder"> &nbsp;&nbsp;&nbsp;<input type="button" name="cancel" value="Back" style="width: 70pt;" onclick="back()"></p>
        </td>
	</tr>

</table>
</form>
</body>