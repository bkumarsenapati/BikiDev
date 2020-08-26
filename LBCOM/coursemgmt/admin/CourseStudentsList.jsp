  
<%@ page language="java" import="java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String schoolId="",teacherId="",studentId="",courseName="",folderName="",courseDes="",state="",classId="",subject="",acYear="",sess="",mode="",selectedIds="",id="",courseId="",nostd="";
String className="";
Connection con=null;
ResultSet rs=null;
Statement st=null;
boolean flag=false;
File folder=null;
Hashtable selectedIdsHTable=null;
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
	//teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	classId=request.getParameter("classid");
	courseName=request.getParameter("coursename");
	courseId=request.getParameter("courseid");
	className=request.getParameter("classname");
	nostd=request.getParameter("noofstd");
	
	String subsectionId=request.getParameter("subsectionid");
	String query="";
	Hashtable hs=null;
	if(subsectionId==null)
	{
		query="";
	}
	else
	{
		if(subsectionId.equals("all"))
		{
			query="";
		}
		else
		{
			StringTokenizer stk=new StringTokenizer(subsectionId,",");
			if(stk.hasMoreTokens())
			{
				query=" and (subsection_id='"+stk.nextToken()+"'";
				while(stk.hasMoreTokens())
				{
					query+=" or subsection_id='"+stk.nextToken()+"'";
				}
				query+=")";
			}
			else
			{
				//query=" where (subsection_id='"
			}
		}
	}
	mode=request.getParameter("mode");
	con=con1.getConnection();
	st=con.createStatement();
	
	if(mode.equals("mod"))
	{
		rs=st.executeQuery("select student_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		selectedIdsHTable=new Hashtable();
		while(rs.next())
		{
			id=rs.getString(1);
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
	var stdCount=0;
	for(var i=0,j=0,k=0;i<arr.length;i++)
	{

		if(arr[i].checked)
		{
			chk=true;
			checked[j++]=arr[i].value;
			stdCount=stdCount+1;
			var nostds=<%=nostd%>;
			var justnostd=stdCount-nostds;
		}
		else
		{
			unchecked[k++]=arr[i].value;
		}
		
	}
	if(i==nostds)
	{
			
				if(nostds<stdCount)
				{
					alert("You have added " +justnostd+ " new student(s) successfully!");
				}
				else if(nostds>stdCount)
				{
					alert("You have unassigned "+ justnostd+" student(s) successfully!");
				}
				else
				{
					alert("You did not make any changes!");
				}
	}
	else
	{
				if(nostds<stdCount)
				{
					alert("You have added " +justnostd+ " new student(s) successfully!");
				}
				else if(nostds>stdCount)
				{
					alert("You have unassigned "+ justnostd+" student(s) successfully!");
				}
				else if(nostds=stdCount)
				{
					alert("You did not make any changes!");
				}
				else
				{
					alert("You made some assignings and unassignings!");
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

function call(courseid,coursename,classid,classname,mode)
{
	var sec=document.getElementsByName("subsection_id");
	var subsec="";
	var flag=false;
	for(var i=0;i<sec[0].length;i++)
	{
		flag=true;
		if(sec[0].options[i].selected)
		{
			if(sec[0].options[i].value=="all")
			{
				subsec="all,";
				//i=sec[0].length;
				break;
			}
			subsec+=sec[0].options[i].value+",";
		}
	}
	subsec=subsec.substr(0,subsec.length-1);
	
	if(flag==true)
	{
		document.location.href="CourseStudentsList.jsp?mode="+mode+"&coursename="+coursename+"&classid="+classid+"&courseid="+courseid+"&classname="+classname+"&subsectionid="+subsec;
	}
	else
	{
		alert('Select the Group / Subsection');
		return false;
	}
}
</script>

</head>
<body topmargin=3 leftmargin="0" marginwidth="0">

<form name="studentslist" method="post" action="DistributeCourse.jsp?courseid=<%=courseId%>" onSubmit="return validate();">
<p align="right">
	<a href='javascript:history.go(-1);'><font face="Arial" size="2"><b>Back</b></font></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<center>

<table border="1" width="70%" cellspacing="0">
	<tr>
<%
		hs=new Hashtable();
		rs=st.executeQuery("select * from subsection_tbl where school_id='"+schoolId+"' and class_id='"+classId+"'");
		if(rs.next())
		{
%>
			<td width='400' colspan='2' align='left'>
				<font face='arial' size='2'><b>Group / Subsection :</b></font>
				<select name='subsection_id' size='1' multiple='true'>
					<option value='all'>All</option>
					<option value='nil'>Default</option>
<%
			do
			{
%>
					<option value='<%=rs.getString("subsection_id")%>'><%=rs.getString("subsection_des")%></option>
<%
					hs.put(rs.getString("subsection_id"),rs.getString("subsection_des"));
			}while(rs.next());
%>
				</select>&nbsp;&nbsp
				<input type='button' value='>>' name='list' onclick="call('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=mode%>');"></td>
<%
		}
		rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and status>0 and grade='"+classId+"' "+query+" order by username");
%>
	</tr>  
	<tr>      
  		  
		<td align="left"  bgcolor="#E7D57C" colspan="3"><b>Course Name:
			<font face="Arial" size="2" color="#0033FF">&nbsp;<%=courseName%></font></b></td> 
		    
	</tr>
	<tr>      
  		<td width="10" height="24" bgcolor="#E7D57C">
			<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all students">
		</td>      
		<td align="left" width="40%" bgcolor="#E7D57C"><b>
			<font face="Arial" size="2" color="#000066">Student Id</font></b></td> 
		<td align="left" width="60%" bgcolor="#E7D57C"><b>
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
				<input type="image" TITLE="Done" src="images/submit.gif" width="90" height="37"></TD>
        </tr>
</table>
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