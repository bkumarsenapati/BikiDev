package common;
import java.util.*;
import java.text.*;
public class DateToTimestamp {
   public static void main(String[] args)throws Exception
	   
   {
		String str_date="23-April-11";
	 long yourmilliseconds = 020202;
SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss");
 
Date resultdate1 = new Date(yourmilliseconds);

System.out.println(sdf1.format(resultdate1));  

SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
 
Date resultdate2 = new Date(str_date);

System.out.println(sdf.format(resultdate2));  

} 
}       