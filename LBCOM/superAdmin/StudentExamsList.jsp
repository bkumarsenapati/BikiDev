<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,java.lang.Object,java.util.Vector,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=15;
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
	String tableName="",status="",eType="",tdate="";
	int marks=0;
	int totRecords=0,start=0,end=0,c=0,ass=0,sub=0,pen=0,eval=0,markScheme=0;
	
	int index=0,startIndex=0,examPassword=0,currentPage=0;
	int i=0,childStatus=0,masterStatus=0,attempted=0,noOfAttempts=0;
	Date currentDate=null,fromDate=null,toDate=null,createDate=null;
	boolean flag=false,dateFlag=false,mAttemptsFlag=false;
	Time currentTime=null,toTime=null,fromTime=null;
	String nChances="";

	
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
	if((courseId=request.getParameter("courseid"))==null){
		
		courseId=(String)session.getAttribute("courseid");
	}else 
	    session.setAttribute("courseid",courseId);
	courseName=request.getParameter("coursename");
	examType=request.getParameter("examtype");
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
				rs=st.executeQuery("select count(*) from  "+tableName+" as s inner join exam_tbl as e on s.exam_id=e.exam_id where e.course_id='"+courseId+"' and e.status='1' and e.school_id='"+schoolId+"' order by from_date");
			}else{
				rs=st.executeQuery("select count(*) from "+tableName+" as s inner join exam_tbl as e on s.exam_id=e.exam_id where e.course_id='"+courseId+"' and e.exam_type='"+examType+"' and e.school_id='"+schoolId+"' and e.status='1' order by from_date");
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

			rs=st.executeQuery("select *,curdate() t ,curtime() ct from exam_tbl e inner join "+tableName+" s on e.exam_id=s.exam_id where course_id='"+courseId+"' and school_id='"+schoolId+"' and status='1' order by status,from_date desc LIMIT "+start+","+pageSize);
		  }else{
			rs=st.executeQuery("select *,curdate() t ,curtime() ct from exam_tbl e inner join "+tableName+" s on e.exam_id=s.exam_id where course_id='"+courseId+"' and school_id='"+schoolId+"' and exam_type='"+examType+"' and status='1' order by status,from_date  desc LIMIT "+start+","+pageSize);
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
				
			}catch(SQLException se){
				ExceptionsFile.postException("StudentExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}	

		catch(Exception e)
		{
			ExceptionsFile.postException("StudentExamsList.jsp","geting and storing all the exam details in the vectors","Exception",e.getMessage());
			System.out.println("The Error is:"+e);
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

<SCRIPT LANGUAGE="JavaScript">
<!--

	function go(start,totrecords,eType){	
		window.location.href="StudentExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&coursename=<%=courseName%>";
		return false;
	}
	
	function gotopage(totrecords,eType){
		var page=document.filelist.page.value;
		if (page==0){
			alert("Select page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="StudentExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&coursename=<%=courseName%>";
			return false;
		}
	}

	function openwin(eId,ename,max,etype,crdate,teachId,course,version,stuPassword){
		//var newwin=window.open("StuExamHistory.jsp?examid="+eId+"&examname="+ename+"&maxattempts="+max+"&crdate="+crdate+"&teacherid="+teachId+"&courseid="+course+"&version="+version,"History",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
		window.location.href="StuExamHistory.jsp?examid="+eId+"&examname="+ename+"&maxattempts="+max+"&crdate="+crdate+"&teacherid="+teachId+"&courseid="+course+"&version="+version+"&stupassword="+stuPassword;
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
		
		//top.studenttopframe.studentExamWin=win;
		win.focus();

	}
	function openpassword(eId,tblName,teacherId,expassword,stupassword,etype,chances,markscheme,durationinsecs){
		
		parent.category.document.leftpanel.asgncategory.value=etype;
		if((confirm("Do you want to take the Assessment now?"))){
			if(top.studenttopframe.stuExamHistoryWin!=null && ! top.studenttopframe.stuExamHistoryWin.closed)
				top.studenttopframe.stuExamHistoryWin.close();
			if(top.studenttopframe.stuAnsSheetWin!=null && !top.studenttopframe.stuAnsSheetWin.closed)
				top.studenttopframe.stuAnsSheetWin.close();
			if(expassword==1){
				if(stupassword!="")
				  window.location.href="ExamPassword.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&status=0&examtype="+etype+"&start=<%=start%>&totrecords=<%=totRecords%>&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;	
				 else{
					 alert("You are blocked to take the Assessment");
					 return false;
				 }

			}else{
				 win=window.open("ExamPlayer.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs,"ExamPlayer","width=900,height=700,status=yes,resizable=1");
				win.focus();
				top.studenttopframe.studentExamWin=win;
				
			}
			var t=setTimeout("window.location.reload()",2000)

			
		}else{
			return false;
		}

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
	<tr>

	<% if (flag==false){
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Nothing is scheduled yet. </font></b></td></tr></table></td></tr></table>");				
		return;
	}
	%>	
    <td bgcolor="#BD966B" height="21" >
      <sp align="right"><font size="2" face="Arial"><span class="last">Exams <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span></td>
	  <td bgcolor="#BD966B" height="21" align="center"><font color="#000080" size="2" face="arial">

	  <%

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
	  
  </font></td>
	<td  bgcolor='#BD966B' height='21' align='right' ><font face="arial" size="2">Page&nbsp;
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
    <td width="14" bgcolor="#C0C0C0" height="18" align="center" valign="middle"></td>
    <td width="200" bgcolor="#C0C0C0" height="21"><b><font size="2" face="Arial" color="#000080">Assessment
     </font></b></td>
	<td width="50" bgcolor="#C0C0C0" height="21"><b><font size="2" face="Arial" color="#000080">Attempts</font></b></td>
    <td width="200" bgcolor="#C0C0C0" height="21"><b><font size="2" face="Arial" color="#000080">Instructions</font></b></td>
    <td width="101" bgcolor="#C0C0C0" height="21"><font size="2" face="Arial" color="#000080"><b>From Date&nbsp;</b></font> </td>
    <td width="101" bgcolor="#C0C0C0" height="21"><font size="2" face="Arial" color="#000080"><b>To Date&nbsp;</b></font></td>
	<td width="101" bgcolor="#C0C0C0" height="21"><font size="2" face="Arial" color="#000080"><b>Time From&nbsp;</b></font> </td>
    <td width="101" bgcolor="#C0C0C0" height="21"><font size="2" face="Arial" color="#000080"><b>Time To&nbsp;</b></font></td>
	<td width="101" bgcolor="#C0C0C0" height="21"><font size="2" face="Arial" color="#000080"><b>Duration&nbsp;</b></font></td>
	 
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
				    
					examId=rs.getString("exam_id");
					examType=rs.getString("exam_type");
					currentDate=rs.getDate("t");
					fromDate=rs.getDate("from_date");
					toDate=rs.getDate("to_date");
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
					
					
					attempted=rs.getInt("count");
	

					if (toDate==null){
						
					    tdate="-";
					}else{
						tdate=String.valueOf(toDate);
					}
						
					if (childStatus==0)
						foreColor="#FF0000";

					else if(childStatus==1)
						foreColor="gray";
					else
//						foreColor="#FF7B4F";
						foreColor="green";
					
    %>
	<tr>
   
	 <td width="14" bgcolor="#E7E7E7" height="18" align="center" valign="middle"></td>
	
	 <% 
	 if (masterStatus==1) {
		 noOfAttempts=rs.getInt("mul_attempts");
		 stuPassword=rs.getString("exam_password");
		 examPassword=rs.getInt("password");
		 if (noOfAttempts==-1){
			 chances="No limit";
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
		
		if ((fromDate==null)&&(toDate!=null)) {
			if (currentDate.compareTo(toDate)<=0)
				dateFlag=true;
		} else if ((fromDate!=null)&&(toDate==null))	{
			if (currentDate.compareTo(fromDate)>=0) 
				dateFlag=true;
		} else if ((fromDate==null)&&(toDate==null))	{	
			dateFlag=true;
		} if ((fromDate!=null)&&(toDate!=null))	{
			
				if ((currentDate.compareTo(fromDate)>=0)&&((currentDate.compareTo(toDate)<=0))) 
				dateFlag=true;
		}
		

		 if ((dateFlag==true)&&(currentDate.compareTo(fromDate)==0)) {
			  if ((currentTime).after(fromTime)) { 	
				dateFlag=true;
			}
			else 
				dateFlag=false;
		}
		if ((dateFlag==true)&&(toDate!=null)&&(currentDate.compareTo(toDate)==0)) {	
			  if ((currentTime).before(toTime)) {
				dateFlag=true;
			}
			else {
				dateFlag=false;
			}
		}
	 }
	 else {

		mAttemptsFlag=false;
		dateFlag=false;
	 }
	

	if ((mAttemptsFlag)&&(dateFlag)) {%>
	   	<!--<td width="200" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>"><a href="ExamPassword.jsp?examid=<%=examId%>&tblname=<%=tableName%>&teacherid=<%=teacherId%>"><%=examName%></a></font></td>-->
		<td width="200" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>"><a href="#" style="text-decoration:none;" onclick="openpassword('<%=examId%>' ,'<%=tableName%>','<%=teacherId%>','<%=examPassword%>','<%=stuPassword%>','<%=examType%>','<%=nChances %>','<%=markScheme%>','<%=durationInSecs%>'); return false;"><font color="<%=foreColor%>"><%=examName%></a></font></td>
	<%     
	} else {%>
		<td width="200" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial"  color="<%=foreColor%>"> <%=examName%></font></td>
	 <%} 
	if(examType.equals("ST")){%>
		<td width="50" bgcolor="#E7E7E7" height="21"><b><font size="2" face="Arial" color="#000080"> <%=chances%></font></b></td>
	<%} else{%>
		<td width="50" bgcolor="#E7E7E7" height="21"><b><font size="2" face="Arial" color="#000080"><a style="text-decoration:none;" href="#" onclick="return openwin('<%=examId%>','<%=examName%>','<%=rs.getInt("mul_attempts")%>','<%=examType%>','<%=createDate%>','<%=teacherId%>','<%=courseId%>','<%=rs.getString("version")%>','<%=stuPassword%>');" target="contents"><font color="<%=foreColor%>"> <%=chances%></a></font></b></td>

	<%}%>
    <td width="200" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>" ><%=rs.getString("instructions")%></font></td>
    <td width="101" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>"> <%=fromDate%></font> </td>
    <td width="101" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>"><%=tdate%></font></td>
	<td width="101" bgcolor="#E7E7E7" height="21" ><font size="2" face="Arial" color="<%=foreColor%>"> <%=fromTime%></font> </td>
    <td width="101" bgcolor="#E7E7E7" height="21" align="center"><font size="2" face="Arial" color="<%=foreColor%>"> <%=toTime%></font></td>
	<td width="101" bgcolor="#E7E7E7" height="21"><font size="2" face="Arial" color="<%=foreColor%>"> <%=rs.getInt("dur_hrs")%>:<%=rs.getInt("dur_min")%></font>
	</td>
	 
	</tr>
  <%
	}
	  }catch(Exception e) {
		ExceptionsFile.postException("StudentExamsList.jsp","operations on database","Exception",e.getMessage());
	    System.out.println("Error StudentExamsList_new is "+e);	
		
	}finally{
		try{
			if(st!=null)
				st.close();
			if(st!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StudentExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
		 %>
      </form>
	  </body>
	  </html>
