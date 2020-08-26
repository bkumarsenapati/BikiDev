<html>
<head><title></title>
</head>
<body>
<%@  page language="java"  import="java.sql.*,java.util.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
  Connection con=null;
  Statement statement=null;
  String aduser="",tdir="",schoolid="";
%>
<%
		try
        {
			con = con1.getConnection();
        }
        catch(Exception ex) {
			out.println(ex+" its first");
		}
        
		//aduser=(String)session.getAttribute("emailid");
		String emailid = request.getParameter("emailid");
		aduser = emailid;
		//tdir=(String)session.getAttribute("dir");
		String dir = request.getParameter("dir");
		tdir = dir;
        //schoolid=(String)session.getAttribute("schoolid");        
		schoolid = request.getParameter("schoolid");        
        
        //String dir=request.getParameter("dir");
        String message=request.getParameter("message");
        message=message.replace('\'','_');
        String d=new java.util.Date().toString();
         try
         {
          statement=con.createStatement();
          String query="insert into dirsuggession values('"+aduser+"','"+dir+"','"+message+"','"+d+"','"+schoolid+"')";
          int i=statement.executeUpdate(query);
         }
        catch(Exception se)
        {
        out.println(se+" 1");
        }
     finally
       {
        try
        {
			if(statement!=null)
		        statement.close();
			if(con!=null)
		        con.close();
        }catch(Exception e){System.out.println("Connection close failed");}

       }
        response.setHeader("Refresh", "2;URL=../teacherAdmin/ShowTopics.jsp?emailid="+emailid+"&schoolid="+schoolid+"&dir="+tdir);
%>
</body>
</html>