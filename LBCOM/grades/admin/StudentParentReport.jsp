<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Students</title>
</head>
<body>
<%
    String school_id="",uname="",sid="",fname="",lname="",sname="";
    Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	Hashtable stud_profile=null;
	Hashtable class_ids=null; 
	boolean student_flag=false,cFlag=false;
	int count=0;
	int inboxItems=0;					//total no.of new items in the studnet inbox
	int newAssItems=0,totalAssItems=0;				//total no.of new AS+HW+PW
	int newMatItems=0;				//total no.of new CO+CM+RB+MI
	int newResults=0;					//total no of new Results
	int len=0,i=0;
	int newExams=0,totalExams=0;
	int newMidExams=0;
	int newFinals=0;
	boolean flag=false;					//false if there are no courses for the student
	String distDesc="",distId="",sstatus="",statusDesc="";
	Vector courseNames=null,schoolNames=null,courseIds=null,teachers=null,courseCredits=null;
	String courseName="",classId="",studentName="",studentId="",schoolId="",courseId="",workId="",examId="",createDate="",examType="";
	String tableName="",teacherId="",crossRegisterFlag="";
	String newSchoolId="",cId="",cName="";
	String cid="",status="NA",courseCredit="";                           // added by santhosh for usage report
%>

<%
   school_id=request.getParameter("schoolid");
  //classId=(String)session.getAttribute("originalclassid");
   //classId="C000";
   //System.out.println("school_id.."+school_id+"...classId..."+classId);
   //sname=request.getParameter("sname");
   
  try
    {
		stud_profile = new Hashtable();
		con = con1.getConnection();
		st=con.createStatement();
		//System.out.println("select *,d.dist_desc from studentprofile as sp,dist_master as d where sp.schoolid=d,schoolid and schoolid='"+school_id+"' and sp.crossregister_flag<'2'");
	//	rs=st.executeQuery("select *,d.dist_desc from studentprofile as sp,dist_master as d where sp.schoolid=d,schoolid and schoolid='"+school_id+"' and sp.crossregister_flag<'2'");
	//rs=st.executeQuery("select * from studentprofile where schoolid='"+school_id+"' and crossregister_flag<'2'");
		rs=st.executeQuery("select dist_id,dist_desc from dist_master where school_id='"+school_id+"' order by dist_desc");
		student_flag= false;
		
				
%>

<table border="1" cellpadding="0" cellspacing="1" width="95%" align="center">
 <tr>             
	   
	   <td width="100%" height="20%" align="center" valign="middle" colspan="3" >
			<p align="right"><b><font face="Verdana" size="2">
            <a target="_self" href="index.jsp"><< Back</a></font></b></td>
    </tr>
</table>

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" align="center">
	
	<tr>   
        <td valign="bottom" align="center" bgcolor="#EEBA4D" width="300" height="19">
			<font face="Verdana" size="2"><b>Student Name</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="197" height="19">
            <font face="Verdana" size="2"><b>Student Id</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>District</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>Course(s)</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>Completion Status&nbsp;(AS|EX)</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>Total Credits Enrolled</b></font>
        </td>
     </tr>
<%
		while(rs.next())
		{
			
			st1=con.createStatement();
			distId=rs.getString("dist_id");
			distDesc=rs.getString("dist_desc");
			//System.out.println("#####################");
			rs1=st1.executeQuery("select * from studentprofile where schoolid='"+school_id+"' and parent_occ='"+distId+"' and crossregister_flag<'2'");
			while(rs1.next())
			{
				
				count++;
				cFlag=false;
				
				uname=rs1.getString("username");
				//System.out.println("In while loop..."+uname);
				fname=rs1.getString("fname");
				lname=rs1.getString("lname");
				classId=rs1.getString("grade");
				sstatus=rs1.getString("status");
				if(sstatus.equals("1"))
				{
					statusDesc="Active";
				}
				else
				{
					statusDesc="Inactive";
				}
				student_flag= true;
				//System.out.println("......select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+uname+"' and c.status=1 and c.school_id='"+school_id+"'");
				st2=con.createStatement();
				
				courseNames=new Vector();
				courseIds=new Vector();
				teachers=new Vector();
				courseCredits=new Vector();
				rs2=st2.executeQuery("select c.course_name,c.course_id,c.teacher_id,c.sess from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+uname+"' and c.status=1 and c.school_id='"+school_id+"'");
				while (rs2.next()) 
				{		
					courseNames.add(rs2.getString("course_name"));
					courseIds.add(rs2.getString("course_id"));
					teachers.add(rs2.getString("teacher_id"));
					courseCredits.add(rs2.getString("sess"));

				}
				int k=courseNames.size();
				if(k==0)
				{
					cFlag=true;
					//System.out.println("courseIds..."+courseNames.size());
				}
				
				//System.out.println("teachers..."+teachers.size());
				rs2.close();
				st2.close();

				for(int j=0;j<courseNames.size();j++)		    // for each course	
				{
						courseName=(String)courseNames.get(j);
						courseId=(String)courseIds.get(j);
						teacherId=(String)teachers.get(j);
						courseCredit=(String)courseCredits.get(j);
						cid = school_id + "/" + courseId;              // added by santhosh
						inboxItems=0;
						newAssItems=0;
						newResults=0;
						totalAssItems=0;
						totalExams=0;
						//System.out.println("*******************");
						//System.out.println("courseCredit...."+courseCredit);
						//System.out.println("select count(distinct(w.work_id)) as cnt,d.status from "+school_id+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+school_id+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+uname+"'  and d.status!=5 where w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");

						st3=con.createStatement();

						rs3=st3.executeQuery("select count(distinct(w.work_id)) as cnt,d.status from "+school_id+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+school_id+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.student_id='"+uname+"'  and d.status!=5 where w.status='1' and (d.start_date<=curdate() and d.end_date>=curdate() or d.end_date<=curdate()) or ( d.end_date='0000-00-00' and d.start_date<=curdate()) group by status");
						int sts=0,cnt=0;	
						
						while(rs3.next()) 
						{
							sts=rs3.getInt("status");
							cnt=rs3.getInt("cnt");
							if(sts==4)
								newResults+=cnt;
							if(sts==0)
								newAssItems=cnt; 
							totalAssItems+=cnt;
						}
						rs3.close();		
						//System.out.println("After rs3");
						
						inboxItems=newAssItems+newResults;	//new items in the inbox
						
						//
							st4=con.createStatement();
							rs4=st4.executeQuery("select count(distinct w.work_id) from "+school_id+"_"+classId+"_"+courseId+"_workdocs w inner join "+school_id+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id and d.status!=5 where d.student_id='"+uname+"' and w.status='1' and (d.start_date<=curdate())");
							if(rs4.next())
							{
								totalAssItems=rs4.getInt(1);
							}
							rs4.close();
							//System.out.println("After rs4");


						//
						st5=con.createStatement();

						rs5=st5.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+school_id+"' and d.school_id='"+school_id+"' and d.status=0 and d.student_id='"+uname+"'");
						newMatItems=0;		
						if(rs5.next()) 
						{
							newMatItems+=rs5.getInt(1);   
						}					
						inboxItems+=newMatItems;	        //new items in Inbox				
						rs5.close();
						//System.out.println("After rs5");

					
						st6=con.createStatement();
						rs6=st6.executeQuery("select s.exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+school_id+"_"+uname+" as s ,"+school_id+"_cescores as c where e.exam_id=s.exam_id and e.exam_id=c.work_id and c.user_id='"+uname+"' and c.course_id='"+courseId+"' and c.report_status=1 and e.course_id='"+courseId+"' and e.school_id='"+school_id+"' and e.status='1' and s.start_date is NOT NULL and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() or e.to_time<=curtime())) group by s.exam_status");

						sts=0;cnt=0;
						newExams=0;
						while(rs6.next())
						{
							sts=rs6.getInt("status");
							cnt=rs6.getInt("cnt");
							if(sts==0)
								newExams=cnt; 
							totalExams+=cnt;
						}
						rs6.close();
						//System.out.println("After rs6");
						if(courseCredit.equals(""))
						{
							courseCredit="NA";
						}
						

					if(cFlag==false)
					{
						
						%>
					  <tr>
					  <td width="250" align="left">
						<font size="2" face="verdana"><%=fname%>&nbsp;&nbsp;<%=lname%></font></td>
					  <td width="250" align="center">
						<font size="2" face="verdana"><%=uname%></font></td>
					  <td width="250" align="center">
						<font size="2" face="verdana"><%=distDesc%></font></td>
						<td width="250" align="center">
						<font size="2" face="verdana"><%=courseName%></font></td>
						<td width="250" align="center">
						<font size="2" face="verdana"><%=newAssItems%>/<%=totalAssItems%>&nbsp;|&nbsp;<%=newExams%>/<%=totalExams%></font></td>
						<td width="250" align="center">
						<font size="2" face="verdana"><%=courseCredit%></font></td>
				   </tr>
									   
					<%
					}
					
				}
			
			}
			if(cFlag==true)
			{
%>
						<tr>
						  <td width="250" align="left">
							<font size="2" face="verdana"><%=fname%>&nbsp;&nbsp;<%=lname%></font></td>
						  <td width="250" align="center">
							<font size="2" face="verdana"><%=uname%></font></td>
						  <td width="250" align="center">
							<font size="2" face="verdana"><%=distDesc%></font></td>
							<td width="250" align="center">
							<font size="2" face="verdana" color="red">--</font></td>
							<td width="250" align="center">
							<font size="2" face="verdana" color="red">&nbsp;----</font></td>
							<td width="250" align="center">
							<font size="2" face="verdana" color="red">--</font></td>
					    </tr>
<%
					}
			rs1.close();
			st1.close();				

		  }
		rs.close();
	
%>
    </td>
    </tr>
	<tr><td>&nbsp;</td></tr>
    <tr bgcolor="#EEBA4D">
	 <td colspan="6" width="100%" align="left">
		<font face="Verdana" size="2">Total number of students are <b><%=count%></b></font></td>
   </tr>
</table>

<%
if(student_flag==false)
{
%>
<table width="100%">
    <tr>
        <td colspan="6" width="100%" height="18">
			<CENTER><b><font face="verdana" color="#800080" size="2">Presently there are no Students.</font></b></CENTER>
        </td>
    </tr>
<%
}
%>
    <tr>
        <td width="100%">
            <p align="center"><span style="font-size:10pt;"><font face="Verdana">
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("accounts/StudentProfile.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
         rs.close();
         st.close();
		 con.close();
	}catch(Exception e){
		ExceptionsFile.postException("accounts/StudentProfile","closing statement,resultset and connection objects","Exception",e.getMessage());
	}
}
%>
            
    </tr>
</table>
</body>
</html>