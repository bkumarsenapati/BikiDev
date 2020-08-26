
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%

Connection con=null;
Statement st=null,st1=null,st2=null,st7=null,st8=null;
ResultSet  rs=null,rs1=null,rs2=null,rs7=null,rs8=null;


Vector courseNames=null,schoolNames=null,courseIds=null,teachers=null;		     				//stores the coursenames alloted to the student
//Vector assWorkIds,matWorkIds,courseIds;

int inboxItems=0;					//total no.of new items in the studnet inbox
int newAssItems=0,totalAssItems=0;				//total no.of new AS+HW+PW
int newMatItems=0;				//total no.of new CO+CM+RB+MI
int newResults=0;					//total no of new Results
int len=0,i=0;
int newExams=0,totalExams=0;
int newMidExams=0;
int newFinals=0;
boolean flag=false;					//false if there are no courses for the student

String courseName="",classId="",studentName="",studentId="",schoolId="",courseId="",workId="",examId="",createDate="",examType="";
String tableName="",teacherId="",crossRegisterFlag="";
String newSchoolId="",cId="",cName="";
String cid="",status="NA";                           // added by santhosh for usage report
%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0); 
%>
<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	String sessionStatus=(String)session.getAttribute("sessionstatus");
	System.out.println("**************************");
	System.out.println("Student sessionStatus..."+sessionStatus);
	if(sessionStatus==null)
	{
		
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		studentName=(String)session.getAttribute("studentname");
		classId=(String)session.getAttribute("classid");
		/*
		schoolId=(String)session.getAttribute("originalschoolid");
		studentId=(String)session.getAttribute("originalemailid");
		studentName=(String)session.getAttribute("originalstudentname");
		classId=(String)session.getAttribute("originalclassid");
		*/
		
	}
	else
	{
		schoolId=(String)session.getAttribute("originalschoolid");
		studentId=(String)session.getAttribute("originalemailid");
		studentName=(String)session.getAttribute("originalstudentname");
		classId=(String)session.getAttribute("originalclassid");
	}
		
		System.out.println("Student schoolId..."+schoolId);
		System.out.println("Student studentId..."+studentId);
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st7=con.createStatement();
	st8=con.createStatement();
	rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
	if(rs.next())
	{
		crossRegisterFlag=rs.getString("crossregister_flag");
	}
	rs.close();
	st.close();
	st=con.createStatement();
	if(crossRegisterFlag.equals("1"))
	{
		rs=st.executeQuery("select schoolid from studentprofile where username='"+schoolId+"_"+studentId+"'");
		schoolNames=new Vector();
		while(rs.next())
		{
			schoolNames.add(rs.getString("schoolid"));
		}
		rs.close();
		st.close();
	}
	//// This is for teacher to view his own courses when he try to view virtual student courses
	String sview_string="";
	if(crossRegisterFlag.equals("3"))
	{
		String lu=(String)session.getAttribute("Login_user");
		if(!lu.equals(""+studentId+""))
			sview_string="and c.teacher_id='"+lu+"'";
		
	}
	/// end  and check for sview_string
	st=con.createStatement();
	
	rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and class_id='"+classId+"'"+sview_string);
	
	courseNames=new Vector();
	courseIds=new Vector();
	teachers=new Vector();

	while (rs.next()) 
	{		
		courseNames.add(rs.getString("course_name"));
		courseIds.add(rs.getString("course_id"));
		teachers.add(rs.getString("teacher_id"));
	}
	rs.close();
	st.close();
%>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function takePretest(courseName,courseId)
{
	if(confirm("Are you sure that you want to take the pretest now?")==true)
	{
		window.open("/LBCOM/pretest/student/StudentExamPaper.jsp?courseid="+courseId+"&coursename="+courseName,"Document","resizable=yes,scrollbars=yes,width=900,height=600,toolbars=no");
		//window.location.href="/LBCOM/pretest/student/StudentExamPaper.jsp?courseid="+courseId+"&coursename="+courseName;
	}
	else
		return;
}

