<%@  page language="java"  import="java.sql.*,java.util.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	String user="",schoolId="",dir="",fId="",crtBy="",uType="",logType="",emailId="",mode="";
	String fName="",fDesc="",accCode="",status="",selTag="";
	Hashtable tgrade=null,sgrade=null,scourses=null;
	int i=0,j=0;
	boolean tFlag=false,sFlag=false,cFlag=false;
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	uType    = (String)session.getAttribute("logintype");

	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	emailId = request.getParameter("emailid");
	schoolId = request.getParameter("schoolid");
	if(emailId==null)
	{
		emailId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
	}
	user = emailId;
	logType=(String)session.getAttribute("logintype");
	fId=request.getParameter("fid");
	fName=request.getParameter("fname");
	mode=request.getParameter("mode");

	boolean flag=false;
	try
	{
		con = con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("EditForum.jsp","creating connection and statement objects","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Edit Forum</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function changeStatus()
{
	var stat=document.frm.statussel.value;
	document.frm.status.value=stat;
}
function checkTchGrade()
{
	document.frm.teachsel[1].checked=true;
	document.frm.teachers.disabled=false;
}
function checkStdGrade()
{
	document.frm.studsel[1].checked=true;
	document.frm.students.disabled=false;
}
function checkStdCourse()
{
	document.frm.studsel[2].checked=true;
	document.frm.courses.disabled=false;
}
function goBack()
{
	if(uType.equals("admin"))
						uType="school";
	if(uType.equals("teacher"))
						uType="teacher";
	document.frm.action="/LBCOM/"+uType+"Admin/ForumMgmtIndex.jsp?schoolid=<%=schoolId%>&emailid=<%=emailId%>";
	document.submit;	
}
function tcheck()
{
	document.frm.teachers.selectedIndex=-1;
	document.frm.teachers.disabled=true;
}
function tuncheck()
{
	document.frm.teachers.disabled=false;
}
function suncheck()
{
	document.frm.courses.selectedIndex=-1;
	document.frm.students.disabled=false;
	document.frm.courses.disabled=true;
}
function scuncheck()
{
	document.frm.students.selectedIndex=-1;
	document.frm.students.disabled=true;
	document.frm.courses.disabled=false;
}
function scheck()
{
	document.frm.students.selectedIndex=-1;
	document.frm.courses.selectedIndex=-1;
	document.frm.students.disabled=true;
	document.frm.courses.disabled=true;
}
function sccheck()
{
	document.frm.students.selectedIndex=-1;
	document.frm.courses.selectedIndex=-1;
	document.frm.courses.disabled=true;
}
function getvals()
{
	var k=0;
	var tString="-";
	var sString="-";
	var cString="-";
	if(document.frm.teachsel[0].checked)
	{
		k=1;
		document.frm.teachers.disabled=false;
		for(i=0;i<document.frm.teachers.length;i++)
			tString+="T:"+document.frm.teachers[i].value+":ALL-";
	}
	else if(document.frm.teachsel[1].checked)
	{
		var c=0;
		k=1;
		for(i=0;i<document.frm.teachers.length;i++)
		{
			if(document.frm.teachers[i].selected)
			{
				c=1;
				tString+="T:"+document.frm.teachers[i].value+":ALL-";
			}
		}
		if(c==0)
		{
			alert("Please select atleast one Grade from teachers list");
			return false;
		}
	}
	if(document.frm.studsel[0].checked)
	{
		document.frm.students.disabled=false;
		k=1;
		for(i=0;i<document.frm.students.length;i++)
			sString+="S:"+document.frm.students[i].value+":ALL-";
	}
	else if(document.frm.studsel[1].checked)
	{
		c=0;
		k=1;
		for(i=0;i<document.frm.students.length;i++)
		{
			if(document.frm.students[i].selected)
			{
				c=1;
				sString+="S:"+document.frm.students[i].value+":ALL-";
			}
		}
		if(c==0)
		{
			alert("Please select atleast one Grade from students list");
			return false;
		}
	}
	else if(document.frm.studsel[2].checked)
	{
		c=0;
		k=1;
		for(i=0;i<document.frm.courses.length;i++)
		{
			if(document.frm.courses[i].selected)
			{
				c=1;
				sString+="S:"+document.frm.courses[i].value+":ALL-";
			}
		}
		if(c==0)
		{
			alert("Please select atleast one Course from the Courses List");
			return false;
		}
	}
	if(k==0)
	{
		alert("Please select atleast one user");
		return false;
	}

	document.frm.action="/LBCOM/forums.EditForum?tstring="+tString+"&sstring="+sString+"&mode=edit";
	document.submit;
}
//-->
</SCRIPT>

</head>
<%
	try
	{
		rs1=st1.executeQuery("select * from forum_master where school_id='"+schoolId+"' and forum_id='"+fId+"'");
	    if(rs1.next())
		{
			fDesc=rs1.getString("forum_desc");
			crtBy=(rs1.getString("created_by")).trim();
			accCode=rs1.getString("access_code");
			status=rs1.getString("status");
		}
		rs1.close();
%>
<body>
<center>
<form name="frm" method="post">

<table border="0" cellspacing="1" width="61%" id="AutoNumber2" bgcolor="#A3A3A3">
  <tr>
    <td width="90%" align="center"><font face="Verdana" size="4"><b>Edit Forum</b></font></td>
	<td width="10%" align="right"><font face="Verdana" size="2">
	<%
	if(uType.equals("admin"))
		{
	%>
	<b>
		<a href="/LBCOM/schoolAdmin/ForumMgmtIndex.jsp?schoolid=<%=schoolId%>&emailid=<%=emailId%>">BACK</a></b></font>
		<%
		}
	%>
	<%
	if(uType.equals("teacher"))
		{
	%>
	<b>
		<a href="/LBCOM/teacherAdmin/ForumMgmtIndex.jsp?schoolid=<%=schoolId%>&emailid=<%=emailId%>">BACK</a></b></font>
		<%
		}
	%>
	</td>
  </tr>
</table>
<br>
<table border="0" cellspacing="1" width="61%" id="AutoNumber1" height="84">
  <tr>
    <td width="25%" bgcolor="#A3A3A3" height="23"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Forum Name :</font></b></td>
    <td width="49%" height="23" bgcolor="#D4D4D4">
    <input type="text" name="fname" value="<%=fName%>" size="29"></td>
  </tr>
  <tr>
    <td width="25%" bgcolor="#A3A3A3" height="25"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Description :</font></b></td>
    <td width="49%" height="25" bgcolor="#D4D4D4">
    <textarea rows="4" name="fdesc" cols="29"><%=fDesc%></textarea></td>
  </tr>
  <tr>
    <td width="25%" bgcolor="#A3A3A3" height="27"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Forum State :</font></b></td>
<%
		if(status.equals("1"))
		{
%>
			<td width="49%" height="27" bgcolor="#D4D4D4">
				<select size="1" name="statussel" onchange="changeStatus()">
					<option value="1" selected>Open</option>
					<option value="0">Close</option>
				</select>
			</td>
<%
		}
		else
		{
%>
			<td width="49%" height="27" bgcolor="#D4D4D4">
				<select size="1" name="statussel" onchange="changeStatus()">
					<option value="1">Open</option>
					<option selected value="0">Close</option>
				</select>
			</td>
<%
		}	
%>
<%
		tgrade=new Hashtable();
		i=0;
						
		rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from teachprofile where schoolid='"+schoolId+"')");
			
		while(rs.next())
		{
			tgrade.put(rs.getString("class_id"),rs.getString("class_des"));
			i++;
		}
			
		i=0;
		j=0;
		sgrade=new Hashtable();
		scourses=new Hashtable();

		rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolId+"' order by grade)");
		while(rs.next())
		{
			sgrade.put(rs.getString("class_id"),rs.getString("class_des"));
			i++;
		}
if(uType.equals("teacher"))
	{
		rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+user+"' and status>0 order by course_name");

		while(rs.next())
		{
			scourses.put(rs.getString("course_id"),rs.getString("course_name"));
			j++;
		}	
	}
