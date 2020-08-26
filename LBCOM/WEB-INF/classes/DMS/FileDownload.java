
package DMS;
import java.io.IOException;
import java.io.File;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.FileOutputStream;
//import java.net.Proxy;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.URL;

import java.net.URLConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;

import coursemgmt.ExceptionsFile;

public class FileDownload extends HttpServlet{

	//member declaretion
	private String source_path="",dest_path="";
	private URL url=null;
	private URLConnection urlConnection=null;
	private InputStream input=null;
	private File dest_fol=null;
	private FileOutputStream fos=null;
	private String zip_source="";
	private ZipCreate cc;
   
   //method declaretions
      public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
		{
		  doPost(request,response);
	  }
	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
     try
     {
		 response.setContentType("text/html");
		 PrintWriter out=response.getWriter();

			 /*  InetAddress proxyAddress = InetAddress.getLocalHost()  ;
			InetSocketAddress inetSocketAddress = new InetSocketAddress(proxyAddress, 8088);

					Proxy proxy = new Proxy(Proxy.Type.HTTP, inetSocketAddress);
			*/
			ServletContext sc = getServletConfig().getServletContext();
			source_path=request.getParameter("source");
			
			String init_path=sc.getInitParameter("app_path");
			String download_path=sc.getInitParameter("download_path");
			url = new URL(source_path);
			
			urlConnection = url.openConnection();
			urlConnection.connect();
			input = url.openStream();
			dest_fol=new File(init_path+"/DMS/files/temp_download");
			source_path=source_path.replace('\\','/');
			String outfile="out_"+source_path.substring(source_path.lastIndexOf("/")+1);
			
			cc=new ZipCreate();
//javascript:history.go(-1)
			if(!(dest_fol.exists()))
			 {
				dest_fol.mkdir();
			 }

//			dest_path=dest_fol.getPath()+"/"+source_path.substring(source_path.lastIndexOf("/")+1);
//			
			
			fos=new FileOutputStream(outfile);
			int i=0;

			while((i=input.read())!=-1)
			{
				fos.write(i);
			}
			if(fos!=null)
				fos.close();
			

//			String temp_path=dest_path.substring(0,dest_path.lastIndexOf("/"));
//			
			
			String source=init_path.substring(0,init_path.lastIndexOf("/"))+url.getPath();//init_path+"/files/temp_download";
			//cc.createZip(source,temp_path+".zip");
			
			cc.createZip(outfile,dest_fol+"/temp.zip");
			File del_file=new File(outfile);
			if(del_file.exists())
				del_file.delete();
			//out.print("<html><head>ghouse<script language=\"javascript\">window.open('"+download_path+"/temp_download/temp.zip')</script></head></html>");
			response.sendRedirect("./DMS/JSP/list_temp.jsp?fol_name="+request.getParameter("fol_name")+"&path="+download_path+"/temp_download/temp.zip");
			//response.sendRedirect("./DMS/JSP/list.jsp?fol_name="+request.getParameter("fol_name"));

       } catch ( Exception e )
       {
			ExceptionsFile.postException("FileDownload.Java","closing statement object","SQLException",e.getMessage());	 
			System.out.println(e.getMessage());
       }
	   finally{
		try{
			if(input!=null)
				input.close();

		}catch(Exception e)
		{
			ExceptionsFile.postException("FileDownload.Java","closing statement object","SQLException",e.getMessage());	 
			System.out.println(e.getMessage());
		}
	}

   }
}