<%@ page import="java.io.*,java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String examId="",teacherId="",courseId="",schoolId="",studentId="",tableName="",examType="",examName="";
	String status="",count="",sessid="";

	String mode="",qList="",aStr="",qStr="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	StringTokenizer ansStr,indMarks;
	String securedMarks="";
%>
<%
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		mode=request.getParameter("mode");
			
		teacherId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		
		tableName=(String)session.getAttribute("stuTblName");
		
		examId=request.getParameter("examid");
		studentId=request.getParameter("studentid");
		examType=request.getParameter("examtype");
		examName=request.getParameter("examname");
		status=request.getParameter("status");
		count=request.getParameter("count");
		securedMarks=request.getParameter("securedmarks");

		System.out.println("mode..."+mode+"....tableName..."+tableName);

		if(status.equals("2") && mode.equals("EVALUATION"))
		{
			rs=st.executeQuery("select ques_list from "+tableName+" where student_id='"+studentId+"' and count='"+count+"'");
			if(rs.next())
			{
				qList=rs.getString(1);
			}
			
			boolean aStrFlag=true;	// used to test whether there is any answer string or not.

			ansStr=new StringTokenizer(qList,"&");
			if(ansStr.hasMoreTokens())
			{
				aStr=ansStr.nextToken();
				try
				{
					qStr=ansStr.nextToken();
				}
				catch(NoSuchElementException e)
				{
					aStrFlag=false;
				}
			}

			if(aStrFlag==true)
			{	
				indMarks=new StringTokenizer(aStr,",");			//individual question marks
%>
				<script>
					var arr = new Array();
					var i=0;
				</script>
<%
				while(indMarks.hasMoreTokens())
				{
%>
					<script>
						arr[i]=<%=indMarks.nextToken()%>;
						i++;
					</script>
<%
				}	
%>
					<script>
						var j=0;
						for(var i=0;i<parent.frames["mid_f"].qType.length;i++)
						{	
							if(parent.frames["mid_f"].qType[i]==6)
							{
								var qid=parent.frames["mid_f"].qIds[i];
								var mid="M"+qid;
								qid="E"+qid;
								parent.mid_f.document.getElementById(qid).style.visibility="visible";
								parent.mid_f.document.getElementById(mid).value=arr[j++];
								parent.mid_f.document.getElementById(mid).readOnly=false;								
							}
							if(parent.frames["mid_f"].qType[i]==3)
							{
								var qid=parent.frames["mid_f"].qIds[i];
								var mid="M"+qid;
								qid="E"+qid;
								parent.mid_f.document.getElementById(qid).style.visibility="visible";
								parent.mid_f.document.getElementById(mid).value=arr[j++];
								parent.mid_f.document.getElementById(mid).readOnly=false;								
							}
						}
					</script>
<%
			}
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ModeSelector.jsp","General","Exception",e.getMessage());
		System.out.println("The Error in ModeSelector.jsp is : "+e);
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con1.close(con);
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ModeSelector.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The Error in ModeSelector.jsp is : "+se.getMessage());
		}
	}
%>

<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>

<SCRIPT LANGUAGE="JavaScript">

<!--
function setSubmissionMode()
{
	if(confirm("Are you sure that you want to take this assessment on behalf of <%=studentId%>?"))
	{
		parent.modeframe.location.href="ModeSelector.jsp?mode=SUBMISSION&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&securedmarks=<%=securedMarks%>";

		for(var i=1;i<=parent.frames["mid_f"].qIds.length;i++)
		{
			if(parent.frames["mid_f"].qType[i-1]==6)
			{
				var qid=parent.frames["mid_f"].qIds[i-1];
				qid="E"+qid;
				parent.mid_f.document.getElementById(qid).style.visibility="hidden";
			}
			if(parent.frames["mid_f"].qType[i-1]==3)
			{
				var qid=parent.frames["mid_f"].qIds[i-1];
				qid="E"+qid;
				parent.mid_f.document.getElementById(qid).style.visibility="hidden";
			}
		}
		parent.btm_f.location.href="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/bottom.html";
		parent.fb_f.location.href="/LBCOM/exam/TeacherAsmtBottom.jsp?examid=<%=examId%>&studentid=<%=studentId%>&attempt=<%=count%>&status=<%=status%>";
	}
	else
	{
		parent.modeframe.location.href="ModeSelector.jsp?mode=VIEW&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&securedmarks=<%=securedMarks%>";

		parent.btm_f.location.href="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/bottom.html";
		parent.fb_f.location.href="SubmissionDetails.jsp?studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&attempt=<%=count%>&status=<%=status%>&securedmarks=<%=securedMarks%>&mode=submission";
	}

	
}

