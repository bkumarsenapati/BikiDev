<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String classId="",courseName="",teacherId="",schoolId="",title="",url="",courseId="",className="";
String catId="",materialId="";
ResultSet rs=null;
Connection con=null;
Statement st=null;
%>

<%

try
	{
		String sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
	con=con1.getConnection();

	st=con.createStatement();
	teacherId = (String)session.getAttribute("emailid");
    schoolId = (String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");

	courseName=request.getParameter("coursename");

	classId=request.getParameter("classid");
	className=request.getParameter("classname");
	title=request.getParameter("title");
	catId=request.getParameter("cat");
	materialId=request.getParameter("workid");
	
	rs=st.executeQuery("select title,titleurl from courseweblinks where  title='"+title+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");//modified on 2004-8-16
	rs.next();
	
	url=rs.getString("titleurl");
	
	
}catch(SQLException se){
	ExceptionsFile.postException("EditWeblink.jsp","Operations on database  and reading parameters","SQLException",se.getMessage());
	System.out.println("Error: SQL -" + se.getMessage());
}
catch(Exception e){
	ExceptionsFile.postException("EditWeblink.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("EditWeblink.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>



<html>
<head>

<script language="javascript" src="validationscripts.js"></script>
<script language="javascript" src="../../validationscripts.js"></script>

<script language="javascript">

function validate(frm)
{
	
	if(trim(frm.url.value)=="")
	{
		alert("Enter Link");
		frm.url.focus();
		return false;
	}
	replacequotes();
}
</script>

</head>
<body topmargin=3 leftmargin="0" marginwidth="0">
<!--<form name="addpage" action="/servlet/coursemgmt.AddWebLinks?mode=mod" method="post" onsubmit="return validate(this);">-->
<form name="addpage" action="/LBCOM/coursemgmt.AddWebLinks?mode=mod" method="post" onsubmit="return validate(this);">
  <!-- <table border="0" width="100%" cellspacing="1">
    <tr>

		 <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><a href="CoursesList.jsp">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>"><%=courseName %></a> &gt;&gt; <%=className %> &gt;&gt; <a href="WeblinksList.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>">Weblinks</span></font></td>

    </tr>
  </table> -->
  <p>
  <br>
<br>
  </p>
  <table align=center width=491 border="0" height="153" cellspacing="1">
    <tr> 
      <td colspan=2 bgcolor="#40A0E0" width="481" height="13"> 
        <div align="center"><b><font face="Arial" color="#FFFFFF" size="3">Edit a Web Link</font></b></div>
      </td>
    </tr>
   <tr>
      <td width="150" height="28"> 
        <div align="right"><font face="Arial" size="2">Title :</font></div>
      </td>
      <td width="325" height="28"> 
        <font face="Arial" size="2"> 
        <input type="text" name="tittle" size="34" disabled value="<%= title %>">
        </font>
      </td>
    </tr>
   <tr>
      <td width="150" height="29"> 
        <div align="right"><font size="2" face="Arial">Link :</font></div>
      </td>
      <td width="325" height="29"> 
        <font face="Arial" size="2"> 
        <input type="text" name="url" size="34" value="<%= url %>"></font></td></tr>
  
  <tr><td colspan=2 align=center width="481" height="1" bgcolor="#42A2E7">&nbsp;</td></tr>
<tr><td colspan=2 align=right width="481" height="47">
    <p align="center"><input type=image border="0" src="../images/submit.gif">
</td>
</tr>
</table>
	<input type=hidden name="coursename" value="<%= courseName %>">
	<input type=hidden name="classid" value="<%= classId %>">
	<input type=hidden name="title" value="<%= title %>">
	<input type=hidden name="courseid" value="<%= courseId %>">
	<input type=hidden name="classname" value="<%= className %>">
	<input type="hidden" name="workid" value="<%=materialId%>">
	<input type="hidden" name="cat" value="<%=catId%>">
</form>
</body>
</html>
