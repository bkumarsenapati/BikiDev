<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String examId="",teacherId="",tblName="",examPassword="",status="",examType="",chances="";
  int markScheme=0;
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	String start="";
	String totRecords="";
	examId=request.getParameter("examid");
	teacherId=request.getParameter("teacherid");
	tblName=request.getParameter("tblname");
	examPassword=request.getParameter("exampassword");
	status=request.getParameter("status");
	examType=request.getParameter("examtype");
	chances=request.getParameter("chances");
	start=request.getParameter("start");
	totRecords=request.getParameter("totrecords");
	
	markScheme=Integer.parseInt(request.getParameter("markscheme"));
	String durationInSecs=request.getParameter("durationinsecs");

	String reassign=request.getParameter("reassign");
	if(reassign==null)
	    reassign="false";

	
	
%>
<HTML>
<HEAD>
<title></title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">

<script>
<!--
	function openExamPlayer(){
		var pswrd =window.document.password.password.value;
//		alert('in if <%=reassign%>');
		var resubmit='<%=reassign%>';
		if(resubmit=="false"){
			var win=window.open("ExamPlayer.jsp?examid=<%=examId%>&tblname=<%=tblName%>&exampassword=<%=examPassword%>&teacherid=<%=teacherId%>&password="+pswrd+"&examtype=<%=examType%>&start=<%=start%>&totrecords=<%=totRecords%>&chances=<%=chances%>&markscheme=<%=markScheme%>&durationinsecs=<%=durationInSecs%>","ExamPlayer","widht=900,height=700,status=yes,resizable=1");
			win.focus();
			top.studenttopframe.studentExamWin=win;
		}else if(resubmit=="true"){
			document.location.href="/LBCOM/exam/ExamPlayer.jsp?examid=<%=examId%>&tblname=<%=tblName%>&exampassword=<%=examPassword%>&teacherid=<%=teacherId%>&password="+pswrd+"&examtype=<%=examType%>&chances=<%=chances%>&markscheme=<%=markScheme%>&durationinsecs=<%=durationInSecs%>&reassign=true&start=<%=start%>&totrecords=<%=totRecords%>";
		}
	}
	//-->
</script>
</HEAD>

<BODY>
<form name="password" onsubmit='openExamPlayer(); return false;'>
<%if(status.equals("1")){%>
<b>Invalid Pasword</b>
<%}%>
<table>
  <tr>
    <td>
      Enter Password:   <input type="password" name="password" maxlength="60">
    </td>
  </tr>
   <tr colspan="3">
	  <td  width="893" align="center" colspan="2" height="53" bgcolor="#FFFFFF" >
      <p align="left"><input type='image' name="submit" src="images/submit.gif" ></td>
	</tr>
 </table>
<!--<input type="hidden" name="examid" value="<%=examId%>">
<input type="hidden" name="tblname" value="<%=tblName%>">
<input type="hidden" name="teacherid" value="<%=teacherId%>">
<input type="hidden" name="exampassword" value="<%=examPassword%>">-->
</BODY>
</HTML>
