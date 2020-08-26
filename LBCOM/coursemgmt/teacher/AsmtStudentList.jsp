<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
    int totRecords=0,start=0,end=0,c=0,pages=0,pageNo=0;
	String teacherId="",classId="",schoolId="",argSelIds="",stuId="",str_pageNo="",argUnSelIds="",docName="",workId="",linkStr="",cat="";
	String stuTableName="",teachTableName="",tag="",examType="",total="";
	Hashtable hsSelIds=null;	
	String typeWise="",randomWise="",versions="",quesList="",createDate="",courseId="",type="",enableMode="",exmTbl="",exmInsTbl;
	Hashtable subsections=null;
	String subsectionId="";
	String query="";
	String flag="";

	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
			
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		docName=request.getParameter("docname");
		workId=request.getParameter("workid");
		cat=request.getParameter("cat");
		type=request.getParameter("type");
		total=request.getParameter("total");
		subsectionId=request.getParameter("subsectionid");
		enableMode=request.getParameter("enableMode");  

		if(enableMode==null)
			enableMode="1";
		if(enableMode.equals("0"))
		{
			exmTbl="exam_tbl";
		}
		else
		{
			exmTbl="exam_tbl_tmp";
 		}
		
		subsections=new Hashtable();
		if(flag==null)
		{
			flag="false";
		}
		if (subsectionId!=null)
		{
			StringTokenizer stk=new StringTokenizer(subsectionId,",");
			if(stk.hasMoreTokens())
			{
				query+=" and (s.subsection_id='"+stk.nextToken()+"'"; 
				while(stk.hasMoreTokens())
				{
					query+=" or s.subsection_id='"+stk.nextToken()+"'";  
				}
				query+=") ";
			}
		}
		else
		{
			subsectionId="";
			query="";
		}
		
		if(cat.equals("edit"))
		{
			session.removeValue("seltIds");
		}
		if(request.getParameter("totrecords").equals(""))
		{
			session.removeValue("seltIds");
		}

		hsSelIds=(Hashtable)session.getAttribute("seltIds");
		subsections=(Hashtable)session.getAttribute("subsections");
		if(hsSelIds==null)
			hsSelIds=new Hashtable();
	
		if(cat.equals("edit")||cat.equals("modeEdit"))
		{
			st=con.createStatement();
			rs=st.executeQuery("select exam_name,create_date,ques_list,exam_type,random_wise,versions,type_wise from "+exmTbl+" where exam_id='"+workId+"' and school_id='"+schoolId+"'");
			if(rs.next())
			{
				createDate=(rs.getString("create_date")).replace('-','_');
				session.putValue("createDate",createDate);
				quesList=rs.getString("ques_list");
				randomWise=rs.getString("random_wise");
				typeWise=rs.getString("type_wise");
				versions=rs.getString("versions");
				docName=rs.getString("exam_name");
				examType=rs.getString("exam_type");
			}
			if(cat.equals("edit"))
			{
				cat="modeEdit";	
				if(enableMode.equals("0"))
				{
					exmInsTbl=schoolId+"_"+workId+"_"+createDate;
				}
				else 
				{
					exmInsTbl=schoolId+"_"+workId+"_"+createDate+"_tmp";
 				}
				rs=st.executeQuery("select student_id from "+exmInsTbl);
				while(rs.next())
				{
					stuId=rs.getString("student_id");
					hsSelIds.put(stuId,stuId);
				}
				
				if(!hsSelIds.contains(classId+"_vstudent"))
					hsSelIds.put(classId+"_vstudent",classId+"_vstudent"); //Added by rajesh

				session.putValue("seltIds",hsSelIds);
			}
		}
		else if(type.equals("CM")||type.equals("CO"))
		{
			stuTableName="course_docs_dropbox";
			teachTableName="course_docs";
		}
		else if(type.equals("AS"))
		{
			stuTableName=schoolId+"_"+classId+"_"+courseId+"_dropbox";
			teachTableName=schoolId+"_"+classId+"_"+courseId+"_workdocs";
		}
		
		if(request.getParameter("totrecords").equals(""))
		{ 
			st=con.createStatement();
			//rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"'");
			if(subsectionId.equals("")||subsectionId.equals("all"))
			{
				rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1");
			}
			else
			{
				rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' adn s.status=1 "+query);
			}
			rs.next();
			c=rs.getInt(1);
			if(c!=0 )
			{			
				totRecords=c;
			}
			else
			{
				out.println("<html><head></head><body topmargin=2 leftmargin=2><table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' ><tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Student are not found. </font></b></td></tr></table></form></body></html>");	return;
			}
		}
		else
			totRecords=Integer.parseInt(request.getParameter("totrecords"));    
			
		start=Integer.parseInt(request.getParameter("start"));
		argSelIds=request.getParameter("checked");
		argUnSelIds=request.getParameter("unchecked");   
		
		if(argUnSelIds!="" & argUnSelIds!=null)
     	{
			StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
			String id;
			while(unsel.hasMoreTokens())
			{
				id=unsel.nextToken();
		        if(hsSelIds.containsKey(id))
					hsSelIds.remove(id);
			}
		}
		if(argSelIds!="" && argSelIds!=null)
		{
			StringTokenizer sel=new StringTokenizer(argSelIds,",");
			String id;			
			
			while(sel.hasMoreTokens())
			{
				id=sel.nextToken();
				hsSelIds.put(id,id);
			}
			if(!hsSelIds.contains(classId+"_vstudent"))
				hsSelIds.put(classId+"_vstudent",classId+"_vstudent"); //Added by rajesh
			session.putValue("seltIds",hsSelIds);
		}
		
		c=start+pageSize;
		end=start+pageSize;
		
		if(c>=totRecords)
			end=totRecords;
		
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	
		//rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' LIMIT "+start+","+pageSize);

		if(subsectionId.equals("")||subsectionId.equals("all"))
		{
			rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1  order by s.subsection_id LIMIT "+start+","+pageSize);
		}
		else 
		{
			rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1 "+query+" order by s.subsection_id LIMIT "+start+","+pageSize);
		}
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("AsmtStudentList.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AsmtStudentList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The exception in AsmtStudentList.jsp is....."+se.getMessage());
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("AsmtStudentList.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("The exception2 in AsmtStudentList.jsp is....."+e);
	}	
