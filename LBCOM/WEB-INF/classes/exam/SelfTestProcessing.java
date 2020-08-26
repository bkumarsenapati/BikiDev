package exam;
import sqlbean.DbBean;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Object;
import java.util.*;
import java.util.Arrays;
import java.util.Vector;
import java.util.Date;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import coursemgmt.ExceptionsFile;

public class SelfTestProcessing extends HttpServlet {
	int count;
	DbBean con1;
	Connection con;
	PreparedStatement ps;
	Statement st,st1;
	PrintWriter out;
	ResultSet rs,rs1;
	HttpSession session;
	
	String examId,examTable,examType,examName,title;
	String courseId,prevGroupId,cFeedBack,icFeedBack,isSingle;
	String studentId;
	String gradeId;
	String teacherId,schoolId;
	String responseString;
	String answer;
	String qType,qId;
	String schoolPath;
	String stuRes,qBody;
	String ansTable,ansStr,quesList;
	String t,courseName,eType,groupId;
	StringTokenizer qList;
	StringTokenizer resList;
	StringTokenizer temp;
	Vector questions;
	Vector responses;
	Vector answers;
	Vector rWeight;
	Vector nWeight;
	Vector group;    //modified on 6-09-2004 for the sake of grouping
	Hashtable totQtns;
	Hashtable ansQtns;
    Hashtable gInst;
	Hashtable gPMarks;
	Hashtable gNMarks;

	RandomAccessFile rFile;
	
