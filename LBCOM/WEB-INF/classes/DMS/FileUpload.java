package DMS;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import sqlbean.DbBean;

public class FileUpload extends HttpServlet 
{
	private MultipartRequest mreq=null;
	private String f_type="";
	private Connection con=null;
	private PreparedStatement pst=null;
	private DbBean bean;

	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		bean=new DbBean();
		PrintWriter out=response.getWriter();
		//folder_name=request.getParameter("f_upload");
		
		ServletContext sc = getServletConfig().getServletContext();
		HttpSession session=request.getSession();
		String init_path=sc.getInitParameter("app_path1");
		//String path=init_path+"\\WEB-INF\\textfiles\\";
		String path=session.getAttribute("r_path").toString()+"/";
		
		mreq=new MultipartRequest(request,path,10*1024*1024);
		String filename=mreq.getFilesystemName("f_upload");
		
		System.out.println("File Name :"+filename);
		String filepath=path+filename;
		File new_path=new File(filepath);
		f_type=filename.substring(filename.lastIndexOf('.')+1);
		
		/*if(f_type.equals(".doc"))
			f_type="Document";
		else if(f_type.equals(".txt"))
		{
			f_type="Text";
		}
*/


		try{
			
				con=bean.getConnection();
				String uid=session.getAttribute("emailid").toString();
				String query="insert into files (name,path,dt,type,userid) values(?,?,curdate(),?,?)";
				pst=con.prepareStatement(query);
				pst.setString(1,new_path.getName());
				pst.setString(2,new_path.getPath().replace('\\','/'));
				pst.setString(3,f_type.toUpperCase());
				pst.setString(4,uid);
				pst.executeUpdate();
				
			
		}catch(Exception sql)
		{
			sql.printStackTrace();
		}
		finally{
			try{
			con.close();
			}catch(SQLException sqlexp)
			{
				sqlexp.printStackTrace();
			}
		}
		//out.println("<script language=javascript>window.close()</script> ");
		response.sendRedirect("./DMS/JSP/list.jsp");

	}

}
