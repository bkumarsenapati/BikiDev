package DMS;
import java.util.*;
import java.util.zip.*;
import java.io.*;
public class Unzip {
	ZipOutputStream cpZOS = null;
	String src = "";
	String tgt = "";
	String str = "";	
	public boolean unzip(String fName,String zurl,String uzurl){
		Enumeration entries;
		String nPath="",fn="";
		int i;
		try {
			nPath=zurl+"/"+fName;
			if(new File(nPath).exists()){
			}
			else{
			}
			i = fName.lastIndexOf('.');
			if (i > 0 &&  i < fName.length() - 1) {
				fn = fName.substring(0,i);
			}
			i = fn.lastIndexOf('.');
			if(i > 0 &&  i < (fn.length()-1)){
				if(new File(uzurl+fn).exists())
					return false;
			}
			else
				if(new File(uzurl+fn).exists())
					return false;
			ZipFile zipFile=new ZipFile(nPath);
			entries = zipFile.entries();
			while(entries.hasMoreElements()) {
				ZipEntry entry = (ZipEntry)entries.nextElement();
				if(entry.isDirectory()) {
					(new File(uzurl+"/"+entry.getName())).mkdirs();
					continue;
				}
				((new File(uzurl+"/"+entry.getName())).getParentFile()).mkdirs();
				copyInputStream(zipFile.getInputStream(entry),
				new BufferedOutputStream(new FileOutputStream(uzurl+"/"+entry.getName())));
			}
			zipFile.close();
			return true;
		} catch(Exception e){
		System.out.println("Exception in ZipUtility.unzip() \"ZIp Format Error has occurred\"");
		return false;
		}
	}
	public void copyInputStream(InputStream in, BufferedOutputStream bos)throws Exception{
		try{
			byte[] buf = new byte[1024];
			int b;
			while((b=in.read(buf))>=0){
				bos.write(buf,0,b);
			}
			in.close();
			bos.close();
		}
		catch(FileNotFoundException ex){
			System.out.println(ex.getMessage() + " in the specified directory.");
			System.exit(0);
		}
		catch(IOException e){
			System.out.println(e.getMessage());
		}
	}
}
