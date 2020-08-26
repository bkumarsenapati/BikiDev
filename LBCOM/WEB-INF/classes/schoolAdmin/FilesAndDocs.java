// Decompiled by Jad v1.5.5.3. Copyright 1997-98 Pavel Kouznetsov.
// Jad home page:      http://web.unicom.com.cy/~kpd/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FilesAndDocs.java

package schoolAdmin;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class FilesAndDocs extends HttpServlet
{

    public FilesAndDocs()
    {
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {	PrintWriter pt=null;
	    String adminid=null;
		String schoolid=null;
        try
        {
            httpservletresponse.setContentType("text/html");
            pt = httpservletresponse.getWriter();
            adminid = httpservletrequest.getParameter("adminid");
            schoolid = httpservletrequest.getParameter("schoolid");
            pt.println("<html>");
            pt.println("<head>");
            pt.println("<title></title>");
            pt.println("</head>");
            pt.println("<frameset cols=\"28%,*\">");
            pt.println("<frame src=\"/LBCOM/schoolAdmin.LeftDirs?adminid=" + adminid + "&schoolid=" + schoolid + "\" name=\"lfdirs\">");
            pt.println("<frame src=\"/LBCOM/schoolAdmin/emptyright.html\" name=\"eright\" target=\"_self\">");
            pt.println("</frameset></html>");
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("FilesAndDocs.java","service","Exception",exception.getMessage());
            pt.println(exception);
        }
    }

    
}