function evalPending(courseName,courseId)
{
	alert("The pretest is not yet evaluated by your teacher. Please contact your teacher.");
	return;
}

function pretestEvaluated(courseName,courseId,cbName)
{
		
	/*if(confirm("The pretest has been evaluated by your teacher already. Do you want to see the results?")==true)
	{
		//window.open("/LBCOM/pretest/student/EvaluatedPretest.jsp?studentid=<%=studentId%>&courseid="+courseId+"&coursename="+courseName,"Document","resizable=yes,scrollbars=yes,width=900,height=600,toolbars=no");
		//window.location.href="/LBCOM/pretest/student/StudentExamPaper.jsp?courseid="+courseId+"&coursename="+courseName;
	}
	else*/
	
		window.open("/LBCOM/schools/<%=schoolId%>/<%=studentId%>/coursemgmt/"+courseId+"/CD/"+cbName+"/Lessons.html","Document","resizable=yes,scrollbars=yes,width=900,height=600,toolbars=no");

	
		return;
}

function changesession(cName,cId,sId,stId,stName,clId,mode,type)
{
		
	//$("#nav_main li").removeClass('selected');showLoading('grid');$("#live_board").addClass('selected');grid_content.load("/LBCOM/CourseHomeMain.jsp?schoolid="+sId+"&emailid="+tId+"", hideLoading);
	cName=cName.replace(/ /g,"+");
	stName=stName.replace(/ /g,"+");
	$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/student/CourseHomeMain.jsp?courseid="+cId+"&coursename="+cName+"&schoolid="+sId+"&studentid="+stId+"&studentname="+stName+"&classid="+clId+"&mode="+mode+"&page_type="+type+"", hideLoading);
	
}

//-->
</script>

<link href="images/style.css" rel="stylesheet" type="text/css" />
<link href="admcss.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
	<!--
       	function setMatVar(course_id)
       	{
			frames['left'].asgncid='';
			frames['left'].asmtcid='';
			frames['left'].studycid = course_id;
			frames['left'].temp = 'study';

       } 
       
       function setAsgnVar(course_id)
       {
		  frames['left'].studycid='';
		  frames['left'].asmtcid='';
		  frames['left'].asgncid = course_id;
		  frames['left'].temp = 'assignment';
		  
       }
       
       function setAsmtVar(course_id)
       {
          frames['left'].studycid='';
		  frames['left'].asgncid='';
		  frames['left'].asmtcid = course_id;
          frames['left'].temp = 'assessment';
       }   
 	  
       function setVar()
       {
          parent.frames['left'].temp = 'other';
       }    
	//-->	   
</script>
<form id="courseslist">
<table border="0" width="100%" align="center" cellspacing="2" bordercolor="#ffffff" cellpadding="2">

<tr>
	<td class="gridhdr">
		<img src="/LBCOM/coursemgmt/student/images/course information.png" width="16" height="16" border="0">
	</td>
	<td class="gridhdr">
		<img src="/LBCOM/coursemgmt/student/images/web_inks.png" width="22" height="22" border="0">
	</td>
    <td class="gridhdr">
		Available Courses <br>
	</td>
	<td class="gridhdr">
		Assignments
	</td>
	<td class="gridhdr">
		Assessments
	</td>
	<td class="gridhdr">
		Pretest
	</td>
