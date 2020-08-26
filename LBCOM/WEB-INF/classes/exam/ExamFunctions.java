package exam;

import java.io.*;
import java.sql.*;
import java.util.*;
import coursemgmt.ExceptionsFile;


public class ExamFunctions{
	Connection con;
	Statement st;
	ResultSet rs;

	String examId,schoolId,title,path,dispPath;
	/*String quesList;
	String ansList;
	String resList;*/

	String [][] groupsDet;
	boolean flage;

	Vector questions=null;
	Vector responses=null;
	Vector answers=null;
	Vector rWeight=null;
	Vector nWeight=null;
	
	Vector groups=null;   
	Vector g=null;
	Vector maxQues=null;
	Hashtable totQtns=null;
	Hashtable ansQtns=null;
	Hashtable gInst=null;
	Hashtable gPMarks=null;
	Hashtable gNMarks=null;

	RandomAccessFile rFile,ansFile;

	float totalMarks;
	float marksScored;
	
	int mIndex=0;

	public ExamFunctions(){
		examId="";
		schoolId="";
		title="";
		path="";
		dispPath="";

		flage=false;

		totalMarks=0.0f;
		marksScored=0.0f;
		mIndex=0;

		questions=new Vector(2,1);
		responses=new Vector(2,1);
		rWeight=new Vector(2,1);
		nWeight=new Vector(2,1);
		
		groups=new Vector(2,1);
		
		totQtns=new Hashtable();
		ansQtns=new Hashtable();
		gInst=new Hashtable();
		gPMarks=new Hashtable();
		gNMarks=new Hashtable();

		rFile=null;
		ansFile=null;

		g=new Vector(2,2);
		maxQues=new Vector(2,2);
	}

	public void setRFile(RandomAccessFile file){
		rFile=file;
	}

	public void setAnsFile(RandomAccessFile file){
		ansFile=file;
	}

	public RandomAccessFile getRFile(){
		return rFile;
	}

	public RandomAccessFile getAnsFile(){
		return ansFile;
	}

	public float getTotalMarks(){
		return totalMarks;
	}
	
	public void setTotalMarks(float t){
		totalMarks=t;
	}
	public float getMarksScored(){
		return marksScored;
	}
	public void setExamId(String eId){
		examId=eId;
	}
	
	public void setSchoolId(String sId){
		schoolId=sId;
	}
	
	public void setTitle(String t){
		title=t;
	}
	public void setPath(String p){
		path=p;
	}

	public void setDispPath(String dp){
		dispPath=dp;
	}

	public String getDispPath(){
		return dispPath;
	}
	
	public void setStatement(Statement s){
		st=s;
	}

	public void setResultSet(ResultSet r){
		rs=r;
	}

	public Vector getQuestions(){
		return questions;
	}

	public Vector getResponses(){
		return responses;
	}
	public void setResponses(Vector res){
		responses=res;
	}
	public Vector getGroups(){
		return groups;
	}
	public String getPath(){
		return path;
	}
	public boolean getFlage(){
		return flage;
	}
	public void singleAnswer(String qid,String a,String cfBack,String icFBack) {  
				String str="";
				String value="";
				String feedback="";
				int ind=questions.indexOf(qid);
				String r=(String)responses.get(ind);
				String gId=(String)groups.get(ind);
				float negMarks=Float.parseFloat((String)nWeight.get(ind));
				float posMarks=Float.parseFloat((String)rWeight.get(ind));
				float marks=0;
				try {
					if (r.equals(a)){
						value="Correct";
						marks=posMarks; 
						feedback=cfBack;
					} else {
						value="Incorrect";
						feedback=icFBack;
						if ((r.indexOf('1'))==-1){
							marks=0;  
						}
						else{
							marks=(-1)*negMarks;
							
						}
					}
					
					str=str+"setTableProperties('Q"+(ind+1)+qid+"','"+value+"','"+marks+"','"+posMarks+"');"+"\n";
					str=str+"setMultipleOptionsProperties('"+qid+"','"+r+"');"+"\n";
					ansFile.writeBytes(str);
					
					setMarks(gId,marks);     
									   
				}catch(Exception e) {
					ExceptionsFile.postException("ExamFunctions.java","singleAnswer","Exception",e.getMessage());
				}
	}
	
