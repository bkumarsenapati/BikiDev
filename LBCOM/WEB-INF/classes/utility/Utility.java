package utility;

import java.io.*;
import java.lang.*;
import coursemgmt.ExceptionsFile;

public class Utility
{
	String id;
	String schoolId,schoolPath;
	public Utility()
	{
		id="";
	}
	public Utility(String schoolid,String sPath) 
    {
		id="";
		schoolId=schoolid;
		this.schoolPath=sPath;
		//String path="C:/Tomcat 5.0/webapps/LBCOM/schools/"+schoolId;
		String path=schoolPath+"/"+schoolId;
		File dir=new File(path);
		if(!dir.exists()) {

			dir.mkdirs();
		}

	}
	
	//This function is used to set a new type of Id as user wishes
	synchronized public void setNewId(String type,String format) throws IOException
	{
		int flag = 0,i,j,k;
		String insertString = type + "=" + format + "\n";//constructs the required format
		String searchString;
		try
		{
			RandomAccessFile file = new RandomAccessFile(schoolPath+"/"+schoolId+"/GenIds.txt","rw");//Opens the file in read/write mode
			//RandomAccessFile file = new RandomAccessFile("C:/Tomcat 5.0/webapps/LBCOM/exam/GenIds.txt","rw");//Opens the file in read/write mode

			file.seek(0);//moves to beginning of the file
			for(i=0,j=0;i<file.length();i++)//used to count the number of lines in the file into j
				if((char)file.readByte()=='\n')
					j++;

			file.seek(0);//moves to beginning of the file
			for(k=1;k<=j;k++)//reading data line by line
			{
				searchString = file.readLine();
				if(searchString.indexOf(type)>=0)//if the read line matches the required type
				{
					flag = 1;
					break;
				}
			}
			
			if(flag==0)
			{
				file.seek(file.length());//moves to end of file
				file.writeBytes(insertString);//appends the new type at end of file line by line
			}
			file.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("Utility.java","setNewId","Exception",e.getMessage());
			
		}
	}
		
	synchronized public String getId(String type) throws IOException
	{
		String searchString,numberString,format,genId="",onlyChars="";
		int i,j,k,formLen,idNo,numLen;
		try
		{
			RandomAccessFile file = new RandomAccessFile(schoolPath+"/"+schoolId+"/GenIds.txt","rw");//Opens the file in read/write mode
			//RandomAccessFile file = new RandomAccessFile("C:/Tomcat 5.0/webapps/LBCOM/"+schoolId+"/GenIds.txt","rw");//Opens the file in read/write mode
			
			file.seek(0);//moves to beginning of the file
			for(i=0,j=0;i<file.length();i++)//used to count the number of lines in the file into j
				if((char)file.readByte()=='\n')
					j++;
			
			file.seek(0);//moves to beginning of the file
			for(k=1;k<=j;k++)//reading data line by line
			{
				searchString = file.readLine();
				if(searchString.indexOf(type)>=0)//if the read line matches the required type
				{
					format = searchString.substring(searchString.indexOf('=')+1);//gives the format string in which id is to be generated
					formLen = format.length();
					for(i=0;i<format.length()-1;i++)//to find out where from the numbers start in the format
					{
						if(format.charAt(i)>=48 && format.charAt(i)<=57)
						{
							break;
						}
						onlyChars+=format.charAt(i);//finding the characters in format string
					}
					numberString = format.substring(i,format.length());//extracting numbers
					idNo = Integer.parseInt(numberString);//converting that to integer
					numLen = format.length() - onlyChars.length();//finding the length of only numbers
					String samp = searchString.substring(0,searchString.indexOf('=')+1) + onlyChars ;
					genId = writeFile(file,k-1,samp,idNo,numLen);	
					genId = genId.substring(genId.indexOf('=')+1);
				}
			}
			file.close();
		}
		catch(Exception eset)
		{
			ExceptionsFile.postException("Utility.java","getNewId","Exception",eset.getMessage());
			
		}
		return genId;		
	}

