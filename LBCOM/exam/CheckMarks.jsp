<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@ page import="java.sql.*,java.util.*,java.lang.Object,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
   Connection con=null;
   Statement st=null;
   ResultSet rs=null;
   Vector questionIds=null,groupIds=null;
   Hashtable totQtns=null,ansQtns=null;
   int status=0,totRecords=0,shortAnsMarks=0,count=0;
   float marksSecured=0.0f,maxMarks=0.0f;
   String examId="",examType="",studentId="",stuTableName="",examName="",marksScheme="";

	
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
	 examId=request.getParameter("examid");	
	 examName=request.getParameter("examname");
	 examType=request.getParameter("examtype");
	 status=Integer.parseInt(request.getParameter("status"));
	 count=Integer.parseInt(request.getParameter("count"));
	 stuTableName=request.getParameter("tablename");
	 marksScheme=request.getParameter("scheme");
	 totRecords=Integer.parseInt(request.getParameter("totrecords").trim());
	 maxMarks=Float.parseFloat(request.getParameter("totalmarks"));

	 

	 con=con1.getConnection();
	 st=con.createStatement();
	
	rs=st.executeQuery("select * from "+stuTableName+" where student_id='"+studentId+"' and count="+count+" and exam_id='"+examId+"'");
	if(rs.next()){
		//maxMarks=Integer.parseInt(rs.getString("total_marks"));
		marksSecured=Float.parseFloat(rs.getString("marks_secured"));
	}
	
}catch(Exception e){
		ExceptionsFile.postException("CheckMarks.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CheckMarks.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	 
%>

<head><title></title>
</head>
<SCRIPT LANGUAGE="JavaScript" src="exam_validations.js"></SCRIPT>
<script>
 function get(field) {
		window.document.sub.marks.value=field.value;
	alert(field.value);
}
  function check()
  {		
    var win=window.document.sub.marks;
	   
	if ( trim(win.value) == "" ) {
		alert("Please assign points");
	    win.focus();
		return false;
	  }
  }


</script>
<BODY>
<form name="sub" method="post" action="/LBCOM/exam.ExamEvaluate" onsubmit="return check();">


<table border="1" width="100%" bgcolor="#BEC9DE" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF">
  <tr>
    <td width="18%"><font face="Arial" size="2">Max&nbsp; Points for this Assessment</font> </td>
	<td width="1%"><font face="Arial" size="2"><b>:</b></font></td>
    <td width="80%" colspan="3"><font face="Arial" size="2"><b><%=maxMarks%></b></font></td>
  </tr>
  <tr>
    <td width="18%"><font face="Arial" size="2">Points secured&nbsp; for graded
      questions</font></td>
    <td width="1%"><font face="Arial" size="2"><b>:</b></font></td>
    <td width="20%"><font face="Arial" size="2"><%=marksSecured%></font></td>
    <td width="20%">
      <p align="right"><font face="Arial" size="2">Points for these Questions</font> </td>
    <td width="10%"><font face="Arial" size="2"><input type="text" name="marks" readonly size="20" >      </font>      </td>
  </tr>
<% if (status<2) {%>
<tr>
    <td width="100%" colspan="5" bgcolor="#FFFFFF">
	<p align="center"><font face="Arial" size="4"><input type="image" src="images/submit.gif"  name="submit" >
	</font></td>

</tr><% }%>

</table>

<input type="hidden" name="studentid" value="<%=studentId%>">
<input type="hidden" name="studentid" value="<%=studentId%>">
<input type="hidden" name="maxmarks" value="<%=maxMarks%>">
<input type="hidden" name="markssecured" value="<%=marksSecured%>">
<input type="hidden" name="examid" value="<%=examId%>">
<input type="hidden" name="examname" value="<%=examName%>">
<input type="hidden" name="examtype" value="<%=examType%>">
<input type="hidden" name="totrecords" value="<%=(totRecords-1)%>">
<input type="hidden" name="tablename" value="<%=stuTableName%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="count" value="<%=count%>">
<input type="hidden" name="scheme" value="<%=marksScheme%>">


</form>
</BODY>
</HTML>
