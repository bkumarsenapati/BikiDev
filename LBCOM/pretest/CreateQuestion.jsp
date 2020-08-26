<%@page import = "java.sql.*,java.lang.*,java.io.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String qType="";
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest - New Question</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/q_wysiwyg.js"></script> 
<SCRIPT LANGUAGE="JavaScript">

function questionType()
{
	var qtype=document.createquestion.questiontype.value;
	 parent.bottompanel.location.href="CreateQuestion.jsp?qtype="+qtype;
	return false;
}
</script>
</head>

<%
	qType=request.getParameter("qtype");

	if(qType == null)
		qType="mc";
%>

<body>
<form name="createquestion" method="POST" action="AddQuestion.jsp">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="33%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2"><b>&nbsp;Pretest - New Question</b></font></td>
    <td width="33%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="index.jsp">
		<font color="#FFFFFF">Back to Pretest</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="100%" align="center" colspan="2"><hr></td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
	<td width="2%">&nbsp;</td>
	<td width="38%"><font face="Verdana" size="2"color="#934900">&nbsp;<b>Select Question Type :</b></font></td>
    <td width="60%">
	<select size="1" name="questiontype" onchange="questionType(); return false;">
    <option value="mc" selected>Multiple Choice</option>
    <option value="ma">Multiple Answers</option>
    <option value="yn">Yes / No</option>
    <option value="tf">True / False</option>
    <option value="fib">Fill in the Blanks</option>
  <!--   <option value="mtf">Match the Following</option> -->
    <option value="seq">Short or Essay Question</option>
    </select></td>
  </tr>
  </table>
  <script>
	document.createquestion.questiontype.value="<%=qType%>";
</script>
&nbsp;
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="2">&nbsp;</td>
    <td width="98%" colspan="2"><font face="Verdana" size="2" color="#934900">&nbsp;<b>Enter Question Here:</b></font></td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="90%" align="center">
	<textarea name="questionbody" id="questionbody" rows="1" cols="20"></textarea>
	<script language="JavaScript">
		generate_wysiwyg('questionbody');
	</script>
	</td>
    <td width="5%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" width="100%">&nbsp;</td>
  </tr>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <%
	if(qType.equals("fib"))
	{
%>
	<tr>
    <td width="2%">&nbsp;</td>
    <td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Enter answer(s) here :</font></b></td>
  </tr>
  <%}else{%>

  <tr>
    <td width="2%">&nbsp;</td>
    <td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Enter options here :</font></b></td>
  </tr>
  <%}%>
  </table>

<%
	if(qType.equals("mc"))
	{
%>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="4%"><input type="radio" value="option1" name="mchoice"><font size="2" face="Verdana">A</font></td>
    <td width="40%" align="left"><textarea rows="2" name="option1" cols="20"></textarea></td>
    <td width="6%">&nbsp;</td>
    <td width="4%"><input type="radio" value="option2" name="mchoice"><font size="2" face="Verdana">B</font></td>
    <td width="25%" align="left"><textarea rows="2" name="option2" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td>
  </tr>
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="4%"><input type="radio" value="option3" name="mchoice"><font size="2" face="Verdana">C</font></td>
    <td width="40%" align="left"><textarea rows="2" name="option3" cols="20"></textarea></td>
    <td width="6%">&nbsp;</td>
    <td width="4%"><input type="radio" value="option4" name="mchoice"><font size="2" face="Verdana">D</font></td>
    <td width="25%" align="left"><textarea rows="2" name="option4" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td>
  </tr>
  </table>
<%
	}
	else if(qType.equals("ma"))
	{
%>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="4%"><input type="checkbox" name="a" value="option1"><font size="2" face="Verdana">A</font></td>
    <td width="40%" align="left"><textarea rows="2" name="option1" cols="20"></textarea></td>
    <td width="6%">&nbsp;</td>
    <td width="4%"><input type="checkbox" name="b" value="option2"><font size="2" face="Verdana">B</font></td>
    <td width="25%" align="left"><textarea rows="2" name="option2" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td>
  </tr>
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="4%"><input type="checkbox" name="c" value="option3"><font size="2" face="Verdana">C</font></td>
    <td width="40%" align="left"><textarea rows="2" name="option3" cols="20"></textarea></td>
    <td width="6%">&nbsp;</td>
    <td width="4%"><input type="checkbox" name="d" value="option4"><font size="2" face="Verdana">D</font></td>
    <td width="25%" align="left"><textarea rows="2" name="option4" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td>
  </tr>
  </table>
<%
	}
	else if(qType.equals("yn"))
	{
%>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="25%"><font face="Verdana">
    <input type="radio" value="option1" name="yesorno"><font size="2">Yes</font></font></td>
    <td width="65%"><font face="Verdana">
    <input type="radio" value="option2" name="yesorno"><font size="2"> No</font></font></td>
  </tr>
  </table>
<%
	}
	else if(qType.equals("tf"))
	{
%>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="25%"><font face="Verdana">
    <input type="radio" value="option1" name="trueorfalse"><font size="2">True</font></font></td>
    <td width="65%">
    <p align="left"><font face="Verdana">
    <input type="radio" value="option2" name="trueorfalse"><font size="2">False</font></font></td>
  </tr>
  </table>
<%
	}
	if(qType.equals("fib"))
	{
%>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
   <!--  <td width="3%">&nbsp;</td> -->
    <td width="4%">&nbsp;</td>
    <td width="40%" align="left" colspan="2"><textarea rows="2" name="option1" cols="20"></textarea></td>
    <!-- <td width="6%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
    <td width="25%" align="left"><textarea rows="2" name="option2" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td> -->
  </tr>
 <!--  <tr>
    <td width="8%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
    <td width="40%" align="left"><textarea rows="2" name="option3" cols="20"></textarea></td>
    <td width="6%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
    <td width="25%" align="left"><textarea rows="2" name="option4" cols="20"></textarea></td>
    <td width="66%">&nbsp;</td>
  </tr> -->
  </table>
<%
	}
	else if(qType.equals("mtf"))
	{
%>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="90%">
    <font face="Verdana" size="1" color="red">This question is not supported presently. It will be added soon.............</font></td>
    <td width="5%">&nbsp;</td>
  </tr>
  </table>
<%
	}
	else if(qType.equals("seq"))
	{
%>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="90%"><font face="Verdana" size="1" color="red">This will not have any options.</font></td>
    <td width="5%">&nbsp;</td>
  </tr>
  </table>
<%
	}	
%>

  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="100%">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" align="center">
		<input type="submit" value="Submit" name="B1">&nbsp;&nbsp;
		<input type="reset" value="Reset" name="B2"></td>
  </tr>
  <tr>
    <td width="100%">&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>