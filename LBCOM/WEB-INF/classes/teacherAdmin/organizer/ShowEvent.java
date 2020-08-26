package teacherAdmin.organizer;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class ShowEvent extends HttpServlet
{
	

    public ShowEvent()
    {
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		DbBean db=null;
		Connection connection=null;
		Statement statement = null;
        try
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

            httpservletresponse.setContentType("text/html");
            String s = httpservletrequest.getParameter("userid").trim();
            String s1 = httpservletrequest.getParameter("dd");
            String s2 = httpservletrequest.getParameter("mm");
            String s3 = httpservletrequest.getParameter("yy");
            String s4 = httpservletrequest.getParameter("time");
            String s5 = httpservletrequest.getParameter("bcolor");
            String bcolor=s5;
            String s6 = httpservletrequest.getParameter("fcolor");
            String s7 = httpservletrequest.getParameter("fstyle");
            String s8 = s1 + "-" + s2 + "-" + s3;
            String s9 = "";
            String s10 = "";
            String s11 = "";
            if(s.equals(""))
            {
                httpservletresponse.setStatus(204);
                return;
            }
            PrintWriter printwriter = httpservletresponse.getWriter();
            httpservletresponse.setHeader("Cache-Control", "no-store");
            try
            {
                    printwriter.println("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
                    printwriter.println("<meta name=\"GENERATOR\" content=\"Namo WebEditor v5.0\">");
                    printwriter.println("<meta name=\"ProgId\" content=\"FrontPage.Editor.Document\">");
                    printwriter.println("<title></title>");
                    printwriter.println("</head><body>");
                    
                db=new DbBean();
		        connection=db.getConnection();

                statement = connection.createStatement();
                ResultSet resultset = statement.executeQuery("select * from  hotorganizer where userid='" + s + "' and  time='" + s4 + "'  and  date='" + s8 + "' and schoolid='"+schoolId+"'");
                
                if(resultset.next())
                {
                    String s12 = resultset.getString(4);
                    String s13 = resultset.getString(5);
                    String s14 = resultset.getString(6);
                    String s15 = resultset.getString(7);

                    
                   if(bcolor.equals("A8B8D0"))
                   {
                    printwriter.println("<table border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\" valign=\"top\">");
                    printwriter.println("<tbody><tr>");
                    printwriter.println(" <td bgColor=\"#40A0E0\" height=\"25\" width=\"100%\"><font color=\"#FFFFC8\"><b>&nbsp;<font face=\"halvetica\" size=\"-1\">" + s8 + "&nbsp;at&nbsp;" + s4 + "</font>&nbsp;</b></font>&nbsp;&nbsp;&nbsp;<font color=\"#ffffff\" face=\"Arial\" size=\"-1\" align=\"center\"><b>");
                    printwriter.println("Mr." + s + "&nbsp;&nbsp;&nbsp; Your Event</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s + "&bcolor=" + s5 + "&fcolor=" + s6 + "&fstyle=" + s7 + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #00FF00\">Back</a></font></td>");
                    printwriter.println("</tr></tbody></table>");
                     printwriter.println("<table bgColor=\"#a8b8d0\" border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" height=\"148\" width=\"334\" bordercolor=\"#40A0E0\">");
                    printwriter.println("<tbody><tr><td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">SchoolId&nbsp;&nbsp;&nbsp;&nbsp;</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s15 + "</font></td>");
                    printwriter.println("</tr>");
                    printwriter.println("<tr><td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s12 + "</font></td>");
                    printwriter.println("</tr><tr>");
                    printwriter.println("<td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Occassion</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s13 + "</font></td></tr><tr>");
                    printwriter.println("<td height=\"21\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Notes</font></b></td>");
                    printwriter.println("<td height=\"21\" width=\"212\"><font color=\"#FFFF66\">" + s14 + "</font>");
                    printwriter.println("</td></tr></tbody></table>");
                    printwriter.println("<table border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
                    printwriter.println(" <tbody><tr bgColor=\"#e1e1e1\"><td align=\"middle\" bgColor=\"#40A0E0\" noWrap width=\"70%\">");
                    printwriter.println("<p align=\"center\"><font face=\"Arial\" size=\"-1\"><a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s + "&bcolor=" + s5 + "&fcolor=" + s6 + "&fstyle=" + s7 + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #00FF00;text-decoration:none\"><font size=3><b>&lt&ltBack</b></font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println("</font></p></td></tr></tbody></table>");

                    }
                   else if(bcolor.equals("B0A890"))
                     {

                    printwriter.println("<table border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\" valign=\"top\">");
                    printwriter.println("<tbody><tr>");
                    printwriter.println(" <td bgColor=\"#E08448\" height=\"25\" width=\"100%\"><font color=\"#FFFFC8\"><b>&nbsp;<font face=\"halvetica\" size=\"-1\">" + s8 + "&nbsp;at&nbsp;" + s4 + "</font>&nbsp;</b></font>&nbsp;&nbsp;&nbsp;<font color=\"#ffffff\" face=\"Arial\" size=\"-1\" align=\"center\"><b>");
                    printwriter.println("Mr." + s + "&nbsp;&nbsp;&nbsp; Your Event</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s + "&bcolor=" + s5 + "&fcolor=" + s6 + "&fstyle=" + s7 + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #00FF00\">Back</a></font></td>");
                    printwriter.println("</tr></tbody></table>");
                    printwriter.println("<table bgColor=\"#B0A890\" border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" height=\"148\" width=\"334\" bordercolor=\"#E08448\">");
                    printwriter.println("<tbody><tr><td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">SchoolId&nbsp;&nbsp;&nbsp;&nbsp;</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s15 + "</font></td>");
                    printwriter.println("</tr>");
                    printwriter.println("<tr><td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s12 + "</font></td>");
                    printwriter.println("</tr><tr>");
                    printwriter.println("<td height=\"25\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Occassion</font></b></td>");
                    printwriter.println("<td height=\"25\" width=\"212\"><font color=\"#FFFF66\">" + s13 + "</font></td></tr><tr>");
                    printwriter.println("<td height=\"21\" width=\"118\"><b><font color=\"#800000\" face=\"times New roman,Halvetica\">Notes</font></b></td>");
                    printwriter.println("<td height=\"21\" width=\"212\"><font color=\"#FFFF66\">" + s14 + "</font>");
                    printwriter.println("</td></tr></tbody></table>");
                    printwriter.println("<table border=\"1\" cellPadding=\"0\" cellSpacing=\"0\" width=\"100%\">");
                    printwriter.println(" <tbody><tr bgColor=\"#e1e1e1\"><td align=\"middle\" bgColor=\"#E08448\" noWrap width=\"70%\">");
                    printwriter.println("<p align=\"center\"><font face=\"Arial\" size=\"-1\"><a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s + "&bcolor=" + s5 + "&fcolor=" + s6 + "&fstyle=" + s7 + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #00FF00;text-decoration:none\"><font size=3><b>&lt&ltBack</b></font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    printwriter.println("</font></p></td></tr></tbody></table>");
                 }
                }
                else
                {
                    printwriter.println("error occured");
                }
								try{
									if(connection!=null && !connection.isClosed())
			                           connection.close();
								}catch(Exception e){
									ExceptionsFile.postException("showEvent.java","closing connections","Exception",e.getMessage());
									
								}
 
            }
            catch(Exception exception1)
            {
				ExceptionsFile.postException("showEvent.java","getting connections","Exception",exception1.getMessage());
                printwriter.println("sub  " + exception1);
                
            }
            printwriter.println("</body></html>");
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("showEvent.java","service","Exception",exception.getMessage());
            
        }finally{
			try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("updateaddress.java","closing connection objects","Exception",e.getMessage());
			}
		}
    }
}
