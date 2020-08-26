<%@ page language="java" contentType="text/html" import = "java.io.*" import  = 'com.oreilly.servlet.*' %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import="java.util.*,utility.FileUtility,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String schoolId="",sessid="",logoName=""; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean flag=false;
	int j=0;
%>

<% 
    
    try
    {	

			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			

			con=con1.getConnection();
			st=con.createStatement();
			schoolId = (String)session.getAttribute("schoolid");
			
		rs=st.executeQuery("select * from cobrand_logo where school_id='"+schoolId+"'");
		 if(rs.next())
		{
			logoName=rs.getString("logo_name");
			flag=true;
			
		}
		if(flag==false)
		{
			logoName="facility_logo.JPG";

		}
		
		rs.close();
		     
    }
	catch(Exception e)
	{
		
		ExceptionsFile.postException("top.jsp"," uploading","Exception",e.getMessage());
				
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
					
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of top.jsp : pretest -"+se.getMessage());
		}
	}
%>

<html>

<head>
<title>.:: Welcome to www.Learnbeyond.net ::. [ Learning Redefined ]</title>
<meta name="generator" content="Namo WebEditor">
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
	usermanualwindow=window.open("/LBCOM/manuals/educator_UG/","UserManual","resizable=yes,scrollbars,toolbars=no");
}
</SCRIPT>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="90">
    <tr>
        <td height="50" width="100%">
            <p><img src="../images/hsn/logo.gif"  border="0"></p>
        </td>
        <td height="50" align="right" width="100%">
            <p align="left">&nbsp;</p>
        </td>
        <td height="50" align="right" valign="top" width="100%">
<img src="../images/hsn/<%=logoName%>" width="219" height="50" border="0" title="<%=schoolId%>"></td>
    </tr>
    <tr>
        <td width="100%" colspan="3" height="6" bgcolor="#A8B8D1">
           
        </td>
    </tr>
    <tr>
        <td bgcolor="#429EDF" height="24">
            <p><font face="Arial"><span style="font-size:10pt;">&nbsp;</span></font><span style="font-size:10pt;"><font face="Arial" color="white"><!-- <b>Welcome : </b>User Name --> </font></span></p>
        </td>
        <td width="380" height="24" bgcolor="#429EDF">&nbsp;</td>
        <td width="616" height="24" bgcolor="#429EDF">            <div align="right">

            <table border="0" cellpadding="0" cellspacing="0" width="50%">
                <tr>
                    <td width="33"><div id="HCLInitiate" style="position:absolute; z-index:1; top: 40%; left:40%; visibility: hidden;">
					<a href="javascript:initiate_accept()"><img src="//oh.learnbeyond.net/~oh/hcl/inc/skins/default/images/lh/initiate.gif" border="0"></a>
					<a href="javascript:initiate_decline()">
					<img src="//oh.learnbeyond.net/~oh/hcl/inc/skins/default/images/lh/initiate_close.gif" border="0"></a></div>
					<script type="text/javascript" language="javascript" src="//oh.learnbeyond.net/~oh/hcl/lh/live.php?department=Hotschools"></script></td>
                    <td width="33"><a href="javascript://" onclick="return usermanual();"><img src="../images/hsn/Usermanuals.gif" width="147" height="28" border="0"></a></td>
                    <td width="52"><a href="javascript://" onclick="return logout();"><img src="../images/hsn/logout.gif" width="105" height="28" border="0"></a></td>
                        <td width="52">&nbsp;</td>
                </tr>
            </table>
            </div>
        </td>
    </tr>
	  <tr>
        <td width="1004" colspan="5" bgcolor="#546878"> &nbsp;           
            <iframe name="usage" width="0" height="0"></iframe>
        </td>
    </tr>
</table>
</body>

</html>
