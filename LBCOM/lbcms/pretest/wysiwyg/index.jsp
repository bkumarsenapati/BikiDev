<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

<head>
<title>openWYSIWYG Examples</title>
<script language="JavaScript" type="text/javascript"> 
function newWindow() 
{ 
var file = prompt("Enter file name","");
updateTextArea("textarea1");
var text_val = document.getElementById("textarea1").value;
document.getElementById("hidee2").value = text_val;

return file;
} 
</script> 
</head>

<script language="JavaScript" type="text/javascript" src="wysiwyg.js">
</script>

<%@ page import = "javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>

<% 
try{
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/?user=root&password=abc123");
Statement st = con.createStatement();
int i1 =  st.executeUpdate("create database cDBase;");
int i2 = st.executeUpdate("use cDBase;");
int i3 = st.executeUpdate("create table cTable (fName varchar(15), hCode varchar(200));");
 con.close();
}
catch(Exception e)
   {System.out.println("Unable to create ");} 
   finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("SQLException in index.jsp is..."+se);
			}
		}
%>
<body>

<form name="example" action="save.jsp">

<textarea id="textarea1" name="test1" style="height: 170px; width: 500px;">enter text</textarea>
<br><br>
<script language="javascript1.2">
	var x = "5", y ="4";
	var z = x+y;
	var d = new Date(), time = d.getHours();
	generate_wysiwyg("textarea1");
</script>
<br/>

<input type = "hidden" name = "fileName" id="hidee" value = ""/><br>
<input type = "hidden" name = "fileName2" id="hidee2" value = ""/>
<input type="submit"  name="done" value="save" onclick="hidee.value=newWindow()"/>

</form>
</body>
</html>
