<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<% 
	String schoolId="",userId="",userType="",toUser="all",toSchool="all",toGroup="allclass",toAdmin="yes";
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
%>
<%	
try{
		userId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
                userType=request.getParameter("type");
		
		con = con1.getConnection();
		st=con.createStatement();		

		rs=st.executeQuery("select * from mail_priv where from_school='"+schoolId+"' and from_user='"+userType+"'");
                if(rs.next())
		{
		    toSchool=rs.getString("to_school");
		    toUser=rs.getString("to_user");
		    toGroup=rs.getString("to_group");
		    toAdmin=rs.getString("to_admin");
		}
}
catch(Exception ex)
{
	ExceptionsFile.postException("DefineSendMailPrivilege.jsp","creating statement and connection objects","Exception",ex.getMessage());		
}
finally
{
	try
	{
		if(con!=null)
			con.close();
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("DefineSendMailPrivilege.jsp","operations on database","Exception",e.getMessage());
	}
}
%>

<html>
 <head>
 <title></title>
 </head>
 <body>
 <form name="privform" action="SendMailPrivilege.jsp?type=<%=userType%>" method="POST">
 <div align="center"><br>
 <table bgcolor="#EEBA4D" width=350>
       <tr>
		<td align="center"><b>Define Mail Sending Privilege for <%=userType%>s</b></td>		
	</tr>
 </table>
 <br><br>
 <table>
 	<tr>
		<td><font size="2">To School</font></td>
		<td><font size="2">:</font></td>	
		<td><select name="toschool">
		     <%  if(toSchool.equals("own")){   %>
		     	<option value="own" selected>Own School</option>
		     	<option value="all">all Schools</option>
		     <%  }else{ %>
		        <option value="own">Own School</option>
		     	<option value="all" selected>All Schools</option>
		     <%    }%>   
		    </select>
		</td>	
	</tr>
	<tr>
		<td><font size="2">To User</font></td>
		<td><font size="2">:</font></td>	
		<td><select name="touser">
		     <%  if(toUser.equals("student")){  %>
		     	<option value="student" selected>Student&nbsp;&nbsp;&nbsp;&nbsp;</option>
		     	<option value="teacher">Teacher</option>
		     	<option value="all">Both</option>
		     <% }else if(toUser.equals("teacher")){  %>
		     	<option value="student">Student&nbsp;&nbsp;&nbsp;&nbsp;</option>
		     	<option value="teacher" selected>Teacher</option>
		     	<option value="all">Both</option>
		     <% }else{  %>
		     	<option value="student">Student&nbsp;&nbsp;&nbsp;&nbsp;</option>
		     	<option value="teacher">Teacher</option>
		     	<option value="all" selected>Both</option>
		     <%  }%>
		    </select>
		</td>
	</tr>
	<tr>
		<td><font size="2">To Group</font></td>
		<td><font size="2">:</font></td>	
		<td><select name="togroup">
		     <%  if(toGroup.equals("owncourse")){ %>
		     	<option value="ownclass">Own Class&nbsp;&nbsp;</option>
		     	<option value="allclass">All Classes</option>
		     	<option value="owncourse" selected>Own Course</option>
		     	<option value="allcourse">All Courses</option>
		     <% }else if(toGroup.equals("ownclass")){  %>
		     	<option value="ownclass" selected>Own Class&nbsp;&nbsp;</option>
		     	<option value="allclass">All Classes</option>
		     	<option value="owncourse">Own Course</option>
		     	<option value="allcourse">All Courses</option>
		     <% }else if(toGroup.equals("allcourse")){  %>
		     	<option value="ownclass">Own Class&nbsp;&nbsp;</option>
		     	<option value="allclass">All Classes</option>
		     	<option value="owncourse">Own Course</option>
		     	<option value="allcourse" selected>All Courses</option>
		     <% }else{ %>
		     	<option value="ownclass">Own Class&nbsp;&nbsp;</option>
		     	<option value="allclass" selected>All Classes</option>
		     	<option value="owncourse">Own Course</option>
		     	<option value="allcourse">All Courses</option>
		     <% }  %>
		    </select>
		</td>
	</tr>
 </table>
 <table>
       <tr>
		<td>
		<% if(toAdmin.equals("no")){%>
			<input type="checkbox" name="toadmin" value="yes">
		<% }else{  %>
			<input type="checkbox" name="toadmin" value="yes" checked>
		<% }  %>
		</td>		
		<td><font size="2"><%=userType%>s can send mail to admin</font></td>		
	</tr>
 </table>
 <table>
       <tr>
		<td><input type="image" src="images/submit.gif"></td>
		<td><input type="image" src="images/cancel.gif" onclick="javascript: history.back();"></td>		
	</tr>
 </table>
 </div>
 </form>
 </body>
 </html>