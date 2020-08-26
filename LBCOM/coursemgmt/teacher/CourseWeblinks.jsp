
<html>
<head>
<title></title>
<script>
function deletewl()
{
	var chk="false";
	var len2=window.document.create.elements.length;
	for(k=0;k<len2;k++)
	{
		if(window.document.create.elements[k].checked==true)
        {
			chk="true";
			var name = window.document.create.elements[k].value;			
        }
	}
	if(chk=="false")
	{
		alert("Select at least one option ");
		return false;
	}
	else
    {		
		var f = window.document.create.foldername.value;
		var s = window.document.create.schoolid.value;
		var t = window.document.create.teacherid.value;
		window.location.href="deleteweblink.jsp?title="+name+"&foldername="+f+"&teacherid="+t+"&schoolid="+s;
    	return false; 
    }	
}
function modifywl()
{
	var chk="false";
	var len2=window.document.create.elements.length;
	for(k=0;k<len2;k++)
	{
		if(window.document.create.elements[k].checked==true)
        {
			chk="true";
			var name = window.document.create.elements[k].value;	
        }
	}
	if(chk=="false")
	{
		alert("Select at least one option ");
		return false;
	}
	else
    {
	    var f = window.document.create.foldername.value;
		var s = window.document.create.schoolid.value;
		var t = window.document.create.teacherid.value;

	 	window.location.href="modifypage.jsp?title="+name+"&foldername="+f+"&teacherid="+t+"&schoolid="+s;
    	return false; 
    }
}
function funBack()
{
	var s = window.document.create.schoolid.value;
	var t = window.document.create.teacherid.value;

	window.location.href="CoursesList.jsp"
}


</script>

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseName="",teacherId="",schoolId="",classId="",courseId="",className="";
String docName="",folderName="",catId="",materialId="";
ResultSet  rs=null;
Connection con=null;
PreparedStatement pst=null;
Statement st=null; 
boolean flag=false;
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
	
	//teacherId = (String)session.getAttribute("emailid");
	
	schoolId = (String)session.getAttribute("schoolid");

	classId=request.getParameter("classid");
	courseName=request.getParameter("coursename");
	courseId=request.getParameter("courseid");
	className=request.getParameter("classname");

	teacherId=request.getParameter("teacherid");
	folderName=request.getParameter("foldername");
	System.out.println("folderName..."+folderName);
	docName=request.getParameter("docname");
	catId=request.getParameter("cat");
	materialId=request.getParameter("workid");
	
	flag=false;
	con=con1.getConnection();
	st = con.createStatement();
	rs = st.executeQuery("select title,titleurl from courseweblinks where course_id= '"+courseId+"' and school_id='"+schoolId+"'");//modified on 2004-8-17
 %>

	<body topmargin=3 leftmargin="0" marginwidth="0">
    <form name=create action="weblinks.jsp">
    <table border="0" width="100%" cellspacing="1">
      <tr>
      
		 <!-- <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><a href="CoursesList.jsp">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"><%=courseName %></a> &gt;&gt; <%=className%> &gt;&gt; </font><font color=black> Weblinks</span></font></td> -->


      </tr>
    </table>
    &nbsp;
	
  <table align=center border=0 10pt; font-weight: bold\ width="600" height="134" >
    <tr>
      <td height="30" colspan="3" width="594"><font face="Arial" size="3"><img border="0" src="../images/weblinks.gif"></font></td>
    </tr>
    <tr>
      <td height="1" colspan="3" width="594" bgcolor="#42A2E7"> 
        <p align="center">&nbsp;</td>
    </tr>
 <%
 while(rs.next())
 {   	
   String t = rs.getString("title");
   String turl = rs.getString("titleurl");
   String adturl=turl;

   if(!turl.startsWith("http://"))
	   adturl="http://"+turl;

   	out.println("<tr><td height='25' width='30' align=\"center\"><font face='Arial' size='3'><input type=radio name=click value='"+t+"'></font></td><td align=\"left\"  height='25' width='150'> <font face='Arial' size='2'><a href="+adturl+" target='_Blank'>"+t+"</a></font> </td>  <td align=\"left\"  height='25' width='300'> <font face='Arial' size='2'>"+adturl+"</font> </td></tr>");
	flag=true;
 }

 if(!flag)
 	out.println("<tr><td height='25' colspan='3' valign='center' ><font face='Arial' size='2'> Web Links are yet to be provided</font> </td></tr>");
%>
  
  <tr>
      <td align=center height="27" colspan="3" width="575">
<p align="center"><font face="Arial" size="3">
<img border="0" src="../images/studentslistfooter.gif">
</font></p>
</td>
</tr>
  
  <tr>
      <td align=center height="37" colspan="3" width="575">
<p align="center"><font face="Arial" size="3">
<img border="0" src="../images/add.gif" onClick="return go('add');">
<img border="0" src="../images/edit.gif" onClick="return go('mod');">
<img border="0" src="../images/delete.gif" onClick="return go('del');">
</font>
</td>     
</tr>
</table>

<%
}
catch(Exception e)
{
	ExceptionsFile.postException("WeblinksList.jsp","Operations on database ","Exception",e.getMessage());
  out.println("error in choice that is:"+e.getMessage());
}finally{
		
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed()){
				con.close();
			}
			
		}catch(SQLException se){
			ExceptionsFile.postException("WeblinksList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

<input type=hidden name="courname" value="<%=courseName%>">
<input type=hidden name="classid" value="<%=classId %>">
<input type="hidden" name="courseid" value="<%=courseId%>">

<input type="hidden" name="workid" value="<%=materialId%>">
	<input type="hidden" name="path" value="<%=folderName%>">
	<input type="hidden" name="docname" value="<%=docName%>">
	<input type="hidden" name="cat" value="<%=catId%>">

</form>
</body>

<SCRIPT LANGUAGE="JavaScript">
<!--

var classId='<%= classId %>';
var courseName='<%= courseName %>';
var courseId='<%=courseId%>';
var title="";
function go(tag){
	if(tag=='add')
		window.location.href="CreateWeblink.jsp?classid="+classId+"&coursename="+courseName+"&courseid="+courseId+"&classname=<%=className%>";
	else if(tag=='mod'){		
		if(gettitle()==true){							window.location.href="EditWeblink.jsp?classid="+classId+"&coursename="+courseName+"&title="+title+"&courseid="+courseId+"&classname=<%=className%>";
		
		}else
			return false;

	}
	else{				
		if(gettitle()==true){
			if(confirm("Are you sure? You want to delete the link.")==true){	
			//window.location.href="/servlet/coursemgmt.AddWebLinks?mode=del&coursename="+courseName+"&classid="+classId+"&title="+title+"&courseid="+courseId;
			window.location.href="/LBCOM/coursemgmt.AddWebLinks?mode=del&coursename="+courseName+"&classid="+classId+"&title="+title+"&courseid="+courseId+"&classname=<%=className%>";
			
			} else
				return;

		}else
			return false;

	}
}

function gettitle(){
	
	var chk=false;

	if(window.document.create.elements.length==3){
		alert("Web links are not available.");
		return false;
	}

	for(var k=0;k<window.document.create.elements.length;k++)
	{
		if(window.document.create.elements[k].checked==true)
        {
			chk=true;
			title = window.document.create.elements[k].value;			
        }
	}

	if(chk==false)
	{
		alert("Select a web link");
		return false;
	}
	return true;
}


//-->
</SCRIPT>

</html>

