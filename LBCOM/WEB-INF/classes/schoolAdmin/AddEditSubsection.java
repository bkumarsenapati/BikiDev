package schoolAdmin;

import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class AddEditSubsection extends HttpServlet
{
	
	

	public void init()
	{
		/*try
		{
		//	super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditSubsections.java","init","Exception",e.getMessage());	
			
		}*/
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		HttpSession session=null;
		PrintWriter out=null;
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;

		Utility u1=null;

		String schoolId="",mode="",classId="",subsectionId="",subsectionDes="",schoolPath="";
		int i;
		session=request.getSession();
		out=response.getWriter();
		response.setContentType("text/html");
		schoolId = (String)session.getAttribute("schoolid");				
		classId=   request.getParameter("classid");
		mode = request.getParameter("mode");		
		
		try
		{
			
			String sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();
			ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			u1 = new Utility(schoolId,schoolPath);
			i=0;

			subsectionDes=request.getParameter("subsectiondes");
			classId=request.getParameter("classid");

			if(mode.equals("add"))
			{

				subsectionId=u1.getId("SubsectionId");
				
				if (subsectionId.equals(""))
				{
					u1.setNewId("SubsectionId","S00000");
					subsectionId=u1.getId("SubsectionId");
				}
				
				rs=st.executeQuery("select subsection_id from subsection_tbl where lcase(subsection_des)='"+subsectionDes.toLowerCase()+"' and school_id='"+schoolId+"' and class_id='"+classId+"'");
				
				if(rs.next()){					
						//out.println("<script language=javascript>alert('This class is already exists.'); \n history.go(-1); \n </script>");
						out.println("<center><h3><FONT COLOR=red>Section already exists.Please choose anothername</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						
						out.close();
						
						return;
				
				}else{
					
					i = st.executeUpdate("insert into subsection_tbl values('"+schoolId+"','"+classId+"','"+subsectionId+"','"+subsectionDes.trim()+"')");	
				}
								
			}
			else if(mode.equals("edit"))
			{
				subsectionId = request.getParameter("subsectionid");
				rs=st.executeQuery("select subsection_id from subsection_tbl where lcase(subsection_des)='"+subsectionDes.toLowerCase()+"' and school_id='"+schoolId+"' and class_id='"+classId+"'");
				if(rs.next())
				{
				    if(!subsectionId.equals(rs.getString("subsection_id"))){
				        out=response.getWriter();
						//out.println("<script language=javascript>alert('The class with this name already exists. Please choose another name.'); \n history.go(-1); \n </script>");
						out.println("<center><h3><FONT COLOR=red>Section already exists.Please choose anothername</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}				
				i = st.executeUpdate("update subsection_tbl set subsection_des='"+subsectionDes+"' where school_id='"+schoolId+"' and class_id='"+classId+"' and subsection_id='"+subsectionId+"'");

				
			}
			else if(mode.equals("delete"))
			{
				subsectionId = request.getParameter("subsectionid");
				i = st.executeUpdate("delete from subsection_tbl where school_id='"+schoolId+"' and class_id='"+classId+"' and subsection_id='"+subsectionId+"'");								
			}
			if (i==1)
			{
				response.sendRedirect("/LBCOM/schoolAdmin/DisplaySubsections.jsp?classid="+classId);
			}else{
				out.println("Transaction failed..");
			}
		}
		catch(SQLException es)
		{
			ExceptionsFile.postException("AddEditSubsections.java","service","SQLException",es.getMessage());	
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditSubsections.java","service","Exception",e.getMessage());	
			
		}
		finally
		{
			try
			{
				if(st!=null)
				  st.close();
				if(con!=null){
				  con.close();
				}
				db=null;
			}
			catch(Exception ee)
			{
				ExceptionsFile.postException("AddEditSubsections.java","closing connection","Exception",ee.getMessage());	
				
				}
		}
	}
}
