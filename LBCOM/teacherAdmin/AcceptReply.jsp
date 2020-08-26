<html>
<head><title></title>
</head><body>

<%@  page language="java"  import="java.sql.*,java.util.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	String monthhot[]={" ","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<% 
  Connection con=null;
  Statement statement=null;
  
  String aduser="",puser="",schoolid="",dir="",pdate="",topic="",username="",message="";
 %>


<% 
   try
        {
			con = con1.getConnection();
        }
        catch(Exception ex) {out.println(ex+" its first");}

   //aduser=(String)session.getAttribute("emailid");
   String emailid = request.getParameter("emailid");
   aduser = emailid;
   puser=request.getParameter("puser");
   //schoolid=(String)session.getAttribute("schoolid");
   schoolid = request.getParameter("schoolid");
   //dir=(String)session.getAttribute("dir");
   dir = request.getParameter("dir");
   pdate=request.getParameter("pdate");
   topic=request.getParameter("topic");
   //session.putValue("emailid",aduser);
   //session.putValue("schoolid",schoolid);
   
   
   message=request.getParameter("message");
   message=message.replace('\'','_');
    String d1=new java.util.Date().toString();
        StringTokenizer stz=new StringTokenizer(d1," ");
        String dd,mon,yy,d;
        int mn=0;
        mon=stz.nextToken();
        mon=stz.nextToken();
        dd=stz.nextToken();
        yy=stz.nextToken();
        yy=stz.nextToken();
        yy=stz.nextToken();
            
       for(int i=0;i<monthhot.length;i++)
       {
        if(mon.startsWith(monthhot[i]))
              mn=i;
        else if (mon.equalsIgnoreCase(monthhot[i]))
              mn=i;
       }
        d=yy+"-"+mn+"-"+dd;
         //d=dd+"-"+mn+"-"+yy;

       try
         {
          statement=con.createStatement();
          String query="insert into postdirreply values('"+dir+"','"+topic+"','"+message+"','"+d+"','"+puser+"','"+aduser+"','"+schoolid+"')";
         
          int i=statement.executeUpdate(query);
          
         }
        catch(Exception se)
        {
         out.println(se+" "+2);
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


  response.setHeader("Refresh", "1;URL=../teacherAdmin/ShowTopics.jsp?emailid="+emailid+"&schoolid="+schoolid+"&dir="+dir);

%>
</body>
</html>