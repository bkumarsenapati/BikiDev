<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
var formid="<%=request.getParameter("formid")%>";
function Submit(){
	var field_status=document.getElementsByName("field_status");
	txt=""
	for (i=0;i<field_status.length;++ i)
	{
		
		if (field_status[i].checked)
		{
			if(field_status[i].value=="courseware")
			{
				txt=txt + "0"
			}
			else
			{
				txt=txt + "1"
			}
		}else{
			txt=txt + "0"
		}
	}
	document.getElementById("status").value=txt;
	return true;
}
//-->
</SCRIPT>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</HEAD>
<BODY onload="body_onload();">
<% if(request.getParameter("status")!=null){%>
<div style="background-color:yellow;">
<p align="center">
	Fields Disabled
</p>
</div>

<p align="left">
<%}%>
<font color="#800000">
<b>
<font size="2" face="Verdana">Form View</font></b><font face="Arial">
</font>
<%
	String schoolid=(String)session.getAttribute("schoolid");
	String formid=request.getParameter("formid");
	String status="";
	try{
			Connection con=null;
			Statement st=null;
			ResultSet  rs=null;
			con=con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select  field_ids,field_names,sample_file FROM  form_access where form_id='"+formid+"'");
			boolean x=rs.next();
			String fields_ids=rs.getString("field_ids");
			String fields_names=rs.getString("field_names");
			String[] fields_ids_arry=fields_ids.split(",");
			String[] fields_names_arry=fields_names.split(",");
%>
</font>
<iframe src="sample_pages/<%=rs.getString("sample_file")%>" width="98%" height="150" style="border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px" name="test"></iframe>
</p>
<div align="center">
<form onsubmit="return Submit()" action="../accesscontrol.SaveEdit">
<table border="1" cellspacing="0" width="100%" id="table1" bordercolor="#E5E5E5">
	<tr>
		<td colspan="9" height="36">
<input type="checkbox" name="RUS" value="true" Title="If you check this you will lose user's individual settings"><b><font face="Verdana" style="font-size: 9pt" color="#FF0000"> Remove Individual User Selections</font></b>
		</td>
	</tr>
	<%	
		String query="SELECT "+request.getParameter("utype")+"_status from form_access_group_level where form_id='"+formid+"' and school_id='"+schoolid+"'";
		System.out.println("111111111.....query..."+query);
			rs=st.executeQuery(query);
			if(rs.next()){
				status=rs.getString(1);
			}
		con.close();

	%>
	<%
		for(int i=0;i<fields_ids_arry.length;){
			int j=0;
			%>
			<tr>
			<%		
			while((i<fields_ids_arry.length)&&(j<4))
			{%>
				<td width="2%">
				<input type="checkbox" name="field_status" value="<%=fields_ids_arry[i]%>"></td>
				<td width="20%"><font face="Verdana" size="2"><%=fields_names_arry[i++]%></font></td>
			<%j++;}%>
			<tr>
	<%
		}}catch(Exception e){
			System.out.println("Exception in accesscontrol/grouplevel/top.jsp  :"+e);
		}
%>	
</table>
</div>
<INPUT TYPE="hidden" name="utype" value="<%=request.getParameter("utype")%>">
<INPUT TYPE="hidden" id="status" name="status">
<INPUT TYPE="hidden" name="formid" value="<%=formid%>">
<p align="center">
<INPUT TYPE="submit" Value="DISABLE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<INPUT TYPE="button" value="RESET" onclick="re_set()"></p>
</form>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
<!--
function re_set(){
		window.document.forms[0].reset();
		body_onload()
	}
function body_onload(){
	var status="<%=status%>"
	var field_status=document.getElementsByName("field_status");
	for (i=0;i<status.length;++i)
	{
		if (status.charAt(i)==1)
		{
			field_status[i].checked="checked"
		}
	}
}
//-->
</SCRIPT>
</HTML>