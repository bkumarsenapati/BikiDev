package exam;
import java.util.*;
import java.sql.*;
import java.io.*;
import coursemgmt.ExceptionsFile;
//import javax.servlet.*;
//import javax.servlet.http.*;





public class QuestionFormat{

	QuestionBody qtnBody;
	String courseId,schoolId,classId,qtnTbl,exmInsTbl,examId,studentId,teacherId;
	String duration,instr,examName;
	int nQtns,durHrs,durMns;
	PrintWriter out;

	public QuestionFormat(){}

	// Constructing Question body format

	//public static String getFormattedQBdy(ArrayList qStr,String qId,String qNo,int qType,boolean isST,String hint,int wt,int nm,String diffLevel,String time){
	public static String getFormattedQBdy(ArrayList qStr,String qId,String qNo,int qType,boolean isST,String hint,float wt,float nm){

		int j;
		String qtn;
		String fQtn;

		char caseStr;
		int idx;
		boolean flag;

		fQtn="";
		flag=true;

		for(j=0;j<qStr.size();j++){

			qtn=qStr.get(j).toString().trim();

			caseStr=qtn.charAt(0);			

			switch (caseStr)
			{
				case '#':
				
                   if(qtn.indexOf("####")!=-1){
	                   	if(flag==true){
							if (fQtn.equals(""))	{
								fQtn=qtn.substring(4).trim();						
							}else{
								fQtn=fQtn+"<br>"+qtn.substring(4).trim();						
							}
						}
						else	
							fQtn=fQtn+getQnFString(qtn.substring(4).trim(),flag,qId,qNo,qType);						
	               } else { 	
						fQtn=getQnFString(fQtn,flag,qId,qNo,qType)+"</td></tr>";
						idx=qtn.indexOf("##",2);
						fQtn=fQtn+getQnEFString(qtn.substring(2,idx),qtn.substring( idx+2 ));
						flag=false;
				   }
                                        break;
				default:
					fQtn=fQtn+"<br>"+qtn;			
			}	
			
		}	

		if (flag==true){		
			fQtn=getQnFString(fQtn,flag,qId,qNo,qType);
		}
		if (isST==true)
		{
			fQtn=fQtn+"</td><td width='90' valign='top'><a href='#' onclick=\"popUpWindow('"+getHint(hint)+"','hint.jpg','Hint');return false;\"><img src='/LBCOM/images/hinticon.jpg' width='19' height='19'></a>&nbsp;<a href='#' onclick=\"parent.btm_f.document.bpanel.issingle.value='true';parent.btm_f.go(true,'"+qId+"','"+qNo+"',false);\"><img src='/LBCOM/images/answericon.jpg' width='12' height='20'></a> </td></tr>";

		}else{		
			
			fQtn=fQtn+"</td><td width='90' valign='top'><font face='Arial' size='2' color='#800000'> Points = "+wt;
			/*********** Below is the code for printing diffcult level and estimated time in the exam paper******************
			
			fQtn=fQtn+"</td><td width='68' valign='top'><font face='Arial' size='2' color='#800000'> Points = "+wt+"\n";
			fQtn=fQtn+"</font></td><td width='41' valign='top'><font face='Arial' size='2' color='#800000'> "+time+"\n";
			fQtn=fQtn+"</font></td><td width='30' valign='top'><font face='Arial' size='2' color='#800000'> "+diffLevel+"\n";
			*/
			if(nm!=0)
				fQtn=fQtn+"&nbsp; Penalty = -"+nm;
			
			fQtn=fQtn+"</font>";

			fQtn=fQtn+"</td></tr>";
		}
		
		return fQtn;

	}

