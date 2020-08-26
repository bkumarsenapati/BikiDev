<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<HTML>
<HEAD>
<%
	String pg_grp=request.getParameter("group");
	String classid=request.getParameter("classid");
	if(pg_grp==null)
	  pg_grp="xxx";
	if(classid==null)
	  classid="xxx";
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var pg_grp="<%=pg_grp%>"
	var classid="<%=classid%>"
	function change_page(k){
		var grp=document.getElementById("group");
		var classid=document.getElementById("classid");
		var page=document.getElementById("page");
		var level_type=""
		if(k==1){
			if(grp.selectedIndex!=0){
						var grp=grp.value;
						window.location="formaccess.jsp?level=G&group="+grp+"";
						parent.sec.location.href="about:blank";
					}else{
						grp.value=pg_grp;
				}
			}
		if(k==2){         ///SELECT CLASS
				
				if((grp.selectedIndex!=0)&&(page.selectedIndex!=0)){
						var grp=grp.value;
						var classid=classid.value;
						parent.sec.location.href="formaccessreport.jsp?formid="+page.value+"&group=<%=pg_grp%>&classid="+classid+"";
					}
				
		}
		if(k==4){
				if(page.selectedIndex!=0){
					if((grp.selectedIndex==0)){
						alert("You must select all fields");
						page.selectedIndex=0;
					}else{					
						var classid=classid.value;
						parent.sec.location.href="formaccessreport.jsp?formid="+page.value+"&group=<%=pg_grp%>&classid="+classid+"";
					}
				}else{
					parent.sec.location.href="about:blank";

				}
			
		}
	}
	function body_onload(){
		var grp=document.getElementById("group");
		var clssid=document.getElementById("classid")
		<%
		if(pg_grp=="xxx"){	%>
			grp.selectedIndex=0;
			clssid.selectedIndex=0;		
		<%}else{%>
			grp.value="<%=pg_grp%>";
			clssid.value="<%=classid%>";
		<%}
		if(classid=="xxx"){	%>
			clssid.selectedIndex=0;		
		<%}%>
	}
		//
//-->
</SCRIPT>
</HEAD>
<BODY topmargin="0" onload="body_onload();" >
<%
	String schoolid=(String)session.getAttribute("schoolid");
	String query="";
	try{
		Connection con=null;
		Statement st=null;
		ResultSet  rs=null;
		con=con1.getConnection();
		st=con.createStatement();
%>
<TABLE  width="100%" border=0 cellspacing="1" bordercolor="#FFFFFF" bgcolor="#C0C0C0">
<TR>
	 <TD id="glevel" width="73">
			<p align="left">
			<B>
			<font size="2" face="Arial">&nbsp;</font><font size="2" face="Verdana">Group 
			:</font></B></TD>
	 <TD id="glevel" width="119">
			<p align="left">
			<font face="Arial">
			<select id="group" onchange="change_page('1')"; name="D2" size="1">
				<option selected>Select</option>
				<option value="Teacher">Teacher</option>
				<option value="Student">Student</option>
			</select></font></TD>
	<TD id="ulevel0" width="72">
			<font face="Verdana" size="2"><B>Class :</B></font></TD>
	<TD id="ulevel1">
			<font face="Arial">
			<select id="classid" onchange="change_page('2')" name="D3">
			<option value="all">Select</option>
			<%
				query= "SELECT  class_id,class_des FROM  class_master where school_id='"+schoolid+"'";
				rs=st.executeQuery(query);
				while (rs.next()) {		
			%>
					<option value="<%=rs.getString("class_id")%>"><%=rs.getString("class_des")%></option>
					
			<%}%>			
			</select></font>
	</TD>
	<TD id="glevel" width="107">
			<p align="left">
			<font size="2" face="Verdana">
			<B>Form&nbsp;Name :</B>
		</font>
			</TD>
	 <TD id="glevel" width="207">
			<font face="Arial">
		<select id="page" onchange="change_page('4')" name="D1">
		<option value="">Select</option>
		<%
			query= "SELECT  form_id, form_name FROM  form_access where Bto like '%"+pg_grp.charAt(0)+"%'";
			rs=st.executeQuery(query);
			while (rs.next()) {		
		%>
				<option value="<%=rs.getString("form_id")%>"><%=rs.getString("form_name")%></option>
				
		<%}%>		
		</select></font>
	</TD>
	
	
</TR>
</TABLE>

<%
		con.close();
	}catch(Exception e){
			System.out.println("Exception in accesscontrol/grouplevel/formaccess.jsp  :"+e);

   }
%>
</BODY>
</HTML>