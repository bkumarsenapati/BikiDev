package bean;
import java.text.*;
import java.util.*;

public class WeekFormat {

    public static void main(String args[]) {

        String s;
		try{
			Format formatter;
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM/dd/yyyy");
			Date date = dateFormat.parse("22/08/2009");

			formatter = new SimpleDateFormat("E");     // Wed
			s = formatter.format(date);
			System.out.println("Day : " + s);

			formatter = new SimpleDateFormat("EEEE");  // Wednesday
			s = formatter.format(date);
			System.out.println("Day : " + s);
		}catch(Exception exp){exp.printStackTrace();}
    }
}