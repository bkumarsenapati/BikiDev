package nboards;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
import coursemgmt.ExceptionsFile;

public class DeleteNotice extends HttpServlet
{
	
	public void init(ServletConfig config)
	{
		try  
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("DeleteNotice.java","init","Exception",e.getMessage());	
		}
	}
	
	public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		HttpSession session=null;
		PrintWriter out=null;
		Connection con=null;
		ResultSet rs=null;
		Statement st=null;
		StringTokenizer stz=null;
		File file=null;
		DbBean db=null;
		String schoolId=null,ids=null,path=null,noticeId=null,dirName=null,creator=null;
	
		try  
		{
			ids=request.getParameter("filenames");
			System.out.println("ids..."+ids);
			dirName=request.getParameter("dir");
			creator=request.getParameter("creator");
			session=request.getSession(false);
			schoolId=(String)session.getAttribute("schoolid");
			//System.out.println("ids..."+ids+"....dirName.."+dirName+"..schoolId..."+schoolId);
			out = response.getWriter();
			response.setContentType("text/html");
			if(schoolId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolPath;
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			path = schoolPath+"/"+schoolId+"/nboards/"+dirName;
			//System.out.println("path is ...."+path);
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			stz=new StringTokenizer(ids,",");
				
			while(stz.hasMoreTokens())
			{
				noticeId=stz.nextToken();
				System.out.println("noticeId..."+noticeId);
				rs=st.executeQuery("select filename from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
				rs.next();
				if(rs.getString(1).indexOf("null")==-1)
				{
					System.out.println("IF");
					file=new File(path+"/"+rs.getString(1));
					if(file.delete())
						st.executeUpdate("delete from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
					System.out.println("End of IF");
				}
				else
				{
					System.out.println("Else");
					st.executeUpdate("delete from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
					System.out.println("End of Else");
				}
			}			response.sendRedirect("/LBCOM/nboards/ShowNotices.jsp?name="+dirName+"&viewer="+creator+"&createdby="+creator);
						
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
						ExceptionsFile.postException("DeleteNotice.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
	}
}
