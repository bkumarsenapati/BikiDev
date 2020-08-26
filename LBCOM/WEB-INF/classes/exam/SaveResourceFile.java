package exam;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import coursemgmt.ExceptionsFile;
public class  SaveResourceFile extends HttpServlet
{
	
  public void init() throws ServletException {
		super.init();  
  }
  public void service(HttpServletRequest req,HttpServletResponse res) {
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
			String schoolPath = application.getInitParameter("schools_path");
			res.setContentType("text/html");
			out=res.getWriter();
			path= schoolPath+"/resource/im/";
			//path="/Testimages";
			dir=new File(path);
			if(!dir.exists())
				dir.mkdirs();
			mreq=new MultipartRequest(req,path,10*1048576);
			
			presentFileName=mreq.getFilesystemName("lfile");
			File file = new File(schoolPath+"/resource/im/"+presentFileName);
			long len=file.length();
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
			out.close();
			
		}
		catch (Exception e)
		{
			ExceptionsFile.postException("SaveResourceFile.java","service","Exception",e.getMessage());
			out.println(headhtm+"Try Again."+bodyhtm);
			System.out.println("Error in SavePicture.java is "+e);
		}
  }

 /*  private void getParameters(HttpServletRequest req,HttpServletResponse res) {

		newFileName=req.getParameter("alt");

   }*/
}
