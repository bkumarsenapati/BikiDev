<%
	String grade=null,subjId=null,subjStr=null,conGrade=null,idxFile=null;
%>
<%
	grade=(String)session.getAttribute("grade");

	subjId=(String)session.getAttribute("subjid");
	subjStr=(String)session.getAttribute("subjstr");

	if (grade.equals("3rdGrade")){

		if (subjId.equals("M")){
			idxFile="Grade3/math/index.htm";
		}
		else if (subjId.equals("S")){
			idxFile="Grade3/science/index.html";
		}
		else if (subjId.equals("L")){
			idxFile="Grade3/languagearts/index.htm";
		}
		else if (subjId.equals("H")){
			idxFile="Grade3/social/index.htm";
		}
	}
	else if (grade.equals("5thGrade")){
		if (subjId.equals("S")){
			idxFile="Grade5/science/index.html";
		}else{
			idxFile="default.htm";
		}

	}else{
		idxFile="default.htm";
	}
	
%>

<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">

</head>

<body topmargin="3" leftmargin="3">
<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#FBF4EC"><font color="#800000" face="Arial"><b><a href="lcindex.htm" target="_parent"><span style="font-size:10pt;">Learning Center</span></a><span style="font-size:10pt;"> &nbsp;&gt;&gt;&nbsp;</span><a href="LCInner.jsp?subid=<%=subjId%>" target="_parent"><span style="font-size:10pt;"><%=subjStr%></span></a></b></font><span style="font-size:10pt;"><font face="Arial">  &nbsp;&gt;&gt;&nbsp;<b><a href="/LBCOM/schools/tutorials/<%=idxFile%>" target="bottom">Tutorials</a></b></font></span></td>
    </tr>
</table>

</body>

</html>
