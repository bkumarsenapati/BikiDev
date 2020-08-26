package lbadmin;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;

public class AddEditCategory extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
    Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String c_name,c_status,name=null,mode;
    PrintWriter out=null;
	int i=0,status=0;
        mode=request.getParameter("mode");
        System.out.println("mode is :"+mode);
        name=request.getParameter("name");
           System.out.println("name while delete"+name);
        try  
	 {
          response.setContentType("text/html");
	  out=response.getWriter();
	  db = new DbBean(); 
	  con=db.getConnection();
          st = con.createStatement();
	  c_name=request.getParameter("cname");
	  c_status=request.getParameter("status");
	  if(c_status=="active"||c_status.equals("active"))
	    {
	    status=1;
	    }
	   else
            {
	    status=0;
	    }
      if(mode.equals("add"))
       {
	  rs = st.executeQuery("select category_name from lb_categories where category_name='"+c_name+"'");
	  if(rs.next())
            {
	    out.println("<html><body><font face='Arial' size='2'><b> <center> <br>Category with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font> </center></body></html>");
	    }
	  else
	    {
	    i=st.executeUpdate("insert into lb_categories values ('"+c_name+"','','"+status+"')");
	     }
	   if(i==0)
	   {
	   out.println("details not added");
	   }
	  else
	   {
	    response.sendRedirect("/LBCOM/lbadmin/CategoryManager.jsp");
           }
       }
    else if(mode.equals("edit"))
      {
          name=request.getParameter("name");
	  rs = st.executeQuery("select category_name from lb_categories where category_name='"+name+"'");
	  rs.next();
	  if(rs.next())
	  {
	  out.println("<html><body><font face='Arial' size='2'><b><center><br>Category with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
	  }
	 else
	  {
	   i=st.executeUpdate("update lb_categories set category_name='"+c_name+"',status='"+status+"' where category_name='"+name+"'");
	   }
	 if(i==0)
	   {
	   out.println("details not updated");
	   }
	  else
	   {
	   response.sendRedirect("/LBCOM/lbadmin/CategoryManager.jsp");
           }
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
