<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	String scid="";
	//final  String dbURL    = "jdbc:mysql://127.0.0.1:3306/lbdb?user=root&password=whizkids";
	//final  String dbURL    = "jdbc:mysql://59.162.195.3:3306/webhuddle?user=root&password=whizkids";
	final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/lbdb?user=root&password=whizkids";
	final  String dbDriver = "com.mysql.jdbc.Driver"; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int count=0;
%>
<%	
	
	
	try{
	Class.forName(dbDriver );
	out.println("1...");
	con = DriverManager .getConnection( dbURL );
	out.println("2...");
	//con=db.getConnection();
	if(con==null || con.equals(""))
	{
		out.println("not connected"+con);
	}
	else
	{
		out.println("connected..."+con);
	}
	st = con.createStatement() ;
	rs=st.executeQuery("select count(*) from customers");
	if(rs.next())
	{
		count=rs.getInt(1);
		out.println("Customers are..."+count);
	}
	else
	{
		out.println("There are no Customers..."+con);
	}


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

<title>Import Utility</title>
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