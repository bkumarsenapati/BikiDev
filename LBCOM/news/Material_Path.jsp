<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	String scid="";
	final  String dbURL    = "jdbc:mysql://96.57.191.220:3306/lbcomrtdb?user=root&password=LBE&123";
	final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%	
	
	
	try{
	Class.forName(dbDriver );
	con = DriverManager .getConnection( dbURL );
	//out.println("Start here 1");
	//con=db.getConnection();
	//out.println("Start here 2");

	if(con==null || con.equals(""))
	{
		out.println("Not Connected"+con);
	}
	else
	{
		out.println("Connected...Connection id is......."+con);
	}
	%>
	<table border="0" width="86%" id="table2" height="104">
	
	<%
	st = con.createStatement() ;
	out.print("Students are ..");
	rs=st.executeQuery("select * from material_publish");
	while(rs.next())
	{
		%>
		<tr>
        <td width="250" height="25" bgcolor="" align="left">
			
				<font size="2" face="Verdana"><%=rs.getString("fname")%>&nbsp;<%=rs.getString("lname")%></font> 
        </td>
       <td width="250" height="25" bgcolor="" align="left"><font size="2" face="Verdana"><%=rs.getString("username")%></font></td>
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
