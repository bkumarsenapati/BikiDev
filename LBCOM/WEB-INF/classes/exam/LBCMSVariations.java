package exam;
import sqlbean.DbBean;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import coursemgmt.ExceptionsFile;
public class  LBCMSVariations extends HttpServlet
{
	public void init(ServletConfig conf) {
		try{
			super.init(conf);
		}
		catch (Exception e)
		{
			ExceptionsFile.postException("Variations.java","init","Exception",e.getMessage());
		}
		
	}
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LBCMSExamPaper examPaper=null;
		Hashtable qList=null,questionsList=null,sortedList=null;
		Vector list=null;
        try{

		    res.setContentType("text/html");
			PrintWriter out=res.getWriter();
			HttpSession session=req.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if (session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String versionTable=null,examType=null,queryString=null,createDate=null,questionString=null,ques=null;
			String examName="",teacherId=null,schoolId=null,classId=null,courseId=null,examId=null,courseName=null,qtnTbl=null;
			String schoolPath=null;
			int random=0,sort=0,variations=0,size=0,noOfGrps=0;
			
			ServletContext application = getServletContext();
		    schoolPath = application.getInitParameter("schools_path");
			teacherId =(String)session.getAttribute("emailid");
			schoolId  =(String)session.getAttribute("schoolid");
			courseName=(String)session.getAttribute("coursename");
			courseId=(String)session.getAttribute("courseid");
			
			classId=(String)session.getAttribute("classid");
						
			db=new DbBean();
			examPaper=new LBCMSExamPaper();	

			con=db.getConnection();
			st=con.createStatement();

			examId=req.getParameter("examid");
			examType=req.getParameter("examtype");
			
			String[] exam_id=examId.split(",");
			String[] exam_type=examType.split(",");

			noOfGrps=Integer.parseInt(req.getParameter("noofgrps"));

			random=Integer.parseInt(req.getParameter("random1"));						

			variations=Integer.parseInt(req.getParameter("variations"));

			sort=Integer.parseInt(req.getParameter("sort1"));



			qList=new Hashtable();
			sortedList=new Hashtable();
			questionsList=new Hashtable();
			Hashtable groupQuesList=new Hashtable();
			
			qtnTbl=schoolId+"_"+classId+"_"+courseId+"_quesbody";

			
			//versionTable=schoolId+"_"+examId+"_versions_tbl_tmp";

			//st.executeUpdate("update exam_tbl_tmp set random_wise="+random+",versions="+variations+",type_wise="+sort+",group_status=2,status='4' where exam_id='"+examId+"' and school_id='"+schoolId+"'");
			
			//st.executeUpdate("delete from "+schoolId+"_"+examId+"_versions_tbl_tmp");

			for(int qt=0;qt<exam_id.length;qt++)
			{
				exam_id[qt]=exam_id[qt];
				exam_type[qt]=exam_type[qt];
				
			rs=st.executeQuery("select * from exam_tbl where exam_id='"+exam_id[qt]+"' and school_id='"+schoolId+"'");
			while (rs.next()){
				createDate=rs.getString("create_date").replace('-','_');	
				questionString=rs.getString("ques_list");	
			}
			size=getSize(questionString);
			questionsList=getQuestionsList(questionString);
			groupQuesList=formQuestion(questionString);
			if (random==1)
			{
				for(int i=0;i<variations;i++){
					queryString="";
					if(sort==1){
						String grp="";
						String grp1="-";
						Enumeration e=groupQuesList.keys();
						while(e.hasMoreElements()){
							grp=(String)e.nextElement();
						}
					    if((sort==1)&&((groupQuesList.size()==1)&&(groupQuesList.containsKey(grp)))){
							//queryString=sortQuesWise(st,rs,questionsList,schoolId,classId,courseId);
							sortedList=sortQuesWise(st,rs,questionsList,schoolId,classId,courseId);
							//queryString=getSortedQuesString(ques,list);
							//sortedList=getSortedHashtable(ques,list);
							queryString=randomize(sortedList);
						}
						else{
							queryString=randomize(groupQuesList);
     						queryString=sortGroupWise(queryString,size);
						}

					}else{
						queryString=randomize(groupQuesList);
						queryString=sortGroupWise(queryString,size);
					}
					qList.put(Integer.toString((i+1)),queryString);
					//st.addBatch("insert into "+versionTable+" (ver_no,ques_list) values("+(i+1)+",'"+queryString+"')");
				}
				
			}
			else{
				if(sort==1){
					String grp="";
					String grp1="-";
					Enumeration e=groupQuesList.keys();
					Hashtable temp=new Hashtable();
					while(e.hasMoreElements()){
						grp=(String)e.nextElement();
					}
					if((sort==1)&&((groupQuesList.size()==1)&&(groupQuesList.containsKey(grp)))){
						//queryString=sortQuesWise(st,rs,questionsList,schoolId,classId,courseId);
						sortedList=sortQuesWise(st,rs,questionsList,schoolId,classId,courseId);
						//queryString=getSortedQuesString(ques,list);
						//sortedList=getSortedHashtable(ques,list);
					}
					else{
						queryString=sortGroupWise(questionString,size);
					}
				}else{
					//queryString=questionString;
					queryString=sortGroupWise(questionString,size);
				}
				
				//st.addBatch("insert into "+versionTable+" (ver_no,ques_list) values(1,'"+queryString+"')");
				qList.put("1",queryString);
			}
			//st.executeBatch();	
						
				examPaper.setPaper(qList,exam_id[qt],size,teacherId,qtnTbl,schoolId,courseId,courseName,schoolPath,0);	
			}
			out.println("<script>");
			//out.println("window.location.href=\"/LBCOM/coursemgmt/teacher/AsgnFrames.jsp?totrecords=&start=0&checked=&unchecked&cat=edit&workid="+examId+"&docname="+examName+"\";");
			//out.println("parent.parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status=4&editMode=edit&examId="+exam_id[qt]+"&examName="+exam_name[qt]+"&examType="+exam_type[qt]+"&noOfGrps="+noOfGrps+"\";");
			out.println("window.location.href=\"/LBCOM/coursedeveloper/ImpAsessmetns.jsp?totrecords=&start=0&checked=&unchecked&cat=edit&workid="+examId+"&docname="+examName+"\";");
			out.println("</script>");		

		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","doPost","Exception",e.getMessage());
		}finally{
			try{
				 if(st!=null)
					 st.close();
				 if (con!=null && !con.isClosed()){
					 con.close();
				 }
				 qList=null;
				 questionsList=null;
				 sortedList=null;
               }catch(SQLException se){
				        ExceptionsFile.postException("Variations.java","closing connections","SQLException",se.getMessage());
               }
		}
	}

