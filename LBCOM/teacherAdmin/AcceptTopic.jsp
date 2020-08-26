<html>
<head><title></title>
</head>
<body>
<%@  page language="java"  import="java.sql.*,java.util.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%! 
	String monthhot[]={" ","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<%
  Connection con=null;
  Statement statement=null;
  
  String aduser="",type="",tdir="",schoolid="";
%>
<%
  try
        {
			con = con1.getConnection();
        }
        catch(Exception ex) {
			
			out.println(ex+" its first");}
        //aduser=(String)session.getAttribute("emailid");
        //schoolid=(String)session.getAttribute("schoolid");
        //tdir=(String)session.getAttribute("dir");
		String emailid = request.getParameter("emailid");		 
		aduser = emailid;
		schoolid = request.getParameter("schoolid");
		String dir = request.getParameter("dir");
		tdir = dir;
      
        
        
        String username=aduser;
        //String dir=request.getParameter("dir");
        String topic=request.getParameter("topic");
        topic=topic.replace('\'','_');
        String message=request.getParameter("message");
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
        try
         {
          statement=con.createStatement();
          

           try
           {
             String query="insert into postdirtopic values('"+username+"','"+dir+"','"+topic+"','"+message+"','"+d+"','"+schoolid+"')";
        
        

 
          int i=statement.executeUpdate(query);
          }
          catch(Exception supe)
          {
           out.println(supe+" 1sup");
          }

         }
        catch(Exception se)
        {
         out.println(se+" "+1);
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



        response.setHeader("Refresh", "2;URL=../teacherAdmin/ShowTopics.jsp?emailid="+emailid+"&schoolid="+schoolid+"&dir="+dir);
%>
</body>
</html>