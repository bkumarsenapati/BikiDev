package DMS;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
public class  addFolder extends HttpServlet
{
	private String folder_name="";
	private String message="";
	private File f=null;
	private Connection con=null;
	private PreparedStatement pst=null;
	private HttpSession session=null;
	private DbBean bean;
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{

		response.setContentType("text/html");
		PrintWriter out=response.getWriter(); 
		bean=new DbBean();
		folder_name=request.getParameter("folder_name");
		
		ServletContext sc = getServletConfig().getServletContext();
		 session=request.getSession();		
		String init_path=sc.getInitParameter("app_path1");
		//File text_path=new File(init_path+"\\WEB-INF\\textfiles\\"+folder_name);
		File text_path=new File(session.getAttribute("r_path")+"/"+folder_name);

		try{
			con=bean.getConnection();
			
			String uid=session.getAttribute("emailid").toString();
			String query="insert into files (name,path,dt,type,userid) values(?,?,curdate(),'folder',?)";
			pst=con.prepareStatement(query);
			pst.setString(1,text_path.getName());
			pst.setString(2,text_path.getPath().replace('\\','/'));
			pst.setString(3,uid);
			pst.executeUpdate();
		}catch(Exception sql)
		{
			sql.printStackTrace();
		}
		text_path.mkdir();
		response.sendRedirect("./DMS/JSP/list.jsp");
	}
}