</tr>
<%
	for(int j=0;j<courseNames.size();j++)		    // for each course	
	{
		courseName=(String)courseNames.get(j);
		courseId=(String)courseIds.get(j);
		teacherId=(String)teachers.get(j);
		cid = schoolId + "/" + courseId;              // added by santhosh
		inboxItems=0;
		newAssItems=0;
		newResults=0;
		totalAssItems=0;
		totalExams=0;
		st=con.createStatement();

		rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from "+schoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+schoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+studentId+"'  and d.status!=5 where w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");
		int sts=0,cnt=0;	
		
		while(rs.next()) 
		{
			sts=rs.getInt("status");
			cnt=rs.getInt("cnt");
			if(sts==4)
				newResults+=cnt;
			if(sts==0)
				newAssItems=cnt; 
			totalAssItems+=cnt;
		}
		rs.close();	
		st.close();
		
		inboxItems=newAssItems+newResults;	//new items in the inbox
		
		//
			rs2=st2.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.status='1' and (d.start_date<=curdate())");
			if(rs2.next())
			{
				totalAssItems=rs2.getInt(1);
			}
			rs2.close();


		//
		st=con.createStatement();

		rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and d.status=0 and d.student_id='"+studentId+"'");
		newMatItems=0;		
		if(rs.next()) 
		{
			newMatItems+=rs.getInt(1);   
		}					
		inboxItems+=newMatItems;	        //new items in Inbox				
		rs.close();
		st.close();

		st=con.createStatement();
		rs=st.executeQuery("select s.exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+schoolId+"_"+studentId+" as s ,"+schoolId+"_cescores as c where e.exam_id=s.exam_id and e.exam_id=c.work_id and c.user_id='"+studentId+"' and c.course_id='"+courseId+"' and c.report_status=1 and e.course_id='"+courseId+"' and e.school_id='"+schoolId+"' and e.status='1' and s.start_date is NOT NULL and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() or e.to_time<=curtime())) group by s.exam_status");

		sts=0;cnt=0;
		newExams=0;
		while(rs.next())
		{
			sts=rs.getInt("status");
			cnt=rs.getInt("cnt");
			if(sts==0)
				newExams=cnt; 
			totalExams+=cnt;
		}
		rs.close();
		st.close();

		st=con.createStatement();		
		status="NA";
		rs=st.executeQuery("select status from pretest_student_material_distribution where school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id='"+studentId+"'");
		if(rs.next())
		{
			status=rs.getString("status");
		}

		rs.close();	
		st.close();
		
		rs7=st7.executeQuery("select cb_courseid from pretest_lms where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		if(rs7.next())
		{
			cId=rs7.getString("cb_courseid");
		}
		rs7.close();	
		rs8=st8.executeQuery("select course_name from dev_course_master where course_id='"+cId+"'");
		if(rs8.next())
		{
			cName=rs8.getString("course_name");
		}
		rs8.close();	
		inboxItems+=newExams;
%>
<!--To display the course name, new items in a tabular format   -->
 <!-- <table border="1" width="682" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333">  -->
		<tr>
			<td class="griditem">
				<!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CO" Title="Course Information" onMouseOut="MM_swapImgRestore()" onClick="javascript: setVar();" onMouseOver="MM_swapImage('Image39','','images/images/info-over.gif',1)">
				<img src="images/course information.png" width="16" height="16" border="0"></a> -->
				<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','CO'); setMatVar('<%=cid%>');"><img src="/LBCOM/coursemgmt/student/images/course information.png" width="16" height="16" border="0"></span></font></a>
			</td>
			<td class="griditem">
				<!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=WL" Title="Weblinks" onClick="javascript: setVar();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','images/images/weblinks-over.gif',1)">
				<img src="images/web_inks.png" width="16" height="16" border="0"></a> -->
				<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','WL'); setVar();"><img src="/LBCOM/coursemgmt/student/images/web_inks.png" width="22" height="22" border="0"></span></font></a>
			</td>
			<td class="griditem">
				<!-- <a href="/LBCOM/coursemgmt/student/CourseHomeMain.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CM" Title="Course Material"  onclick="javascript: setMatVar('<%=cid%>');">
				<font face="Arial" size="2"><%=courseName%></font></a> -->
				<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','CM'); setMatVar('<%=cid%>');"><%=courseName%></span></font></a>
			</td>
<%
		if(totalAssItems == 0)
		{
%>

			<td class="griditem">NA</td>
<%
		}
		else
		{	
%>
		<td class="griditem">
			<!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=AS" TITLE="Assignments" onClick="javascript: setAsgnVar('<%=cid%>');">
			<%=newAssItems%>/<%=totalAssItems%></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','AS'); setAsgnVar('<%=cid%>');"><%=newAssItems%>/<%=totalAssItems%></span></font></a>
		</td>
<%
		}	
%>
<%
		if(totalExams==0)
		{
%>				
		<td class="griditem">NA</td>
<%
		}
		else
		{
%>
		<td class="griditem">
			<!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=EX" TITLE="Assessments" onClick="javascript: setAsmtVar('<%=cid%>');">
			<%=newExams%>/<%=totalExams%></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','EX'); setAsmtVar('<%=cid%>');">
			<%=newExams%>/<%=totalExams%></span></font></a>
		</td>
<%
		}	
			//System.out.println("Pretest status is..."+status);
		if(status.equals("NA"))
		{
%>
		<td class="griditem">NA</td>
<%
		}
		else if(status.equals("0"))
		{
%>
		<td class="griditem">
			<a href="#" onClick="takePretest('<%=courseName%>','<%=courseId%>');return false;">Pretest</a>
		</td>
<%
		}	
		else if(status.equals("1"))
		{
%>
		<td class="griditem">
			<a href="#" onClick="evalPending('<%=courseName%>','<%=courseId%>');return false;">Pretest</a>
		</td>
<%
		}	
		else if(status.equals("2"))
		{
%>
		<td class="griditem">
			<a href="#" onClick="pretestEvaluated('<%=courseName%>','<%=courseId%>','<%=cName%>');return false;">Pretest</a>
		</td>
<%
		}	
%>
    </tr>
<% 
		flag=true;
	}
