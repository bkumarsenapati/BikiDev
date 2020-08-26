<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@page language="java" import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs=null,rs1=null,rs2=null;
String schoolId="",studentId="",nbId="",nbTitle="",msg="",nbFile="",dir="";
String imp="",endDate="";
int i=0;
%>
<%!

private String check4Opostrophe(String str){
	str=str.replaceAll("\'","\\\\\'");
	str=str.replaceAll("\"","\\&quot;");
	return(str);
}

%>

<%
try
{
		msg=request.getParameter("msg");
		msg="No Message!";
		nbId=request.getParameter("nbid");
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		studentId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");

		
		rs1=st1.executeQuery("select * from notice_master where schoolid='"+schoolId+"' and noticeid='"+nbId+"'");
		if(rs1.next())
		{
			msg=rs1.getString("description");
			nbFile=rs1.getString("filename");
			nbTitle=rs1.getString("title");
			dir=rs1.getString("dirname");
			imp=rs1.getString("imp");
			endDate=rs1.getString("to_date");

		}

		
		// This is for all users
		
		/*
		
		if(imp.equals("1"))
		{
			i=st.executeUpdate("insert into student_notice_boards values('"+nbId+"','"+schoolId+"','"+studentId+"')");
		}
		else if(imp.equals("2"))
		{
			System.out.println("before ...rs2....");
			rs2=st2.executeQuery("select to_date from notice_master where schoolid='"+schoolId+"' and noticeid='"+nbId+"' and to_date<=curdate()");
			if(rs2.next())
			{
				System.out.println("rs2....");
				i=st.executeUpdate("insert into student_notice_boards values('"+nbId+"','"+schoolId+"','"+studentId+"')");
			}
		}
		*/
		
			i=st.executeUpdate("insert into student_notice_boards values('"+nbId+"','"+schoolId+"','"+studentId+"')");

if((msg==null)||msg.equals(""))
	msg="No Message";
else
	msg="'"+check4Opostrophe(msg)+"'";

%>
<html><head>
<script language="javascript">
function openwin(){
	parent.location.href="StudentHomeNB.jsp";
}
</script>
</head><body>
<form name="main">
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" onunload="javascript:closeallpop()">
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="0">
    <tr>
        <td width="208" height="24">
            <p><img src="../images/hsn/logo.gif"  border="0" ></p>
        </td>
        <td width="387" height="24">
            <p>&nbsp;</p>
        </td>
		 <tr>
        <td width="1004" colspan="5" bgcolor="#546878"> &nbsp;           
            <iframe name="usage" width="0" height="0"></iframe>
        </td>
    </tr>        
    <tr>
        <td width="1004" colspan="5" bgcolor="#dcdcde"> &nbsp;

            &nbsp;
        </td>
    </tr>
</table>
<script language="javascript">
 
	var mes= <%=msg%>;
  if (mes==null){
        mes="No Message";
} if ((mes=="")||(mes=="null")){
        mes="No Message";
}
  document.write("<font face='Arial' size='2' color='blue'>&nbsp;&nbsp;<b>Important Announcement:</b>&nbsp;&nbsp;<%=nbTitle%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript://' onclick=\"return showFile();\"><img src='../forums/images/button_attach.gif' TITLE='Attachments' border=0></a></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><input type='button' value='Continue' onclick='return openwin();'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
  document.write("<font face='Arial' size='2' >&nbsp;&nbsp;&nbsp;</font><br>");
  document.write("<font face='Arial' size='2' >&nbsp;&nbsp;&nbsp;"+mes+"</font><br><br><br>");
 <!--  document.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript://' onclick=\"return showFile();\"><img src='../forums/images/button_attach.gif' TITLE='Attachments' border=0></a></font>"); -->
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--

var studentChatWin=null;
var stuExamHistoryWin=null;
var stuAnsSheetWin=null;
var studenteClassRoomWin=null;
var studentUserManualwin=null;
var studentExamWin=null;
var studentViewMatWin=null;
var studentPasswordWin=null;
var studentNoticeBoardWin=null;
var stuAsgnHtmlEditorWin=null;
var stuAsgnAttemptsWin=null;
var stuAsgnAttemptsFileWin=null;
var stuAsgnTeacherRemarkWin=null;
var stuAsgnPerDocWin=null;
var stuAsgnTeacherInstWin=null;
// last 6 varables are added by Ghanendra
var logout1=false;

function showFile(attachfile)
{
	var x=window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/nboards/<%=dir%>/<%=nbFile%>","Document","width=750,height=600,scrollbars");
	
	return false;
}

function closestudentview(){
	// Added by Rajesh	
	if(logout1)return false;
	if((parent.window.opener!=undefined)||(parent.window.opener!=null)){
		if(parent.window.opener.window.sview.closed!=true){			
				parent.window.opener.current_login= "Teacher";
				parent.window.opener.oldPosition();
				parent.window.close();
				return false
		}
	}
	return false
	// Added By Rajesh
}

// this function gives warning to student before closing or reloading the main page regarding all popup close
 function showwarning()
  {     
     return 'Reloading/closing this page or logout will close all the popups!';
   }

// this function will close all the popups related to hotschools. modified by ghanendra
function closeallpop()
{
         closestudentview();
         if(studentViewMatWin!=null && !studentViewMatWin.closed)	// coursemgmt/student/ViewMaterial.jsp
		studentViewMatWin.close();
	
	if(studentPasswordWin!=null && !studentPasswordWin.closed)	// studentAdmin/modifyStudentReg.jsp
		studentPasswordWin.close();

	if(studentNoticeBoardWin!=null && !studentNoticeBoardWin.closed)	// teacherAdmin/ShowDeptFiles.jsp
		studentNoticeBoardWin.close();

	if(stuExamHistoryWin!=null && !stuExamHistoryWin.closed)	//coursemgmt/student/StudentInbox.jsp
		stuExamHistoryWin.close();

	if(studentChatWin!=null && !studentChatWin.closed)	// studentAdmin/left.jsp
		studentChatWin.close();

	if(studenteClassRoomWin!=null && !studenteClassRoomWin.closed)	// studentAdmin/left.jsp
		studenteClassRoomWin.close();

	if(studentUserManualwin!=null && !studentUserManualwin.closed)	// studentAdmin/top.html (this file only)
		studentUserManualwin.close();

	if(studentExamWin!=null && !studentExamWin.closed)	// exam/ExamPassword.jsp and exam/StudentExamsList.jsp
		studentExamWin.close();
		
	if(stuAsgnHtmlEditorWin!=null && !stuAsgnHtmlEditorWin.closed) 
		stuAsgnHtmlEditorWin.close();
		
	if(stuAsgnAttemptsWin!=null && !stuAsgnAttemptsWin.closed)
		stuAsgnAttemptsWin.close();
		
	if(stuAsgnAttemptsFileWin!=null && !stuAsgnAttemptsFileWin.closed) 
		stuAsgnAttemptsFileWin.close();
	
	if(stuAsgnTeacherRemarkWin!=null && !stuAsgnTeacherRemarkWin.closed) 
		stuAsgnTeacherRemarkWin.close();			
		
	if(stuAsgnPerDocWin!=null && !stuAsgnPerDocWin.closed)
		stuAsgnPerDocWin.close();
		
	if(stuAsgnTeacherInstWin!=null && !stuAsgnTeacherInstWin.closed) 
		stuAsgnTeacherInstWin.close();		
        return true;
}

// This function is used to close all the windows related to hotschools when a student logs out.
function logout()
{
	// Added by Rajesh	
	logout1=true;
	if((parent.window.opener!=undefined)||(parent.window.opener!=null)){
		if(parent.window.opener.window.sview.closed!=true){			
			parent.window.opener.current_login= "Teacher";
			parent.window.opener.oldPosition();
			parent.window.close();
			return false
		}
		
	}
	// Added By Rajesh
	parent.frames["bottom"].logcookie();
	//popups close is done by unload event  so i removed the popup close statements from here :  Ghanendra
	parent.location.href="/LBCOM/common/Logout.jsp";
	return false;
}

function usermanual()
{
	//studentUserManualwin=window.open("/LBCOM/manuals/learner_UG/","UserManual","resizable=yes,scrollbars,width=750,height=550,toolbars=no");

	studentUserManualwin=window.open("/LBCOM/studentAdmin/Video_Tutorials/TrainingTutorials.html","UserManual","resizable=yes,scrollbars,width=750,height=550,toolbars=no");
}
//-->
</SCRIPT>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("Top.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
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
		if(con!=null)
			con.close();
			
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("Top.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}
%>
</form>
</body>
</html>
