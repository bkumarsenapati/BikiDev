package cmgenerator;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import coursemgmt.ExceptionsFile;
public class  CBSaveFile extends HttpServlet
{
	
  public void init() throws ServletException {
		super.init();  
  }
  public void doPost(HttpServletRequest req,HttpServletResponse res){
	    String bodyhtm=null,headhtm=null,uloded="";
		String path=null,newFileName=null,presentFileName=null,fileName=null;
		File dir=null;
		MultipartRequest mreq=null;
		PrintWriter out=null;
		boolean flag=false;
		try
		{
			ServletContext application = getServletContext();
			HttpSession session=req.getSession(false);
			String courseDevPath = application.getInitParameter("lbcms_dev_path");
			String appPath = application.getInitParameter("app_path");
			String lbcmsFPath = application.getInitParameter("lbcms_file_path");
			res.setContentType("text/html");
			out=res.getWriter();
			path= courseDevPath+"/CB_images/";
			dir=new File(path);
			if(!dir.exists())
				dir.mkdirs();
			mreq=new MultipartRequest(req,path,15*1024*1024);
			
			presentFileName=mreq.getFilesystemName("imageurl");
			System.out.println("presentFileName..."+presentFileName);
			String cbFile=lbcmsFPath+"/CB_images/"+presentFileName+"";
			System.out.println(courseDevPath+"/CB_images/"+presentFileName);
			File file = new File(courseDevPath+"/CB_images/"+presentFileName);
			out.println("<script>");
			//out.println("var copyImage='"+presentFileName+"';");
			out.println("opener.document.f1.src.value = \""+cbFile+"\";");
			//out.println("window.opener.ImageDialog.showPreviewImage(\""+presentFileName+"\");");
			out.println("window.opener.switchType(\""+cbFile+"\");");
			out.println("window.opener.generatePreview();");
			out.println("</script>");
			out.println("<script>window.close();</script>");
			

			
		}
		catch (Exception e)
		{
			ExceptionsFile.postException("CBSaveFile.java","service","Exception",e.getMessage());
			out.println(headhtm+"Try Again."+bodyhtm);
			System.out.println("Error in SaveVideo is "+e);
		}
  }
}