	public void multipleAnswer(String qid,String a,String cfBack,String icfBack,String qtype) {
		try{
				
				int ind=questions.indexOf(qid);
				String r=(String)responses.get(ind);
				String gId=(String)groups.get(ind);

				float negMarks=Float.parseFloat((String)nWeight.get(ind));
				float posMarks=Float.parseFloat((String)rWeight.get(ind));

				int k=0;
				float marks=0;
				int j=0;
				float marksPerAns;
				String str="";
				String value="",feedback="";
				boolean flage=false;
				
					if (r.equals(a))
						{				
							marks=posMarks;    
							value="Correct";
							feedback=cfBack;
						}
					else
						{										
							value="Incorrect";
							feedback=icfBack;
							//Question is not attempted

							if ((r.indexOf('1'))==-1)
								{
									marks+=0;   
								}
							else if ((r.indexOf('0'))==-1)
								{							//all options are checked
									marks=(-1)*negMarks; 
    							}
								
							else
								{							
									char ans[]=new char[a.length()];
									a.getChars(0,a.length(),ans,0);
									char res[]=new char[r.length()];
									r.getChars(0,r.length(),res,0);
	
									for (int i=0;i<ans.length;i++ )
										{
											if ((ans[i]==res[i])&&(ans[i]=='1'))
												{									 //if one option is correct
													j++;
													//no of options are correct
												}
											else if ( (ans[i]!=res[i]) && ((ans[i]=='0')||(ans[i]=='1')) && (res[i]=='1'))
												{	
													/* if the option checked is not correct then increment n by one*/
													flage=true;	
												}
									
											if (ans[i]=='1')
												{						//how any correct options are there for a single questions
													k++;
												}
										}
									marksPerAns=posMarks/(float)k;						//positive marks per one correct answer
									marks=(j*marksPerAns);  
									if (flage)
										{
											marks+=(-1)*negMarks;							//if there is any wrong answer
										}
								} 	
						
						}
						//-----------------------Santhosh added from here----------------
						
						if(qtype.equals("4")||qtype.equals("5"))			// For Matching and Ordering type of questions-------
						{

							if (r.equals(a))
							{				
								marks=posMarks;    
								value="Correct";
								feedback=cfBack;
							}
							else
							{										
								value="Incorrect";
								feedback=icfBack;
							
								char ans[]=new char[a.length()];
								a.getChars(0,a.length(),ans,0);
								char res[]=new char[r.length()];
								r.getChars(0,r.length(),res,0);
								for (int i=0;i<ans.length;i++ )
								{
									
									if (ans[i]==(res[i]))
									{									 //if one option is correct
										j++;							//no of options are correct
									}
									else if(ans[i]!=(res[i]))
									{								/* if the option checked is not correct then increment n by one*/
										flage=true;	
									}
															//how many options are there in a question
											k++;
																
								}
							marksPerAns=posMarks/(float)k;
							marks=(j*marksPerAns);
							if (flage)
							{
								marks+=(negMarks)*(-1);  
							}
							str=str+"setTableProperties('Q"+(ind+1)+qid+"','MO','"+marks+"','"+posMarks+"');"+"\n";						
							str=str+"setMatching('"+qid+"','"+r+"');"+"\n";
							}
							str=str+"setTableProperties('Q"+(ind+1)+qid+"','MO','"+marks+"','"+posMarks+"');"+"\n";
							str=str+"setMatching('"+qid+"','"+r+"');"+"\n";
						}
						else
						{
							str=str+"setTableProperties('Q"+(ind+1)+qid+"','"+marks+"','"+posMarks+"');"+"\n";
							str=str+"setMultipleOptionsProperties('"+qid+"','"+r+"');"+"\n";
						}
						
					
						ansFile.writeBytes(str);
						setMarks(gId,marks);
							
						
			}catch(Exception e) {
					ExceptionsFile.postException("ExamFunctions.java","multipleAnswer","Exception",e.getMessage());
					
				}
	}

					//---------------------Santhosh added upto here----------------
	    
	public void fillInTheBlanks(String qid,String a,String cfBack,String icfBack) {
				int ind=questions.indexOf(qid);
				String r=(String)responses.get(ind);
				String gId=(String)groups.get(ind);

				float negMarks=Float.parseFloat((String)nWeight.get(ind));
				float posMarks=Float.parseFloat((String)rWeight.get(ind));

				int j=0;
				int k=0;
				a=a.trim();
				r=r.trim();
				float marksPerAns,marks=0;
				String str="";
				String value="",feedback="";
				String stuAns=r;
				String actAns=a;
				boolean flage=false;
				try {
					if (r.equalsIgnoreCase(a))
					{								//response matches with correct answer
						value="Correct";
						feedback=cfBack;
						marks=posMarks;       
					}
					else if (r.equals(""))
					{						//if the question is not attempted
						marks=0;     
						value="Incorrect";
						feedback=icfBack;
					}
					else
					{		
						value="Incorrect";
						feedback=icfBack;
						
						StringTokenizer ans=new StringTokenizer(a,"~");	// Santhosh changed , to ~ on 18-11-06
						StringTokenizer res=new StringTokenizer(r,"~");	// Santhosh changed , to ~ on 18-11-06
						String t;
						while(ans.hasMoreTokens())
						{	
							if((ans.nextToken()).equalsIgnoreCase(res.nextToken()))
							{ 
							
										     /*	if one reponse per question  is correct  */
    							   j++;
							}
							else
							{									//if the attempted answer is wrong
									flage=true;
							}
							k++;									//no of answers per questions
						}
						marksPerAns=posMarks/(float)k;
						marks=(j*marksPerAns); 
						if (flage)
						{
							marks+=(negMarks)*(-1);  
						}
					
					}
	
					str=str+"setTableProperties('Q"+(ind+1)+qid+"','teacher');"+"\n";
					str=str+"setFillInTheBlanks('"+qid+"','"+r+"');"+"\n";
					ansFile.writeBytes(str);
					
					// Santhosh added from here
					
					//setMarks(gId,marks);
						setMarks(gId,0);
					
				
					flage=true;
					// Upto here
				
				}catch(Exception e){
					ExceptionsFile.postException("ExamFunctions.java","fillInTheBlanks","Exception",e.getMessage());
					
				}
	}


