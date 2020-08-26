<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	final  String dbURL    = "jdbc:mysql://127.0.0.1:3306/webhuddle?user=root&password=whizkids";
	final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%	
	
	
	try{
		out.println("Service started 1..");
	Class.forName(dbDriver );
	out.println("Service started 2..");
	con = DriverManager .getConnection( dbURL );
	out.println("Service started 3..."+con);
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
	rs=st.executeQuery("select * from customers");
	if(rs.next())
	{
		out.println("Customers are..."+con);
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
			System.out.println("Santhosh...");
		}
		e.printStackTrace();
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