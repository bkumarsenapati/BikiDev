package nboards;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
import utility.FileUtility;

public class AddNewNoticeBoard extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try  
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("CreateEditNotice.java","init","Exception",e.getMessage());	
		}
	}
	
	public void service(HttpServletRequest request,HttpServletResponse response)
	{
		DbBean db=null;
		HttpSession session=null;
		Connection con=null;
		Statement st=null,st1=null,st2=null;
		ResultSet rs=null,rs1=null;
		String schoolId=null,nbName=null,nbDesc=null,mode=null,creator=null,path=null,teacherId=null,oldNbName=null;
		PrintWriter out=null;
		File file=null;
		int i=0,j=0;
		
		try  
		{
			response.setContentType("text/html");
			session = request.getSession(false);
			schoolId=(String)session.getAttribute("schoolid");
			out=response.getWriter();
			if(schoolId==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolPath;
			FileUtility fu=new FileUtility();
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			mode = request.getParameter("mode");
			creator=request.getParameter("creator");
			nbName=request.getParameter("nbname");
			oldNbName=request.getParameter("oldnbname");
			nbDesc=request.getParameter("nbdesc");
			path=schoolPath+"/"+schoolId+"/nboards";
			db= new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			
			if(creator.equals("admin"))
			{
				if(mode.equals("add"))
				{
					rs = st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and nboard_name='"+nbName+"'");
					if(rs.next())
					{
						out.println("<html><body><font face='Arial' size='2'><b><center><br>Notice Board with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
					}
					else
					{
						file=new File(path+"/"+nbName);
						if(file.mkdirs())
						{
							i=st.executeUpdate("insert into notice_boards(schoolid,teacherid,nboard_name,description,created_date) values('"+schoolId+"','admin','"+nbName+"','"+nbDesc+"',curdate())");
							if(i!=0)
								response.sendRedirect("/LBCOM/nboards/NoticeBoards.jsp?creator=admin");
							else
							{
								file.delete();
								problem(out);
							}
						}
						else
							problem(out);
					}
				}
				else if(mode.equals("edit"))
				{
					i = st.executeUpdate("update notice_boards set nboard_name='"+nbName+"',description='"+nbDesc+"' where schoolid='"+schoolId+"' and nboard_name='"+oldNbName+"'");

					// From here Added by Santhosh 
					
					// To Rename the Notice Board Folder

					fu.renameFile(path+"/"+oldNbName,path+"/"+nbName);

					// Update the Notice Board Name with new one					

					rs1 = st1.executeQuery("select * from notice_master where schoolid='"+schoolId+"' and dirname='"+oldNbName+"'");
					if(rs1.next())
					{
						j = st2.executeUpdate("update notice_master set dirname='"+nbName+"' where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and dirname='"+oldNbName+"'");

					}

					// Upto here 

					if(i!=0)
						response.sendRedirect("/LBCOM/nboards/NoticeBoards.jsp?creator=admin");
					else
						problem(out);
				}
				else
					problem(out);	
			}
			else if(creator.equals("teacher"))
			{
				teacherId=(String)session.getAttribute("emailid");
				if(mode.equals("add"))
				{
					rs = st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and nboard_name='"+nbName+"'");
					if(rs.next())
					{
						out.println("<html><body><font face='Arial' size='2'><b><center><br>Notice Board with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
					}
					else
					{
						file=new File(path+"/"+nbName);
						if(file.mkdirs())
						{
							i=st.executeUpdate("insert into notice_boards(schoolid,teacherId,nboard_name,description,created_date) values('"+schoolId+"','"+teacherId+"','"+nbName+"','"+nbDesc+"',curdate())");
							if(i!=0)
								response.sendRedirect("/LBCOM/nboards/NoticeBoards.jsp?creator=teacher");
							else
							{
								file.delete();
								problem(out);
							}
						}
						else
							problem(out);
					}
				}
				else if(mode.equals("edit"))
				{
					i = st.executeUpdate("update notice_boards set nboard_name='"+nbName+"',description='"+nbDesc+"' where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and nboard_name='"+oldNbName+"'");
					// From here Added by Santhosh 
					
					// To Rename the Notice Board Folder

					fu.renameFile(path+"/"+oldNbName,path+"/"+nbName);

					// Update the Notice Board Name with new one
					//System.out.println("select * from notice_master where schoolid='"+schoolId+"' and nboard_name='"+oldNbName+"'");
					rs1 = st1.executeQuery("select * from notice_master where schoolid='"+schoolId+"' and dirname='"+oldNbName+"' and teacherid='"+teacherId+"'");
					if(rs1.next())
					{
						j = st2.executeUpdate("update notice_master set dirname='"+nbName+"' where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and dirname='"+oldNbName+"'");

					}
					else
					{
						// System.out.println("");
					}
					
					// Upto here 
					if(i!=0)
						response.sendRedirect("/LBCOM/nboards/NoticeBoards.jsp?creator=teacher");
					else
						problem(out);
				}
				else
					problem(out);
			}
		}
		catch(Exception e1)
		{
			ExceptionsFile.postException("AddNewNoticeBoard.java","service","Exception",e1.getMessage());	
		}
		finally
		{
			try{
		       if(st!=null)
				   st.close();
			   if(con!=null && !con.isClosed()){
				   con.close();
			   }
			   db=null;
			   file=null;
		   }catch(SQLException se){
				ExceptionsFile.postException("AddNewNoticeBoard.java","closing connections","SQLException",se.getMessage());
		   }
		}
	}
	
	private void problem(PrintWriter out)
	{
		out.println("<html><body><font face='Arial' size='2'><b><center><br>There is a problem in creating the Notice Board. Please try once again. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
	}
}