	public void shortAnswer(String q,String a,String qid,int ec) {
		int ind=questions.indexOf(qid);
		String r=(String)responses.get(ind);
		r=r.replaceAll("\r\n","<BR>");
		r=r.replaceAll("\'","\\\\\'");
		String gId=(String)groups.get(ind);
		String str="";
		String ansStr="";
		String prevGroupId="";
		float negMarks=Float.parseFloat((String)nWeight.get(ind));
		float posMarks=0.0f;
		//System.out.println("ec..."+ec);

		/*
		if(ec==2)
		{
			//posMarks=100;
		}
		else
		{
			//posMarks=Float.parseFloat((String)rWeight.get(ind));
		}
		*/
		
		posMarks=Float.parseFloat((String)rWeight.get(ind));
		int ans=0,ques=0;
		float marks=0;
		
		
		try
		{	
				rFile.seek(rFile.length());
			
				if (rFile.length()==0)
				{	
			
					str="\n"+"<html>"+"\n"+"<head>"+"\n"+"<title>"+title+"</title>"+"\n";
					str=str+"<script>"+"\n";  
					str=str+"function ltrim ( s ) {"+"\n";
					str=str+"	return s.replace( /^\\s*/, \"\" );"+"\n"+"}"+"\n";
					str=str+"function rtrim ( s ){	"+"\n";
					str=str+"	return s.replace( /\\s*$/, \"\" );"+"\n"+"}"+"\n";
					str=str+"function trim ( s ) {"+"\n";
					str=str+"	return rtrim(ltrim(s));"+"\n"+"}"+"\n";
					str=str+"function show_key(the_value)"+"\n"+"{"+"\n";
					str=str+"var the_key=\".0123456789\";"+"\n";
                    str=str+"var the_char;"+"\n";
					str=str+"var len=the_value.length;"+"\n";
					str=str+"if(the_value==\"\")"+"\n";
					str=str+"return false;"+"\n";
					str=str+"for(var i=0;i<len;i++){"+"\n";
					str=str+"the_char=the_value.charAt(i);"+"\n";
					str=str+"if(the_key.indexOf(the_char)==-1)"+"\n";
					str=str+"return false;"+"\n"+"}"+"}"+"\n";
					str=str+"\n"+"function verify(m,max){";
					str=str+"\n"+"var kk=0;";
					str=str+"\n"+"var txt= document.getElementsByName(m.name);";
					str=str+"\n"+"var tFldId=document.getElementById(m.id);";
					str=str+"\n"+"   if(tFldId.readOnly==false)	{";
					str=str+"\n"+"for(var i=0;i<txt.length;i++)";
					str=str+"\n"+"if(txt[i]==m){";
					str=str+"\n"+"   var kk=i;";
					str=str+"\n"+"	 break;";
					str=str+"\n"+"   }";
					str=str+"\n"+"   if(isNaN(m.value)) {";
					str=str+"\n"+"	   alert('Type in number');";
					str=str+"\n"+"	   txt[kk].select();";
					str=str+"\n"+"   }else if(m.value>max) { ";
					str=str+"\n"+"	   alert('Maximum points for this answer is '+max);";
					str=str+"\n"+"	   txt[kk].select();";
					str=str+"\n"+"   }else { ";
					str=str+"\n"+"	  if(m.value!=\"\"){ ";
					str=str+"\n"+"	  				  calc();";
					str=str+"\n"+"		   for(var j=0;j<txt.length;j++){";
					str=str+"\n"+"			if(trim(txt[j].value)==\"\"){";
					str=str+"\n"+"			 txt[j].focus();";
					str=str+"\n"+"			 break;";
					str=str+"\n"+"			}";	
					str=str+"\n"+"			}";
					str=str+"\n"+"					}";
					str=str+"\n"+"	   }";
					str=str+"\n"+"		  }";
					str=str+"\n"+" }";
					
					str=str+"function calc(){"+"\n"+"     ";
					str=str+"\n"+"var len,win,q,tot,temp;"+"\n";
					str=str+"var ar;"+"\n";
					str=str+"tot=0;"+"\n";
					str=str+"for(var i=0;i<arr.length;i++) {"+"\n";
                    str=str+"q=arr[i];"+"\n"+"win=document.anssheet.elements[q];"+"\n"+"len=win.length;";
					str=str+"\n"+"ar=new Array(len);"+"\n";
					str=str+"if(!win.length) {"+"\n"+"  if (trim(win.value)=='')"+"\n"+"tot=parseFloat(tot+0);"+"\n";
		            str=str+"  else "+"\n"+"    tot=parseFloat(tot+parseFloat(win.value));"+"\n";
					str=str+"}else {"+"\n";
					str=str+"  for(var j=0;j<len;j++) "+"\n";
					str=str+"     if (trim(win[j].value)=='')"+"\n";
					str=str+"          ar[j]=0;"+"\n";
					str=str+"     else"+"\n";
			        str=str+"          ar[j]=win[j].value;"+"\n";
			        str=str+"  for(j=0;j<len-1;j++) {"+"\n";
				    str=str+"     for(var k=j+1;k<len;k++) {"+"\n";
				    str=str+"          if (parseInt(ar[j])<parseInt(ar[k])) {"+"\n";
				    str=str+"             temp=ar[j];"+"\n";
					str=str+"             ar[j]=ar[k];"+"\n";
					str=str+"             ar[k]=temp;"+"\n";
					str=str+"           }"+"\n"+"      }"+"\n"+"    }"+"\n";
					str=str+"for(j=0;j<maxarr[i];j++) {"+"\n";
					str=str+"if((ar[j]=='')||(!ar[j]))"+"\n"+"   tot=parseFloat(tot+0)"+"\n"+"else "+"\n";
					str=str+"   	tot=parseFloat(tot+parseFloat(ar[j]));"+"\n";
					str=str+""+"\n"+"}"+"\n"+"}"+"\n"+"}"+"\n";
					str=str+"if (isNaN(tot))"+"\n";
					str=str+"   alert('Enter proper values');"+"\n";
                    str=str+"else"+"\n";
					str=str+"    parent.third.document.sub.marks.value=tot;"+"\n";
					str=str+"}";
					str=str+"</script>"+"\n";
					str=str+"<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>"+"\n";
					str=str+"</head>";
					str=str+"\n"+"<body><form name='anssheet' >";
					rFile.writeBytes(str);
					
				}
				if (!(prevGroupId.equals(gId))) 
				{
					ans=Integer.parseInt((String)ansQtns.get(gId));
					ques=Integer.parseInt((String)totQtns.get(gId));
					g.add(gId);
					maxQues.add((String)ansQtns.get(gId));
					float tMarks=(Float.parseFloat((String)ansQtns.get(gId)))*(posMarks);
					str="\n"+"<table border='0' bgcolor='#E8ECF4' width='100%' bordercolorlight='#FFFFFF' cellspacing='1'>"+"\n<tr><td width='87%' valign='top' bgcolor='#DFE2F4'><font face='Arial' size='2'>Group Instructions : "+(String)gInst.get(gId)+"</font></td>"+"\n";
					
					if (!gId.equals("-")) 
					{
						str=str+"\n"+"<td width='13%' bgcolor='#DFE2F4'><p align='right'><font face='Arial' size='2'>Total Points:"+tMarks+"</font></p></td>"+"\n";
					}
					str=str+"\n"+"</tr></table>"+"\n";
					str=str+"<table border='0' width='100%' bordercolorlight='#FFFFFF' cellspacing='1' height='148'>"+"\n";
					rFile.writeBytes(str);
					
				}
				str="\n"+"<tr> <td width='3%' valign='top' align='left' bgcolor='#E2E2E2' height='21'><b>Q.</b></td>"+"\n";
				str	=str+"\n"+"<td width='95%' valign='top' align='left' height='21' bgcolor='#F3F3F3'><font face='Arial' size='2'>"+getQString(q)+"</font></td>";
                str=str+"\n"+"<td width='11%' height='21' bgcolor='#F7F3F7'><p align='right'><font face='Arial' size='2'>Max. Points :"+posMarks+"</font></p></td></tr>"+"\n"+"<tr>"+"\n";
				str=str+"<td width='3%' valign='top' align='left' bgcolor='#E2E2E2' height='21'><font face='Arial' size='2'>Key</font></td>"+"\n";
				str=str+"<td width='106%' valign='top' align='left' height='21' bgcolor='#F3F3F3' colspan='2'><font face='Arial' size='2'>&nbsp;"+a;			
				str=str+"</font></td></tr>"+"\n";
                str=str+"<tr><td width='3%' valign='top' align='left' bgcolor='#E2E2E2' height='53'><font face='Arial' size='2'>Ans</font></td>"+"\n";
				str=str+"<td width='106%' valign='top' align='left' height='53' colspan='2'><font face='Arial' size='2'>";				
							
				String link=getDataFromFile(qid);
				str=str+link;	
				str=str+r;
								
				str=str+"</font></td></tr>"+"\n";
                str=str+"<tr>";
				str=str+"<td width='3%' bgcolor='#E8ECF4' height='17'>&nbsp;</td>"+"\n";
				str=str+"<td width='95%' bgcolor='#E8ECF4' height='17'><p align='right'><font face='Arial' size='2'>Secured Points</font></td>"+"\n";
				str=str+"<td width='11%' bgcolor='#E8ECF4' height='17'><p align='right'><font size='1' face='Arial'><input type='text' name='"+gId+"' size='12'  onblur='verify(this,"+posMarks+"); '></font>  </td></tr>"+"\n";
				str=str+"<tr><td width='109%' bgcolor='#F5F8FA' colspan='3' height='1'> <p align='right'>&nbsp;</p></td></tr>"+"\n";
			
				rFile.writeBytes(str);				
				
				ansStr=ansStr+"setTableProperties('Q"+(ind+1)+qid+"','teacher');"+"\n";
				ansStr=ansStr+"setAnsFileLink(\"Q"+(ind+1)+qid+"\",\""+getFileName(qid,'f')+"\");"+"\n";
				ansStr=ansStr+"setShortTypeQuestion('"+qid+"','"+r+"');"+"\n";
				ansStr=ansStr+"setTableProperties('Q"+(ind+1)+qid+"','teacher');"+"\n";
				ansStr=ansStr+"setAnsFileLink(\"Q"+(ind+1)+qid+"\",\""+getFileName(qid,'s')+"\");"+"\n";
				ansStr=ansStr+"setShortTypeQuestion('"+qid+"','"+r+"');"+"\n";
				ansFile.writeBytes(ansStr);
				flage=true;
				prevGroupId=gId;
				setMarks(gId,marks);
				
		}catch(Exception e) {
			ExceptionsFile.postException("ExamFunctions.java","shortAnswer","Exception",e.getMessage());
			
		}
			
	}
	
