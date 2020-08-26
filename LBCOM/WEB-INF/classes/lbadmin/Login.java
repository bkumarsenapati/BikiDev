package lbadmin;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
public class Login extends HttpServlet
{ 
	public void init(ServletConfig sc)
	{
		try
		{
			super.init(sc);
		}
		catch(Exception e){}
	}
	public void service(HttpServletRequest req,HttpServletResponse res)
	{	
		try
		{
			System.out.println("Login");
			HttpSession session=req.getSession(true);
			res.sendRedirect("/TALRT/admin/grid.jsp");	
		}
		catch(Exception e){}
	}
}