	Vector g;
	Vector maxQues;
	String [][] groupsDet;
	int shortType,m,n,mIndex,nIndex,x,version;
	float marksScored,deductMarks,totalMarks;
	int shortAnsMarks;
	//float marks;
	boolean flage;
	public void init() {
			try{	
					super.init();
			}catch(Exception e){
				ExceptionsFile.postException("SelfTestProcessing.java","init","Exception",e.getMessage());
			}
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
	   
	   ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		title= application.getInitParameter("title");

	   
	   
	   try{	
		    int i;
			//marks=0;
			totalMarks=0;
			marksScored=0;
			deductMarks=0;
			mIndex=0;
			nIndex=0;
			shortAnsMarks=0;
			res.setContentType("text/html");
			out=res.getWriter();
			session=req.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if (session==null) {
				out.println("Your session has expired. Please Login again... <a href='#' onclick=\"top.location.href='/LBCOM/index.jsp'\">Login</a>");
				return;
			}
			
			con1=new DbBean();
					con=con1.getConnection();
					st=con.createStatement();
					st1=con.createStatement();
			count=1;
			studentId=(String)session.getAttribute("emailid");
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");

			gradeId=(String)session.getAttribute("classid");

			ansTable=schoolId+"_"+gradeId+"_"+courseId+"_quesbody";
			examId=req.getParameter("examid");

			shortType=Integer.parseInt(req.getParameter("shorttype"));

			
			courseName=req.getParameter("coursename");
			ansStr=req.getParameter("ansstr");
			isSingle=req.getParameter("issingle");
			questions=new Vector(2,1);
			answers=new Vector(2,1);
			responses=new Vector(2,1);
			rWeight=new Vector(2,1);
			nWeight=new Vector(2,1);
			group=new Vector(2,1);
			maxQues=new Vector(2,1);
			g=new Vector(2,1);
			totQtns=new Hashtable();
			ansQtns=new Hashtable();
			gInst=new Hashtable();
			gPMarks=new Hashtable();
			gNMarks=new Hashtable();
			prevGroupId="";
			x=0;
			rs=st.executeQuery("select exam_name,exam_type,create_date,teacher_id from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");
			if (rs.next()) {
				examTable=schoolId+"_"+examId+"_"+rs.getString("create_date").replace('-','_');
				teacherId=rs.getString("teacher_id");
				examType=rs.getString("exam_type");
				examName=rs.getString("exam_name");
			}
		String path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+".html";
		String dispath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+".html";

				File temp1=new File(path);

				if (temp1.exists()) {
					temp1.delete();
				}
				path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses";
				temp1=new File(path);
				if(!temp1.exists()){
					temp1.mkdirs();
				}
				path=path+"/"+studentId+".html";
				rFile =new RandomAccessFile(path,"rw");
			if (isSingle.equals("true"))
			{
				String quesId=req.getParameter("qid");
				String singleAns=req.getParameter("ans");
				singleAnsProcessing(quesId,singleAns);
				out.println("<script>window.open('"+dispath+"','Results','width=700,height=400,scrollbars=yes');</script>");
				out.println("<script>history.go(-1)</script>");		 		
				return;

			}
			else{
			flage=false;
			getGroups();	
			rs=st.executeQuery("select ques_list,version from "+examTable+" where  student_id='"+studentId+"' and exam_id='"+examId+"'");
			if (rs.next()) {
				quesList=rs.getString("ques_list");
				version=rs.getInt("version");
				qList=new StringTokenizer(quesList,"#");
				responseString=ansStr;
			}
			i=0;
			String grp,cMarks,nMarks;
			while (qList.hasMoreTokens()) {					//reteriving Questions
				temp=new StringTokenizer(qList.nextToken(),":");
				if (temp.hasMoreTokens()) {
					t=temp.nextToken();
					cMarks=temp.nextToken();
					nMarks=temp.nextToken();
					grp=temp.nextToken();
					questions.add(i,t);
					group.add(i,grp);
					if (grp.equals("-")) {
						
						rWeight.add(i,cMarks);
						nWeight.add(i,nMarks);
					}else {
						cMarks=(String)gPMarks.get(grp);
						nMarks=(String)gNMarks.get(grp);
						rWeight.add(i,cMarks);
						nWeight.add(i,nMarks);
					}
				}
				i++;
			}	
			beginHtml();
			responses=tokenize(responseString,questions,"##");
			int ind;
			ListIterator iter = questions.listIterator();
			while (iter.hasNext()) {						//reteriving question ids
				qId=(String)iter.next();
				rs=st.executeQuery("select * from "+ansTable+" where q_id='"+qId+"'");
				if (rs.next()) {
					qBody=QuestionFormat.getQString(rs.getString("q_body"),40);
					qType=rs.getString("q_type");
					answer=QuestionFormat.getAnswer(rs.getString("ans_str"));

					cFeedBack=QuestionFormat.getCFeedback(rs.getString("c_feedback"));					
					icFeedBack=QuestionFormat.getICFeedback(rs.getString("ic_feedback"));					
					
					ind=questions.indexOf(qId);
					stuRes=(String)responses.get(ind);	
					groupId=(String)group.get(ind);
					if ((qType.equals("1"))||(qType.equals("4"))||(qType.equals("5"))) {			//if the question is multiple answer type
						   multipleAnswer(ind,qId,qBody,answer,cFeedBack,icFeedBack,stuRes,groupId);
					}else if (qType.equals("3")) {			//if the question is fill in the blanks
					       fillInTheBlanks(ind,qId,qBody,answer,cFeedBack,icFeedBack,stuRes,groupId);
					}else {
						   singleAnswer(ind,qId,qBody,answer,cFeedBack,icFeedBack,stuRes,groupId);
					}

				}
			}
		getTotalMarks();
		if (marksScored<0) 
			 marksScored=0;
		 
		 int no=0;
		 rs=st.executeQuery("select count(*) from "+examTable+" where student_id='"+studentId+"' and exam_id='"+examId+"'");
		 if (rs.next()) {
			no=rs.getInt(1);	
		 }
	    // st.executeUpdate("update "+examTable+" set count="+no+",status='2',response='"+ansStr+"',marks_secured="+marksScored+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+no);
		ps=con.prepareStatement("update "+examTable+" set count=?,status=?,response=?,marks_secured=? where student_id=? and count=? and exam_id=?");
		//ps.setString(1,examTable);
		ps.setInt(1,no);
		ps.setInt(2,2);
		ps.setString(3,ansStr);
		ps.setFloat(4,marksScored);
		
		ps.setString(5,studentId);
		ps.setInt(6,no);
		ps.setString(7,examId);
			ps.execute();

		 endHtml();
		 rFile.close();
		session.setMaxInactiveInterval(1800);	
		out.println("<script>window.open('"+dispath+"','Results','width=700,height=400,scrollbars=yes');</script>");
        out.println("<script>parent.window.opener.location.href='/LBCOM/exam/StudentExamsList.jsp?start=0&totrecords=&examtype="+examType+"&coursename="+courseName+"';</script>");		 
		out.println("<script>parent.window.close();</script>");	 		
		}
		}catch(Exception e) {
			ExceptionsFile.postException("SelfTestProcessing.java","doPost","Exception",e.getMessage());
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("SelfTestProcessing.java","closing connections","SQLException",se.getMessage());
               }


			}
		
	}


   private void singleAnswer(int q,String qid,String ques,String a,String cfBack,String icFback,String r,String gId) {  
				String str="";
				String value="";
				String feedback="";
				float negMarks=Float.parseFloat((String)nWeight.get(q));
				float posMarks=Float.parseFloat((String)rWeight.get(q));
				float marks=0;
				try {
				if (r.equals(a)){
					value="Correct";
					marks=posMarks;
					feedback=cfBack;
				} else {
					value="Incorrect";
					feedback=icFback;
					if ((r.indexOf('1'))==-1){
						marks=0;  
					}
					else{
						marks=(-1)*negMarks;
						
					}
				}
				
				str=str+" <tr>"+"\n";
				str=str+"   <td width='20%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+count+"</td>"+"\n";
				str=str+"	<td width='30%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"showQtn('"+qid+"','"+ansTable+"'); return false;\">"+ques+"</a></td>"+"\n";
				str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+value+"</td>"+"\n";
				str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"popUpWindow('"+check4Opostrophe(feedback)+"','feedback.bmp','Feedback');\">click</a></td>"+"\n";
				str=str+"  </tr>"+"\n";

				rFile.writeBytes(str);
				setMarks(gId,marks);               
				count++;
				}catch(Exception e) {
					ExceptionsFile.postException("SelfTestProcessing.java","singleAnswer","Exception",e.getMessage());
				}
	}
     private void multipleAnswer(int q,String qid,String ques,String a,String cFBack,String icFBack,String r,String gId) {
				float negMarks=Float.parseFloat((String)nWeight.get(q));
				float posMarks=Float.parseFloat((String)rWeight.get(q));
				int k=0;
				float marks=0;
				int j=0;
				float marksPerAns;
				boolean flage=false;
				String value="",feedback;
				String str="";
				try {
					if (r.equals(a)){				
						marks=posMarks;         
						value="Correct";
						feedback=cFBack;
					} else {						//Question is not attempted
					    value="Incorrect";
						feedback=icFBack;
						if ((r.indexOf('1'))==-1){
							marks+=0;   
						}
						else if ((r.indexOf('0'))==-1) {				//all options are checked
							marks=(-1)*negMarks; 
    					}
						else {			
							
							char ans[]=new char[a.length()];
							a.getChars(0,a.length(),ans,0);
							char res[]=new char[r.length()];
							r.getChars(0,r.length(),res,0);

							for (int i=0;i<ans.length;i++ ) {
								if ((ans[i]==res[i])&&(ans[i]=='1')) { //if one option is correct
									j++;								//no of options are correct
								}else if ( (ans[i]!=res[i]) && ((ans[i]=='0')||(ans[i]=='1')) && (res[i]=='1')) {	
									/* if the option checked is not correct then increment n by one*/
									flage=true;								
								}
									
								if (ans[i]=='1'){						//how any correct options are there for a single questions
									k++;
								}
							}
							marksPerAns=posMarks/(float)k;						//positive marks per one correct answer
						    marks=(j*marksPerAns);  
							if (flage) {
								marks+=(-1)*negMarks;							//if there is any wrong answer
							}
						} 	
						
					}
					str=str+" <tr>"+"\n";
					str=str+"   <td width='20%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+count+"</td>"+"\n";
					str=str+"	<td width='30%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"showQtn('"+qid+"','"+ansTable+"'); return false;\">"+ques+"</a></td>"+"\n";
					//str=str+"	<td width='20%'>&nbsp;"+r+"</td>"+"\n";
					//str=str+"	<td width='20%'>&nbsp;"+a+"</td>"+"\n";
					str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+value+"</td>"+"\n";					
					str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"popUpWindow('"+feedback+"','feedback.bmp','Feedback'); return false;\">click</a></td>"+"\n";

					str=str+"  </tr>"+"\n";
	
					rFile.writeBytes(str);
					setMarks(gId,marks);
					count++;
				}catch(Exception e) {
					ExceptionsFile.postException("SelfTestProcessing.java","multipleAnswer","Exception",e.getMessage());
				}

	}

		private void fillInTheBlanks(int q,String qid,String ques,String a,String cFBack,String icFBack,String r,String gId) {
				float negMarks=Float.parseFloat((String)nWeight.get(q));
				float posMarks=Float.parseFloat((String)rWeight.get(q));
				int j=0;
				int k=0;
				float marksPerAns,marks=0;
				boolean flage=false;
				String value="",feedback;
				String str="";
				try {
					a=a.trim();
					r=r.trim();
					if (r.equalsIgnoreCase(a)){								//response matches with correct answer
						marks=posMarks;    
						value="Correct";
						feedback=cFBack;
					} else if (r.equals("")) {						//if the question is not attempted
						marks=0;        
						value="Incorrect";
						feedback=icFBack;
					}
					else {				
						value="Incorrect";
						feedback=icFBack;
						StringTokenizer ans=new StringTokenizer(a,",");
						StringTokenizer res=new StringTokenizer(r,",");
						String t;
						while(ans.hasMoreTokens()) {	
							if((ans.nextToken()).equalsIgnoreCase(res.nextToken())) { 
							
							     /*if one reponse per question  is correct  */
    							   j++;
							}else {									//if the attempted answer is wrong
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
					str=str+" <tr>"+"\n";
					str=str+"   <td width='20%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+count+"</td>"+"\n";
					str=str+"	<td width='30%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"showQtn('"+qid+"','"+ansTable+"'); return false;\">"+ques+"</a></td>"+"\n";
					//str=str+"	<td width='20%'>&nbsp;"+r+"</td>"+"\n";
					//str=str+"	<td width='20%'>&nbsp;"+a+"</td>"+"\n";
					str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+value+"</td>"+"\n";

					str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"popUpWindow('"+check4Opostrophe(feedback)+"','feedback.bmp','Feedback'); return false;\">click</a></td>"+"\n";

					
					str=str+"  </tr>"+"\n";

					rFile.writeBytes(str);
					
					setMarks(gId,marks);
					count++;
				}catch(Exception e){
					ExceptionsFile.postException("SelfTestProcessing.java","fillInTheBlanks","Exception",e.getMessage());
				}



	}
	private Vector tokenize(String s,Vector q,String delim) {
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
		while((index1=s.indexOf(delim,startIndex))>-1) {
			temp=s.substring(startIndex,index1);
			
			st=(String)l.next();
			ind1=q.indexOf(st);
			
			v.add(ind1,temp);
			startIndex=index1+delimLen;
		}
		if (startIndex<strLen) {
			temp=s.substring(startIndex,strLen);
 			
			st=(String)l.next();
			ind1=q.indexOf(st);
			v.add(temp);
		}
	}catch(Exception e) {
		ExceptionsFile.postException("SelfTestProcessing.java","tokenize","Exception",e.getMessage());
	}
	return(v);


	}
	
	private void getGroups() {
		String gId,totQues,ansQues,inst,cMarks,nMarks;
		try{
		
			rs.close();
			rs=st.executeQuery("select * from "+schoolId+"_"+examId+"_group_tbl group by group_id ");
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
			ExceptionsFile.postException("SelfTestProcessing.java","getGroups","Exception",e.getMessage());
		}
		
	}

	private void setMarks(String gId,float mrks) {
		try{

			 groupsDet[mIndex][0]=gId;
			 groupsDet[mIndex][1]=String.valueOf(mrks);
			 mIndex++;
			 
		}catch(Exception e) {
			ExceptionsFile.postException("SelfTestProcessing.java","setMarks","Exception",e.getMessage());
		}
   }

   private void getTotalMarks() {
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

			  ind=group.indexOf(key);	
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
		ExceptionsFile.postException("SelfTestProcessing.java","getTotalMarks","Exception",e.getMessage());
	  }
   }
   private void beginHtml() {
		try{
			String str="";
			str=str+"<html>"+"\n";
			str=str+"<head>"+"\n";
			str=str+"<meta http-equiv='Content-Language' content='en-us'>"+"\n";
			str=str+"<meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>"+"\n";
			str=str+"<meta name='GENERATOR' content='Microsoft FrontPage 4.0'>"+"\n";
			str=str+"<meta name='ProgId' content='FrontPage.Editor.Document'>"+"\n";
			str=str+"<title>"+title+"</title>"+"\n";
			str=str+"<script language='javascript' src='/LBCOM/validationscripts.js'></script>";
			str=str+"<script>"+"\n";
			str=str+"	function showQtn(qId,qnTbl){"+"\n";
			str=str+"		var w=window.open(\"/LBCOM/exam/ShowQuestion.jsp?qid=\"+qId+\"&qntbl=\"+qnTbl,'Question','width=600,height=300,scrollbars=yes');"+"\n";
			str=str+"       w.focus()"+"\n";
		    str=str+"	}"+"\n";
			str=str+"   function showFeedBack(feedback){"+"\n";
			str=str+"     alert(feedback);"+"\n";
			str=str+"   }"+"\n";
			str=str+"</script>"+"\n";
			str=str+"</head>"+"\n";
			str=str+"<body>"+"\n";
			str=str+"<form>"+"\n";
			str=str+"<table border='0' width='100%'>"+"\n";
			str=str+"<tr>"+"\n";
			str=str+"<td width='100%'bgcolor='#E08040' align='center'><b><font face='Arial' size='2'><b>"+"Performance"+"\n";
			str=str+"</b></font></td>"+"\n";
			str=str+"</tr></table>"+"\n";
			str=str+"<table border='1' width='100%'>"+"\n";
			str=str+"   <tr>"+"\n";
			str=str+"      <td colspan='4' bgcolor='#E08040' align='left'><b><font face='Arial' size='2'>Exam Name: "+examName+"\n";
			str=str+"       <td>"+"\n";
			str=str+"    <tr>"+"\n";
			str=str+"<td width='20%' bgcolor='#dbd9d5'><b><font face='Arial' color='#000080' size='2'>Qno</td>"+"\n";
			str=str+"<td width='30%' bgcolor='#dbd9d5'><b><font face='Arial' color='#000080' size='2'>Question</td>"+"\n";
			//str=str+"<td width='20%'>Your Answer</td>"+"\n";
			//str=str+"<td width='20%'>Correct Answer</td>"+"\n";
			str=str+"<td width='25%' bgcolor='#dbd9d5'><b><font face='Arial' color='#000080' size='2'>Correct/Incorrect</td>"+"\n";
			str=str+"<td width='25%' bgcolor='#dbd9d5'><b><font face='Arial' color='#000080' size='2'>Feed Back</td>"+"\n";
			str=str+"</tr>"+"\n";
			rFile.writeBytes(str);
		}catch(Exception e){
			ExceptionsFile.postException("SelfTestProcessing.java","beginHtml","Exception",e.getMessage());
		}

   }

   private void endHtml() {
	   try{


		String str="";
		str="\n"+"</table>"+"\n";
		if(!isSingle.equals("true")){
			str=str+"<p align='center'><font face='Arial' color='#A22BAE' size='2'<b>"+"\n";
			str=str+"   Marks="+marksScored+"/"+totalMarks+"\n"+"</b></font>"+"\n";
		}

		str=str+"\n"+"</form>"+"\n"+"</body>"+"\n";
		str=str+"\n"+"</html>";
		rFile.writeBytes(str);		
	   }
	   catch(Exception e) {
		   ExceptionsFile.postException("SelfTestProcessing.java","endHtml","Exception",e.getMessage());
	   }
   }
   private void singleAnsProcessing(String ques,String res){
	  try{
	   int type;
	   String singleAns,quesBody,corFBack,incorFBack,quesType;
	   String value="",feedback="",str="";
	   rs=st.executeQuery("select * from "+ansTable+" where q_id='"+ques+"'");
	   if(rs.next()){
		   quesBody=QuestionFormat.getQString(rs.getString("q_body"),40);
		   quesType=rs.getString("q_type");
		   singleAns=QuestionFormat.getAnswer(rs.getString("ans_str"));
           corFBack=QuestionFormat.getCFeedback(rs.getString("c_feedback"));					
		   incorFBack=QuestionFormat.getICFeedback(rs.getString("ic_feedback"));					
		   beginHtml();
		   if (singleAns.equalsIgnoreCase(res))
		   {

			value="correct";
			feedback=corFBack;
		   }
		   else{
			   value="Incorrect";
			   feedback=incorFBack;
		   }
		   str=str+" <tr>"+"\n";
           str=str+"   <td width='20%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;1</td>"+"\n";
		   str=str+"	<td width='30%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"showQtn('"+ques+"','"+ansTable+"'); return false;\">"+ques+"</a></td>"+"\n";
		   str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;"+value+"</td>"+"\n";					
		   str=str+"	<td width='25%' bgColor='#e7e7e7'><font face='Arial' color='#A22BAE' size='2'>&nbsp;<a href='#' onclick=\"popUpWindow('"+check4Opostrophe(feedback)+"','feedback.bmp','Feedback'); return false;\">click</a></td>"+"\n";
           str=str+"  </tr>"+"\n";
	       rFile.writeBytes(str);
		   endHtml();
		   rFile.close();
	   }
	  }catch(Exception e){
		  ExceptionsFile.postException("SelfTestProcessing.java","singleAnsProcessing","Exception",e.getMessage());
	  }
			
   }
    public static String getQString(String str){

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
			ExceptionsFile.postException("SelfTestProcessing.java","getQString","Exception",e.getMessage());
		}

		return  qStr;
   } 
   private String check4Opostrophe(String s)
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
