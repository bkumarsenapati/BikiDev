<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@ page import="java.io.*,java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
 <HEAD>
  <TITLE> New Document </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
	<LINK Rel="stylesheet" Href="../CSS/mainpage.css" Type="text/css"> 
	<script language="javascript">
		function cc()
		{
			window.location.href="list.jsp";
		}
		</script>
 </HEAD>
 <%!
 private String fileName="";
 private String msg="";
 private String path="",context_path="",folder_path="";
 private Connection con=null;
private Statement st=null;
private DbBean bean;
 %>
<%
msg="";
bean=new DbBean();
fileName=request.getParameter("f_name");
con=bean.getConnection();
	st=con.createStatement();
	st.executeUpdate("update shared_data set status='false' where filename='"+fileName.replace('\\','/')+"'");
	
	if(st!=null)
		st.close();
	if(con!=null)
		con.close();


try{
	context_path=application.getInitParameter("app_path");
	//folder_path=""+context_path+"\\WEB-INF\\textfiles\\"+fileName;
	String new_path=session.getAttribute("r_path").toString();
	folder_path=new_path+"/"+fileName;

if(request.getParameter("mode")!=null)
{
	
	folder_path=fileName;
	File text_path=new File(fileName);
	
	FileInputStream fis=new FileInputStream(text_path);
	byte b[]=new byte[fis.available()];
	fis.read(b);
	fis.close();
	msg=new String(b);
}
%>
 <BODY>
 <form name="form" method="post" action="../../TextFile"><br><br><br>
 <input type="hidden" name="f_name" value="<%=folder_path%>">
 <input type="hidden" name="mode" value="<%=request.getParameter("mode")%>">
 <table width="100%" height="200">	
	<tr>
		<td width="50%">Enter Message </td>
	</tr>
	<tr>
		<td width="50%" height="40%"><textarea name="msg" rows="12" cols="70">
		<%=msg.trim()%>
		</textarea> </td>
	</tr>
	
	<tr>
		<td width="50%" height="10%"><input type="submit" value="Save" width="30">
		<!-- <input type="button" value="Cancel" width="30" onclick="cc()"> -->
		
		</td>
	</tr>
 </table>
 </form>
  <%}catch(Exception exp)
  {
	exp.printStackTrace();}
		%>
 </BODY>
</HTML>
