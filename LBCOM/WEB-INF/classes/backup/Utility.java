package backup;
import java.io.*;
import java.sql.*;
import java.util.*;
import coursemgmt.ExceptionsFile;
import utility.SystemUtilities;
import utility.FileUtility;

public class  Utility 
{
	Connection con;
	String backupPath;
	String schoolsPath;
	String dateTime;
	SystemUtilities gp;
	FileUtility fu;
	public Utility(String spath,String bpath){
		this.schoolsPath=spath;
		this.backupPath=bpath;
		gp=new SystemUtilities();
		fu=new FileUtility();
		
	}
	public void setConnection(Connection c){
		this.con=c;
	}
	public Connection getConnection(){
		return this.con;
	}
	public String getCourseIds(Statement st,ResultSet rs,String users,String schoolid,String tablename){
		String courses="";
		try{
			if(tablename.equals("coursewareinfo")){
			   rs=st.executeQuery("select course_id from "+tablename+" where school_id='"+schoolid+"' and teacher_id in ("+users+")");
			}else{
				rs=st.executeQuery("select course_id from "+tablename+" where school_id='"+schoolid+"' and student_id in ("+users+")");
			}
			if(rs.next()){
				courses="'"+rs.getString("course_id")+"'";
				while(rs.next()){
					courses=courses+",'"+rs.getString("course_id")+"'";
				
				}
			}else
				courses="''";
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","getCourseIds()","Exception",e.getMessage());
		}
		return courses;
	}

	public String getClassIds(Statement st,ResultSet rs,String schoolid,String courses){
		String classes="";
		try{
			
			rs=st.executeQuery("select distinct(class_id) from coursewareinfo where school_id='"+schoolid+"' and course_id in ("+courses+")");
			if(rs.next()){
				classes="'"+rs.getString("class_id")+"'";
				while(rs.next()){
					classes=classes+",'"+rs.getString("class_id")+"'";
				
				}
			}else
				classes="''";
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","getClassIds()","Exception",e.getMessage());
		}
	
		return classes;
	}
	
	public String getWorkIds(Statement st,ResultSet rs,String schoolid,String courses,String tableName){
		String workIds="";
		String fieldName="";
		try{
			if(tableName.equals("exam_tbl")){
				fieldName="exam_id";
			}else if(tableName.equals("course_docs")){
				fieldName="work_id";
			}

			rs=st.executeQuery("select distinct("+fieldName+") from "+tableName+" where school_id='"+schoolid+"' and course_id in ("+courses+")");
			if(rs.next()){
				workIds="'"+rs.getString(fieldName)+"'";
				while(rs.next()){
					workIds=workIds+",'"+rs.getString(fieldName)+"'";
				
				}
			}else
				workIds="''";
		}catch(Exception e){
			ExceptionsFile.postException("backup.Utility.java","getWorkIds()","Exception",e.getMessage());

		}
		return workIds;
	}
	
	public boolean foldersBackup(String name){
		File f= new File(schoolsPath+"/"+name);
		copyFolder(f,name,backupPath+"/backups/"+name+"_"+getDateTime()+"/"+name);
		return(true);

	}
	
	public boolean createFolder(String name){
		try{
			File f=new File(backupPath+"/backups/"+name+"_"+getDateTime());
			if(f.exists()){
				deleteFolder(f);
			}
			f.mkdirs();
			if(gp.isLinux())
				gp.setWritePermissions(backupPath+"/backups/"+name+"_"+getDateTime());
			
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","createFolder()","Exception",e.getMessage());
		}
		return true;
	}
	public void deleteFolder(File tempFile)
	{
			try{
               
			  String tempFiles[]=tempFile.list();
			  boolean s;
			  for (int i=0;i<tempFiles.length;i++) {
			    	File temp=new File(tempFile+"/"+tempFiles[i]);	   
					if (temp.isDirectory()){
					   deleteFolder(temp);
					}else{
				       s=temp.delete();
					}
			     }
			  tempFile.delete();
			  return;

			} catch(Exception e) 	{

				ExceptionsFile.postException("backup.Utility.java","deleteFolder","Exception",e.getMessage());
				
			}
	}
    public void copyFolder(File tempFile,String school,String dstn)
	{
			try{
               
			   if(!tempFile.exists()){
				   
				   return;
			   }
			  String tempFiles[]=tempFile.list();
			  String par,dir,dst,scr;
			  File f,temp;
			  f=temp=null;
			  for (int i=0;i<tempFiles.length;i++) {
				    if(temp!=null)
						temp=null;
					par=dir=dst=scr="";
					temp=new File(tempFile+"/"+tempFiles[i]);	   
					if (temp.isDirectory()){
					   f=new File(dstn+"/"+tempFiles[i]);
					   if(!f.exists()){
						   f.mkdirs();
					   }
					   f=null;
					   copyFolder(temp,school,dstn+"/"+tempFiles[i]);
					}else{
				      	f=new File(dstn);
						if(!f.exists()){
							f.mkdirs();
					    }
						f=null;
						dst=dstn;
						scr=temp.getParent()+"/"+tempFiles[i];
						dst=dst+"/"+tempFiles[i];
						copyFile(scr,dst);
					}
			     }
			  return;

			} catch(Exception e) 	{

				ExceptionsFile.postException("backup.Utility.java","copyFolder","Exception",e.getMessage());
			}
	}