	private static String getQnFString(String qStr,boolean subQ,String qId,String qNo,int qType){
		String str;
	
		if (subQ==true)
		{		
			//str="<table border='0' width='100%' height='61' cellspacing='1' cellpadding='0' bordercolorlight='#BEC9DE'>";
			str="<table id='Q"+qNo+qId+"' border='0' width='100%' height='61' cellspacing='1' cellpadding='0' bordercolorlight='#BEC9DE'>"+"\n";
			str=str+"<tr><td width='2%' valign='top' align='left' height='19' ><input type='checkbox' name='Q"+qNo+"' value='"+qNo+"' onclick=\"checkMarked(this,'"+qId+"',"+qType+")\"></td>"+"\n";
			str=str+"<td width='2%' valign='top' align='left' height='19'><a name='"+qNo+"'><font face='Arial' size='2'>"+qNo+"</font>.&nbsp;</td>"+"\n";
			str=str+"<td width='688' colspan='5' valign='top' align='left' height='19'><font face='Arial' size='2'>"+qStr+"</font>"+"\n";
			//str=str+"<td width='820' colspan='3' valign='top' align='left' height='19'><font face='Arial' size='2'>"+qStr+"</font>"+"\n";
		}else{		
			str="<tr><td width='2%' valign='top' align='left' height='19'>&nbsp;</td>"+"\n";
			str=str+"<td width='2%' valign='top' align='left' height='19'>&nbsp;</td>"+"\n";
			str=str+"<td width='688' colspan='5' valign='top' align='left' height='19'><font face='Arial' size='2'>"+qStr+"</font>"+"\n";
			//str=str+"<td width='820' colspan='3' valign='top' align='left' height='19'><font face='Arial' size='2'>"+qStr+"</font>"+"\n";
		}		
		return str;
	}

	private static String getQnEFString(String eNumStr,String qStr){
		String str;
		str="<tr><td width='2%' height='5'></td><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5' valign='top' align='left'>&nbsp;&nbsp;"+eNumStr+"</td>"+"\n";
		str=str+"<td width='688' valign='top' align='left' height='5' colspan='4'><font face='Arial' size='2'>"+qStr+"\n";
		return str;
	}		
	

	//Question body format for Fill in the blanks

	public static String getFormattedQnBdyForFB(String qStr,String qId,String qNo,float wTg,String grpId){
		
		String str;
		String iTag="<input type='text' name='"+qId+"' onblur=\"setMark_oth('Q"+qNo+"',this.value)\" > ";

		str=qStr.replaceAll("__________",iTag);
//		str=str.replaceAll("~~~~~~~~~~",iTag);
		str=str.replaceAll("==========",iTag);

		//Santhosh added this part which will add the div object in the exam paper for the Fill in the blank questions.
		str=str.replaceAll("</font></td></tr>","</font></td>");
		str=str+"<td width='90' valign='top'>";
		str=str+"<DIV id='E"+qId+"' style='visibility:hidden'><input type='text' id='M"+qId+"' name='"+grpId+"' value='Enter Points' size='12' onkeypress='return noChars(event)' onblur='verify(this,"+wTg+");'></DIV></td>";
		str=str+"</tr>";

		//upto here

//		str="<tr><td width='2%' height='5'></td><td width='2%' height='5'></td>";
//		str=str+"<td width='2%' height='5' valign='top' align='left'></td>";
//		str=str+"<td width='94%' valign='top' align='left' colspan='4'>"+qStr+"</td>";

		return str;
	}


	// Formatted option body for Multiple chice and Multiple Answer
	

	public static String getFormattedOpnBdyForMCAndMA(ArrayList oAList,int qtype,String qId,String qNo){

		int j;
		String opn;
		String fOptn;

		char caseChar;
		int idx;
		fOptn="";

		for(j=0;j<oAList.size();j++){

			opn=oAList.get(j).toString().trim();
			caseChar=opn.charAt(0);
			switch (caseChar)
			{
				case '#':
					idx=opn.indexOf("##",2);
				    if (fOptn.length()!=0)
				    {
						fOptn=fOptn+"</td></tr>"+"\n";
				    }
					fOptn=fOptn+getOpnFString(opn.substring(2,idx),opn.substring( idx+2 ),qtype,qId,(j+1),qNo);			
					break;
				default:
					fOptn=fOptn+"<br>"+opn;			
			}			
		}	
		
		return fOptn+"</td></tr></table><br>"+"\n";

	}
	
	
	private static String getOpnFString(String eNumStr,String oStr,int qtype,String qId,int v,String qNo){
		String str;
		String iStr="";
		switch (qtype)
		{
		case 0:
		case 2:
			iStr="<input type='radio' name='"+qId+"' value="+v+" onclick=\"setMark('Q"+qNo+"')\">";
			break;
		case 1:
			iStr="<input type='checkbox' name='"+qId+"' value="+v+" onclick=\"setMark('Q"+qNo+"')\">";
		}

		str="<tr><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5'></td><td width='2%' height='5' valign='top' align='left'>"+eNumStr+"</td>"+"\n";
		str=str+"<td width='18' valign='top' align='left' height='5'><font face='Arial' size='2'>"+iStr+"</td><td valign='top' width='632' align='left'><font face='Arial' size='2'>"+oStr+"\n";
		return str;
	}

