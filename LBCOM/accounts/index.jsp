<html>

<head>

<title>Login page</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="Authentication of valid users">

<script language='javascript' >

function validate(loginform)
{
  if(loginform.userid.value=="")   { alert('Enter User Name'); loginform.userid.focus();  return false;}
  
  if(loginform.pw.value=="")       { alert('Enter Password');  loginform.pw.focus(); return false;}
  
  if(loginform.pw.value.length<6)  { alert('Enter At least 6 characters '); loginform.pw.focus(); return false;}
  
  if(loginform.pw.value.length>10) { alert('Enter upto 10 characters only'); loginform.pw.focus(); return false;}
  
  return true;
}

</script>
</head>

<body onload="document.loginform.userid.focus()">
 <p>&nbsp;</p>	<p>&nbsp; </p>	<p>&nbsp;</p>
<form	name='loginform' action='ValidateUser.jsp' onsubmit="return validate(this)">
 <div align="center">
  <table border="0" cellpadding="3" cellspacing="1" width="40%" height="30%">  					 
      <tr>
      
          <td width="428" align="right">
              <span style="font-size:9pt;"> <font face="Arial"><b>User Name</b></font></span>
		  </td>
			        
          <td width="428" align="left">
              <span style="font-size:9pt;"><font face="Arial"><b>&nbsp;</b></font></span><input type="text" name="userid" size="12" >
          </td>
      </tr>

      <tr>
			    
          <td width="428" align="right">
          	  <span style="font-size:9pt;"><font face="Arial"><b> Password   &nbsp;</b></font></span>
      	  </td>
				    
          <td width="428" align="left">
           	  <span style="font-size:9pt;"> &nbsp;</span><input type="password" name="pwd" size="12" >			         
  		 </td>
     </tr>             
		
     <tr>
				    	
        <td width="428" valign="bottom">
            <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
        </td>		    			
        <td width="428" valign="bottom" align="left"> &nbsp;
            <input type='image' src="images/login.gif" width="71" height="24" border="0" alt="Login" name="I1"   >
        </td>
    </tr>
                   
  </table>
 </div>
</form>
	
</body>

</html>