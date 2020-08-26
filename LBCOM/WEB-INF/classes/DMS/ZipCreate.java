package DMS;
import java.io.*;
import java.util.zip.*;

public class ZipCreate{
  public void createZip(String sourceFile,String destZip){

//    BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
    String filesToZip =sourceFile;// input.readLine();
    File f = new File(filesToZip);
    if(!f.exists())
    {
      System.out.println("File not found.");
//      System.exit(0);
    }
  //  System.out.print("Please enter zip file namewith extension .zip : ");
    String zipFileName =destZip;// input.readLine();
    byte[] buffer = new byte[18024];
    try{
      ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
      out.setLevel(Deflater.DEFAULT_COMPRESSION);
      FileInputStream in = new FileInputStream(filesToZip);
      out.putNextEntry(new ZipEntry(filesToZip));
      int len;
      while ((len = in.read(buffer)) > 0){
        out.write(buffer, 0, len);
      }
      out.closeEntry();
      in.close();
      out.close();
    }
    catch (IllegalArgumentException iae){
      iae.printStackTrace();
      
    }
    catch (FileNotFoundException fnfe){
      fnfe.printStackTrace();
      
    }
    catch (IOException ioe){
      ioe.printStackTrace();
      
    }
  }
}