	private String sortGroupWise(String quesString,int size){
		try	{
			StringTokenizer stkQ=new StringTokenizer(quesString,"#");
			String questionList[]=new String[size];
			String temp;
			int i=0;
			while(stkQ.hasMoreTokens()){
				questionList[i++]=stkQ.nextToken();
			}
			int qtnsListLen=questionList.length;//questions length
			for(i=0;i<qtnsListLen-1;i++){
				for(int j=i+1;j<qtnsListLen;j++){
					if(questionList[i].charAt(questionList[i].length()-1)>questionList[j].charAt(questionList[j].length()-1)){
							temp=questionList[i];
							questionList[i]=questionList[j];
							questionList[j]=temp;
						}
					}
			}
			quesString="";
			for(i=0;i<qtnsListLen;i++){
				quesString+=questionList[i]+"#";
			}
					
		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","sortGroupWise","Exception",e.getMessage());
		}
		return quesString;
	}
	private String randomize(Hashtable quesList){
		String qString="";
		try{
			String grp,temp;
			StringTokenizer stk;
			Enumeration qtns,grpEle;
			Vector questions=new Vector(2,1);
			grpEle=quesList.keys();
			while(grpEle.hasMoreElements()){
				questions.clear();
				grp=(String)grpEle.nextElement();
				stk=new StringTokenizer((String)quesList.get(grp),"#");
				while(stk.hasMoreTokens()){
					temp=stk.nextToken();
					questions.add(temp);
					Collections.shuffle(questions);
				}
				qtns=questions.elements();
				while(qtns.hasMoreElements()){
					qString+=(String)qtns.nextElement()+"#";
				}
			}
		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","randomize","Exception",e.getMessage());
		}
		return qString;
	}
	private int getSize(String quesString){
		int size=0;
		StringTokenizer stkQues=null;
		try{
			stkQues=new StringTokenizer(quesString,"#");
			size=stkQues.countTokens();
		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","getSize","Exception",e.getMessage());
		}finally{
			stkQues=null;
		}
		return size;
	}
	private Hashtable getQuestionsList(String quesString){
		Hashtable quesList=null;
		StringTokenizer stkQues=null;
		String ques,grp,tmp,qId;
		boolean flag=false;
		try{
			tmp="";
			quesList=new Hashtable();
			stkQues=new StringTokenizer(quesString,"#");
			//size=stkQues.countTokens();
			while(stkQues.hasMoreTokens()){
				ques=stkQues.nextToken();	
				grp=ques.substring(ques.lastIndexOf(':'));	
				qId=ques.substring(0,ques.indexOf(':'));	
				quesList.put(qId,ques);
			}
		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","getQuestionsList()","Exception",e.getMessage());
		}finally{
			stkQues=null;
		}
		return quesList;

	}
	private Hashtable formQuestion(String quesString){
		Hashtable grpsList=new Hashtable();
		String ques,grp,tmp,qId;
		boolean flag=false;
		try
		{
			tmp="";
			StringTokenizer stkQues=new StringTokenizer(quesString,"#");
			//size=stkQues.countTokens();
			while(stkQues.hasMoreTokens()){
				ques=stkQues.nextToken();	

				grp=ques.substring(ques.lastIndexOf(':'));	
				qId=ques.substring(0,ques.indexOf(':'));	
			//	questionsList.put(qId,ques);
				if (grpsList.containsKey(grp)) 
				{
					tmp=(String)grpsList.get(grp);
					//tmp=tmp+ques+"#";	
					tmp=tmp+ques+"#";	
				}else{
					tmp=ques+"#";
				}
					
				grpsList.put(grp,tmp);
			}

		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","formQuestion","Exception",e.getMessage());
		}
		return grpsList;
	}

