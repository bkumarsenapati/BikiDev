package DMS;
/**
     *  Sends a file to the ServletResponse output stream.  Typically
     *  you want the browser to receive a different name than the
     *  name the file has been saved in your local database, since
     *  your local names need to be unique.
     *
     *  @param req The request
     *  @param resp The response
     *  @param filename The name of the file you want to download.
     *  @param original_filename The name the browser should receive.
     */
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;   
import java.io.BufferedInputStream;
import java.io.FileOutputStream; 
import java.io.IOException; 
import java.io.InputStream; 
import java.io.*;
import java.util.*;
public class  Download extends HttpServlet 
{
	private void doDownload( HttpServletRequest req, HttpServletResponse resp, String filename, String original_filename ) throws IOException
	{
        File f = new File(filename);
        int	 length1   = 0;
        ServletOutputStream op = resp.getOutputStream();
        ServletContext      context  = getServletConfig().getServletContext();
        String mimetype = context.getMimeType( filename );

        //
        //  Set the response and go!
        //
        //
        resp.setContentType( (mimetype != null) ? mimetype : "application/octet-stream" );
        resp.setContentLength( (int)f.length() );
        resp.setHeader( "Content-Disposition", "attachment; filename=\"" + original_filename + "\"" );

        //
        //  Stream to the requester.
        //
		int BUFSIZE = 100;
        byte[] bbuf = new byte[BUFSIZE];
        DataInputStream in = new DataInputStream(new FileInputStream(f));

        while ((in != null) && ((length1 = in.read(bbuf)) != -1))
        {
            op.write(bbuf,0,length1);
        }

        in.close();
        op.flush();
        op.close();
    }
}