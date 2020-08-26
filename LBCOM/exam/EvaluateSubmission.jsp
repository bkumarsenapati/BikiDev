<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@ page import="java.sql.*,java.util.*,java.lang.Object,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
   Connection con=null;
   Statement st=null;
   ResultSet rs=null;
   Vector questionIds=null,groupIds=null;
   Hashtable totQtns=null,ansQtns=null;
   int status=0,count=0;
   float marksSecured=0.0f,opoints=0.0f;
   String examId="",examType="",studentId="",stuTblName="",examName="",mode="";
   String totalMarks="";
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

		studentId=request.getParameter("studentid");
		examId=request.getParameter("examid");	
		examName=request.getParameter("examname");
		examType=request.getParameter("examtype");
		status=Integer.parseInt(request.getParameter("status"));
		count=Integer.parseInt(request.getParameter("count"));
		stuTblName=(String)session.getAttribute("stuTblName");
		totalMarks=(String)session.getAttribute("totalMarks");
		mode=request.getParameter("mode");
		if(mode==null)
			mode="eval";							

		con=con1.getConnection();
		st=con.createStatement();

		System.out.println(" Extra credit problem....select * from "+stuTblName+" where student_id='"+studentId+"' and count="+count+" and exam_id='"+examId+"'");

		rs=st.executeQuery("select * from "+stuTblName+" where student_id='"+studentId+"' and count="+count+" and exam_id='"+examId+"'");
		if(rs.next())
		{
			marksSecured=Float.parseFloat(rs.getString("marks_secured"));
			if(mode.equals("reeval"))
			{
				opoints=Float.parseFloat(request.getParameter("opoints"));
				System.out.println("opoints..."+opoints);
				if(Double.isNaN(opoints))
				{
					opoints=0;
				}
				marksSecured=marksSecured-opoints;				
			}
			else
				marksSecured=marksSecured;
			
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EvaluateSubmission.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("EvaluateSubmission.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in EvaluateSubmission.jsp is..."+se.getMessage());
		}
    }
%>

<head><title></title>

<SCRIPT LANGUAGE="JavaScript" src="exam_validations.js"></SCRIPT>
<script>
function get(field) 
{
	window.document.sub.marks.value=field.value;
	
}

function check()
{		
	var win=window.document.sub.marks;
		
	if(trim(win.value)== "") 
	{
		alert("Please assign points");
	    win.focus();
		return false;
	}
	
	var mstr='';
	var points=0;
	for(var i=0;i<parent.frames['mid_f'].qIds.length;i++)
	{
		
		if(parent.frames['mid_f'].qType[i]==6)
		{
			var qid=parent.frames['mid_f'].qIds[i];
			var mid='M'+qid;
			
			if(parent.mid_f.document.getElementById(mid).value=="Enter Points")
				mstr=mstr+',';
			else
				{
					mstr=mstr+parent.mid_f.document.getElementById(mid).value+',';
					points=points+Number(parent.mid_f.document.getElementById(mid).value);
					
				}
			    
		}
		else if(parent.frames['mid_f'].qType[i]==3)
		{
			var qid=parent.frames['mid_f'].qIds[i];
			var mid='M'+qid;
			
			if(parent.mid_f.document.getElementById(mid).value=="Enter Points")
				mstr=mstr+',';
			else
				{
					mstr=mstr+parent.mid_f.document.getElementById(mid).value+',';
					points=points+Number(parent.mid_f.document.getElementById(mid).value);
					
				}
			    
		}
	}
	document.getElementById("ansstr").value=mstr;
		
}

</script>
</head>

<BODY> 
<form name="sub" method="post" action="/LBCOM/exam.EvaluateSubmission" onsubmit="return check();">
<hr>
<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF">
<tr>
    <td width="25%" bgcolor="#CCA47B"><font face="verdana" size="2">&nbsp;Points secured in graded questions</font> </td>
	<td width="1%" bgcolor="#CCA47B"><font face="verdana" size="2"><b>:</b></font></td>
    <td width="20%" bgcolor="#E3CDB7"><font face="verdana" size="2"><b>&nbsp;<%=marksSecured%> / <%=totalMarks%></b></font></td>
	<td width="25%" align="right" bgcolor="#CCA47B"><font face="verdana" size="2">Points Assigned in Essay Questions</font></td>
	<td width="1%" bgcolor="#CCA47B"><font face="verdana" size="2"><b>:</b></font></td>
    <td width="10%" bgcolor="#E3CDB7"><font face="verdana" size="2">&nbsp;<input type="text" name="marks" size="20"></font></td>
</tr>
<% 
	if(status==1 || status==2 || status==5) 
	{
%>
	<tr>
		<td width="95%" colspan="6" align="center" bgcolor="white">
			<font face="Arial" size="4">
			<input type="SUBMIT" name="submit" value="SUBMIT SCORE & MOVE ON TO FEEDBACK"></font>
		</td>
	</tr>
<% 
	}
%>
	<tr>
		<td width="95%" colspan="6" align="center" bgcolor="#E3CDB7">&nbsp;</td>
	</tr>
</table>

<input type="hidden" name="studentid" value="<%=studentId%>">
<input type="hidden" name="markssecured" value="<%=marksSecured%>">
<input type="hidden" name="totalmarks" value="<%=totalMarks%>">
<input type="hidden" name="examid" value="<%=examId%>">
<input type="hidden" name="examname" value="<%=examName%>">
<input type="hidden" name="examtype" value="<%=examType%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="count" value="<%=count%>">
<input type="hidden" name="mode" id="mode"value="<%=mode%>">
<!-- <input type="hidden" name="mode" id="mode" value="eval"> -->
<input type="hidden" name="ansstr" id="ansstr" value="">

</form>
</BODY>
</HTML>
