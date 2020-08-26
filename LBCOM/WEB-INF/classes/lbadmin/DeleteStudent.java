package lbadmin;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;

public class DeleteStudent extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
        Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String user=null;
	PrintWriter out=null;
	int i=0,j=0;
        try  
	 {
          response.setContentType("text/html");
	  out=response.getWriter();
	  db = new DbBean(); 
	  con=db.getConnection();
          st = con.createStatement();
	  user=request.getParameter("id");
          if(user!=null)
           {
       	    i=st.executeUpdate("delete from lb_users where userid='"+user+"'");
		   }
	  if(i==0)
	   {
	   out.println("details not deleted");
	   }
	  else
	   {
	   response.sendRedirect("/LBCOM/lbadmin/StudentManager.jsp");
           }
       }
  catch(Exception e1)
     {
      System.out.println(e1);	
     }
   finally{     //closes the database connections at the end
	try{
	  if(rs!=null)
	  rs.close();
	  if(st!=null)
	  st.close();
	  if(con!=null && !con.isClosed())
	  con.close();
	}catch(SQLException se){
			//ExceptionsFile.postException("CreateCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			//System.out.println(se.getMessage());
		}
	}
  }
}
