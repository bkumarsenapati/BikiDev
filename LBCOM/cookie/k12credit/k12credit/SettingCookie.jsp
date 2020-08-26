<%@ page language="java"%>
<%@ page import = "java.sql.*,javax.servlet.http.*"%>
<%
String login="fails";
String schoolId=request.getParameter("schoolid");
String userId=request.getParameter("userid");
String pwd=request.getParameter("password");
String mode=request.getParameter("mode");
String chkStatus=request.getParameter("chk");
login=request.getParameter("auth");
if(schoolId==null)
	schoolId="";
if(userId==null) 
	userId="";
if(pwd==null) 
	pwd="";
if(chkStatus.equals("checked") && login.equals("succ"))
{
	Cookie cookieSchoolId = new Cookie ("schoolid",schoolId);
	Cookie cookieUserId = new Cookie ("userid",userId);
	Cookie cookiePassWord = new Cookie ("password",pwd);
	cookieSchoolId.setMaxAge(60 * 60 * 24 * 7);
	cookieUserId.setMaxAge(60 * 60 * 24 * 7);
	cookiePassWord.setMaxAge(60 * 60 * 24 * 7);
	response.addCookie(cookieSchoolId);
	response.addCookie(cookieUserId);
	response.addCookie(cookiePassWord);
}
if(chkStatus.equals("unchecked"))
{
	Cookie cookieSchoolId = new Cookie ("schoolid",schoolId);
	Cookie cookieUserId = new Cookie ("userid",userId);
	Cookie cookiePassWord = new Cookie ("password",pwd);
	cookieSchoolId.setMaxAge(0);
	cookieUserId.setMaxAge(0);
	cookiePassWord.setMaxAge(0);
	response.addCookie(cookieSchoolId);
	response.addCookie(cookieUserId);
	response.addCookie(cookiePassWord);
}
%>
<html>
<head>
<title>Cookie Saved</title>
</head>
<body>
<%
response.sendRedirect("/LBCOM/ValidateUser?schoolid="+schoolId+"&userid="+userId+"&password="+pwd+"&mode="+mode+"");
%>
<p>
</body>
</html>
