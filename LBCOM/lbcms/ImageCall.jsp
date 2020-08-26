<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>
</head>
<body topmargin=2 leftmargin=0>
<form name="secicons" id='secicons'>



<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
%>

   
<%
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
			
     try{
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			Blob image = null; 
			OutputStream o = response.getOutputStream();

			byte[ ] imgData = null ; 
%>
	
<%
			rs = st.executeQuery("select image from lbcms_dev_sec_icons"); 

			while(rs.next()) { 

				System.out.println("---");
				flag=true;

			image = rs.getBlob(1);
			imgData = image.getBytes(1,(int)image.length());
			%>
			<TABLE cellpadding="15" border="1" style="background-color: #ffffcc;"> <% response.setContentType("image/gif");  %> <TR>
			<td>
<%
			o.write(imgData);
%>
			</td></tr>
		</table>
				<%
			//
			}
		%>
			<%
			if(flag==false)
			{

			out.println("Display Blob Example"); 

			out.println("image not found for given id"); 

			return; 

			}


// display the image 
		//response.setContentType("image/gif");

		//OutputStream o = response.getOutputStream();

		//o.write("<img src='dreamcodes/web_icons/"+imgData+"' hspace='5' vspace='5' border='0'/>");
		//o.write(imgData);
%>
		<!-- <table style="margin: 0px; margin-top: 15px;">
			<tr>
			<td id="photo">
			
			</td>
			</tr>
			</table> -->

<%

		o.flush();

		o.close();

} catch (Exception e) { 

out.println("Unable To Display image"); 

out.println("Image Display Error=" + e.getMessage()); 

return; 

} finally { 

try { 

rs.close();

st.close();

con.close();

} catch (SQLException e) { 

e.printStackTrace();

}

}

%> 
 </form>
 </body>
 </html>

