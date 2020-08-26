// This Servlet has beed developed for getting the file which has to be uploaded as input.
package studentAdmin;
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
		 PrintWriter pt=null;
        try
        {
            httpservletresponse.setContentType("text/html");
            HttpSession httpsession = httpservletrequest.getSession(false);
            pt = httpservletresponse.getWriter();
			String pfPath;
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			pfPath=application.getInitParameter("schools_path");
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
            pt.println("<script>function checkfld(){");
            pt.println("var le=document.fs.elements[0].value;");
            pt.println("if(le.length==0){");
            pt.println("alert(\"Please select the file to Add\");");
            pt.println("return false;}");
            pt.println("}");
            pt.println("</script>");
            pt.println("</head>");
            pt.println("<body>");
            pt.println("<form name=\"fs\" method=\"POST\" enctype=\"multipart/form-data\" action=\"/LBCOM/studentAdmin.UploadPersonalFile?totalurl="+totalurl+"&foldername="+foldername+"\" onSubmit=\"return checkfld();\">");
            pt.println("<br><br><table align=\"center\"><tr><td colspan=2 bgcolor=\"#E08040\" align=center><b><font color=\"black\" face=\"Verdana\" size=\"2\">Add a File</font></b></td></tr>");
			pt.println("<tr><td colspan=2>&nbsp;</td></tr>");
            pt.println("<tr><td><b><font color=\"#000080\" face=\"Verdana\" size=\"2\">Select a file to Upload ::</font></b></td>");
            pt.println("<td><input type=\"file\" name=\"name\" size=\"30\"></td></tr>");
			pt.println("<tr><td colspan=2>&nbsp;</td></tr>");
            pt.println("<tr><td bgcolor=\"#E08040\" colspan=2 align=\"center\"><input type=\"submit\" value=\"Upload\" name=\"submit\" style=\"color: #000080\"></td></tr></table>");
            pt.println("</form></body></html>");
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("BrowsePersonalFile.java","service","Exception",exception.getMessage());
            pt.println("Error in FileSession:: " + exception);
        }
    }

   
}
