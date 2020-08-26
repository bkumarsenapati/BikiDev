<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,java.lang.Object,java.util.Vector,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=25;
	private int getPages(int tRecords){
		int noOfPages;
		if((tRecords%pageSize)>0){
			noOfPages=(tRecords/pageSize)+1;
		}else{
			noOfPages=(tRecords/pageSize);
		}
		return noOfPages;
	}
%>
<% 
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String studentId="",chances="",stuPassword="",schoolId="";
	String examId="",courseId="",examType="",linkStr="",courseName="",teacherId="",examName="";
	String bgColor="",foreColor="";
	String tableName="",status="",eType="",tdate="",fDate="";
	int marks=0;
	int totRecords=0,start=0,end=0,c=0,ass=0,sub=0,pen=0,eval=0,markScheme=0;
	
	int index=0,startIndex=0,examPassword=0,currentPage=0;
	int i=0,childStatus=0,masterStatus=0,attempted=0,noOfAttempts=0;
	Date currentDate=null,fromDate=null,toDate=null,createDate=null;
	boolean flag=false,dateFlag=false,mAttemptsFlag=false;
	Time currentTime=null,toTime=null,fromTime=null;
	String nChances="";
	float totalMarks=0.0f,shortAnsMarks=0.0f;
	String scheme="";

	String sortBy,sortType,sortImg="";	
