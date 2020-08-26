<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	public String check4Opostrophe(String str){
 str=str.replaceAll("\'","\\\\\'");
 return(str);
}
%>
<%
String userName="",schoolId="",nbName="",nbDesc="",creator="",teacherId="",bgClr1="",bgClr2="";
Connection con=null;
ResultSet rs=null,rs1=null;
Statement st=null,st1=null;
int totCount=0,totActive=0;
%>
<head>
<title><%=application.getInitParameter("title")%></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript">
<!--
function creates(mode,oldname,desc,creator)
{
	document.location.href="CreateNoticeBoard.jsp?mode="+mode+"&oldname="+oldname+"&creator="+creator+"&desc="+desc+"";
	return false;
}
function showcomments(comment,title1){
	var newWin=window.open('','Description',"resizable=no,toolbars=no,scrollbar=yes,width=225,height=170,top=275,left=300");
	newWin.document.writeln("<html><head><title>"+title1+"</title></head><body><font face='Arial' size=2 color='blue'><u>Description</u></font><br><font face='Arial' size=2>"+comment+"</font></body></html>");
	return false;
}
function selectall(cnt){
	var frm=document.form1;
	if(cnt.checked==true)
		for(i=0;i<frm.elements.length;i++)
			frm.elements[i].checked=true;
	else
		for(i=0;i<frm.elements.length;i++)
			frm.elements[i].checked=false;
}
function shownotice(name)
{
	document.location.href="ShowNotices.jsp?name="+name;
	return false;
}
function deletes(){
	var frm=document.form1;
	var c=0;
	for(i=0;i<frm.elements.length;i++)
		if(frm.elements[i].checked)
			c=1;
	if(c==0)
	{
		alert("Please select a Notice Board to delete.")
		return false;
	}
	else
	{
		if(!confirm("Are you sure that you want to delete the selected Notice Board(s)?"))
			return false;
	}
}
//-->
</SCRIPT>
</head>
<%

try
{
	userName="admin";
	schoolId=(String)session.getAttribute("schoolid");
	if(schoolId==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	con = con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	creator=request.getParameter("creator");
	if(creator.equals("admin"))
	{
		rs=st.executeQuery("select *,DATE_FORMAT(created_date,'%m/%d/%Y') as cdate from notice_boards where schoolid='"+schoolId+"' and teacherid='admin' order by created_date");
	}
	else if(creator.equals("teacher"))
	{
			teacherId=(String)session.getAttribute("emailid");
			rs=st.executeQuery("select *,DATE_FORMAT(created_date,'%m/%d/%Y') as cdate from notice_boards where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' order by created_date");
	}

	if(!rs.next())
	{
		out.println("<center><font face='Arial' size='2'><b>No Notice Boards Available.<br>Create one.<a href=\"javascript://\" onclick=\"return creates('add','','','"+creator+"');\"><img src='images/create1.gif' border='0'></a></center>");
		return;
	}
	else
		rs.beforeFirst();
%>
<body bgcolor="#F2F2F2">

<form name="form1" action="/LBCOM/nboards.DelNoticeBoard?creator=<%=creator%>" method="post">
<center>
<%
	if(creator.equals("admin"))
	{
		bgClr1="#f0b850";
		bgClr2="#eee0a1";
	}
	else if(creator.equals("teacher"))
	{
		bgClr1="#429EDF";
		bgClr2="#A8B8D1";
	}
%>
<table border="0" cellpadding="0" cellspacing="1" width="100%">
	<tr>
		<td colspan='7' align='center' bgcolor="<%=bgClr1%>" height='21'>
			<font face="Arial" size="2"><b>Notice Boards in your School</td>
	</tr>
    <tr  bgcolor="<%=bgClr2%>">
      <td width="3%" align="center">
		<input type='checkbox' onclick="return selectall(this);"></td>
      <td width="5%" align="center">&nbsp;</td>
      <td width="5%" align="center">&nbsp;</td>
      <td width="35%" align="center">
		<font face="Arial" size="2"><b>Notice Board Name</b></font></td>
      <td width="17%" align="center">
		<font face="Arial" size="2"><b>Date Created</b></font></td>
      <td width="18%" align="center">
		<font face="Arial" size="2"><b>Total Notices</b></font></td>
      <td width="17%" align="center">
		<font face="Arial" size="2"><b>Active Notices</b></font></td>
    </tr>
<%
	while(rs.next())
	{
		nbName=rs.getString("nboard_name");
		nbDesc=rs.getString("description");
		totActive=totCount=0;
		rs1=st1.executeQuery("select count(*) as c from notice_master where schoolid='"+schoolId+"' and dirname='"+nbName+"'");		
		if(rs1.next())
			totCount=rs1.getInt("c");		
		rs1=st1.executeQuery("select count(*) as c from notice_master where schoolid='"+schoolId+"' and dirname='"+nbName+"' and to_date>=curdate()");
		if(rs1.next())
			totActive=rs1.getInt("c");
%>
    <tr>
      <td width="3%" align="center" bgcolor="#E0DFDA">
		<input type='checkbox' name='nboard' value='<%=nbName%>'></td>
      <td width="5%" align="center" bgcolor="#E7E7E7">
		<a href="javascript://" onclick="return creates('edit','<%=nbName%>','<%=check4Opostrophe(nbDesc)%>','<%=creator%>');">
		<img src='images/idedit.gif' border='0' TITLE='Edit'></a></td>
      <td width="5%" align="center" bgcolor="#E0DFDA">
		<a href="javascript://" onclick="return showcomments('<%=check4Opostrophe(nbDesc)%>','<%=application.getInitParameter("title")%>');">
		<img src='images/idview.gif' border='0' TITLE='View Description'></a></td>
      <td width="35%" bgcolor="#E0DFDA">
		<font face='Arial' size='2'><!--<a href="javascript://" onclick="return shownotice('<%=nbName%>');">--><%=nbName%></td>
      <td width="17%" align="center" bgcolor="#E0DFDA">
		<font face='Arial' size='2'><%=rs.getString("cdate")%></td>
      <td width="18%" align="center" bgcolor="#E0DFDA">
		<font face='Arial' size='2'><%=totCount%></td>
      <td width="17%" align="center" bgcolor="#E0DFDA">
		<font face='Arial' size='2'><%=totActive%></td>
    </tr>
<%
			}
%>
  </table>
	<p>
	 
	 <input type="button" name="create" value="Create" onclick="javascript:creates('add','','','<%=creator%>');" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>">&nbsp;&nbsp;
	 <input type="submit" name="delete" value="Delete" onclick="javascript:return deletes();" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>">
	</center>
	</form>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("NoticeBoard.jsp","Operations on database ","Exception",e.getMessage());
	out.println("Exception occured is "+e);
}
finally
{
	try
	{
		if(con!=null)
			con.close();
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("NoticeBoard.jsp","closing statement and connection objects","Exception",e.getMessage());
	}
}
%>
</body>
</html>
