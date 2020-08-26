package qeditor;
import java.sql.*;
import java.util.StringTokenizer;
public class Parser {
	public String[] initParser(String qtype,String q_body,String[] hint){
			String question[] = new String[3];
			String option[] = new String[4];
			String option1[] = new String[4];
			String edittype="",scriptvar="";
			q_body=doublequotes(q_body);
			question=getQuestion(q_body,qtype);
			edittype=edittype+question[0];
			scriptvar=scriptvar+question[1];
			if(qtype.equals("5"))
				option=getFillOption(q_body,qtype,'f');
			else if(qtype.equals("6")){
				option1=getFillOption(q_body,qtype,'l');
				option=getFillOption(q_body,qtype,'r');
				edittype=edittype+option1[0];
				scriptvar=scriptvar+option1[1];
			}
				else if(qtype.equals("7"))
					option=getFillOption(q_body,qtype,'l');
				else				
				option=getOption(q_body,qtype);
			edittype=edittype+option[0];
			scriptvar=scriptvar+option[1];
			hint=getHintPart(hint,qtype);
			edittype=edittype+hint[0];
			scriptvar=scriptvar+hint[1];
			option[0]=edittype;
			option[1]=scriptvar;
			return option;
	}
	
	public String[] getQuestion(String qbody, String qtype) {
		String[] strr=new String[2];
		String nt,qstrvar="";
		qbody=qbody.substring(qbody.indexOf("@@BeginQBody")+28,qbody.indexOf("@@EndQBody"));
		qbody=qbody.trim();
		String[] spl=qbody.split("####");
		qbody="";
		for (int x=1; x<spl.length; x++){
			nt=spl[x];
			nt=nt.trim();
			qstrvar=qstrvar+"var qparam"+x+"=\""+nt+"\";";
			qbody=qbody+"addToSpan('l_q_area_id','text','q_"+qtype+"',qparam"+x+");" ;
		}
		qstrvar=replacenline(qstrvar);
		strr[0]=qbody;
		strr[1]=qstrvar;
		return strr;		
	}
		
	public String[] getOption(String obody,String qtype) {
		String[] ostrr=new String[2];
		String nt,ostrvar="";
		obody=obody.substring(obody.indexOf("@@BeginOBody")+12,obody.indexOf("@@EndOBod"));	
		obody=obody.trim();
		String[] spl=obody.split("## ##");
		obody="";
		for (int x=1; x<spl.length; x++){
			nt=spl[x];
			nt=nt.trim();
			ostrvar=ostrvar+"var oparam"+x+"=\""+nt+"\";";
			obody=obody+"addToSpan('l_o_area_id','text','o_"+qtype+"',oparam"+x+");" ;
			
		}
		if(qtype.equals("4")){
			nt=spl[0];
			nt=nt.trim();
			ostrvar="var oparam=\""+nt+"\";";
			obody="addToSpan('l_o_area_id','text','o_"+qtype+"',oparam);" ;
		}

		ostrvar=replacenline(ostrvar);
		ostrr[0]=obody;
		ostrr[1]=ostrvar;
		return ostrr;	
		
				
	}
	public String[] getFillOption(String obody,String qtype,char qt) {
		String[] ostrr=new String[2];
		String nt,ostrvar="",temp="";
		if(qt=='f'){
			obody=obody.substring(obody.indexOf("@@BeginOBody")+12,obody.indexOf("@@EndOBod"));
			temp="l_o_area_id";
		}
		if(qt=='l'){
			obody=obody.substring(obody.indexOf("@@BeginLOBody")+12,obody.indexOf("@@EndLOBod"));
			temp="l_o1_area_id";
		}
		if(qt=='r'){
			obody=obody.substring(obody.indexOf("@@BeginROBody")+12,obody.indexOf("@@EndROBod"));
			temp="l_o2_area_id";
		}
		obody=obody.trim();
		String[] spl=obody.split(".##");
		obody="";
		for (int x=1; x<spl.length; x++){
			nt=spl[x];
			if(spl.length-1>1){
				if(x!=spl.length-1){
					nt=nt.trim();
					nt=nt.substring(0,nt.length()-4);
				}
			}
			nt=nt.trim();
			ostrvar=ostrvar+"var "+qt+"oparam"+x+"=\""+nt+"\";";
			obody=obody+"addToSpan('"+temp+"','text','o_"+qtype+"',"+qt+"oparam"+x+");" ;			
		}
		ostrvar=replacenline(ostrvar);
		ostrr[0]=obody;
		ostrr[1]=ostrvar;
		return ostrr;	
		
				
	}
	public String getAnsStr(String ansstr) {
		ansstr=ansstr.trim();
		ansstr=ansstr.substring(13,ansstr.indexOf("\n"));
		ansstr=ansstr.trim();
				return ansstr;		
	}

	public String[] getHintPart(String[] hint,String qtype) {
		String[] hstrr=new String[2];
		String hstrvar="",hstrfcall="";
		///FOR HINT
		hint[0]=doublequotes(hint[0]);
		hint[1]=doublequotes(hint[1]);
		hint[2]=doublequotes(hint[2]);


		hint[0]=hint[0].substring(hint[0].indexOf("@@BeginHBody")+12,hint[0].indexOf("@@EndHBod"));
		hint[0]=hint[0].trim();
		if(hint[0].equals("<br>"))
			hstrvar=hstrvar+"var hparam=\"\";";
		else
			hstrvar=hstrvar+"var hparam=\""+hint[0]+"\";";
		hstrfcall=hstrfcall+"addToSpan('l_h_area_id','text','h_"+qtype+"',hparam);" ;
		///FOR CORRECT
		hint[1]=hint[1].substring(hint[1].indexOf("@@BeginCBody")+12,hint[1].indexOf("@@EndCBod"));
		hint[1]=hint[1].trim();
		if(hint[1].equals("<br>"))
			hstrvar=hstrvar+"var cparam=\"\";";
		else
			hstrvar=hstrvar+"var cparam=\""+hint[1]+"\";";
		hstrfcall=hstrfcall+"addToSpan('l_c_area_id','text','h_"+qtype+"',cparam);" ;
          //FOR  INCORRECT
		hint[2]=hint[2].substring(hint[2].indexOf("@@BeginIBody")+12,hint[2].indexOf("@@EndIBod"));
		hint[2]=hint[2].trim();
		if(hint[2].equals("<br>"))
			hstrvar=hstrvar+"var iparam=\"\";";
		else
			hstrvar=hstrvar+"var iparam=\""+hint[2]+"\";";
		hstrfcall=hstrfcall+"addToSpan('l_i_area_id','text','h_"+qtype+"',iparam);" ;
		hstrvar=replacenline(hstrvar);
		hstrr[0]=hstrfcall;
		hstrr[1]=hstrvar;
		return hstrr;	
		
				
	}
	public String replacenline(String str)
	{
		String[] spl=str.split("\n");
		str=spl[0].trim();
		for (int x=1; x<spl.length; x++){
			str=str+"\\n"+spl[x].trim();
		}
		return(str);
	}
	public String doublequotes(String str)
	{
		str=str.replaceAll("\"","&quot;");
		return(str);
	}
}
	
	
	
	
	

