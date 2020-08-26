
package DMS;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class ShareFiles extends HttpServlet
{
	private String f_name="";
	private String type="",users="";
	private Connection con=null;
	private Statement st=null;
	private String user[];
	private String files[];
	String teacherId="";
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
		HttpSession session=request.getSession();
		teacherId=(String)session.getValue("emailid");
		f_name=request.getParameter("files");
		type=request.getParameter("grade");
		users=request.getParameter("userids");
		
		try{
				user=users.split(",");
				
				files=f_name.split(",");
				

				con=bean.getConnection();

				st=con.createStatement();
				int n=files.length;
				int m=user.length;
				for(int i=0;i<n;i++)
				{
						
						for(int j=0;j<m;j++)
						{
							
							st.addBatch("insert into shared_data (shared_user,filename,userid,ftype,user_type) "+
							"values('"+teacherId+"','"+files[i].replace('\\','/')+"','"+user[j]+"','"+files[i].substring(files[i].lastIndexOf(".")+1)+"','"+type+"')");
							
							
						}
						
				}
				st.executeBatch();
				
					response.sendRedirect("./DMS/JSP/list.jsp");
				
		}catch(Exception sql)
		{
			sql.printStackTrace();
		}
		finally
	{
		try
		{
							
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se){
			ExceptionsFile.postException("ShareFiles.java","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

	}
}
