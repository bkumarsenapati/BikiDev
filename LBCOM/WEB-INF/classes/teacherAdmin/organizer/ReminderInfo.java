package teacherAdmin.organizer;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class ReminderInfo extends HttpServlet
{
	
    static final String Months[] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", 
        "Nov", "Dec"
    };
    /*public ReminderInfo()
    {
        con = null;
    }*/
    public void init(ServletConfig servletconfig)throws ServletException
    {
        super.init(servletconfig);
    }
	/*public void destroy()
    {
        try
        {
            if(con != null)
                db.close(con);
        }
        catch(Exception ex) {
			ExceptionsFile.postException("RemiderInfo.java","closing connections","Exception",ex.getMessage());
			

		}
    }*/
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		
		DbBean db=null;
		Connection con=null;
		Statement statement=null;
		ResultSet resultset=null;  
		PrintWriter pw=null; 
		try
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
			db= new DbBean();
			con=db.getConnection();
                
			pw=httpservletresponse.getWriter();
            httpservletresponse.setHeader("Cache-Control", "no-store");
            httpservletresponse.setContentType("text/html");
			//String purpose = httpservletrequest.getParameter("purpose").trim();
			String s = httpservletrequest.getParameter("userid").trim();
            String s1= httpservletrequest.getParameter("date").trim();
            String s2=httpservletrequest.getParameter("time").trim();
            StringTokenizer stzu=new StringTokenizer(s,"@");
            String user=stzu.nextToken().trim();
            StringTokenizer sz=new StringTokenizer(s1,"-");
            String d=sz.nextToken();
            String m1=sz.nextToken();
            String y=sz.nextToken();
            int mv=Integer.parseInt(m1);
            String today=Months[mv-1]+" "+d+","+y;
            pw.println("<html><head></head><body>");
			pw.println("<table width=\"600\"><tr><td width=\"500\">&nbsp;</td><td align=\"right\" width=\"100\"><font align=\"right\" size=\"2\" face=\"Verdana\" style=\"color:#000080\"><b>"+today+"</b><br></font></td></tr>");
            //pw.println("<tr><td width=\"500\">&nbsp;</td><td align=\"right\" width=\"100\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font align=\"right\" size=\"2\" face=\"Verdana\" style=\"color:#000080\"> <a href=\"/LBCOM/teacherAdmin.organizer.Reminder?userid="+s+"&purpose="+purpose+"\" style=\"color:blue;text-decoration:none\"><b>&lt;&lt;BACK</b></a><br></font></td></tr></table>");
			pw.println("<tr><td width=\"500\">&nbsp;</td><td align=\"right\" width=\"100\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font align=\"right\" size=\"2\" face=\"Verdana\" style=\"color:#000080\"> <a href=\"/LBCOM/teacherAdmin.organizer.Reminder?userid="+s+"\" style=\"color:blue;text-decoration:none\"><b>&lt;&lt;BACK</b></a><br></font></td></tr></table>");
		    statement=con.createStatement();


            resultset = statement.executeQuery("SELECT * from hotorganizer where date= '"+s1 +"' and userid= '"+s+"' and time='"+s2+"' and schoolid='"+schoolId+"'");
	        String val1="",val2="",val3="", val4="",val5="",val6="";		     
            pw.println("<center><font color=\"red\" ><font size=\"2\" face=\"Verdana\"><b>Dear "+user+", Today Your Appointment</b></font></font></center>");

            if(resultset.next())
            {          
				val1=resultset.getString(1);
				val2=resultset.getString(2);
				val3=resultset.getString(3);
				val4=resultset.getString(4);
				val5=resultset.getString(5);
				val6=resultset.getString(6);
	       
				pw.println("<form name=fm>");        
				pw.println("<Center><table><tr><td align=\"right\"><font color=\"red\"><font size=\"2\" face=\"Verdana\">Time:</font></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><font color=\"blue\"><font size=\"2\" face=\"Verdana\">"+val3+"</font></font></td></tr>");
		        pw.println("<tr><td align=\"right\"><font color=\"red\"><font size=\"2\" face=\"Verdana\">Title:</font></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><font color=\"blue\"><font size=\"2\" face=\"Verdana\">"+val4+"</font></font></td></tr>");
				pw.println("<tr><td align=\"right\"><font color=\"red\"><font size=\"2\" face=\"Verdana\">Occassion:</font></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><font color=\"blue\"><font size=\"2\" face=\"Verdana\">"+val5+"</font></font></td></tr>");
		        pw.println("<tr><td align=\"right\"><font color=\"red\"><font size=\"2\" face=\"Verdana\">Notes:</font></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><font color=\"blue\"><font size=\"2\" face=\"Verdana\">"+val6+"</font></font></td></tr></table></center>");
			   //pw.println("<center><input type=button value=\"Close\" onclick=\"javascript:self.close()\"></center>");
		   }
		   else
		   {
				pw.println("<center><b>Dear "+user+", today you dont have any Appointments</b></center> ");
		   }
		   if(resultset!=null)
			   resultset.close();
		   if(statement!=null)
	           statement.close();
		   if (con!=null && !con.isClosed())
		   {
				con.close();
		   }
           pw.println("</form></body></html>");
        }
 		catch(Exception ex)
        {
			ExceptionsFile.postException("RemiderInfo.java","service connections","Exception",ex.getMessage());
			pw.println(ex);
        }
		finally{
			try{
			  if(statement!=null)
				  statement.close();
			  if (con!=null && !con.isClosed())
				{
					con.close();
				}
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("ReminderInfo.java","Closing the connection object","Exception",e.getMessage());
				
			}
		}	
	}
}