	// Formatted  Option body for Short Type Questions

	public static String getFormattedOpnBdyForST(String qId,int qType,String qNo,float wTg,String grpId)
	{
		String str;
		str="<tr><td width='2%' height='5'></td><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5' valign='top' align='left'></td>"+"\n";
		str=str+"<td width='632' valign='top' align='left' colspan='4'><textarea rows='5' cols='86' name='"+qId+"' onblur=\"setMark_oth('Q"+qNo+"',this.value)\" ></textarea></td>"+"\n";
		//Santhosh added this part which will add the div object in the exam paper in the essay type questions.
		str=str+"<td width='90' valign='top'>";
		//str=str+"<DIV id='E"+qId+"' style='visibility:hidden'><input type='text' id='M"+qId+"' name='"+grpId+"' value='Enter Points' size='12' onblur='verify(this,"+wTg+");'></DIV></td>";
		str=str+"<DIV id='E"+qId+"' style='visibility:hidden'><input type='text' id='M"+qId+"' name='"+grpId+"' value='Enter Points' size='12' onkeypress='return noChars(event)' onblur='verify(this,"+wTg+");'></DIV></td>";
		str=str+"</tr>";
		//Santhosh added this part which will add the div object in the exam paper in the essay type questions.

		str=str+"<tr><td width='2%' height='5'></td><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5' valign='top' align='left'></td>"+"\n";
		str=str+"<td width='632' valign='top' align='left'>(Optional file upload) <input type='file' name='"+qId+"_f' size='20'> <input type='file' name='"+qId+"_s' size='20'></td>"+"\n";

		return str;
	}

	// Formatted  Option body for True/False
	

	public static String getFormattedOpnBdyForTF(ArrayList oAList,int qType,String qId,String qNo){

		int j;
		String opn;
		String fOptn;

		char caseChar;
		int idx;
		fOptn="";

		for(j=0;j<oAList.size();j++){

			opn=oAList.get(j).toString().trim();
			caseChar=opn.charAt(0);
			switch (caseChar)
			{
				case '#':
					idx=opn.indexOf("##",2);
				    if (fOptn.length()!=0)
				    {
						fOptn=fOptn+"</td></tr>"+"\n";
				    }
					fOptn=fOptn+getTFString(opn.substring( idx+2),qId,(j+1),qType,qNo);			
					break;
				default:
					fOptn=fOptn+"<br>"+opn;			
			}				
		}	
		
		return fOptn+"</td></tr></table><br>"+"\n";

	}


	

	private static String getTFString(String oStr,String qId,int v,int qType,String qNo){
		String str;
		String iStr="";

		iStr="<input type='radio' name='"+qId+"' value="+v+" onclick=\"setMark('Q"+qNo+"')\">";

		str="<tr><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5'></td><td width='2%' height='5' valign='top' align='left'></td>"+"\n";
		str=str+"<td width='18' valign='top' align='left' height='5'><font face='Arial' size='2'>"+iStr+"</td><td valign='top' width='632' align='left'><font face='Arial' size='2'>"+oStr+"\n";
		return str;
	}


	// Creating list box for matching and ordering

