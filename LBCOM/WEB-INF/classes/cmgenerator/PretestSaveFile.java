package cmgenerator;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import coursemgmt.ExceptionsFile;
public class  PretestSaveFile extends HttpServlet
{

	public void init() throws ServletException 
	{
		super.init();  
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res)
	{
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
			String appPath = application.getInitParameter("app_path");
			res.setContentType("text/html");
			out=res.getWriter();
			path= appPath+"/pretest/images/";
			//path="/Testimages";
			dir=new File(path);
			if(!dir.exists())
				dir.mkdirs();
			mreq=new MultipartRequest(req,path,15*1024*1024);
			
			presentFileName=mreq.getFilesystemName("imageurl");
			File file = new File(appPath+"/pretest/images/"+presentFileName);
			/*long len=file.length();
			if(len>0)
				uloded="parent.window.document.frm2.preview.disabled=false;";
			
			headhtm="<html><head><script language='JavaScript'>\n"+
				"function prev(){\n"+
				"history.go(-1);}\n"+
				"</script></head><body><table><tr><td><h3><font size='3' color='red'>\n";
			bodyhtm="</font></h3></td><td>\n"+
				"<input type='button' value='Back' onclick='prev()'></td></tr></table></body></html>";
			if(len>0)
				out.println(headhtm+"See preview."+bodyhtm);
			else        
				out.println(headhtm+"Try Again."+bodyhtm);
			out.close();*/
			
		}
		catch (Exception e)
		{
			ExceptionsFile.postException("PretestSaveFile.java","service","Exception",e.getMessage());
			out.println(headhtm+"Try Again."+bodyhtm);
			System.out.println("Error in PretestSaveFile.java is "+e);
		}
  }

 /*  private void getParameters(HttpServletRequest req,HttpServletResponse res) {

		newFileName=req.getParameter("alt");

   }*/
}
