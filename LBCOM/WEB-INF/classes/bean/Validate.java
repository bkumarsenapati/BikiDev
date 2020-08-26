package bean;
import java.util.*;
import java.io.*;
public class Validate
{
	public String checkEmpty(String str)
		{
			if(str == null || str.equals("")){
				str = "null";
			}
			return str;

		}
		public String checkEmpty1(String str)
		{
			if(str == null || str.equals("")){
				str = "";
			}
			return str;

		}
	public String changeDate(String dateStr)
		{				
			String ret_date = "0000-00-00";
			try{
				if(dateStr!=null && dateStr!=""){
					
					java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM/dd/yyyy");
					java.util.Date date = dateFormat.parse(dateStr);
					java.text.Format frmt=new java.text.SimpleDateFormat("yyyy-MM-dd");

					String dt=frmt.format(date);
					ret_date = java.sql.Date.valueOf(dt)+"";
				}
			}catch(Exception e){
				System.out.println("Exception from validate.java: "+e);
			}

			return ret_date;
		}
		public String dayName(String dateStr)
		{
			
			String s="null";
			try{
			java.text.Format formatter;
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			Date date = dateFormat.parse(dateStr);

			formatter = new java.text.SimpleDateFormat("E");     // Wed
			s = formatter.format(date);
			

			formatter = new java.text.SimpleDateFormat("EEEE");  // Wednesday
			s = formatter.format(date);
			
			
			}catch(Exception exp)
			{
				exp.printStackTrace();
			}
			return s;

		}
		public int getNoOfDays(String dt)
		{
			//int date=0;
			String date=dt;
			Calendar calCurr = GregorianCalendar.getInstance();
			int year=Integer.parseInt(date.substring(0,date.indexOf("-")));
			int mm=Integer.parseInt(date.substring(date.indexOf("-")+1,date.lastIndexOf("-")));
			
			calCurr.set(year, (mm-1), 1); // Months are 0 to 11
			return (calCurr.getActualMaximum(GregorianCalendar.DAY_OF_MONTH));

		}
		
}
