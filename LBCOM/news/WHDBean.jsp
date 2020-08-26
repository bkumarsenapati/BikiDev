<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	//final  String dbURL    = "jdbc:mysql://59.162.195.3:3306/webhuddle?user=root&password=whizkids";
	//final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null;
	String appPath=application.getInitParameter("app_path");
	boolean flag=false;
	String userId="",pwd="",fName="",lName="";

%>
<%	
	
	
	try{

	con= db.getConnection();
	//String schoolpath=application.getInitParameter("schools_path");
	RandomAccessFile altSqlFile=null;
	String qry1="",qry2="";
	
	altSqlFile=new RandomAccessFile(appPath+"/coursemgmt/alter_users_file.txt","rw");
	st = con.createStatement() ;
	st1 = con.createStatement() ;
	st2 = con.createStatement() ;
	rs=st.executeQuery("select * from studentprofile where schoolid='mcctc'");
	while(rs.next())
	{
		flag=false;
		userId=rs.getString("username");
		
			qry1="alter table mcctc_'"+userId+"' add start_date date default NULL after  max_attempts;\n";
			qry2="alter table mcctc_'"+userId+"' add end_date date default NULL after  start_date;\n";
			
			altSqlFile.writeBytes(qry1);
			altSqlFile.writeBytes(qry2);
		
	}
	altSqlFile.close();

	out.println("SQL file is generated :"+appPath+"/coursemgmt/alter_users_file.txt");
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