if(uType.equals("admin"))
	{
		rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_name");

		while(rs.next())
		{
			scourses.put(rs.getString("course_id"),rs.getString("course_name"));
			j++;
		}	
	}
%>
  </tr>
  </table>
<hr color="#000000" width="600" size="1">
<table border="1" cellspacing="1" width="61%" id="AutoNumber3" height="235" bgcolor="#D4D4D4">
  <tr>
    <td width="200%" colspan="5" bgcolor="#A3A3A3" height="16"><b>
    <font face="Verdana" size="2"> Select the  group of users who can access this forum:</font></b></td>
  </tr>
  <tr>
   <td width="3%" bgcolor="#A3A3A3" height="19">&nbsp;</td>
    <td width="43%" bgcolor="#A3A3A3" height="19">
    <p align="center"><font face="Verdana" size="2" color="#FFFFFF"><b>Teachers</b></font></td>
    <td width="4%" bgcolor="#A3A3A3" height="19">&nbsp;</td>
    <td width="5%" bgcolor="#A3A3A3" height="19">&nbsp;</td>
    <td width="105%" bgcolor="#A3A3A3" height="19">
    <p align="center"><font face="Verdana" size="2" color="#FFFFFF"><b>Students</b></font></td>
  </tr>
  <tr>
   <td width="3%" height="15"><input type="radio" value="AT" name="teachsel" onclick="return tcheck();"></td>
    <td width="43%" height="15"><font face="Verdana" size="2">All teachers in the school</font></td>
    <td width="4%" height="15"></td>
    <td width="5%" height="15"><font face="Verdana">
    <input type="radio" value="AS" name="studsel"  onclick="return scheck();"></font></td>
    <td width="105%" height="15"><font face="Verdana" size="2">All students in the school</font></td>
  </tr>
  <tr>
   <td width="3%" height="20"><input type="radio" value="GT" name="teachsel"  onclick="return tuncheck();"></td>
    <td width="43%" height="20"><font face="Verdana" size="2">Teachers from the following 
    grade(s)</font></td>
    <td width="4%" height="20">&nbsp;</td>
    <td width="5%" height="20"><font face="Verdana">
    <input type="radio" value="GS" name="studsel"  onclick="return suncheck();"></font></td>
    <td width="105%" height="20"><font face="Verdana" size="2">Students from the following 
    grade(s)</font></td>
  </tr>
  <tr>
    <td width="3%" height="20">&nbsp;</td>
    <td width="43%" height="20">
    <p align="right"> 

		<select name="teachers" size="4" multiple disabled>
