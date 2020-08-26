
package schoolAdmin;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class CreateEditNotice extends HttpServlet{
	

	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("CreateEditNotice.java","init","Exception",e.getMessage());	
			
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response){
		DbBean db=null;
		HttpSession session=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String schoolId=null,nbName=null,nbDesc=null,mode=null,path=null,oldNbName=null;
		PrintWriter out=null;
		File file=null;
		int i=0;
		try{
			response.setContentType("text/html");
			session = request.getSession(false);
			schoolId=(String)session.getAttribute("schoolid");
			out=response.getWriter();
			if(schoolId==null){
				out.println("<html><script> top.location.href='/OHRT/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolPath;
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			mode = request.getParameter("mode");
			nbName=request.getParameter("nbname");
			oldNbName=request.getParameter("oldnbname");
			nbDesc=request.getParameter("nbdesc");
			path=schoolPath+"/"+schoolId;
			db= new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			if(mode.equals("add")){
				rs = st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and nboard_name='"+nbName+"'");
				if(rs.next()){
					out.println("<html><body><font face='Arial' size='2'><b><center><br>Notice Board with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
				}
				else{
					file=new File(path+"/"+nbName);
					if(file.mkdirs()){
						i=st.executeUpdate("insert into notice_boards(schoolid,nboard_name,description,created_date) values('"+schoolId+"','"+nbName+"','"+nbDesc+"',curdate())");
						if(i!=0)
							response.sendRedirect("/OHRT/schoolAdmin/NoticeBoards.jsp");
						else{
							file.delete();
							problem(out);
						}
					}
					else
						problem(out);
				}
			}
			else if(mode.equals("edit")){
					i = st.executeUpdate("update notice_boards set nboard_name='"+nbName+"',description='"+nbDesc+"' where schoolid='"+schoolId+"' and nboard_name='"+oldNbName+"'");
					if(i!=0)
					response.sendRedirect("/OHRT/schoolAdmin/NoticeBoards.jsp");
					else
						problem(out);
			}
			else
				problem(out);	
		}
		catch(Exception e1){
			ExceptionsFile.postException("CreateEditNotice.java","service","Exception",e1.getMessage());	
			
		}finally{
			try{
				       if(st!=null)
						   st.close();
					   if(con!=null && !con.isClosed()){
						   
						   con.close();
					   }
					   db=null;
					   file=null;
				   }catch(SQLException se){
						ExceptionsFile.postException("ShowUsers.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
	}
	
	private void problem(PrintWriter out){
		out.println("<html><body><font face='Arial' size='2'><b><center><br>Problem in creating. Please Try Again. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
	}

/*	public void destroy(){
		try{
			if (con!=null)
			{
			   st.close();
			   db.close(con);
			}
		}
		catch(Exception e){
			ExceptionsFile.postException("CreateEditNotice.java","destroy","Exception",e.getMessage());	
			
			}
	}*/
}
