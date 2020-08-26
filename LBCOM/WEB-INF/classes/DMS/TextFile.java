
package DMS;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;

public class TextFile extends HttpServlet
{
	private String f_name="";
	private String message="";
	private Connection con=null;
	private PreparedStatement pst=null;
	private Statement st=null;
	FileOutputStream fos=null;
	DbBean bean;
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		response.setContentType("text/html");
		bean=new DbBean();

		PrintWriter out=response.getWriter(); 
		f_name=request.getParameter("f_name");
		message=request.getParameter("msg");
		
		File text_path=new File(f_name);
		try{
			con=bean.getConnection();
			if(!(request.getParameter("mode").equals("edit")))
			{
				HttpSession session=request.getSession();
				String userid=session.getAttribute("emailid").toString();
				String query="insert into files (name,path,dt,type,userid) values(?,?,curdate(),'text',?)";
				pst=con.prepareStatement(query);
				pst.setString(1,text_path.getName());
				pst.setString(2,text_path.getPath().replace('\\','/'));
				pst.setString(3,userid);
				pst.executeUpdate();
			}
			
			st=con.createStatement();

		//for status update in shared_data 
		st.executeUpdate("update shared_data set status='true' where filename='"+f_name.replace('\\','/')+"'");
		fos=new FileOutputStream(text_path);
		byte msg[]=message.getBytes();
		fos.write(msg);
		response.sendRedirect("./DMS/JSP/list.jsp");
		fos.close();
		
		}catch(Exception sql)
		{
			sql.printStackTrace();
		}finally{
			try{
					if(fos!=null)
					fos.close();
					if(pst!=null)
					pst.close();
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
