<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<html>
<head>
<%
	String userId=(String)session.getAttribute("emailid");
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function createnew(){
	window.location="addeditmp.jsp?mode=add"
}
function edit_mp(m_id){	
	window.location="addeditmp.jsp?classid=<%=request.getParameter("classid")%>&classname=<%=request.getParameter("classname")%>&courseid=<%=request.getParameter("courseid")%>&coursename=<%=request.getParameter("coursename")%>&mode=edit&m_id="+m_id+"";
}
function delete_mp(m_id){
	var ans=confirm("Do you want to delete Marking Period?");
	if(ans==true){		window.location="../../markingpoints.SaveEdit?mode=delete&user=teacher&courseid=<%=request.getParameter("courseid")%>&m_id="+m_id+"";
	}
}
function cant_delete_mp(){
	alert("You can't delete this as it is created by your admin.");
	return false;
}
//-->
</SCRIPT>
</head>
<body style="text-align: left">
<form>
	<table cellspacing="0" width="100%">
			<tr>
				<td bgcolor="#A8B8D1" width="3">&nbsp;</td>
				<td bgcolor="#A8B8D1" align="left">
					<b><font face="Verdana" size="2">Marking Periods</font></b></td>
				<td bgcolor="#A8B8D1">&nbsp;</td>
				<td bgcolor="#A8B8D1">&nbsp;</td>
				<!-- <td width="62" bgcolor="#A8B8D1">
				<p align="right">
				<a href="javascript:history.back()"><font size="2">Back</font></a></td> -->
			</tr>
	</table>		
	<br>
	<table border="1" cellspacing="0" width="100%">
		<%
			Connection con=null;
			Statement st=null,st1=null,st2=null;
			ResultSet rs=null,rs1=null,rs2=null;
			String schoolid=(String)session.getAttribute("schoolid");
			String status="B";
			boolean flag=false;
			try{   
				con=con1.getConnection();
				st=con.createStatement();
				st1=con.createStatement();
				st2=con.createStatement();
				String query3="SELECT status from marking_admin where status='A'and schoolid='"+schoolid+"'" ;
				rs2=st2.executeQuery(query3);
				if(rs2.next()){
					status="A";
				}
				String query1="SELECT marking_course.m_id,DATE_FORMAT(marking_course.s_date, '%m/%d/%Y') AS s_date,DATE_FORMAT(marking_course.e_date, '%m/%d/%Y') AS e_date,activity_id,activity_name,m_name,des FROM marking_admin,marking_course where marking_admin.m_id=marking_course.m_id and marking_course.schoolid='"+schoolid+"'" ;
				rs1=st1.executeQuery(query1);
				String query2="SELECT m_id,m_name,des,DATE_FORMAT(s_date, '%m/%d/%Y') as s_date,DATE_FORMAT(e_date, '%m/%d/%Y') as e_date ,status FROM marking_admin where schoolid='"+schoolid+"' and m_id NOT IN (SELECT m_id from marking_course where schoolid='"+schoolid+"' and courseid='"+request.getParameter("courseid")+"' and teacherid='"+userId+"')";
				rs=st.executeQuery(query2);
				%>
				<tr>
					<%if(status.equals("B")){%>
					<th width="24">&nbsp;</th>
					<th width="24">&nbsp;</th>
					<%}%>
					<th width="206"><font face="Arial" size="2">Marking Period Name</font></th>
					<th width="112"><font face="Arial" size="2">Start Date</font></th>
					<th width="103"><font face="Arial" size="2">End Date</font></th>
					<%if(status.equals("B")){%>
					<th width="103"><font face="Arial" size="2">To Activity</font></th>
					<%}%>
					<th width="497"><font face="Arial" size="2">Description</font></th>
				</tr>

				<%


				while(rs1.next()){
					flag=true;
				%>
						<tr>
								<td width="24" align=center>
								<font face="Arial">
								<img border="0" src="../../images/iedit.gif" name="I1" width="16" height="19" style="cursor:hand" onclick="edit_mp('<%=rs1.getString("m_id")%>')" Title="Edit Marking Periods"></font></td>
								<td width="24" align=center>
								<font face="Arial">
								<img border="0" src="../../images/del.gif" name="I1" width="15" height="15" style="cursor:hand" onclick="delete_mp('<%=rs1.getString("m_id")%>')" Title="Delete Marking Periods"></font></td>
							<td width="206" align=center>
							<font face="Arial" size="2"><%=rs1.getString("m_name")%></font>&nbsp;</td>
							<td align=center><font face="Arial" size="2"><%=rs1.getString("s_date")%></font>&nbsp;</td> 
							<td align=center><font face="Arial" size="2"><%=rs1.getString("e_date")%></font>&nbsp;</td>
							<td align=center><font face="Arial" size="2"><%=rs1.getString("activity_name")%></font>&nbsp;</td>
							<td align=center><font face="Arial" size="2"><%=rs1.getString("des")%></font>&nbsp;</td>
						</tr>
				<%}							
				if(!rs.next()){
					if(flag==false){%>
					<tr>
							<td height="23" colspan="10">
								<FONT face="Arial" SIZE="1" COLOR="red">No categories are created yet.</FONT><font face="Arial">
								</font>
							</td>
						</tr>
				<%}}else{
						
					do{%>
						<tr>
							<%if(status.equals("B")){%>
							<td width="24" align=center>
							<font face="Arial">
							<img border="0" src="../../images/iedit.gif" name="I1" width="16" height="19" style="cursor:hand" onclick="edit_mp('<%=rs.getString("m_id")%>')" title="Edit Marking Periods"></font></td>
							<td width="24" align=center>
							<font face="Arial">
							<img border="0" src="../../images/del.gif" name="I1" width="15" height="15" style="cursor:hand" onclick="cant_delete_mp()" Title="Delete Marking Periods"></font></td>
							<%}%>
							<td width="206" align=center>
							<font face="Arial" size="2"><%=rs.getString("m_name")%></font>&nbsp;</td>
							<td align=center><font face="Arial" size="2"><%=rs.getString("s_date")%></font>&nbsp;</td> 
							<td align=center><font face="Arial" size="2"><%=rs.getString("e_date")%></font>&nbsp;</td>
							<%if(status.equals("B")){%>
							<td align=center><font face="Arial" size="2"></font>&nbsp;</td>
							<%}%>
							<td align=center><font face="Arial" size="2"><%=rs.getString("des")%></font>&nbsp;</td>
						</tr>
						<%}while(rs.next());
				}
				con.close();
		}catch(Exception e){
			ExceptionsFile.postException("markingpoints/teacher/index.jsp","closing connection","Exception",e.getMessage());
			if (con!=null && ! con.isClosed())
				con.close();
		}finally{
			try{
				if(con!=null && ! con.isClosed()){
					con.close();
				}
			}catch(Exception e){
				ExceptionsFile.postException("markingpoints/teacher/index.jsp","closing connection","Exception",e.getMessage());
			}
		}
		%>
	</table>
	<br>
	<table cellspacing="0" width="100%">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align=center>&nbsp;</td>
			<td>&nbsp;</td>
			<td>
				<%if(status.equals("B")){%>
				<input type="button" name="Create" value="Create New" onclick="createnew()" style="float: right; width=0; height: 20; border-style: solid; border-width: 1px; ">
				<%}%>
			</td>
		</tr>
	</table>
</form>
</body>
</html>