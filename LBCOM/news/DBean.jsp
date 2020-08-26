<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	
	
	try{
		con=con1.getConnection();
		st=con.createStatement();

	
	%>
	<table border="0" width="86%" id="table2" height="104">
	
	<%
	
	rs=st.executeQuery("SELECT c.`school_id` , c.`teacher_id` , c.`course_id` , m.`files_path` FROM coursewareinfo c INNER JOIN material_publish m WHERE c.`school_id` = m.`school_id` ORDER BY c.`school_id`");
	while(rs.next())
	{
		%>
		<tr>
        <td width="250" height="25" bgcolor="" align="left">
			
				<font size="2" face="Verdana">/home/oh/jakarta-tomcat-5.0.25/webapps/LBCOM/hsndata/data/schools/<%=rs.getString("school_id")%>/<%=rs.getString("teacher_id")%>/coursemgmt/<%=rs.getString("course_id")%>/CD/<%=rs.getString("files_path")%></font> 
        </td>
      </tr>
  
  <%
	}
  %></table>
  <%
	out.print("End of Students.");
	

	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
	
	
%>

<html>
<head>

<title>Learnbeyond.net</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<body>
<p></p>
<p></p>
<p></p>

<form name= "quesimport" method="post" enctype="multipart/form-data">

<br><br><br>

<%
try{
	if(con!=null && !con.isClosed())
		con.close() ;
}catch(Exception e ){}
%>
</form>
</body>
</html>
