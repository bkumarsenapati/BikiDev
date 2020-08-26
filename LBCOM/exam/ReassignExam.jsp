<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
    Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
    int totRecords=0,start=0,end=0,c=0,pages=0,pageNo=0,examCount=0;
	String teacherId="",classId="",schoolId="",argSelIds="",stuId="",str_pageNo="",argUnSelIds="",docName="",workId="",linkStr="",cat="";
	String stuTableName="",teachTableName="",tag="",examType="",total="",allowedAttempts="";
	Hashtable hsSelIds=null;	
	Date currentDate=null,submissionDate=null;
	String submDate="";
	String typeWise="",randomWise="",versions="",quesList="",createDate="",courseId="",type="";
	boolean studentsFlag=false;
	String attemptsColor="",submissionColor="",studentColor="";
%>
<%
		Hashtable subsections=null;
		String subsectionId="";
		String query="";
		String flag="";

		try
		{	 
			String sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			con=con1.getConnection();
			
			classId=(String)session.getAttribute("classid");
			courseId=(String)session.getAttribute("courseid");
			teacherId = (String)session.getAttribute("emailid");
			schoolId = (String)session.getAttribute("schoolid");
			//docName=request.getParameter("docname");
			workId=request.getParameter("workid");
			cat=request.getParameter("cat");
			
			if(hsSelIds==null)
			   hsSelIds=new Hashtable();
	
			if(cat.equals("reassign"))
			{
				st=con.createStatement();
				rs=st.executeQuery("select curdate() td,exam_name,create_date,to_date,ques_list,exam_type,random_wise,versions,type_wise,mul_attempts from exam_tbl where exam_id='"+workId+"' and school_id='"+schoolId+"'");
				if(rs.next())
				{
					createDate=(rs.getString("create_date")).replace('-','_');
					submissionDate=rs.getDate("to_date");
					currentDate=rs.getDate("td");
					session.putValue("createDate",createDate);
					quesList=rs.getString("ques_list");
					randomWise=rs.getString("random_wise");
					typeWise=rs.getString("type_wise");
					versions=rs.getString("versions");
					docName=rs.getString("exam_name");
					examType=rs.getString("exam_type");
					allowedAttempts=rs.getString("mul_attempts");
				}
							
				rs=st.executeQuery("select student_id from "+schoolId+"_"+workId+"_"+createDate+""); 
				while(rs.next())
				{
					stuId=rs.getString("student_id");
					hsSelIds.put(stuId,stuId);
				}
				session.putValue("seltIds",hsSelIds);
			}


			if(subsectionId.equals("")||subsectionId.equals("all"))
			{
				rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"'  order by s.subsection_id");
			}
			else
			{
				rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' "+query+" order by s.subsection_id");
		   }
		}
		catch(SQLException e)
		{
			out.println("Error in Reassigning is..."+e);
			ExceptionsFile.postException("AssStudentsList.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
					
			}catch(SQLException se){
				out.println("Error in Reassigning is..."+e);
				ExceptionsFile.postException("AssStudentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}catch(Exception e){
			out.println("Error in Reassigning is..."+e);
			ExceptionsFile.postException("AssStudentsList.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
			System.out.println("The Error is:"+e);
		}	

%>

<HTML>
<head>
<script>
var checked=new Array();
var unchecked=new Array();

function reassign()
{
	var flag;
	var obj=document.studentslist;
	var flag=false;
	for(var i=0;i<obj.elements.length;i++)
	{
		if(obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids" && obj.elements[i].checked==true)
		{
			flag=true;
		}
	}

	if(flag==false)
	{
		alert("You have to select at least one student");
		return false;
	}

	getSelectedIds();
<%
	if(cat.equals("reassign"))
	{
%>	
		document.studentslist.strStudentList.value=checked;
		document.studentslist.unchecked.value=unchecked;
		document.studentslist.action="ReAssigning.jsp?workid=<%=workId%>&checkedids="+checked;
		document.forms[0].submit();
<%
	}
%>
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
			obj[i].checked=false;
		}
	}
}

function getSelectedIds()
{
	var obj=document.studentslist;	  
    for(i=0,j=0,k=0;i<obj.elements.length;i++)
	{
		if(obj.elements[i].type=="checkbox")
		{
			if(obj.elements[i].name=="selids" && obj.elements[i].checked==true)
			{
				checked[j++]=obj.elements[i].value;
				//alert("checked value is..."+checked[j++].value);
			}
			else
			{
				unchecked[k++]=obj.elements[i].value;
				//alert("unchecked value is..."+unchecked[k++].value);
			}
		}
	}
}

</script>
</head>
<BODY topmargin=2 leftmargin=2>	
<form name="studentslist" method="post" action="">
<center>

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="104">
    <tr>
      <td width="100%">
        <div align="center">

<table border="0" width="100%" cellspacing="1" height="73">
	<tr>
		<td width="100%" bgcolor="#A8B8D1" height="24" colspan="7" align=left>
			<b><font size="2" face="Verdana" color="black">Reassigning <u><%=docName%></u> to Students</font></b>
		</td>
	</tr>
  <tr>
    <td width="20" bgcolor="#CECBCE" height="20">
    <input type="checkbox" name="selectall" onclick="javascript:selectAll()" value="ON" ></td>
	<td width="266" bgcolor="#CECBCE" height="20" align="center">
    <b><font size="2" face="Verdana" color="#000080">Student Name</font></b></td>
    <td width="234" bgcolor="#CECBCE" height="20" align="center">
    <font size="2" face="Verdana" color="#000080"><b>E-Mail Id</b></font></td>
	<td width="138" bgcolor="#CECBCE" height="20" align="center">
    <font size="2" face="Verdana" color="#000080"><b>Max Attempts</b></font></td>
	<td width="84" bgcolor="#CECBCE" height="20">
    <font size="2" face="Verdana" color="#000080" align="center"><b>Attempted</b></font></td>
	<td width="145" bgcolor="#CECBCE" height="20" align="center">
    <font size="2" face="Verdana" color="#000080"><b>Submission Date</b></font></td>
  </tr>

<%
	try
	{
		st1=con.createStatement();
		st2=con.createStatement();
		studentsFlag=false;
		while(rs.next())
		{
			stuId=rs.getString("emailid");
			studentColor="black";

			rs1=st1.executeQuery("select reassign_status from "+schoolId+"_"+stuId+" where exam_id='"+workId+"'"); 
			if(rs1.next())
			{
				if(rs1.getString("reassign_status").equals("1"))
					studentColor="red";
			}
			rs1.close();
			
			// to list the students whose attempts are over or time is up. ramanujam
			rs1=st1.executeQuery("select count(*) from "+schoolId+"_"+workId+"_"+createDate+" where exam_id='"+workId+"' and student_id='"+stuId+"'"); 
			if(rs1.next())
			{
				examCount=Integer.parseInt(rs1.getString(1));
				if(examCount==1)
				{
					rs2=st2.executeQuery("select count from "+schoolId+"_"+workId+"_"+createDate+" where exam_id='"+workId+"' and student_id='"+stuId+"'"); 
					if(rs2.next())
					{
						examCount=Integer.parseInt(rs2.getString(1));
					}
				}

				attemptsColor="black";
				submissionColor="black";
				
				if(submissionDate!=null)
				{	
					if(((Integer.parseInt(allowedAttempts)!=-1)&&(examCount>=Integer.parseInt(allowedAttempts))) || (currentDate.compareTo(submissionDate)>=0))
					{
						if(examCount >=Integer.parseInt(allowedAttempts))
							attemptsColor="red";
						
						if(currentDate.compareTo(submissionDate)>=0)
							submissionColor="red";
						
						if(allowedAttempts.equals("-1"))
							allowedAttempts="No Limit";
%>

	<td width="20" height="20" bgcolor="#EFEFEF"><font size="2" face="verdana"><input type="checkbox" name="selids" value="<%=stuId%>"></font></td>
	<td width="266" height="20" bgcolor="#EFEFEF">
		<font size="2" face="verdana" color="<%=studentColor%>"><%=rs.getString("fname")+" "+ rs.getString("lname") %></font></td>
    <td width="234" height="20" bgcolor="#EFEFEF"><font size="2" face="verdana"><%=rs.getString("con_emailid")%></font></td>
	<td width="138" height="20" bgcolor="#EFEFEF" align="center"><font size="2" face="verdana"><%=allowedAttempts%></font></td>
	<td width="84" height="20" bgcolor="#EFEFEF" align="center">
		<font size="2" face="verdana" color="<%=attemptsColor%>"><%=examCount%></font></td>
	<td width="145" height="20" bgcolor="#EFEFEF" align="center">
		<font size="2" face="verdana" color="<%=submissionColor%>"><%=submissionDate%></font></td>
  </tr>
  <%   
						studentsFlag=true;
					}
					else
					{}						
				}
				else
				{
					if((Integer.parseInt(allowedAttempts)!=-1)&&(examCount>=Integer.parseInt(allowedAttempts))) 
					{
						if(examCount >=Integer.parseInt(allowedAttempts))
							attemptsColor="red";
						
						if(allowedAttempts.equals("-1"))
							allowedAttempts="No Limit";
%>

	<td width="20" height="20" bgcolor="#EFEFEF"><font size="2" face="verdana"><input type="checkbox" name="selids" value="<%=stuId%>"></font></td>
	<td width="266" height="20" bgcolor="#EFEFEF">
		<font size="2" face="verdana" color="<%=studentColor%>"><%=rs.getString("fname")+" "+ rs.getString("lname") %></font></td>
    <td width="234" height="20" bgcolor="#EFEFEF"><font size="2" face="verdana"><%=rs.getString("con_emailid")%></font></td>
	<td width="138" height="20" bgcolor="#EFEFEF" align="center"><font size="2" face="verdana"><%=allowedAttempts%></font></td>
	<td width="84" height="20" bgcolor="#EFEFEF" align="center">
		<font size="2" face="verdana" color="<%=attemptsColor%>"><%=examCount%></font></td>
	<td width="145" height="20" bgcolor="#EFEFEF" align="center">
		<font size="2" face="verdana" color="<%=submissionColor%>">-</font></td>
  </tr>
<%   
						studentsFlag=true;
					}
					else
					{}//System.out.println("count is greater than allowed");
				}
			}
		}
		if(studentsFlag==false)
		{
%>
			<tr>
				<td width="902" height="24" colspan="6" align="left"><b>
				<font size="2" face="Verdana" color="#800000">No Students Available.</font></b></td>
			</tr>
<%
		}
		else
		{
%>
			<tr>
				<td width="902" height="24" colspan="6" align="left">
					<input type="image" src="images/bassign.gif" onclick="reassign(); return false;" width="113" height="32"> 
				</td>
			</tr>
			
<%
		}

	}
	catch(Exception e)
	{
		System.out.println("There is an exception raised in try"+e);
		ExceptionsFile.postException("AssStudentsList.jsp","operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			{
				con.close();
			}
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AssStudentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
   }
%>  

</table>
</div>
</td>
</tr>

<input type="hidden" name="checkedids" value="">
<input type="hidden" name="uncheckedids" value="">
<input type="hidden" name="stutable" value=<%=stuTableName%>>
<input type="hidden" name="teachtable" value=<%=teachTableName%>>
<input type="hidden" name="cat" value=<%=cat%>>
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

</table>
</form>
</BODY>
</HTML>