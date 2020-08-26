<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY  topmargin="0" leftmargin="0">

<%@ page errorPage="/ErrorPage.jsp" %>

<% 
	String examName="";
	String examType="";
	String examId="";
	String noOfGrps="";
	String editMode;
	String enableMode;
	int status=0;


%>

<%
	editMode=request.getParameter("editMode");
	enableMode=request.getParameter("enableMode");
	if(editMode.equals("edit")){
		examName=request.getParameter("examName");
		examId=request.getParameter("examId");

		examType=request.getParameter("examType");
		noOfGrps=request.getParameter("noOfGrps");
		status=Integer.parseInt(request.getParameter("status"));
	}
%>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111"  id="AutoNumber1">
  <tr>    
	<td width="151">	

	 

	<%
		if(status>=0){

		if(status==0)
			out.println("<a href='/LBCOM/exam/CreateExam.jsp?enableMode="+enableMode+"&examtype="+examType+"&examid="+examId+"&mode=create' target='bot_fr'><img border='0' src='/LBCOM/exam/images/button_act1.GIF' >");
		else
			out.println("<a  href='/LBCOM/exam/CreateExam.jsp?enableMode="+enableMode+"&examtype="+examType+"&examid="+examId+"&mode=edit' target='bot_fr'><img border='0'  src='/LBCOM/exam/images/button_on1.gif' >");
		
		}	
	
	%>
	
	</td>
    <td width="151">

	<% 
		if(status>=1){
			if(status==1)
				out.println("<a href= 'GroupFrames.jsp?enableMode="+enableMode+"&examtype="+examType+"&examid="+examId+"&examname="+examName+"&noofgrps="+noOfGrps+"' target='bot_fr'><img border='0' src='/LBCOM/exam/images/button_act2.GIF' ></a>");

			else
				out.println("<a href= 'GroupFrames.jsp?enableMode="+enableMode+"&examtype="+examType+"&examid="+examId+"&examname="+examName+"&noofgrps="+noOfGrps+"' target='bot_fr'><img border='0' src='/LBCOM/exam/images/button_on2.gif' ></a>");

		} else { 

			 out.println("<img border='0' src='/LBCOM/exam/images/button_off2.gif' >");
	
		}
	%>

	</td>
    <td width="151">
	
	<% 
		if(status>=2){  
			if(status==2)	
				out.println("<a target='bot_fr' href='CreateExamFrames.jsp?enableMode="+enableMode+"&type=edit&examid="+examId+"&examtype="+examType+"&examname="+examName+"'><img border='0' src='/LBCOM/exam/images/button_act3.GIF' > </a>");
			else
				out.println("<a target='bot_fr' href='CreateExamFrames.jsp?enableMode="+enableMode+"&type=edit&examid="+examId+"&examtype="+examType+"&examname="+examName+"'><img border='0' src='/LBCOM/exam/images/button_on3.gif' > </a>");

	
	 } else { 
			out.println("<img border='0' src='/LBCOM/exam/images/button_off3.gif' >");

	 }
	 
	 %>

	</td>

    <td width="151">
	<% 
	if(status>=3){ 
			if(status==3)
				out.println("<a target='bot_fr' href='RandomizeFrames.jsp?enableMode="+enableMode+"&examid="+examId+"&examtype="+examType+"&examname="+examName+"' ><img border='0' src='/LBCOM/exam/images/button_act4.GIF'  >");
			else
				out.println("<a target='bot_fr' href='RandomizeFrames.jsp?enableMode="+enableMode+"&examid="+examId+"&examtype="+examType+"&examname="+examName+"' ><img border='0' src='/LBCOM/exam/images/button_on4.gif' >");
	
	 } else { 
			out.println("<img border='0' src='/LBCOM/exam/images/button_off4.gif'  >");
	 }
	 
	 %>

	</td>

    <td width="151">
	<% 
		if(status>=4){  
			 if(status==4)
				out.println("<a target='bot_fr' href='/LBCOM/coursemgmt/teacher/AsgnFrames.jsp?enableMode="+enableMode+"&totrecords=&start=0&checked=&unchecked&cat=edit&workid="+examId+"&docname="+examName +"'><img border='0' src='/LBCOM/exam/images/button_act5.GIF'>");
			else
				out.println("<a target='bot_fr' href='/LBCOM/coursemgmt/teacher/AsgnFrames.jsp?enableMode="+enableMode+"&totrecords=&start=0&checked=&unchecked&cat=edit&workid="+examId+"&docname="+examName +"'><img border='0' src='/LBCOM/exam/images/button_on5.gif' >");

	   } else {
			out.println("<img border='0' src='/LBCOM/exam/images/button_off5.gif' >");

		}
	%>
	</td>
  </tr>
</table>
</BODY>
<script language="javascript">
	var status=<%=status%>;

	if (status==1)
		parent.bot_fr.location.href='GroupFrames.jsp?enableMode=<%=enableMode%>&examtype=<%=examType%>&examid=<%=examId%>&examname=<%=examName%>&noofgrps=<%=noOfGrps%>';
	else if(status==2)
		parent.bot_fr.location.href='CreateExamFrames.jsp?enableMode=<%=enableMode%>&type=create&examid=<%=examId%>&examtype=<%=examType%>&examname=<%=examName%>';
	else if(status==3)
		parent.bot_fr.location.href='RandomizeFrames.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&examtype=<%=examType%>&examname=<%=examName%>';
	else if(status==4)			parent.bot_fr.location.href='/LBCOM/coursemgmt/teacher/AsgnFrames.jsp?enableMode=<%=enableMode%>&totrecords=&start=0&checked=&unchecked&cat=edit&workid=<%=examId%>&docname=<%=examName %>';
</script>
</HTML>
