<html>

<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<meta name="generator" content="Namo WebEditor v5.0">
<SCRIPT LANGUAGE="JavaScript">
var contineowin=null;
var chatwindow=null;
var eclassroomwindow=null;
var usermanualwindow=null;
var questionEditorWindow=null;
var teacherCourseMaterialWin=null;
var teacherPrivateDocsWin=null;
function logout(){
	parent.frames['left'].closePopups();
	parent.frames["bottom"].logcookie();
	if(contineowin!=null && !contineowin.closed){
	  //if(!contineowin.closed){
		contineowin.location.href="../../<%=application.getInitParameter("cmsroot")%>/Logout.do";
		contineowin.close();
		//}
	}
	if(chatwindow!=null && !chatwindow.closed)
		chatwindow.close();
	if(eclassroomwindow!=null && !eclassroomwindow.closed)
		eclassroomwindow.close();
	if(usermanualwindow!=null && !usermanualwindow.closed)
		usermanualwindow.close();
	if(questionEditorWindow!=null && !questionEditorWindow.closed)
		questionEditorWindow.close();
	if(teacherCourseMaterialWin!=null && !teacherCourseMaterialWin.closed)
		teacherCourseMaterialWin.close();
	if(teacherPrivateDocsWin!=null && !teacherPrivateDocsWin.closed)
		teacherPrivateDocsWin.close();
	if (document.images){
         parent.location.replace("/LBCOM/common/Logout.jsp");
	}else{
         parent.href = "/LBCOM/common/Logout.jsp";
	}
	//parent.location.href="/LBCOM/common/Logout.jsp";

	return false;
	
}
function usermanual(){
	usermanualwindow=window.open("/LBCOM/manuals/educator_UG/","UserManual","resizable=yes,scrollbars,width=750,height=550,toolbars=no");
}
</SCRIPT>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="0">
    <tr>
        <td width="208" height="24">
            <p><img src="../images/hsn/logo.gif"  border="0" ></p>
        </td>
        <td width="387" height="24" align="right">
		&nbsp;
        </td>
        <TD vAlign=center align=middle width=200>
		<!--
		<font face="sans-serif, Arial" color="#429EDF" size=2 > Live support is temporarily unavailable. </font>
		-->
			<!-- BEGIN Help Center Live Code, ? Michael Bird 2004 -->
				<div id="HCLInitiate" style="position:absolute; z-index:1; top: 40%; left:40%; visibility: hidden;">
					<a href="javascript:initiate_accept()"><img src="//oh.learnbeyond.net/~oh/hcl/inc/skins/default/images/lh/initiate.gif" border="0"></a>
					<a href="javascript:initiate_decline()">
					<img src="//oh.learnbeyond.net/~oh/hcl/inc/skins/default/images/lh/initiate_close.gif" border="0"></a></div>
					<script type="text/javascript" language="javascript" src="//oh.learnbeyond.net/~oh/hcl/lh/live.php?department=Hotschools"></script>
			<!-- END Help Center Live Code, ? Michael Bird 2004 -->
			<!-- BEGIN Help Center Live Code, ? Michael Bird 2004 -->
				<!-- <div id="HCLInitiate" style="position:absolute; z-index:1; top: 40%; left:40%; visibility: hidden;">
					<a href="javascript:initiate_accept()"><img src="//oh.learnbeyond.net/hcl/inc/skins/default/images/lh/initiate.gif" border="0"></a>
					<a href="javascript:initiate_decline()">
					<img src="//oh.learnbeyond.net/hcl/inc/skins/default/images/lh/initiate_close.gif" border="0"></a></div>
					<script type="text/javascript" language="javascript" src="//oh.learnbeyond.net/hcl/lh/live.php?department=Learnbeyond"></script> -->
			<!-- END Help Center Live Code, ? Michael Bird 2004 -->

		</TD>
        <td width="104" height="24" align="center" valign="top">
            <p align="left"><a href="javascript://" onclick="return usermanual();"><img Title="User Manual" src="../images/hsn/umanual.gif" width="81" height="48" border="0"></a></p>
        </td>
        <td width="93" height="24" align="center" valign="top">
            <p align="left"><a href="javascript://" onclick="return logout();"><img Title="Logout" src="../images/hsn/logout.gif" width="59" height="48" border="0"></a></p>
        </td>
    </tr>
    <tr>
        <td width="1004" colspan="5" bgcolor="#A8B8D1">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="1004" colspan="5" bgcolor="#429EDF">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
</body>

</html>