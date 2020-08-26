package schoolAdmin;
import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class AddEditDistrict extends HttpServlet
{
	String os="";
	public void init(ServletConfig config)
	{
		os=System.getProperty("os.name").toLowerCase();
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditDistrict.java","init","Exception",e.getMessage());	
			
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		HttpSession session=request.getSession(true);
		DbBean db=null;
		Connection con=null;
		Statement st=null,st1=null;
		PreparedStatement prestmt=null;
		Utility u1=null;
		String schoolId=null,mode=null,distId=null,distDes=null,schoolPath=null;
		ResultSet rs=null,rs1=null;
		int i=0,j=0;
		PrintWriter out=null;
		schoolId = request.getParameter("schoolid");				
		mode = request.getParameter("mode");	
		response.setContentType("text/html");
		
		try
		{
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
            ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			u1 = new Utility(schoolId,schoolPath);
			i=0;
			distDes=request.getParameter("distdesc");
			
			if(mode.equals("add"))		
			{
				
				distId=u1.getId("DistId");
				if (distId.equals(""))
				{
					u1.setNewId("DistId","DST000");
					distId=u1.getId("DistId");
				}
				rs=st.executeQuery("select dist_id from dist_master where lcase(dist_desc)='"+distDes.toLowerCase()+"' and school_id='"+schoolId+"'");
				if(rs.next())
				{
					out=response.getWriter();
					out.println("<center><h3><FONT COLOR=red>District already exists.Please choose another District</FONT></h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
					out.close();
					return;
				}
				else
				{
					
					i=st.executeUpdate("insert into dist_master values('"+schoolId+"','"+distId+"','"+distDes.trim()+"')");								
				
					
					if (i==1)
						response.sendRedirect("/LBCOM/schoolAdmin/DisplayDistrict.jsp?schoolid="+schoolId+"&userid="+schoolId);
					else
						out.println("Transaction failed.");
				}
			}
			else if(mode.equals("edit"))
			{
				
				distId = request.getParameter("distid");
				// code added by Ghanendra Sisodia starts here
			       rs = st.executeQuery("select dist_id from dist_master where school_id='"+schoolId+"' and dist_desc='"+distDes+"'");
				if(rs.next())
				{
				    if(!distId.equals(rs.getString("dist_id"))){
				        out=response.getWriter();
						//out.println("<script language=javascript>alert('The class with this name already exists. Please choose another name.'); \n history.go(-1); \n </script>");
						out.println("<center><h3><FONT COLOR=red>District name already exists.Please choose anothername</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				// code added by Ghanendra Sisodia starts here				
				i = st.executeUpdate("update dist_master set dist_desc='"+distDes+"' where school_id='"+schoolId+"' and dist_id='"+distId+"'");
				if (i==1)
					response.sendRedirect("/LBCOM/schoolAdmin/DisplayDistrict.jsp?schoolid="+schoolId+"&userid="+schoolId);
				else
					out.println("Transaction failed.");
			}
			else if(mode.equals("delete"))
			{
				
				distId = request.getParameter("distid");
				
				i = st.executeUpdate("delete from dist_master where school_id='"+schoolId+"' and dist_id='"+distId+"'");	
				
				if(i==1)
					response.sendRedirect("/LBCOM/schoolAdmin/DisplayDistrict.jsp?schoolid="+schoolId+"&userid="+schoolId); 
				else
					out.println("Transaction failed.");
			}
		}
		catch(SQLException es)
		{
			ExceptionsFile.postException("AddEditDistrict.java","service","SQLException",es.getMessage());	
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditDistrict1.java","service","Exception",e.getMessage());	
			
		}
		finally
		{
			try
			{
				if(st!=null)
				  st.close();
				if(con!=null && !con.isClosed()){
				  con.close();
				}
				db=null;
			}
			catch(Exception ee)
			{
				ExceptionsFile.postException("AddEditDistrict2.java","closing connection","Exception",ee.getMessage());	
				
			}
		}
	}
}