	public Vector tokenize(String s,Vector q,String delim) {
		Vector v=new Vector(2,1);
		String temp;
		String st;
	  try {
		
		int  startIndex=0;
		int ind1;
		int index1=0;
		int delimLen=delim.length();
		int strLen=s.length();
		ListIterator l=q.listIterator();
		int i=0;
		while((index1=s.indexOf(delim,startIndex))>-1) {
			temp=s.substring(startIndex,index1);
			st=(String)l.next();
			ind1=q.indexOf(st);
			
			v.add(ind1,temp);
			
			startIndex=index1+delimLen;
			i++;
		}
		if (startIndex<strLen) {
			temp=s.substring(startIndex,strLen);
 			st=(String)l.next();
			ind1=q.indexOf(st);
			v.add(temp);
		}
	}catch(Exception e) {
		ExceptionsFile.postException("ExamFunctions.java","tokenize","Exception",e.getMessage());
		
	}
	return(v);


	}
	public void setMarks(String gId,float mrks) {
		try{

			 groupsDet[mIndex][0]=gId;
			 groupsDet[mIndex][1]=String.valueOf(mrks);
			 mIndex++;
			 
		}catch(Exception e) {
			ExceptionsFile.postException("ExamFunctions.java","setMarks","Exception",e.getMessage());
			
		}
    }

