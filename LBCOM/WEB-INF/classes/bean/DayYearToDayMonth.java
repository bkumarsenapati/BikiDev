package bean;
import java.util.*;
 
public class DayYearToDayMonth 
{
    public static void main(String[] args)
    {     
        /*Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, 2007);
        calendar.set(Calendar.DAY_OF_YEAR, 181);
        System.out.println("\nThe date of Calendar is: " +
 calendar.getTime());
        int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);  
        System.out.println("The day of month: " +
 dayOfMonth);  
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
    System.out.println("The day of week: " + 
dayOfWeek);
*/

//int date=0;
			String date="2009-08-31";
			Calendar calCurr = GregorianCalendar.getInstance();
			int year=Integer.parseInt(date.substring(0,date.indexOf("-")));
			int mm=Integer.parseInt(date.substring(date.indexOf("-")+1,date.lastIndexOf("-")));
				System.out.println("Year :"+year);
			System.out.println("month :"+mm);
			calCurr.set(year, (mm-1), 1); // Months are 0 to 11
			System.out.println("Test :"+calCurr.getActualMaximum(GregorianCalendar.DAY_OF_MONTH));
			
    }
}