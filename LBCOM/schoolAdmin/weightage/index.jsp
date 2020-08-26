<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function changestatus(check){
	if(check.checked==false){
		var ans=confirm("Are you sure this will delete teacher's weightage");
		if(ans==false){
			check.checked=true
			return	
		}	
	}
	window.location="/LBCOM/schoolAdmin.Weightage?mode=allow&allow="+check.checked+"";
return false;
}
//-->
</SCRIPT>

</head>


<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="5" leftmargin="5" >
<form name="categorieslist">

<BR>

<div align="center">
  <center>

<table border="1" width="564" cellspacing="1" bordercolordark="#FFFFFF"  bordercolor="#111111" height="179" bordercolorlight="#FFFFFF" cellpadding="0" style="border-collapse: collapse">
		<tr>
			<td width="558" align="center" bgcolor="#eeba4d" colspan="2" height="26"><b>
            <font face="Arial" color="#FFFFFF">Courseware Category Manager</font></b></td>
		</tr>
		<tr>
			<td width="558" height="20" bgcolor="#F9F3DB" align="center" colspan="2">
				<p align="left"><font face="Arial" size="2">Add or edit categories under these four courseware sections</font>
			</td>
		</tr>
		<tr>
		<%
			String test="";
			if(((String)session.getAttribute("weightage_status")).equals("B")){
				test="checked";
			}

		%>	
			<td width="558" height="21" bgcolor="#EEE0A1" align="center" colspan="2">
				<p align="left">&nbsp; <input type="checkbox" <%=test%> NAME="alloteacher" onclick="return changestatus(this)">
				<font face="Arial" size="2">Allow teacher to add/edit/delete 
				weightages</font></td>
	     </tr>
	    <tr>
			<td width="23" bgcolor="#E7E7E7" align="right" height="21">
				<p>
                <img border="0" src="images/idedit.gif" width="19" height="21" style="cursor:hand" onclick=go('CO')></p>
			</td>
			<td width="531" height="21" bgcolor="#E7E7E7">
				<p><b><font face="Arial" size="2">Course Info</font></b></p>
			</td>
		</tr>
		<tr>
			<td width="23" height="21" bgcolor="#E7E7E7" align="right">
				<img border="0" src="images/idedit.gif" width="19" height="21" style="cursor:hand" onclick=go('CM')></td>
			<td width="531" height="21" bgcolor="#E7E7E7">
				<b><font face="Arial" size="2">Course Material</font></b></td>
		</tr>
		<tr>
			<td width="23" height="21" bgcolor="#E7E7E7" align="right">
				<img border="0" src="images/idedit.gif" width="19" height="21" style="cursor:hand" onclick=go('AS') ></td>
			<td width="531" height="21" bgcolor="#E7E7E7">
				<b><font face="Arial" size="2">Assignments</font></b></td>
		</tr>
		<tr>
			<td width="23" bgcolor="#E7E7E7" align="right" height="22">
				<p>
                <img border="0" src="images/idedit.gif" width="19" height="21" style="cursor:hand" onclick=go('EX')></p>
			</td>
			<td width="531" height="22" bgcolor="#E7E7E7">
				<p><b><font face="Arial" size="2">Assessments</font></b></p>
			</td>
		</tr>
		<tr>
			<td align="left" height="22" colspan='3'>&nbsp;</td>
		</tr>

</table>
  <p>&nbsp;</p>
  </center>
</div>
</form>
</body >
<SCRIPT LANGUAGE="JavaScript">
<!--
	function go(tag){
		window.location.href="AllCategoriesList.jsp?type="+tag+"";
		return true;
	}
//-->
</SCRIPT>
</html>