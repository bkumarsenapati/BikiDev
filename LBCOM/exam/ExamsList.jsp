<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	synchronized private int getPages(int tRecords,int pageSize)
	{
		int noOfPages;
		if((tRecords%pageSize)>0)
		{
			noOfPages=(tRecords/pageSize)+1;
		}
		else
		{
			noOfPages=(tRecords/pageSize);
		}
		return noOfPages;
	}
%>
<% 
	int pageSize=150;
	String teacherId="",checkedTag;
	String examId="",examName="",schoolId="",cat="",clusterId="",widStr="",id3="";
	String courseId="";
	String gradeId="";
	String examType="";
	String linkStr="",noOfGrps="",ques="",fromDate="",toDate="";
	String fgColor="",bgColor="",random="",sort="",variations="",password="",scheme="",rt_date="",rc_date="",rf_date="";
	String stuExamTable="",createDate="",flag="",groupStatus="",sortStr="",sortingBy="",sortingType="",actStatus="0",mode="create";
	int marks=0,currentPage=0,status=0,maxAttempts=0,editStatus=0;
	int totRecords=0,start=0,end=0,c=0,ass=0,sub=0,pen=0,eval=0,totSub=0;
	boolean versionFlage=false,stuPassword=false,passwordFlage=false;
    Hashtable htSelAsmtIds=null,htUnAsgndAsmtIds=null;	
	String argSelIds,argUnSelIds;
