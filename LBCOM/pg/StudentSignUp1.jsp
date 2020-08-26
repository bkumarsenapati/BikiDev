<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title></title>
<meta name="generator" content="Microsoft FrontPage 6.0">


									<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script type="text/javascript">
                 $(document).ready(function () {
                    $('#id_radio1').click(function () {
                       $('#div1').show();
                       $('#div2').hide();
                });
                $('#id_radio2').click(function () {
                      $('#div1').show();
                      $('#div2').show();
                 });
               });
</script>
      				 


</head>

<body >




			 
		
			 <input type="radio"  value="er" id="id_radio1" checked="checked" name="enroll" >&nbsp;Enrichment enrollment&nbsp;&nbsp;
			 <input type="radio" id="id_radio2" value="cr" name="enroll">&nbsp;CreditRecovery enrollment&nbsp;
			 


		<div id="div1" >
  
		     
   				 
  
Name on the Card: 

  
    </div>
			

					
					  	
	<div id="div2" width="100%" border="0" cellspacing="0" cellpadding="0">
	<input type="text" name="fname">
	<strong>Credit Card Number: </strong>
	

																	             

		 

       
 </div>



</body>


</html>
