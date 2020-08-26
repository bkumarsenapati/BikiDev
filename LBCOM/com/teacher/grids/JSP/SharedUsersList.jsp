<html>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<head>
<script language="Javascript" src="../JS/mainpage.js"></script>
<%!
	private File filepath=null,mFilePath=null;
	private String path="",context_path="",folder_path="",mfiles="",download_path="";
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private DbBean bean;
	private int i=0;
	String flag="false",uid="";
%>
</head>
<body>
<form method="post" action="../../SharedUsers">
<center>
<table border="0" cellspacing="0" width="70%" id="AutoNumber3" style="border-collapse: collapse" cellpadding="0" >
<tr bgcolor="#429EDF"><td width="40%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">UserId</font></td><td width="20%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF"> Read </font></td><td width="20%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Read/Write</font></td><td width="30%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Remove Sharing</font></td></tr>
<%
try{
	uid=(String)session.getAttribute("emailid");
	path=request.getParameter("f_path").replaceAll("\\\\\\\\" , "\\\\");
	bean=new DbBean();
	con=bean.getConnection();
	
	st=con.createStatement();
	
	rs=st.executeQuery("select userid,sid,permission from shared_data where shared_user='"+uid+"' and filename='"+path.replace('\\','/')+"'");
	while(rs.next())
	{
		i++;
		if(rs.getString("permission")==null)
		{
		%>
		<input type="hidden" name="sid_<%=rs.getString("userid")%>" value="<%=rs.getString("sid")%>">
		<tr><td height="28"><font face="arial" size="2"><input type="hidden" name="uid_<%=rs.getString("userid")%>" value="<%=rs.getString("userid")%>"><%=rs.getString("userid")%></td>

		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="read">Read</td> 
		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="R/W">R/W</td>
		
		
		<%}
			else{
			String selected="checked";
			%>
		<input type="hidden" name="sid_<%=rs.getString("userid")%>" value="<%=rs.getString("sid")%>">
		<tr><td height="28"><font face="arial" size="2"><input type="hidden" name="uid_<%=rs.getString("userid")%>" value="<%=rs.getString("userid")%>"><%=rs.getString("userid")%></td>
			<%if(rs.getString("permission").equals("read"))
			{
				%>
		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="read" <%=selected%>><font face="arial" color="red">Read</font></font></td> 
		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="R/W">R/W</td>
		<%}else {
					
					%>
		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="read">Read</td> 
		<td height="28"><input type="radio" name="read_<%=rs.getString("userid")%>" value="R/W" <%=selected%>><font face="arial" color="red">R/W</font></td>
		<%
				}
					}
			%><td height="28"><a href="removeshering.jsp?f_path=<%=path%>&sid=<%=rs.getString("sid")%>" style="font-family: times new roman;text-decoration:none;">Remove Sharing</a></td><%
		
					%>
		</tr>
		<%
		}
	
		if(i>0)
		{
			%>
			<tr><td height="28" colspan="2" align="right" width="20%"><input type="submit" value="OK"></td>
			<td height="28" colspan="2" align="left" width="20%"><input type="button" value="Cancel" onclick="javascript:back()"></td></tr>
			<%
		}else{
				%>
				<tr><td colspan="4" height="28"> <font face="Arial" size="3">not available </font></td></tr>
				<%
			}
}
finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
%>
</center>
</table>
</form>
</body>
</html>
