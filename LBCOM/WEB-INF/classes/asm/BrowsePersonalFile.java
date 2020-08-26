// This Servlet has beed developed for getting the file which has to be uploaded as input.
package asm;
import java.io.File;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class BrowsePersonalFile extends HttpServlet
{

    public BrowsePersonalFile()
    {
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        String pfPath;
		//ServletConfig config = getServletConfig();
		ServletContext application = getServletContext();
		pfPath = application.getInitParameter("schools_path");
		
		try
        {
            httpservletresponse.setContentType("text/html");
            HttpSession httpsession = httpservletrequest.getSession(false);
            pt = httpservletresponse.getWriter();
            String foldername = httpservletrequest.getParameter("foldername");
            String emailid = httpservletrequest.getParameter("emailid");
            String schoolid = httpservletrequest.getParameter("schoolid");
			//String emailid = (String)httpsession.getAttribute("emailid");
            //String schoolid = (String)httpsession.getAttribute("schoolid");
			String totalurl = pfPath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername;
			httpsession.setAttribute("path", totalurl);
            pt.println("<html>");
            pt.println("<head>");
            pt.println("<title></title>");
            pt.println("<script language=\"javascript\">function checkfld(){");
            pt.println("var le=document.fs.elements[0].value;");
            pt.println("if(le.length==0){");
            pt.println("alert(\"Please select a file to Upload\");");
            pt.println("return false;}");
            pt.println("}");
            pt.println("</script>");
            pt.println("</head>");
            pt.println("<body>");
            pt.println("<form name=\"fs\" method=\"POST\" enctype=\"multipart/form-data\" action=\"/OHRT/asm.UploadPersonalFile?totalurl="+totalurl+"&foldername="+foldername+"\" onsubmit=\"return checkfld();\">");
            pt.println("<br><br><table align=\"center\"><tr><td colspan=2 bgcolor='#40A0E0' align=center><b><font color=\"black\" face=\"Verdana\" size=\"2\">Add a File</font></b></td></tr>");
			pt.println("<tr><td colspan=2>&nbsp;</td></tr>");
            pt.println("<tr><td><b><font color=\"#000080\" face=\"Verdana\" size=\"2\">Select a file to Upload ::</font></b></td>");
            pt.println("<td><input type=\"file\" name=\"name\" size=\"30\"></td></tr>");
			pt.println("<tr><td colspan=2>&nbsp;</td></tr>");
            pt.println("<tr><td bgcolor='#40A0E0' colspan=2 align=\"center\"><input type=\"submit\" value=\"Upload\" name=\"submits\" style=\"color: #000080\"></td></tr></table>");
            pt.println("</form></body></html>");
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("BrowsePersonalFile.java","service","Exception",exception.getMessage());	
            pt.println("Error in FileSession:: " + exception);
        }
    }

    PrintWriter pt;
}