	public float calculateTotalMarks() {
		float totalMarks=0.0f;
	   try{
		   int fromIndex=0;
		   int toIndex=0;
		   float max=0;
		   String key;
		   float[] ar;
		   int i,j;
		   int limit=0;
		   int loopControl=0;
		   int ind;
		   int s=0; 	
		   
		   while (loopControl<mIndex) {
			  key=groupsDet[fromIndex][0];

			  ind=groups.indexOf(key);	
			  toIndex=Integer.parseInt((String)totQtns.get(key))+fromIndex;
			  limit=Integer.parseInt((String)ansQtns.get(key));

			   if (key.equals("-")) {
				   	Enumeration t= rWeight.elements();
					while(t.hasMoreElements()) {
						if (s<limit){ 
						   totalMarks+=Float.parseFloat((String)t.nextElement());
						   s++;
						}
						else
							break;
					}
			   }else {	
					totalMarks+=limit*(Float.parseFloat((String)rWeight.get(ind)));
			   }
			  ar=new float[toIndex-fromIndex];
			  for (j=fromIndex,i=0;j<toIndex;j++,i++ )
			  {
					  ar[i]=Float.parseFloat(groupsDet[j][1]);

			  }

              Arrays.sort(ar);

			  for(i=ar.length-1,j=0;j<limit;i--,j++){	
				  marksScored+=ar[i]; 	

		      }
			  loopControl=toIndex;

		      fromIndex=loopControl;
		  }

		
	  }catch(Exception e) {
		  ExceptionsFile.postException("ExamFunctions.java","setTotalMarks","Exception",e.getMessage());
			
	  }
	  return totalMarks;
    }
	
	public void setGroups() {
		String gId,totQues,ansQues,inst,cMarks,nMarks;
		try{
		
			
			rs=st.executeQuery("select * from "+schoolId+"_"+examId+"_group_tbl group by group_id");
			while (rs.next()) {
				gId=rs.getString("group_id");
				totQues=rs.getString("tot_qtns");
				ansQues=rs.getString("ans_qtns");
				inst=rs.getString("instr");
				cMarks=rs.getString("weightage");
				nMarks=rs.getString("neg_marks");
				totQtns.put(gId,totQues);
				ansQtns.put(gId,ansQues);
				gInst.put(gId,inst);
				gPMarks.put(gId,cMarks);
				gNMarks.put(gId,nMarks);
				mIndex+=Integer.parseInt(totQues);
			}
			groupsDet=new String[mIndex][2];
			mIndex=0;
		}catch (Exception e) {
			ExceptionsFile.postException("ExamFunctions.java","getGroups","Exception",e.getMessage());
			
		}
		
	}

