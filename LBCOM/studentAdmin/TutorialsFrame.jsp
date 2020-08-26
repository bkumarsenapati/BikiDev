<!--
/**
 * Divides the parent window in to 2 frames
 * first frame is again divided in to 2  vertical forms for displaying the directories in one frame
 * and other is for displaying files in the selected directory
 * second frame contains Ok & Cancel buttons
 */

-->
<%
	String grade=null,subjId=null,subjStr=null,idxFile=null;
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
	

/*	if (grade.equals("1stGrade")){
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
	} */
%>

<html>
<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotsschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Content Resources</title>
</head>

	<frameset rows="50,*" frameborder=0 framespacing="1" >
		<frame name="top" src="TutTop.jsp" scrolling=no >
	    <frame name="bottom" src="/LBCOM/schools/tutorials/<%=idxFile%>">
	 </frameset>

  <noframes>
  <body>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

  </frameset> 

</html>
