<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--

function changestatus(check){
	if(check.checked==false){
		var ans=confirm("Are you sure?");
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
</HEAD>

<BODY>
<%
    String test="";
	if(((String)session.getAttribute("wait_status")).equals("B")){
		test="checked";
	}

%>	
<TD> 
<INPUT TYPE="checkbox" NAME="alloteacher" <%=test%> onclick="return changestatus(this)"><FONT SIZE="" COLOR="red" > Allow teachers to edit Weightages.</FONT></TD>
</BODY>
</HTML>
