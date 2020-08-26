package coursemgmt;
import java.io.*;
import java.util.Calendar;
import java.util.*;
import common.*;
public class ExceptionsFile 
{
	RandomAccessFile exceptions;
	Calendar calendar;
	String date;
	/*public ExceptionsFile() {
		calendar=Calendar.getInstance();
		date=calendar.get(Calendar.YEAR)+""+calendar.get(Calendar.MONTH)+""+calendar.get(Calendar.DATE);
	}*/

	public static void postException(String fileName,String funName,String excepType,String msg) {
		RandomAccessFile exceptions=null;
		Calendar calendar=null;
		String date=null;
		String path=null;
		File temp=null;
		try{
			
			
			calendar=Calendar.getInstance();
    		date=calendar.get(Calendar.YEAR)+"_"+(calendar.get(Calendar.MONTH)+1)+"_"+calendar.get(Calendar.DATE);
			ResourceBundle rb;
			rb=I18n.getBundle();
		    path=rb.getString("Exception.path");//"/home/hsn/jakarta-tomcat-5.0.25/webapps/LBCOM/exceptions";
			temp=new File(path);
			if(!temp.exists())
				temp.mkdirs();
			
			path=path+"/"+date+".txt";
			temp=new File(path);
			temp.createNewFile();

			exceptions = new RandomAccessFile(temp,"rw");
			exceptions.seek(exceptions.length());
			
			msg="Error in  "+fileName+" at "+funName+" of type "+excepType+" : "+msg;	
			msg="\n"+calendar.get(Calendar.HOUR)+":"+calendar.get(Calendar.MINUTE)+":"+calendar.get(Calendar.MINUTE)+":      "+msg+"\n";
			exceptions.writeBytes(msg);
			exceptions.close();
		}catch (Exception e) {
			System.out.println("Error in ExceptionsFile at postExceptions() is "+e);
		}finally{
			try{
				if(exceptions!=null)
					exceptions.close();
				temp=null;
				calendar=null;
				date=null;
			}catch(Exception e){
				System.out.println("Exception in ExceptionsFile while closing the file objects() is "+e);
			}

		}
   }
	

}
