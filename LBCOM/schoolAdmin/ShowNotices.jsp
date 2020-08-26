<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/LBCOM/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<%
	String dirName,schoolId;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean flag=true;
	dirName=request.getParameter("name");                
	schoolId=(String)session.getAttribute("schoolid");
	if(schoolId==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	flag=false;
	try{
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' order by from_date");
%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function count(){                 
	var len=window.document.f1.elements.length;
	var IDS=new Array(len);
	var flag=false;    
	var mess;
	for(var i=0,j=0;i<len;i++){                 
		if(window.document.f1.elements[i].checked==true){                 
			flag=true;                 
			IDS[j]=window.document.f1.elements[i].value;
			j++;
		}                 
	}
	
	if(flag==true){                 
		if(confirm("Are you sure? You want to delete these file(s)"))          window.location.href="/LBCOM/schoolAdmin.DeleteNotice?filenames="+IDS+"&dir=<%=dirName%>";  
	}
	else {                 
		alert('Please select the file(s) you want to delete');                 
		return false;
	}
}
function checks(){
	var win=window.document.f1;
	for(i=0;i<win.nid.length;i++)
		win.nid[i].checked=true;
	return false;
}
function unchecks(){
	var win=window.document.f1;
	for(i=0;i<win.nid.length;i++)
		win.nid[i].checked=false;
	return false;
}
function openMsg(comment,title1){
	var newWin=window.open('','Notice',"resizable=no,toolbars=no,scrollbar=yes,width=350,height=278,top=275,left=300");
	newWin.document.writeln("<html><head><title>"+title1+"</title></head><body><font face='Arial' size=2 color='blue'><u>Description</u></font><br><font face='Arial' size=2>"+comment+"</font></body></html>");
	return false;
}

function openFile(file,msg){
	window.open("PopFrame.jsp?dir=<%=dirName%>&file="+file+"&msg="+escape(msg),'Notice',"resizable=no,toolbars=no,scrollbar=yes,width=650,height=450,top=75,left=100");
	return false;
}
function editFile(notice){
	document.location.href="/LBCOM/schoolAdmin/FileSession.jsp?mode=edit&urlval=<%=dirName%>&notice="+notice;
	return false;
}
function newfile(){
	document.location.href="/LBCOM/schoolAdmin/FileSession.jsp?mode=add&urlval=<%=dirName%>";
	return false;
}
function goback(){
	document.location.href="NoticeBoards.jsp";
	return false;
}

//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<form name="f1">
<center>
  <table border="0" cellpadding="0" cellspacing="1" width="95%" bgcolor="#F2F2F2" align="center">
	<tr bgcolor="#F0B850">
	  <td colspan='5' align='center'><font face="Arial" size="2"><b><%=dirName%>&nbsp;Notice Board Structure</b></font></td>
	</tr>
    <tr bgcolor="#EEE0A1">
      <td width="5%" align="center">&nbsp;</td>
      <td width="5%" align="center">&nbsp;</td>
      <td width="54%"><font face="Arial" size="2">&nbsp;<b>Title</b></font></td>
      <td width="18%" align="center"><font face="Arial" size="2"><b>Open From</td>
      <td width="18%" align="center"><font face="Arial" size="2"><b>Open Upto</td>
    </tr>
	<tr>
		<td colspan='5' align='left'><font face="arial" size=2>
		<a href="javascript://" onclick="return newfile();">Create New</a></td>
	</tr>
<%
	while(rs.next()){
	flag=true;
	String comm=rs.getString("description");
%>
    <tr>
      <td width="3%" align="center"><input type='checkbox' name='nid' value="<%=rs.getString("noticeid")%>"></td>
      <td width="2%" align="center"><a href="javascript://" onclick="return editFile('<%=rs.getString("noticeid")%>');"><img src="images/ROOT.JPG" alt="Edit" border='0'></a></td>
<%
	if(rs.getString("filename").indexOf("null")==-1){
%>
      <td width="54%"><font face="Arial" size="2">&nbsp;<a href="javascript://" onclick="return openFile('<%=rs.getString("filename")%>','<%=common.javastr2javascriptstr(comm)%>')"><%=rs.getString("title")%></a></font></td>
<%
	  }else{		  
%>
	  <td width="54%"><font face="Arial" size="2">&nbsp;<a href="javascript://" onclick="return openMsg('<%=common.javastr2javascriptstr(comm)%>','<%=application.getInitParameter("title")%>')"><%=rs.getString("title")%></a></font></td>
<%}%>
      <td width="18%" align="center"><font face="Arial" size="2"><%=rs.getDate("from_date")%></td>
      <td width="18%" align="center"><font face="Arial" size="2"><%=rs.getDate("to_date")%></td>
    </tr>
<%
	}
}
catch(Exception e){
	ExceptionsFile.postException("ShowNotices.jsp","operations on database","Exception",e.getMessage());
	out.println("Excepiton occured is "+e);
}finally{
		try{
			st.close();
			con1.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowNotices.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
if(flag==false)
	out.println("<tr><td colspan='5' align='center'><font face='Arial' size='2'><b>No Files</td></tr>");
%>
<tr>
	<td colspan='5' align='center'><input type="button" name="delete" value="Delete" onClick="javascript:count();" style="color:black; background-color: #EEE0A1; border-style: solid; border-color: #F0B850">
	<input type="button" name="check" value="CheckAll" onClick="javascript:checks();" style="color:black; background-color: #EEE0A1; border-style: solid; border-color: #F0B850">
	<input type="button" name="uncheck" value="ClearAll" onClick="javascript:unchecks();" style="color:black; background-color: #EEE0A1; border-style: solid; border-color: #F0B850">
	</td>
</tr>
  </table>
</center>
</form>
</body>
</html>