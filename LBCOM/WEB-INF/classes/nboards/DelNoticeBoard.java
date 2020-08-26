package nboards;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class DelNoticeBoard extends HttpServlet{
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("DelNoticeBoard.java","init","Exception",e.getMessage());
			
		}
	}
	public void service(HttpServletRequest req,HttpServletResponse res){
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		try  
		{
			PrintWriter out=null;
			HttpSession session=null;
			String path=null,schoolId=null,creator=null;
			String nbNames[]=req.getParameterValues("nboard");
			session=req.getSession(false);
			schoolId=(String)session.getAttribute("schoolid");
			res.setContentType("text/html");
			out=res.getWriter();
			if(schoolId==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}			
			creator=req.getParameter("creator");
			File file=null,f2=null;
			int j=0;
			boolean flag=false;
			String schoolPath;
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			path=schoolPath+"/"+schoolId+"/nboards";
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();

			if(creator.equals("admin"))
			{
				for(int i=0;i<nbNames.length;i++)
				{
					flag=true;
					file=new File(path+"/"+nbNames[i]);
					String filedocs[]=file.list();
					for(j=0;j<filedocs.length;j++)
					{
						f2=new File(path+"/"+nbNames[i]+"/"+filedocs[j]);
						f2.delete();
					}
					if(file.delete())
					{	
						j=st.executeUpdate("delete from notice_boards where schoolid='"+schoolId+"' and teacherid='admin' and nboard_name='"+nbNames[i]+"'");
						j=st.executeUpdate("delete from notice_master where schoolid='"+schoolId+"' and teacherid='admin' and dirname='"+nbNames[i]+"'");
					}
					else
					{
						problem(out);
						flag=false;
						break;
					}
				}
			} 
			else if(creator.equals("teacher"))
			{
				String teacherId="";
				teacherId=(String)session.getAttribute("emailid");

				for(int i=0;i<nbNames.length;i++)
				{
					flag=true;
					file=new File(path+"/"+nbNames[i]);
					String filedocs[]=file.list();
					for(j=0;j<filedocs.length;j++)
					{
						f2=new File(path+"/"+nbNames[i]+"/"+filedocs[j]);
						f2.delete();
					}
					if(file.delete())
					{	
						j=st.executeUpdate("delete from notice_boards where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and nboard_name='"+nbNames[i]+"'");
						j=st.executeUpdate("delete from notice_master where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and dirname='"+nbNames[i]+"'");
					}
					else
					{
						problem(out);
						flag=false;
						break;
					}
				}
			}

			if(flag==true)
				res.sendRedirect("/LBCOM/nboards/NoticeBoards.jsp?creator="+creator);
		}
		catch(Exception e1)
		{
			ExceptionsFile.postException("DelNoticeBoard.java","service","Exception",e1.getMessage());
		}
		finally
		{
			try  
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("ShowUsers.java","closing connections","SQLException",se.getMessage());
			}
		}
	}
	
	private void problem(PrintWriter out){
		out.println("<html><body><font face='Arial' size='2'><b><center><br>Problem in Deleting. Please Try Again. <a href='/LBCOM/nboards/NoticeBoards.jsp'>Back</a></font></center></body></html>");
	}
}
