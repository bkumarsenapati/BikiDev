<%@ page language="Java" %>
<%
	String studentId=request.getParameter("studentid");
	String attempt=request.getParameter("attempt");
	String examId=request.getParameter("examid");
	String status=request.getParameter("status");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<script language="javascript">

function callSubmit()
{
	var obj=parent.btm_f.document.getElementsByName("submit");		
	parent.mid_f.frm.action='/LBCOM/exam/SubmitShtAnsFiles.jsp?examid=<%=examId%>&mode=T&studentid=<%=studentId%>&attempt=<%=attempt%>&status=<%=status%>';
	var btmFrm=parent.btm_f.document.getElementsByName("bpanel");		
	btmFrm[0].action='/LBCOM/exam.ProcessResponse?mode=T&studentid=<%=studentId%>&attempt=<%=attempt%>&status=<%=status%>';		

	obj[0].click();
}
</script>

<BODY topmargin="25">

<hr>
<center><input type="submit" value="    Submit The Assessment    " name="submit" onclick='callSubmit();'></center>
</BODY>
</HTML>
