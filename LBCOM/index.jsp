<%
response.sendRedirect("/LBCOM/session/");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="css/Learnbeyond-login.css">

<head>
<meta charset="utf-8">
<title>Learnbeyond</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="Responsive HTML template for Your company" name="description">
<meta content=" " name="author">
</head>
<body onload="popupsCheck(); return false;">
<div class="navbar navbar-fixed-top">
<div class="navbar-inner">
<div class="container">

<a class="brand" href="/LBCOM/">
<img alt="Learnbeyond" src="/LBCOM/session/images/logo.png">
</a>
</div>
</div>
</div>
<div class="container">
<div id="login-wraper">
<form name="homepage" method="post" id="homepage" class="form login-form" onSubmit="validate();return false;">

<legend>
<span class="blue"><!-- Learnbeyond --></span><BR><BR><BR>
</legend>
<div class="body">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-success" onclick="goStaff(); return false;">Staff</button>&nbsp;&nbsp;<button class="btn btn-success" onclick="goStudent(); return false;">Student</button>&nbsp;&nbsp;<button class="btn btn-success" onclick="goParent(); return false;">Parent</button>
</div>
<div class="footer">
<label class="checkbox inline">
<!-- <input id="inlineCheckbox1" type="checkbox" value="option1"> -->

</label>

</div>

</form>
</div>
</div>
<footer class="white navbar-fixed-bottom">
<!-- Note: Your User Id is your Admission number.--><BR> 
</footer>

<div class="backstretch" style="left: 0px; top: 0px; overflow: hidden; margin: 0px; padding: 0px; height: 74px; width: 1349px; z-index: -999999; position: fixed;">
<img style="position: absolute; margin: 0px; padding: 0px; border: medium none; width: 1349px; height: 758.442px; max-width: none; z-index: -999999; left: 0px; top: -342.221px;" src="images/bg3.png" class="deleteable">
<img style="position: absolute; margin: 0px; padding: 0px; border: medium none; width: 1349px; height: 758.442px; max-width: none; z-index: -999999; left: 0px; top: -342.221px; opacity: 0.0690969;" src="images/bg4.png">
</div>
<script>
function goStaff() {
    window.location.replace("http://candor.learnbeyond.com:8080/LBCOM/session/");
}
function goStudent() {
    window.location.assign("http://candor.learnbeyond.com:8080/LBCOM/session/");
}
function goParent() {
    window.location.assign("http://candor.learnbeyond.com/sms/");
}
</script>
</body>
</html>