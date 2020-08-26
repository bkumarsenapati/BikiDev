package lbadmin;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;

public class DeleteCourse extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
        Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String c_id=null,mode=null;
	PrintWriter out=null;
	int i=0;
        try  
	 {
          response.setContentType("text/html");
	  out=response.getWriter();
	  db = new DbBean(); 
	  con=db.getConnection();
          st = con.createStatement();
	  c_id=request.getParameter("id");
          if(c_id!=null)
        	  i=st.executeUpdate("delete from lb_course_catalog where course_id='"+c_id+"'");
	  if(i==0)
	   {
	   out.println("details not deleted");
	   }
	  else
	   {
	   response.sendRedirect("/LBCOM/lbadmin/CourseManager.jsp");
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
