package DMS;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
public class  SharedUsers extends HttpServlet
{
	private String folder_name="";
	private String message="";
	private File f=null;
	private Connection con=null;
	private Statement st=null;
	private DbBean bean;
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{

		response.setContentType("text/html");
		try{
		bean=new DbBean();
		con=bean.getConnection();
		st=con.createStatement();
		Enumeration user=request.getParameterNames();
		while(user.hasMoreElements())
		{

			String uid=request.getParameter((String)user.nextElement());
			if(request.getParameter("read_"+uid)!=null)
			{
				
				
				int sid=Integer.parseInt(request.getParameter("sid_"+uid));
				
				String query="update shared_data set permission='"+request.getParameter("read_"+uid)+"' where sid="+sid;
				st.addBatch(query);
			}
		}
			st.executeBatch();
			
			response.sendRedirect("./DMS/JSP/list.jsp");
		}catch(Exception sql)
		{
			sql.printStackTrace();
		}
		finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}
	}
}
