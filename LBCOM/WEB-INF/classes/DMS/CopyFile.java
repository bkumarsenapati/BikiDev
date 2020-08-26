package DMS;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import sqlbean.DbBean;

public class CopyFile extends HttpServlet
{
	private String file_name="";
	private String folder_name="";
	private FileInputStream fis=null;
	private FileOutputStream fos=null;
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session=request.getSession();
		file_name=session.getAttribute("allfiles").toString();
		CopyFiles cp=new CopyFiles();

		folder_name=request.getParameter("dest_path");
		
		String files[]=file_name.split(",");
		int x=0,y=0;
		
		for(int i=0;i<files.length;i++)
		{

		File r_file=new File(files[i]);
		if(r_file.isFile())
			{
			String ext=r_file.getName().substring(r_file.getName().lastIndexOf(".")+1);
			String sc_file=r_file.getPath();
			folder_name=folder_name+"\\"+r_file.getName();
			
			// to copy file
			cp.copyFile1(sc_file,folder_name);
			
			
		}
		else if(r_file.isDirectory())
			{
			cp.copyDirectory(r_file.getPath(),folder_name);
			
		}
		}
		response.sendRedirect("./DMS/JSP/list.jsp");
	}
}