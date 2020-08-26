<%@ page import="java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>
<%@page import="java.io.*,java.sql.*,java.util.*,java.util.StringTokenizer,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Connection conObj=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
	String examId=null,examName="",studentId=null,stuTblName="";
	int attempts=0;
	int version=1;
	Vector questions=null;
	ExamFunctions ef=null;
	Vector responses=null;
	Vector groups=null;  
	ArrayList oAList=null,oLList=null,oRList=null,optStr=null;
	
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	//Santhosh from here
	String teacherId="";
	String examType="",marksScheme="",status="",count="",totalMarks="";
	String shortAnsMarks="";
	//Santhosh upto here
	String type="",qtnTbl="";
	String quesList="",responseString="";
	String cFeedBack="";
		String icFeedBack="";
		String qBody="";
	String answer="";
		String qId="",uId="";
		String stuRes="",title1="";
		String ansStr="",groupId="",questionId="";
		String difficultLevel="",estimatedTime="",timeScale="",qT="",questionType="",qid="";
		 String sessid="",fText="",cFeedback="",icFeedback="",hint="";
		String bgclr="";
		int ind=0;
		int eCredit=0;
		int nstat=0,qType=0;
		boolean flage=false,flagFill=false;

	String lessonId="",lessonName="",asgnId="",asgnName="",assessId="",assessName="";
	String crctAns="",crctAns1="",qnColor="";
	String unitIds="",lessonIds="",asgnIds="",assessIds="",unitId="",unitName="";
	String chkStatus="";
	String distributedIds="";
	String cbCourseId="";

	
	examId=request.getParameter("examid");
	if(request.getParameter("type")==null || request.getParameter("type").trim().equals(""))
	{
		type="";
	}
	else 
	{
		type=request.getParameter("type");
	}
	
	if(type.equals("student"))
	{
		studentId=request.getParameter("studentid");
		version=Integer.parseInt(request.getParameter("version"));
		attempts=Integer.parseInt(request.getParameter("attempts"));
		stuTblName=request.getParameter("stuTblName");
		examName=request.getParameter("examname");
		//Santhosh from here
		examType=request.getParameter("examtype");
		marksScheme=request.getParameter("scheme");
		status=request.getParameter("status");
		count=request.getParameter("count");
		totalMarks=request.getParameter("totalmarks");
		shortAnsMarks=request.getParameter("shortansmarks");
		//Santhosh upto here
	}
	String mode="";
	if(request.getParameter("mode")==null)
		mode="act";
	else
		mode="tmp";
	//puts the values of classid,coursename,courseid in the session
		session.setAttribute("submissionNo",request.getParameter("attempts"));
		session.setAttribute("version",request.getParameter("version"));
		session.setAttribute("stuTblName",stuTblName);
		session.setAttribute("marksScheme",marksScheme);
		session.setAttribute("totalMarks",totalMarks);
		String classId=(String)session.getAttribute("classid");
		String courseId=(String)session.getAttribute("courseid");
		String schoolId=(String)session.getAttribute("schoolid");
		String ansTable=schoolId+"_"+classId+"_"+courseId+"_quesbody";
		teacherId=request.getParameter("teacherid");
		String examTable=stuTblName;
		questions=new Vector(2,1);
		ef=new ExamFunctions();		

%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest</title>
<SCRIPT LANGUAGE="JavaScript">

function distribute()
{
	
	var lid=new Array();
	var uid=new Array();
	var asgnid=new Array();
	var assessid=new Array();

	with(document.distribution)
	{
		for(var i=0,j=0; i < elements.length; i++) 
		{
			if(elements[i].type == 'checkbox' && elements[i].checked==true)
			{
				if(elements[i].name == 'lids')
				{
					lid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'uids')
				{
					uid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'asgnids' )
				{
					asgnid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'assessids' )
				{
					assessid[j++]=elements[i].value;								
				}
			}
		}
	}
	if (j>0)
	{
		//window.location.href="/LBCOM/pretest/MakeDistribution1.jsp?courseid=<%=courseId%>&studentids=<%=studentId%>&unitids="+uid+"&lessonids="+lid+"&workids="+asgnid+"&assessids="+assessid;
		//return false;
    }
	else
	{
		alert("Please select the file(s) to be assigned");
		return false;
    }
}

