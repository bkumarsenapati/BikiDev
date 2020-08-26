<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
     	String studentId="",studentName="",courseId="",workId="",docType="";
	String maxMarks="",marks="",tableName="",attempt="",url="";
%>
<%
	try{
        	session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
	   studentId=request.getParameter("studentid");
	   studentName=request.getParameter("studentname");
	   courseId=request.getParameter("courseid");
	   workId=request.getParameter("workid");
	   docType=request.getParameter("doctype");
	   maxMarks=request.getParameter("maxmarks");
	   marks=request.getParameter("marks");
	   tableName=request.getParameter("tablename");
	   attempt=request.getParameter("attempt");
	   
	   url = "Modify.jsp?studentid="+studentId+"&courseid="+courseId+"&workid="+workId+"&doctype="+docType+"&oldmarks="+marks+"&maxmarks="+maxMarks+"&tablename="+tableName+"&attempt="+attempt;
		     		    
   }catch(Exception e){
	  ExceptionsFile.postException("ModifyForm.jsp","Exception in ModifyForm.jsp","Exception",e.getMessage());
	  System.out.println("Error in ModifyForm.jsp is "+e);
	  }
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>

<script language="JavaScript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript" src="/LBCOM/accesscontrol/ac.js"></script>
<script language="JavaScript">
<!--
    
   function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}

  function validate(frm)
	  {
	       var marks= Number(frm.marks.value);
	       var maxmarks= Number(frm.maxmarks.value);
	       var icr = /[^\d\.]/;	
	       var str = trim(frm.marks.value);
	         
	      if(trim(frm.marks.value)=="")
	         {
		   alert('Enter Points Secured');
		   frm.marks.focus();
		   return false;
		 }
	        	 
	       if(trim(frm.comment.value)=="")
		 {
		    alert('Comment is mendatory');
		    frm.comment.focus();
		    return false;
		 }  
		 
	       if(icr.test(str))
	        {
		     alert('Enter number only in New Points Secured field');
		     return false;
		}
		   
	      if(maxmarks < marks)
	         {
		     alert('New Points Secured may not be greater than Points Possible');
		     frm.marks.focus();
		     return false;
		  }
	    return true;
          }
	   
	function close_win()
	{
	    window.close();
	}   
 	    
//-->	   
</script>

</head>
<body topmargin="3" leftmargin="3">
<form name=modifyform method="post" action='<%=url%>' onSubmit="return validate(this);">
<center>

         <br>	
	<table border="0" cellspacing="1" cellpadding="1" width="600">
		<tr>
			<td width="300" bgcolor="#ADBACE" height="20"><b>
				<font  face='Verdana' size='2' color="#800000">Student Name</font></b></td>
			<td width="300" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><%=studentName%></font></td>
		</tr>
		<tr>
			<td width="300" bgcolor="#ADBACE" height="20"><b>
				<font  face='Verdana' size='2' color="#800000">Points Secured</font></b></td>
			<td width="300" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><%=marks%></font></td>
		</tr>
		<tr>		
			<td width="300" bgcolor="#ADBACE" height="20" bordercolordark="#ADBACE"><b>
				<font face='Verdana' size='2' color="#800000">Points Possible</font></b></td>
			<td width="300" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><%=maxMarks%></font></td>
		</tr>
		<tr>		
			<td width="300" bgcolor="#ADBACE" height="20" bordercolordark="#ADBACE"><b>
				<font face='Verdana' size='2' color="#800000">Enter New Points Secured</font></b></td>
			<td width="300" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><input type="text" name="marks" size=8"></font></td>
		   <!--     <td width="300" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><input type="text" name="marks" size=8 oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></font></td> -->
		</tr>
	</table>
	
<br>	
	    
	<table width='400'>    
	        <tr>
			     <td align="left"><font  face='Verdana' size='2' color="#800000">Write Comment Here(Necessary)</font> </td>
		 </tr>
		 <tr>
			     <td align="center"><textarea rows="4" cols="50"  name="comment"></textarea></td>
		 </tr>
	</table>
	
	<table width='200'>
		<tr>
			<td width='100' height='25' bgcolor='#FFFFFF' align='center'>
			     <input type="submit" name="submit" value="Submit">
			</td>
		        <td width='100' height='25' bgcolor='#FFFFFF' align='center'>
			     <input type="button" name="cancel" value="Cancel" onClick="return close_win();">
			</td>
		</tr>
	</table>
	
    
     <input type=hidden name='maxmarks' value='<%=maxMarks%>'>
        
</form>  
</body>

</html>
