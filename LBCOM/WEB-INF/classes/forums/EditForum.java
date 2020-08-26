/**
Author  : Ramanujam Kondapally
Version : 2.0
Description : This program is written to Edit the Forum irrespective of the Creator i.e either Administrator or Teacher.
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

public class EditForum extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try  
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("EditForum.java","init","Exception",e.getMessage());
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
			String teachString=null,studString=null,forumId=null,aCode="",mode=null,status="";
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
				
			if(mode.equals("edit"))
			{
				//System.out.println("entered into edit");
				forumId=request.getParameter("fid");
				forumName=request.getParameter("fname");
				forumDesc=request.getParameter("fdesc");
				teachString=request.getParameter("tstring");
				studString=request.getParameter("sstring");
				status=request.getParameter("status");
				//System.out.println("status value is..."+status);
				//forumDesc=check4Opostrophe(forumDesc);			
				if(teachString.equals("-"))
					aCode=studString;
				else if(studString.equals("-"))
					aCode=teachString;
				else
					aCode=teachString + studString;
				stmt = con.createStatement();

				int i = stmt.executeUpdate("update forum_master SET forum_name='"+forumName+"',forum_desc='"+forumDesc+"',access_code='"+aCode+"',status='"+status+"' where school_id='"+schoolId+"' and forum_id='"+forumId+"'");

				if(i==1)
				{
					if(uType.equals("admin"))
						uType="school";
					out.println("<html><head><title></title>");
					out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/"+uType+"Admin/ForumMgmtIndex.jsp?schoolid="+schoolId+"&emailid="+userName+"';}");
					out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
					out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Forum has been modified successfully.</font></i></b></center></body></html>");
				}
			}
		}
		catch(Exception ser)
		{
			ExceptionsFile.postException("EditForum.java","service","Exception",ser.getMessage());
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
				ExceptionsFile.postException("EditForum.java","closing connections","SQLException",se.getMessage());
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
