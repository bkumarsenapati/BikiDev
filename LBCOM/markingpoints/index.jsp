<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function createnew(){
	window.location="addeditmp.jsp?mode=add"
}
function edit_mp(m_id){
	window.location="addeditmp.jsp?mode=edit&m_id="+m_id+"";
}
function delete_mp(m_id){
	var ans=confirm("Do You want to delete Marking Period?");
	if(ans==true){
		window.location="../markingpoints.SaveEdit?mode=delete&user=admin&m_id="+m_id+"";
	}
}
//-->
</SCRIPT>
</head>
<body>
<form>
	<table cellspacing="0" width="100%">
			<tr>
				<td bgcolor="#EEE0A1" width="3">&nbsp;</td>
				<td bgcolor="#EEE0A1" width="691" align="left">
					<b><font face="Verdana" size="2">Marking Periods</font></b></td>
				<td bgcolor="#EEE0A1" width="48">&nbsp;</td>
				<td bgcolor="#EEE0A1" width="48">&nbsp;</td>
				<td width="63" bgcolor="#EEE0A1" align="right">
					<a href="javascript:history.back()"><font size="2">Back</font></a></td>
			</tr>
	</table>		
	<br>
	<table border="1" cellspacing="0" width="100%">
		<tr bgcolor="#EEBA4D">
			<th width="24"><font face="Verdana" size="2"> &nbsp;</font></th>
			<th width="24"><font face="Verdana" size="2"> &nbsp;</font></th>
			<th width="206"><font face="Verdana" size="2">Marking Period Name</font></th>
			<th width="112"><font face="Verdana" size="2">Start Date</font></th>
			<th width="103"><font face="Verdana" size="2">End Date</font></th>
			<th width="497"><font face="Verdana" size="2">Description</font></th>
		</tr>
		<%
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			String allow="";
			String schoolid=(String)session.getAttribute("schoolid");
			try{   
				con=con1.getConnection();
				st=con.createStatement();
				rs=st.executeQuery("SELECT m_id,m_name,des,DATE_FORMAT(s_date, '%m/%d/%Y') as s_date,DATE_FORMAT(e_date, '%m/%d/%Y') as e_date,status FROM marking_admin where schoolid='"+schoolid+"'");
				if(!rs.next()){	%>
				<tr>
					<td height="23" colspan="6">
						<FONT face="verdana" SIZE="1" COLOR="red">No Marking periods are created yet.</FONT>
					</td>
				</tr>
				<%}else{
					if(rs.getString("status").equals("B")) allow="checked";   // A means Admin T means Teacher						
					do{%>
						<tr>
							<td width="24" align=center>
							<img border="0" src="../images/iedit.gif" name="I1" width="16" height="19" style="cursor:hand" onclick="edit_mp('<%=rs.getString("m_id")%>')" title="Edit Marking Periods"></td>
							<td width="24" align=center>
							<img border="0" src="../images/del.gif" name="I1" width="13" height="15" style="cursor:hand" onclick="delete_mp('<%=rs.getString("m_id")%>')" Title="Delete Marking Periods"></td>
							<td width="206" align=left><%=rs.getString("m_name")%>&nbsp;</td>
							<td align=center><%=rs.getString("s_date")%>&nbsp;</td> 
							<td align=center><%=rs.getString("e_date")%>&nbsp;</td>
							<td align=left><%=rs.getString("des")%>&nbsp;</td>
						</tr>
						<%}while(rs.next());
				}
				con.close();
		}catch(Exception e){
			ExceptionsFile.postException("markingpoints/index.jsp","closing connection","Exception",e.getMessage());
			System.out.println(e);
			if (con!=null && ! con.isClosed())
				con.close();
		}finally{
			if (con!=null && ! con.isClosed())
				con.close();
		}
		%>
	</table>
	<input type="checkbox" name="Access" value="access" <%=allow%> onclick=change(this)>  <font size="2" face="Verdana" color="red">Allow&nbsp;teachers&nbsp;to&nbsp;edit&nbsp;marking periods.</font>
<input type="button" name="Create" value="Add New" onclick="createnew()" style="font-family:Arial; text-align:Center; padding-top:1px; padding-bottom:1px; border-width:1px; border-style:solid; height:20; float:right;"><br>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
function change(check){
	if(check.checked==false){
		var ans=confirm("Are you sure?");
		if(ans==false){
			check.checked=true
			return	
		}	
	}
	window.location="../markingpoints.SaveEdit?mode=allow&user=admin&allow="+check.checked+"";
}
//-->
</SCRIPT>

</body>
</html>