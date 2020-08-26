<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page language="java" import="mperiod.getMarkingPeriod"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%

Connection con=null;
Statement st=null,st1=null,st2=null,st3=null;
ResultSet  rs=null,rs1=null,rs2=null,rs3=null;


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
String newSchoolId="";
String cid="";                           // added by Santhosh for usage report
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
	if(sessionStatus==null)
	{
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		studentName=(String)session.getAttribute("studentname");
		classId=(String)session.getAttribute("classid");
	}
	else
	{
		schoolId=(String)session.getAttribute("originalschoolid");
		studentId=(String)session.getAttribute("originalemailid");
		studentName=(String)session.getAttribute("originalstudentname");
		classId=(String)session.getAttribute("originalclassid");
	}
	
	con=con1.getConnection();
	st=con.createStatement();
	
	rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
	if(rs.next())
	{
		crossRegisterFlag=rs.getString("crossregister_flag");
	}
	rs.close();
	st.close();
	
	if(crossRegisterFlag.equals("1"))
	{
		st=con.createStatement();
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
	System.out.println("Hi");
%>

<html>
<head>
<title></title>
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

/*function viewMaterial(cName,cId,sId,stId,stName,clId,mode,type)
{
	alert(type);
	//$("#nav_main li").removeClass('selected');showLoading('grid');$("#live_board").addClass('selected');grid_content.load("/LBCOM/CourseHomeMain.jsp?schoolid="+sId+"&emailid="+tId+"", hideLoading);
	$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/student/CourseHomeMain.jsp", hideLoading);
	
}
*/

function changesession(cName,cId,sId,stId,stName,clId,mode,type)
{
	alert(type);
	alert(cName);
	//$("#nav_main li").removeClass('selected');showLoading('grid');$("#live_board").addClass('selected');grid_content.load("/LBCOM/CourseHomeMain.jsp?schoolid="+sId+"&emailid="+tId+"", hideLoading);
	cName=cName.replace(/ /g,"+");
	$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/student/CourseHomeMain.jsp?courseid="+cId+"&coursename="+cName+"&schoolid="+sId+"&studentid="+stId+"&studentname="+stName+"&classid="+clId+"&mode="+mode+"&page_type="+type+"", hideLoading);
	
}
//-->
</script>

<link href="images/style.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">
	<!--
       	function setMatVar(course_id)
       	{
        	  parent.frames['left'].studycid = course_id;
          	parent.frames['left'].temp = 'study';
       } 
       
       function setAsgnVar(course_id)
       {
          parent.frames['left'].asgncid = course_id;
          parent.frames['left'].temp = 'assignment';
       }
       
       function setAsmtVar(course_id)
       {
          parent.frames['left'].asmtcid = course_id;
          parent.frames['left'].temp = 'assessment';
       }   
 	  
       function setVar()
       {
          parent.frames['left'].temp = 'other';
       }    
	//-->	   
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table border="1" width="95%" align="left" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="106">
    <tr>
        <td width="670" height="10" colspan="3" bgcolor="#03345e"><font face="Arial" color="FFFFFF"><span style="font-size:11pt;"><b>&nbsp;<img src="../coursemgmt/student/images/book_accept.png" width="24" height="24" border="0" align="absmiddle"> Courses Enrolled</b></span></font></td>
    </tr>
	<tr>
        <!-- <td height="20" bgcolor="#dcdcde" width="5%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b></b></font></span><img src="images/course information.png" width="16" height="16" border="0"></p>
        </td>
        <td height="20" bgcolor="#dcdcde" width="5%" background="images/1bg.jpg">
            <p align="center"><img src="images/web_inks.png" width="16" height="16" border="0"></p>
        </td> -->
        <td height="20" bgcolor="#F2F2F2" width="43%" background="images/1bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>Course Material <br>
</b></font></span></p>
        </td>
        <td height="20" bgcolor="#F2F2F2" width="12%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b>Assignments</b></font></span></p>
        </td>
        <td height="20" bgcolor="#F2F2F2" width="12%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b>Assessments</b></font></span></p>
        </td>
    </tr>
	
	
<%
	for(int j=0;j<courseNames.size();j++)		    // for each course	
	{
		courseName=(String)courseNames.get(j);
		courseId=(String)courseIds.get(j);
		teacherId=(String)teachers.get(j);
		cid = schoolId + "/" + courseId;              // added by Santhosh
		inboxItems=0;
		newAssItems=0;
		newResults=0;
		totalAssItems=0;
		totalExams=0;
		
		//rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from "+schoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+schoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+studentId+"' where w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");

		

		String query="select m_id,m_name from marking_admin where curdate() between s_date and e_date and  schoolid='"+schoolId+"'";
		String mpId="";
		st2=con.createStatement();
		rs2=st2.executeQuery(query);
			if(rs2.next())
			{
				mpId=rs2.getString("m_id");				
			}
			rs2.close();
			st2.close();
		
		st=con.createStatement();
		rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from "+schoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+schoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+studentId+"' where w.work_id in (Select work_id  from mp_cescores where m_id='"+mpId+"' and school_id='"+schoolId+"') and w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");

		//rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from demoschool_C000_c0001_workdocs as w left join demoschool_C000_c0001_dropbox as d on  w.work_id=d.work_id left join mp_cescores as mpc  on w.work_id=mpc.work_id and mpc.school_id='demoschool'  where  d.student_id='student1' and  w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");


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
			st3=con.createStatement();
			rs3=st3.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where w.work_id in (select work_id  from mp_cescores where m_id='"+mpId+"') and d.student_id='"+studentId+"' and w.status='1' and (d.start_date<=curdate())");
			if(rs3.next())
			{
				totalAssItems=rs3.getInt(1);
			}
			rs3.close();
			st3.close();

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
		rs=st.executeQuery("select s.exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+schoolId+"_"+studentId+" as s ,"+schoolId+"_cescores as c where e.exam_id in (Select work_id  from mp_cescores where m_id='"+mpId+"') and e.exam_id=s.exam_id and e.exam_id=c.work_id and c.user_id='"+studentId+"' and c.course_id='"+courseId+"' and c.report_status=1 and e.course_id='"+courseId+"' and e.school_id='"+schoolId+"' and e.status='1' and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() or e.to_time<=curtime())) group by s.exam_status");

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
		inboxItems+=newExams;
%>
<!--To display the course name, new items in a tabular format   -->
 <!-- <table border="1" width="682" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333">  -->
	<tr>
        <!-- <td height="24" width="34" bgcolor="#dcdcde">
            <p align="center"><a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CO" Title="Course Information" onmouseout="MM_swapImgRestore()" onclick="javascript: setVar();" onmouseover="MM_swapImage('Image39','','images/images/info-over.gif',1)"><img src="images/course information.png" width="16" height="16" border="0"></a></p>
        </td>
        <td height="24" width="34" bgcolor="#dcdcde">
            <p align="center"><a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=WL" Title="Weblinks" onclick="javascript: setVar();" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image38','','images/images/weblinks-over.gif',1)"><img src="images/web_inks.png" width="16" height="16" border="0"></a></p>
        </td> -->
        <td height="15" width="47%" bgcolor="#ffffff">
			<!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CM" Title="Course Material"  onclick="javascript: setMatVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=courseName%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','CM'); setMatVar('<%=cid%>');"><%=courseName%></span></font></a>
			</td>
<%
				if(totalAssItems == 0)
				{
%>

					<td height="15" width="80" bgcolor="#ffffff">
						<p align="center"><font face="Arial"><span style="font-size:10pt;">NA</span></font></p>
					</td>
<%
				}
				else
				{	
%>
		<td height="15" width="80" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=AS" TITLE="Assignments" onclick="javascript: setAsgnVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=newAssItems%>/<%=totalAssItems%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','AS'); setAsgnVar('<%=cid%>');"><%=newAssItems%>/<%=totalAssItems%></span></font></a>
			</p>
        </td>
<%
				}	
%>
<%
				if(totalExams==0)
				{
%>				

					<td height="15" width="80" bgcolor="#ffffff">
						<p align="center"><font face="Arial"><span style="font-size:10pt;">NA</span></font></p>
					</td>
<%
				}
				else
				{
%>
		<td height="15" width="80" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=EX" TITLE="Assessments" onclick="javascript: setAsmtVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=newExams%>/<%=totalExams%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=schoolId%>','<%= studentId%>','<%=studentName%>','<%=classId%>','newtoold','EX'); setAsmtVar('<%=cid%>');"><%=newExams%>/<%=totalExams%></span></font></a>
			</p>
        </td>
<%
				}	
%>

    </tr>

<tr>
<td colspan="3" width="100%">
	
<% 
			if(totalExams==0 && totalAssItems == 0)
			{
%>	
					<table width="100%">
					<tr>
						<td height="15" width="100%" bgcolor="#F0ECE1">
							<p align="center"><font face="Arial"><span style="font-size:10pt;">There are no assignments available</span></font></p>
						</td>
						</tr>
					</table>
<%			}
			else
			{
%>
			<table width="100%">
			<%
			getMarkingPeriod mp1=new getMarkingPeriod();
			ArrayList al1=mp1.getMP(schoolId,studentId,courseId,classId);
			Iterator it=al1.iterator();
			while(it.hasNext())
			{
				String ele=(String)it.next();
				String eles[]=ele.split(",");
				String code="";
				if(eles[2].equals("Fail"))
				{
					code="red";
				}
				else{
					code="green";
				}
				float scale=0.0f;
				scale=100-Float.parseFloat(eles[1]);
				
					%>
					<tr><td width="60%"><font size="1" face="Arial" color="#333333">By :<%=eles[0]%></font><font face="Arial" color="green" size="2"><b>&nbsp; <%=eles[1]%>%</b></font></td>
					<td width="40%" align="right"><!-- <B><font size="1" face="Arial" >Grade By Marking Period :</font><font face="Arial" color="<%=code%>" size="2"><b><%=eles[2]%></font></b> --></td>
					</td>
					</tr>
					<%
						//if(eles[2].equals("Fail"))
						//{
					//%>
					<tr>
					<td width="100%" colspan="2"></td>
					</tr>
					<%
						//}
					//else{
						%>
					<tr>
					<td width="100%" colspan="2">
					<table width="100%">
					<tr>
				<%
					if(eles[1].equals("0.0"))
					{
				%>
					<td width="<%=scale%>%" height="20" bgColor="#ff0000"></td>
				<%
					}
					else if(scale!=0.0)
					{
				%>
					<td width="<%=eles[1]%>%" height="20" bgColor="#008000"></td>
					
				<%	}
				
					if(scale==0.0)
					{
				%>
					<td width="<%=eles[1]%>%" height="20" bgColor="#008000"></td>
				<%
					}
					else if(!eles[1].equals("0.0"))
					{
				%>
					
					<td width="<%=scale%>%" height="20" bgColor="#ff0000"></td>
				<%	}
				%>
					
					</tr>
					</table>
					</td>
					</tr>
					<%
						//}

			}
			%></table><%
		}
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
				cid = newSchoolId + "/" + courseId;        // added by Santhosh
				inboxItems=0;
				newAssItems=0;
				newResults=0;
				totalAssItems=0;
				totalExams=0;
				
				st=con.createStatement();
				rs=st.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from  "+newSchoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join "+newSchoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+schoolId+"_"+studentId+"' where (d.start_date<=curdate() and w.to_date>=curdate()) or ( w.to_date='0000-00-00' and d.start_date<=curdate()) group by status");
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
				inboxItems+=newExams;
