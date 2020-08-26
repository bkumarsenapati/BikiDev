package teacherAdmin.organizer;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class saveaddress extends HttpServlet
{
    
    public saveaddress()
    {
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		DbBean db=null;
		Connection connection=null;
		Statement statement=null;
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
        String fcolor=httpservletrequest.getParameter("fcolor");
	    String bcolor=httpservletrequest.getParameter("bcolor");
	    String fstyle=httpservletrequest.getParameter("fstyle");


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
        try
        {
            
			db=new DbBean();
			connection=db.getConnection();

            statement = connection.createStatement();
            String s24 = "Insert into addressbook(school_id,userid,lname,fname,email,webpage,hstreet,hcity,hstate,hzip,hcountry,title,organization,ostreet,ocity,ostate,ozip,ocountry,hphone,wphone,pphone,mphone,fphone,ophone)  VALUES ('"+schoolId+"','" + s + "','" + s1 + "','" + s2 + "','" + s3 + "','" + s4 + "','" + s5 + "','" + s6 + "','" + s7 + "','" + s8 + "','" + s9 + "','" + s10 + "','" + s11 + "','" + s12 + "','" + s13 + "','" + s14 + "','" + s15 + "','" + s16 + "','" + s17 + "','" + s18 + "','" + s19 + "','" + s20 + "','" + s21 + "','" + s22 + "')";
            statement.executeUpdate(s24);

			/*try{
				if(connection!=null)
                   connection.close();

			}catch(Exception e){
				ExceptionsFile.postException("saveaddress.java","closing connections","Exception",e.getMessage());
				
			}*/
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("saveaddress.java","getting connections","Exception",exception.getMessage());
            exception.getMessage();
            
        }
		finally{
			try{
				if(statement!=null)
					statement.close();
			  if (connection!=null && !connection.isClosed())
				{
					connection.close();
				}
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("savfeaddress.java","Closing the connection object","Exception",e.getMessage());
				
			}
		}
        httpservletresponse.setHeader("Refresh", "2;URL=/LBCOM/teacherAdmin.organizer.showaddress?userid=" + s+"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle);
    }
}
