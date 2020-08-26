package DMS;
import java.io.*;
import java.util.*;
public class  FindFolder
{
	private boolean flag=false;
	private File f_name;
	private File al[];
	public File[] folder(File f)
	{
		int j=0;
		f_name=f;
		try{
			File lFile[]=f_name.listFiles();
			
					for(int i=0;i<lFile.length; i++)
			{
				File fld=lFile[i];
				if(fld.isDirectory())
				{
					j++;
				}
			}
		
					al=new File[j];
					int k=0;

			for(int i=0;i<lFile.length; i++)
			{
				File fld1=lFile[i];
				if(fld1.isDirectory())
				{
					al[k++]=fld1;
				}
			}

		  }
		catch(Exception exp)
			{
				exp.printStackTrace();
			}
		return al;
	}
}
