package DMS;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.util.zip.*;
import java.sql.*;
import sqlbean.DbBean;
/* 
*/
public class CopyFiles {	

	//public Common com=new Common();	
	String title="", sep = File.separator;  // slash or backslash;
	    private DbBean bean;
	private Connection con=null,con1=null;
	private Statement st=null,st1=null;
	
	public void copyDirectory(String srcDir, String dstDir)
	{
		
		bean=new DbBean();
        try{
			
		con=bean.getConnection();
		st=con.createStatement();
			File fdstDir = new File(dstDir); 
			if (! fdstDir.exists()) {
				fdstDir.mkdirs();  
			}
 
			String[ ] fileList = new File(srcDir).list(); 
			boolean dir;
 
			for (int i = 0; i < fileList.length ; i++) {
				dir = new File(srcDir+sep+fileList[ i ]).isDirectory();
				if (dir) {
					//st.addBatch("insert into files (name,path,curdate(),'folder') values ('"+fileList[ i ]+"','"+(dstDir+"\\"+fileList[ i ]).replace('\\','/')+"')");
				    copyDirectory (srcDir+"/"+fileList[ i ], dstDir+"/"+fileList[ i ]);
			  } else {
				  	  //st.addBatch("insert into files (name,path,dt,type) values ('"+fileList[ i ]+"','"+(dstDir+"\\"+fileList[ i ]).replace('\\','/')+"',curdate(),'"+fileList[ i ].substring(fileList[ i ].lastIndexOf(".")+1)+"')");
					copyFile(srcDir+sep+fileList[ i ], dstDir+"/"+fileList[ i ]);
				}
			}
			//int x[]=st.executeBatch();
			
		}catch(Exception e) {
			//com.createLogFile("FROM CopyFiles.java copyDirectory(): "+e);
			e.printStackTrace();
		}
		finally{
		
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}
    }

	public void copyFile(String srcFile, String dstFile) throws IOException 
	{bean=new DbBean();
		try{
			/*con=bean.getConnection();
			st1=con.createStatement();
			st1.executeUpdate("insert into files (name,path,dt,type) values ('"+dstFile.substring(dstFile.lastIndexOf("\\")+1)+"','"+dstFile.replace('\\','/')+"',curdate(),'"+dstFile.substring(dstFile.lastIndexOf(".")+1)+"')");
			*/
			FileInputStream inp = new FileInputStream(srcFile) ;
			FileOutputStream out = new FileOutputStream(dstFile) ;
		 
			byte[] buff = new byte[8192];
			int count;
		// read up to buff.length bytes
			while ((count = inp.read(buff)) != -1) {
				out.write(buff, 0, count);
			} 
			out.close( ) ;
			inp.close( ) ;
		}catch(Exception e){
			//com.createLogFile("FROM CopyFiles.java copyFile(): "+e);
			e.printStackTrace();
		}/*finally{
		
		try{
			if(st1!=null)
				st1.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}*/
	 
	}
	public void copyFile1(String srcFile, String dstFile) throws IOException 
	{bean=new DbBean();
		try{
			con1=bean.getConnection();
			st1=con1.createStatement();
			st1.executeUpdate("insert into files (name,path,dt,type) values ('"+dstFile.substring(dstFile.lastIndexOf("\\")+1)+"','"+dstFile.replace('\\','/')+"',curdate(),'"+dstFile.substring(dstFile.lastIndexOf(".")+1)+"')");
		
			FileInputStream inp = new FileInputStream(srcFile) ;
			FileOutputStream out = new FileOutputStream(dstFile) ;
		 
			byte[] buff = new byte[8192];
			int count;
		// read up to buff.length bytes
			while ((count = inp.read(buff)) != -1) {
				out.write(buff, 0, count);
			} 
			out.close( ) ;
			inp.close( ) ;
		}catch(Exception e){
			//com.createLogFile("FROM CopyFiles.java copyFile(): "+e);
			e.printStackTrace();
		}finally{
		
		try{
			if(st1!=null)
				st1.close();
			if(con1!=null)
				con1.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}
	 
	}

	public void zipFolder(String srcFolder, String destZipFile) throws Exception 
	{
		try{
			
			ZipOutputStream zip = null;
			FileOutputStream fileWriter = null;

			fileWriter = new FileOutputStream(destZipFile);
			zip = new ZipOutputStream(fileWriter);

			addFolderToZip("", srcFolder, zip);
			zip.flush();
			zip.close();
			fileWriter.close();
			}catch(Exception e){
				//com.createLogFile("FROM CopyFiles.java zipFolder(): "+e);
				e.printStackTrace();
			}
    }

    public void addFileToZip(String path, String srcFile, ZipOutputStream zip)
    {
	  try{
			File folder = new File(srcFile);
			if (folder.isDirectory()) {
			  addFolderToZip(path, srcFile, zip);
			} 
			else {
			  byte[] buf = new byte[1024];
			  int len;
			  FileInputStream in = new FileInputStream(srcFile);
			  zip.putNextEntry(new ZipEntry(path + "/" + folder.getName()));
			  while ((len = in.read(buf)) > 0) {
				zip.write(buf, 0, len);
				in.close();
			  }
			}
	  }catch(Exception e){
		  //com.createLogFile("FROM CopyFiles.java addFileToZip(): "+e);
		  e.printStackTrace();
	   }
    }

	public void addFolderToZip(String path, String srcFolder, ZipOutputStream zip)
    { 
		try{
			File folder = new File(srcFolder);
			/*for (String fileName : folder.list()) {
				*/
				String s[]=folder.list();
			for (int i=0;i< s.length; i++) {
				String fileName =s[i];
			    if (path.equals("")) {
					addFileToZip(folder.getName(), srcFolder + "/" + fileName, zip);
				  } else {
					addFileToZip(path + "/" + folder.getName(), srcFolder + "/" + fileName, zip);
					}
			}
		}catch(Exception e){
			 //com.createLogFile("FROM CopyFiles.java addFolderToZip(): "+e);
			 e.printStackTrace();
		}
    }

}