	public String writeFile(RandomAccessFile file,int pos,String type,int idNo,int numLen) throws IOException
	{
		String temp="";
		int d=1,k;
		try
		{
			idNo++;
			k=idNo;
			while(k>0)//to find number of digits for the newId
			{
				d++;
				k/=10;
			}
			d--;
			switch(numLen)
			{
				case 9:
						switch(d)
						{
							case 1: id = type + "00000000" + idNo;
									break;
							case 2: id = type + "0000000" + idNo;
									break;
							case 3: id = type + "000000" + idNo;
									break;
							case 4: id = type + "00000" + idNo;
									break;
							case 5: id = type + "0000" + idNo;
									break;
							case 6: id = type + "000" + idNo;
									break;
							case 7: id = type + "00" + idNo;
									break;
							case 8: id = type + "0" + idNo;
									break;
							case 9: id = type + idNo;
									break;
						}
						break;
				case 8:
						switch(d)
						{
							case 1: id = type + "0000000" + idNo;
									break;
							case 2: id = type + "000000" + idNo;
									break;
							case 3: id = type + "00000" + idNo;
									break;
							case 4: id = type + "0000" + idNo;
									break;
							case 5: id = type + "000" + idNo;
									break;
							case 6: id = type + "00" + idNo;
									break;
							case 7: id = type + "0" + idNo;
									break;
							case 8: id = type + idNo;
									break;
						}
						break;
				case 7:
						switch(d)
						{
							case 1: id = type + "000000" + idNo;
									break;
							case 2: id = type + "00000" + idNo;
									break;
							case 3: id = type + "0000" + idNo;
									break;
							case 4: id = type + "000" + idNo;
									break;
							case 5: id = type + "00" + idNo;
									break;
							case 6: id = type + "0" + idNo;
									break;
							case 7: id = type + idNo;
									break;
						}
						break;
				case 6:
						switch(d)
						{
							case 1: id = type + "00000" + idNo;
									break;
							case 2: id = type + "0000" + idNo;
									break;
							case 3: id = type + "000" + idNo;
									break;
							case 4: id = type + "00" + idNo;
									break;
							case 5: id = type + "0" + idNo;
									break;
							case 6: id = type + idNo;
									break;
						}
						break;
				case 5:
						switch(d)
						{
							case 1: id = type + "0000" + idNo;
									break;
							case 2: id = type + "000" + idNo;
									break;
							case 3: id = type + "00" + idNo;
									break;
							case 4: id = type + "0" + idNo;
									break;
							case 5: id = type + idNo;
									break;
						}
						break;
				case 4:
						switch(d)
						{
							case 1: id = type + "000" + idNo;
									break;
							case 2: id = type + "00" + idNo;
									break;
							case 3: id = type + "0" + idNo;
									break;
							case 4: id = type + idNo;
									break;
						}
						break;
				case 3:
						switch(d)
						{
							case 1: id = type + "00" + idNo;
									break;
							case 2: id = type + "0" + idNo;
									break;
							case 3: id = type + idNo;
									break;
						}
						break;
				case 2:
						switch(d)
						{
							case 1: id = type + "0" + idNo;
									break;
							case 2: id = type + idNo;
									break;
						}
						break;
				case 1:
						id = type + idNo;
						break;

			}
			file.seek(0);
			for(int i=0;i<pos;i++)
				temp = file.readLine();
			file.writeBytes(id);
			
		}
		catch(Exception E)
		{
			ExceptionsFile.postException("Utility.java","writeFile","Exception",E.getMessage());
			
		}
		return id;
	}

	public static void main(String[] args) throws IOException
	{
		String examId="";
		Utility u1 = new Utility();
		if(args.length>1)
		{
			u1.setNewId(args[0],args[1]);
			examId = u1.getId(args[0]);
		}
		else
			examId = u1.getId(args[0]);
		
	}
}