%>
		<!--To display the course name, new items in a tabular format   -->
				
	<table border="1" width="80%" align="left" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="106">
    <tr>
        <td width="670" height="40" colspan="5" bgcolor="#E8E8E8"><font face="Arial"><span style="font-size:11pt;"><b>&nbsp;<img src="images/book_accept.png" width="24" height="24" border="0" align="absmiddle"> Courses Enrolled</b></span></font></td>
    </tr>
	<tr>
        <td height="34" bgcolor="#dcdcde" width="5%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b></b></font></span><img src="images/course information.png" width="16" height="16" border="0"></p>
        </td>
        <td height="34" bgcolor="#dcdcde" width="5%" background="images/1bg.jpg">
            <p align="center"><img src="images/web_inks.png" width="16" height="16" border="0"></p>
        </td>
        <td height="34" bgcolor="#F2F2F2" width="47%" background="images/1bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>Course Material <br>
</b></font></span></p>
        </td>
        <td height="34" bgcolor="#F2F2F2" width="18%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b>Assignments</b></font></span></p>
        </td>
        <td height="34" bgcolor="#F2F2F2" width="18%" background="images/1bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b>Assessments</b></font></span></p>
        </td>
    </tr>
	<tr>
        <td height="24" width="34" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CO"  onclick="javascript: setVar();" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image39','','images/images/info-over.gif',1)"><img src="images/course information.png" width="16" height="16" border="0"></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','CO'); setVar();"><img src="images/course information.png" width="16" height="16" border="0"></span></font></a>
			</p>
        </td>
        <td height="24" width="34" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=WL" onmouseout="MM_swapImgRestore()" onclick="javascript: setVar();" onmouseover="MM_swapImage('Image38','','images/images/weblinks-over.gif',1)"><img src="images/web_inks.png" width="16" height="16" border="0"></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','WL'); setVar();"><img src="images/web_inks.png" width="16" height="16" border="0"></span></font></a>
			</p>
        </td>
        <td height="24" width="47%" bgcolor="#ffffff">
			<!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CM" onclick="javascript: setMatVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=courseName%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','CM'); setMatVar('<%=cid%>')"><%=courseName%></span></font></a>		
			</td>

		<td height="24" width="124" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=AS" TITLE="Assignments" onclick="javascript: setAsgnVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=newAssItems%>/<%=totalAssItems%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','AS'); setMatVar('<%=cid%>')"><%=newAssItems%>/<%=totalAssItems%></span></font></a>
			</p>
        </td>

		<td height="24" width="123" bgcolor="#ffffff">
            <p align="center"><!-- <a href="../coursemgmt/student/ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=EX" TITLE="Assessments" onclick="javascript: setAsmtVar('<%=cid%>');"><font face="Arial"><span style="font-size:10pt;"><%=newExams%>/<%=totalExams%></span></font></a> -->
			<a href="#"  onClick="changesession('<%=courseName%>','<%=courseId%>','<%=newSchoolId%>','<%=schoolId%>_<%=studentId%>','<%=studentName%>','<%=classId%>','oldtonew','EX'); setMatVar('<%=cid%>')"><%=newExams%>/<%=totalExams%></span></font></a>
			</p>
        </td>

    </tr>
	<%
		getMarkingPeriod mp=new getMarkingPeriod();
	
		ArrayList al=mp.getMP(schoolId,studentId,courseId,classId);
		
		%>
</table>


<% 
				flag=true;
			}
%>
<%
		}
	}
%>
<!--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<%
	if(!flag)		//if there are no courses alloted to the student
	{
%>
		<table border="1" width="100%" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="106">
    <tr>
        <td width="670" height="40" colspan="5" bgcolor="#E8E8E8"><font face="Arial"><span style="font-size:11pt;"><b>&nbsp;<img src="images/book_accept.png" width="24" height="24" border="0" align="absmiddle"> Courses Enrolled</b></span></font></td>
    </tr>
     <tr>
		<td height="24" width="100%" bgcolor="#dcdcde" colspan="5">
            <p align="left">&nbsp;Presently there are no Courses available.</span></font></p>
        </td>
	</tr>
</table>
<%
		}	
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("CourseHomeDB.jsp","Operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL in CourseHomeDB.jsp" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CourseHomeDB.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error in CourseHomeDB.jsp:  -" + e.getMessage());

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
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("CourseHomeDB.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQL Error in CourseHomeDB.jsp"+se.getMessage());
		}
	}
%>

</body>
</html>