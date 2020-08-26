<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String foldername="",teacherid="",schoolid="",teacheridurl="",courseid="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;
//ServletOutputStream out=null;
%>
<html>
<head>
<title><%=application.getInitParameter("title")%></title> 
<script>
var subcourse;
var c=0;
function getcourse()
{
	var len = window.document.showcourse.elements.length;

	for(var i=0;i<len;i++)
	{
		if(window.document.showcourse.elements[i].checked)
		{
			subcourse = window.document.showcourse.elements[i].value;
			c=1;
		}
	}

	if(c==0)
	{ alert("Please select a course");
	  return false;
	}
	//window.location.href="/LBCOM/babylon/babylon.jsp?course="+subcourse;
	window.location.href="/LBCOM/WhiteBoard/WhiteBoard.jsp?courseid="+subcourse+"&schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>";

	


	return false;
}

</script>
<body bgcolor="#A8B8D0">
<form name="showcourse" method="POST">
<center><h3><font face="Arial"><span style="font-size:11pt;">Select a Course to Launch Chat for that Course</span></font></h3></center> 
<%
try
{
	teacherid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	teacherid=teacherid.replace('@','_');
	teacherid=teacherid.replace('.','_');
//	out.println(teacherid);

	con = con1.getConnection();
	st=con.createStatement();
	
	rs=st.executeQuery("select  distinct(course_name),course_id from coursewareinfo where teacher_id='"+teacherid+"' and school_id='"+schoolid+"' and status=1");

	out.println("<center><table>");
	while(rs.next())
	{
		foldername=rs.getString("course_name");
		courseid=rs.getString("course_id");
%>


		<tr>
			<td width="250">
			<input type="radio" value="<%=courseid%>" name=course><font face="Garamond"><%=foldername%></font><br>
			</td>
		</tr>


<%
	}
	out.println("</table></center>");

%>
		<center><input type=image src="images/chatstart.gif" onclick="return getcourse();" width="106" height="51"></center>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("ShowCourse.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}
finally
		{
			try
			{
				//out.close();
				//rs.close();
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception ex){
				ExceptionsFile.postException("ShowCourse.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
				
			}
			
		}
%>
</form>
</body>
</html>
