
<%@ page language="java" import="java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="con3" class="sqlbean.WHDbBean" scope="page" />
<%
String schoolId="",teacherId="",studentId="",classId="",sess="",mode="",selectedIds="",id="",courseId="";
String meetingId="",cId="";
String query1="",query2="";
Connection con=null,con2=null;
ResultSet rs=null,rs1=null,rs2=null;
Statement st=null,st1=null,st2=null;
boolean flag=false;
File folder=null;
Hashtable selectedIdsHTable=null;
//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
//final  String dbDriver = "com.mysql.jdbc.Driver"; 
%>
<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	//classId="C000";
	classId=(String)session.getAttribute("classid");
	courseId=request.getParameter("courseid");
	meetingId=request.getParameter("mid");
	String query="";
	Hashtable hs=null;
	//Class.forName(dbDriver );
	//con2 = DriverManager .getConnection( dbURL );
	con2=con3.getConnection();
	con=con1.getConnection();
	
	mode="mod";
	//con=con1.getConnection();
	st=con.createStatement();
	st1=con2.createStatement();
	st2=con.createStatement();
	if(mode.equals("mod"))
	{
		rs1=st1.executeQuery("select logon_name from invitations where meeting_id_fk="+meetingId+"");
		selectedIdsHTable=new Hashtable();
		while(rs1.next())
		{
			id=rs1.getString(1);
			selectedIdsHTable.put(id,id);
		}
		session.setAttribute("selectedids",selectedIdsHTable);
	}
	
	
%>
<html>
<head>
<title></title>
<script>
var checked=new Array();
var unchecked=new Array();

function selectAll()
{
	if(document.studentslist.selectall.checked==true)
	{
		with(document.studentslist)
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'studentids')
					elements[i].checked = true;
            }
		}
	}
	else
	{
		with(document.studentslist)
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'studentids'){
					if(elements[i].value != "<%=classId%>_vstudent")
					elements[i].checked = false;
				}
            }
		}
	}
}

function validate()
{
	var chk="false";
	var len2=window.document.studentslist.elements.length;
	var arr=document.getElementsByName("studentids");
	for(var i=0,j=0,k=0;i<arr.length;i++)
	{
		if(arr[i].checked)
		{
			chk=true;
			checked[j++]=arr[i].value;
		}
		else
		{
			unchecked[k++]=arr[i].value;
		}
	}
	if(chk=="false")
	{
		if(confirm("Are you sure that you don't want to assign the course to any student?")==true)
		{
			document.studentslist.checked.value=checked;
			document.studentslist.unchecked.value=unchecked;
		}
		else
			return false;
	}
	else
	{
		document.studentslist.checked.value=checked;
		document.studentslist.unchecked.value=unchecked;
	}
}
function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
			document.location.href="WHStudentsList.jsp?mid=<%=meetingId%>&userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		alert("Select Grade")
		grades='no';
		location.href="MeetingPermissions.jsp?mid=<%=meetingId%>&userid=<%=teacherId%>";						
	}
}

</script>

</head>
<body topmargin=3 leftmargin="0" marginwidth="0">

<form name="studentslist" method="post" action="MeetingInvitations.jsp?mid=<%=meetingId%>" onSubmit="return validate();">
<p align="right">
	<a href='javascript:history.go(-1);'><font face="Arial" size="2"><b>Back</b></font></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<center>
