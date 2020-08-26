<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<html>
<head>
<script language="JavaScript">
activity_type="Assessments";
function changeParent(){
	var a_id=document.frames("frame1").document.getElementsByName("activity_id");
	var a_name=document.frames("frame1").document.getElementsByName("activity_name")
	var e_date=document.frames("frame1").document.getElementsByName("e_date")
	var selected_id="";
	var selected_name="";
	var selected_edate="";
	for(i=0;i<a_id.length;i++){
		if(a_id[i].checked==true){
			selected_id=a_id[i].value;
			selected_name=a_name[i].value;
			selected_edate=e_date[i].value;	
			
		}		
	}
	if(selected_id===""){
		alert("Please select any activity.");
	}else{
		opener.document.getElementById("activity").value=selected_name;
		opener.document.getElementById("activity_id").value=selected_id;
		opener.document.getElementById("Activity_type").value=activity_type;
		opener.document.getElementById("to_date").value=selected_edate;
		window.close();
	}
}
function change_loc(key_type){
	activity_type=key_type;
	document.frames("frame1").location="activitylist.jsp?classid=<%=request.getParameter("classid")%>&classname=<%=request.getParameter("classname")%>&courseid=<%=request.getParameter("courseid")%>&coursename=<%=request.getParameter("coursename")%>&a_type="+activity_type+""



}
</script>
<meta http-equiv="Content-Language" content="en-us">
</head>
<body>
<form method="POST" action="--WEBBOT-SELF--">
<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%" height="100%">
	<tr>
		<td height="27">
			<input type="button" value="Assessments" name="btn_assessments" onclick="change_loc('Assessments')" style="height: 19; width: 123; border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">&nbsp;&nbsp;
			<input type="button" value="Assignments" name="btn_assignments" onclick="change_loc('Assignments')" style="height: 19; border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">
		</td>
		<td height="27">		
			<input type="button" name="Insert" value="Insert" onclick="changeParent()" style="text-align:center; border-width:1px; border-style:solid; height:20; float:right;">
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<iframe name="frame1" id="iframe" width="100%" height="100%" src="">		
			</iframe>
		</td>
	</tr>
</table>
</form>
</body>

</html>