	private Hashtable sortQuesWise(Statement st,ResultSet rs,Hashtable questionsList,String schoolId,String classId,String courseId){
		String qid,tmp,qtype,q="";
		StringBuffer queryString=new StringBuffer();
		Enumeration ele=questionsList.keys();
		Hashtable ques=new Hashtable();
		Hashtable sortedList=null;
		boolean flg=false;
		try{
			tmp="";
			while(ele.hasMoreElements()){
				if(flg==true)
					queryString.append(" or q_id='"+ele.nextElement()+"'");
				else
					queryString.append("q_id='"+ele.nextElement()+"'");
				flg=true;
			}
			//if there are questions in the group '-'
			if(queryString.length()>0){
				//rs=db.execSQL("select q_id,q_type from "+classId+"_"+courseId+"_quesbody where ("+queryString+")");
				rs=st.executeQuery("select q_id,q_type from "+schoolId+"_"+classId+"_"+courseId+"_quesbody where ("+queryString+")");
				while(rs.next()){
					qid=rs.getString("q_id");
					qtype=rs.getString("q_type");
					if(ques.containsKey(qtype)){
						tmp=(String)ques.get(qtype)+(String)questionsList.get(qid)+"#";
					}else{
						tmp=questionsList.get(qid)+"#";
					}
					ques.put(qtype,tmp);
				}

			}
			//q=sorting(ques);
			Vector list=getSortedList(ques);
			//q=getSortedQuesString(ques,list);
		    sortedList=getSortedHashtable(ques,list);

				

		}catch(Exception e){
			ExceptionsFile.postException("Variations.java","sortQuesWise","Exception",e.getMessage());
		}
		return sortedList;
		//return ques;
	  }
	 /* private String sorting(Hashtable qList){
		Enumeration ele=qList.keys();
		Vector list=new Vector(2,1);
		String tmp;
		while(ele.hasMoreElements()){
				list.add(ele.nextElement());
		}
		Collections.sort(list);
		ele=list.elements();
		String i;
		String q="";
		while(ele.hasMoreElements()){
		    i=(String)ele.nextElement();
			sortedList.put(i,qList.get(i));
			q+=qList.get(i);
		}
		return q;
	  }*/

	  private Vector getSortedList(Hashtable qList){
		  Vector list=null;
		  try{
			Enumeration ele=qList.keys();
			list=new Vector(2,1);
			String tmp;
			while(ele.hasMoreElements()){
					list.add(ele.nextElement());
			}
			Collections.sort(list);
		 }catch(Exception e){
				ExceptionsFile.postException("Variations.java","getSortedList","Exception",e.getMessage());
		 }

		return list;
	  }
	  private String getSortedQuesString(Hashtable qList,Vector list){
		  String q="";
		  try{
			Enumeration ele=list.elements();
			String i;
			
			while(ele.hasMoreElements()){
				i=(String)ele.nextElement();
			//	sortedList.put(i,qList.get(i));
				q+=qList.get(i);
			}
		  }catch(Exception e){
				ExceptionsFile.postException("Variations.java","getSortedQuesString","Exception",e.getMessage());
		  }
		return q;
	  }
	  private Hashtable getSortedHashtable(Hashtable qList,Vector list){
		  Hashtable sortedList=null;
		  try{
			  Enumeration ele=list.elements();
			  String i;
			  String q="";
			  
			 // Hashtable qList=new Hashtable();
			  sortedList=new Hashtable();

			  while(ele.hasMoreElements()){
				i=(String)ele.nextElement();
				sortedList.put(i,qList.get(i));
				q+=qList.get(i);
			  }
		  }catch(Exception e){
				ExceptionsFile.postException("Variations.java","getSortedHashtable","Exception",e.getMessage());
		  }
		  return sortedList;
	  }
	  
}
