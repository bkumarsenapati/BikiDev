<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseName="",classId="",courseId="",teacherId="",schoolId="";
Connection con = null;   Statement stmt = null;
ResultSet rs = null,rs1=null;

%>
<% 
	
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
teacherId = (String)session.getAttribute("emailid");
schoolId=   (String)session.getAttribute("schoolid");

courseName = request.getParameter("coursename"); 
courseId=request.getParameter("courseid");
classId=request.getParameter("classid");



try
{

	con=con1.getConnection();
	stmt = con.createStatement();
	rs = stmt.executeQuery("select fname,lname,grade,emailid from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.schoolId where c.course_id='"+courseId+"' and c.school_id='"+schoolId+"' and s.grade='"+classId+"'");
}
catch(Exception e){
	ExceptionsFile.postException("ViewStudentsPerformance.jsp","Operations on database ","Exception",e.getMessage());
	System.out.println("Error in viewStuPerf is: "+e);

}

%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function getNextPage(anc,userid,grade,fname,lname)
{
	anc.href="ViewPerformance.jsp?emailid="+userid+"&grade="+grade+"&courseid=<%=courseId%>&coursename=<%=courseName%>&fname="+fname+"&lname="+lname+"&mode=teacher";
}

function goBack()
{
	history.back();
	return false;
}

</script>
</head>
<body>
<form>
 <table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
    <tr><td align=center><img src="../images/smartbutton15452.gif" border="0" width="300" height="33"></td></tr>
        <tr>
            <td width>
			<table align=center border="1" width="100%" cellspacing="0" bordercolor="#48A0E0" bordercolordark="#48A0E0" bordercolorlight="#48A0E0">
			<tr>
			    <td align="center" ><font face="Verdana" size="2"><b>Name</b></font></td>
				<td align="center" ><font face="Verdana" size="2"><b>User Id</b></font></td>
				<td align="center" ><font face="Verdana" size="2"><b>Class ID</b></font></td>
			    <td align="center" ><font face="Verdana" size="2"><b>Performance</b></font></td>
			</tr>

<%  try{
			while(rs.next()) { %>
				
				
				<tr>
		        <td><font face="Verdana" size="2"><%=rs.getString("fname")+"	"+rs.getString("lname")%></font></td>
			    <td><font face="Verdana" size="2"><%=rs.getString("emailid")%></font></td>
				<td><font face="Verdana" size="2"><%=rs.getString("grade")%></font></td>
			    <td><font face="Verdana" size="2"><a href="#" onClick="getNextPage(this,'<%=rs.getString("emailid")%>','<%=rs.getString("grade")%>', '<%=rs.getString("fname")%>','<%=rs.getString("lname")%>')">View</a></font></td>
			    </tr>				
				<%
				}
    }catch(Exception e){
		ExceptionsFile.postException("viewStudnetsPer.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ViewStudentsPerformance.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	
 %>
		</table>
		</td></tr>
		<tr>
         <td align=center colspan=4>  
          <input onClick="return goBack()" border="0" src="../images/back.gif" name="I1" width="87" height="38" type="image" TITLE="Back">
          </td>
        </tr>
    </table>
</form>
</body>
</html>
