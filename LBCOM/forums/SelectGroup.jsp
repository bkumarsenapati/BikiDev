<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@page language="java" import="java.lang.*,java.sql.*,java.io.*,coursemgmt.ExceptionsFile,java.util.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
    Hashtable tgrade=null,sgrade=null,scourses=null;
	String utype="",username="",schoolid="",forumname="",forumdesc="",temp="",bcolor="",tag="";
	int tcount=0,scount=0,i=0,j=0;
	Connection con=null;
	Statement stmt=null,stmt1=null;
	ResultSet rs=null,rs1=null;
%>

<html>

<head>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript">
<!--
function tcheck(){
	document.frm.teachers.selectedIndex=-1;
	document.frm.teachers.disabled=true;
}
function tuncheck(){
	document.frm.teachers.disabled=false;
}
function suncheck()
{
	document.frm.students.disabled=false;
	document.frm.courses.disabled=true;
}
function scuncheck()
{
	document.frm.students.disabled=true;
	document.frm.courses.disabled=false;
}
function scheck()
{
	document.frm.students.selectedIndex=-1;
	document.frm.students.disabled=true;
	document.frm.courses.disabled=true;
}
function sccheck(){
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
			alert("Please select at least one Grade from teachers list");
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
			alert("Please select at least one Grade from students list");
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
			alert("Please select at least one Course from the Courses List");
			return false;
		}
	}
	if(k==0)
	{
		alert("Please select at least one user");
		return false;
	}

	document.frm.action="/LBCOM/forums.CreateForum?tstring="+tString+"&sstring="+sString;
	document.submit;
}
//-->
</SCRIPT>
</head>
<body>
<form name="frm" method="post">
<%
	utype=(String)session.getAttribute("logintype");
	username=(String)session.getAttribute("emailid");
	schoolid=(String)session.getAttribute("schoolid");
	forumname = request.getParameter("fname");
	forumdesc = request.getParameter("fdesc");
	if(utype.equals("teacher")){
		bcolor="#40A0E0";
		tag="t";
	}
	else if(utype.equals("student")){
		bcolor="#E08040";
		tag="s";
	}
	else if(utype.equals("admin")){
		bcolor="#F0B850";
		tag="a";
	}
	try
	{
		con = con1.getConnection();
		stmt = con.createStatement();
		stmt1=con.createStatement();
		
		rs = stmt.executeQuery("select * from forum_master where forum_name='"+forumname+"' and created_by='"+username+"' and creator_type='"+utype+"' and school_id='"+schoolid+"'");

		if(rs.next())
		{
			if(utype.equals("admin"))
				utype="school";	response.sendRedirect("/LBCOM/"+utype+"Admin/CreateForum.jsp?utype=teacher&tag=2");
		}
		else
		{
			tgrade=new Hashtable();
			i=0;
						
			rs=stmt.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"'  and class_id= any(select distinct(class_id) from teachprofile where schoolid='"+schoolid+"')");
			
			while(rs.next())
			{
				tgrade.put(rs.getString("class_id"),rs.getString("class_des"));
				i++;
			}
			
			i=0;
			j=0;
			sgrade=new Hashtable();
			scourses=new Hashtable();

			rs=stmt.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolid+"' order by grade)");
			while(rs.next())
			{
				sgrade.put(rs.getString("class_id"),rs.getString("class_des"));
				i++;
			}

	if(utype.equals("teacher"))
	{
			rs1=stmt1.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolid+"' and teacher_id='"+username+"' and status>0 order by course_name");

			while(rs1.next())
			{
				scourses.put(rs1.getString("course_id"),rs1.getString("course_name"));
				j++;
			}
	}
	if(utype.equals("admin"))
	{
			rs1=stmt1.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolid+"' and status>0 order by course_name");

			while(rs1.next())
			{
				scourses.put(rs1.getString("course_id"),rs1.getString("course_name"));
				j++;
			}
	}
%>

<br>
<center>
<table width="75%" bordercolor="#A8B8DO" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
  <tr>
    <td colspan="4" width="100%" align="center" style="border-width:1; border-color:black; border-style:solid;" bgcolor=<%=bcolor%>><span style="FONT-SIZE: 11pt"><b><i><font face="Arial">Select
        the Group who can access the Forum:</font></i></b></span></td>
  </tr>
  <tr>
    <td width="50%" colspan="2" style="border-width:1; border-color:black; border-style:solid;" bgcolor="#FFFFFF">
      <p align="center"><span style="FONT-SIZE: 10pt"><font face="Arial"><b>Teachers</b></font></span></p>
    </td>
    <td width="50%" colspan="2" style="border-width:1; border-color:black; border-style:solid;" bgcolor="#FFFFFF">
      <p align="center"><span style="FONT-SIZE: 10pt"><font face="Arial"><b>Students</b></font></span></td>
  </tr>
</center>
  <tr>
    <td width="1%" style="border-top-width:1; border-left-width:1; border-top-color:black; border-left-color:black; border-top-style:solid; border-left-style:solid;">
      <p align="right"><input type="radio" value="AT" name="teachsel" onclick="return tcheck();">
    </td>
<center>
    <td width="49%" style="border-top-width:1; border-right-width:1; border-top-color:black; border-right-color:black; border-top-style:solid; border-right-style:solid;">
      <span style="FONT-SIZE: 10pt"><font face="Arial">&nbsp;All Teachers in the
        School</font></span>
    </td>