<%
		Enumeration enum=tgrade.keys();
	    String s;
	    while (enum.hasMoreElements())
		{
			s=(String)enum.nextElement();
			if(accCode.indexOf("T:"+s)!=-1)
			{
				selTag="selected";
				tFlag=true;
			}
			else
				selTag="";
			out.println("<option value='"+s+"' "+selTag+">"+tgrade.get(s)+"</option>");
		}
%>
		</select>
	</td>
<%
		if(tFlag==true)
		{
%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
				checkTchGrade();
			//-->
			</SCRIPT>
<%
		}
%>
    <td width="4%" height="20">&nbsp;</td>
    <td width="5%" height="20">&nbsp;</td>
    <td width="105%" height="20">
    <p align="right">
	<select name="students" size="4" multiple disabled>
<%
		enum=sgrade.keys();
	    while(enum.hasMoreElements())
		{
			s=(String)enum.nextElement();
			if(accCode.indexOf("S:"+s)!=-1)
			{
				selTag="selected";
				sFlag=true;
			}
			else
				selTag="";
			out.println("<option value='"+s+"' "+selTag+">"+sgrade.get(s)+"</option>");
		}
%>
        </select>
	</td>
<%
		if(sFlag==true)
		{
%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
				checkStdGrade();
			//-->
			</SCRIPT>
<%
		}
%>
  </tr>
   <tr>
    <td width="3%" height="19">&nbsp;</td>
    <td width="43%" height="19">&nbsp;</td>
    <td width="4%" height="19">&nbsp;</td>
    <td width="5%" height="19"><font face="Verdana">
    <input type="radio" value="SC" name="studsel"  onclick="return scuncheck();"></font></td>
    <td width="105%" height="19">
		<font face="Verdana" size="2">Students from the following course(s)</font></td>
  </tr> 
   <tr>
    <td width="3%" height="19">&nbsp;</td>
    <td width="43%" height="19">&nbsp;</td>
    <td width="4%" height="19">&nbsp;</td>
    <td width="5%" height="19">&nbsp;</td>
    <td width="105%" height="19">
    <p align="right">
		<select name="courses" size="4" multiple disabled> 
<%
		String s1;
		enum=scourses.keys();
	    while (enum.hasMoreElements())
		{
			s1=(String)enum.nextElement();
			if(accCode.indexOf(s1)!=-1)
			{
				selTag="selected";
				cFlag=true;
			}
			else
				selTag="";
			out.println("<!-- <input type=\"hidden\"> --><option value='"+s1+"' "+selTag+">"+scourses.get(s1)+"</option>");
		}
%>
		</select>
</td>
<%
		if(cFlag==true)
		{
%>
			<SCRIPT LANGUAGE="JavaScript">
			
				checkStdCourse();
			
			</SCRIPT>
<%
		}
%>
   </tr>
  <tr>
    <td width="161%" height="19" colspan="6">&nbsp;</td>
  </tr>
  <tr bgcolor="white">
    <td width="161%" height="19" colspan="6">
    <p align="center">
	<input type="image" src="images/tsubmit.gif" onclick="return getvals();" TITLE="Submit">
	<input type="image" src="images/tcancel.gif" onclick="return goBack();" TITLE="Cancel">
  </tr>
  </table>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowDirTopics.jsp","operations on database","Exception",e.getMessage());
		out.println(e+" second");
	}
	finally
	{
		try
		{
			if(st2!=null)
				st2.close();
	        if(st1!=null)
		        st1.close();
			if(con!=null)
		        con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowDirTopics.jsp","closing connection,statement and resultset objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>
<input type="hidden" name="fid" value="<%=fId%>">
<input type="hidden" name="fname" value="<%=fName%>">
<input type="hidden" name="fdesc" value="<%=fDesc%>">
<input type="hidden" name="status" value="<%=status%>">
</form>
</center>
</body>

</html>