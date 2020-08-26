<%!

private String username ="";
private String schoolid ="";
private String fname = "";
private String lname = "";
private String country1 ="";
private String email="";


%>
<%
username = request.getParameter("username").toLowerCase();
schoolid = request.getParameter("schoolid").toLowerCase();
fname = request.getParameter("firstname");
lname = request.getParameter("lastname");
country1 = request.getParameter("country");
email=username+"@"+schoolid;
System.out.println("Email :"+email);
%>

<html>
    <head>    	
    	     	
		
        <link rel="stylesheet" href="sts.css" type="text/css"/>
        <title>
            My Profile - WebHuddle
        </title>  
        
        <base href="https://192.168.1.116:8443/profilepage.jsp">
    </head>
    <body bgcolor="#FFFFFF" >
        <a name="top"></a>

<table width="640" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>
      <td width="390" height="75" border="0"><br/><br/><img
          alt="" src="../images/logo1.gif" border="0"/>
      </td>
      
    </tr>
    <tr align="right">
        
	        <td colspan="2">
	            <a class="WHMENU" href="https://192.168.1.116:8443/enterroom.do?action=setToken">Join Meeting</a>
	            |
	            <!-- <a class="WHMENU" href="logon.do?action=setToken">Logon</a>
	            |-->
	            <!-- 
	            	
				    
						    <a href="/editProfile.do?action=Create" class="WHMENU">Register</a>
				|
				    
	            
	            <a class="WHMENU" href="aboutpage.jsp">About</a> -->
	        </td>
	        <td colspan="3">
	        </td>
	    
	       
    
    </tr>    
  </tbody>
</table>
<form name="profileForm" method="post" action="https://192.168.1.116:8443/saveProfile.do">
<input type="hidden" name="action" value="Create">
<table width="640" cellspacing="5" cellpadding="5" border="0" align="center">
  <tr>
    <td colspan="2">
      
    </td>
  </tr>
  <tr>
    <th align="right">
      <P>First Name</P>
    </th>
    <td align="left">
      <input type="text" name="firstName" size="16" value="<%=fname%>">
    </td>
  </tr>
  <tr>
    <th align="right">
      <P>Last Name</P>
    </th>
    <td align="left">
      <input type="text" name="lastName" size="16" value="<%=lname%>">
    </td>
  </tr>
  <tr>
    <th align="right">
      <P>Email Address</P>
    </th>
    <td align="left">
      <input type="text" name="email" size="24" value="<%=email%>">
    </td>
  </tr>

  <tr>
    <th align="right">
      <P>Country (2-letter)</P>
    </th>
    <td align="left">
      <input type="text" name="country" size="2" value="<%=country1%>">
    </td>
  </tr>
</table>
</form>

<table width="640" cellspacing="0" cellpadding="0" border="0" align="center">
    <tr>
      <td>&nbsp;
      </td>
    </tr>
</table>
  
    </body>
</html>
<script> document.forms[0].submit(); </script>