	public void setObjects(String quesList)
	{
		StringTokenizer qList=null,temp=null;
		StringTokenizer trimQList=null;	//Added by Santhosh on 07_12_2006 (trimming question list. i.e removing the marks obtained in the submission
		try
		{
			String cMarks="",nMarks="",t="",grp="";
			int i=0;
			String ansStr1="";

			trimQList=new StringTokenizer(quesList,"&");
			if(trimQList.hasMoreTokens())
			{
				ansStr1=trimQList.nextToken();
				try
				{
					quesList=trimQList.nextToken();
				}
				catch(NoSuchElementException e) 
				{
					quesList=ansStr1;
					ansStr1="";
				}
			}
			
			qList=new StringTokenizer(quesList,"#");
			while (qList.hasMoreTokens()) 					//reteriving Questions
			{
				temp=new StringTokenizer(qList.nextToken(),":");
				if(temp.hasMoreTokens())
				{
					t=temp.nextToken();
					cMarks=temp.nextToken();
					nMarks=temp.nextToken();
					grp=temp.nextToken();
					questions.add(i,t);
					groups.add(i,grp);
					if(grp.equals("-"))
					{
						rWeight.add(i,cMarks);
						nWeight.add(i,nMarks);
					}
					else
					{
						cMarks=(String)gPMarks.get(grp);
						nMarks=(String)gNMarks.get(grp);
						rWeight.add(i,cMarks);
						nWeight.add(i,nMarks);
					}
				}
				i++;
			}
		}
		catch (Exception e) 
		{
			ExceptionsFile.postException("ExamFunctions.java","setObjects","Exception",e.getMessage());
			System.out.println("The Exception in ExamFunctions.java is..."+e);
		}
		finally
		{
			qList=null;
			temp=null;
		}
	}
	
