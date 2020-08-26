package Commonmail;

import com.oreilly.servlet.MultipartRequest;
import java.io.*;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class FileUpload extends HttpServlet
{

    public FileUpload()
    {
    }

    protected boolean create()
        throws Exception
    {
        return true;
    }

    public void destroy()
    {
        super.destroy();
    }

    protected void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
    }

    protected void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        PrintWriter printwriter = httpservletresponse.getWriter();
        try
        {
            httpservletresponse.setContentType("text/html");
            HttpSession httpsession = httpservletrequest.getSession(false);
            String s = (String)httpsession.getAttribute("attachmenturl");
			//String s= httpservletrequest.getParameter("attachmenturl");
			String userid= httpservletrequest.getParameter("userid");
			String schoolid= httpservletrequest.getParameter("schoolid");
			String category= httpservletrequest.getParameter("category");
			
			printwriter.println("<HTML>");
            printwriter.println("<head><Title>Decoded Uploaded File</title><head>");
            printwriter.println("<script>");
            printwriter.println("</script>");
            printwriter.println("<body>");
            printwriter.println("<form>");
            MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, s, 0xf00000);
            Enumeration enumeration = multipartrequest.getParameterNames();
            printwriter.println("<pre>");
            String s1;
            while(enumeration.hasMoreElements()) 
                s1 = (String)enumeration.nextElement();

            printwriter.println("</pre>");
            printwriter.println("Files:");
            Enumeration enumeration1 = multipartrequest.getFileNames();
            printwriter.println("<pre>");
            for(; enumeration1.hasMoreElements(); printwriter.println("</table>"))
            {
                String s2 = (String)enumeration1.nextElement();
                String s3 = multipartrequest.getFilesystemName(s2);
                String s4 = multipartrequest.getContentType(s2);
                File file = multipartrequest.getFile(s2);
                if(file != null)
                {
                    httpsession.setAttribute("filename", file.getName());
                    httpsession.setAttribute("filepath", file.toString());
                    //httpservletresponse.sendRedirect("/Commonmail/MailWithAttachment.jsp");
					String filename = file.getName();
					String filepath = file.toString();
                    printwriter.println("<input type=hidden name=category value=\"+category+\">");
					printwriter.println("<input type=\"hidden\" name=\"schoolid\" value=\"+schoolid+\">");
					printwriter.println("<input type=\"hidden\" name=\"userid\" value=\"+userid+\">");
					printwriter.println("<input type=\"hidden\" name=\"filname\" value=\"+filename+\">");
                    printwriter.println("<input type=\"hidden\" name=\"filpath\" value=\"+filepath+\">");

					httpservletresponse.sendRedirect("/Commonmail/MailWithAttachment.jsp");//?category="+category+"& "+schoolid+" "+userid+" "+filename+" "+filepath");				
                }
            }

        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("FileUpload.java","service","Exception",exception.getMessage());
            printwriter.println("<pre>");
            exception.printStackTrace(printwriter);
            printwriter.println("</pre>");
        }
        printwriter.println("</body>");
        printwriter.println("</form>");
        printwriter.println("</html>");
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
    }

    private void unhandledEvent(String s, String s1, Object obj)
    {
    }
}
