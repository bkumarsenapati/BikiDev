package forums;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import coursemgmt.ExceptionsFile;
public class  Forum_SaveFile extends HttpServlet
{
	
 public void init(ServletConfig servletconfig) throws ServletException{
        super.init(servletconfig);
  }
  public void doPost(HttpServletRequest req,HttpServletResponse res){
	    String bodyhtm=null,headhtm=null,uloded="";
		String path=null,newFileName=null,presentFileName=null,fileName=null;
		File dir=null;
		MultipartRequest mreq1=null;
		PrintWriter out=null;
		boolean flag=false;
		//System.out.println("Before try");
		try
		{
			ServletContext application = getServletContext();
			HttpSession session=req.getSession(false);
			String forumPath = application.getInitParameter("forum_path");
			res.setContentType("text/html");
			out=res.getWriter();
			//System.out.println("courseDevPath....."+courseDevPath);
			path= forumPath+"/images/";
			//path="/Testimages";
			dir=new File(path);
			if(!dir.exists())
				dir.mkdirs();
			mreq1=new MultipartRequest(req,path,5*1024*1024);
			
			presentFileName=mreq1.getFilesystemName("imageurl");
			File file = new File(forumPath+"/images/"+presentFileName);
			//System.out.println(forumPath+"/CB_images/"+presentFileName);
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
			ExceptionsFile.postException("Forum_SaveFile.java","service","Exception",e.getMessage());
			out.println(headhtm+"Try Again."+bodyhtm);
			System.out.println("Error in SavePicture.java is "+e);
		}
  }

 /*  private void getParameters(HttpServletRequest req,HttpServletResponse res) {

		newFileName=req.getParameter("alt");

   }*/
}
