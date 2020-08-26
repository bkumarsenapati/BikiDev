<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	//final  String dbURL    = "jdbc:mysql://59.162.195.22.static-hyderabad.vsnl.net.in:3306/webhuddle?user=root&password=whizkids";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%	
	
	
	try{
		System.out.println("Service started 1....................................................");
		con=con1.getConnection();
		System.out.println("Service started 3..."+con);
	if(con==null || con.equals(""))
	{
		out.println("not connected"+con);
	}
	else
	{
		out.println("connected..."+con);
	}
	st = con.createStatement() ;
	st.executeUpdate("create table cobrand_logo(school_id varchar(50) default NULL,logo_name varchar(150) default NULL);");
	out.println("Table Created");
	
	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Santhosh...");
		}
		e.printStackTrace();
	}
	
	
%>

<html>
<head>

<title>Hotschools</title>
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