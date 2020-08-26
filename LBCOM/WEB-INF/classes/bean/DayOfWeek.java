package bean;
import java.util.*;

public class DayOfWeek{
  public static void main(String[] args){
    Calendar cal = Calendar.getInstance();
    int day = cal.get(Calendar.DAY_OF_WEEK);
    System.out.print("Today is ");
    switch(day){
      case 1: System.out.print("Sunday");
          break;
      case 2: System.out.print("Monday");
          break;
      case 3: System.out.print("Tueseday");
          break;
      case 4: System.out.print("Wednesday");
          break;
      case 5: System.out.print("Thursday");
          break;
      case 6: System.out.print("Friday");
          break;
      case 7: System.out.print("Saturday");
          break;
    }
    System.out.print(".");
  }
}