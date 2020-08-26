package DMS;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import sqlbean.DbBean;

public class CBSaveFile extends HttpServlet 
{
	private MultipartRequest mreq=null;
	private String f_type="",presentFileName="";
	private Connection con=null;
	private PreparedStatement pst=null;

	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		PrintWriter out=response.getWriter();
		//folder_name=request.getParameter("f_upload");
		
		ServletContext sc = getServletConfig().getServletContext();
		HttpSession session=request.getSession();
		String init_path=sc.getInitParameter("app_path1");
		//String path=init_path+"\\WEB-INF\\textfiles\\";
		String path=session.getAttribute("r_path").toString()+"\\DMS_image\\";
		
		mreq=new MultipartRequest(request,path,10*1024*1024);
		

		presentFileName=mreq.getFilesystemName("imageurl");
			File file = new File(path+presentFileName);
			
	}

}