%>
<%

	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if (s==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	con=con1.getConnection();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	studentId=(String)session.getAttribute("emailid");
	
	// Santhosh added this on Aug 3,2013
	// Student builder status
	session.setAttribute("stdstatus","no");
	// Upto here

	if((courseId=request.getParameter("courseid"))==null){
		
		courseId=(String)session.getAttribute("courseid");
	}else 
	    session.setAttribute("courseid",courseId);
	courseName=request.getParameter("coursename");
	examType=request.getParameter("examtype");

	
	sortType=request.getParameter("sorttype");
	sortBy=request.getParameter("sortby");

	if (sortType==null){
		sortType="ASC";
	}

	if(sortBy==null)
		sortBy="slno";
	
	if(sortType.equals("ASC"))
		sortImg="sort_dn_1.gif";
	else
		sortImg="sort_up_1.gif";

	chances="";
	nChances="";
	flag=true;
	c=0;
	String durationInSecs="";
	try {
		 
		 tableName=schoolId+"_"+studentId;
		 if (request.getParameter("totrecords").equals("")) {

			st=con.createStatement();
			
			if(examType.equals("all")){

				rs=st.executeQuery("select count(*) from "+tableName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+studentId+"' and c.report_status=1 and s.start_date is NOT NULL");

			}
			else
			{
				rs=st.executeQuery("select count(*) from "+tableName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+studentId+"' and c.report_status=1 and s.start_date is NOT NULL");

			}
			if(rs.next()) {
		    	c+=rs.getInt(1);
				
			}
			
			if(c!=0) {

				totRecords=c;
				startIndex=0;
			}else
				flag=false;
			
		}
		else 
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
		 
		   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		   start=Integer.parseInt(request.getParameter("start"));
		   startIndex=start;
		   c=start+pageSize;
		   end=start+pageSize;

		   if (c>=totRecords)
			   end=totRecords;
		 
	   
		   if(examType.equals("all")){

//			rs=st.executeQuery("select *,curdate() t ,curtime() ct from exam_tbl e inner join "+tableName+" s on e.exam_id=s.exam_id where course_id='"+courseId+"' and school_id='"+schoolId+"' and status='1' order by "+sortBy+" "+sortType+" LIMIT "+start+","+pageSize);

			rs=st.executeQuery("select s.*,e.*,c.total_marks,curdate() t ,curtime() ct from "+tableName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+studentId+"' and c.report_status=1 and s.start_date is NOT NULL order by "+sortBy+" "+sortType+" LIMIT "+start+","+pageSize);

		  }
		  else
		  {
			rs=st.executeQuery("select s.*,e.*,c.total_marks,curdate() t ,curtime() ct from "+tableName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+studentId+"' and c.report_status=1 and s.start_date is NOT NULL order by "+sortBy+" "+sortType+" LIMIT "+start+","+pageSize );

		  }
		   currentPage=(start/pageSize)+1;
		   

		
		}	
		catch(SQLException e)
		{
			ExceptionsFile.postException("StudentExamsList.jsp","geting and storing all the exam details in the vectors","SQLException",e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("StudentExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("SQLException in StudentExamsList.jsp is.. "+se.getMessage());
				System.out.println("The student id at the time of error is 11111..."+studentId);
			}
		}	

		catch(Exception e)
		{
			ExceptionsFile.postException("StudentExamsList.jsp","geting and storing all the exam details in the vectors","Exception",e.getMessage());
			System.out.println("The Exception in StudentExamsList.jsp is:"+e);
			System.out.println("The student id at the time of error is 2222..."+studentId);
		}	
%>

<html>

<head>
<title></title>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<base target="main">
<link href="admcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
<!--

	function open_help(){
		window.open("../coursemgmt/student/st_exam_list_help.html","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=400, height=200")
	}
	function go(start,totrecords,eType){	
		window.location.href="StudentExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&coursename=<%=courseName%>&sortby=<%=sortBy%>&sorttype=<%=sortType%>";
		return false;
	}
	
	function gotopage(totrecords,eType){
		var page=document.filelist.page.value;
		if (page==0){
			alert("Please select a page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="StudentExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&coursename=<%=courseName%>&sortby=<%=sortBy%>&sorttype=<%=sortType%>";
			return false;
		}
	}

	function openwin(eId,ename,max,etype,crdate,teachId,course,version,stuPassword,mAttemptFlag,count,totmarks,status){
		//var newwin=window.open("StuExamHistory.jsp?examid="+eId+"&examname="+ename+"&maxattempts="+max+"&crdate="+crdate+"&teacherid="+teachId+"&courseid="+course+"&version="+version,"History",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
		window.location.href="StuExamHistory.jsp?examid="+eId+"&examname="+ename+"&maxattempts="+max+"&crdate="+crdate+"&teacherid="+teachId+"&courseid="+course+"&version="+version+"&stupassword="+stuPassword+"&attemptFlag="+mAttemptFlag+"&totalmarks="+totmarks+"&shortansmarks=<%=totalMarks%>&count="+count+"&status="+status+"scheme=<%=scheme%>&examtype=<%=examType%>";
		//var newwin=window.open("HistoryFrames.jsp?examid="+eId+"&examname="+ename+"&maxattempts="+max+"&crdate="+crdate+"&teacherid="+teachId+"&courseid="+course,"History",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
		//newwin.focus();
    	//top.studenttopframe.stuExamHistoryWin=newwin;
		return false;
	}
	function openExamPlayer(eId,tblName,teacherId,markscheme){
		if(top.studenttopframe.stuExamHistoryWin!=null && !top.studenttopframe.stuExamHistoryWin.closed)
			top.studenttopframe.stuExamHistoryWin.close();
		if(top.studenttopframe.stuAnsSheetWin!=null && !top.studenttopframe.stuAnsSheetWin.closed)
			top.studenttopframe.stuAnsSheetWin.close();
		var win=window.open("ExamPlayer.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&markscheme="+markscheme,"ExamPlayer","width=900,height=700,status=yes,resizable=1");
		
		top.studenttopframe.studentExamWin=win;
		win.focus();

	}
	function showpapers(attempts,version,student,count,status)
	{
		 alert(attempts);
		 alert(version);
		 alert(student);
		 alert(count);
		 alert(status);
		 var e="<%=examId%>";
		 alert(e);
		 var submittedwin=window.open("StuExamPapersFrame.jsp?examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
	function openpassword(eId,tblName,teacherId,expassword,stupassword,etype,chances,markscheme,durationinsecs)
	{
		/*
		parent.category.document.leftpanel.asgncategory.value=etype;
		if(top.studenttopframe.stuExamHistoryWin!=null && ! top.studenttopframe.stuExamHistoryWin.closed)
			top.studenttopframe.stuExamHistoryWin.close();
		if(top.studenttopframe.stuAnsSheetWin!=null && !top.studenttopframe.stuAnsSheetWin.closed)
			top.studenttopframe.stuAnsSheetWin.close();
			*/
		if(expassword==1){
			if(stupassword!="")
				window.location.href="ExamPassword.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&status=0&examtype="+etype+"&start=<%=start%>&totrecords=<%=totRecords%>&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;	
			else{
				alert("Sorry! You cannot take the Assessment.");
				return false;
			}
		}else{
			window.location="examdetails.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;
			//win=window.open("ExamPlayer.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs,"ExamPlayer","width=900,height=700,status=yes,resizable=1");
			//top.studenttopframe.studentExamWin=win;
			//win.focus();
		}
		//var t=setTimeout("window.location.reload()",2000)
	}

//-->
</SCRIPT>

</head>
<body topmargin=2 leftmargin=2>
<form name="filelist">

<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" >
        <div align="center">


	<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
   <td colspan="9">
    
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr >

	<% if (flag==false){
		out.println("<tr><td width='100%' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>There are no assessments available at this point of time.</font></b></td></tr></table></td></tr></table>");				
		return;
	}
	%>	
    <td height="21" >
      <span align="right"><font size="2" face="Arial" ><span class="last">&nbsp;Exams <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span>
	</td>
	<td height="21" align="center"><font size="2" face="arial">

	  <%


		  	if(sortType.equals("ASC"))
				sortType="DESC";
			else
				sortType="ASC";



	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+examType+"');return false;\" target='contents'>Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
  </font>
  </td>
  <td width="351" >
		<a href="javascript://" onclick=open_help() style="cursor: pointer;cursor: hand;"><font size="2" face="Arial" >Help!</font></a>
 </td>
<td  height='21' align='right' ><font face="arial" size="2" >Page&nbsp;
	  <%
		index=1;
		int begin=0;
		int noOfPages=getPages(totRecords);
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"','"+examType+"');return false;\"> ");
		while(index<=noOfPages){
			if(index==currentPage){
			    out.println("<option value='"+index+"' selected>"+index+"</option>");
			}else{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			begin+=pageSize;

		}
	  %>
  </font></td>
  </tr>
  </table>
  </td>
  </tr>
  
   <tr>
    <!-- <td width="14" height="18" align="center" valign="middle"></td> -->
    <td class="gridhdr">&nbsp;<a href="./StudentExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=exam_name&sorttype=<%=sortType%>" target="_self"><img border="0" src="images/<%=sortImg%>"></a>Assessment
     </td>
	<td class="gridhdr">&nbsp;&nbsp;</td>
	<td class="gridhdr">&nbsp;Submission History&nbsp;</td>
    <td class="gridhdr">Points</td>
    <!-- <td class="gridhdr"><a href="./StudentExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=from_date&sorttype=<%=sortType%>" target="_self"><img border="0" src="images/<%=sortImg%>"></a>From Date&nbsp; </td>
    <td class="gridhdr">To Date&nbsp;</td>
	<td class="gridhdr">Time From&nbsp;</td>
    <td class="gridhdr">Time To&nbsp;</td>
	<td class="gridhdr">Duration&nbsp;</td> -->
	 
	</tr>
	<%
	  i=1;
	  try {
		  int hrs=0;
		  int mins=0;
			
			//while((i<=pageSize)&&(startIndex<totRecords)) {
			  while(rs.next()){
				  
					dateFlag=false;
					mAttemptsFlag=false;

					examName=rs.getString("exam_name");
					examName=examName.replaceAll("&#39;","&#92;&#39;");
				    
					examId=rs.getString("exam_id");
					examType=rs.getString("exam_type");
					currentDate=rs.getDate("t");
					// Individual dates
					
					fromDate=rs.getDate("start_date");
					toDate=rs.getDate("end_date");
					 // Upto here

					//fromDate=rs.getDate("from_date");
					//toDate=rs.getDate("to_date");
					teacherId=rs.getString("teacher_id");
					createDate=rs.getDate("create_date");
					toTime=rs.getTime("to_time");
					fromTime=rs.getTime("from_time");
					currentTime=rs.getTime("ct");
					masterStatus=rs.getInt("status");
					childStatus=rs.getInt("exam_status");
					markScheme=rs.getInt("grading");
					tableName=schoolId+"_"+examId+"_"+(createDate.toString()).replace('-','_');
					hrs=rs.getInt("dur_hrs");
					mins=rs.getInt("dur_min");
					durationInSecs=String.valueOf((hrs*360)+(mins*60));
					totalMarks=rs.getInt("total_marks");
										 					
					
					attempted=rs.getInt("count");
					if (fromDate==null){
						
					   fDate="-";
					}
					else{
						fDate=String.valueOf(fromDate);
					}
	

					if (toDate==null){
						
					    tdate="-";
					}else{
						tdate=String.valueOf(toDate);
					}
					 						
					if (childStatus==0)
						foreColor="#FF0000";
					else
						foreColor="green";//foreColor="#FF7B4F";
					
    %>
	<tr>
   
	<!--  <td width="14" height="18" align="center" valign="middle"></td> -->
	
	 <% 
	 if (masterStatus==1) {
		 
		// noOfAttempts=rs.getInt("mul_attempts");
		 noOfAttempts=rs.getInt("max_attempts");

		 stuPassword=rs.getString("exam_password");
		 examPassword=rs.getInt("password");
		 if (noOfAttempts==-1){
			 chances="No&nbsp;Limit";
			 nChances="-";
			 noOfAttempts=attempted+2;
		 }else{
			chances=attempted+"/"+noOfAttempts;
			nChances=(attempted+1)+"/"+noOfAttempts;

		 }
		 		 
		if ((noOfAttempts<=attempted)&&(childStatus>=1))
			 mAttemptsFlag=false;
		 else
			 mAttemptsFlag=true;
		
		if ((fromDate==null)&&(toDate!=null))
		{
			if (currentDate.compareTo(toDate)<=0)
				dateFlag=true;
		}
		else if ((fromDate!=null)&&(toDate==null))
		{
			if (currentDate.compareTo(fromDate)>=0) 
				dateFlag=true;
		}
		else if ((fromDate==null)&&(toDate==null))
		{	
			dateFlag=true;
		}
		
		if((fromDate!=null)&&(toDate!=null))
		{
				if ((currentDate.compareTo(fromDate)>=0)&&((currentDate.compareTo(toDate)<=0)))
				{
					dateFlag=true;
				}
				
		}
		
		if ((dateFlag==true)&&(currentDate.compareTo(fromDate)==0))
		{
			  if ((currentTime).after(fromTime))
			  { 	
				dateFlag=true;
			  }
			  else 
				dateFlag=false;
			
		}
		if ((dateFlag==true)&&(toDate!=null)&&(currentDate.compareTo(toDate)==0))
		{	
			
			 if ((currentTime).before(toTime))
			  {
				 dateFlag=true;	
				
			  }
			  else if ((currentTime).after(toTime))
			  {
				dateFlag=true;
								
			  }
			  else
			  {
				dateFlag=false;
								
			  }
		 }
	 }
	 else {

		mAttemptsFlag=false;
		dateFlag=false;
	 }
	 	
	if ((mAttemptsFlag)&&(dateFlag)) {
		
		
		%>
			
	   	<!--<td width="200" height="21"><font size="2" face="Arial" color="<%=foreColor%>"><a href="ExamPassword.jsp?examid=<%=examId%>&tblname=<%=tableName%>&teacherid=<%=teacherId%>"><%=examName%></a></font></td>-->
		
		<%
						if(schoolId.equals("achievebeyond")){
						%>
						<td class="griditem">&nbsp;<a href="#" onClick="openpassword('<%=examId%>','<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;" ><%=examName.replaceAll("&#92;&#39;","&#39;")%></a></td>
						<%
						}else if(schoolId.equals("lbpghs") || schoolId.equals("pghighschool") || schoolId.equals("training")){
						%>
					
							
							<td class="griditem">&nbsp;<a href="#" onClick="examPlayer('<%=examId%>','<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;" ><%=examName.replaceAll("&#92;&#39;","&#39;")%></a></td>
						<%
						}else{
						%>
					
							<td class="griditem">&nbsp;<a href="#" onClick="openpassword('<%=examId%>','<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;" ><%=examName.replaceAll("&#92;&#39;","&#39;")%></a></td>
						<%
						}
						%>
		

		<td class="griditem"></td>
		<!-- <td class="griditem">&nbsp;<a href="#" onClick="examPlayer('<%=examId%>','<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;" ><!-- <img src="new_plyr.jpg" width="30",height="30" border="0" title="Unit Based Assessments"> Unit Based Assessments</a></td> -->
	<%     
	} else {
			
			foreColor="blue";
	%>
		<td class="griditem">&nbsp;<%=examName%></td>
		<td class="griditem">&nbsp;</td>
	 <%} 
	if(examType.equals("ST")){%>
		<td class="griditem">&nbsp;<%=chances%></td>
	<%} else{%>
		<td class="griditem">&nbsp;<b><a href="#" onClick="return openwin('<%=examId%>','<%=examName.replaceAll("'","&#92;&#39;")%>','<%=rs.getInt("mul_attempts")%>','<%=examType%>','<%=createDate%>','<%=teacherId%>','<%=courseId%>','<%=rs.getString("version")%>','<%=stuPassword%>','<%=mAttemptsFlag%>','<%=attempted%>','<%=totalMarks%>','<%=rs.getString("status")%>');" target="contents" ><%=chances%></a></td> 
		<!-- <td width="50" height="21">&nbsp;<b><a href="#" onclick="showpapers('<%=attempted%>','<%=rs.getString("version")%>','<%=studentId%>','<%=attempted%>','<%=rs.getString("status")%>');return false;"><font size="2" face="Arial" color="<%=foreColor%>"><%=chances%></a></font></b></td> -->
	<%}%>
    <!-- <td class="griditem"><%=rs.getString("instructions")%></td>
    <td class="griditem"> <%=fDate%></td>
    <td class="griditem"><%=tdate%></td>
	<td class="griditem"> <%=fromTime%></td>
    <td class="griditem"> <%=toTime%></td>
	<td class="griditem"> <%=rs.getInt("dur_hrs")%>:<%=rs.getInt("dur_min")%>
	</td> -->
	<td class="griditem"> <%=totalMarks%></td>
	


	<input type="hidden" name="attempted" value="<%=attempted%>">
	<input type="hidden" name="version" value="<%=rs.getString("version")%>">
	<input type="hidden" name="status" value="<%=rs.getString("status")%>"> 
	</tr>
  <%
		 
	}
	  }
		catch(Exception e) 
		{
			ExceptionsFile.postException("StudentExamsList.jsp","operations on database","Exception",e.getMessage());
			System.out.println("The Error StudentExamsList_new is "+e);	
			System.out.println("The student id at the time of error is 3333..."+studentId);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
			}
			catch(SQLException se)
			{
			ExceptionsFile.postException("StudentExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in StudentExamList.jsp is.."+se.getMessage());
			System.out.println("The student id at the time of error is 4444..."+studentId);
		}
    }
%>
</form>
<script>
function examPlayer(eId,tblName,teacherId,expassword,stupassword,etype,chances,markscheme,durationinsecs)
{
	//window.open("/LBCOM/GetQuestions?examid="+eId+"&tableName="+tblName,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
	//window.location.href="/LBCOM/GetQuestions?examid="+eId+"&tableName="+tblName;

		if(expassword==1){
			if(stupassword!="")
				window.location.href="ExamPassword.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&status=0&examtype="+etype+"&start=<%=start%>&totrecords=<%=totRecords%>&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;	
			else{
				alert("Sorry! You cannot take the Assessment.");
				return false;
			}
		}else{
			
			window.location="examinstructions.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;

			//window.open("/LBCOM/GetQuestions?examid="+eId+"&tableName="+tblName,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
			
		}



}
</script>
</body>
</html>
