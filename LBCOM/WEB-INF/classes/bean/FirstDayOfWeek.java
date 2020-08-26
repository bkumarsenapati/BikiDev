package bean;
import java.util.*;

public class FirstDayOfWeek{
  public static void main(String[] args) {
    GregorianCalendar gcal = new GregorianCalendar();
    int week = gcal.getActualMaximum(Calendar.DAY_OF_WEEK);
    System.out.println("Day of week: " + week);
    int first = gcal.getFirstDayOfWeek() ;
    switch(first){
      case 1:
        System.out.println("Sunday");
      break;
      case 2:
        System.out.println("Monday");
      case 3:
        System.out.println("Tuesday");
      case 4:
        System.out.println("Wednesday");
      case 5:
        System.out.println("Thrusday");
      case 6:
        System.out.println("Friday");
      case 7:
        System.out.println("Saturday");
    }
  }
}