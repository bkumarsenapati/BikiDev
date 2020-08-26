<html>
<head>
<title>Learnbeyond Course Builder</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="Authentication of valid users">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table id="Table_01" width="100%" height="101" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="304" background="images/lb_coursedev_bg.gif">
            <p align="left">			<img src="images/lb_coursedev.gif" width="304" height="101" alt=""></p>
        </td>
        <td width="100%" background="images/lb_coursedev_bg.gif">
			&nbsp;</td>
        <td width="284" background="images/lb_coursedev_bg.gif">
            <p align="right">			<img src="images/lb_coursedev_maho.gif" width="300" height="101" alt=""></p>
        </td>
    </tr>
</table>

<body onload="document.loginform.userid.focus()">
<p>&nbsp;</p>
<form	name='loginform' method="post" action='ValidateUser.jsp' onsubmit="return validate(this)">
 <div align="center">
  <table border="0" cellpadding="3" cellspacing="1" width="40%" height="30%">  					 
      <tr>
      
          <td width="428" align="right">
              <span style="font-size:9pt;"> <font face="Arial"><b>User Name</b></font></span>
		  </td>
			        
          <td width="428" align="left">
              <span style="font-size:9pt;"><font face="Arial"><b>&nbsp;</b></font></span><input type="text" name="userid" value="developer" size="24">
          </td>
      </tr>

      <tr>
			    
          <td width="428" align="right">
          	  <span style="font-size:9pt;"><font face="Arial"><b> Password   &nbsp;</b></font></span>
      	  </td>
				    
          <td width="428" align="left">
           	  <span style="font-size:9pt;"> &nbsp;</span><input type="password" name="pwd" value="1q2w3e4r" size="24">			         
  		 </td>
     </tr>             
		
     <tr>
				    	
        <td width="428" valign="bottom">
            
        </td>		    			
        <td width="428" valign="bottom" align="left"> &nbsp;
            <input type='image' src="images/login.gif" width="71" height="24" border="0" alt="Login" name="I1">
        </td>
    </tr>
                   
  </table>
 </div>
</form>
</body>