</center>
    <td width="3%" style="border-top-width:1; border-left-width:1; border-top-color:black; border-left-color:black; border-top-style:solid; border-left-style:solid;">
      <p align="right"><input type="radio" value="AS" name="studsel" onclick="return scheck();"></td>
<center>
    <td width="46%" style="border-top-width:1; border-right-width:1; border-top-color:black; border-right-color:black; border-top-style:solid; border-right-style:solid;">
      <span style="FONT-SIZE: 10pt"><font face="Arial">&nbsp;All Students in the
        School</font></span></td>
  </tr>
</center>
  <tr>
    <td width="1%" style="border-left-width:1; border-left-color:black; border-left-style:solid;">
      <p align="right"><input type="radio" value="GT" name="teachsel" onclick="return tuncheck();">
    </td>
<center>
    <td width="49%" style="border-right-width:1; border-right-color:black; border-right-style:solid;">
      <span style="FONT-SIZE: 10pt"><font face="Arial">&nbsp;Teachers of
        the following Grade(s)</span></font>
    </td>
</center>
    <td width="3%" style="border-left-width:1; border-left-color:black; border-left-style:solid;">
      <p align="right"><input type="radio" value="GS" name="studsel" onclick="return suncheck();" disabled></td>
<center>
    <td width="46%" style="border-right-width:1; border-right-color:black; border-right-style:solid;">
      <span style="FONT-SIZE: 10pt"><font face="Arial">&nbsp;Students of the following Grade(s)</font></span></td>
  </tr>
</center>
  <tr>
    <td width="50%" colspan="2" style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:black; border-bottom-color:black; border-left-color:black; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
      <p align="center">
	  <select name="teachers" size="4" multiple disabled>
<%
		Enumeration enum=tgrade.keys();
	    String s;
	    while (enum.hasMoreElements())
		{
			s=(String)enum.nextElement();
			out.println("<option value='"+s+"'>"+tgrade.get(s)+"</option>");
		}
          //for(i=0;i<tgrade.length;i++)
			//out.println("<option value='"+tcode[i]+"'>"+tgrade[i]+"</option>");
			//out.println("<option value='"+tgrade[i]+"'>"+tgrade[i]+"</option>");
%>
        </select>
    </td>
<center>
    <td width="50%" colspan="2" style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:black; border-bottom-color:black; border-left-color:black; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
      <p align="center">
	  
	  <select name="students" size="4" multiple disabled>
<%
		enum=sgrade.keys();
	    while(enum.hasMoreElements())
		{
			s=(String)enum.nextElement();
			out.println("<option value='"+s+"'>"+sgrade.get(s)+"</option>");
		}
%>
        </select>
		</td>
	</tr>
	 <tr>
		<td width="3%" COLSPAN="3" ALIGN="RIGHT" style="border-left-width:1; border-left-color:black; border-left-style:solid;">
			<input type="radio" value="SC" name="studsel" onclick="return scuncheck();"></td>
			<center>
	    <td width="46%" style="border-right-width:1; border-right-color:black; border-right-style:solid;">
		  <span style="FONT-SIZE: 10pt">
		  <font face="Arial">&nbsp;Students of the following Course(s)</font></span></td>
	</tr>
</center>
	<tr>
		<td width="50%" colspan="2" style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:black; border-bottom-color:black; border-left-color:black; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
			<p align="center">&nbsp;
		</td>
<center>
		<td width="50%" align="center" colspan="2" style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:black; border-bottom-color:black; border-left-color:black; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
			<select name="courses" size="4" multiple disabled> -->
<%
		String s1;
		enum=scourses.keys();
	    while (enum.hasMoreElements())
		{
			s1=(String)enum.nextElement();
			out.println("<!-- <input type=\"hidden\"> --><option value='"+s1+"'>"+scourses.get(s1)+"</option>");
		}
          //for(i=0;i<sgrade.length;i++)
		  //out.println("<option value='"+scode[i]+"'>"+sgrade[i]+"</option>");
		  //out.println("<option value='"+sgrade[i]+"'>"+sgrade[i]+"</option>");
%>
			</select>
		</td>
	</tr> 
	<tr>
		<td width="100%" align="center" colspan="4" style="border-width:1; border-color:black; border-style:solid;">
<%
		if(utype.equals("admin"))
				utype="school";	
%>
                    &nbsp;

		<!-- <a href="/LBCOM/<%=utype%>Admin/ShowDirTopics.jsp?emailid=<%=username%>&schoolid=<%=schoolid%>"> -->		
		<input type="image" src="../forums/images/<%=tag%>submit.gif" width="88" height="33" onclick="return getvals();" TITLE="Submit">
		<a href="javascript:history.go(-1);">
		<img src="../forums/images/<%=tag%>cancel.gif" border="0" TITLE="Cancel"></a>
	</td>
  </tr>
</table>
</center>
<input type="hidden" name="frname" value="<%=forumname%>">
<input type="hidden" name="frdesc" value="<%=forumdesc%>">
<%
		}
	}
	catch(Exception ex)
	{
		ExceptionsFile.postException("SelectGroup.jsp","Operations on database ","Exception",ex.getMessage());

		out.println("Exception occured is "+ex);
	}
	finally{
		try{
			if(con!=null && !con.isClosed())
				con.close();
		}catch(Exception e1)
		{
			ExceptionsFile.postException("SelectGroup.jsp","closing connection object ","Exception",e1.getMessage());
			out.println("Exception while closing "+e1);
		}
	}
%>
</form>
</body>
</html>


