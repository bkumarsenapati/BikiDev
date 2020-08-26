<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",userId="",gradeId="",mode="",courseId="",topicId="",topicDes="",classId="",courseName="",className="";
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
		courseId = request.getParameter("courseid");
		classId=   request.getParameter("classid");
		courseName=request.getParameter("coursename");
        schoolId= (String)session.getAttribute("schoolid");
		className=request.getParameter("classname");
		con=db.getConnection();
		st=con.createStatement();
		rs = st.executeQuery("select  topic_id,topic_des from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"' order by topic_des");
	}catch(SQLException e){
			ExceptionsFile.postException("DisplayTopics.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("DisplayTopics.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
	}catch(Exception e) {
		ExceptionsFile.postException("DisplayTopics.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
	}


	

%>
<html>
<head>
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function nextPage(field)
{
	var cName="<%=courseName%>";
	cName=cName.replace(/ /g,"+");
	if(field=='add')
	{
				
		//$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/AddEditTopic.jsp?mode=add&coursename="+cName+"&courseid=<%=courseId%>&classid=<%=classId%>&classname=<%=className%>", hideLoading);

		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/AddEditTopic.jsp?coursename="+cName+"&courseid=<%=courseId%>&classid=<%=classId%>&mode="+field+"&topicid="+topicid+"&classname=<%=className%>",hideLoading);


		
		//return false;

		//document.location.href = "/LBCOM/coursemgmt/teacher/AddEditTopic.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&classid=<%=classId%>&mode="+field+"&classname=<%=className%>";
	}
	else 
	{
		var c=0;
		var topicid;
		var len = window.document.DispTopics.elements.length;
		if(len==0){
			alert("There are no topics");
			return false;
		}
	
		for(var i=0;i<len;i++)
		{
			if(window.document.DispTopics.elements[i].checked)
			{
				topicid = window.document.DispTopics.elements[i].value;
				c=1;
			}
		}
		if(c==0)
		{ 
			  alert("Please select a Topic.");
			  return false;
		}
		if(field=='edit'){

			//document.location.href = "AddEditTopic.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&classid=<%=classId%>&mode="+field+"&topicid="+topicid+"&classname=<%=className%>";

			$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/AddEditTopic.jsp?coursename="+cName+"&courseid=<%=courseId%>&classid=<%=classId%>&mode="+field+"&topicid="+topicid+"&classname=<%=className%>",hideLoading);

		}
		else if(field=='delete')
			if(confirm('Are you sure? You want to delete the topic.')) {
				document.location.href = "/LBCOM/coursemgmt.AddEditTopic?coursename="+cName+"&courseid=<%=courseId%>&classid=<%=classId%>&mode="+field+"&topicid="+topicid+"&classname=<%=className%>";
				
		    }
		return false;
	}	
	//return false;
}
//-->
</SCRIPT>
</head>
<form name="DispTopics">
<table border="0" width="100%" cellspacing="0">
  <tr>
    <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><!-- <a href="CoursesList.jsp">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"> --><%=courseName %><!-- </a> --> &gt;&gt; <%=className %> &gt;&gt; <font color=black> Topics</span></font></font></td>
  </tr>
</table>

<center><br>

</center>
<div align="center">
  <center>
  <br><br>
	<table width="500" height="130" cellspacing="0" cellpadding="0">
	
	<tr><td bgcolor="#bfbebd">
		<h3>&nbsp;&nbsp;Topics</h3></td>
	<td width="407">&nbsp;	  </td>
	</tr>
	
	<tr bgcolor="#bfbebd"><td>&nbsp;
		</td><td >&nbsp;
		</td></tr>

		


<%
/*		if(!rs.next())
		{
			out.println("<tr><td><b>There are no Topics in this Course</b></td></tr>");
			out.println("<tr><tds><br><a href=\"javascript:nextPage('add');\"><img src='../images/add.gif' border='0'></a></td></tr>");
			return;
		}else { 
				do {
						out.println("<tr><td width='300' align='center'><p align='left'>");
						out.println("<input type='radio' name='topic' value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</p>");
						out.println("</td></tr>");
				}while(rs.next());
		} */
	try{
		boolean flag=false;
		while(rs.next()){
			out.println("<tr><td width='300' align='left'><font face='Arial' size='2'>");
			out.println("<input type='radio' name='topic' value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</font></td></tr>");
			flag=true;
		} 

		if(flag==false){
			out.println("<tr><td width='300' align='center' height='50'>");
			out.println("<font face='Arial' size='3' color='red'>No topic is added yet. </font></td></tr>");
		}
	}catch(Exception e){
		ExceptionsFile.postException("DisplayTopics.jsp","getting data from resultset","Exception",e.getMessage());
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("DisplayTopics.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }

%>


	<tr bgcolor="#bfbebd">
	<td>&nbsp;
    
	
    </td><td>&nbsp;
		</td></tr>


	<tr><td>&nbsp;
		</td>
	<td align="center" height="47">
    <p align="center">
        <font face="Arial" size="2">
		<a href="javascript:nextPage('add');"><img src='/LBCOM/coursemgmt/images/add.gif' border='0'></a>
		<a href="" onClick="javascript:return nextPage('edit');" target="_self"><img src='/LBCOM/coursemgmt/images/edit.gif' border='0'></a>
		<a href="javascript://" onClick="return nextPage('delete');"><img src='/LBCOM/coursemgmt/images/delete.gif' border='0'></a>
        </font>
	</td></tr>
	</table>
</div>
 
</form>
</center>
</html>