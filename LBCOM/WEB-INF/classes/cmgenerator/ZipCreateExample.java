package cmgenerator;
import java.io.*;
import java.util.zip.*;

public class ZipCreateExample{
	public static void main(String[] args) throws IOException{
		System.out.println("Example of ZIP file creation.");
		System.out.println("Please enter file name to zip : ");
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
		String filesToZip = input.readLine();
		File f = new File(filesToZip);
		if(!f.exists())
		{
			System.out.println("File not found.");
			System.exit(0);
		}
		System.out.print("Please enter zip file name with extension .zip : ");
		String zipFileName = input.readLine();
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
			System.exit(0);
		}
		catch (FileNotFoundException fnfe){
			fnfe.printStackTrace();
			System.exit(0);
		}
		catch (IOException ioe){
			ioe.printStackTrace();
			System.exit(0);
		}
	}
}