function setEditMode()
{
	var stat=<%=status%>;
	if(stat==2)
	{
		parent.modeframe.location.href="ModeSelector.jsp?mode=EVALUATION&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&securedmarks=<%=securedMarks%>";
	
		for(var i=1;i<=parent.frames["mid_f"].qIds.length;i++)
		{
			
			if(parent.frames["mid_f"].qType[i-1]==6)
			{
				var qid=parent.frames["mid_f"].qIds[i-1];
				qid="E"+qid;
				parent.mid_f.document.getElementById(qid).style.visibility="visible";
			}
			if(parent.frames["mid_f"].qType[i-1]==3)
			{
				var qid=parent.frames["mid_f"].qIds[i-1];
				qid="E"+qid;
				parent.mid_f.document.getElementById(qid).style.visibility="visible";
			}
		}
		//parent.fb_f.location.href="EvaluatedEarlier.jsp?status="+stat;
		parent.fb_f.location.href="SubmissionDetails.jsp?studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&attempt=<%=count%>&status=<%=status%>&securedmarks=<%=securedMarks%>&mode=reeval";
	}
	else if(stat==1 || stat==5)
	{
		parent.modeframe.location.href="ModeSelector.jsp?mode=EVALUATION&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&securedmarks=<%=securedMarks%>";
	
		for(var i=1;i<=parent.frames["mid_f"].qIds.length;i++)
		{
			if(parent.frames["mid_f"].qType[i-1]==6||parent.frames["mid_f"].qType[i-1]==3)
			{
				var qid=parent.frames["mid_f"].qIds[i-1];
				qid="E"+qid;
				parent.mid_f.document.getElementById(qid).style.visibility="visible";
			}
		}
		parent.fb_f.location.href="EvaluateSubmission.jsp?studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>";
	}
}

function setViewMode()
{
	parent.modeframe.location.href="ModeSelector.jsp?mode=VIEW&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=count%>&securedmarks=<%=securedMarks%>";

	for(var i=1;i<=parent.frames["mid_f"].qIds.length;i++)
	{
		if(parent.frames["mid_f"].qType[i-1]==6||parent.frames["mid_f"].qType[i-1]==3)
		{
			var qid=parent.frames["mid_f"].qIds[i-1];
			qid="E"+qid;
			parent.mid_f.document.getElementById(qid).style.visibility="hidden";
		}
	}
	parent.fb_f.location.href="SubmissionDetails.jsp?studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&attempt=<%=count%>&status=<%=status%>&securedmarks=<%=securedMarks%>&mode=view";
}
//-->
</SCRIPT>
</head>

<body>
<form>
<table border="1" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="33%" bgcolor="#E3CDB7" align="center">
    <input type="button" ONCLICK="setViewMode()" border="0" value="VIEW MODE" name="B3"></td>
    <td width="33%" align="center" bgcolor="#E3CDB7">
    <input type="button" ONCLICK="setEditMode()" border="0" value="EVALUATION MODE" name="B4"></td>
    <td width="34%" align="center" bgcolor="#E3CDB7">
    <input type="button" ONCLICK="setSubmissionMode()" border="0" value="SUBMISSION MODE" name="B5"></td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="100%" bgcolor="#CCA47B" align="left"><b>
    <font size="2" face="verdana"><%=mode%> MODE</font></b></td>
  </tr>
</table>

<input type="hidden" name="attempt" id="attempt" value="">

</form>
</body>
</html>
