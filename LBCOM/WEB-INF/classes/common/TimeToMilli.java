package common;
import java.util.*;
import java.io.*;

public class TimeToMilli{
	
	public String millisecondsToString(long time){
		int milliseconds = (int)(time % 1000);
		int seconds = (int)((time/1000) % 60);
		int minutes = (int)((time/60000) % 60);
		int hours = (int)((time/3600000) % 24);
		String millisecondsStr = (milliseconds<10 ? "00" : (milliseconds<100 ? "0" : ""))+milliseconds;
		String secondsStr = (seconds<10 ? "0" : "")+seconds;
		String minutesStr = (minutes<10 ? "0" : "")+minutes;
		String hoursStr = (hours<10 ? "0" : "")+hours;
		return new String(hoursStr+":"+minutesStr+":"+secondsStr+"."+millisecondsStr);
	}

	public static void main(String[] args){
		long time = 200000000;
		TimeToMilli ts = new TimeToMilli();
		System.out.println(ts.millisecondsToString(time));
		}
}