%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignment Editor</title>
<link href="../../style.css" rel="stylesheet" type="text/css" />

<SCRIPT LANGUAGE="JavaScript">
var checked=new Array();
var unchecked=new Array();
	
function validate()
{	
	var flag;
<% 
	if(hsSelIds.size()==0)
	{
%>			
		var obj=document.studentslist;
		var flag=false;
		for(var i=0;i<obj.elements.length;i++)
		{
			if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids" && obj.elements[i].checked==true)
				flag=true;
		}
		if(flag==false)
		{
			alert("You have to select at least one student");
			return false;
		}
<%
	}
%>
	getSelectedIds();
<%
	if(cat.equals("modeEdit"))
	{
%>	
		document.studentslist.strStudentList.value=checked;
		document.studentslist.unchecked.value=unchecked;
		document.studentslist.action="/LBCOM/exam.DistributeExam";
		document.forms[0].submit();
<%
	}
	else
	{
%>
window.location.href="/LBCOM/coursemgmt.AssignWork?workid=<%=workId%>&checkedids="+checked+"&uncheckedids="+unchecked+"&cat=<%=cat%>&teachtable=<%=teachTableName%>&stutable=<%=stuTableName%>&type=<%=type%>&total=<%=total%>";
<%
	}
%>
}

function getSelectedIds()
{
	var obj=document.studentslist;	  
    for(i=0,j=0,k=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids")
		{
			if(obj.elements[i].checked==true)
				checked[j++]=obj.elements[i].value;
			else 
				unchecked[k++]=obj.elements[i].value;
		}
	}
}

function selectAll()
{
	var obj=document.studentslist.selids;
	if(document.studentslist.selectall.checked==true)
	{
		for(var i=0;i<obj.length;i++)
		{
			obj[i].checked=true;
		}
	}
	else
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].value != "<%=classId%>_vstudent")
				obj[i].checked=false;
		}
	}
}

function goNextPrev(s,tot)
{
	getSelectedIds();	  
	var start=s;  
    var totalrecords=tot;	  	 
	document.location.href="AsmtStudentList.jsp?start="+start+"&totrecords="+totalrecords+"&checked="+checked+"&unchecked="+unchecked+"&docname=<%=docName%>&cat=<%= cat%>&workid=<%= workId %>&examtype<%=examType%>&type=<%=type%>&total=<%=total%>"; 	   
}
</SCRIPT>
</head>

<body bgcolor="#EBF3FB"> 

