<!--
/**
 * Divides the parent window in to 2 frames
 * first frame is again divided in to 2  vertical forms for displaying the directories in one frame
 * and other is for displaying files in the selected directory
 * second frame contains Ok & Cancel buttons
 */

-->
<%
	String grade=null,subId=null,subjString=null,conGrade=null,idxFile=null;
%>
<%
/*	grade=(String)session.getAttribute("grade");
	subId=request.getParameter("subid");	
	
	if (subId.equals("M")){
		subjString="Math";
		idxFile="MathIndex.html";
	}
	else if (subId.equals("S")){
		subjString="Science";
		idxFile="ScienceIndex.htm";
	}
	else if (subId.equals("L")){
		subjString="LanguageArts";
		idxFile="LanguageArts.htm";
	}
	else if (subId.equals("H")){
		subjString="SocialStudies";
		idxFile="SocialIndex.htm";
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

	*/

%>
<html>
<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="hotschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Content Resources</title>
</head>

	<frameset rows="50,*" frameborder=0 framespacing="1" >
		<frame name="top" src="PerTop.jsp" scrolling=no >
		<frame name="bottom" src="/LBCOM/pc/PerformanceIndex.jsp">
	 </frameset>

  <noframes>
  <body>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

  </frameset> 

</html>
