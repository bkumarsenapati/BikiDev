package DMS;
import java.io.*;
import java.util.*;
public class  FindFiles
{
	ArrayList files_list;
	
	public FindFiles()
	{
		files_list=new ArrayList();
	}
	 public void copyFiles(File sourceDir)
                throws IOException{

  File[] children = sourceDir.listFiles();

      /*for(File sourceChild : children){
 
     String name = sourceChild.getPath();
	 */
	 for(int i=0; i< children.length; i++){
	File sourceChild =children[i];
     String name = sourceChild.getPath();
 
      //File destChild = new File(destDir, name);

        if(sourceChild.isDirectory()){
		if((!(sourceChild.getName().equals("DMS_image"))))
			{
				copyFiles(sourceChild);
			}
 
      }
     
 else{
  
      //copyFile(sourceChild, destChild);
	  files_list.add(sourceChild);
 
     }
	  }
   
 }
 public ArrayList listOfFiles()
	{
	 return files_list;
	}
 
}
