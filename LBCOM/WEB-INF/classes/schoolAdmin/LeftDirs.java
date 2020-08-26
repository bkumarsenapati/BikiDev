// Decompiled by Jad v1.5.5.3. Copyright 1997-98 Pavel Kouznetsov.
// Jad home page:      http://web.unicom.com.cy/~kpd/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   LeftDirs.java
package schoolAdmin;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class LeftDirs extends HttpServlet
{
	
    
	public LeftDirs()
    {
    }
    public void init(ServletConfig servletconfig)
    {
        try
        {
            super.init(servletconfig);
        }
        catch(Exception exception) {
		   ExceptionsFile.postException("LeftDir.java","init","Exception",exception.getMessage());
		}
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
		DbBean dbBean=null;
        Connection con=null;
		Statement st=null;
	    ResultSet rs=null;
        try
        {
			String dirname=null;
			String idname=null;
			String path=null;
			String adminid=null;
			String schoolid=null;
            httpservletresponse.setContentType("text/html");
            PrintWriter pt = httpservletresponse.getWriter();
            adminid = httpservletrequest.getParameter("adminid");
            schoolid = httpservletrequest.getParameter("schoolid");
            pt.println("<html><head><title></title>");
			pt.println("<body bgcolor=\"#F2F2F2\">");
            pt.println("<table border=1 bordercolor= #F0B850 bgcolor=#EEE0A1><tr><td width=\"100%\" height=30>");
    		//pt.println("<a style=TEXT-DECORATION:none href=\"/LBCOM/schoolAdmin.SelectDirForUpFiles?schoolid=" + schoolid + "&user=" + adminid + "\" target=\"eright\">");
            pt.println("<b><font face=\"verdana\" color=black size=\"2\">Select Notice Board</font></b></td></tr></table><br>");
            boolean flag=false;
			//con = DriverManager.getConnection("jdbc:mysql://localhost/hsndb?user=hsn&password=whizkids");
			dbBean =new DbBean();
			con=dbBean.getConnection();
            st = con.createStatement();
			rs = st.executeQuery("select * from notice_boards where schoolid='"+schoolid+"'"); 
			while(rs.next())
			{
			    idname = rs.getString(1);
                dirname = rs.getString(2);
                path = idname + "/" + dirname;
				flag=true;
                pt.println("<p><img border=\"0\" src=\"/LBCOM/schoolAdmin/images/Folder.gif\">");
                pt.println("<font color=\"#184883\" face=\"verdana\" size=\"2\">");
                pt.println("<a style=\"TEXT-DECORATION:none\" href='/LBCOM/schoolAdmin/ShowNotices.jsp?name=" + dirname +  "'target=\"eright\">");
				pt.println("<b>" + dirname + "</b></a></font></p>");
            }
			if(flag==false)
				pt.println("<font face='arial' size='2' color='maroon'><b>Notice Boards are yet to be created</b></font>");
          /*  for(rs = st.executeQuery("select * from directoryinfo where adminuserid='" + adminid + "'"); rs.next(); pt.println("<b>" + dirname + "</b></a></font></b></p>"))
            {
                idname = rs.getString(1);
                dirname = rs.getString(2);
                path = idname + "/" + dirname;
                pt.println("<img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/Folder.gif\">");
                pt.println("<font color=\"#184883\" face=\"verdana\" size=\"2\">");
                pt.println("<a style=\"TEXT-DECORATION:none\" href='/LBCOM/schoolAdmin.SelectFilenew?name=" + schoolid + "/" + path + "'target=\"eright\">");
            }
        */
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("LeftDir.java","service","Exception",exception.getMessage());
           // pt.println(exception);
        }
		finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				dbBean=null;
			}catch(Exception e){
				ExceptionsFile.postException("LeftDir.java","closing connection","Exception",e.getMessage());
				
			}
		}
    }
   
}
