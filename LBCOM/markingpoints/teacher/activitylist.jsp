<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<html>
<head>
</head>
<body>
<form>
	<Div style="background-color:rgb(66,162,231);">
		<table cellspacing="0" style="border-collapse: collapse" width="100%">
			<tr>
				<td>&nbsp;</td>
				<td><div align="center"><b><font face="Arial" color="#FFFFFF">Activity List</font></b></div></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td width="62">
				<a style="font-family: Arial; " href="javascript:return falsr">
				<font color="#FFFFFF" size="2"></font></a></td>
			</tr>
		</table>		
	</Div><font face="Arial"><br>
	</font>
	<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%">
		<tr>
			<th width="24"></th>
			<th width="206"><font face="Arial" size="2">Activity Name</font></th>
			<th width="112"><font face="Arial" size="2">Starting Date</font></th>
			<th width="103"><font face="Arial" size="2">Ending Date</font></th>
		</tr>
		<%
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			String schoolid=(String)session.getAttribute("schoolid");
			String teacherId = (String)session.getAttribute("emailid");
			String query="";
			if(request.getParameter("a_type").equals("Assignments")){
				query="Select work_id as activityid,doc_name as activityname,DATE_FORMAT(from_date, '%m/%d/%Y') as from_date,DATE_FORMAT(to_date, '%m/%d/%Y') as to_date from "+schoolid+"_"+request.getParameter("classid")+"_"+request.getParameter("courseid")+"_workdocs where teacher_id='"+teacherId+"'";
			}else{
				query="Select exam_id as activityid,exam_name as activityname,DATE_FORMAT(from_date, '%m/%d/%Y') as from_date,DATE_FORMAT(to_date, '%m/%d/%Y') as to_date from exam_tbl where course_id='"+request.getParameter("courseid")+"' and school_id='"+schoolid+"'";
			}
			try{   
				con=con1.getConnection();
				st=con.createStatement();
				rs=st.executeQuery(query);
				if(!rs.next()){%>
				<tr>
					<td height="23" colspan="5">
						<FONT face="Arial" SIZE="1" COLOR="red">No <%=request.getParameter("a_type")%> are created yet.</FONT><font face="Arial">
						</font>
					</td>
				</tr>
				<%}else{
					do{%>
						<tr>
							<td width="24" align=center><input type="radio" name="activity_id" value="<%=rs.getString("activityid")%>">
							<INPUT TYPE="hidden" name="activity_name" value="<%=rs.getString("activityname")%>"> </td>
							<td width="206" align=center>
							<font face="Arial" size="2"><%=rs.getString("activityname")%></font></td>
							<td align=center><font face="Arial" size="2"><%=rs.getString("from_date")%></font></td> 
							<td align=center><font face="Arial" size="2"><%=rs.getString("to_date")%></font></td>
							<INPUT TYPE="hidden" name="e_date" value="<%=rs.getString("to_date")%>">
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
	<br>
	<table cellspacing="0" style="border-collapse: collapse" width="100%">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align=center>
				&nbsp;</td>
			<td>&nbsp;</td>
			<td>
				<input type="button" name="Create" value="Create New" onclick="createnew()" style="text-align:center; border-width:1px; border-style:solid;width:0;height:20; float:right;"></td>
		</tr>
	</table>
</form>
</body>
</html>