	private static String getListBox(ArrayList oList,String qId,String qNo){
		
		int j;
		String opn;
		String rOptn;

		char caseChar;
		
		rOptn="<font face='Arial' size='2'><select name='"+qId+"' onchange=\"setMark_oth('Q"+qNo+"',this.value)\">";

		char abc[]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
		for(j=0;j<oList.size();j++){

			opn=oList.get(j).toString().trim();
			caseChar=opn.charAt(0);
			switch (caseChar)
			{
				case '#':
				    if (rOptn.equals("<font face='Arial' size='2'><select>"))
						rOptn=rOptn+"<option value='"+abc[j]+"'>";
					else
						rOptn=rOptn+"</option><option value='"+abc[j]+"'>";

					rOptn=rOptn+Character.toUpperCase(abc[j]);			

					break;
				default:
					rOptn=rOptn+opn;			
			}			
		}	
		
		rOptn=rOptn+"</option><option value='' selected>...</option></select>";

		return rOptn;
	}


	// Formatted Option String for Matching and Ordering
	
	public static String getFormattedOpnBdyForOM(ArrayList oLList,ArrayList oRList,int qType,String qId,String qNo){
		
		int j;
		String opn;
		String fOptn,rOptn;
		String rStr;
		String fStr;

		char caseChar;
		int idx;
		fStr="<table border='0' width='600' height='61' cellspacing='1' cellpadding='0' bordercolorlight='#BEC9DE'><tr>"+"\n";

		if (qType==4)
		{
			rOptn=getListBox(oRList,qId,qNo);

			for(j=0;j<oLList.size();j++){

				opn=oLList.get(j).toString().trim();
				rStr=oRList.get(j).toString().trim();
				caseChar=opn.charAt(0);

				switch (caseChar)
				{
					case '#':				
						fStr=fStr+"<tr><td valign='top' width='15'><font face='Arial' size='2' align='center'>"+opn.substring(2,opn.indexOf(".")+1)+"&nbsp;</td>"+"\n";			
						fStr=fStr+"<td valign='top' width='192'><font face='Arial' size='2' align='left'>"+opn.substring(opn.indexOf(".")+3)+"</td>"+"\n";
						fStr=fStr+"<td valign='top' width='15'><font face='Arial' size='2' align='center'>"+rStr.substring(2,4)+"</td>"+"\n";
						fStr=fStr+"<td valign='top' width='167'><font face='Arial' size='2' align='left'>"+rStr.substring(6)+"</td>"+"\n";
						fStr=fStr+"<td valign='top' align='left' width='12' align='center'><font face='Arial' size='2'>"+opn.substring(2,3)+"</td>"+"\n";
						fStr=fStr+"<td valign='top' align='left' width='245' align='left'><font face='Arial' size='2'>"+rOptn+"</td></tr>"+"\n";	
				}				
	
			}		
	
			return getOM_FString(fStr)+"</table></td></tr></table><br>"+"\n";

		}
		else{
			
			rOptn=getListBox(oLList,qId,qNo);

			for(j=0;j<oLList.size();j++){

				opn=oLList.get(j).toString().trim();
				caseChar=opn.charAt(0);

				switch (caseChar)
				{
					case '#':				
						fStr=fStr+"<tr><td valign='top' width='15' align='center'><font face='Arial' size='2'>"+opn.substring(2,4)+"</td>"+"\n";			
						fStr=fStr+"<td valign='top' width='192' align='left'><font face='Arial' size='2'>"+opn.substring(6)+"</td>"+"\n";
						fStr=fStr+"<td valign='top' align='left'  align='left'><font face='Arial' size='2'>"+rOptn+"</td></tr>"+"\n";		
				}				
	
			}		
	
			return getOM_FString(fStr)+"</table></td></tr></table><br>"+"\n";
		}
	}




	private static String getOM_FString(String fStr){
		String str;
		str="<tr><td width='2%' height='5'></td>"+"\n";
		str=str+"<td width='2%' height='5'></td><td  height='5' valign='top' align='left'><font face='Arial' size='2'>"+fStr+"</td></tr>"+"\n";
		return str;
	}

	

//  Question String

