<!--
	/**
	 * Divides the window in to three horizontal frames
	 *first one is to provide the links for the courses,course contents and for the student Inbox.
	 *second one is to display the work document given by the teacher.
	 *third one is to provide a form where a student can browse for a file to submit.
	 *Third frame displays only when the student is not yet submitted the given work and the current *date is before the dead line
	 */
-->

<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String start="",totrecords="",courseName="",docName="",workFile="",workId="",categoryId="",deadLineFlag="",workStatus="";
  int status=0,maxAttempts=0,submitCount=0;
%>
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
		
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	categoryId=request.getParameter("cat");
	courseName=request.getParameter("coursename");
	docName=request.getParameter("docname");
	workFile=request.getParameter("workfile");
	deadLineFlag=request.getParameter("flag");
	workId=request.getParameter("workid");
	status=Integer.parseInt(request.getParameter("status"));
	workStatus=request.getParameter("workstatus");
	maxAttempts=Integer.parseInt(request.getParameter("maxattempts"));
	submitCount=Integer.parseInt(request.getParameter("submitcount"));
%>

<HTML>
<HEAD>
<TITLE>A frameset document</TITLE>
</HEAD>

<frameset rows="0%,70%,*" border="0" framespacing=0 frameborder=0>
	<FRAME name="first" src="Navigation.jsp?&cat=<%=categoryId%>&coursename=<%=courseName%>&doc=<%=docName%>" scrolling=no>
<%
	  //if ((status<=1)&&(deadLineFlag.equals("true"))&&(workStatus.equals("1"))) {
		if ((status<=1)&&(deadLineFlag.equals("true"))) 
		{	
			 /*  *if the student is not yet viewed or viewed but not submitted the work document 			 *and the current date is before the deadline 			 *and the teacher is assigned the work but not yet deleted 	the workdocument then			 *    if the student is not yet viewed the document,call the file ChangeStatus.jsp to change *    the status to 1 which means the studnet is viewed			 *    else if the student is viewed but not submitted then display the work document in     *    second frame and submit form in third frame  			 *else if the student submitted the work document then display the work document in the *second frame and leave the third frame empty			 */
		    if((status==0)) 
			{
%>
				<frame name="second" src="ChangeStatus.jsp?workfile=<%=workFile%>&workid=<%=workId%>&cat=<%=categoryId%>"> 
<% 
			}
            else
			{
%>
				<frame name="second" src="<%=workFile%>"> 
<%
			}
			if(workStatus.equals("1")) 
			{
%>
				<frame name="third" src="SubmitButton.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&submitcount=<%=submitCount%>" scrolling="auto">  <% 
			}
	    }
		else
		{
%>
			<frame name="second" src="<%=workFile%>">  
<%
		}
		if(status>1 && (submitCount<maxAttempts || maxAttempts==-1) && deadLineFlag.equals("true")&&workStatus.equals("1"))
		{
%>   
			<frame name="third" src="SubmitButton.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&submitcount=<%=submitCount%>" scrolling="auto">
<%
		}
%>

</FRAMESET>
</HTML>

