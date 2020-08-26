<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	String schoolId="",courseId="",topicId="",subTopicId="",subTopicDes="",mode="",subtopicDes=""; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
	try
	{
		session=request.getSession();

		String s=(String)session.getAttribute("sessid");
		if(s==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		mode = request.getParameter("mode");
		topicId = request.getParameter("topicid");
		subTopicId = request.getParameter("subtopicid");
		courseId=request.getParameter("courseid");

		con=db.getConnection();
		st=con.createStatement();

		if(mode.equals("edit")) {
			rs = st.executeQuery("select subtopic_des from subtopic_master where topic_id='"+topicId+"' and course_id='"+courseId+"' and subtopic_id='"+subTopicId+"' and school_id='"+schoolId+"'");
			if(rs.next())
				subtopicDes=rs.getString("subtopic_des");
					
		}
		else{
			   subtopicDes="";	
			
		}

	}
	catch(Exception e) {
		ExceptionsFile.postException("AddEditSubtopic.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Error in AddEditSubtopic is "+e);

	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditSubtopic.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" src='../../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{

	var tdesc=trim(document.AddEditTopics.subtopicdesc.value);

	if(tdesc==''){
		alert("Sub topic name should be entered.");
		document.AddEditTopics.subtopicdesc.focus();
		return false;
	}	
	 replacequotes();

//document.location.href="/LBCOM/coursemgmt.AddEditSubtopic?courseid=<%=courseId%>&mode=<%=mode%>&topicid=<%=topicId%>&subtopicdesc="+tdesc+"&subtopicid="+field;
	//document.location.href="/LBCOM/coursemgmt.AddEditSubtopic?courseid=<%=courseId%>&mode=<%=mode%>&topicid=<%=topicId%>&subtopicdesc="+document.AddEditTopics.subtopicdesc.value+"&subtopicid="+field;
}
//-->
</SCRIPT>
</head>
<body>
<form name="AddEditTopics" method="post" action="/LBCOM/coursemgmt.AddEditSubtopic?courseid=<%=courseId%>&mode=<%=mode%>&topicid=<%=topicId%>" onSubmit="return validate();">

  <table align=center width=491 border="0" bgcolor="#FFFFFF" height="192" cellspacing="1">
    <tr> 
      <td colspan=2 width="481" height="13">      </td>
    </tr>
    <tr> 
      <td colspan=2 bgcolor="#bfbebd" width="481" height="13"> 
        <div align="center"><b><font face="Arial" color="#453F3F" size="3">Add/Edit
          Sub Topic</font></b></div>      </td>
    </tr>
   <tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">Sub Topic Name :</font></div>      </td>
      <td width="303" height="67"> 
	
		<input type='text' name='subtopicdesc' value="<%=subtopicDes%>" size='37'  oncontextmenu="return false" onKeyDown="restrictctrl(this,event)" onKeyPress="return AlphaNumbersOnly(this, event)" >
		<input type="hidden" name='subtopicid' value='<%=subTopicId%>'>      </td>
    </tr>
  
  <tr><td colspan=2 align=center width="481" height="1" bgcolor="#FFFFFF"">&nbsp;</td></tr>
<tr><td colspan=2 align=right width="481" height="47">
    <p align="center"><center>
      <input type="image" src="../images/submit.gif" >
      <input type="image"  src='../images/back.gif' onClick="history.go(-1); return false;">
	
</center>
</td>
</tr>
</table>
<center><br>	
</center>
</form>
</body>
</html>