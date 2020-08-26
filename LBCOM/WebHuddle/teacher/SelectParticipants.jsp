<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Webinar Participants</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
	
function selectAll()
{
        
		var selid=new Array();
        with(document.dir)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'chk' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				   alert(selid);
				  
				   
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to import the selected file(s)?")==true)
			{
				 
				window.location.href="#";
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the file(s) to import");
              return false;
        }
}
//-->
</SCRIPT>
</head>

<body>
<form name="dir" id='dir'><BR>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet  rs=null,rs1=null,rs2=null;
	boolean flag=false;
	String cId="";

	String teacherId=request.getParameter("userid");
	String courseId=request.getParameter("courseid");
	String schoolId=(String)session.getValue("schoolid");
	
	if(schoolId==null){
			out.println("<font face='Arial' size='2'><b>Your session has expired. Please Login again... <a href='#' onclick=\"top.location.href='/LBCOM/'\">Login.</a></b></font>");
			return;
	}
  try
	 {
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();
		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
%>
<table border="0" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Select Course</font></b></font></td>
	<td width="50%" height="24" align="right">
	<a href="MeetingPermissions.jsp?userid=<%=teacherId%>">Back</a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellpadding="5" cellspacing="0"  width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px"size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">

<%		
		while(rs.next())
		{
			cId=rs.getString("course_id");
			if(cId.equals(courseId))
			{
%>
				<option value='<%=cId%>' selected>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
			else
			{
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
		
		}
%>
    </select></td><tr></table>
	<table border="0" cellpadding="5" cellspacing="0"  width="95%" id="AutoNumber1" height="26" bordercolor="#111111" >
<%
	rs1=st1.executeQuery("select grade, username, fname, lname from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' ORDER BY fname,lname)");
	

	while (rs1.next()) 
	{
%>		
		<tr>
			<td width="5%">
			<input type="checkbox" name="chk" value='<%=rs1.getString("username")%>'></td>
			<td width="95%"><%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%>

			</td>
		</tr>
		
<%
	flag=true;
	}
%>	
	
<%
	if(flag==false)
	{
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
</td>	
  </tr>
</table>
  </center>
</div>


			<hr color="#429EDF" width="95%" size="1">
<br>
<div align="left">
 
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Add" name="sb" onclick="return selectAll();"></td>&nbsp;&nbsp;&nbsp;<td><input type="Reset" name="reset" value="Reset"></td>
</tr>
 
</div>
</form>

</body>
<%
	
	 }
	catch(Exception e)
	{
		ExceptionsFile.postException("SelectParticipants.jsp","operations on database","Exception",e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("SelectParticipants.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function goResults(obj)
{
       	var gradeObj=document.grstudselectfrm.gradeid;
		var studentObj=document.grstudselectfrm.studentid;
		var cid=gradeObj.value;
		var studentid=studentObj.value;
		document.location.href="OverallSummary3.jsp?userid=<%=teacherId%>&courseid="+cid+"&sid="+studentid;
		
	}
function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
		document.location.href="SelectParticipants.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		
		grades='no';
		location.href="SelectParticipants.jsp?userid=<%=teacherId%>&courseid="+grade1;						
	}
}
function clear1() {
		var i;
		var temp=document.grstudselectfrm.studentid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}

</script>
</html>