package DMS;

import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
import javax.servlet.*;
import javax.servlet.http.*;


public class MoveFile extends HttpServlet
{
	private String file_name="";
	private String folder_name="";
	private DbBean bean;
	private Connection con=null;
	private Statement st=null;

	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		file_name=request.getParameter("file_name");
		folder_name=request.getParameter("folder_name");
		try{
		bean=new DbBean();
		con=bean.getConnection();
		st=con.createStatement();
		String files[]=file_name.split(",");
		for(int i=0;i<files.length;i++)
		{
		File r_file=new File(files[i]);
		
		File d_folder=new File(folder_name+"/"+r_file.getName());
		st.addBatch("update files set path='"+d_folder.getPath().replace('\\','/')+"' where path='"+r_file.getPath().replace('\\','/')+"'");
		r_file.renameTo(d_folder);
		}
		st.executeBatch();
		
		response.sendRedirect("./DMS/JSP/list.jsp");
		}catch(Exception exp)
		{
			exp.printStackTrace();
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