//	ArrayList unAsgndAsmtIds=new ArrayList();
%>
<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if (s==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");
	gradeId=(String)session.getAttribute("classid");
   	con=con1.getConnection();
	clusterId=request.getParameter("clid");
	if(clusterId==null)
	{
		clusterId="";
	}

	examType=request.getParameter("examtype");
	//System.out.println("examType..."+examType);
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");

	if (sortingType==null)
		sortingType="A";
	
	versionFlage=false;

	if(request.getParameter("totrecords").equals(""))
	{
		htSelAsmtIds=null;
		session.putValue("seltAsmtIds",null);
		htUnAsgndAsmtIds=null;	
		session.putValue("unAsgndAsmtIds",null);

	}
	else
	{
		htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");
		htUnAsgndAsmtIds=(Hashtable)session.getAttribute("unAsgndAsmtIds");
	}
	
	if(htSelAsmtIds==null)
		   htSelAsmtIds=new Hashtable();

	if(htUnAsgndAsmtIds==null)
		htUnAsgndAsmtIds=new Hashtable();

	argSelIds=request.getParameter("checked");
	argUnSelIds=request.getParameter("unchecked");   

    if(argUnSelIds!="" & argUnSelIds!=null)
	{
		StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
		String id;
		
		while(unsel.hasMoreTokens())
		{
			id=unsel.nextToken();
		    if(htSelAsmtIds.containsKey(id))
				htSelAsmtIds.remove(id);
		}
	}
	if(argSelIds!="" && argSelIds!=null) 
	{
		StringTokenizer sel=new StringTokenizer(argSelIds,",");
		String id;			
		while(sel.hasMoreTokens())
		{
			id=sel.nextToken();
			htSelAsmtIds.put(id,id);
		}			
	}
	
	try 
	{
		if(request.getParameter("totrecords").equals("")) 
		{ 
		    session.removeValue("seltAsmtIds");
			session.removeValue("unAsgndAsmtIds");
			st=con.createStatement();
			if(examType.equals("all"))
			{
				rs=st.executeQuery("Select count(*) from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'");
			}
			else
			{
				rs=st.executeQuery("Select count(*) from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and exam_type='"+examType+"' and school_id='"+schoolId+"'");
			}
			
			rs.next();
			c=rs.getInt(1);
			if (c!=0 )
			{
				totRecords=rs.getInt(1);
			}
			else
			{
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No Assessment scheduled yet.</font></b></td></tr></table>");				
				return;
			}
			out.println("\n<SCRIPT LANGUAGE='JavaScript'> parent.asmtNotAsgnFlag=false;</SCRIPT>\n");
		}
		else
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
		
		if(request.getParameter("nrec")!=null)
		{
			pageSize=Integer.parseInt(request.getParameter("nrec"));
			if(pageSize==0)
			{
				pageSize=totRecords;					
			}
		}		

		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();

		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
		
		if(sortingBy==null || sortingBy.equals("null"))
		{
			sortStr="slno";
			sortingBy="en";
		}
		else
		{
			if(sortingBy.equals("en"))
				sortStr="exam_name";
			else if (sortingBy.equals("av"))
				sortStr="status";
			else if (sortingBy.equals("fd"))
				sortStr="from_date";
   			else if (sortingBy.equals("td"))
				sortStr="to_date";
			else if (sortingBy.equals("cd"))
				sortStr="create_date";
		    if (sortingType.equals("A"))
			{
				sortStr=sortStr+" asc";
				//sortingType="D";                  changed by Santhosh
			}
			else
			{
				sortStr=sortStr+" desc";
				//sortingType="A";                   changed by Santhosh
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

<script language="javascript" src="../validationscripts.js"></script> 
<title><%=application.getInitParameter("title")%></title>
<base target="main">

<link href="admcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
	var checked=new Array();
	var unchecked=new Array();
	var asmtNotAsgnFlag=false;
	var asgndFlag=false;
	function validate(actMode){			
		var flag;

	<% if(htSelAsmtIds.size()==0){	%>			
		var obj=document.fileslist;
		var flag=false;
		for(var i=0;i<obj.elements.length;i++){
		   if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="status" && obj.elements[i].checked==true){
						flag=true;
				   }
		   }

		if(flag==false){
		   alert("You have to select at least one item");
		   return false;
		}
	<%} %>
		getSelectedIds(actMode);

		if(actMode=="MA" && (asmtNotAsgnFlag==true || asgndFlag==true) ){
			if(confirm("Some of the Assessment(s) are not assigned to the students. Those assessment(s) can't be made available. Do you want  to continue?")==true)
				return true;
			else
				return false;
		}else			
		    return true; 
//			return true;
	}

   function getSelectedIds(actMode)
   {
	  var obj=document.fileslist;	
	  asmtNotAsgnFlag=false;
      for(i=0,j=0,k=0;i<obj.elements.length;i++)
		   {
		     if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="status"){
				 if(obj.elements[i].checked==true){
	                  checked[j++]=obj.elements[i].value;
					  if(actMode=="MA"){
						  for(var m=0;m<unAsgndAsmtIds.length;m++){
							  if(obj.elements[i].value==unAsgndAsmtIds[m]){
								  asmtNotAsgnFlag=true;							
							  }
								
						  }
					  }

				 }else 
					 unchecked[k++]=obj.elements[i].value;
			 }
		   }
	return true;
   }

   function selectAll(){
		var obj=document.fileslist.status;
		if(document.fileslist.selectall.checked==true){
			for(var i=0;i<obj.length;i++){
				obj[i].checked=true;
			}

		}else{
			for(var i=0;i<obj.length;i++){
				obj[i].checked=false;
			}

		}
	}
	function showStudents(wid)
{
	window.open("/LBCOM/exam/ShowAssStudentsList.jsp?examid="+wid,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
}

function createCluster(cat)
{
	var selid=new Array();
	var wids=0;
    with(document.fileslist)
	{
		for (var i=0,j=0; i < elements.length; i++)
		{
			if(elements[i].type == 'checkbox' && elements[i].name == 'status')
			{
				if(elements[i].checked==true)
				{
					selid[j++]=elements[i].value;
					wids=wids+1;
				}
				else
					wids=wids+1;
			}
		}
	}
    if(j>1)
	{
		if(confirm("Are you sure that you want to create a cluster with the selected assessments?")==true)
		{
			window.document.fileslist.nRec.value=cat;
			parent.bottompanel.location.href="AddCluster.jsp?totrecords=&start=0&cat="+cat+"&selids="+selid;
			return false;
		}
        else
			return false;
	}
	else
	{
		if(wids==0)
		{
			alert("There should be at least two assessments in order to create a cluster!");
			return false;
		}
		else
		{
			alert("You have to select at least two assessments to create a cluster!");
			return false;
		}
	}
}

function goCluster(cluster) // Selecting Clusters
{
	var clusterId=document.fileslist.cluster.value;
	parent.bottompanel.location.href="ExamsList1.jsp?clid="+clusterId+"&totrecords=&start=0&status=&examtype=all";
}

function manageCluster(cat) // Cluster Manager
{
	parent.bottompanel.location.href="ManageCluster.jsp?mode=manage&cat="+cat;
}

function createMap(eId,cDate) // Cluster Manager
{
	var selid=new Array();
	var eid=0;
        with(document.fileslist)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'status' && elements[i].checked==true)
					{
                     
							selid[j++]=elements[i].value;
							eid+=1;
					}
				}
         }
		 
    if(eid>0 && eid<2)
	{
		if(confirm("Are you sure that you want to map with the selected assessments?")==true)
		{
			//window.document.fileslist.nRec.value=cat;
			parent.bottompanel.location.href="../pretest/QuestionMapping.jsp?classid=<%=gradeId%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&examid="+selid+"&cdate="+cDate;
			return false;
		}
        else
			return false;
	}
	else
	{
		if(eid==0)
		{
			alert("Select one assessment in order to map to assessment!");
			return false;
		}
		else
		{
			alert("Select one assessment in order to map to assessment!");
			return false;
		}
	}
	
}
</SCRIPT>


