
package teacherAdmin.organizer;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class ISAddSave extends HttpServlet
{

    DbBean db;
    public ISAddSave()
    {
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		httpservletresponse.setContentType("text/html");
		PrintWriter out=httpservletresponse.getWriter();
		HttpSession session= httpservletrequest.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		String schoolId=(String)session.getAttribute("schoolid");
		
        String s = httpservletrequest.getParameter("userid");
        String s1 = httpservletrequest.getParameter("month");
        String s2 = httpservletrequest.getParameter("year");
        String s3 = httpservletrequest.getParameter("time");
        String s4 = httpservletrequest.getParameter("noon");
        String s5 = s3 + s4;
        String s6 = httpservletrequest.getParameter("date");
        String s7 = httpservletrequest.getParameter("title");
        String s8 = httpservletrequest.getParameter("occasion");
        String s9 = httpservletrequest.getParameter("notes");
        String fcolor = httpservletrequest.getParameter("fcolor");
        String bcolor = httpservletrequest.getParameter("bcolor");
        String fstyle= httpservletrequest.getParameter("fstyle");
		
		String s10 = s6 + "-" + s1 + "-" + s2;
        Connection connection=null;
		Statement stmt1=null,stmt2=null,statement=null;
	    ResultSet rs=null;
		try
        {
           db=new DbBean();
		   connection=db.getConnection();

            stmt1 = connection.createStatement();
			stmt2 = connection.createStatement();
			int i;
			statement = connection.createStatement();
			           
			rs = statement.executeQuery("select * from hotorganizer where date='"+s10+"' and time='"+s5+"' and userid='"+s+"' and schoolid ='"+schoolId+"'");
			
			if(rs.next())
			{
				stmt1.executeUpdate("update  hotorganizer  set   title='" + s7 + "' , occassion='" + s8 + "', notes='" + s9 + "'  where userid='" + s + "' and date='" + s10 + "' and time='" + s5 + "' and schoolid='"+schoolId+"'");
			}
			else
			{
				stmt2.executeUpdate("insert into hotorganizer values ('" + s + "', '" + s10 + "','" + s5 + "', '" + s7 + "', '" + s8 + "','" + s9 + "','"+schoolId+"','own')");
			}
			
			httpservletresponse.sendRedirect("/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&dd=" + s6 + "&mm=" + s1 + "&yy=" + s2);
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("IsAddSave.java","service","Exception",exception.getMessage());
            exception.getMessage();
        }
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(stmt1!=null)
					stmt1.close();
				if(stmt2!=null)
					stmt2.close();
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
				db=null;
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("IsAddSave.java","closing connections","Exception",e.getMessage());
				e.getMessage();
			}
		}
    }
}
