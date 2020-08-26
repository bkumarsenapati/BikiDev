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
	//alert("Rajesh")
	var field_status=document.forms[0].field_status
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
</SCRIPT></HEAD>
<BODY onload=body_onload()>
<% if(request.getParameter("status")!=null){%>
<div style="background-color: #FFFF00">
<p align="center">
	Fields Disabled
</p>
</div>
<%}%><font face="Arial" size="2" color="#0000FF"> </font>
<font face="Arial" size="2" color="#800000"> <b>Form View</b></font><font face="Arial" size="2" color="#0000FF"></b>

<%
	String schoolid=(String)session.getAttribute("schoolid");
	String formid=request.getParameter("formid");
	String utype=request.getParameter("utype");
	String classid=request.getParameter("classid");
	String uid=request.getParameter("userids");
	String status="";
	String uids[]=uid.split(",");//request.getParameterValues("userid");
	if(uids.length==1)
	  uid=uids[0];
	try{
			Connection con=null;
			Statement st=null;
			ResultSet  rs=null;
			con=con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery(" SELECT  field_ids,field_names,sample_file FROM  form_access where form_id='"+formid+"'");
			boolean x=rs.next();
			String fields_ids=rs.getString("field_ids");
			String fields_names=rs.getString("field_names");
			String[] fields_ids_arry=fields_ids.split(",");
			String[] fields_names_arry=fields_names.split(",");
			

%></font>
<iframe src="sample_pages/<%=rs.getString("sample_file")%>" width="98%" height="150" style="border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px" name="test"></iframe>
<form onsubmit="return Submit()" action="../accesscontrol.SaveEdit">
<%	
		String query="SELECT status from form_access_user_level where form_id='"+formid+"' and school_id='"+schoolid+"' and utype='"+utype.charAt(0)+"' and uid='"+uid+"'";
		rs=st.executeQuery(query);
			if(rs.next()){
				status=rs.getString(1);
				
			}else{
				query="SELECT "+request.getParameter("utype").charAt(0)+"_status from form_access_group_level where form_id='"+formid+"' and school_id='"+schoolid+"'";
				rs=st.executeQuery(query);
				if(rs.next()){
					status=rs.getString(1);
				}
			}		
			
		con.close();
		%>
	<table border="1" cellspacing="0" width="100%" id="table1" bordercolor="#999999">
		<%
		for(int i=0;i<fields_ids_arry.length;){int j=0;%>
		   <tr>
			<%		
			while((i<fields_ids_arry.length)&&(j<4))
			{%>
				<td width="2%">
				<input type="checkbox" name="field_status" value="<%=fields_ids_arry[i]%>"></td>
				<td width="20%"><font face="Verdana" size="2"><%=fields_names_arry[i++]%></font></td>
			<%j++;}%>
			</tr>
      <%
		}}catch(Exception e){
			System.out.println("Exception in accesscontrol/grouplevel/top.jsp  :"+e);
		}
		%>
	</TABLE>
<INPUT TYPE="hidden" name="formid" value="<%=formid%>" >
<INPUT TYPE="hidden" id="status" name="status" >
<INPUT TYPE="hidden" name="utype" value="<%=utype%>">
<INPUT TYPE="hidden" name="uid" value="<%=uid%>">
<INPUT TYPE="hidden" name="classid" value="<%=classid%>">
<hr>
<CENTER>
<INPUT TYPE="submit" Value="Disable" style="height: 21; border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px"> <INPUT TYPE="button" value="Reset" onclick="re_set()" style="height: 21; border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px"></CENTER>
<hr>
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
	var field_status=document.forms[0].field_status
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