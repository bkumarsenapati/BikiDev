package teacherAdmin.organizer;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class HotexamsDelete extends HttpServlet
{
	
    public HotexamsDelete()
    {
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		httpservletresponse.setContentType("text/html");
		PrintWriter out=httpservletresponse.getWriter();
		HttpSession session= httpservletrequest.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if (session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		String schoolId=(String)session.getAttribute("schoolid");
		String s = httpservletrequest.getParameter("userid");
        String bcolor = httpservletrequest.getParameter("bcolor");
        String fcolor = httpservletrequest.getParameter("fcolor");
        String fstyle = httpservletrequest.getParameter("fstyle");
        String s1 = httpservletrequest.getParameter("date");
        String s2 = httpservletrequest.getParameter("month");
        String s3 = httpservletrequest.getParameter("year");
        String s4 = httpservletrequest.getParameter("time");
        String s5 = httpservletrequest.getParameter("title");
        String s6 = httpservletrequest.getParameter("occasion");
        String s7 = httpservletrequest.getParameter("notes");
        String s8 = s1 + "-" + s2 + "-" + s3;
    	Connection connection=null;
		Statement statement =null;
		DbBean db=null;
        try
        {
            db=new DbBean();
		    connection=db.getConnection();

            statement = connection.createStatement();
            statement.executeUpdate("delete from  hotorganizer  where userid='" + s + "' and  date='" + s8 + "' and time='" + s4 + "' and schoolid='"+schoolId+"'");
			try{
				if(connection!=null && !connection.isClosed())
                    connection.close();
			}catch(Exception e){
				ExceptionsFile.postException("HotexamsDelete.java","closing connection","Exception",e.getMessage());
				
			}
        }
        catch(Exception exception1)
        {
			ExceptionsFile.postException("HotexamsDelete.java","getting connection","Exception",exception1.getMessage());
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
				   ExceptionsFile.postException("hotexamsDelete.java","closing connection objects","Exception",e.getMessage());
			   }
            httpservletresponse.setHeader("Refresh", "1;URL=/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3);
        }
    }
}
