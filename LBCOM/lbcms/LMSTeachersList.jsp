
<%@ page language="java" import="java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String schoolId="",teacherId="",studentId="",classId="",sess="",mode="",selectedIds="",id="",courseId="";
String courseName="",cId="";
String query1="",query2="";
Connection con=null;
ResultSet rs=null,rs1=null,rs2=null;
Statement st=null,st1=null,st2=null;
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
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	//classId="C000";
	//classId=(String)session.getAttribute("classid");
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");

	
	String query="";
	Hashtable hs=null;
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	mode="mod";
	if(mode.equals("mod"))
	{
		rs1=st1.executeQuery("select teacher_id from lbcms_dev_course_permissions where dev_course_id='"+courseId+"'");
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
		if(confirm("Are you sure that you don't want to assign the course to any teacher?")==true)
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
			document.location.href="WHStudentsList.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		alert("Select Grade")
		grades='no';
		location.href="MeetingPermissions.jsp?userid=<%=teacherId%>";						
	}
}

function viewUserManual()
{
	
window.open("/LBCOM/manuals/Lessons.html","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

</script>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr>
        <!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	
  </table>
   
<form name="studentslist" method="post" action="CoursePermissions.jsp?userid=<%=teacherId%>&courseid=<%=courseId%>" onSubmit="return validate();">
<p align="right">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<center>
<%
	if(!courseId.equals("teachers"))		// Start of IF
	{
		rs2=st2.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
	
%>
<table border="0" cellpadding="5" cellspacing="0" width="90%" id="AutoNumber1" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
   <!--  <td width="40%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px" size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">
    <option value="teachers" selected>Teachers List</option>

    </select>
	</td> -->
	<td width="80%" height="23" colspan="2" class="gridhdrNew"><font color="black" size="2"> Course Name:<b> <%=courseName%></b></font></td>
    <td width="20%" height="23" colspan="2" class="gridhdrNew">
    <a href='javascript:history.go(-1);'><font face="Arial" color="black" size="2"><b>Back</b></font></a>
	</td>
    
  </tr>
  
  
</table>

<BR>
		<table border="1" width="90%" cellspacing="0">
	<tr>
<%
	rs=st.executeQuery("select * from teachprofile where schoolid='"+schoolId+"' and username!='"+teacherId+"' order by username");
%>
	</tr>  
	<tr>      
  		<td width="10" height="24" class="gridhdrNew1">
			<input type="checkbox" name="selectall" onClick="selectAll()" value="ON" title="Select or deselect all students">
		</td>      
		<td align="left" width="40%" class="gridhdrNew1"><b>
			<font face="Arial" size="2" >Teacher Id</font></b></td> 
		<td align="left" width="60%" class="gridhdrNew1"><b>
			<font face="Arial" size="2" >Teacher Name</font></b></td>      
	</tr>
	
<%
		while(rs.next())
		{
			studentId=rs.getString("email");
			String block="";
			if(studentId.equals(classId+"_vstudent")) block="onclick='this.checked=true' checked ";
			if(mode.equals("mod"))
			{
				
				if(studentId.equals(selectedIdsHTable.get(studentId)))
				{
%>
		<tr>
			<td align='left' width='19' class="gridhdrNew1">
				<input type='checkbox' name='studentids' checked value="<%=studentId%>"  <%=block%>></td>      
<%
				}
				else
				{
%>
		<tr>
			<td align="left" width="19" class="gridhdrNew1"><input type="checkbox" name="studentids" value="<%=studentId%>" <%=block%>></td>      
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
			<td align='left' width='40%' class="gridhdrNew1">
				<font face='Arial' size='2'><%=studentId%></font>&nbsp;</td>
			<td align='left' width='60%' class="gridhdrNew1"><b>
				<font face='Arial' size='2'><%=rs.getString("firstname")%> <%=rs.getString("lastname")%></font></b> &nbsp;</td>
<%
			flag=true;
		}	
		if(!flag)
		{
%>
		<tr>
			<td colspan=4 class="gridhdrNew1"><font size='2' face='arial'><b>Presently there are no teachers available.</b></font></td>
		</tr>
<%
		}
%>
		<tr>
			<TD width="100%" colspan="3" height="37" align="center class="gridhdrNew1"">
				<input type="image" TITLE="Done" src="images/submit.jpg" width="90" height="37"></TD>
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