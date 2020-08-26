
<%@ page language="java" import="java.util.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
//session=request.getSession();
String schoolid =(String)session.getAttribute("schoolid");
String classid = request.getParameter("classid");
String courseid = request.getParameter("courseid");
String classname = request.getParameter("classname");
String coursename = request.getParameter("coursename");
String teacherid = request.getParameter("teacherid");
String topicid="none";
String subtopicid="none";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <!--<base href="">-->
   
    <title>My JSP 'frame2.jsp' starting page</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
	<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
<script language="javascript" >
function check(){
  var rrfile = document.quesimport.rfile.value;
  var rrtitle = document.quesimport.title.value;
  if ((rrtitle=="")||(rrtitle==null)){
			alert("Please enter Package title ");
			document.quesimport.title.focus();
			return false;
		}
	if ((rrfile=="")||(rrfile==null)){
			alert("select the file to import");
			document.quesimport.rfile.focus();
			return false;
		}else if ((rrfile.indexOf('.zip')==-1)&&(rrfile.indexOf('.dat')==-1)){
			alert("select the zip/dat file to import");
			document.quesimport.rfile.focus();
			return false;
		}
	loding();
	return true;
}
</script>
    
</head>
 <DIV id=loading  style='WIDTH:100%;height:100%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;visibility:hidden'><IMG src="/LBCOM/common/images/loading.gif" border=0></DIV>
  <body>
	<form name="quesimport" method="post" enctype="multipart/form-data"  action="/LBCOM/importutility.uploadzip?schoolid=<%=schoolid%>&classid=<%=classid%>&classname=<%=classname%>&courseid=<%=courseid%>&coursename=<%=coursename%>&teacherid=<%=teacherid%>">
		<table align = center>
			<tr><td><font face=Arial size=3 >Package title :</font></td><td><INPUT maxlength=50 type=text name=title></td></tr>
			<tr><td><font face=Arial size=3>File to import :</font></td><td><INPUT type=file name=rfile></td></tr>
		</table>
		<br><center><input type=submit  value='Submit' onclick ="return check();">&nbsp;<input type='button' onclick='history.go(-1)' value=' Back '></center>
	</form>
  </body>
</html>
