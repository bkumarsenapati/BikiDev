<%@page language="Java" import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String examId=null,examType=null,examName=null;
	int noOfGrps=0;
	boolean composedFlag=false;
%>
<%
	session=request.getSession(false);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	try{
		examId=request.getParameter("examid");
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select ques_list from exam_tbl where exam_id='"+examId+"' and trim(ques_list)!=''");
		if(rs.next()){
			composedFlag=true;
		}
		
		examName=request.getParameter("examname");
		examType=request.getParameter("examtype");

		if(request.getParameter("noofgrps")!=null)
			noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
		else
			noOfGrps=0;
		st.close();
	}catch(Exception e){
		System.out.println("Exception in ExamSteps.jsp is "+e);
		ExceptionsFile.postException("ExamSteps.jsp","operations on database","Exception",e.getMessage());
     }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && ! con.isClosed())
				con.close();
		}catch(SQLException se){
				ExceptionsFile.postException("ExamSteps.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				
		}

   }

	

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
 function go(type){
	if(type=='modify'){
		parent.desc.location.href='CreateExam.jsp?examid=<%=examId%>&mode=edit&examname=<%=examName%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>';
	}else if (type=='groups'){
		parent.desc.location.href='GroupFrames.jsp?examud=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>';
	}else if (type=='questions'){

	}else if (type=='papers'){
		parent.desc.location.href='RandomizeFrames.jsp?examud=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>';	

	}

 }
//-->
</SCRIPT>
</HEAD>

<BODY topmargin=0>
<table width="100%">
<tr>
	<td><font face='arial' size='2'><a href='javascript://' onclick="go('modify');return false">Exam Details</a></font></td>
	<td><font face='arial' size='2'><a href='javascript://' onclick="go('groups');return false">Group Details</a></font></td>
	<td><font face='arial' size='2'><a href='javascript://' onclick="go('questions');return false">Select Questions</a></font></td>
	<td><font face='arial' size='2'><a href='javascript://' onclick="go('papers');return false">Generate Papers</a></font></td>
</tr>
</table>

</BODY>
</HTML>