</script>
</head>
<body>
<form name="distribution" method="POST" ACTION="/LBCOM/pretest/MakeDistribution1.jsp?courseid=<%=courseId%>&studentids=<%=studentId%>" onSubmit="return distribute();">
<table>

<%
	try
	{
		con=con1.getConnection();
		//conObj=db.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		
		
		 rs1=st1.executeQuery("select max(count) as count,ques_list,version,password,response from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count=1 group by student_id");
		 if(rs1.next())
		{
			quesList=rs1.getString("ques_list");
			
			responseString=rs1.getString("response");
		}
		rs1.close();
		ef.setObjects(quesList);
		questions=ef.getQuestions();
		responses=ef.tokenize(responseString,questions,"##");
		ef.setResponses(responses);
		int qNo=0;
		ListIterator iter = questions.listIterator();
			try
			{
			while (iter.hasNext()) 		//retreiving question ids
			{
				qNo++;
				qId=(String)iter.next();
				rs=st.executeQuery("select * from "+ansTable+" where q_id='"+qId+"'");
				if (rs.next())
				{
					qBody=QuestionFormat.getQString(rs.getString("q_body"),50);
					answer=QuestionFormat.getAnswer(rs.getString("ans_str"));
					ind=questions.indexOf(qId);
					//System.out.println("answer..."+answer);
					qT=rs.getString("q_type");
					if(qT.equals("0"))
						questionType="Multiple choice";
					if(qT.equals("1"))
						questionType="Multiple answers";
					if(qT.equals("2"))
						questionType="Yes/No";
					if(qT.equals("3"))
						questionType="Fill in the blanks";
					if(qT.equals("4"))
						questionType="Matching";
					if(qT.equals("5"))
						questionType="Ordering";
					if(qT.equals("6"))
						questionType="Short/Essay-type";
				
					qType=Integer.parseInt(qT);
					qtnTbl=ansTable;
					
				conObj=db.getConnection();

				QuestionBody qtnBody=new QuestionBody();
				qtnBody.setConnection(conObj);
				qtnBody.setTblName(qtnTbl);	
				
				ArrayList qoAList=qtnBody.getQBody(qId);
				qType=qtnBody.getQType();
				hint=QuestionFormat.getHint(qtnBody.getHint());
				cFeedback=QuestionFormat.getCFeedback(qtnBody.getCFeedback());
				icFeedback=QuestionFormat.getICFeedback(qtnBody.getICFeedback());
				difficultLevel=qtnBody.getDifficultLevel();
				estimatedTime=qtnBody.getEstimatedTime();
				timeScale=qtnBody.getTimeScale();
				if(estimatedTime!=null )
					estimatedTime+="&nbsp;"+timeScale;
				else
					estimatedTime="-";
				/*
				ansStr=QuestionFormat.getAnswer(qtnBody.getAnsStr());
				System.out.println("***************ansStr......."+ansStr);

				int len=ansStr.length();
				System.out.println("length...."+len);
				char char1=ansStr.charAt(1);
				System.out.println("char1..."+char1);
				*/


		

				Question qtn=new Question();					
				qtn.setQBody(qoAList);	
				qtn.setQType(qType);

			
				ArrayList qAList =qtn.getQuestionString();	

				stuRes=(String)responses.get(ind);
				//System.out.println("Student Response...."+stuRes);
				
				st5=con.createStatement();
				rs5=st5.executeQuery("select * from pretest_lms where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+qId+"'");
				if(rs5.next())
				{
					
					cbCourseId=rs5.getString("cb_courseid");
					unitIds=rs5.getString("unit_ids");
					distributedIds=rs5.getString("lesson_ids")+","+rs5.getString("assignment_ids")+","+rs5.getString("assessment_ids");
					lessonIds=rs5.getString("lesson_ids");
					if(unitIds==null || unitIds.equals("null"))
					{
						unitIds="";
					}
					if(lessonIds==null || lessonIds.equals("null"))
					{
						lessonIds="";
					}

					asgnIds=rs5.getString("assignment_ids");
					if(asgnIds==null || asgnIds.equals("null"))
					{
						asgnIds="";
					}

					assessIds=rs5.getString("assessment_ids");
					if(assessIds==null || assessIds.equals("null"))
					{
						assessIds="";
					}
					
				}
				rs5.close();
				st5.close();
			

				if(qType==0)
				{
							

					oAList=qtn.getOptionStrings();
					int i=0,j=0;
					String opn="";
					String fOptn="";

					char caseChar;
					int idx=0;
					fOptn="";
					//System.out.println("oAList..."+oAList);
					if(answer.equals(stuRes))
					{
						bgclr="green";
					}
					else
					{
						bgclr="red";
					}

					%>
					<table>
						<tr>
							<td><%=qNo%>.<td bgcolor=<%=bgclr%>><%=qBody%></td></tr>
					<%
					//fText=QuestionFormat.getFormattedOpnBdyForMCAndMA(oAList,qType,questionId,questionId);
					for(j=0;j<oAList.size();j++)
					{
						int len=stuRes.length();
						char char1=stuRes.charAt(j);
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
							fOptn=opn.substring( idx+2 );	
							
							
							//System.out.println("fOptn...."+fOptn);
							%>
							<tr>
							<%
								if(char1=='0')
								{
							%>
									<td><input type="radio"><%=fOptn%></td>
							<%
							}
							else
							{
								%>
								<td><input type="radio" checked><%=fOptn%></td>
							<%
							}
							%>
								</tr>
							<%
							break;
						default:
						fOptn=opn;			
						}			
					}	
				}
					
				if(qType==1)
				{
					oAList=qtn.getOptionStrings();
					int k=0;
				String opnTF="";
				String fOptnTF="";

					char caseCharTF;
					int idxTF=0;
					fOptnTF="";

					for(k=0;k<oAList.size();k++)
					{

						opnTF=oAList.get(k).toString().trim();
						caseCharTF=opnTF.charAt(0);
						switch (caseCharTF)
						{
							case '#':
								idxTF=opnTF.indexOf("##",2);
								if (fOptnTF.length()!=0)
								{
									fOptnTF=fOptnTF+"</td></tr>"+"\n";
								}
								fOptnTF=opnTF.substring( idxTF+2);	
								//System.out.println("fOptnTF...."+fOptnTF);
								break;
							default:
								fOptnTF=opnTF;			
					}				
				}	
					//fText=fText+QuestionFormat.getFormattedOpnBdyForTF(oAList,qType,questionId,questionId);
					
				}
				if(qType==2)
				{
							

					oAList=qtn.getOptionStrings();
					int i=0,j=0;
					String opn="";
					String fOptn="";

					char caseChar;
					int idx=0;
					fOptn="";
					if(answer.equals(stuRes))
					{
						bgclr="green";
					}
					else
					{
						bgclr="red";
					}

					%>
					<table>
						<tr>
							<td><%=qNo%>.<td><%=qBody%></td></tr>
					<%
					//fText=QuestionFormat.getFormattedOpnBdyForMCAndMA(oAList,qType,questionId,questionId);
					for(j=0;j<oAList.size();j++)
					{
						int len=stuRes.length();
						char char1=stuRes.charAt(j);
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
							fOptn=opn.substring( idx+2 );	
							
							
							//System.out.println("fOptn...."+fOptn);
							%>
							<tr>
							<%
								if(char1=='0')
								{
							%>
									<td><input type="checkbox"><%=fOptn%></td>
							<%
							}
							else
							{
								%>
								<td><input type="checkbox" checked><%=fOptn%></td>
							<%
							}
							%>
								</tr>
							<%
							break;
						default:
						fOptn=opn;			
						}			
					}	
				}

				if(qType==3)
				{
					qBody=qBody.replaceAll("__________","");

					%><table><tr><td><%=qNo%>.<td><td><%=qBody%></td></tr><tr><td><input type="text" value=<%=stuRes%>></td></tr></table><%
				}



				if(qType==4)
				{
					oLList=qtn.getLOptionStrings();
					oRList=qtn.getROptionStrings();
					int j;
					String opn;
					String fOptn,rOptn;
					String rStr;
					String fStr;

					char caseChar;
					int idx;
					//fStr="<table border='0' width='600' height='61' cellspacing='1' cellpadding='0' bordercolorlight='#BEC9DE'><tr>"+"\n";

					
						//rOptn=getListBox(oRList,qId,qNo);
						if(answer.equals(stuRes))
							{
								bgclr="green";
							}
							else
							{
								bgclr="red";
							}




				%><table>
						<tr>
							<td><%=qNo%>.<td bgcolor=<%=bgclr%>><%=qBody%></td></tr><%
				for(j=0;j<oLList.size();j++)
				{
					char lenMO=stuRes.charAt(j);
					opn=oLList.get(j).toString().trim();
					rStr=oRList.get(j).toString().trim();
					caseChar=opn.charAt(0);

					switch (caseChar)
					{
						case '#':			
							
						fOptn=opn.substring(2,opn.indexOf(".")+1);
							rOptn=opn.substring(opn.indexOf(".")+3);

							%><td valign='top' width='15'><font face='Arial' size='2' align='center'><%=rStr.substring(2,4)%></td>
							<td valign='top' width='167'><font face='Arial' size='2' align='left'><%=rStr.substring(6)%></td>
							<td valign='top' align='left' width='245' align='left'><font face='Arial' size='2'><%=rOptn%><select><option value='<%=lenMO%>' selected><%=lenMO%></option></select></td></tr>

							<%
							
					}				
		
				}		
	
							//fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,oRList,qType,questionId,questionId);
					out.println("MT...fText...."+fText);
					%></table><%
				
				}
			if(qType==5)		//  Ordering
			{				
					oLList=qtn.getLOptionStrings();						
					fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,null,qType,questionId,questionId);
					
			}
			if(qType==6)// Short type questions
			{
					float f=0.0f;
					String gid="-";

					%><table>
						<tr>
							<td><%=qNo%>.<td><td><%=qBody%></td></tr><br>
							<tr><td><textarea rows='5' cols='86'  name="SE<%=qNo%>"><%=stuRes%></textarea></td></tr>
							</table>
							<%
					//fText=fText+QuestionFormat.getFormattedOpnBdyForST(qId,qType,questionId,f,gid);
					
			}
	}

%>
<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
 <tr>
	<td width="2%">&nbsp;</td>
    <td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Course Material</font></b></td>
  </tr>
<%
			int j=0;
			
			
			try
			{
				if(!unitIds.equals(""))
				{
			StringTokenizer widTokens=new StringTokenizer(unitIds,",");
		
			while(widTokens.hasMoreTokens())
			{
				uId=widTokens.nextToken();				

			st6=con.createStatement();
			rs6=st6.executeQuery("select * from dev_units_master where course_id='"+cbCourseId+"' and unit_id='"+uId+"'");
			while(rs6.next())
			{
			unitId=rs6.getString("unit_id");
			unitName=rs6.getString("unit_name");
			j=0;
			st3=con.createStatement();
			//rs3=st3.executeQuery("select * from dev_lessons_master where course_id='"+courseId+"'");
			rs3=st3.executeQuery("select * from dev_lessons_master where course_id='"+cbCourseId+"' and unit_id='"+unitId+"' order by lesson_id");
			while(rs3.next())
			{
				lessonId=rs3.getString("lesson_id");
				lessonName=rs3.getString("lesson_name");

				if(distributedIds.indexOf(lessonId)!=-1)
				{
					chkStatus="checked";
					
				}
				else
				{
					chkStatus="";
				}
				

				if(lessonIds.indexOf(lessonId)!=-1)
				{
					if(j==0)
					{
%>
<tr>
		<td width="2%">&nbsp;</td>
		 <td width="2%"><input type="checkbox" name="uids" value="<%=unitId%>" <%=chkStatus%>></td>
	    <!-- <td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td> -->
		<td width="96%"><font face="Verdana" size="2"><%=unitName%></font></td>
</tr>
<%	
					}
					j++;
					
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="2%"><input type="checkbox" name="lids" value="<%=lessonId%>" <%=chkStatus%>></td>
	    <!-- <td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td> -->
		<td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td>
	</tr>
<%
				}
			}
			rs3.close();
			st3.close();
			
			}
			rs6.close();
			st6.close();
			}
			}
			}			
			catch(Exception e) 
			{
				System.out.println("Exception in third block in PretestStudentResponse.jsp"+e.getMessage());
			}
			
			if(j==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no lessons associated with this question.</i></font>
		</td>
	</tr>
<%
			}
%>
	</table>
	<hr>

	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Assignments</font></b></td>
	</tr>

<%
			int wid=0;
			st4=con.createStatement();
			rs4=st4.executeQuery("select work_id,doc_name from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2 order by slno");
			while(rs4.next())
			{
				asgnId=rs4.getString("work_id");
				asgnName=rs4.getString("doc_name");

				
				if(distributedIds.indexOf(asgnId)!=-1)
				{

					chkStatus="checked";
				}
				else
				{
					chkStatus="";
				}
				
							
				if(asgnIds.indexOf(asgnId)!=-1)
				{
					wid++;
					
%>
  <tr>
	<td width="2%">&nbsp;</td>
    <td width="2%"><input type="checkbox" name="asgnids" value="<%=asgnId%>" <%=chkStatus%>></td>
    <td width="96%"><font face="Verdana" size="2"><%=asgnName%></font></td>
  </tr>
<%
				}
			}
			rs4.close();
			st4.close();
			if(wid==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no assignments associated with this question.</i></font>
		</td>
	</tr>
<%
			}	
%>
	</table>
	<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Assessments</font></b></td>
	</tr>

<%
			int l=0;
			st5=con.createStatement();
			rs5=st5.executeQuery("select exam_id,exam_name from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'");
			while(rs5.next())
			{
				assessId=rs5.getString("exam_id");
				assessName=rs5.getString("exam_name");

				
				if(distributedIds.indexOf(assessId)!=-1)
								{
									chkStatus="checked";
								}
								else
								{
									chkStatus="";
								}
				
				if(assessIds.indexOf(assessId)!=-1)
				{
					l++;
%>
  <tr>
	<td width="2%">&nbsp;</td>
    <td width="2%"><input type="checkbox" name="assessids" value="<%=assessId%>" <%=chkStatus%>></td>
    <td width="96%"><font face="Verdana" size="2"><%=assessName%></font></td>
  </tr>
<%
				}
			}
			if(l==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no assessments associated with this question.</i></font>
		</td>
	</tr>
<%
			}	
%>
</table>
<hr>


<%
			
			}		
	
			}
			catch(Exception e) 
			{
				System.out.println("Exception in third block in PretestStudentResponse.jsp"+e.getMessage());
			}

		
		

%>


<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="74">
      <tr>
        <td width="52%" height="19">&nbsp;</td>
      </tr>
      <tr>
        <td width="52%" bgcolor="#934900" height="36">
        <p align="center"><input type="submit" value="MAKE THE DISTRIBUTION" name="B1">&nbsp;&nbsp;&nbsp;
        <input type="reset" value="Reset" name="B2"></td>
      </tr>
      <tr>
        <td width="52%" height="19">&nbsp;</td>
      </tr>
    </table>
	</td></tr>
</table>
<%
	}
  	catch(SQLException se)
	{
		System.out.println("Error in MaterialMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in MaterialMapping.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(st4!=null)
				st4.close();
			if(st5!=null)
				st5.close();
			if(st6!=null)
				st6.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of MaterialMapping.jsp : pretest -"+se.getMessage());
		}
	}
%>
</form>
</body>
</html>