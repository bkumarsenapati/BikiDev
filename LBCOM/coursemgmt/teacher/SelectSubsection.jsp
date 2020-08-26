<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" import="java.io.*,java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>

<%
	Connection con=null;
	Statement st=null;
	String docName=request.getParameter("docname");
	String workId=request.getParameter("workid");
	String cat=request.getParameter("cat");
	String type=request.getParameter("type");
	String total=request.getParameter("total");
	String subsection=request.getParameter("subsectionname");
	String argSelIds=request.getParameter("checked");
	String argUnSelIds=request.getParameter("unchecked");  
	
	String classId=(String)session.getAttribute("classid");
	String courseId=(String)session.getAttribute("courseid");
	String schoolId=(String)session.getAttribute("schoolid");
	String enableMode=request.getParameter("enableMode");  
	if (enableMode==null)
		enableMode="1";
	
	try
	{
		con=db.getConnection();
		st=con.createStatement();
		Hashtable subsections=null;
		subsections=(Hashtable)session.getAttribute("subsections");
	
		if(subsections!=null)
		{
			session.removeAttribute("subsections");
		}
		else
		{
			subsections=new Hashtable();
		}
		String dispGroups="";
		if(subsection==null)
		{
			dispGroups="";
		}
		
		ResultSet rs=st.executeQuery("select * from subsection_tbl where class_id='"+classId+"' and school_id='"+schoolId+"'");
%>

<HTML>
<HEAD>
<TITLE></TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">

<!--
function call()
{
	var sec=document.getElementsByName("subsection_id");
	var subsec="";
	var subsecname="";
	var flag=false;
	
	for(var i=0;i<sec[0].length;i++)
	{
		flag=true;
		if(sec[0].options[i].selected)
		{
			if(sec[0].options[i].value=="all")
			{
				subsec="all,";
				subsecname=sec[0].options[i].text+",";
				break;
			}
			subsec+=sec[0].options[i].value+",";
			subsecname+=sec[0].options[i].text+",";
		}
	}
	subsec=subsec.substr(0,subsec.length-1);
	subsecname=subsecname.substr(0,subsecname.length-1);
	
	if(flag==true)
	{
		parent.stu.location.href="AssStudentsList.jsp?enableMode=<%=enableMode%>&start=0&totrecords=&checked=<%=argSelIds%>&unchecked=&workid=<%=workId%>&docname=<%=docName%>&cat=<%=cat%>&type=<%=type%>&subsectionid="+subsec;
	}
	else
	{
		alert('Select the Group / Subsection');
		return false;
	}
	
	document.subsection.groups.value=subsecname;
}

function show()
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
}
//-->
</SCRIPT>
</HEAD>
<BODY topmargin="0" leftmargin="0">
<form name="subsection">

<%	
		if(rs.next())
		{
%>
			<table width='100%' border="2"  bordercolordark='#C2CCE0' valign='top'>
			<tr>
				<td width='70%' bgcolor='#FFFFFF' height='16' align='center'>
					<font size='2' face='Arial'><b>Group / Subsection :&nbsp;&nbsp;</b></font>
					<select name='subsection_id' multiple='true' size='1'>
						<option value='all'>All</option>
						<option value='nil'>Default</option>
<%
			subsections.put("nil","Default");
			do
			{
				out.println("<option value='"+rs.getString("subsection_id")+"'>"+rs.getString("subsection_des")+"</option>");
				subsections.put(rs.getString("subsection_id"),rs.getString("subsection_des"));
			}while(rs.next());
%>		
					</select>&nbsp;&nbsp
					<input type='button' name='list' value='>>' onclick='call();'>
					<input type='text' name='groups' value='ALL'>
				</td>
			</tr>
			</table>
<%
		}
		subsections.put("nil","Default");
		session.setAttribute("subsections",subsections);
	}
	catch(Exception e)
	{
		System.out.println("Error in SelectSubsection.jsp is "+e);
		ExceptionsFile.postException("SelectSubsection.jsp","Operations on Database","Exception",e.getMessage());
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
		catch(SQLException se)
		{
			ExceptionsFile.postException("SelectSubsection.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>

</form>
<script>

parent.location.href="AssStudentsList.jsp?enableMode=<%=enableMode%>&start=0&totrecords=&checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>&subsectionid=all";
</script>

<script language='javascript'>	
<%  
	if (enableMode.equals("0"))
	{
%>
		var frm=document.subsection;
		for (var i=0; i<frm.elements.length;i++)
			frm.elements[i].disabled=true;
<% 
	}
%>
</script>
</BODY>
</HTML>
