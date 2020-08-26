

package teacherAdmin.organizer;

import java.sql.*;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
import java.io.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class deleteaddress extends HttpServlet
{
   
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
           String s ="";
           s = httpservletrequest.getParameter("userid");
           String fcolor=httpservletrequest.getParameter("fcolor");
	       String bcolor=httpservletrequest.getParameter("bcolor");
	       String fstyle=httpservletrequest.getParameter("fstyle");

      try{
		    DbBean db=null; 
		   PrintWriter pw=null;
            httpservletresponse.setContentType("text/html");
            pw=httpservletresponse.getWriter();              
			HttpSession session= httpservletrequest.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null)
			{
				pw.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolId=(String)session.getAttribute("schoolid");
            String s3 = httpservletrequest.getParameter("email");
			Connection connection=null;
			Statement statement=null;
            try
            {
                db=new DbBean();
		        connection=db.getConnection();
                statement = connection.createStatement();
				int resultset = statement.executeUpdate("delete from addressbook where userid='" + s + "' and   email='" + s3 + "' and school_id='"+schoolId+"'");
				try{
					if(connection!=null && !connection.isClosed())
						connection.close();
				}catch(Exception e){
					ExceptionsFile.postException("deleteaddress.java","closing connection","Exception",e.getMessage());
					
				}
               
           }catch(Exception ex) {
				ExceptionsFile.postException("deleteaddress.java","getting connection","Exception",ex.getMessage());
				pw.println(ex); 
			} try{
				if(statement!=null)
					statement.close();
				if(connection!=null && connection.isClosed())
					connection.close();
				db=null;
			   }catch(Exception e){
				   ExceptionsFile.postException("Information.java","closing connection objects","Exception",e.getMessage());
			   }
       }
  
        catch(Exception ex) {
			    ExceptionsFile.postException("deleteaddress.java","service","Exception",ex.getMessage());
		}

	        httpservletresponse.setHeader("Refresh", "2;URL=/LBCOM/teacherAdmin.organizer.showaddress?userid=" + s+"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle);

    }
}
