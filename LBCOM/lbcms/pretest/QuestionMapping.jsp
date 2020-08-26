<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>
<%@page import="java.io.*,java.sql.*,java.util.*,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Connection conObj=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String classId="",courseId="",questionCount="",questionId="",questionBody="";
	String lessonsStatus="",asgnStatus="",assessStatus="";
	String lessonsColor="green",asgnColor="green",assessColor="green";
	String devCourseId="",userId="",courseName="",assmtId="";
	 String sessid="",qtnTbl="",qId="",fText="",ansStr="",cFeedback="",icFeedback="",hint="";
	String difficultLevel="",estimatedTime="",timeScale="",qT="",questionType="",qid="";
	int i=0,slNo=0,qType=0;
	ArrayList oAList=null,oLList=null,oRList=null,optStr=null;

	try
	{
		con=con1.getConnection();
		conObj=db.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		classId=request.getParameter("classid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		userId=request.getParameter("uid");
		assmtId=request.getParameter("assmtid");
		slNo=Integer.parseInt(request.getParameter("slno"));

		System.out.println("select count(*) from lbcms_dev_assmt_content_quesbody where course_id='"+courseId+"' and assmt_id='"+assmtId+"'");
		
		rs=st.executeQuery("select count(*) from lbcms_dev_assmt_content_quesbody where course_id='"+courseId+"' and assmt_id='"+assmtId+"'");
		if(rs.next())
			questionCount=rs.getString(1);

		System.out.println("questionCount..."+questionCount);

		rs1=st1.executeQuery("select * from lbcms_dev_assmt_content_quesbody where course_id='"+courseId+"' and assmt_id='"+assmtId+"' ORDER BY q_id");
		
			

	

%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest - Question Map</title>
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" /> 
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="../images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr></table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" class="gridhdrNew" height="25">
    <font face="Verdana" size="2">&nbsp;<b>Pretest - Question Map</b></font></td>
    <td width="25%" align="center" class="gridhdrNew" height="25">&nbsp;</td>
    <td width="25%" align="right" class="gridhdrNew" height="25">
		<b><font face="Verdana" size="2"><a href="../ViewAssignInfo.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=userId%>">
		<font >Back to Pretest</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="24%"><font color="#934900"><font face="Verdana" size="1">&lt;&lt; </font><font face="Verdana" size="2">Prev</font></font></td>
    <td width="49%" align="center">
    	<font face="Verdana" size="2" color="#934900">1 - <%=questionCount%> of <%=questionCount%> Questions</font>
    </td>
    <td width="18%" align="center">
		<a href="CreateQuestion.jsp" style="text-decoration: none"><font face="Verdana" size="2">New Question</font></a>
	</td>
    <td width="9%" align="right">
    	<font color="#934900"><font face="Verdana" size="2">Next </font><font face="Verdana" size="1">&gt;&gt;</font></font>
    </td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="2%" align="center" class="gridhdrNew1">&nbsp;</td>
    <td width="3%" align="center" class="gridhdrNew1">
    <font face="Verdana" size="1" >CM</font></td>
    <td width="3%" align="center"class="gridhdrNew1">
    <font face="Verdana" size="1" >AS</font></td>
    <td width="3%" align="center" class="gridhdrNew1">
    <font face="Verdana" size="1" >EX</font></td>
    <td width="2%" align="center" class="gridhdrNew">&nbsp;
    </td>
    <td width="64%" class="gridhdrNew"><b>
    <font face="Verdana" size="2" >&nbsp;Title of the Question</font></b></td>
    <td width="17%" align="center" class="gridhdrNew"><b>
    <font face="Verdana" size="2" >Question Type</font></b></td>
  </tr>
<%System.out.println("..*********************....");
			
		while(rs1.next())
		{

			questionBody=QuestionFormat.getQString(rs1.getString("q_body"),50);
			
			questionId=rs1.getString("q_id");
			i++;
			
			//if(questionBody.length() > 50)
				//questionBody=questionBody.substring(0,50)+".......";

			/*
			lessonsStatus=rs.getString("lesson_ids");
			if(lessonsStatus == null || lessonsStatus =="")
				lessonsColor="red";
			else
				lessonsColor="green";

			asgnStatus=rs.getString("assignment_ids");
			if(asgnStatus == null || asgnStatus=="")
				asgnColor="red";
			else
				asgnColor="green";

			assessStatus=rs.getString("assessment_ids");
			if(assessStatus == null || assessStatus=="")
				assessColor="red";
			else
				assessColor="green";
			devCourseId=rs.getString("cb_courseid");
			if(devCourseId==null || devCourseId=="")
			{
				devCourseId="selectcourse";
			}
			*/
			qT=rs1.getString("q_type");
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

		System.out.println("qT..."+qT);

		
			qType=Integer.parseInt(qT);
			qtnTbl="lbcms_dev_assmt_content_quesbody";
		qId=questionId;

		System.out.println("qtnTbl..."+qtnTbl+"....qId..."+qId);

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
		ansStr=QuestionFormat.getAnswer(qtnBody.getAnsStr());
		System.out.println("***************ansStr......."+ansStr);

		int len=ansStr.length();
		System.out.println("length...."+len);
		char char1=ansStr.charAt(1);
		System.out.println("char1..."+char1);


		

		Question qtn=new Question();					
		qtn.setQBody(qoAList);	
		qtn.setQType(qType);

	
		ArrayList qAList =qtn.getQuestionString();	
			

		switch (qType)
				{
				case 0: // Multiple choice
				case 1: // Multiple ansers
						

					oAList=qtn.getOptionStrings();
					int j;
					String opn="";
					String fOptn="";

					char caseChar;
					int idx=0;
					fOptn="";
					System.out.println("oAList..."+oAList);
					//fText=QuestionFormat.getFormattedOpnBdyForMCAndMA(oAList,qType,questionId,questionId);
					for(j=0;j<oAList.size();j++)
					{

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
							break;
						default:
						fOptn=opn;			
						}			
					}	
					
					
					
					break;
				case 2: // True or false
					oAList=qtn.getOptionStrings();
					int k=0;
				String opnTF="";
		String fOptnTF="";

		char caseCharTF;
		int idxTF=0;
		fOptnTF="";

		for(k=0;k<oAList.size();k++){

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
					System.out.println("fOptnTF...."+fOptnTF);
					break;
				default:
					fOptn=opnTF;			
			}				
		}	
					//fText=fText+QuestionFormat.getFormattedOpnBdyForTF(oAList,qType,questionId,questionId);
					break;

				case 4: // Matching
					oLList=qtn.getLOptionStrings();
					oRList=qtn.getROptionStrings();
					fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,oRList,qType,questionId,questionId);
					break;
				case 5://  Ordering
					oLList=qtn.getLOptionStrings();						
					fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,null,qType,questionId,questionId);
					break;					
				case 6: // Short type questions
					float f=0.0f;
					String gid="-";
					fText=fText+QuestionFormat.getFormattedOpnBdyForST(qId,qType,questionId,f,gid);
					break;
				}			


			
			
%>
	<tr>
		<td width="2%" class="gridhdrNew1" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
		<td  width="3%" align="center" bgcolor="<%=lessonsColor%>">
			<a href="MaterialMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>&devcourseid=<%=devCourseId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">CM</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=asgnColor%>">
			<a href="AssignmentsMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">AS</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=assessColor%>">
			<a href="AssessmentsMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">EX</font>
			</a>
		</td>
		<td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
		<td width="64%"><font face="Verdana" size="2">&nbsp;<%=questionBody%></font></td>
		<td width="17%" align="center"><font face="Verdana" size="2"><%=questionType%></font>&nbsp;</td>
	</tr>
<%
		}	
System.out.println("..*********************....");
		if(Integer.parseInt(questionCount) ==0)
		{
%>
  <tr>
    <td width="100%" colspan="7">
		<font face="Verdana" size="1">There are no questions in the pretest.</font></td>
  </tr>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in QuestionMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in QuestionMapping.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of QuestionMapping.jsp : pretest -"+se.getMessage());
		}
	}
%> 
</table>
</body>
</html>