%>
</table>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<%
	if(crossRegisterFlag.equals("1"))
	{
		for(int k=0;k<schoolNames.size();k++)
		{
			newSchoolId=(String)schoolNames.get(k);
%>
<%
			st=con.createStatement();
			rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+schoolId+"_"+studentId+"' and c.status=1 and c.school_id='"+newSchoolId+"' and class_id='"+classId+"'");
			
			courseNames=new Vector();
			courseIds=new Vector();
			teachers=new Vector();

			while (rs.next()) 
			{		
				courseNames.add(rs.getString("course_name"));
				courseIds.add(rs.getString("course_id"));
				teachers.add(rs.getString("teacher_id"));
			}
			rs.close();
			st.close();
%>
<%
			for(int j=0;j<courseNames.size();j++)		    // for each course	
			{
				courseName=(String)courseNames.get(j);
				courseId=(String)courseIds.get(j);
				teacherId=(String)teachers.get(j);
				cid = newSchoolId + "/" + courseId;        // added by santhosh
				inboxItems=0;
				newAssItems=0;
				newResults=0;
				totalAssItems=0;
				totalExams=0;
				st=con.createStatement();
				rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from  "+newSchoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join "+newSchoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+schoolId+"_"+studentId+"' where (d.start_date<=curdate() and w.to_date>=curdate()) or ( w.to_date='0000-00-00' and d.start_date<=curdate()) and d.status!=5 group by status");
				int sts=0,cnt=0;
				
				while(rs.next()) 
				{
					sts=rs.getInt("status");
					cnt=rs.getInt("cnt");
					if(sts==4)
						newResults+=cnt;
					if(sts==0)
						newAssItems=cnt; 
					totalAssItems+=cnt;
				}
				rs.close();
				st.close();
				inboxItems=newAssItems+newResults;	//new items in the inbox
					
			   st=con.createStatement();
				rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+newSchoolId+"' and d.school_id='"+newSchoolId+"' and d.status=0 and d.student_id='"+schoolId+"_"+studentId+"'");

				newMatItems=0;
				
				if(rs.next()) 
				{
					newMatItems+=rs.getInt(1);   
				}
							
				inboxItems+=newMatItems;	        //new items in Inbox					
				rs.close();
				st.close();
				st=con.createStatement();
				rs=st.executeQuery("select exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+newSchoolId+"_"+schoolId+"_"+studentId+" as s on e.exam_id=s.exam_id where e.course_id='"+courseId+"' and e.school_id='"+newSchoolId+"' and e.status='1' and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() and e.to_time<=curtime())) group by exam_status");	
				sts=0;cnt=0;
				newExams=0;
				while(rs.next()){
					sts=rs.getInt("status");
					cnt=rs.getInt("cnt");
					if(sts==0)
						newExams=cnt; 
					totalExams+=cnt;
				}
				rs.close();
				st.close();

				inboxItems+=newExams;
