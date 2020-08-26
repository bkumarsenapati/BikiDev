<jsp:useBean id="db" class="sqlbean.DbBean" scope="session">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",userId="",gradeId="",mode="",courseId="",topicId="",subTopicId="",subTopicDes="",courseName="",classId="";
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
		courseId = request.getParameter("courseid");
		topicId = request.getParameter("topicid");
		
		con=db.getConnection();
		st=con.createStatement();
		


//		classId=   request.getParameter("classid");
//		courseName=request.getParameter("coursename");

		rs =st.executeQuery("select subtopic_id,subtopic_des from subtopic_master where course_id='"+courseId+"' and topic_id='"+topicId+"' and school_id='"+schoolId+"' order by subtopic_des");

	}catch(SQLException e){
		ExceptionsFile.postException("DisplaySubTopics.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		System.out.println("The Error: SQL - "+e.getMessage());
		try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
		}catch(SQLException se){
			ExceptionsFile.postException("DisplaySubTopics.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}catch(Exception e) {
		ExceptionsFile.postException("DisplaySubtopics.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Error in DisplaySubTopics is "+e);
	}

	

%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function nextPage(field)
{
	if(field=='add')
		document.location.href = "AddEditSubtopic.jsp?courseid=<%=courseId%>&mode="+field+"&topicid=<%=topicId%>";

	else 
	{
		var c=0;
		var subtopicid;
		var len = window.document.DispTopics.elements.length;
		if(len==0){
			alert("There are no sub topics");
			return false;
		}
	
		for(var i=0;i<len;i++)
		{
			if(window.document.DispTopics.elements[i].checked)
			{
				subtopicid = window.document.DispTopics.elements[i].value;
				c=1;
			}
		}
		if(c==0)
		{ 
			  alert("Select a sub topic");
			  return false;
		}
		if(field=='edit'){
			document.location.href = "AddEditSubtopic.jsp?courseid=<%=courseId%>&mode="+field+"&topicid=<%=topicId%>&subtopicid="+subtopicid;		}
		else if(field=='delete')
			if(confirm('Are you sure? You want to delete the sub topic.')) {
				document.location.href = "/LBCOM/coursemgmt.AddEditSubtopic?courseid=<%=courseId%>&mode="+field+"&topicid=<%=topicId%>&subtopicid="+subtopicid;

		    }
		return false;
	}	
	return false;
}
//-->
</SCRIPT>
</head>
<body topmargin='3' leftmargin='3'>
<form name="DispTopics">
<div align="center">
  <center>
  <br><br>
	<table width="500" height="130" cellspacing="0" cellpadding="0">
	
	<tr><td width="300"  >
		<img border="0" src="../images/subtopics.gif">
	</td></tr>
	
	<tr><td width="300" height="20" ><img border="0" src="../images/studentslistheader.gif" width="597" height="26" >
		</td></tr>

		


<%
    try{
		boolean flag=false;
		while(rs.next()){
			out.println("<tr><td width='300' align='left'><font face='Arial' size='2'>");
			out.println("<input type='radio' name='topic' value='"+rs.getString("subtopic_id")+"'>"+rs.getString("subtopic_des")+"</font></td></tr>");
			flag=true;
		} 

		if(flag==false){
			if(topicId.equals("None")){
				out.println("<tr><td width='300' align='center' height='50'>");
				out.println("<font face='Arial' size='3' color='red'>Select a topic in the above list. </font></td></tr>");

			}else{
			out.println("<tr><td width='300' align='center' height='50'>");
			out.println("<font face='Arial' size='3' color='red'>Sub topics are not available. </font></td></tr>");
			}
		}
   }catch(Exception e){
		ExceptionsFile.postException("DisplaySubtopics.jsp","reterving data from resultset","Exception",e.getMessage());
   }finally{
		try{
			st.close();
			db.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("DisplaySubtopics.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>


	<tr>
	<td width="300" align="center" height="20">
    <p align="left">
    <font face="Arial" size="2">
	<img border="0" src="../images/studentslistfooter.gif">
    </font>
    </p>
	</td></tr>


	<tr>
	<td align="center" height="47">
    <p align="center">
        <font face="Arial" size="2">
		<a href="javascript:nextPage('add');"><img src='../images/add.gif' border='0'></a>
		<a href="" onclick="javascript:return nextPage('edit');" target="_self"><img src='../images/edit.gif' border='0'></a>
		<a href="javascript://" onclick="return nextPage('delete');"><img src='../images/delete.gif' border='0'></a>
        </font>
	</td></tr>
	</table>
</div>
 
</form>
</center>
</body>
</html>