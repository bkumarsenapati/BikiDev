package cmgenerator;
import java.io.*;

  public class CopyDirectory{
 
 public static void main(String[] args) throws IOException{
 
   CopyDirectory cd = new CopyDirectory();
   String source = "";

    File src = new File(source);
  
    System.out.println("Enter the destination directory or file name : ");
    String destination="";
  
      File dst = new File(destination); 

    cd.copyDirectory(src, dst);

  }
  

  public void copyDirectory(File srcPath, File dstPath)
                               throws IOException{
  
  if (srcPath.isDirectory()){

      if (!dstPath.exists()){

        dstPath.mkdir();
 
     }

 
     String files[] = srcPath.list();
  
    for(int i = 0; i < files.length; i++){
        copyDirectory(new File(srcPath, files[i]),new File(dstPath, files[i]));
  
      }

    }
 
   else{
  
      if(!srcPath.exists()){

        System.out.println("File or directory does not exist.");
 
       System.exit(0);

      }
      
else
  
      {
 
       InputStream in = new FileInputStream(srcPath);
       OutputStream out = new FileOutputStream(dstPath); 
                     // Transfer bytes from in to out
            byte[] buf = new byte[1024];
 
              int len;
 
           while ((len = in.read(buf)) > 0) {
  
          out.write(buf, 0, len);

        }
 
       in.close();
 
           out.close();

      }
 
   }
   
 System.out.println("Directory copied.");
 
 }

}