<%
	if(!courseId.equals("teachers"))		// Start of IF
	{
		rs2=st2.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
	
%>
<table border="0" cellpadding="5" cellspacing="0" width="70%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
    <td width="40%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px" size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">
    <option value="no" selected>Select Course/Teacher</option>
	<option value="teachers" selected>Teachers List</option>
<%		
		
		while(rs2.next())
		{
			cId=rs2.getString("course_id");
			if(cId.equals(courseId))
			{
				
%>
				<option value='<%=cId%>' selected>&nbsp;&nbsp;<%=rs2.getString("course_name")%>&nbsp;</option>
<%			}
			else
			{
				
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs2.getString("course_name")%>&nbsp;</option>
<%			}
		
		}
		rs2.close();
%>
    </select>
	<script>
			document.studentslist.gradeid.value='<%=courseId%>';
		</script></td>
    
  </tr>
  
  
</table>
<BR>
<table border="1" width="70%" cellspacing="0" >
	<tr>
<%
	//rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and grade='"+classId+"' order by username");
	
	rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.username!='"+classId+"_vstudent' and s.status=1 "+query+" order by s.emailid");
	
	//rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1 "+query+" order by s.subsection_id");
%>
	</tr>  
	<tr>      
  		<td width="10" height="24" bgcolor="#96C8ED">
			<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all students">
		</td>      
		<td align="left" width="40%" bgcolor="#96C8ED"><b>
			<font face="Arial" size="2" color="#000066">Student Id</font></b></td> 
		<td align="left" width="60%" bgcolor="#96C8ED"><b>
			<font face="Arial" size="2" color="#000066">Student Name</font></b></td>      
	</tr>
	
<%
		while(rs.next())
		{
			studentId=rs.getString("emailid");
			String block="";
			if(studentId.equals(classId+"_vstudent")) block="onclick='this.checked=true' checked ";
			if(mode.equals("mod"))
			{
				
				if(studentId.equals(selectedIdsHTable.get(studentId)))
				{
%>
		<tr>
			<td align='left' width='19'>
				<input type='checkbox' name='studentids' checked value="<%=studentId%>"  <%=block%>></td>      
<%
				}
				else
				{
%>
		<tr>
			<td align="left" width="19"><input type="checkbox" name="studentids" value="<%=studentId%>" <%=block%>></td>      
<%
				}
			}
			else
			{
%>
		<tr>
			<td align='left' width='19'><input type='checkbox' name='studentids' value='<%=studentId%>' <%=block%>></td>      
<%
			}
%>
			<td align='left' width='40%'>
				<font face='Arial' size='2'><%=studentId%></font>&nbsp;</td>
			<td align='left' width='60%'><b>
				<font face='Arial' size='2'><%=rs.getString("fname")%> <%=rs.getString("lname")%></font></b> &nbsp;</td>
<%
			flag=true;
		}	
		if(!flag)
		{
%>
		<tr>
			<td colspan=4><font size='2' face='arial'><b>Presently there are no students available.</b></font></td>
		</tr>
<%
		}
%>
		<tr>
			<TD width="100%" colspan="3" height="37" align="center">
				<input type="image" TITLE="Done" src="../images/submit.jpg" width="90" height="37"></TD>
        </tr>
</table>

<%
	}		// End of IF 
	else	// Start of ELSE
	{
		rs2=st2.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
	
%>
<table border="0" cellpadding="5" cellspacing="0" width="70%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
    <td width="40%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px" size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">
    <option value="no" selected>Select Course/Teacher</option>
	<option value="teachers" selected>Teachers List</option>
<%		
		
		while(rs2.next())
		{
			cId=rs2.getString("course_id");
			
			if(cId.equals(courseId))
			{
				
%>
				<option value='<%=cId%>' selected>&nbsp;&nbsp;<%=rs2.getString("course_name")%>&nbsp;</option>
<%			}
			else
			{
				//System.out.println("ELSE ELSE ***"+cId);
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs2.getString("course_name")%>&nbsp;</option>
<%			}
		
		}
		rs2.close();
%>
    </select>
	<script>
			document.studentslist.gradeid.value='<%=courseId%>';
		</script></td>
    
  </tr>
  
  
</table>
<BR>
		<table border="1" width="70%" cellspacing="0">
	<tr>
<%
	rs=st.executeQuery("select * from teachprofile where schoolid='"+schoolId+"' and username!='"+teacherId+"' order by username");
%>
	</tr>  
	<tr>      
  		<td width="10" height="24" bgcolor="#96C8ED">
			<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all students">
		</td>      
		<td align="left" width="40%" bgcolor="#96C8ED"><b>
			<font face="Arial" size="2" color="#000066">Teacher Id</font></b></td> 
		<td align="left" width="60%" bgcolor="#96C8ED"><b>
			<font face="Arial" size="2" color="#000066">Teacher Name</font></b></td>      
	</tr>
	
<%
		while(rs.next())
		{
			studentId=rs.getString("email");
			String block="";
			if(studentId.equals(classId+"_vstudent")) block="onclick='this.checked=true' checked ";
			if(mode.equals("mod"))
			{
				//System.out.println("studentId...WHStudentsList.jsp......"+studentId+"....."+selectedIdsHTable.get(studentId));
				if(studentId.equals(selectedIdsHTable.get(studentId)))
				{
%>
		<tr>
			<td align='left' width='19'>
				<input type='checkbox' name='studentids' checked value="<%=studentId%>"  <%=block%>></td>      
<%
				}
				else
				{
%>
		<tr>
			<td align="left" width="19"><input type="checkbox" name="studentids" value="<%=studentId%>" <%=block%>></td>      
<%
				}
			}
			else
			{
%>
		<tr>
			<td align='left' width='19'><input type='checkbox' name='studentids' value='<%=studentId%>' <%=block%>></td>      
<%
			}
%>
			<td align='left' width='40%'>
				<font face='Arial' size='2'><%=studentId%></font>&nbsp;</td>
			<td align='left' width='60%'><b>
				<font face='Arial' size='2'><%=rs.getString("firstname")%> <%=rs.getString("lastname")%></font></b> &nbsp;</td>
<%
			flag=true;
		}	
		if(!flag)
		{
%>
		<tr>
			<td colspan=4><font size='2' face='arial'><b>Presently there are no teachers available.</b></font></td>
		</tr>
<%
		}
%>
		<tr>
			<TD width="100%" colspan="3" height="37" align="center">
				<input type="image" TITLE="Done" src="../images/submit.jpg" width="90" height="37"></TD>
        </tr>
</table>
<%

	} // End of ELSE
%>
</center>
<input type="hidden" name="checked" value="">
<input type="hidden" name="unchecked" value="">
<font face=Arial size=2>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("CourseStudentsList.jsp","Operations on database and reading parameters","Exception",e.getMessage());
	out.println(e);
}
finally
{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(Exception e)
	{  
		ExceptionsFile.postException("CourseStudentsList.jsp","closing connections","Exception",e.getMessage());
		System.out.println("Error : Finallly  - "+e.getMessage()); 
	}
}
%>
</font>
</form>
</body>
</html>