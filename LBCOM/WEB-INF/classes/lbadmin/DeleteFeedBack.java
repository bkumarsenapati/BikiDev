package lbadmin;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;

public class DeleteFeedBack extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
        Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String count=null;
	PrintWriter out=null;
	int i=0;
        try  
	 {
          response.setContentType("text/html");
	  out=response.getWriter();
	  db = new DbBean(); 
	  con=db.getConnection();
          st = con.createStatement();
	  count=request.getParameter("count");
          if(count!=null)
        	  i=st.executeUpdate("delete from lb_feedbacks where feedback_id='"+count+"'");
	  if(i==0)
	   {
	   out.println("details not deleted");
	   }
	  else
	   {
	   response.sendRedirect("/LBCOM/lbadmin/FeedbackManager.jsp");
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
