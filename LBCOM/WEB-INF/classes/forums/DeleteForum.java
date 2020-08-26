/**
Author  : Santhosh
Version : 2.0
Description : This program is written to Delete the Reply irrespective of the Creator i.e either Administrator or Teacher.
*/
package forums;
import java.io.*;
import java.lang.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class DeleteForum extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try  
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("DeleteForum.java","init","Exception",e.getMessage());
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response)
	{
		Connection con=null;
		DbBean con1=null;
		Statement stmt=null;
	
		try  
		{
			HttpSession session = request.getSession(false);
			response.setContentType("text/html");
			String userName=null,schoolId=null,uType=null,threadName=null,message=null,posteduser=null,postedDate=null;
			String teachString=null,studString=null,forumId=null,aCode="",mode=null,status="",forumName=null;
			String schoolPath=null,actualUser=null;
			int sno=0;
			//userName = (String)session.getAttribute("emailid");
			//schoolId = (String)session.getAttribute("schoolid");
			uType    = (String)session.getAttribute("logintype");

			ServletContext application = getServletContext();
			//schoolPath = application.getInitParameter("schools_path");

			PrintWriter out = response.getWriter();

			mode = request.getParameter("mode");
			
			con1= new DbBean();
			con = con1.getConnection();
				
			if(mode.equals("delete"))
			{
				//System.out.println("entered into edit");
				sno=Integer.parseInt(request.getParameter("sno"));
				schoolId = request.getParameter("sid");
				forumId=request.getParameter("fid");
				threadName=request.getParameter("topic");
				forumName=request.getParameter("dir");
				//message=request.getParameter("message");
				//teachString=request.getParameter("tstring");
				//studString=request.getParameter("sstring");
				//status=request.getParameter("status");
				posteduser=request.getParameter("user");
				postedDate=request.getParameter("postdate");
				actualUser=request.getParameter("auser");
				//System.out.println("status value is..."+status);
				//forumDesc=check4Opostrophe(forumDesc);			
				/*if(teachString.equals("-"))
					aCode=studString;
				else if(studString.equals("-"))
					aCode=teachString;
				else
					aCode=teachString + studString;*/
				stmt = con.createStatement();
				

				int i = stmt.executeUpdate("delete from  forum_post_topic_reply where sno="+sno+" and topic='"+threadName+"' and user_id='"+posteduser+"' and school_id='"+schoolId+"' and forum_id='"+forumId+"'");

				if(i==1)
				{

					//out.println("<center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Reply has been Deleted successfully.</font></i></b></center>");

					if(uType.equals("admin"))
					{
						uType="school";
					}
					else if(uType.equals("teacher"))
					{
						uType="teacher";
					}
			response.sendRedirect("/LBCOM/"+uType+"Admin/Forums/ShowReply.jsp?fid="+forumId+"&user="+actualUser+"&topic="+threadName+"&postdate="+postedDate+"&dir="+forumName);
					
			
				}
			}
		}
		catch(Exception ser)
		{
			ExceptionsFile.postException("DeleteForum.java","service","Exception",ser.getMessage());
		}
		finally
		{
			try  
			{
				if(stmt!=null)
					stmt.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("DeleteForum.java","closing connections","SQLException",se.getMessage());
			}
		}
	}
/*
	synchronized private String check4Opostrophe(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        while(i < s.length()) 
            if(s.charAt(i++) == '\'')
            {
                stringbuffer.replace(j + i, j + i, "'");
                j++;
            }

        return stringbuffer.toString();
    }
	public void destroy(){
		try{
			if(stmt!=null)
			   stmt.close();
			if(con!=null && !con.isClosed()){
			  con.close();
			}
		}
		catch(Exception e1){
			ExceptionsFile.postException("CreateForum.java","destroy","Exception",e1.getMessage());
			
		}
	}*/
}
