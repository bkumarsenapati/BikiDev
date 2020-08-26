<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Think-And-Learn [Learner Cerntet]</title>
<LINK HREF="images/lc/style.css" TYPE="text/css" REL="stylesheet">  
<style type="text/css">
<!--
.style3 {
	color: #663333;
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
</head>

<%

	String subId=request.getParameter("subid");
	String subjString="";
	String conRes="";
	String grade;

	grade=(String)session.getAttribute("grade");

	
	if (subId.equals("M")){
		subjString="Math";
		conRes="mathlinks.htm";
	}
	else if (subId.equals("S")){
		subjString="Science";
		conRes="sciencelinks.htm";
	}
	else if (subId.equals("L")){
		subjString="Language Arts";
		conRes="lalinks.htm";
	}
	else if (subId.equals("H")){
		subjString="Social Studies";
		conRes="sslinks.htm";
	}
	
	if (!grade.equals("3rdGrade")){
		conRes="default.htm";
	}

	session.putValue("subjstr",subjString);
	session.putValue("subjid",subId);


%>
<body class="body" topmargin="3" leftmargin="3">

<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#FBF4EC"><a href="lcindex.htm">Learning Center</a> <font size=1>&nbsp;<B>>></B>&nbsp;</font><%= subjString%></font></td>
    </tr>
</table>

<table width="500" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="6%" height="361" align="center" valign="top"><p>            <img src="images/lc/icon_01.gif" width="32" height="32"></p>
          </td>
        <td width="94%" valign="top"><br>
          <br>
          <table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFF2E7">
          <tr>
            <td ><span class="style3"><%=subjString %></span></td>
          </tr>
        </table>
          <table width="100%"  border="0" cellpadding="4" cellspacing="0">
            <tr>
              <td width="3" rowspan="8" class="v-dot">&nbsp;</td>
              <td width="187">&nbsp;</td>
              <td width="32" height="39">&nbsp;</td>
              <td width="12" rowspan="5" class="v-line">&nbsp;</td>
              <td width="194">&nbsp;</td>
              </tr>
            <tr>
              <td rowspan="7" align="left" valign="top"><img src="images/lc/math_01.gif" width="173" height="200"></td>
              <td height="30" align="right" valign="bottom"><img src="images/lc/ic-cr.gif" width="32" height="32"></td>
              <td valign="bottom" class="dot"><a href="/LBCOM/lc/LCTopic.jsp">Content Resources </a></td>
              </tr>
            <tr>
              <td align="right" valign="bottom"><img src="images/lc/ic-tt.gif" width="32" height="32"></td>
              <td valign="bottom" class="dot"><a href="TutorialsFrame.jsp?subid=<%=subId%>">Tutorials</a></td>
              </tr>
            <tr>
              <td align="right" valign="bottom"><img src="images/lc/ic-pa.gif" width="32" height="32"></td>
              <td valign="bottom" class="dot"><a href="PAFrames.jsp?subid=<%=subId%>">Practice Area </a></td>
              </tr>
            <tr>
              <td align="right" valign="bottom"><img src="images/lc/ic-st.gif" width="32" height="32"></td>

			  <td valign="bottom" class="dot"><a href="/LBCOM/pc/PracticeTopic.jsp">Make your own test </a></td>

              </tr>
            <tr>
              <td height="32" align="right" valign="bottom"><img src="images/lc/ic-st.gif" width="32" height="32"></td>
              <td class="v-line">&nbsp;</td>
              <td valign="bottom" ><span class="dot"><a href="PerfomanceFrames.jsp">Check your performance</a></span></td>
            </tr>
            <tr>
              <td height="70" align="right">&nbsp;</td>
              <td class="v-line">&nbsp;</td>
              <td valign="bottom" >&nbsp;</td>
              </tr>
            <tr>
              <td height="26" align="right">&nbsp;</td>
              <td valign="top" ><img src="images/lc/arrow.gif" width="12" height="15"></td>
              <td valign="bottom" >&nbsp;</td>
              </tr>
          </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
