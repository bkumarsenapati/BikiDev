package common;
public class CommonBean{	
	public String doublequotes(String str){   //replace " to &quotes
			str=str.replaceAll("\"","&quot;");
			return(str);
	}	
	public String replacenline(String str)    // replace all the \n chars as it will give errors if we convert string as javascript variable
	{
		String[] spl=str.split("\n");
		str=spl[0].trim();
		for (int x=1; x<spl.length; x++){
			str=str+"\\n"+spl[x].trim();
		}
		return(str);
	}
	public String replacenlineReqStr(String str,String rep)   // replace line with req string(</br>
	{
		String[] spl=str.split("\n");
		str=spl[0].trim();
		for (int x=1; x<spl.length; x++){
			str=str+rep+spl[x].trim();
		}
		return(str);
	}
	public String javastr2javascriptstr(String str)   // replace javastring to javascript string s
	{
		str=replacenlineReqStr(str,"</br>");
		str=doublequotes(str);		
		return(str);
	}
	public String convertDate(String given){		//Converting m/d/yy to yyyy-mm-dd
		String k[]=given.split("/");
		int year=Integer.parseInt(k[2]);
		if(year<50)
			year=year+2000;
		else if(year<100&&year>50)
			year=year+1900;    
		return year+"-"+k[0]+"-"+k[1];

	}
	public String convertoDisplayDate(String given){		//Converting m/d/yy to yyyy-mm-dd
		String k[]=given.split("-");
		return k[1]+"/"+k[2]+"/"+k[0];

	}
}