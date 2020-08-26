<html>
<title> Editor</title>
<%@ page import = "javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>

<% 
    String htmlText = request.getParameter("fileName2"); 
      String fileName = request.getParameter("fileName");
    out.println("html = "  + htmlText);
try{Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cDBase?user=root&password=abc123");
Statement st = con.createStatement();
    if(fileName != null)
{
   int i = st.executeUpdate("insert into cTable (fName, hCode) values( ' "+fileName+ " ' , ' "+htmlText+" ' ) ");
}
   con.close();
}
catch(Exception e)
   {e.printStackTrace();} 
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
				System.out.println("SQLException in save.jsp is..."+se);
			}
		}
%>


<!--
<p>  Your html Code is <br><br><% out.print(htmlText); %><br><br>
Your file name is <br><br><%= fileName %><br><br>
</p>
-->

<p>  Saved under the file name  <br><br><%= fileName %> in cDBase.<br><br> 
</p>

<form action = "return.html" >
<input type = "submit" name = "button" value = "Return"/><br>
</form>
</table>
</form>
</html>
