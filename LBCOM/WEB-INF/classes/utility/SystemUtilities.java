package utility;
import java.lang.Runtime;
import java.lang.Process;
import java.io.File;
import coursemgmt.ExceptionsFile;
public class SystemUtilities 
{
	Runtime r;
	Process p;

	public SystemUtilities(){
		r=Runtime.getRuntime();

	}
	public boolean isLinux(){
		boolean result=false;
		try{
			if((File.separator).equals("\\")){
				result=false;
			}else if ((File.separator).equals("/"))
			{
				result=true;
			}
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","isLinux()","Exception",e.getMessage());
		}
		return result;
	}
    public void setWritePermissions(String path){
		try{
		String command = "chmod 775 " + path;
		p = r.exec(command);
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","setWritePermissions()","Exception",e.getMessage());
		}
	}

	public void unsetWritePermissions(String path){
		try{
			String command = "chmod 444 " + path;
			p = r.exec(command);
			
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","unsetWritePermissions()","Exception",e.getMessage());
		}
	}
	
	public int createTarFile(String tarFileName, String src){
		int returnStatus=1;
		try{
			
			String command="tar -zcf "+tarFileName+" "+src;
			p=r.exec(command);
			returnStatus=p.waitFor();
			
			
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","CreateTarFile()","Exception",e.getMessage());
		}
		return returnStatus;
	}

	public int extractTar(String src,String dest){
		int returnStatus=1;
		try{
			String command="tar -zxf "+src+" "+dest;
			p=r.exec(command);
			returnStatus=p.waitFor();
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","extractTar()","Exception",e.getMessage());
		}
		return returnStatus;
	}
	
	public int createJarFile(String jarFileName, String src){
		int returnStatus=1;
		try{
			
			String command="jar -cf "+jarFileName+" "+src;
			p=r.exec(command);
			returnStatus=p.waitFor();
			
			
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","CreateJarFile()","Exception",e.getMessage());
		}
		return returnStatus;
	}

	public int extractJar(String src,String dest){
		int returnStatus=1;
		try{
			
			String command="jar -xf "+src+" "+dest;
			p=r.exec(command);
			returnStatus=p.waitFor();
			
		}catch(Exception e){
			
			ExceptionsFile.postException("SystemUtilities.java","extractJar()","Exception",e.getMessage());
		}
		return returnStatus;
	}

	public void destroy(){
		r=null;
		if(p!=null)
			p.destroy();

	}

}
