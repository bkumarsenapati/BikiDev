<%@ page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String workId="",teacherId="",schoolId="",studentId="",courseName="",sectionId="",categoryId="",folderName="";
String names[],path="",docName="",disPath="",courseId="";
File courseFile=null;
int i=0;
%>


<%
   try {
   	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
		
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	studentId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	sectionId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
   	teacherId=request.getParameter("teacherid");
	folderName=request.getParameter("workid");
	courseName=request.getParameter("coursename");
	categoryId=request.getParameter("cat");
	docName=request.getParameter("docname");
	String spath= application.getInitParameter("schools_path");
  	path = spath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;  
	disPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
	courseFile=new File(path);
	names=courseFile.list();
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select * from material_publish where work_id='"+folderName+"' and school_id='"+schoolId+"'");
  }catch(SQLException s){
		ExceptionsFile.postException("ViewMaterial.jsp","Operations on database ","SQLException",s.getMessage());
		try{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("ViewMaterial.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
  } catch(Exception e) {
	  ExceptionsFile.postException("viewMaterial.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
	  System.out.println("THe error is "+e);
  }

%>

<html>
<head>

<script language="JavaScript">

function go(name)
{
	parent.parent.studenttopframe.studentViewMatWin = window.open("<%=disPath%>/"+name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
}


</script>

</head>
<body topmargin=3 leftmargin=3>
<form name="filelist">
	<center>
	<table width=500>
	<tr>
	  <td width=29 bgcolor="#DBD9D5">
	  <td  bgcolor="#DBD9D5" height="21" >
      <p align="left"><font size="2" face="Arial"><font color="#800000"><b><%=docName%>&nbsp;&nbsp;</b></font><font color="#000080"></td>
    </tr>

<%
    try{
		  if(rs.next()) {
			 do{
				 out.println("<tr>"); 
				 out.println("<TD width='29' height='20' align='center' valign='middle' bgcolor='#EEEEEE'><p align='center'><img src='../../coursemgmt/images/File.gif' width='20' height='20' border='0'></p></TD>");
				 out.println("<td bgcolor='#EEEEEE'> <a href='#' onclick=\"go('"+rs.getString("files_path")+"')\">"+rs.getString("description")+"</a>");
				 out.println("</td></tr>");
				   
			 }while(rs.next());
		}else
			out.println("<table><tr><td width='500' bgcolor='#EEEEEE'>No file is published yet </td></tr></table>");
    }catch(Exception e){
		 ExceptionsFile.postException("viewMaterial.jsp","at displaying ","Exception",e.getMessage());

	}finally{
	try{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("viewMaterial.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}



%>



	</table>
  </body>
  </html>
