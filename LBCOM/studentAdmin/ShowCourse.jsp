<%@ page errorPage="/LBCOM/ErrorPage.jsp" %>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile,java.util.ListIterator,java.util.Vector" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String foldername=null,studentid=null,schoolid=null,courseId="";
boolean crFlag=false;
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
var courseArray = new Array();
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
	opener.window.top.frames['left'].chatcid = courseArray[subcourse];
	window.location.href="../babylon/babylon.jsp?course="+subcourse;

	return false;
}

</script>
</head>
<body bgcolor="#B0A891">
<form name="showcourse">
<center><h3><span style="font-size:11pt;"><font face="Arial">Select a Course to Launch Chat for that Course</font></span></h3></center> 
<%
try
{
	studentid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
//	studentid=studentid.replace('@','_');
//	studentid=studentid.replace('.','_');
//	out.println(teacherid);

	con = con1.getConnection();

	st=con.createStatement();
	
	//rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolid+"' and studentids like '%"+studentid+"%' ");

	rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+studentid+"' and schoolid='"+schoolid+"'");
	if(rs.next())
	{
	     if((rs.getInt("crossregister_flag"))==1)
	                       crFlag=true;
	}
        rs=st.executeQuery(" select distinct c.school_id, c.course_name, c.course_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentid+"' and status='1' and c.school_id='"+schoolid+"'");
   	
	out.println("<center><table>");
	while(rs.next())
	{
		foldername=rs.getString("course_name");
		courseId = rs.getString("school_id")+"/"+rs.getString("course_id");
                out.println("<script> courseArray['"+foldername+"']='"+courseId+"'; </script>");
%>

	
		<tr>
			<td width="250">
			<input type="radio" value="<%=foldername%>" name=course><font face="Garamond"><%=foldername%></font><br>
			</td>
		</tr>
	

<%
	}
	if(crFlag==true)
	{
	        rs=st.executeQuery("select schoolid from studentprofile where username='"+schoolid+"_"+studentid+"'");
		Vector schoolNames=new Vector();
		while(rs.next())
		{
			schoolNames.add(rs.getString("schoolid"));
		}
		rs.close();
	
		ListIterator itr = schoolNames.listIterator();
		while(itr.hasNext())
		{
		   String school = (String)itr.next();
	            rs=st.executeQuery(" select distinct c.school_id, c.course_name, c.course_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+schoolid+"_"+studentid+"' and status='1' and c.school_id='"+school+"'");
   	            while(rs.next())
	            {
			foldername=rs.getString("course_name");
			courseId = rs.getString("school_id")+"/"+rs.getString("course_id");
                	out.println("<script> courseArray['"+foldername+"']='"+courseId+"'; </script>");
%>
	
		   <tr>
			<td width="250">
			<input type="radio" value="<%=foldername%>" name=course><font face="Garamond"><%=foldername%></font><br>
			</td>
		   </tr>
		   
<%		
		      } 
	          }
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
				if(rs!=null)
					rs.close();
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				con.close();
			}catch(Exception e){
				ExceptionsFile.postException("ShowCourse.jsp","closing resultset,statement and connection objects","Exception",e.getMessage());
				System.out.println("Connection close failed");
			}
		}
%>
</form>
</body>
</html>
