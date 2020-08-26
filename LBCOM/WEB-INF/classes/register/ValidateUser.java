package register;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
//session needs to be maintained
public class ValidateUser extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		Connection con = null;
		Statement st = null;
		ResultSet rs=null;
		DbBean db=null;
		String uname,u_pwd;
		Vector courseList=null,webList=null;
		PrintWriter out=null;
		if(session==null)
		 {
			response.sendRedirect("/LBCOM/NoSession.html");
		 }
		 else
		 {
          try  
		   {
			response.setContentType("text/html");
			out=response.getWriter();
			db = new DbBean(); 
			con=db.getConnection();
			st = con.createStatement();
			courseList= (Vector) session.getAttribute("courselist");
			webList= (Vector) session.getAttribute("wblist");
			uname=request.getParameter("uId");
			u_pwd=request.getParameter("pwd");
			rs = st.executeQuery("select userid,password from lb_users where userid='"+uname+"' and password='"+u_pwd+"'");
			if(rs.next())
			{
				session.setAttribute("User",uname);
		        if(courseList==null&&webList==null)
				{
					response.sendRedirect("/LBCOM/products/CourseIndex.jsp");
				}
				else
				{
					response.sendRedirect("/LBCOM/products.PaymentServlet");
				}
			}
			else
			{
				response.sendRedirect("/LBCOM/register/StudentLogin.jsp?mode=invalid");
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ValidateUser.java","operations on database","Exception",e.getMessage());	 
            System.out.println("Exception in register/ValidateUser.java is..."+e);	
		}
		
		finally	     //closes the database connections at the end
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}
			catch(SQLException se)
			{
			   ExceptionsFile.postException("ValidateUser.java","closing statement object","SQLException",se.getMessage());	 
			   System.out.println("Exception in ValidateUser.java....... "+se.getMessage());
			}
		 }
	   }
	}
}
