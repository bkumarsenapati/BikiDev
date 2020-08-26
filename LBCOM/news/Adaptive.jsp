<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%

	final  String dbURL    = "jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=RAM_SQL";
	//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
	final  String dbDriver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%	
	
	
	try{
		out.println("......................Service started 1........................");
	Class.forName(dbDriver ).newInstance ();
	out.println("Service started 2..");
	con = DriverManager .getConnection( dbURL,"madhu","admin" );
	out.println("Service started 3...");
	out.println("con is...."+con);
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
	st.executeUpdate("update customers set customer_id=5 where customer_id=13");
	
	out.println("Success ...");

	

	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("...");
		}
		e.printStackTrace();
	}
	
	
%>

<html>
<head>

<title>Adaptive</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<body>
<p></p>
<p></p>
<p></p>

<form name= "adaptive" method="post" enctype="multipart/form-data">

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