<form name="studentslist" method="post" action="">

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="50%" align="left"><input type="image" src="../images/bassign.gif" onclick="validate(); return false;"></td>
	<td width="50%" align="right">
		<b><font face="Verdana" size="2" color="#0000FF">
		<a href="#" onclick="history.go(-1); return false;">&lt;&lt;BACK</a></font></b>
	</td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="33%">
		<font face="Verdana" size="2" color="#000080">Students <%=(start+1)%> - <%=end%> of <%=totRecords%></font>
	</td>
    <td width="17%">&nbsp;</td>
    <td width="16%">&nbsp;</td>
    <td width="34%" align="right">
	<font size="1" face="Verdana">
<%
		if(start==0 )
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"javascript:goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>&nbsp;");
			}
			else
				out.println("Previous | Next ");
		}
		else
		{
			linkStr="<a href=\"javascript:goNextPrev("+(start-pageSize)+","+totRecords+")\">Previous</a> |";
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"javascript:goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>";
			}
			else
				linkStr=linkStr+" Next";
			out.println(linkStr);
		}	
%>
	</font></td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#C0C0C0" width="100%">
<tr>
	<td width="3%" bgcolor="#858585" height="21">&nbsp;</td>
	<td width="3%" bgcolor="#858585" height="21">&nbsp;</td>
	<td width="30%" bgcolor="#858585" height="21"><b>
		<font face="Verdana" size="2" color="#FFFFFF">&nbsp;Student Name</font></b>
	</td>
	<td width="19%" bgcolor="#858585" height="21"><b>
		<font face="Verdana" size="2" color="#FFFFFF">&nbsp;Student Id</font></b>
	</td>
	<td width="28%" bgcolor="#858585" height="21">&nbsp;</td>
	<td width="17%" bgcolor="#858585" height="21">&nbsp;</td>
</tr>

<%
		try
		{
   			while(rs.next())
			{		
				out.println("<tr>");
 				stuId=rs.getString("emailid");
				String block="";
				if(stuId.equals(classId+"_vstudent")) block="onclick='this.checked=true'";
				if(hsSelIds.containsKey(stuId))
				{
%>
					<td width="3%" bgcolor="#83B489" height="21">
						<input type="checkbox" name="selids" checked value="<%=stuId %>"  <%=block%>>
					</td>
<%	
				}
				else
				{ 
%>
					<td width="18" height="18" bgcolor="#EE948E"><input  type="checkbox" name="selids" value="<%=stuId%>"></td>
<%				
				}
%>
				<td width="3%" height="20">&nbsp;</td>
				<td width="30%" height="20">
					<font face="Verdana" size="2">&nbsp;<%=rs.getString("fname")+" "+ rs.getString("lname")%></font>
				</td>
				<td width="19%" height="20">
					<font face="Verdana" size="2">&nbsp;<%=rs.getString("emailid")%></font>
				</td>
				<td width="28%" height="20">&nbsp;</td>
				<td width="17%" height="20">&nbsp;</td>
			</tr>
<%          
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AsmtStudentList.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Exception e e e in AsmtStudentList.jsp iss......."+e);
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
				ExceptionsFile.postException("AsmtStudentList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("Exception in AsmtStudentList.jsppp iss..."+se.getMessage());
			}
		}
%>  

</table>
	<input type="hidden" name="stutable" value=<%=stuTableName%>>
    <input type="hidden" name="teachtable" value=<%=teachTableName%>>
	<input type="hidden" name="cat" value=<%=cat%>>
	<input type="hidden" name="checkedids" value="">
	<input type="hidden" name="uncheckedids" value="">
	<input type="hidden" name="random" value="<%=randomWise%>">
	<input type="hidden" name="versions" value="<%=versions%>">
	<input type="hidden" name="qidlist" value="<%=quesList%>">
	<input type="hidden" name="type" value="<%=typeWise%>">
	<input type="hidden" name="strStudentList">
	<input type="hidden" name="createdate" value="<%=createDate%>">
	<input type="hidden" name="examid" value="<%=workId%>">
	<input type="hidden" name="mode" value="<%=cat%>">
	<input type="hidden" name="examtype" value="<%=examType%>">
	<input type="hidden" name="unchecked">

<%  
	if(!enableMode.equals("0"))
	{
%>
		<tr><td colspan=7><input type="image" src="../images/bassign.gif" onclick="validate(); return false;"></td> </tr>
<% 
	}
%>
</form>
</body>

<%  
	if (enableMode.equals("0"))
	{
%>
		<script language='javascript'>	
			var frm=document.studentslist;
			for(var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;
		</script>
<% 
	}
%>

</html>