%>
		<!--To display the course name, new items in a tabular format   -->
				
	<table border="0" width="682" align="center" cellspacing="2"  cellpadding="2" height="106">
    <tr>
        <td class="gridhdr" colspan="5"><font face="Arial"><span style="font-size:11pt;">&nbsp;<img src="/LBCOM/coursemgmt/student/images/book_accept.png" width="24" height="24" border="0" align="absmiddle"> Courses Enrolled</span></font></td>
    </tr>
	<tr>
        <td class="gridhdr" >
            <img src="images/course information.png" width="16" height="16" border="0">
        </td>
        <td class="gridhdr">
            <img src="images/web_inks.png" width="22" height="22" border="0">
        </td>
        <td class="gridhdr">
            Available Courses <br>
        </td>
        <td class="gridhdr">
            Assignments
        </td>
        <td class="gridhdr">
            Assessments
        </td>
    </tr>
	<tr>
        <td class="griditem">
           <!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CO"  onclick="javascript: setVar();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image39','','images/images/info-over.gif',1)"><img src="images/course information.png" width="16" height="16" border="0"></a> -->
		   <a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','CO'); setVar();"><img src="images/course information.png" width="16" height="16" border="0"></span></font></a>
        </td>
        <td class="griditem">
          <!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=WL" onMouseOut="MM_swapImgRestore()" onClick="javascript: setVar();" onMouseOver="MM_swapImage('Image38','','images/images/weblinks-over.gif',1)"><img src="images/web_inks.png" width="16" height="16" border="0"></a> -->
		   <a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','WL'); setVar();"><img src="images/web_inks.png" width="22" height="22" border="0"></span></font></a>
        </td>
        <td class="griditem">
		<!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CM" onClick="javascript: setMatVar('<%=cid%>');"><font face="Arial"><%=courseName%></a> -->
		 <a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','CM'); setMatVar('<%=cid%>')"><%=courseName%></span></font></a>
		</td>

		<td class="griditem">
           <!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=AS" TITLE="Assignments" onClick="javascript: setAsgnVar('<%=cid%>');"><%=newAssItems%>/<%=totalAssItems%></a> -->
		   <a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','AS'); setMatVar('<%=cid%>')"><%=newAssItems%>/<%=totalAssItems%></span></font></a>
        </td>

		<td class="griditem">
           <!-- <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=EX" TITLE="Assessments" onClick="javascript: setAsmtVar('<%=cid%>');"><%=newExams%>/<%=totalExams%></a> -->
		   <a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','EX'); setMatVar('<%=cid%>')"><%=newExams%>/<%=totalExams%></span></font></a>
        </td>

    </tr>
</table>


<% 
				flag=true;
			}
%>
<%
		}
	}
%>
<!--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<%
	if(!flag)		//if there are no courses alloted to the student
	{
%>
		<table border="0" width="682" align="center" cellspacing="2"  cellpadding="2" height="106">
    <tr>
        <td class="gridhdr">&nbsp;<img src="images/book_accept.png" width="24" height="24" border="0" align="absmiddle"> Courses Enrolled</td>
    </tr>
     <tr>
		<td class="griditem">
            &nbsp;Presently there are no Courses available.
        </td>
	</tr>
</table>
<%
		}	
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("CourseHome.jsp","Operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL in CourseHome.jsp" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CourseHome.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error in CourseHome.jsp:  -" + e.getMessage());

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
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("CourseHome.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQL Error in CourseHome.jsp"+se.getMessage());
		}
	}
%>
</form>

<!-- <script type="text/javascript">
setTimeout(
function(){
	alert("rfgregre");
document.getElementById( "courseslist" ).reset();
},
5
);
 

</script> -->