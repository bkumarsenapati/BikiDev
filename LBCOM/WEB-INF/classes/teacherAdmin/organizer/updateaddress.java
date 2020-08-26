package teacherAdmin.organizer;
import java.io.*;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class updateaddress extends HttpServlet
{

   

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
        String fcolor=httpservletrequest.getParameter("fcolor");
        String bcolor=httpservletrequest.getParameter("bcolor");
	    String fstyle=httpservletrequest.getParameter("fstyle");

        String emailcopy= httpservletrequest.getParameter("emailcopy");
        //java.io.PrintWriter pw=httpservletresponse.getWriter();

        String s1 = httpservletrequest.getParameter("lname");
        String s2 = httpservletrequest.getParameter("fname");
        String s3 = httpservletrequest.getParameter("email");
        String s4 = httpservletrequest.getParameter("webpage");
        String s5 = httpservletrequest.getParameter("hstreet");
        String s6 = httpservletrequest.getParameter("hcity");
        String s7 = httpservletrequest.getParameter("hstate");
        String s8 = httpservletrequest.getParameter("hzip");
        String s9 = httpservletrequest.getParameter("hcountry");
        String s10 = httpservletrequest.getParameter("title");
        String s11 = httpservletrequest.getParameter("organization");
        String s12 = httpservletrequest.getParameter("ostreet");
        String s13 = httpservletrequest.getParameter("ocity");
        String s14 = httpservletrequest.getParameter("ostate");
        String s15 = httpservletrequest.getParameter("ozip");
        String s16 = httpservletrequest.getParameter("ocountry");
        String s17 = httpservletrequest.getParameter("hphone");
        String s18 = httpservletrequest.getParameter("wphone");
        String s19 = httpservletrequest.getParameter("pphone");
        String s20 = httpservletrequest.getParameter("mphone");
        String s21 = httpservletrequest.getParameter("fphone");
        String s22 = httpservletrequest.getParameter("ophone");
        String s23 = new String();
        String s24="";
        DbBean db=null;
		Connection connection=null;
		Statement statement =null;
        try
        {
            db=new DbBean();
		    connection=db.getConnection();

            statement = connection.createStatement();
            
            s24 = "update addressbook set userid='" + s + "',lname='" + s1 + "',fname='" + s2 + "',email='" + s3 + "',webpage='" + s4 + "',hstreet='" + s5 + "',hcity='" + s6 + "',hstate='" + s7 + "',hzip='" + s8 + "',hcountry='" + s9 + "',title='" + s10 + "',organization='" + s11 + "',ostreet='" + s12 + "',ocity='" + s13 + "',ostate='" + s14 + "',ozip='" + s15 + "',ocountry='" + s16 + "',hphone='" + s17 + "',wphone='" + s18 + "',pphone='" + s19 + "',mphone='" + s20 + "',fphone='" + s21 + "',ophone='" + s22 + "' where email='"+emailcopy+"' and school_id='"+schoolId+"' and userid='"+s+"'";

                                                                                                                                                                                                                                                                                                                    
            int suc=statement.executeUpdate(s24);
			try{           
				if(connection!=null && connection.isClosed())
					connection.close();
			}catch(Exception e){
				ExceptionsFile.postException("updateaddress.java","closing connection","Exception",e.getMessage());
				
			}
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("updateaddress.java","getting connection","Exception",exception.getMessage());
            
            exception.getMessage();
        }finally{
			try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();

			}catch(Exception e){
				ExceptionsFile.postException("updateaddress.java","closing connection objects","Exception",e.getMessage());
			}
		}
        httpservletresponse.setHeader("Refresh", "2;URL=/LBCOM/teacherAdmin.organizer.showaddress?userid=" + s+"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle);
    }
}
