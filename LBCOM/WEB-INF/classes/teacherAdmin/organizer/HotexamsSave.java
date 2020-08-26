package teacherAdmin.organizer;
import java.io.*;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;


public class HotexamsSave extends HttpServlet
{  
	
    public HotexamsSave()
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
        String s4 = httpservletrequest.getParameter("date");
        String s5 = httpservletrequest.getParameter("title");
        String s6 = httpservletrequest.getParameter("occasion");
        String s7 = httpservletrequest.getParameter("notes");
        String s8 = s4 + "-" + s1 + "-" + s2;
        String fcolor = httpservletrequest.getParameter("fcolor");
        String bcolor = httpservletrequest.getParameter("bcolor");
        String fstyle= httpservletrequest.getParameter("fstyle");
		DbBean db=null;
		Connection connection=null;
		Statement statement =null;
        try
        {
            db=new DbBean();
		    connection=db.getConnection();
            statement = connection.createStatement();
            statement.executeUpdate("insert into  hotorganizer  values ('" + s + "', '" + s8 + "','" + s3 + "', '" + s5 + "', '" + s6 + "','" + s7 + "','"+schoolId+"','own')");
			try{
				if(connection!=null)
                     db.close(connection);
			}catch(Exception e){
				ExceptionsFile.postException("HotexamSave.java","closing connection","Exception",e.getMessage());
				System.out.println("Connection close failed");}
        }
        catch(Exception exception1)
        {
			ExceptionsFile.postException("HotexamSave.java","sercvice","Exception",exception1.getMessage());
            exception1.getMessage();
        }
        finally
        {
			 try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
				db=null;
			   }catch(Exception e){
				   ExceptionsFile.postException("HotexamsSave.java","closing connection objects","Exception",e.getMessage());
			   }
            httpservletresponse.setHeader("Refresh", "1;URL=/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=verdana&dd=" + s4 + "&mm=" + s1 + "&yy=" + s2);
        }
    }
}