	public String getDate(){
		String date="";
		String month="";
		String day="";
		String year="";
		try{
			Calendar c=Calendar.getInstance();
			year=""+c.get(Calendar.YEAR);
			month=""+(c.get(Calendar.MONTH)+1);
			day=""+c.get(Calendar.DATE);
			if(month.length()<2)
				month="0"+month;
			if(day.length()<2)
				day="0"+day;
			date=year+"_"+month+"_"+day;
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","getDate","Exception",e.getMessage());
		}
		return date;

	}
	public String calcDateTime(){
		String dateTime="";
		try{
			Calendar c=Calendar.getInstance();
			String month="";
			String day="";
			String year="";	
			year=""+c.get(Calendar.YEAR);
			month=""+(c.get(Calendar.MONTH)+1);
			day=""+c.get(Calendar.DATE);
			if(month.length()<2)
				month="0"+month;
			if(day.length()<2)
				day="0"+day;
			String hr="";
			String min=""+c.get(Calendar.MINUTE);
			String sec=""+c.get(Calendar.SECOND);
			if(c.get(Calendar.AM_PM)==1)
				hr=""+(c.get(Calendar.HOUR)+12);
			else
				hr=""+c.get(Calendar.HOUR);

			if(hr.length()<2)
				hr="0"+hr;
			if(min.length()<2)
				min="0"+min;
			if(sec.length()<2)
				sec="0"+sec;

			dateTime=year+"_"+month+"_"+day+"_"+hr+"_"+min+"_"+sec;

		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","calcDateTime()","Exception",e.getMessage());
		}
		return dateTime;
	}
	public void setDateTime(String t){
		dateTime=t;
	}
	public String getDateTime(){
		return dateTime;
	}

	public String formatList(String list){
		String formatedList="";
		
		try{
			String item="";
			StringTokenizer stk=new StringTokenizer(list,",");
			if(stk.hasMoreTokens()){
				item=stk.nextToken();
				item=item.substring(1,item.length()-1);
				formatedList=item;
				while(stk.hasMoreTokens()){
					item=stk.nextToken();
					item=item.substring(1,item.length()-1);
					formatedList+=","+item;
				}
			}else{
				formatedList="";
			}
		}catch(Exception e){
			ExceptionsFile.postException("backup.Utility.java","formatList","Exception",e.getMessage());

		}
		return(formatedList);
	}
	public String unformatList(String list){
		String unformatedList="";
		
		try{
			String item="";
			StringTokenizer stk=new StringTokenizer(list,",");
			if(stk.hasMoreTokens()){
				unformatedList="'"+stk.nextToken()+"'";
				while(stk.hasMoreTokens()){
					unformatedList+=",'"+stk.nextToken()+"'";
				}
			}else{
				unformatedList="''";
			}
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","unformatList","Exception",e.getMessage());
		}
		return(unformatedList);
	}
	public void copyFile(String scrUrl,String dstUrl){
		byte buffer []=new byte[100*1024];
		try{
			File scr =new File(scrUrl);
			File dst=new File(dstUrl);
			FileInputStream fis=new FileInputStream(scr);
			FileOutputStream fos=new FileOutputStream(dst);
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

			ExceptionsFile.postException("backup.Utility.java","copyFile","Exception",e.getMessage());
		}
   }
   public String getUserIds(Statement st,ResultSet rs,String schoolid,String tableName){
		String userIds="";
		try{
			rs=st.executeQuery("select username from "+tableName+" where schoolid='"+schoolid+"'");
			if(rs.next()){
			    userIds="'"+rs.getString("username")+"'";
				while(rs.next()){
				     userIds=userIds+",'"+rs.getString("username")+"'";
				}
			}else{
				userIds="''";
			}
		}catch(Exception e){

			ExceptionsFile.postException("backup.Utility.java","getuserIds","Exception",e.getMessage());
		}
		return userIds;
	}
	
	public boolean createJar(String jarname,String src){

		int result=gp.createJarFile(jarname,src);
		boolean status=false;
		if(result==0){
			status=fu.deleteDir(src);
			
		}
		return status;
	}
	
	public boolean extractJar(String src,String dest){
		int result=gp.extractJar(src,dest);
		if(result==0)
			return true;
		else 
			return false;
	}
	public boolean delete(String src){
		return fu.deleteDir(src);

	}
	public boolean isLinux(){
		boolean result=false;
		result=gp.isLinux();

		return result;
	}
	public void destroy(){
		if(gp!=null)
			gp.destroy();

	}
}