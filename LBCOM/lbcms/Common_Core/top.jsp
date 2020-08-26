<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<HTML>
<HEAD>
<%
	String pg_grp=request.getParameter("group");
	pg_grp="teacher";
	String classid=request.getParameter("classid");
	classid="C000";
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
		var lavel=document.getElementById("ulevelc");
		var level_type=""
		if(lavel.checked!=true)
			level_type="Group"
		else
			level_type="user"
		if(k==1){
			if(level_type==="user"){
				if(grp.selectedIndex!=0){
						var grp=grp.value;
						window.location="top.jsp?level=U&group="+grp+"";
					}else{
						grp.value=pg_grp;
				}
			}else{
				if(grp.selectedIndex!=0){
						var grp=grp.value;
						window.location="top.jsp?level=G&group="+grp+"";
					}else{
						grp.value=pg_grp;
				}
			}
		}
		if(k==2){
				if(classid.selectedIndex!=0){
					if((grp.selectedIndex!=0)&&(page.selectedIndex!=0)){
						var grp=grp.value;
						var classid=classid.value;
						//window.location="top.jsp?level=U&group="+grp+"&classid="+classid+"&page="+page.value+"";
						parent.main.location.href="userlist.jsp?formid="+page.value+"&group=<%=pg_grp%>&classid="+classid+"";
					}else{
						alert("You must select the group and Form");
						classid.selectedIndex=0;
					}
				}else{
					document.getElementById("group").value=pg_grp;
					parent.main.location.href="about:blank";
				}		
		}
		if(k==4){
			if(level_type==="user"){
				if(page.selectedIndex!=0){
					if((grp.selectedIndex==0)){
						alert("You must select all fields");
						page.selectedIndex=0;
					}
				}
			}else{
				if(page.selectedIndex!=0){
					if((grp.selectedIndex==0)){
						alert("You must select all fields");
						page.selectedIndex=0;
					}else{						parent.main.location.href="groupbody.jsp?formid="+page.value+"&utype=<%=pg_grp.charAt(0)%>";
					}
				}else{
					parent.main.location.href="about:blank";

				}
			}
		}
	}
	function check(k){
		var ulevel0=document.getElementById("ulevel0");
		var ulevel1=document.getElementById("ulevel1");
		var glevel=document.getElementById("glevel");
		var classid=document.getElementById("classid");
		if(k==false){
			ulevel0.style.visibility = "hidden";
			ulevel1.style.visibility = "hidden";
			glevel.style.visibility = "visible"
		}else{
			ulevel0.style.visibility = "visible";
			ulevel1.style.visibility = "visible";
			glevel.style.visibility = "visible"
			classid.selectedIndex=0;
		}
		var page=document.getElementById("page");
		parent.main.location.href="about:blank"
		//page.selectedIndex=0;
				
	}
	function body_onload(){
		var lev="<%=request.getParameter("level")%>";
		if(lev=="U"){
			document.getElementById("ulevelc").checked=true;
			check(true)
		}else
			check(false)

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
//-->
</SCRIPT>
</HEAD>
<BODY onload="body_onload();">
<%
	String schoolid=(String)session.getAttribute("schoolid");
	try{
		Connection con=null;
		Statement st=null;
		ResultSet  rs=null;
		con=con1.getConnection();
		st=con.createStatement();
%>
<div style="border-width:0px; border-style:solid; top=0%">
	<p align="left"><b><font face="Verdana" color="#89610E" size="2">FORM&nbsp;ACCESS&nbsp;CONTROL</font></b></p>
	<FONT SIZE="1" COLOR="#FF0000" face="Verdana">Choose a form and enable/disable selected form fields for a group/an individual user.</FONT>
</div>
<TABLE  width="100%" border=0 cellspacing="1" bordercolor="#FFFFFF" bgcolor="#EEE0A1">
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
<%
		String query= "SELECT  * FROM  dev_common_core_larts_standards";
			System.out.println("query..."+query);
			rs=st.executeQuery(query);
			while (rs.next()) {	
%>
				<option value="grade"><%=rs.getString("grade")%></option>
				<%
			}
				st.close();
			st=con.createStatement();
			%>
			</select></font></TD>
			

	 <TD id="glevel" width="107">
			<p align="left">
			<font size="2" face="Verdana">
			<B>Form&nbsp;Name :</B>
		</font>
			</TD>
	 <TD id="glevel" width="134">
			<font face="Arial">
		<select id="page" onchange="change_page('4')" name="D1">
		<option value="">Select</option>
		<%
			query= "SELECT  form_id, form_name FROM  form_access where Bto like '%"+pg_grp.charAt(0)+"%'";
			System.out.println("query..."+query);
			rs=st.executeQuery(query);
			while (rs.next()) {		
		%>
				<option value="<%=rs.getString("form_id")%>"><%=rs.getString("form_name")%></option>
				
		<%}%>		
		</select></font></TD>
	 <TD id="glevel" width="104">
		<p align="left">
		<font size="2" face="Verdana"><b>User&nbsp;Level :</b></font></TD>
	 <TD id="glevel" width="25">
		<font face="Arial">
        <INPUT TYPE="checkbox" NAME="ulevelc" id="ulevelc" onclick= "check(this.checked)" value="ON"></font></TD>
	<TD id="ulevel0" width="51">
			<font face="Verdana" size="2"><B>Class :</B></font></TD>
	
	
	<TD id="ulevel1">
			<font face="Arial">
			<select id="classid" onchange="change_page('2')" name="D3">
			<option value="null">Select</option>
			<%
				query= "SELECT  class_id,class_des FROM  class_master where school_id='"+schoolid+"'";
				rs=st.executeQuery(query);
				while (rs.next()) {		
			%>
					<option value="<%=rs.getString("class_id")%>"><%=rs.getString("class_des")%></option>
					
			<%}%>			
			<option value="All">All</option>
		    </select></font></TD>
	<td><a href="reports/formaccess.jsp" onclick="parent.main.location.href='about:blank'">Reports</a></td>
	
</TR>
</TABLE>

<%
		con.close();
	}catch(Exception e){
			System.out.println("Exception in accesscontrol/grouplevel/top.jsp  :"+e);

   }
%>
</BODY>
</HTML>