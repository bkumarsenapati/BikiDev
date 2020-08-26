package coursemgmt;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sqlbean.DbBean;

// Referenced classes of package coursemgmt:
//            ExceptionsFile

public class AddCluster extends HttpServlet
{

    public AddCluster()
    {
    }

    public void init()
        throws ServletException
    {
        super.init();
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        PrintWriter printwriter;
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        
        httpservletresponse.setContentType("text/html");
        HttpSession httpsession = null;
        printwriter = null;
        httpsession = httpservletrequest.getSession(false);
        printwriter = httpservletresponse.getWriter();
        if(httpsession == null)
        {
            printwriter.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
            return;
        }
        
        String s = "";
        String s1 = "";
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String s9 = "";
        String s11 = "";
        String s12 = "";
        String s13 = "";
        int i = 0;
              
        try
        {
            DbBean dbbean = new DbBean();
            connection = dbbean.getConnection();
            statement = connection.createStatement();
        }
        catch(Exception exception)
        {
            ExceptionsFile.postException("AddCluster.java", "getting connection", "Exception", exception.getMessage());
        }
        ServletContext servletcontext = getServletContext();
        s11 = servletcontext.getInitParameter("schools_path");
        s12 = servletcontext.getInitParameter("schools_path");
        s4 = (String)httpsession.getAttribute("emailid");
        s5 = (String)httpsession.getAttribute("schoolid");
        s7 = (String)httpsession.getAttribute("coursename");
        s2 = (String)httpsession.getAttribute("classid");
        s1 = (String)httpsession.getAttribute("courseid");
        s6 = httpservletrequest.getParameter("mode");
        System.out.println("mode is.." + s6);
        s = httpservletrequest.getParameter("categoryid");
        i = 0;
        if(s6.equals("add"))
		{
            
        
        s3 = httpservletrequest.getParameter("selids");
        s13 = httpservletrequest.getParameter("clname");
		System.out.println("select cluster_name from assessment_clusters where school_id='" + s5 + "' and course_id='" + s1 + "' and teacher_id='" + s4 + "'");
        
        try {
            rs = statement.executeQuery("select cluster_name from assessment_clusters where school_id='" + s5 + "' and course_id='" + s1 + "' and teacher_id='" + s4 + "'"); 
        
        if(rs.next())
        {
            System.out.println("Cluster name..." + rs.getString("cluster_name")+"....s13..."+s13);
            if(s13.equals(rs.getString("cluster_name")))
            {
                printwriter.println("<br><br><br><br><center><center>  <table border=1 cellspacing=1 width=50% id=AutoNumber1><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr></table>");
                printwriter.println("<center><h3><FONT COLOR=#02ADE6 face=Verdana size=2>Cluster name already exists. Please choose another one.</FONT></h3></center>");
                printwriter.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
                printwriter.close();
                return;
            }
        }
      }catch(SQLException se) {
    	  ExceptionsFile.postException("AddCluster.java", "getting resultset", "Exception", se.getMessage());  
      }

        try
        {
            i = statement.executeUpdate("insert into assessment_clusters(school_id,teacher_id,course_id,cluster_name,work_ids,status) values('" + s5 + "','" + s4 + "','" + s1 + "','" + s13 + "','" + s3 + "','1')");
			 i = 1;
        }
        catch(SQLException sqlexception)
        {
            ExceptionsFile.postException("AddCluster.java", "AddGroup", "SQLException", sqlexception.getMessage());
            System.out.println("Exception se in AddGroup.class is..." + sqlexception);
        }
        catch(Exception exception1)
        {
            ExceptionsFile.postException("AddCluster.java", "AddGroup", "Exception", exception1.getMessage());
            System.out.println("Exception e in AddGroup.class is..." + exception1);
        }
       
	}
        if(s6.equals("edit"))
		{
            
        s9 = httpservletrequest.getParameter("clid");
        String clName = httpservletrequest.getParameter("clname");
        try {
           rs = statement.executeQuery("select cluster_name from assessment_clusters where school_id='" + s5 + "' and course_id='" + s1 + "' and teacher_id='" + s4 + "' and cluster_id!='" + s9 + "'");
          if(rs.next())
        {
            System.out.println("Cluster name..." + rs.getString("cluster_name"));
            if(clName.equals(rs.getString("cluster_name")))
            {
                printwriter.println("<br><br><br><br><center><center>  <table border=1 cellspacing=1 width=50% id=AutoNumber1><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr></table>");
                printwriter.println("<center><h3><FONT COLOR=#02ADE6 face=Verdana size=2>Cluster name already exists. Please choose another one.</FONT></h3></center>");
                printwriter.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
                printwriter.close();
                return;
            }
        }
        }catch(SQLException sqlexception1)
          {
              ExceptionsFile.postException("AddCluster.java", "resultset assesment cluster", "SQLException", sqlexception1.getMessage());
          }

        try
        {
            i = statement.executeUpdate("update assessment_clusters set cluster_name='" + clName + "' where course_id='" + s1 + "' and cluster_id='" + s9 + "' and teacher_id='" + s4 + "' and school_id='" + s5 + "'");
			 i = 1;
        }
        catch(SQLException sqlexception1)
        {
            ExceptionsFile.postException("AddCluster.java", "AddGroup", "SQLException", sqlexception1.getMessage());
            System.out.println("Exception se in AddGroup.class is..." + sqlexception1);
        }
        catch(Exception exception2)
        {
            ExceptionsFile.postException("AddCluster.java", "AddGroup", "Exception", exception2.getMessage());
            System.out.println("Exception e in AddGroup.class is..." + exception2);
        }
       
	}
        if(s6.equals("delete"))
        {
            try
            {
                String s10 = httpservletrequest.getParameter("clid");
                i = statement.executeUpdate("delete from assessment_clusters where cluster_id='" + s10 + "' and course_id='" + s1 + "' and teacher_id='" + s4 + "' and school_id='" + s5 + "'");
            }
            catch(SQLException sqlexception2)
            {
                ExceptionsFile.postException("AddCluster.java", "AddGroup", "SQLException", sqlexception2.getMessage());
                System.out.println("Exception se in AddGroup.class is..." + sqlexception2);
            }
            catch(Exception exception3)
            {
                ExceptionsFile.postException("AddCluster.java", "AddGroup", "Exception", exception3.getMessage());
                System.out.println("Exception e in AddGroup.class is..." + exception3);
            }
            i = 1;
        }
        try
        {
            if(i > 0)
            {
                if(s == null)
                    s = "all";
                httpservletresponse.sendRedirect("/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype=all");
                httpservletresponse.flushBuffer();
            } else
            {
                printwriter.println("Transaction failed. Internal server error...");
                printwriter.close();
                httpservletresponse.flushBuffer();
            }
        }
	
        catch(Exception exception4)
        {
            ExceptionsFile.postException("AddCluster.java", "add", "Exception", exception4.getMessage());
        }
        finally
        {
            try
            {
               if(rs != null)
            	  rs.close(); 
            	if(statement != null)
                    statement.close();
                if(connection != null && !connection.isClosed())
                    connection.close();
            }
            catch(SQLException sqlexception3)
            {
                ExceptionsFile.postException("AddCluster.java", "closing connection", "SQLException", sqlexception3.getMessage());
            }
        }
        return;
    }
}
