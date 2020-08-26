
package teacherAdmin.organizer;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class CalAppoint extends HttpServlet
{


    public CalAppoint()
    {
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        try
        {
            httpservletresponse.setContentType("text/html");
            String s = ""; 
			/*String fcolor=httpservletrequest.getParameter("fcolor");
			String bcolor=httpservletrequest.getParameter("bcolor");
			String fstyle=httpservletrequest.getParameter("fstyle");*/
            String purpose=httpservletrequest.getParameter("purpose");
            String fcolor="",bcolor="",fstyle="";
            if(purpose.equalsIgnoreCase("teacher"))
            {
				  s=httpservletrequest.getParameter("userid");
                  fcolor="D00068";
                  bcolor="A8B8D0";
                  fstyle="Verdana";
            }          
            else if(purpose.equalsIgnoreCase("student"))
            {
				  HttpSession httpsession = httpservletrequest.getSession(false);
				  s = (String)httpsession.getAttribute("emailid");
                  fcolor="D00068";
                  bcolor="B0A890";
                  fstyle="Verdana";
            }          
            else if(purpose.equalsIgnoreCase("school"))
            {
				  s=httpservletrequest.getParameter("userid");
                  fcolor="000000";
				  //fcolor="EFD3DE";
				  bcolor="EEE0A1";	
				  fstyle="Verdana";
            }          



            PrintWriter printwriter = httpservletresponse.getWriter();
            printwriter.println("<html><head><title></title>");
            printwriter.println("<script language=\"JavaScript\">");
            printwriter.println("var day=new Date();");
            printwriter.println("var userid=\"" + s+"\"");
			printwriter.println("var fcolor1=\"" +fcolor+"\"");
			printwriter.println("var bcolor1=\"" +bcolor+"\"");
            printwriter.println("var fstyle1=\"" +fstyle+"\"");

			//printwriter.println("alert(bcolor1+fcolor1+fstyle1)");
            printwriter.println(" var dd=day.getDate();  var mm=day.getMonth(); mm++;  var yy=day.getYear();");
            printwriter.println("if(navigator.appName == \"Netscape\")    yy=yy+1900;");
            printwriter.println("document.write(\"<frameset rows=0,* border=0 frameborder=0 framespacing=0>\");");
            if(purpose.equalsIgnoreCase("teacher"))
            {
            printwriter.println("document.write(\"<frame src='../teacherAdmin/yk_hot_logot.html'  scrolling=no noresize marginheight=0 marginwidth=0 width=100% target='cal'>\");");
            }
           else if(purpose.equalsIgnoreCase("student"))
            {
             printwriter.println("document.write(\"<frame src='../teacherAdmin/yk_hot_logos.html'  scrolling=no noresize marginheight=0 marginwidth=0 width=100% target='cal'>\");");
            }
             else if(purpose.equalsIgnoreCase("school"))
            {
             printwriter.println("document.write(\"<frame src='../teacherAdmin/yk_hot_logos.html'  scrolling=no noresize marginheight=0 marginwidth=0 width=100% target='cal'>\");");
            }

            printwriter.println("document.write(\"<frameset cols=28%,* border=0 frameborder=0 framespacing=0>\");");
            //printwriter.println("document.write(\"<frame name='cal' src='http://www.hotexams.com/servlets/teacherAdmin.organizer.CalApp1?userid=\"+userid+\"&bcolor=\"+bcolor1+\"&fcolor=\"+fcolor1+\"&fstyle=\"+fstyle1+\"' scrolling=no noresize marginheight=0 marginwidth=0 target='org' >\");");
			//the above statement is made commnet my kumar on 04-11-2003 to fix local bugs ....

			printwriter.println("document.write(\"<frame name='cal' src='/LBCOM/teacherAdmin.organizer.CalApp1?userid=\"+userid+\"&bcolor=\"+bcolor1+\"&fcolor=\"+fcolor1+\"&fstyle=\"+fstyle1+\"' scrolling=no noresize marginheight=0 marginwidth=0 target='org' >\");");
           printwriter.println("document.write(\"<frame src='/LBCOM/teacherAdmin.organizer.Organizer1?userid=\"+userid+\"&bcolor=\"+bcolor1+\"&fcolor=\"+fcolor1+\"&fstyle=\"+fstyle1+\"&dd=\"+dd+\"&mm=\"+mm+\"&yy=\"+yy+\"' scrolling=auto marginheight=0 marginwidth=0  name='org'>\");");
            printwriter.println("document.write(\"</frameset></frameset>\");  </script> </head> <body bgcolor=\"#ffffff\"></body> </html>");
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("CalAppoint.java","service","Exception",exception.getMessage());
            exception.getMessage();
        }
    }
}
