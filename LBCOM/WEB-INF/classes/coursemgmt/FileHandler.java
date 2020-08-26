package coursemgmt;

import java.util.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import com.oreilly.servlet.MultipartRequest;
import java.util.zip.*;

public class FileHandler {

	public int maxSize;
	private MultipartRequest mRequest;

	public FileHandler(){
		maxSize=10*1048576;
	}

	public void setFileSize(int fSize){
		maxSize=fSize;
	}

//public boolean isFileUploaded(){
//		return false;
//	}

//public void renameTo(String sourceURL,String destURL){
//		return false;
//	}



	public boolean uploadFile(HttpServletRequest request,String destPath){
		try{

			mRequest = new MultipartRequest(request,destPath,maxSize);  
			return true;
		}catch(IOException ie){
			ExceptionsFile.postException("FileHandler.java","uploadFile","IOException",ie.getMessage());
			
			return false;
		}
	}

	private void copyInputStream(InputStream in, OutputStream out) throws IOException
	  {
		byte[] buffer = new byte[2048];
	    int len;
		while((len = in.read(buffer)) >= 0)
	      out.write(buffer, 0, len);
		in.close();
	    out.close();
	  }

  
	public boolean extractZipFile(String fileName,String url){
			Enumeration entries;
			String newPath;
		    try {
				newPath=url+"/"+fileName;
				ZipFile zipFile=new ZipFile(newPath);
				entries = zipFile.entries(); 
				while(entries.hasMoreElements()) {
					ZipEntry entry = (ZipEntry)entries.nextElement();
					if(entry.isDirectory()) {//if the entry is Directory
			          // Assume directories are stored parents first then children.
					  (new File(url+"/"+entry.getName())).mkdirs();
				 	  continue;
				    }//end if is Directory
					((new File(url+"/"+entry.getName())).getParentFile()).mkdirs();
				copyInputStream(zipFile.getInputStream(entry),
				new BufferedOutputStream(new FileOutputStream(url+"/"+entry.getName())));
			  }//end while
		      zipFile.close();
			  return true;
		    } catch(ZipException ze){
				  ExceptionsFile.postException("FileHandler.java","extractZipFile","ZipException",ze.getMessage());
				  
				  return false;
			  }
			  catch (IOException ioe) {
				  ExceptionsFile.postException("FileHandler.java","extractZipFile","IOException",ioe.getMessage());
			 	  
				  				  return false;
				  //ioe.printStackTrace();
			 }
			 catch(IllegalStateException ise){
				 ExceptionsFile.postException("FileHandler.java","extractZipFile","IllegalSateException",ise.getMessage());
				
								  return false;
				//ise.printStackTrace();
			 }
			  
			  
    }//end method extractZipFile

	
}
