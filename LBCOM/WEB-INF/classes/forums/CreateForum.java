/**
Author  : Santhosh
Version : 1.0
Description : This program is written to Create a Forum irrespective of the Creator i.e either Administrator or Teacher.
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

public class CreateForum extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try  
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("CreateForum.java","init","Exception",e.getMessage());
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
			String userName=null,schoolId=null,uType=null,forumName=null,forumDesc=null;
			String teachString=null,studString=null,forumId=null,aCode="",mode=null;
			String schoolPath=null;
			userName = (String)session.getAttribute("emailid");
			schoolId = (String)session.getAttribute("schoolid");
			uType    = (String)session.getAttribute("logintype");

			ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");

			PrintWriter out = response.getWriter();

			mode = request.getParameter("mode");
			con1= new DbBean();
			con = con1.getConnection();
				
			if(mode==null)
			{
				forumName = request.getParameter("frname");
				forumDesc = request.getParameter("frdesc");
				teachString = request.getParameter("tstring");
				studString = request.getParameter("sstring");
				//forumDesc = check4Opostrophe(forumDesc);			
				utility.Utility u1 = new Utility(schoolId,schoolPath);
				u1.setNewId("ForumId","F0000000");
				forumId = u1.getId("ForumId");
				
				if(teachString.equals("-"))
					aCode=studString;
				else if(studString.equals("-"))
					aCode=teachString;
				else
					aCode=teachString + studString;
				stmt = con.createStatement();
				int i = stmt.executeUpdate("insert into forum_master values('"+ schoolId +"','"+ forumId +"','"+ forumName +"','"+ forumDesc +"','"+ userName +"',curdate(),'"+ uType +"','"+ aCode +"','1',0)");
				if(i==1){
					if(uType.equals("admin"))
						uType="school";
					out.println("<html><head><title></title>");
					out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/"+uType+"Admin/ForumMgmtIndex.jsp?schoolid="+schoolId+"&emailid="+userName+"';}");
					out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
					out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Forum Created Successfully</font></i></b></center></body></html>");
				}
			}
			else{
				forumId = request.getParameter("fid");
				forumName = request.getParameter("fname");
				stmt = con.createStatement();
				int i = stmt.executeUpdate("delete from forum_post_topic_reply where school_id='"+schoolId+"' and forum_id='"+forumId+"'");
				i = stmt.executeUpdate("delete from forum_master where school_id='"+schoolId+"' and forum_id='"+forumId+"' and forum_name='"+forumName+"'");
				if(i==1){
					if(uType.equals("admin"))
						uType="school";
					out.println("<html><head><title></title>");
					out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/"+uType+"Admin/ForumMgmtIndex.jsp?schoolid="+schoolId+"&emailid="+userName+"';}");
					out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
					out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Forum Deleted Successfully</font></i></b></center></body></html>");
				}
			}
		}
		catch(Exception ser){
			ExceptionsFile.postException("CreateForum.java","service","Exception",ser.getMessage());
			
		}finally{
				 try{
					   if(stmt!=null)
						   stmt.close();
					   if(con!=null && !con.isClosed()){
						   con.close();
					   }
				   }catch(SQLException se){
						ExceptionsFile.postException("CreateForum.java","closing connections","SQLException",se.getMessage());
						
			   }


		}
	}
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
/*	public void destroy(){
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
