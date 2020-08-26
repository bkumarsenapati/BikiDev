<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	

<%
	String schoolid="";
    Connection dbCon=null; 
	Statement st=null;
    ResultSet rs=null;
%>
<%
	String myschoolid = (String)request.getParameter("myschoolid");		    	
	try
	{
		dbCon=con1.getConnection();
		st=dbCon.createStatement(); 
		rs = st.executeQuery( "select t.firstname,t.lastname,t.schoolid,t.username,t.class_id, t.password,a.course_name,a.course_id ,m.class_des from teachprofile t , coursewareinfo a ,class_master m  where   t.schoolid ='"+myschoolid+"' and  m.school_id= '"+myschoolid+"'   and   t.schoolid= '"+myschoolid+"' and  a.class_id = t.class_id and a.school_id=t.schoolid and a.teacher_id=t.username and m.class_id=t.class_id and a.status='1'");
	}
	catch(Exception se)
	{		
		System.out.println("SQL Error in tlist.jsp");		
	}		
%>

<html>
<head>
<title>Teacher List</title>
<script language='javascript' >

function windowsetting( schoolid ,  courseid , grade , tname , cname )
{
	window.open("studentlist.jsp?myschoolid="+schoolid+"&mycourseid="+courseid+"&mytname="+tname+"&mygrade="+grade+"&mycname="+cname+"  ","studentdetails","location=no , target='self', scrollbars=yes ,fullscreen=no ,status=yes ,titlebar=yes,width=550 , height=350 ");
}

</script>
</head>

<body leftmargin='100' topmargin='10'>

<div align="left">

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" id="table1" >
   <tr>             
	   <td width="359" height="20%" align="center" valign="middle" colspan="3" >
          <p align="left"><font face="Verdana" size="2" ><b>School Name : 
                </b></font><font size="2" face="Verdana"><%=request.getParameter("myschoolid")%></font> 
       </td>
	   <td width="358" height="20%" align="center" valign="middle" colspan="3" >
          <p align="right"><b><font face="Verdana" size="2">
                <a target="_self" href="slist.jsp"><< Schools List</a></font></b></td>
    </tr>
   <tr>             
	   <td width="100%" colspan="6" align="center">
			<font face="Verdana" size="2"><b>List of Courses in this School</b></font> 
       </td>
    </tr>
   <tr>             
	   <td width="40%" height="20%" align="center" valign="bottom" bgcolor="#0099FF" >
              <p align="center"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Course Name</b></font></span></p>
 
       </td>
	   <td width="10%" height="20%" align="center" valign="bottom" bgcolor="#0099FF" >
              <span style="font-size:10pt;"><font face="Arial" color="white"><b>Teacher Name</b></font></span> 
       </td>
       <td width="10%" height="10%" valign="bottom" bgcolor="#0099FF" colspan="2" >
              <p align="center"><font face="Arial" color="white"><b><span style="font-size: 10pt">Teacher ID</span></b></font> </p>
       </td>
       <td width="10%" height="10%" align="center" valign="bottom" bgcolor="#0099FF" >
	          <p align="center"><span style="font-size:10pt;"><font face="Arial" color="white"><b>Password</b></font></span></p>
       </td>
       <td width="10%" height="10%" align="center" valign="bottom" bgcolor="#0099FF" >
              <p align="center"><font face="Arial" color="white"><b><span style="font-size: 10pt">Class ID</span></b></font>
       </td>
    </tr>

<% 
	while(rs.next())
	{
%>
	<tr>
        <td width="20%" height="25" bgcolor=""  align="left">	     	      
                <font size="2" face="Verdana"><b><%=rs.getString("a.course_name")%></b></font>           
        </td>
        <td width="20%" height="25" bgcolor=""  align="left">	     	      
	      	<font size="2" face="Verdana"><%=rs.getString("t.firstname")%>&nbsp;<%=rs.getString("t.lastname")%></font>           
        </td>
        <td width="10%" height="25" bgcolor="" align="left" colspan="2">
	      	<font size="2" face="Verdana"><%=rs.getString("t.username")%></font>         
       </td>
       <td width="10%" height="25" bgcolor="" align="left">
	        <font size="2" face="Verdana"><%= rs.getString("t.password") %></font>         
       </td>
       <td width="10%" height="20%" bgcolor="" align="left">
           
                 <a href="javascript://"               onClick="windowsetting('<%=rs.getString("t.schoolid")%>','<%=rs.getString("a.course_id")%>','<%=rs.getString("m.class_des")%>','<%=rs.getString("t.firstname")%>+<%=rs.getString("t.lastname")%>','<%=rs.getString("a.course_name")%>')" ><font size="2" face="Verdana"><%=rs.getString("m.class_des")%></font></a>       
       </td>
   </tr>

<% 
	}
%>
</table>
</div>
<%
	   rs.close();
	   dbCon.close();
%>
</body>
</html>