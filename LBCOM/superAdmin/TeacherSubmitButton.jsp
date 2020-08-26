
<HTML>
<%@ page import="java.sql.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   int status=0;
   String workId="",categoryId="",studentId="",comments="",docName="",marksSecured="",workFile="",remark="",submitDate="",maxMarks="",count="";

	
%>
<%
     
     session=request.getSession();
     String sessid=(String)session.getAttribute("sessid");
	 if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	 }
	 studentId=request.getParameter("studentid");
	 workId=request.getParameter("workid");	
	 categoryId =request.getParameter("cat");
     maxMarks= request.getParameter("maxmarks");
	 comments=request.getParameter("comments");
	 docName=request.getParameter("docname");
	 status=Integer.parseInt(request.getParameter("status"));
	
	 
	 marksSecured=request.getParameter("marks");
	 workFile=request.getParameter("workfile");
	 remark=request.getParameter("remarks");
	 submitDate=request.getParameter("submitdate");
	 count=request.getParameter("count");
	 
%>

<head>
<title></title>
</head>
<script>

function check()
{
	var max=<%=maxMarks%>;
	var win=window.document.sub.markssecured;
	if(show_key(win.value)==false)
	{
		alert("Enter only numbers");
		win.focus();
		return false;
	}
	else
	{
		if(win.value > max || win.value == "")
		{
			alert("Maximum points should be less than or equal to "+max);
			win.focus();
			return false;
		}
	}
}

function show_key(the_value)
{
	var the_key="0123456789";
	var the_char;
	var len=the_value.length;
	if(the_value=="")
		return false;
	for(var i=0;i<len;i++)
	{
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1)
			return false;
	}
}

function showcomments(comment)
{
	var newWin=window.open('','StudentComments',"resizable=no,toolbars=no,scrollbar=yes,width=225,height=170,top=275,left=300");
	newWin.document.writeln("<html><head><title>Student Comments</title></head><body><font face='Arial' size='2'><b>Student Comments</b></font><br><font face='Arial' size=2>"+comment+"</font></body></html>");
}

function enterRemarks(remark)
{
	var newWin=window.open("SetRemark.jsp?remark="+remark,'TeacherRemarks',"resizable=no,toolbars=no,scrollbar=yes,width=250,height=250,top=200,left=300");
	/*newWin.document.writeln("<html><head><title>Teacher's Remarks</title></head><body><font face='Arial' size='2' color='blue'><u>");
	newWin.document.writeln("Please Enter the Remarks</u><br><textarea name='remarks' rows='8'></textarea><br><center><input type=submit value='Ok' onclick='return setremark();'></center></body></html>");*/
}


/*   function checkNum(keyCode)
   {

     if(keyCode==8 || keyCode==13)
		return true;

	  if(keyCode<48 || keyCode>57)
	  {

		alert("Enter Numbers Only");
		return false;
	  }
	return true;

}*/
</script>

<BODY bgcolor="#E8ECF4">
<form name="sub" method="post" action="TeacherSubmit.jsp?workfile=<%=workFile%>" onsubmit="javascript:return check();">

<table width="100%" border=1 bordercolorlight="#FFFFFF" cellspacing="0" bordercolor="#FFFFFF" cellpadding="0">
	<tr>
		<td width="25%" align="center">
			<b><font face="Arial" size="2"><a href="javascript:showcomments('<%=comments%>');">View Student Comments</font>
		</td>
		<td width="20%" align=center><b>
			<font face="Arial" size="2"><a href="javascript:enterRemarks('<%=remark%>');">Add Remarks</a></font>
		</td>
		<td width="40%">
			<font face="Arial" size="2">Total Points&nbsp;[Max = <%=maxMarks%>] 

<%
	if(status<4)
	{
%>
			<input type="text" name="markssecured" size="10"> 
<%
	}
	else
	{
%>
			<input type="text" name="markssecured" value="<%=marksSecured%>" size="10">
			
<%
	}
%>
			</font>
		</td>

	<!--<input type="image" src="../images/submit.gif" name="submit" onclick="javascript:return check();">-->

		<td width="15%" align="center">
			<input type="image" value="Submit" src="../images/submit.gif" onclick="javascript:return check();">
		</td>
</tr>
</table>

<input type="hidden" name="cat" value="<%=categoryId%>">
<input type="hidden" name="studentid" value="<%=studentId%>">	
<input type="hidden" name="workid" value="<%=workId%>">
<input type="hidden" name="maxmarks" value="<%=maxMarks%>">
<input type="hidden" name="docname" value="<%=docName%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="remarks">
<input type="hidden" name="submitdate" value="<%=submitDate%>">
<input type="hidden" name="count" value="<%=count%>">

</form>
</BODY>
</HTML>