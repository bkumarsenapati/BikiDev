


<%
	String grade=null,subId=null,subjString=null,conGrade=null,idxFile=null;
%>
<%
	grade=(String)session.getAttribute("grade");
	subId=request.getParameter("subid");	
	idxFile=request.getParameter("idxfile");	
	
	if (subId.equals("M")){
		subjString="Math";
	}
	else if (subId.equals("S")){
		subjString="Science";
	}
	else if (subId.equals("L")){
		subjString="LanguageArts";
	}
	else if (subId.equals("H")){
		subjString="SocialStudies";
	}



	if (grade.equals("1stGrade")){
		conGrade="Grade1";
	}
	else if (grade.equals("2ndGrade")){
		conGrade="Grade2";
	}
	else if (grade.equals("3rdGrade")){
				conGrade="Grade3";
	}
	else if (grade.equals("4thGrade")){
				conGrade="Grade4";
	}
	else if (grade.equals("5thGrade")){
				conGrade="Grade5";
	}

	else if (grade.equals("6thGrade")){
				conGrade="Grade6";
	}
	else if (grade.equals("7thGrade")){
				conGrade="Grade7";
	}
	else if (grade.equals("8thGrade")){
				conGrade="Grade8";
	}
	else if (grade.equals("GradeK")){
		conGrade="GradeK";
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
      <td width="100%" valign="middle" align="left" bgcolor="#FBF4EC"><font color="#800000" face="Arial"><b><a href="lcindex.htm" target="_parent"><span style="font-size:10pt;">Learning Center</span></a><span style="font-size:10pt;"> &nbsp;&gt;&gt;&nbsp;</span><a href="LCInner.jsp?subid=<%=subId%>" target="_parent"><span style="font-size:10pt;"><%=subjString%></span></a></b></font><span style="font-size:10pt;"><font face="Arial">  &nbsp;&gt;&gt;&nbsp;<b>
	  <%
	
	if( grade.equals("9thGrade") || grade.equals("10thGrade") || grade.equals("11thGrade")|| grade.equals("9thGrade") ){
	%>

	  <a href="/LBCOM/schools/coursecontent/default.htm" target="bottom">Practice Area</a></b></font></span></td>
	

	<%}else { %>

	  <a href="/LBCOM/schools/coursecontent/<%=conGrade%>/<%=subjString %>/<%=idxFile%>"	  target="bottom">Practice Area</a></b></font></span></td>

	<%}	%>
	  

    </tr>
</table>

</body>

</html>
