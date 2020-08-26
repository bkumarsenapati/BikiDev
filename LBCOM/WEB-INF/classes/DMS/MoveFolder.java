package DMS;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MoveFolder extends HttpServlet
{
	private String s_name="";
	private String d_name="";
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		s_name=request.getParameter("s_name");
		d_name=request.getParameter("d_name");
		String files[]=s_name.split(",");
		for(int i=0;i<files.length;i++)
		{
		File s_folder=new File(files[i]);
		File d_folder=new File(d_name+"/"+s_folder.getName());
		if(s_folder.isFile())
		{
			s_folder.renameTo(d_folder);
		}
		else if(s_folder.isDirectory())
			{
				MovingFile.copyDirectory(s_folder, d_folder);
				MovingFile.delete(s_folder);
			}
		}
		response.sendRedirect("./JSP/foldersList.jsp");
	}
}