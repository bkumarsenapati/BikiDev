<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<% 
	
	String teacherId="";
	String examId="",examName="",schoolId="";
	String courseId="";
	String gradeId="";
	String examType="";
	String noOfGrps="";
	String crtdDate="";
	String fgColor="";
	String bgColor="";
	String importd="",query="";
	int c,totRecords=0,status=0,editStatus=0;

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

	try {

				st=con.createStatement();
				if(examType.equals("all")){
					query="Select count(*) from exam_tbl_tmp where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'";
				}else{
					query="Select count(*) from exam_tbl_tmp where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and exam_type='"+examType+"' and school_id='"+schoolId+"'";
				}
				
				rs=st.executeQuery(query);
				rs.next();
				c=rs.getInt(1);
				if (c!=0 ){
					totRecords=rs.getInt(1);
				}
				else{

					out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
					out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No Assessment found.</font></b></td></tr></table>");				
					return;
				}		   

				if(examType.equals("all")){
					rs=st.executeQuery("select *,curdate() cd from exam_tbl_tmp where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' order by exam_name");		   
				}else{
					rs=st.executeQuery("select *,curdate() cd from exam_tbl_tmp where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and exam_type='"+examType+"' and school_id='"+schoolId+"' order by exam_name");		   
				}

%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 

<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=application.getInitParameter("title")%></title>
<script language="javascript" src="../validationscripts.js"></script> 
<base target="main">
<script language="javascript">
function deleteAsmt(examId,crtdDate,examType)
{
	if(confirm("Are you sure? you want to delete the assessment.")==true)							 window.location.href="/LBCOM/exam.CreateSaveExam?mode=delete&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
	else
		return false;
	
}		

function moveAsmt(examId,crtdDate,examType,editStatus)
{
	if(confirm("Are you ready to publish?")==true){

		alert(editStatus);

		if(editStatus==0){						 window.location.href="/LBCOM/exam.CreateSaveExam?updatestatus=0&mode=move&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
	    }else{
			var flag=false;
			do {
			var rValue=prompt("Overwrite the original assessment or publish as a new one? \n( 1 - Overwrite ) ( 2 - Publish as new )","1");
			if(rValue==null)
				return false;
			rValue=trim(rValue);
			alert("rValue.."+rValue);

			if(rValue==1){										
				flag=true;
				if(editStatus==2){

					if(confirm("The original assessment is attempted by some students and cannot be overwritten. Save as new?")==true)	
					window.location.href="/LBCOM/exam.CreateSaveExam?mode=newcopy&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
					else
						return false;

				}else if(examId.substr(0,1)!="e"){			

					if(confirm("You do not have enough privilege to overwrite this assessment. Save as new?")==true)					window.location.href="/LBCOM/exam.CreateSaveExam?mode=newcopy&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
					else
						return false;				
				
				}else{		
					alert("else");
					window.location.href="/LBCOM/exam.CreateSaveExam?updatestatus=1&mode=move&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
				}

			} else if (rValue==2){
				flag=true;	window.location.href="/LBCOM/exam.CreateSaveExam?mode=newcopy&selExId="+examId+"&crtdDate="+crtdDate+"&examType="+examType;
				
			} else{
				flag=false;
				alert("Enter a valid value (1 or 2)");
			}
		
			}while(flag!=true);
		
		}	
	
	}else
		return false;
	

}		

function showPapers(eid){
		 var paperswin=window.open("ExamPapersFrame.jsp?mode=tmp&examid="+eid+"&type=teacher","Question","width=1000,height=600,scrollbars=yes resizable=yes");
		 paperswin.focus();
	}


</script>
</head>

<body topmargin=0 leftmargin=2 vlink="blue" link="blue" alink="#800080">
<form name="fileslist">
<div align="center">
  <center>
  <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="646" id="AutoNumber1">
    <tr>
      <td width="646" colspan="5" bgcolor="#C2CCE0" height="17">
      <font face="Arial" size="2">
      <p align="left"><font size="2"><span class="last">Assessments (<%=totRecords%>)</span></td>
    </tr>
    <tr>
      <td width="29" bgcolor="#CECBCE">&nbsp;</td>
      <td width="29" bgcolor="#CECBCE">&nbsp;</td>
      <td width="29" bgcolor="#CECBCE">&nbsp;</td>
      <td width="478" bgcolor="#CECBCE">
      <p align="center"><b><font color="#000080" face="Arial" size="2">
      Assessment Name</font></b></td>
      <td width="81" bgcolor="#CECBCE">
      <p align="center"><b><font color="#000080" face="Arial" size="2">Date</font></b></td>
    </tr>

	<%

		while(rs.next()){
			examId=rs.getString("exam_id");
			examType=rs.getString("exam_type");
			noOfGrps=rs.getString("no_of_groups");
			examName=rs.getString("exam_name");
			crtdDate=rs.getString("create_date").replace('-','_');
			status=rs.getInt("status");
			editStatus=rs.getInt("edit_status");

			if(status==5)
				fgColor="#008000";
			else
				fgColor="black";


			 if(examId.indexOf("e")!=-1){
				bgColor="#F3F3F3";
//				fgColor="#800080";
			 }
			else{
				bgColor="#E7E7E7";
//				fgColor="#000080";
			}
			
%>
	<tr>
      <td width="29" bgcolor="<%=bgColor%>" height="16"><a href="CEFrames.jsp?status=<%=status%>&editMode=edit&examName=<%=examName%>&examType=<%=examType%>&examId=<%=examId%>&noOfGrps=<%=noOfGrps%>" onclick="	parent.toppanel.document.examform.examcategory.value='<%=examType%>'" target="bottompanel"><font size="2" face="Arial"><img border="0" src="images/iedit.gif" TITLE="Edit Assessment details." ></font></a></td>
      <td width="29" bgcolor="<%=bgColor%>" height="16"><font size="2" face="Arial"><a href="#" onclick="deleteAsmt('<%=examId%>','<%=crtdDate%>','<%=examType%>');return false;">
      <img border="0" src="images/idelete.gif" TITLE="Delete Assessment." width="19" height="19" ></a></font></td>
      <td width="29" bgcolor="<%=bgColor%>" height="16"><font face="Arial" size="2">

	  <% if(status==5) {%>
		<a href="#" onclick="moveAsmt('<%=examId%>','<%=crtdDate%>','<%=examType%>',<%=editStatus%>);return false;"><img border="0" src="images/idpasswd.gif" TITLE="Publish" ></a>
	  <% } else { %>
			<img border="0" src="images/idpasswd.gif" TITLE="Publish" >
	  <% } %>

	  </font></td>
      <td width="478" bgcolor="<%=bgColor%>" height="16">&nbsp;<a href="#" onclick="showPapers('<%=examId%>'); return false;"><font size="2" face="Arial" color="<%=fgColor%>"><%= examName %></font></a></td>
      <td width="81" bgcolor="<%=bgColor%>" height="16"><font size="2" face="Arial" color="<%=fgColor%>">&nbsp;<%= rs.getString("create_date") %></font></td>
    </tr>

  <% } %>
  </table>
  </center>
</div>  

	<%	   
	 
 		}
		catch(SQLException e)
		{
			ExceptionsFile.postException("ExamsListTmp.jsp","operations on database","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
		}	

		catch(Exception e)
		{
			ExceptionsFile.postException("ExamsListTmp.jsp","General","Exception",e.getMessage());
			System.out.println("The Error is:"+e);
		}
		finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				con1.close(con);
			
			}catch(SQLException se){
				ExceptionsFile.postException("ExamsListTmp.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}

		}

		 %>