	public static String getQString(String str,int nChar){

		String qStr;
		StringReader strReadObj;
		BufferedReader bfr;
		qStr="";
		try{

				strReadObj=new StringReader(str);
				bfr=new BufferedReader(strReadObj);		
				while((str=bfr.readLine().trim())!=null){
					if(str.length()!=0){
						if (str.charAt(0)=='@')
						{
							continue;
						}

						if (str.indexOf("<img")!=-1)
						{
							nChar=str.indexOf("<img")-1;

							if (nChar==3)
							{
								qStr="............";
								break;
							}
						}

						if (str.length()>=nChar)
							qStr=str.substring(4,nChar)+"....";
						else
							qStr=str.substring(4,str.length())+"....";						

					    break;
					}
				}
				bfr.close();
		}
		catch(Exception e){
			ExceptionsFile.postException("QuestionFormat.java","getQString","Exception",e.getMessage());			
		}

		return  qStr;
   }	



	
/*	public static String getQString(ArrayList qStr){

		int j,tc;
		String qtn;
		String fQtn;
		char caseStr;
		fQtn="";

		for(j=0;j<qStr.size();j++){
			qtn=qStr.get(j).toString().trim();
			caseStr=qtn.charAt(0);			
			if (caseStr=='%')
			{
				if (qtn.length()<=20) 
					tc=qtn.length();
				 else
					tc=20;

				
				fQtn=qtn.substring(2,tc)+"...........";
				break;
			}
		}
			
		return fQtn;

	}	 */


	
	///   Question body
	
	public static String getQBdyString(ArrayList qStr,String qId,String nLStr){

		int j;
		String qtn;
		String fQtn;

		char caseStr;
		int idx;
		boolean flag;

		fQtn="";
		flag=true;

		for(j=0;j<qStr.size();j++){

			qtn=qStr.get(j).toString().trim();

			caseStr=qtn.charAt(0);			

			switch (caseStr)
			{
				case '%':
					if(flag==true)
						fQtn=qtn.substring(2).trim();						
					else
						fQtn=fQtn+qtn.substring(2).trim();						
					break;
				case '#':
					fQtn=fQtn+nLStr;
					idx=qtn.indexOf("##",2);
					fQtn=fQtn+"\t"+qtn.substring(2,idx)+" "+qtn.substring( idx+2 );
					flag=false;
					break;
				default:
					fQtn=fQtn+nLStr+qtn;			
			}			

		}	

		if (flag==true){		
			fQtn=fQtn;
		}
		
		return fQtn;

	}	


	private static String getString(String body,String beginStr,String endStr){

				String retStr,str;
				retStr="";
				try{			
					StringReader strReadObj=new StringReader(body);
					BufferedReader bfr=new BufferedReader(strReadObj);		
					while((str=bfr.readLine().trim())!=null){
						if(str.length()!=0){
							if(str.indexOf(beginStr)!=-1)
								continue;
							else if(str.indexOf(endStr)!=-1)
								break;
							else
								retStr=retStr+str;
						}
					}
					bfr.close();
				}catch(IOException ie){
					ExceptionsFile.postException("QuestionFormat.java","getString","IOException",ie.getMessage());
				}
				return retStr;

	}

	public static String getAnswer(String bodyStr){
			return getString(bodyStr,"@@BeginABody","@@EndABody");
	}	

	public static String getHint(String bodyStr){
			//return getString(bodyStr,"@@BeginHBody","@@EndHBody");
			String hint=getString(bodyStr,"@@BeginHBody","@@EndHBody");
			return check4Opostrophe(hint);
    }

	public static String getCFeedback(String bodyStr){
			return getString(bodyStr,"@@BeginCBody","@@EndCBody");
	}

	public static String getICFeedback(String bodyStr){
			return getString(bodyStr,"@@BeginIBody","@@EndIBody");
	}
	private static String check4Opostrophe(String s)
    { 
	    String s1="";
        StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        while(i < s.length()) {
			
            if(s.charAt(i) == '\'')
            {
               stringbuffer.replace(i+j , i+j+1, "\\\'");
			   j++;
			}else if(s.charAt(i)=='\"'){

				stringbuffer.replace(i+j , i+j+1 , "&quot;");
				j+=5;
			}
			i++;
	    }
        return stringbuffer.toString();
		
    }
}
