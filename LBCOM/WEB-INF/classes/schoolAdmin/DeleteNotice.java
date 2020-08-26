
package schoolAdmin;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
import coursemgmt.ExceptionsFile;

public class DeleteNotice extends HttpServlet{
	
	

	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("DeleteNotice.java","init","Exception",e.getMessage());	
			
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session=null;
		PrintWriter out=null;
		Connection con=null;
		ResultSet rs=null;
		Statement st=null;
		StringTokenizer stz=null;
		File file=null;
		DbBean db=null;
		String schoolId=null,ids=null,path=null,noticeId=null,dirName=null;
	
		try{
			ids=request.getParameter("filenames");
			dirName=request.getParameter("dir");
			session=request.getSession(false);
			schoolId=(String)session.getAttribute("schoolid");
			out = response.getWriter();
			response.setContentType("text/html");
			if(schoolId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolPath;
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			path = schoolPath+"/"+schoolId+"/"+dirName;


			
			
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			stz=new StringTokenizer(ids,",");
			while(stz.hasMoreTokens()){
				noticeId=stz.nextToken();
				rs=st.executeQuery("select filename from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
				rs.next();
				if(rs.getString(1).indexOf("null")==-1){
					file=new File(path+"/"+rs.getString(1));
					if(file.delete())
						st.executeUpdate("delete from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
				}
				else
					st.executeUpdate("delete from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
			}

			response.sendRedirect("/LBCOM/schoolAdmin/ShowNotices.jsp?name="+dirName);
			
		}
		catch(Exception e1){
			ExceptionsFile.postException("DeleteNotice.java","service","Exception",e1.getMessage());
			
		}finally{
			try{
					   if(st!=null)
						   st.close();
					   if(con!=null && !con.isClosed()){
						   //st.close();
						   con.close();
					   }
					   db=null;
					   stz=null;
					   file=null;
				   }catch(SQLException se){
						ExceptionsFile.postException("ShowUsers.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
	}
}
