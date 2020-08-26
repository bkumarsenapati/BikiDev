<%@ page import="java.io.*"%>
<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 

<%!String files="",files2="";%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Share Page</title>
<script language="Javascript" src="../JS/ajax.js"></script>
<script language="Javascript" src="../JS/mainpage.js"></script>
<script language="JavaScript">
var http_share = getHTTPObject();
var result="";
var test=0;
var grades="";
function handleHttpShareResponse() {
	
	if (http.readyState == 4) {
	if (http.status==200){

	test=0;
	
	var message=http.responseXML.getElementsByTagName("root");
	result="<table border=\"0\" cellspacing=\"0\" width=\"70%\" id=\"AutoNumber3\"  style=\"border-collapse: collapse\" bordercolor=\"#111111\" cellpadding=\"0\" >";
	for(i=0; i<message.length;i++)
			{
				v=message[i].getElementsByTagName('data');
				
				for(j=0;j<v.length;j++)
				{
					
					result=result+"<tr><td width=\"19\"><input type=checkbox name=c_data value=\""+v[j].getElementsByTagName('check_data')[0].firstChild.nodeValue+"\"></td>";
					result=result+"<td align='left' width=\"40%\"><font face=\"Aria\" size=\"3\">"+v[j].getElementsByTagName('id')[0].firstChild.nodeValue+"</font></td>";

					result=result+"<td align='left' width=\"40%\"><font face=\"Aria\" size=\"3\">"+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</font></td></tr>";
					test++;
				}
				
			}
			
			if(test>0)
				result=result+"<tr><td colspan=\"3\" align=center><input type=\"submit\" value=\"submit\"><input type=\"reset\" value=\"Cancel\"></td></tr>	";
				else
			{
					result="not available yet.";
				}

			result=result+"</table>";
			
document.getElementById("details").innerHTML=result;
	}
	}
}

//submit 

</script>
</head>

<body>
Sharing Files:
<table>
<%

files=request.getParameter("files");

String f_list[]=files.split(",");
for(int i=0;i<f_list.length;i++)
{
	File f_name=new File(f_list[i]);
	
	String file_ext=f_name.getName().substring(f_name.getName().indexOf(".")+1);
	if(file_ext.equals("txt"))
	{
	%><tr>
	<td><img src="../images/text.gif"><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}
	else if(file_ext.equals("doc") || file_ext.equals("rtf"))
	{
	%><tr>
	<td><img src="../images/word.gif"><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}else if(file_ext.equals("zip"))
	{
	%><tr>
	<td><img src="../images/zip.gif"><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}else if(file_ext.equals("pdf"))
	{
	%><tr>
	<td><img src="../images/word.gif"><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}
	else if(file_ext.equals("html"))
	{
	%><tr>
	<td><img src="../images/html.gif"><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}
	else
	{
	%><tr>
	<td><%=f_name.getName().substring(0,f_name.getName().indexOf("."))%></td>
	</tr>
	<%
	}
}
%>

<form name="grstudselectfrm" id='gr_stud_id' action="#" onsubmit="return share('<%=files%>');"><BR>
<input type="hidden"  name="files" value="<%=files%>">
<input type="hidden"  name="grade" value="">
<input type="hidden"  name="userids" value="">
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet  rs=null,rs1=null,rs2=null;
	boolean flag=false;

	String teacherId=(String)session.getValue("emailid");
	String schoolId=(String)session.getValue("schoolid");
	String meetingId=request.getParameter("mid");
	String utype=session.getAttribute("utype").toString();
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
<table border="0" cellspacing="0" width="70%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
  <tr>
    <td width="50%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Users List  </font></b></font></td>
	<td width="50%" height="24" align="right">
	<a href="#" onclick="back()"><IMG SRC="../images/back.gif" WIDTH="70" HEIGHT="25" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellpadding="5" cellspacing="0" width="70%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
    <td width="40%" height="23" colspan="2" bgcolor="#96C8ED">
	<%
		
		if(utype.equals("teacher"))
		 {
		
			out.print("	<select style=\"width:200px\" size=\"1\" id=\"grade_id\" name=\"gradeid\"  onchange=\"change1(this.value)\">");
			out.print("<option value=\"no\" selected>Select Course</option>");

		while (rs.next())
		{

			out.print("<option value="+rs.getString("course_id")+">&nbsp;&nbsp;"+rs.getString("course_name")+"</option>");

		flag=true;
		} 
		out.print("</select>");
	}%>
	</td>
	<td width="40%" height="23" colspan="2" align="right" bgcolor="#96C8ED"><a href="#" onclick="change1('teachers')" style="font-family: arial;text-decoration:none;">TeachersList</a></td>
<%
	if(flag==false && utype.equals("teacher")){
		out.println("</tr><tr><td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
    
  </tr>
  </table>
  
  </center>
</div>
<br>
<center>
<div id="details">
<font face="Arial" size="2"><center>Please select a teacher(s) by click on the TeachersList.</center></font>
</div>
</center>
			<hr color="#429EDF" width="70%" size="1">
<%
	  
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("OverallSummary.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("ShareFile.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">
function change1(grade1)
{
	grades=grade1;
	if(grade1!='no')
	{
	http.open("GET", "TeachersList.jsp?userid=<%=teacherId%>&courseid="+grade1, true);	
	http.onreadystatechange = handleHttpShareResponse;
	http.send(null);
	}
	else{
document.getElementById("details").innerHTML="Select course or teacher";
	}
	
	
}
function change(grade1)
{
	
	
	if(grade1!='no')
	{
		grades=grade1
			document.location.href="TeachersList.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		
		grades='no';
		location.href="MeetingPermissions.jsp?userid=<%=teacherId%>";						
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

function share(files)
{
	var c_value1 = "";
		var f_name = "";
		
		if(grstudselectfrm.c_data.length)
		{
		for (var i=0; i < grstudselectfrm.c_data.length; i++)
		{
		if (grstudselectfrm.c_data[i].checked)
		  {
				c_value1=c_value1 + grstudselectfrm.c_data[i].value+",";
		  }
		}
		}
		else if(grstudselectfrm.c_data.checked)
		{
			c_value1 = grstudselectfrm.c_data.value;
		}
		if(c_value1=="" || c_value1.length<=0)
		{
			alert('please select an Item');
			return false;
		}
		else
		{

			//var course=document.grstudselectfrm.gradeid[document.grstudselectfrm.gradeid.selectedIndex].value;
			
			//alert(course);
			
			document.grstudselectfrm.grade.value=grades;
			document.grstudselectfrm.userids.value=c_value1;

			document.grstudselectfrm.action="../../share";
		}
		

}
</script>
</html>