<SCRIPT LANGUAGE="JavaScript">
<!--

	function editAsmt(examId,examType,crtdDate,actStatus,examName,noOfGrps,editStatus){	

				if(editStatus==1)	{
					if(confirm("Assessment editing involves a 5-step workflow. \n The edited assessment is  put in \"TmpList\". It is put back into the assessment \"List\" ONLY after it is \"published\" from within \"TmpList\". \n Ready to edit?")==true){
						parent.toppanel.document.examform.examcategory.value=examType;					
					
					//alert("/LBCOM/exam.CreateSaveExam?enabledMode=1&mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps+"&editStatus=1&overWriteFlag=0");
					parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?enabledMode=1&mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps+"&editStatus=1&overWriteFlag=0";
						return false;
					} else
						return false;
				} else if(editStatus==2){
					var flag=false;

					do{
					
					var rValue=prompt("Some of the students have already taken this assessment. \n Do you want to View or Copy of this Assessment? ( 1 - View ) ( 2 - Copy ) ","1");
							parent.toppanel.document.examform.examcategory.value=examType;											
					if(rValue==null)
						return false;

					rValue=trim(rValue);

					if(rValue==1){						
					flag=true;	parent.bottompanel.location.href="/LBCOM/exam/CEFrames.jsp?enableMode=0&editMode=edit&examId="+examId+"&examType="+examType+"&examName="+examName+"&status=5&noOfGrps="+noOfGrps;			
					
					
					}else if(rValue==2){
					flag=true;	parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?overWriteFlag=0&enabledMode=1&mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps+"&editStatus=2";		

					}else{
						flag=false;
						alert("Enter a valid value (1 or 2)");
						
					}
					
					}while(flag!=true);
					
					return false;					
				
				}				
				else if(editStatus==3){	

					var flag=false;

					do{
					
					var rValue=prompt("You already have a copy of this assessment in Tmp. List.\n Do you want to view or overwrite the record in TmpList?(1-View)(2-Overwrite)","1");

					parent.toppanel.document.examform.examcategory.value=examType;											
					
					if(rValue==null)
						return false;

					rValue=trim(rValue);

					if(rValue==1){						
						flag=true;	parent.bottompanel.location.href="/LBCOM/exam/CEFrames.jsp?enableMode=0&editMode=edit&examId="+examId+"&examType="+examType+"&examName="+examName+"&status=5&noOfGrps="+noOfGrps;								
					
					}else if(rValue==2){
						flag=true;	parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?overWriteFlag=1&mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps+"&editStatus=2";		

					}else{
						flag=false;
						alert("Enter a valid value (1 or 2)");
						
					}
					
					}while(flag!=true);
					
					return false;	

					
				/*	if(confirm("Do you want to view this Assessment details?")==true){											parent.bottompanel.location.href="/LBCOM/exam/CEFrames.jsp?enableMode=0&editMode=edit&examId="+examId+"&examType="+examType+"&examName="+examName+"&status=5&noOfGrps="+noOfGrps;
					return false;
					}else
						return false;
				*/
				
				}
				else if(editStatus==4){		
					if(confirm("You already have a copy of this assessment in Tmp. List.\nWould you like to ignore the partial modifications already made and overwrite the record in Tmp. List?")==true){		
					parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?overWriteFlag=1&mode=copy&selExId="+examId+"&examType="+examType+"&crtdDate="+crtdDate+"&actStatus="+actStatus+"&examName="+examName+"&noOfGrps="+noOfGrps+"&editStatus=2";
					
					return false;
					}else
						return false;
				}
				

	}

	function deleteAsmt(examId,examType,instTable){	

			if(confirm("Are you sure that you want to delete the assessment?")==true){

			parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?mode=remove&examid="+examId+"&examtype=<%=examType%>&instable="+instTable+"&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords-1%>&start=<%=start%>";
			return false;
			}
			else
				return false;

	}

// Santhosh changed this function on 29-11-06
	function showsubmitfiles(eid,ename,eType,scheme,crtdate)
	{
		parent.bottompanel.location.href="ShowSubmittedFiles.jsp?examid="+eid+"&examname="+ename+"&examtype="+eType+"&scheme="+scheme+"&createdate="+crtdate;
		return false;
	}