	synchronized public static String getQString(String str){

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
	/*	if (str.length()>=30)
		qStr=str.substring(2,30)+"....";
		else
		qStr=str.substring(2,str.length())+"...."; */
		qStr=str.substring(4,str.length());
			break;
		}
		}
		bfr.close();
		}
		catch(Exception e){
			ExceptionsFile.postException("ExamFunctions.java","getQString","Exception",e.getMessage());
		
		}

		return  qStr;
   } 

   public String getDataFromFile(String qId){


	//String path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;

	//String path="C:/Tomcat 5.0/webapps/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;	
	
	//String urlpath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no+"/";



	String data="";
	String data1="";

	String record = "";  

	try {  
		
		File  temp=new File(path);
		String fileList[] = temp.list();
		
		for(int i=0;i<fileList.length;i++)   
	    {  
			if(fileList[i].indexOf('_')==-1)
				continue;
			if(fileList[i].substring(0,fileList[i].indexOf("_f")+2).equals(qId+"_f")){
				data="<a href='#' onclick=\"window.open('"+dispPath+fileList[i]+"','t','width=400,height=400,resizable=yes,scrollbars=yes'); return false;\">"+fileList[i]+"</a>";
				data=data+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			if(fileList[i].substring(0,fileList[i].indexOf("_s")+2).equals(qId+"_s"))
				data1="<a href='#' onclick=\"window.open('"+dispPath+fileList[i]+"','t','width=400,height=400,resizable=yes,scrollbars=yes'); return false;\">"+fileList[i]+"</a>";
						
		}
		data=data+""+data1;

	//			FileReader fr = new FileReader(path+"/"+qId); 
	//			BufferedReader bfr = new BufferedReader(fr);

	//		 while ( (record=bfr.readLine()) != null ) {      


	//			data=data+record+"<br>";
		 
	} catch (Exception e) {  
		ExceptionsFile.postException("ExamFunctions.java","getDataFromFile","Exception",e.getMessage());
		
	}  

	
	return data;	
	}
	public String getFileName(String qId,char no){
		//String path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;

		//String urlpath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no+"/";
		String data="";

		String record = "";  

	try {  

		File  temp=new File(path);
		String fileList[] = temp.list();	
		for(int i=0;i<fileList.length;i++)   
	    {  
			if(fileList[i].indexOf("_"+no)==-1)
				continue;
			if(fileList[i].substring(0,fileList[i].indexOf("_"+no)).equals(qId))
				data=dispPath+fileList[i];			
		}


		 
	} catch (Exception e) {  
		ExceptionsFile.postException("ExamFunctions.java","getDataFromFile","Exception",e.getMessage());
		
	}  

	
	return data;	
	}

	public void beginAnsHtml(){
		
		try{
			String str="";
			str=str+"<html>"+"\n";
			str=str+"<head>"+"\n";
			str=str+"<meta http-equiv='Content-Language' content='en-us'>"+"\n";
			str=str+"<meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>"+"\n";
			str=str+"<meta name='GENERATOR' content='Microsoft FrontPage 4.0'>"+"\n";
			str=str+"<meta name='ProgId' content='FrontPage.Editor.Document'>"+"\n";
			str=str+"<META HTTP-EQUIV='Expires' CONTENT='Mon, 04 Dec 1999 21:29:02 GMT'>"+"\n";
			str=str+"<title>"+title+"</title>"+"\n";
			str=str+"<script language='javascript' src='/LBCOM/validationscripts.js'></script>"+"\n";
			str=str+"<script language='javascript' src='/LBCOM/common/evaluation.js'></script>"+"\n";
			str=str+"<script language='javascript'>"+"\n";
			str=str+"<!--"+"\n";
			/*str=str+"function setTableProperties(tableid,msg){"+"\n";
			str=str+"		try{"+"\n";
			str=str+"	var x=top.mid_f.document.getElementById(tableid);"+"\n";
			str=str+"	var y=top.mid_f.document.getElementById(tableid).rows[0].cells;"+"\n";
			str=str+"	if(msg=='Correct'){"+"\n";
			str=str+"		x.bgColor='#F7FBF7';"+"\n";
			str=str+"		y[2].innerHTML=\"<font face='arial' size='2' color='#008000'>\"+y[2].innerHTML+\"</font>\";"+"\n";
			str=str+"	}else if(msg=='Incorrect'){"+"\n";
			str=str+"		x.bgColor='#FFF4F4';"+"\n";
			str=str+"		y[2].innerHTML=\"<font face='arial' size='2' color='red'>\"+y[2].innerHTML+\"</font>\";"+"\n";
			str=str+"	}else if (msg=='teacher'){"+"\n";
			str=str+"		//x.bgColor='#DFD5FF';"+"\n";
			str=str+"	}"+"\n";
			str=str+"		}catch(err){"+"\n";
			str=str+"			onld();"+"\n";
			str=str+"		}"+"\n";
			str=str+"}"+"\n";
			str=str+"function setAnsFileLink(tableid,file){"+"\n";
			//st=str+"<a href='#' onclick=\"window.open('\"+file+\"','t','width=400,height=400,resizable=yes,scrollbars=yes'); return false;\">\"+file+\"</a>";
			str=str+"	var x=top.mid_f.document.getElementById(tableid).rows[0].cells"+"\n";
			str=str+"   var desc='';"+"\n";
			str=str+"   if (file.length>0){"+"\n";
			str=str+"		desc=file.substring(file.lastIndexOf('/')+1,file.length)"+"\n";
			str=str+" }"+"\n";
			str=str+"	x[2].innerHTML=x[2].innerHTML+'&nbsp;&nbsp;'+\"<a href='#' onclick=\\\"window.open('\"+file+\"','t','width=400,height=400,resizable=yes,scrollbars=yes'); return false;\\\"><font face='arial' size='2' color='blue'>\"+desc+\"</font></a>\";"+"\n";
			str=str+"}"+"\n";
			str=str+"function setMultipleOptionsProperties(id,option){"+"\n";
			str=str+"	var ind=0;"+"\n";
			str=str+"	var ele=top.mid_f.document.getElementsByName(id);"+"\n";
			str=str+"	if(ele.length>0 && option.length>0){"+"\n";
			str=str+"		for(var i=0;i<option.length;i++){"+"\n";
			str=str+"			if(option.charAt(i)==1){"+"\n";
			str=str+"				ele[i].checked=true;"+"\n";
			str=str+"			}else if(option.charAt(i)==0){"+"\n";
			str=str+"				ele[i].checked=false;"+"\n";
			str=str+"			}"+"\n";
			str=str+"		}"+"\n";
			str=str+"	}"+"\n";
			str=str+"}"+"\n";
			str=str+"function setFillInTheBlanks(id,option){"+"\n";
			str=str+"  var winele=top.mid_f.document.getElementsByName(id);"+"\n";
			str=str+"  if(winele.length>0){"+"\n";
			str=str+"	if(winele.length>1){"+"\n";
			str=str+"		var arr=option.split('~');"+"\n";	//Santhosh changed comma to ~ on 18-11-06.
			str=str+"		if(arr.length>0){"+"\n";
			str=str+"		  for(var i=0;i<arr.length;i++){"+"\n";
			str=str+"			winele[i].value=arr[i];"+"\n";
			str=str+"		  }"+"\n";
			str=str+"		}else{"+"\n";
			str=str+"			winele[0].value=option;"+"\n";
			str=str+"		}"+"\n";
			str=str+"	}else{"+"\n";
			str=str+"		winele[0].value=option;"+"\n";
			str=str+"	}"+"\n";
			str=str+" }"+"\n";
			str=str+"}"+"\n";

			str=str+"	function replaceAll( str, from, to ) {\n";
			str=str+"			var idx = str.indexOf( from );\n";
			str=str+"		while ( idx > -1 ) {\n";
			str=str+"			str = str.replace( from, to ); \n";
			str=str+"			idx = str.indexOf( from );\n";
			str=str+"		}\n";
			str=str+"		return str;\n";
			str=str+"	}\n";
			str=str+"function setShortTypeQuestion(id,option){"+"\n";
			str=str+"	top.mid_f.document.getElementsByName(id)[0].value=replaceAll(option,'<BR>','\\n');"+"\n";
			str=str+"}"+"\n";

			str=str+"function setMatching(id,option){"+"\n";
			str=str+"	var ind=0;"+"\n";
			str=str+"	var ele=top.mid_f.document.getElementsByName(id);"+"\n";
			str=str+"	if(ele.length>0 && option.length>0){"+"\n";
			str=str+"		for(var i=0;i<option.length;i++){"+"\n";
			str=str+"				ele[i].value=option.charAt(i);"+"\n";
			str=str+"		}"+"\n";
			str=str+"	}"+"\n";
				
			str=str+"}"+"\n";
			*/
			str=str+"function change(){"+"\n";
			str=str+"var act=top.mid_f.document.forms[0].action\n";
			str=str+"top.mid_f.document.forms[0].action=act+'&attempt="+path.substring(path.lastIndexOf("/")+1)+"\'\n";
			writeInToFile(ansFile,str);
		}catch(Exception e){
			System.out.println("Exception in ExamFunctions.java is..."+e);
			ExceptionsFile.postException("SelfTestProcessing.java","beginAnsHtml","Exception",e.getMessage());
			

		}
   }
  

   public void endAnsHtml(String examId,String createdDate,int version,String stuPassword) {
	   try{
		String str="";
		str=str+"}"+"\n";
		str=str+"function onld(){"+"\n";
		str=str+"	var t=setTimeout('change()',5000);"+"\n"+"DeleteTimeCount();"+"\n";
		str=str+"}"+"\n";
		str=str+"function stat(){"+"\n";
		str=str+"window.status= 'Done';"+"\n";
		str=str+"timer = setTimeout('stat()',300)}"+"\n";
		str=str+"function DeleteTimeCount(){"+"\n";
		str=str+"window.status= 'Done';"+"\n";
		str=str+"stat();"+"\n";
		str=str+"var t=setTimeout('parent.frames[0].clearTimeout(parent.frames[0].timer)',1000);"+"\n";
		str=str+"stat();"+"\n";
		str=str+"}"+"\n";
		str=str+"//-->"+"\n";	
		str=str+"</SCRIPT>"+"\n";
		str=str+"</head>"+"\n";
		str=str+"<body onload='onld();'>"+"\n";
		str=str+"</body >"+"\n";

		str=str+"	<a href='#' onclick=\"parent.frames[0].startClock();parent.btm_f.location.href='/LBCOM/exam/CheckExamStatus.jsp?examid="+examId+"&createddate="+createdDate.replace('-','_')+"&version="+version+"&stupassword="+stuPassword+"'\">Do you want to submit again</a>"+"\n";
		str=str+"</body>"+"\n";
		str=str+"</html>"+"\n";
		writeInToFile(ansFile,str);	
	   }catch(Exception e) {
		   ExceptionsFile.postException("SelfTestProcessing.java","endHtml","Exception",e.getMessage());
		   
	   }
   }


	public void endHtml(float shortAnsMarks) 
	{
		try
		{
			int i=0;
			String str="\n"+"</table>"+"\n"+"<p align='center'>"+"\n";
			str="<input type='hidden' name='shortansmarks' value='"+shortAnsMarks+"'>"+"\n";
			str=str+"\n"+"</form>"+"\n"+"</body>"+"\n";
			str=str+"\n"+"<script>"+"\n"+"var arr=new Array();"+"\n"+"var maxarr=new Array();"+"\n";
			rFile.writeBytes(str);		
			Enumeration e=g.elements();
			Enumeration e1=maxQues.elements();

			while(e.hasMoreElements()) 
			{
				str="arr["+i+"]=\""+e.nextElement()+"\""+"\n";
				str=str+"maxarr["+i+"]=\""+e1.nextElement()+"\""+"\n";
				rFile.writeBytes(str);		
				i++;
			}
		
			str="</script>"+"\n";
			str=str+"\n"+"</html>";
			rFile.writeBytes(str);		
		}	
		catch(Exception e) 
		{
			ExceptionsFile.postException("ExamFunctions.java","endHtml","Exception",e.getMessage());
		}
	}	
	
	public RandomAccessFile createRandomFile(String path){
		RandomAccessFile rFile=null;
		try{
			rFile=new RandomAccessFile(path,"rw");
		}catch(Exception e){
			ExceptionsFile.postException("ExamFunctions.java","createRandomFile","Exception",e.getMessage());
			

		}
		return rFile;
	}

	public void writeInToFile(RandomAccessFile rFile,String str){
	   try{
		   rFile.seek(rFile.length());
		   rFile.writeBytes(str);
	   }catch(IOException e){
		   ExceptionsFile.postException("ExamFunctions.java","writeInToFile","Exception",e.getMessage());
		   
	   }
   }

    public void closeAll(){
		try{
			if(rFile!=null)
				rFile.close();

			if(ansFile!=null)
				ansFile.close();

	   }catch(IOException e){
		   ExceptionsFile.postException("ExamFunctions.java","writeInToFile","Exception",e.getMessage());
		   
	   }

	}

	public void destroy(){
		examId=null;
		
		questions=null;
		responses=null;
		rWeight=null;
		nWeight=null;
		
		groups=null;
		
		totQtns=null;
		ansQtns=null;
		gInst=null;
		gPMarks=null;
		gNMarks=null;
		rFile=null;
		ansFile=null;
	}



};