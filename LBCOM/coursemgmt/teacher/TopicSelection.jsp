<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" >
<jsp:setProperty name="db" property="*" />
</jsp:useBean>
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Statement st=null;
	String courseId="",courseName="",classId="",schoolId="",className="";
	ResultSet rs=null;
%>
<%
	try {		
			session=request.getSession();
			
			String s=(String)session.getAttribute("sessid");
			if(s==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			schoolId=(String)session.getAttribute("schoolid");
			System.out.println("Topic selection schoolId..."+schoolId);
			courseId=request.getParameter("courseid");
			classId=request.getParameter("classid");
			courseName=request.getParameter("coursename");
			className=request.getParameter("classname");

			System.out.println("Topic selection");

			con=db.getConnection();
			st=con.createStatement();
			rs = st.executeQuery("select topic_id,topic_des from topic_master where course_id='"+courseId.trim()+"' and school_id='"+schoolId+"' order by topic_des");

    } 
	catch(Exception e) {
		ExceptionsFile.postException("TopicSelection.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Error in TopicSelection is "+e);
	}

%>
<HTML>
<HEAD>
<title></title>
<script>
function go()
{
	
    if(window.document.TopicSelection.topics.value!="None"){
		parent.sec.location.href="DisplaySubtopics.jsp?topicid="+document.TopicSelection.topics.value+"&courseid=<%=courseId%>&classid=<%=classId%>&coursename=<%=courseName%>&classname=<%=className%>";
    }else{
		parent.sec.location.href="about:blank";
	}


}
</script>
</HEAD>
<body topmargin='3' leftmargin='3'>
<form name="TopicSelection"  method="post" >
<table border="0" width="100%" cellspacing="1">
  <tr>
    <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><a href="CoursesList.jsp" target="main">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>" target="main"><%=courseName %></a> &gt;&gt; <%=className %> &gt;&gt; <font color=black>Sub Topics</span></font></td>
  </tr>
</table>
<br>
<p align='center'> <font color="#800080" face="Arial" size=2><b>Topic : <b>
<select name="topics" onchange="javascript:go();">
<%
	boolean flag=false;
  try{
	if(!rs.next()){
		out.println("<option value='None' Selected>Add a topic first.</option>");
	}else{
		out.println("<option value='None' Selected>- - - - - - Select Topic - - - - - -</option>");
		do{
			out.println("<option value="+rs.getString("topic_id")+">"+rs.getString("topic_des")+"</option>");
		}while(rs.next());
	}
  }catch(Exception e){
		ExceptionsFile.postException("TopicSelection.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("TopicSelection.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</select>
</form>
</BODY>
</HTML>
