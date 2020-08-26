<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=15;
	synchronized private int getPages(int tRecords){
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
	
	String teacherId="";
	String examId="",examName="",schoolId="";
	String courseId="";
	String gradeId="";
	String examType="";
	String linkStr="",noOfGrps="",ques="",fromDate="",toDate="";
	String fgColor="",bgColor="",random="",sort="",variations="",password="",scheme="",rt_date="",rc_date="",rf_date="";
	String stuExamTable="",createDate="",flag="",groupStatus="",sortStr="",sortingBy="",sortingType="",actStatus="0",mode="create";
	int marks=0,currentPage=0,status=0;
	int totRecords=0,start=0,end=0,c=0,ass=0,sub=0,pen=0,eval=0;
	boolean versionFlage=false,stuPassword=false,passwordFlage=false;

%>
<%

	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if (s==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");
	gradeId=(String)session.getAttribute("classid");
   	con=con1.getConnection();

	examType=request.getParameter("examtype");

	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");

	if (sortingType==null)
		sortingType="A";

	
	versionFlage=false;

	try {
		if (request.getParameter("totrecords").equals("")) 
			{ 
				st=con.createStatement();
				if(examType.equals("all")){
					rs=st.executeQuery("Select count(*) from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'");
				}else{
					rs=st.executeQuery("Select count(*) from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and exam_type='"+examType+"' and school_id='"+schoolId+"'");
				}
			
				rs.next();
				c=rs.getInt(1);
				if (c!=0 ){
					totRecords=rs.getInt(1);
				}
				else{

					out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");

					out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No Assessment scheduled yet.</font></b></td></tr></table>");				
					return;


				}
			}
			else
				totRecords=Integer.parseInt(request.getParameter("totrecords"));
		   
		   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		   st1=con.createStatement();
		   start=Integer.parseInt(request.getParameter("start"));

		   c=start+pageSize;
		   end=start+pageSize;


		   if (sortingBy==null || sortingBy.equals("null")){
				sortStr="exam_name";
		   }else{

			   if (sortingBy.equals("en"))
				   sortStr="exam_name";
			   else if (sortingBy.equals("av"))
				   sortStr="status";
			   else if (sortingBy.equals("fd"))
				   sortStr="from_date";
   			   else if (sortingBy.equals("td"))
				   sortStr="to_date";
			   else if (sortingBy.equals("cd"))
				   sortStr="create_date";

			    if (sortingType.equals("A")){
					sortStr=sortStr+" asc";
					sortingType="D";
				}
				else{
					sortStr=sortStr+" desc";
					sortingType="A";
				}
		   }
		   
		   if (c>=totRecords)
			   end=totRecords;
		   String query="";
		   if(examType.equals("all")){
			   query="select *,curdate() cd,DATE_FORMAT(create_date, '%m/%d/%Y') as rc_date,DATE_FORMAT(from_date, '%m/%d/%Y') as rf_date,DATE_FORMAT(to_date, '%m/%d/%Y') as rt_date from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' order by "+sortStr+" LIMIT "+start+","+pageSize+"";
		   }else{
			    query="select *,curdate() cd ,DATE_FORMAT(create_date, '%m/%d/%Y') as rc_date,DATE_FORMAT(from_date, '%m/%d/%Y') as rf_date,DATE_FORMAT(to_date, '%m/%d/%Y') as rt_date from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and exam_type='"+examType+"' and school_id='"+schoolId+"' order by "+sortStr+" LIMIT "+start+","+pageSize+"";
		   }
			rs=st.executeQuery(query);
			currentPage=(start/pageSize)+1;

		   		  
		
		
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 

<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">


<title><%=application.getInitParameter("title")%></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--

	function editAsmt(examId,examType,crtdDate,actStatus,examName,noOfGrps){
	

			if(confirm("Are you sure that you want to edit the Assessment?")==true){
				parent.toppanel.document.examform.examcategory.value=examType;
			
			parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps;
			return false;
			}
			else
				return false;

	}
	function showsubmitfiles(eid,ename,crtdate){
	  
	   parent.bottompanel.location.href="ShowSubmittedFiles.jsp?examid="+eid+"&examname="+ename+"&createdate="+crtdate;
	   return false;
   }
   function showPapers(eid){
		 var paperswin=window.open("ExamPapersFrame.jsp?examid="+eid+"&type=teacher","Question","width=1000,height=600,scrollbars=yes resizable=yes");
		 paperswin.focus();
	}
	function go(start,totrecords,eType){	
			parent.bottompanel.location.href="ExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&sortby=<%=sortingBy%>";
		return false;
	}

	function gotopage(totrecords,eType){
		var page=document.fileslist.page.value;
		if (page==0){
			alert("Please select page number");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			parent.bottompanel.location.href="ExamsList.jsp?start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&sortby=<%=sortingBy%>";
			return false;
		}
	}

	function available(field,s,status,eType,insTable) 
	{
		if(field.checked==true)
		{
			if(status!=2 && status!=3)
			{
				if(confirm("Are you sure that you want to make the Assessment available to students?")) 
				{
					parent.toppanel.document.examform.examcategory.value=eType;					  	parent.bottompanel.location.href="/LBCOM/exam.UpdateStatus?examid="+field.value+"&examtype="+eType+"&mode=avail&instable="+insTable;
				}
			}
			else
			{
				alert("Please first provide assessment controlling data to make it available to students");
			}
		}
		else
		{
			if(s!=0)
			{
				alert("Sorry! You cannot unset the assessment as it is attempted by some of your students.");
				return false;
			}
			else
			{
				if(confirm("Are you sure that you want to make the Assessment unavailable to students?")) 
				{
					parent.toppanel.document.examform.examcategory.value=eType;	parent.bottompanel.location.href="/LBCOM/exam.UpdateStatus?examid="+field.value+"&examtype="+eType+"&mode=unavail&instable="+insTable;
				}
				field.checked==false;
				return false;
			}
		}
	}
//-->
</SCRIPT>

</head>

<body topmargin=0 leftmargin=2 vlink="blue" link="blue" alink="#800080">
<form name="fileslist">
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="1" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" colspan="14">
        <div align="center">

<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolordark="#C2CCE0" >
  <tr>
    <td bgcolor="#C2CCE0" height="21" >
      <font face="Arial" size="2">
      <sp align="left"><font size="2" face="arial"><span class="last">Assessments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span>
	  </td></font>
	  <td bgcolor="#C2CCE0" height="21" align="center"><font face="arial" size="2" color="#000080">	

	  <%

	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"');return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+examType+"');return false;\">Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
	  </font></font></td>
	  <td  bgcolor='#C2CCE0' height='21' align='right' ><font face="Arial" size="2">Page&nbsp;
	  <%
		int index=1;
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
  </tr></table>
  </td>
   <tr>
	
	<td width="17" bgcolor="#CECBCE" align="right" valign="middle"><a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&examtype=<%=examType%>&sortby=av&sorttype=<%=sortingType%>" target="_self"><img  border="0" src="images/sort_dn_1.gif" ></td>


	<td width="14" bgcolor="#CECBCE" height="18" align="center" valign="middle">&nbsp;</td>
    <td width="13" bgcolor="#CECBCE" align="center" valign="middle">&nbsp;</td>
<!-- This colmn is to reassigning -->
	 <td width="13" bgcolor="#CECBCE" align="center" valign="middle">&nbsp;</td>
<!-- This colmn is to reassigning -->
	<td width="200" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&examtype=<%=examType%>&sortby=en&sorttype=<%=sortingType%>" target="_self">
    <img border="0" src="images/sort_dn_1.gif"></a>Assessment Name</font></b></a></td>

    <td width="69" bgcolor="#CECBCE" height="21" align="center"><b><font size="2" face="Arial" color="#000080">
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&examtype=<%=examType%>&sortby=cd&sorttype=<%=sortingType%>" target="_self">
    <img border="0" src="images/sort_dn_1.gif"></a>Date</font></b></td>
    <td width="101" bgcolor="#CECBCE" height="21" align="center"><b><font size="2" face="Arial" color="#000080">
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&examtype=<%=examType%>&sortby=fd&sorttype=<%=sortingType%>" target="_self">
    <img border="0" src="images/sort_dn_1.gif"></a>From&nbsp;</font> </b> </td>
    <td width="76" bgcolor="#CECBCE" height="21" align="center"><b><font size="2" face="Arial" color="#000080">
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&examtype=<%=examType%>&sortby=td&sorttype=<%=sortingType%>" target="_self">
    <img border="0" src="images/sort_dn_1.gif"></a>To</font> </b></td>
	 <td width="13" bgcolor="#CECBCE" height="21" align="center"><b>
		<font size="2" face="Arial" color="#000080">
		<img border="0" src="images/idassign.gif" TITLE="Number of assigned students"></font></b>
	</td>
	 <td width="13" bgcolor="#CECBCE" height="21" align="center"><b>
		<font size="2" face="Arial" color="#000080">
		<img border="0" src="images/idsubmit.gif" TITLE="Submissions"></font></b>
	</td>
 	 <td width="13" bgcolor="#CECBCE" height="21" align="center"><b>
		<font size="2" face="Arial" color="#000080">
		<img border="0" src="images/ideval.gif" TITLE="Number of submissions evaluated manually" ></font></b>
	</td>
 	 <td width="13" bgcolor="#CECBCE" height="21" align="center"><b>
		<font size="2" face="Arial" color="#000080">
		<img border="0" src="images/idpending.gif" TITLE="Number of submissions pending for evaluation" ></font></b>
	</td>
</tr>

<%
	while (rs.next())
	{
		examId=rs.getString("exam_id");
		examName=rs.getString("exam_name");
		examType=rs.getString("exam_type");
		scheme=rs.getString("grading");
		rf_date=rs.getString("rf_date");
		rt_date=rs.getString("rt_date");
		rc_date=rs.getString("rc_date");
		createDate=rs.getString("create_date");
		fromDate=rs.getString("from_date");
		if(fromDate==null){
				 fromDate="-";
			 }		 
			 
			 toDate=rs.getString("to_date");
			 if(toDate==null){
				toDate="-";
			 }

			 if(examId.indexOf("e")!=-1){
				bgColor="#F3F3F3";
				fgColor="#800080";
			 }
			else{
				bgColor="#E7E7E7";
				fgColor="#000080";
			}
			
			
			noOfGrps=rs.getString("no_of_groups");


			 stuExamTable=schoolId+"_"+examId+"_"+createDate.replace('-','_');

			 
			//* the count of asmt. assigned students --> 

			 rs1=st1.executeQuery("Select count(distinct(student_id)) from "+stuExamTable+" where exam_id='"+examId+"'"); 		 

			 if (rs1.next()) 
				ass=rs1.getInt(1);

			 //*  the count of asmt. submitted students --> 
			 rs1=st1.executeQuery("Select count(*) from "+stuExamTable+" where exam_id='"+examId+"' and  status = 1 or status = 2");

			 if (rs1.next())
				sub=rs1.getInt(1);

			//* the count of asmt. evaluated students --> 
			 rs1=st1.executeQuery("Select count(*) from "+stuExamTable+" where exam_id='"+examId+"' and  status = 2");			 

			 if (rs1.next())
				 eval=rs1.getInt(1);

			 
			//* the count of asmt. pedning student for evaluating 
			
			 pen=sub-eval;

			 if (sub>0)
				 actStatus="1";
			 else
				 actStatus="0";

			status=rs.getInt("status");
			mode="create";

		   %>
	<tr>	
	<% 
	if (status==1){%>

	<!--  Make it available/unavailable to students. -->

		<td width="13" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font face="Arial"><input type="checkbox" checked name="status" value="<%=examId%>" onclick="available(this,'<%=sub%>','<%=status%>','<%=examType%>','<%=stuExamTable%>');return false;"></font></td>		

		<!--  edit asmt. metat data -->

		<td width="14" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" onclick="alert('Please first unset the assessment to edit');return false;" ></font></a></td>
	
		<!-- asmt conroller -->

		<td width="14" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial"><img border="0" src="images/ieditques.gif" TITLE="Assessment Controller" onclick="alert('Please first unset the assessment to edit');return false;" ></font></a></td>


	<% } else {%>
		

		<!--  Make it available/unavailable to students. -->

		<td width="13" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font face="Arial"><input type="checkbox" name="status" value="<%=examId%>" onclick="available(this,'<%=sub%>','<%=status%>','<%=examType%>','<%=stuExamTable%>');return false;"></font></td>	

		<!--  edit asmt. metat data -->

		<td width="14" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><a href="#" onclick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>')"><font size="2" face="Arial"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" > </font></a></td>
	
		
		<!-- asmt conroller -->
		<%
			if (status==0 || status==3 ){
				mode="edit";
			}
		%>

		<td width="14" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><a href="ExamController.jsp?examName=<%=examName%>&examtype=<%=examType%>&examid=<%=examId%>&mode=<%=mode%>" onclick="						parent.toppanel.document.examform.examcategory.value='<%=examType%>'" target="bottompanel"><font size="2" face="Arial"><img border="0" src="images/ieditques.gif" TITLE="Assessment Controller"  ></font></a></td>

<%	}
%>
	<!-- This column is to reassigning -->
	
	<td width="14" height="18" bgcolor="<%=bgColor%>" align="center" valign="middle">
	<a href="ReassignExam.jsp?examName=<%=examName%>&examtype=<%=examType%>&workid=<%=examId%>&cat=reassign" 
	onclick="parent.toppanel.document.examform.examcategory.value='<%=examType%>'" target="bottompanel">
	<font size="2" face="Arial">
	<img border="0" src="images/reassign.gif" TITLE="Reassign Exam"></font></a></td>	
	
	<!-- This column is to reassigning -->

	<td width="200" bgcolor="<%= bgColor %>" height="21"><a href="#" onclick="showPapers('<%=examId%>'); return false;"><font size="2" face="Arial" color="<%=fgColor%>"> <%=examName%></a></font> </td>
	
	<td width="69" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=rc_date%></font></td>
    
	<td width="101" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=rf_date%>&nbsp;</font> </td>

	<td width="76" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=rt_date%>
      </font></td>

	<!-- the count of asmt. assigned students --> 
	 <td width="13" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=ass%></font></td>
	<!-- the count of asmt. submitted students --> 
	<%if(sub>0){%> 
			<td width="13" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><a href="javascript://" onclick="showsubmitfiles('<%=examId%>','<%=examName%>','<%=createDate%>');return false;"><%=sub%></a></font></td>
	<%}else{%>
			<td width="13" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=sub%></font></td>
	<%}%>
	<!-- the count of asmt. evaluated students --> 
 	 <td width="13" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=eval%></font></td>
	<!-- the count of asmt. pedning student for evaluating --> 
	 <%if ((flag.equals("0"))||(pen==0)) {%>
 	     <td width="13" bgcolor="<%= bgColor %>" height="21" align="center"><font size="2" face="Arial" color="<%=fgColor%>"><%=pen%></font></td>

	 <%}else{%>
		<td width="14" bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><a href="examTakenStu.jsp?examname=<%=examName%>&tablename=<%=stuExamTable%>&examid=<%=examId%>&examtype=<%=examType%>&totrecords=<%=(sub)-(eval)%>&start=0&scheme=<%=scheme%>" onclick="parent.toppanel.document.examform.examcategory.value='<%=examType%>'" target="bottompanel"><font face="Arial" size="2"><%=pen%></font></a></td>
	<%}%>
	</tr>	
  <%
	   }
	 }catch(Exception e){
		ExceptionsFile.postException("ExamsList.jsp","operations on database","Exception",e.getMessage());
		System.out.println(e.getMessage());
     }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && ! con.isClosed())
			con1.close(con);

			
		}catch(SQLException se){
			ExceptionsFile.postException("ExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());

		}

    }

		 %>
