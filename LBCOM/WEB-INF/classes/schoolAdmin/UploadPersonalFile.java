//This Servlet to get the url of the folder which to be uploaded and upload the File if it is lessthan 2MB.
//It is imports MultipartRequest.class from "com.oreilly.servlet" package.
package schoolAdmin;
import com.oreilly.servlet.MultipartRequest;
import java.io.*;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
public class UploadPersonalFile extends HttpServlet
{

    public UploadPersonalFile()
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

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		String s1,s2,schoolid,adminid,foldername,pfPath;
		File checksizeoffile,checksizeoffolder;
		PrintWriter printwriter = httpservletresponse.getWriter();
		long total;
        try
        {
			HttpSession httpsession = httpservletrequest.getSession(false);
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			pfPath=application.getInitParameter("schools_path");
			foldername = httpservletrequest.getParameter("foldername");
            adminid = (String)httpsession.getAttribute("adminid");
            schoolid = (String)httpsession.getAttribute("schoolid");
			String s = httpservletrequest.getParameter("totalurl");
			//------------getting size of existing folder
			String adminurl =pfPath+"/"+schoolid+"/"+adminid+"/PersonalFolders/";			
			File adminfolder = new File(adminurl);
			String userfolders[] = adminfolder.list();
			int i,j;
			long temp,ts=0;
			for(i=0;i<userfolders.length;i++)
			{
				File userfolder = new File(adminurl+"/"+userfolders[i]);
				String files[] = userfolder.list();
				for(j=0;j<files.length;j++)
				{
					File currentfile = new File(userfolder+"/"+files[j]);
					temp=currentfile.length();
					ts=ts+temp;
					
				}
			}
			//-------------end of code
			httpservletresponse.setContentType("text/html");
			printwriter.println("<HTML>");
			printwriter.println("<head><Title>Decoded Uploaded File</title><head>");
			printwriter.println("<body>");
			MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, s, 0xf00000);
			Enumeration enumeration = multipartrequest.getParameterNames();
			printwriter.println("<pre>");
			for(; enumeration.hasMoreElements(); printwriter.println(s1 + " = " + s2))
			{
				s1 = (String)enumeration.nextElement();
				s2 = multipartrequest.getParameter(s1);
			}
			printwriter.println("</pre>");
			Enumeration enumeration1 = multipartrequest.getFileNames();
			printwriter.println("<pre>");
			for(; enumeration1.hasMoreElements(); printwriter.println("</pre>"))
			{
				String s3 = (String)enumeration1.nextElement();
				String s4 = multipartrequest.getFilesystemName(s3);
				String s5 = multipartrequest.getContentType(s3);
				File file = multipartrequest.getFile(s3);
				if(file.isFile())
				{
					if((file != null))
					{
						total=ts+file.length();
						
						if(total<2080800)
						{
							httpservletresponse.sendRedirect("/LBCOM/schoolAdmin/uploaded.jsp?adminid="+adminid+"&schoolid="+schoolid+"&foldername="+foldername+"");
						}
						else
							file.delete();
							httpservletresponse.sendRedirect("/LBCOM/schoolAdmin/notuploaded.jsp?adminid="+adminid+"&schoolid="+schoolid+"&foldername="+foldername+"");
					}
				}
				else
					httpservletresponse.sendRedirect("/LBCOM/schoolAdmin/notuploaded.jsp?adminid="+adminid+"&schoolid="+schoolid+"&foldername="+foldername+"");
			}
			
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("UploadPersonalFile.java","service","Exception",exception.getMessage());	
            printwriter.println("<pre>");
            exception.printStackTrace(printwriter);
            printwriter.println("</pre>");
        }
        printwriter.println("</body></html>");
    }

    private void unhandledEvent(String s, String s1, Object obj)
    {
    }
}