// Santhosh changed upto here on 29-11-06

	function showpendingfiles(eid,ename,eType,scheme,crtdate)
	{
		parent.bottompanel.location.href="show_pending_ass.jsp?examid="+eid+"&examname="+ename+"&examtype="+eType+"&scheme="+scheme+"&createdate="+crtdate;
		return false;
	}


   function showPapers(eid){
		 var paperswin=window.open("ExamPapersFrame.jsp?examid="+eid+"&type=teacher","Question","width=1000,height=600,scrollbars=yes resizable=yes");
		 paperswin.focus();
	}

	function assign(){
		if(validate("ASGN")==true){

parent.bottompanel.location.href="/LBCOM/exam/AsmtAsgn.jsp?nrec=<%=pageSize%>&examtype=<%=examType%>&checked="+checked+"&unchecked="+unchecked;
			return false;
		}
		
	}
	function moveto(to){
		getSelectedIds("move");		window.location="moveexams.jsp?checked="+checked+"&to="+to+"&totrecords=<%=request.getParameter("totrecords")%>&start=<%=request.getParameter("start")%>&examtype=<%=examType%>";
		return false;
				
	}

	function makeAvailable(mode,examId,examName){
		

//		asmtNotAsgnFlag=parent.asmtNotAsgnFlag;
		if(validate("MA")==true){
			
			if(mode=="UA"){			parent.bottompanel.location.href="/LBCOM/MakeAsmtAvailable?nrec=<%=pageSize%>&examtype=<%=examType%>&mode=UA&checked="+checked+"&unchecked="+unchecked;
			}else{	
				if(mode=="SL"){
					if(confirm("Modifying control information automcatically makes this assessment available to those to whom it is assigned. \n Ready to modify?")==true){
						parent.bottompanel.location.href="/LBCOM/exam/ExamControllerForBulk.jsp?examid="+examId+"&nrec=<%=pageSize%>&examtype=<%=examType%>&mode="+mode+"&checked="+checked+"&unchecked="+unchecked+"&examname="+examName;
						return false;

					}else
						return false;
			   }else{
						//parent.bottompanel.location.href="/LBCOM/exam/ExamControllerForBulk.jsp?examid="+examId+"&nrec=<%=pageSize%>&examtype=<%=examType%>&mode="+mode+"&checked="+checked+"&unchecked="+unchecked+"&examname="+examName;
						
						parent.bottompanel.location.href="/LBCOM/exam/AssManytoMany.jsp?examid="+checked+"&nrec=<%=pageSize%>&examtype=<%=examType%>&mode="+mode+"&checked="+checked+"&unchecked="+unchecked+"&examname="+examName+"&totrecords=&start=0";
						return false;
			   }
			
		   }
			
		}
	}


	function go(start,totrecords,eType,sortby,sorttype,nRec){	
		getSelectedIds("MA");
		
//	    parent.asmtNotAsgnFlag=asmtNotAsgnFlag;

		parent.bottompanel.location.href="ExamsList.jsp?nrec="+nRec+"&start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&sortby="+sortby+"&sorttype="+sorttype+"&checked="+checked+"&unchecked="+unchecked;
		return false;
	}

	function gotopage(totrecords,eType,sortby,sorttype,nRec){
		getSelectedIds("MA");
//	    parent.asmtNotAsgnFlag=asmtNotAsgnFlag;
		var page=document.fileslist.page.value;
		if (page==0){
			alert("Please select any page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			parent.bottompanel.location.href="ExamsList.jsp?nrec="+nRec+"&start="+ start+ "&totrecords="+totrecords+"&examtype="+eType+"&sortby="+sortby+"&sorttype="+sorttype+"&checked="+checked+"&unchecked="+unchecked;
			return false;
		}
	}

	function available(field,s,status,eType,insTable) {


		if (field.checked==true) { // make it available to the students

				if(status!=2 && status!=3){
					if (confirm("Are you sure that you want to make the Assessment available to the students?")) {
						parent.toppanel.document.examform.examcategory.value=eType;					  	parent.bottompanel.location.href="/LBCOM/exam.UpdateStatus?examid="+field.value+"&examtype="+eType+"&mode=AV&instable="+insTable+"&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>";
					}
				}else{
					alert("Please provide the Assessment controlling data");
				}

		}
		else {   // make it unavailable to the students

			if (s!=0){   // if the students are being attempted
				
				msg="Some students have taken the assessment already.\n You will loose all that information.\n Are you sure that you want to make the Assessment unavailable to the students?";

				if(confirm(msg)==true){
					parent.toppanel.document.examform.examcategory.value=eType;					  	parent.bottompanel.location.href="/LBCOM/exam.CreateSaveExam?examid="+field.value+"&mode=unavailable&instable="+insTable+"&examtype=<%=examType%>&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>";
				}else{
					field.checked=false;
					return false;
				}

			}
			else {  //  Asmt is not attempted by any student
				if (confirm("Are you sure that you want to make the Assessment unavailable to the students?")) {
					parent.toppanel.document.examform.examcategory.value=eType;	parent.bottompanel.location.href="/LBCOM/exam.UpdateStatus?examid="+field.value+"&examtype="+eType+"&mode=UA&instable="+insTable+"&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>";

				}
				field.checked==false;
				return false;
			}
		}

			

	
	}

	function setMarking()
{
        var selid=new Array();
        with(document.fileslist)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'status' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to set the Marking Periods?")==true)
			{
				parent.bottompanel.location.href="/LBCOM/exam/SetMarking.jsp?workids="+selid;
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the file(s) to set  Marking Period");
              return false;
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
    <td  >
      <font size="2">
      Assessments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
	  </td>
	  <td align="center">
<font size="2">
	  <%

	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"','"+sortingBy+"','"+sortingType+"','"+pageSize+"');return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+examType+"','"+sortingBy+"','"+sortingType+"','"+pageSize+"');return false;\">Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+examType+"','"+sortingBy+"','"+sortingType+"','"+pageSize+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  </font>
	  </td>
	  <td align='right' ><font size="2">Rec/Page
<%	  
		out.println("<select name='nRec' onchange=\"gotopage('"+totRecords+"','"+examType+"','"+sortingBy+"','"+sortingType+"',this.value);return false;\"> ");%>

			<option value=15>15</option>
			<option value=25>25</option>

			<option value=50>50</option>
			<option value=100>100</option>
			<option value=0>All</option>
		</select>
			  
	  
	  &nbsp;Page&nbsp;
	  <%
		int index=1;
		int begin=0;
		
		//int noOfPages=getPages(totRecords,pageSize);

		int noOfPages=(totRecords%pageSize);

		if(noOfPages>0)
			noOfPages=(totRecords/pageSize)+1;
		else
			noOfPages=(totRecords/pageSize);


		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"','"+examType+"','"+sortingBy+"','"+sortingType+"','"+pageSize+"');return false;\"> ");
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
  

</font>
	</td>
	<td  height='21' align='right' >
			<select id="cluster" name="cluster" onChange="goCluster('<%= cat%>')">	

<%
			rs2=st2.executeQuery("select cluster_id,cluster_name from assessment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' order by cluster_id");
			if(!rs2.next())
			{
%>
				<option value="none" selected>No Clusters</option>
<%
			}
			else
			{
%>
				<option value="none" selected>Select Cluster</option>
<%				do
				{
%>				
					<option value="<%=rs2.getString("cluster_id")%>"><%=rs2.getString("cluster_name")%></option>
<%
				}while(rs2.next());
			}
%>
			</select>
		</td>
  </tr></table>
  </td>
   <tr>
   
   <%	 
      String bgColorAv="#CECBCE",bgColorEn="#CECBCE",bgColorCd="#CECBCE",bgColorFd="#CECBCE",bgColorTd="#CECBCE";	 
      if(sortingBy.equals("av"))
      {     bgColorAv= "#CBCBEE";     }
      if(sortingBy.equals("en"))	 
	{      bgColorEn= "#CBCBEE";   }
      if(sortingBy.equals("cd"))
      {     bgColorCd= "#CBCBEE";     }
      if(sortingBy.equals("fd"))	 
	{      bgColorFd= "#CBCBEE";   }
      if(sortingBy.equals("td"))
      {     bgColorTd= "#CBCBEE";     }
   %>	 

	
<!--	<td width="17" bgcolor='<%=bgColorAv%>' align="right" valign="middle">
         <% 
		
	if((sortingType.equals("D"))&&(sortingBy.equals("av"))){
    
		 %>
   	   <a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=av&sorttype=A" target="_self"><img  border="0" src="images/sort_dn_1.gif" ></td>
         <%   }else{  %>
	 <a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=av&sorttype=D" target="_self"><img  border="0" src="images/sort_up_1.gif" ></td>
         <%   }  %>

-->
<td class="gridhdr"><input type="checkbox" name="selectall" onClick="javascript:selectAll()" ></td>
	 
    <td class="gridhdr">
	<a href="#" onclick="return setMarking();">
    <img border="0" src="images/marking.gif" TITLE="Set Marking Period" width="19" height="21"></td>
	<td class="gridhdr">&nbsp;</td>
    <td class="gridhdr">&nbsp;</td>
<!-- This colmn is to reassigning -->
	 <td class="gridhdr">&nbsp;</td>
<!-- This colmn is to reassigning -->
	<td class="gridhdr">
	 <%  if((sortingType.equals("D"))&&(sortingBy.equals("en"))){
         %>
   	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=en&sorttype=A&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_dn_1.gif"></a>
	 <%   }else{  %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=en&sorttype=D&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_up_1.gif"></a>
	<%   }  %>
	Assessment Name</td>

    <td class="gridhdr">
	<%  if((sortingType.equals("D"))&&(sortingBy.equals("cd"))){
         %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=cd&sorttype=A&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_dn_1.gif"></a>
     <%   }else{  %>
        <a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=cd&sorttype=D&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_up_1.gif"></a>
    <%   }  %>
    Date</td>
    
    <td class="gridhdr">
	<%  if((sortingType.equals("D"))&&(sortingBy.equals("fd"))){
         %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=fd&sorttype=A&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_dn_1.gif"></a>
        <%   }else{  %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=fd&sorttype=D&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_up_1.gif"></a>
       <%   }  %>
       From&nbsp; </td>
    
    <td class="gridhdr">
	<%  if((sortingType.equals("D"))&&(sortingBy.equals("td"))){
         %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=td&sorttype=A&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_dn_1.gif"></a>
	<%   }else{  %>
	<a href="./ExamsList.jsp?totrecords=<%=totRecords%>&start=0&examtype=<%=examType%>&sortby=td&sorttype=D&nRec=<%=pageSize%>" target="_self"><img border="0" src="images/sort_up_1.gif"></a>
        <%   }  %>
	To </td>
	
	 <td class="gridhdr"><b><img border="0" src="images/idassign.gif" TITLE="Number of students for whom the Assessment is scheduled" ></b></td>
	 <td class="gridhdr"><b><img border="0" src="images/idsubmit.gif" TITLE="Number of students who took the Assessment" ></font></b></td>
 	 <td class="gridhdr"><b><img border="0" src="images/ideval.gif" TITLE="Number of responses (manually) evaluated" ></b></td>
 	 <td class="gridhdr"><b><img border="0" src="images/idpending.gif" TITLE="Number of responses pending for evaluation" ></b></td>
	
	</tr>
	<%
		rs3=st3.executeQuery("Select work_ids from assessment_clusters where  school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and cluster_id='"+clusterId+"' and work_ids!='null'");

		if(rs3.next())
		{
			widStr=rs3.getString("work_ids");
			StringTokenizer widTokens=new StringTokenizer(widStr,",");
			while(widTokens.hasMoreTokens())
			{
				id3=widTokens.nextToken();
				c++;
			}
			
			if(c==0)
			{
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'><b><font face='verdana' color='#FF0000' size='2'>There are no assessments available.</font></b></td></tr></table>");				
				return;
			}
			else
				{
						totRecords=c;
				 }
		}
	%>
	<%


		while (rs.next()) 
		{
		     examId=rs.getString("exam_id");
			 examName=rs.getString("exam_name");
			 examName=examName.replaceAll("&#39;","&#92;&#39;");
			 examType=rs.getString("exam_type");
			 scheme=rs.getString("grading");
			 rf_date=rs.getString("rf_date");
			 rt_date=rs.getString("rt_date");
			 rc_date=rs.getString("rc_date");
			 createDate=rs.getString("create_date");
			 fromDate=rs.getString("from_date");
			 maxAttempts=rs.getInt("mul_attempts");
			 editStatus=rs.getInt("edit_status");

			
			/*
			// oh.learnbeyond.net:8080 problem with images
			// Added code from here by Santhosh On 11-11-11

				
			String appPath = application.getInitParameter("app_path");

			String disPath = (String)session.getAttribute("schoolpath")+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/1.html";
			
			//String disPath=(String)session.getAttribute("schoolpath")+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/e0008/1.html";
             
			//System.out.print("appPath...."+appPath);
			//System.out.print("disPath...."+disPath); 
			String message="";
			
			disPath = disPath.replaceFirst("/LBCOM","/"); 
			

			// Physical email file reading from here
			
			File fwdMsgFile = new File(appPath+disPath);
			   if((fwdMsgFile.exists())&&(fwdMsgFile.isFile()))
			   {
						Reader fr = new FileReader(fwdMsgFile); 
				BufferedReader br = new BufferedReader(fr);
				String buff = br.readLine();
				while(buff!=null)
				{
					message = message + "\n" + buff;
					buff = br.readLine();
					//System.out.println("message...."+message);
				}
			   
			   //message=message.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
			   message=message.replaceAll("=/LBCOM","=\"/LBCOM");
			  RandomAccessFile XMLDataRead=null;
			  XMLDataRead=new RandomAccessFile(appPath+disPath,"rw");
			  XMLDataRead.writeBytes(message);
			  XMLDataRead.close();
			   }
						
	

			// Upto here

*/
			 if(fromDate==null){
				 fromDate="-";
			 }
			 if(rf_date==null){
				 rf_date="0000-00-00";
			 }
			 if(rt_date==null){
				 rt_date="0000-00-00";
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


				
rs1=st1.executeQuery("select count(*) from "+schoolId+"_cescores as ces inner join coursewareinfo_det cd on cd.student_id=ces.user_id and cd.school_id='"+schoolId+"' and cd.course_id='"+courseId+"'  where ces.school_id='"+schoolId+"' and work_id='"+examId+"' and report_status!=2");
				


			if (rs1.next()) 
				ass=rs1.getInt(1);

			if(ass==0){
				bgColor="#ECECF9";
				htUnAsgndAsmtIds.put(examId,examId);
			}

			 //*  the count of asmt. submitted students --> 
//			 rs1=st1.executeQuery("Select count(*) from "+stuExamTable+" where exam_id='"+examId+"' and  status = 1 or status = 2");

 rs1=st1.executeQuery("select count(distinct st.student_id) from "+stuExamTable+" as st inner join coursewareinfo_det cd on st.student_id=cd.student_id and school_id='"+schoolId+"' and course_id='"+courseId+"' and status=1 or status = 2");


			 if (rs1.next())
				sub=rs1.getInt(1);
rs1.close();
			//* the count of asmt. evaluated students --> 
			 rs1=st1.executeQuery("Select count(*) from "+stuExamTable+" where exam_id='"+examId+"' and  status = 2");			 


// rs1=st1.executeQuery("select count(distinct st.student_id) from "+stuExamTable+" as st inner join coursewareinfo_det cd on st.student_id=cd.student_id and school_id='"+schoolId+"' and course_id='"+courseId+"' and status = 2");


			 if (rs1.next())
				 eval=rs1.getInt(1);

			rs1.close();
			//  pending 

			 rs1=st1.executeQuery("Select count(*) from "+stuExamTable+" where exam_id='"+examId+"' and  status = 1");			 


//			 rs1=st1.executeQuery("select count(distinct st.student_id) from "+stuExamTable+" as st inner join coursewareinfo_det cd on st.student_id=cd.student_id and school_id='"+schoolId+"' and course_id='"+courseId+"' and status=1");

			 if (rs1.next())
				pen=rs1.getInt(1);
 
			//* the count of asmt. pedning student for evaluating 
	rs1.close();		
		//	 pen=totSub-eval;

			 if (sub>0)
				 actStatus="1";
			 else
				 actStatus="0";

			status=rs.getInt("status");
			mode="create";

		   %>
	<tr>	
	<% 
		   checkedTag="";
		   if (htSelAsmtIds.containsKey(examId)){
			checkedTag="checked";	
		   }

	if (status==1){
		   
	   		htSelAsmtIds.put(examId,examId);

	   %>

	<!--  Make it available/unavailable to students. -->
	
		<td  class="griditem"><input type="checkbox" name="status" value="<%=examId%>" ></td>		

		<!--  edit asmt. metat data -->

		<% if (actStatus.equals("1"))  { %>

		<!--  edit asmt. metat data -->

			<%if(editStatus==0) { %>
				<td class="griditem"><a href="#" onclick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',2)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" ></td>
			<%} else {%>
				<td  class="griditem"><a href="#" onclick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',3)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details"  ></td>

			<% } %>
		
		<% } else { %>

			<td  class="griditem"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" onClick="alert('Please make it unavailable to students first.');return false;" ></a></td>
		<% } %>

		<!-- delete asmt.  -->

		<td  class="griditem"><img border="0" src="images/idelete.gif" TITLE="Delete Assessment " onClick="alert('Please make it unavailable to students first.');return false;" ></a></td>

		<!-- Controller -->

		<td  class="griditem"><img border="0" src="images/ieditques.gif" onClick="alert('Please make it unavailable to students first.');return false;"  TITLE="Assessment Controller"  ></a></td>



	<% } else {%>
		

		<!--  Make it available/unavailable to students. -->

		<td  class="griditem"><input type="checkbox" <%=checkedTag%> name="status" value="<%=examId%>" ></td>	
		

		<% if (actStatus.equals("1")) { %>

		<!--  edit asmt. metat data -->

			<%if(editStatus==0) { %>
				<td  class="griditem"><a href="#" onclick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',2)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" ></td>
			<%} else {%>
				<td  class="griditem"><a href="#" onclick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',3)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details"  ></td>

			<% } %>
		<!-- delete asmt.  -->

			<td  class="griditem"><img border="0" src="images/idelete.gif" TITLE="Delete Assessment " onClick="alert('You cannot delete this assessments. Some of the students have already taken this assessment.');return false;" ></a></td>

		<% } else { %>
				
		<!--  edit asmt. metat data -->

			<% if (editStatus==0) { %>	
					<td  class="griditem"><a href="#" onClick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',1)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details" ></a></td>
			<% } else { %>
					<td  class="griditem"><a href="#" onClick="return editAsmt('<%=examId%>','<%=examType%>','<%= createDate.replace('-','_')%>','<%=actStatus%>','<%=examName%>','<%=noOfGrps%>',4)"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment Details"  > </a></td>

			<% } %>	

		<!--  delete assessment -->
		
		<td class="griditem"><a href="#" onClick="return deleteAsmt('<%=examId%>','<%=examType%>','<%=stuExamTable%>')"><img border="0" src="images/idelete.gif" TITLE="Delete Assessment Details" > </a></td>


		<% } %>

		<!-- Controller -->

		<% if(ass!=0) { %>
		<td class="griditem"><a href="#" onClick="makeAvailable('SL','<%=examId%>','<%=examName%>');return false;" ><img border="0" src="images/ieditques.gif" TITLE="Assessment Controller" ></a></td>

		<% } else { %>
			<td  class="griditem"><img border="0"  onclick="alert('This assessment is not assigned to students yet.'); return false;" src="images/ieditques.gif" TITLE="Assessment Controller"  ></td>
		<% } %>

<%	}
		%>
		
	
	
	<!-- This column is to reassigning -->
	
	<td class="griditem">
	<a href="StudentsListForAsmt.jsp?examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&stulsttype=A&asmtstutbl=<%=stuExamTable%>&examstatus=<%=status%>&maxattempts=<%=maxAttempts%>&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>&nrec=<%=pageSize%>" onClick="parent.toppanel.document.examform.examcategory.value='<%=examType%>';" target=bottompanel>
	<font size="2" face="Arial">
	<img border="0" src="images/reassign.gif" TITLE="Assign/Unassign/Reassign to students"></font></a></td>	
	
	<!-- This column is to reassigning -->

	<td class="griditem"><a href="#" onClick="showPapers('<%=examId%>'); return false;"> <%=examName.replaceAll("&#92;&#39;","&#39;")%></a> </td>
	
	<td class="griditem"><%=rc_date%></td>
    
	<td class="griditem"><%=rf_date%>&nbsp;</td>

	<td class="griditem"><%=rt_date%>
      </td>

	<!-- the count of asmt. assigned students --> 
	 <td class="griditem"><a href="#" onclick="showStudents('<%=examId%>'); return false;"><%=ass%></td>
	<!-- the count of asmt. submitted students --> 
<%
	if(sub>0)
	{
%> 
		<td class="griditem"><a href="javascript://" onClick="showsubmitfiles('<%=examId%>','<%=examName%>','<%=examType%>','<%=scheme%>','<%=createDate%>');return false;"><%=sub%></a></td>
<%
	}
	else
	{
%>
		<td class="griditem"><%=sub%></td>
<%
	}
%>
	<!-- the count of asmt. evaluated students --> 
 	 <td class="griditem"><%=eval%></td>
	<!-- the count of asmt. pedning student for evaluating --> 
<%
	if ((flag.equals("0"))||(pen==0)) 
	{
%>
 	     <td class="griditem"><%=pen%></td>

<%
	}
	else
	{
%>
<!--		<td width="14" bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><a href="examTakenStu.jsp?examname=<%=examName%>&tablename=<%=stuExamTable%>&examid=<%=examId%>&examtype=<%=examType%>&totrecords=<%=pen%>&start=0&scheme=<%=scheme%>" onclick="parent.toppanel.document.examform.examcategory.value='<%=examType%>'" target="bottompanel"><font face="Arial" size="2"><%=pen%></font></a></td> 
 -->

	<td class="griditem"><a href="javascript://" onClick="showpendingfiles('<%=examId%>','<%=examName%>','<%=examType%>','<%=scheme%>','<%=createDate%>');return false;"><%=pen%></a></td>
		<!-- <td width="14" bgcolor="<%= bgColor %>" height="18" align="center" valign="middle">
			<font face="Arial" size="2"><%=pen%></font></td>  -->
<%
	}
%>
	</tr>	
<%
	   }
%>

</table>
<table><tr>
<script>
		document.fileslist.nRec.value="<%=cat%>";	
</script>

<td align="left"><font face=arial size="2">Action on selected assessments: </font><a href="#" onClick="assign();return false;" ><!-- <font face=arial size="2">Assign</font></a>&nbsp;/&nbsp; --><a href="#" onclick="makeAvailable('AM','','');return false;" ><font face=arial size="2">Make Available</font></a>&nbsp;/&nbsp;<a href="#" onClick="makeAvailable('UA','','');return false;" ><font face=arial size="2">Make Unavailable</font></a>&nbsp;/&nbsp;<a href="#" onClick="createCluster('<%= cat%>');return false;" ><font face=arial size="2">Create Cluster</font></a>&nbsp;/&nbsp;<a href="#" onClick="manageCluster('<%= cat%>');return false;" ><font face=arial size="2">Manage Cluster</font></a><font face=arial size="2">&nbsp; to students</font></td>
<tr>
<td>
<%
			System.out.println("&&&&........examType..."+examType);
			
				if(examType.equals("PT"))
		{
	%>
		<a href="javascript://" onClick="createMap('<%=examId%>','<%=createDate%>');return false;" >Map</a>
		<%
	}%>

</td></tr></table></form></body>

<%
		out.println("<script>");
		if(pageSize>=totRecords)
			out.println("window.document.fileslist.nRec.value='0';");
		else
			out.println("window.document.fileslist.nRec.value='"+pageSize+"';\n");

		out.println("var unAsgndAsmtIds=new Array();\n");
		int i=0,j=0;
		String asmtId="";
		for(Enumeration asmtIds=htUnAsgndAsmtIds.keys();asmtIds.hasMoreElements();i++)
		{
			asmtId=htUnAsgndAsmtIds.get(asmtIds.nextElement()).toString();
			out.println("unAsgndAsmtIds["+i+"]='"+asmtId+"';\n");
			if(htSelAsmtIds.containsKey(asmtId)==true && j==0)
			{
				out.println("asgndFlag=true;\n");
				j=1;
			}
		}
		out.println("</script>");
	
		session.putValue("seltAsmtIds",htSelAsmtIds);
		session.putValue("unAsgndAsmtIds",htUnAsgndAsmtIds);		
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ExamsList.jsp","operations on database","Exception",e.getMessage());
		System.out.println("ExamsList.jsp"+e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && ! con.isClosed())
			con1.close(con);
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("ExamsList.jsp"+se.getMessage());
		}
    }
%>
