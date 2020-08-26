package utility;
//import java.io.File;
import java.io.*;
import coursemgmt.ExceptionsFile;
public class FileUtility 
{
	
	public void copyFile(String scrUrl,String dstUrl){
		byte buffer []=new byte[100*1024];
		FileInputStream fis=null;
		FileOutputStream fos=null;
		File scr=null;
		File dst=null;
		try{
			scr =new File(scrUrl);
			dst=new File(dstUrl);
			fis=new FileInputStream(scr);
			fos=new FileOutputStream(dst);
			int nRead=0;
			byte b;		
			/*for(int i=0;i<scr.length();i++)
				fos.write((byte)fis.read());*/
			while (true) {
				nRead = fis.read(buffer,0,buffer.length);
				if (nRead <= 0)
					break;
				fos.write(buffer,0,nRead);
			}

			fis.close();
			fos.close(); 
		}catch(Exception e){

			ExceptionsFile.postException("utility.FileUtility.java","copyFile","Exception",e.getMessage());
		}finally{
			try{
				if(fis!=null)
					fis.close();
				if(fos!=null)
					fos.close();
				if(scr!=null)
					scr=null;
				if(dst!=null)
					dst=null;
			}catch(Exception e){
				ExceptionsFile.postException("utility.FileUtility.java","clsoing file objects in copyFile()","Exception",e.getMessage());
			}
		}
     }
	 synchronized public static boolean deleteDir(String dirname) {
        boolean result = false;
		File f=null;
        try {
			
            f = new File(dirname);
			if(f.exists()){
				
				if (f.isDirectory()) {
					String[] files = f.list();
					for (int i=0;i<files.length;i++) {
						deleteDir(f.getAbsolutePath() + "/" + files[i]);
						deleteFile(dirname);
					}
				}
				else {
					deleteFile(dirname);
				}
				deleteFile(dirname);
			}
            result = true;
        }
        catch (Exception ex) {
            ExceptionsFile.postException("FileUtility.java","deleteDIr","Exception",ex.getMessage());
        }
        return result;
    }

	/*void deleteFolder(File tempFile)
		synchronized public static boolean deleteDir(String dirname)
		{
			boolean result = false;
			File f=null;
			try{
              f = new File(dirname);
			  String tempFiles[]=f.list();
			 
			  for (int i=0;i<tempFiles.length;i++) {

			    	File temp=new File(tempFile+"/"+tempFiles[i]);	   
					if (temp.isDirectory())
					   deleteFolder(temp);
					else
				       temp.delete();
			     }
			  tempFile.delete();
			  return;

			} catch(Exception e) 	{
				ExceptionsFile.postException("CourseManagerFun.java","deleteFolder","Exception",e.getMessage());
				
			}
		}*/

	synchronized public static boolean deleteFile(String filename) {
        File f = new File(filename);
        boolean result = false;
        try {
			if(f.exists()){
				result = f.delete();
			}
        }
        catch (Exception ex) {
             ExceptionsFile.postException("FileUtility.java","deleteFile","Exception",ex.getMessage());
        }finally{
			try{
				if(f!=null)
					f=null;
				
			}catch(Exception e){
				ExceptionsFile.postException("FileUtility.java","Closing File Objects in deleteFile()","Exception",e.getMessage());
			}
		}
        return result;
    }

	synchronized public static boolean createDir(String filename) {
        File f = new File(filename);
        boolean result = false;
        try {
			if(!f.exists()){
				f.mkdirs();
			}
        }
        catch (Exception ex) {
             ExceptionsFile.postException("FileUtility.java","deleteFile","Exception",ex.getMessage());
        }finally{
			try{
				if(f!=null)
					f=null;
				
			}catch(Exception e){
				ExceptionsFile.postException("FileUtility.java","Closing File Objects in createDir()","Exception",e.getMessage());
			}
		}
		result=true;
        return result;
    }

	synchronized public static boolean checkFile(String path){
		boolean result=false;
		File f=null;
		try{
			f=new File(path);
			if(f.exists()&& f.isFile()){
				result=true;
			}else 
				result=false;
		}catch(Exception e){
			ExceptionsFile.postException("FileUtility.java","CheckFile","Exception",e.getMessage());
			
		}finally{
			try{
				if(f!=null)
					f=null;
				
			}catch(Exception e){
				ExceptionsFile.postException("FileUtility.java","Closing File Objects in CheckFile()","Exception",e.getMessage());
			}
		}
		return result;
	}
 
	public static boolean renameFile(String old,String newp){
		boolean result=false;
		File oldFile=null;
		File newFile=null;
		try{
			oldFile=new File(old);
			newFile=new File(newp);
			result=oldFile.renameTo(newFile);
		}catch(Exception e){
			ExceptionsFile.postException("FileUtility.java","renameFile","Exception",e.getMessage());
		}finally{
			try{
				if(oldFile!=null)
					oldFile=null;
				if(newFile!=null)
					newFile=null;
			}catch(Exception e){
				ExceptionsFile.postException("FileUtility.java","Closing File Objects in renameFile","Exception",e.getMessage());
			}
		}
		return result;
	}

}
