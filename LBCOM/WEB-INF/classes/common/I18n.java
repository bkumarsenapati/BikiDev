package common;
import java.util.*;
public class I18n{
	static String language="en";
	static String country="US";
	static Locale currentLocale;
	static ResourceBundle messages;

	public I18n(String lang,String country){
		language = new String("en");
		country = new String("US");
	}

	public I18n(){
	}

	public static ResourceBundle getBundle(){
		currentLocale = new Locale(language, country);
		messages = ResourceBundle.getBundle("Resources/ApplicationResources", currentLocale);
		return messages;
	}
	
}
