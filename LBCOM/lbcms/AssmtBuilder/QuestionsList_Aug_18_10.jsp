<jsp:useBean	 id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.sql.*,java.util.*,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=50;
	synchronized public String getDifficultyLevel(int level){
		String difficultLevel="";
		if(level==0)
			difficultLevel="Very Easy";
		else if (level==1)
			difficultLevel="Easy";
		else if (level==2)
			difficultLevel="Average";
		else if (level==3)
			difficultLevel="Above Average";
		else if (level==4)
			difficultLevel="Difficult";
		return difficultLevel;
		
	}
%>
<%
	
	Connection  con=null;
	Statement   st=null;
	ResultSet	rs=null;
	String sessid=null;
	String mode="",dbString="",linkStr="",schoolId="",AssmtView="";
	String qId="",qT="",qBody="",bgColor="",forecolor="",qList="",q_ids="",possible_points="",inc_Response="",developerId="",courseName="";
	String courseId="",classId="",topicId="",subTopicId="",qType="",tblName="",status="",assmtId="",examName="",variations="",examType="";
	int totRecords=0,start=0,c=0,end=0,currentPage=0;

%>
<%
	    sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}

		mode=request.getParameter("mode");
		AssmtView=request.getParameter("view");
		if(AssmtView==null||AssmtView=="")
			AssmtView="false";
			else
				AssmtView=request.getParameter("view");

		if(AssmtView.equals("false"))
		{
			con=con1.getConnection();
			st=con.createStatement();
		schoolId=(String)session.getAttribute("schoolid");
		classId		  = request.getParameter("classid");
	    courseId	  = request.getParameter("courseid");
	    //qType=request.getParameter("qtype");
		developerId=request.getParameter("userid");
		topicId=request.getParameter("topicid");
		subTopicId=request.getParameter("subid");
		status=request.getParameter("status");
		assmtId=request.getParameter("assmtId");
		//tblName		  = schoolId+"_"+classId+"_"+courseId;
		examType=request.getParameter("examtype");
		
		rs=st.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+courseId+"'and assmt_id='"+assmtId+"'");
		if(rs.next())
		{
			examName=rs.getString("assmt_name");
			courseName=rs.getString("course_name");
		}
		
		int random=1;
	    variations="1";
		int sort=0;
		int noOfGrps=1;

		tblName="lbcms_dev_assmt_content_quesbody";
try{
	
	con=db.getConnection();
	st=con.createStatement();

	/*rs=st.executeQuery("show tables like '"+tblName+"_sub'");
	if(!(rs.next())){
		out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Questions not yet created for this course.</font></b></td></tr></table>");				
		return;
    }*/
	

	if (request.getParameter("totrecords").equals("")) {
		
		  
		   if(subTopicId.equals("none"))
		{
			   
				dbString="select count(*) from "+tblName+" q where q.assmt_id='"+assmtId+"' and q.status!='2' and course_id='"+courseId+"' order by q.q_id";
				System.out.println("dbString..."+dbString);
		}

			st=con.createStatement();   
			rs=st.executeQuery(dbString);
			   

		   if (rs.next())
		 		c=rs.getInt(1);
		   if (c!=0 )
			   totRecords=c;
		   else{
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Sorry! Questions not found</font></b></td></tr></table>");				
					return;
             }//end else
		}//end if tot==none
		else 
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
	   
	   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	   start=Integer.parseInt(request.getParameter("start"));

	   c=start+pageSize;
	   end=start+pageSize;

	   if (c>=totRecords) 
		   end=totRecords;
       
	   

	   if(subTopicId.equals("none"))
	{
			dbString="select q.q_id,q.q_type,q.q_body,q.difficult_level,q.possible_points,q.incorrect_response from "+tblName+" q where q.assmt_id='"+assmtId+"' and q.status!='2' and course_id='"+courseId+"' order by q.q_id  LIMIT "+start+","+pageSize;
			System.out.println(" 2   dbString....."+dbString);
	}

	   rs=st.executeQuery(dbString);
	   bgColor="#EFEFEF";
	   forecolor="#666699";
	   currentPage=(start/pageSize)+1;
  }catch(SQLException se){
	ExceptionsFile.postException("QuestionsList.jsp","operations on database","SQLException",se.getMessage());
	System.out.println("The error in QuestionsList.jsp is sql error : "+se);
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		
	}catch(SQLException e){
		ExceptionsFile.postException("QuestionsList.jsp","closing statement and connection  objects","SQLException",e.getMessage());
		System.out.println(e.getMessage());
	}
  }catch(Exception e){
	ExceptionsFile.postException("QuestionsList.jsp","operations on database","Exception",e.getMessage());
	System.out.println("The error in QuestionsList.jsp is exce : "+e);
  }

%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function saveQuestions()
{
	document.location.href="QuestionsList.jsp?mode=add&enableMode=null&start=0&totrecords=&start=&topicid=none&subid=none&samePage=0&visited=1&difflevel=-1&courseid=<%=courseId%>&classid=C000&assmtId=<%=assmtId%>&save=yes&noofgrps=<%=noOfGrps%>&assmtname=<%=examName%>&examid=<%=assmtId%>&examtype=<%=examType%>&coursename=<%=courseName%>";
}
function submitAssmt()
{
	document.location.href="/LBCOM/exam.AssBuilderVariations?noofgrps=<%=noOfGrps%>&examname=<%=examName%>&examid=<%=assmtId%>&examtype=<%=examType%>&courseName=<%=courseName%>&courseid=<%=courseId%>&random1=<%=random%>&variations=<%=variations%>&sort1=<%=sort%>";
}
</script>

<!--[if IE]>
<style type="text/css">
*{
font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
}
</style>
<![endif]-->

<SCRIPT LANGUAGE="JavaScript">
<!--
	
function check_all(){
	var frm=window.document.viewQuestions;
	var flag=frm.checkAll.checked;
	if(!frm.qidlist.length)
		frm.qidlist.checked=flag;
	else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++)
			frm.qidlist[i].checked=flag;
	}
}

function go(start,totrecords){	
		
		parent.q_ed_fr.location.href="QuestionsList.jsp?courseid=<%=courseId%>&classid=<%=classId%>&topicid=<%=topicId%>&subid=<%=subTopicId%>&qtype=<%=qType%>&totrecords="+totrecords+"&start="+start+"&status=";
		return false;
}
function gotopage(totrecords){
		var page=document.viewQuestions.page.value;
		if(page==0){
			alert("Please select page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			parent.q_ed_fr.location.href="QuestionsList.jsp?courseid=<%=courseId%>&classid=<%=classId%>&topicid=<%=topicId%>&subid=<%=subTopicId%>&qtype=<%=qType%>&totrecords="+totrecords+"&start="+start+"&status=";
			return false;
		}
}


function deleteQuestion(qid,asmtid){
		if(confirm("Are you sure that you want to delete the question?")==true){		
	     window.location.href="/LBCOM/exam.EditQuestions?mode=del&asmtid="+asmtid+"&courseid=<%=courseId%>&classid=<%=classId%>&qid="+qid+"&qtype=<%=qType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>";
		 //window.location.href="QuestionsList.jsp?mode=del&enableMode=null&start=0&totrecords=&start=&topicid=none&subid=none&samePage=0&visited=1&difflevel=-1&courseid=<%=courseId%>&coursename=<%=courseName%>&classid=C000&assmtId=<%=assmtId%>&userid=<%=developerId%>&qid="+qid;

		   return false;
		}
		else
			return false;
}

function deleteAllQuestions(){
		var selid=new Array();
		with(document.viewQuestions) {
			 for (var i=0,j=0; i < elements.length; i++) {
					if (elements[i].type == 'checkbox' && elements[i].name == 'qidlist'&& elements[i].checked==true) {
							selid[j++]=elements[i].value;

					}
			  }
		}	
		if (j>0) {
			if(confirm("Are you sure that you want to delete the selected question(s)?")==true){		 										window.location.href="/LBCOM/exam.EditQuestions?mode=deleteall&classid=<%=classId%>&courseid=<%=courseId%>&qtype=<%=qType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&selids="+selid;
			}else
				return false;
		}else {
			alert("Select the question(s) to be deleted");
			return false;
		}
}

function showQtn(qId,qnTbl){
		var w=window.open("ShowQuestion.jsp?qid="+qId+"&qntbl="+qnTbl,"Question","width=600,height=300,scrollbars=yes");
                w.focus();
		
}
function editQuestion(qid,qtype)
{
    
	var win;        
	//win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid="+qid+"&classid=<%=classId%>&courseid=<%=courseId%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&qtype=<%=qType%>","qed_win","width=875,height=525,scrollbars=yes");
	win=window.open("fetchQuestion.jsp?qid="+qid+"&assmtId=<%=assmtId%>&classid=C000&courseid=<%=courseId%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&qtype="+qtype+"","qed_win","width=875,height=525,scrollbars=yes");

	win.focus();
}



//-->
</script>
</head>
<body topmargin="0" leftmargin="0" >
<form name="viewQuestions" method="GET" action="">
</form>
<center>
  <table border="0" width="99%" bordercolorlight="#000000" cellspacing="1" bordercolordark="#000000" cellpadding="0">
    <tr>
      <td width="100%" >
        <div align="center">
<table border="0" width="766" cellspacing="1" bordercolordark="#C2CCE0"  >

  <tr>
	<td colspan="5">
<table border="0" width="766" cellspacing="0" cellpadding="0" bordercolordark="#C2CCE0"  >
  <tr>
    <td bgcolor="#C2CCE0" height="21" >
      <sp align="right"><font size="2" face="Arial" ><span class="last">Questions <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span></font></td>
	  <td bgcolor="#C2CCE0" height="21" align="center" ><font color="#000080" face="arial" size="2">
	  <%

	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+qType+"',0);return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+qType+"',0);return false;\">Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+qType+"',0);return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
	  </font></td>
	  <td  bgcolor='#C2CCE0' height='21' align='right' ><font face="arial" size="2">Page&nbsp;
	  <%int index=1;
	    int str=0;
	    int noOfPages=0;
		if((totRecords%pageSize)>0)
		    noOfPages=(totRecords/pageSize)+1;
		else
			noOfPages=totRecords/pageSize;
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"');return false;\"> ");

		while(index<=noOfPages){
				
				if(index==currentPage){
				    out.println("<option value='"+index+"' selected>"+index+"</option>");
				}else{
					out.println("<option value='"+index+"'>"+index+"</option>");
				}
				index++;
				str+=pageSize;

		
	   }%>
	  </select>
	  </font></td>
  </tr>
  </table>
  </td>
  </tr>
</table>
<table width="759">
<tr>
    <td width="20" bgcolor="#CECBCE" height="18" align="center" valign="middle">
     <!-- <input type="checkbox" name="checkAll" onclick="return check_all();" value="ON" > --> </td>
    <td width="28" bgcolor="#CECBCE" height="18" align="center" valign="middle"><font size="2" face="Arial" color="#000080"><b><!-- <a href="#" onclick="return deleteAllQuestions()" > --><a href="#" onclick="alert('will be added soon!')" ><img border="0" src="images/idelete.gif"  TITLE="Delete all."></b></font></a></td>
   <td width="11" bgcolor="#CECBCE" height="18" align="center" valign="middle">&nbsp;</td>
   <td width="335" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Question Description</font></b></td>
   <td width="140" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Correct Response</font></b></td>
   <td width="86" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Incorrect Response</font></b></td>
   <td width="50" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Question Type</font></b></td>
</tr>
 
<%	try{
	int difficultLevel=0,pointsPossible=0;
	String questionType="";
	while(rs.next()){
		qId=rs.getString(1);
		qT=rs.getString(2);
		if(qT.equals("0"))
			questionType="Multiple choice";
		if(qT.equals("1"))
			questionType="Multiple answers";
		if(qT.equals("2"))
			questionType="Yes/No";
		if(qT.equals("3"))
			questionType="Fill in the blanks";
		if(qT.equals("4"))
			questionType="Matching";
		if(qT.equals("5"))
			questionType="Ordering";
		if(qT.equals("6"))
			questionType="Short/Essay-type";

		qBody=QuestionFormat.getQString(rs.getString("q_body"),50);
		difficultLevel=rs.getInt("difficult_level");
		pointsPossible=rs.getInt("possible_points");
		q_ids=rs.getString("q_id");
		possible_points=rs.getString("possible_points");
		inc_Response=rs.getString("incorrect_response");

		//qList=qList+(q_ids+":"+possible_points+".0:"+inc_Response+".0:-#");

		qList=qList+(q_ids+":"+possible_points+".0:0.0:-#");
		
		String qnTblName="lbcms_dev_assmt_content_quesbody";
		out.println("<tr>");
		out.println("<td width='20' height='18' bgcolor='"+bgColor+"'align='center' valign='middle'><font size='2' face='Arial' color='"+forecolor+"'><!-- <input type='checkbox' name='qidlist' value='"+qId+"'> --></font></td>");
		out.println("<td width='28' height='18' bgcolor='"+bgColor+"' valign='middle' align='center'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"return deleteQuestion('"+qId+"','"+assmtId+"');\"><!-- <a href='#' onclick=\"alert('will be added soon')\"> --> <img border='0 ' src='images/idelete.gif' TITLE='Delete.' ></font></td>");
		out.println("<td width='11' height='18' bgcolor='"+bgColor+"' align='center' valign='middle'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"return editQuestion('"+qId+"','"+qT+"');\"><!-- <a href='#' onclick=\"alert('will be added soon')\"> --> <img border='0' src='images/iedit.gif' TITLE='Edit.' ></font></td>");	
		out.println("<td width='335' height='18' bgcolor='"+bgColor+"'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"showQtn('"+qId+"','"+qnTblName+"');\">"+qBody+"</a> </font></td>");
		out.println("<td width='140' height='18' bgcolor='"+bgColor+"'><input type='text' name='corr' size='3' value='"+pointsPossible+"' READONLY></input></td>");
		out.println("<td width='86' height='18' bgcolor='"+bgColor+"'><input type='text' name='incorr' size='3' value='"+inc_Response+"' READONLY></input></td>");
		out.println("<td width='50' height='18' bgcolor='"+bgColor+"'><font size='2' face='Arial' color='"+forecolor+"'>"+questionType+"</font></td></tr>");
		


	}//end while
	if(request.getParameter("save").equals("yes"))
	{
		int len=qList.length();
		len=len-1;
		qList=qList.substring(0,len);
		int ud=st.executeUpdate("update lbcms_dev_assessment_master set ques_list='"+qList+"' where assmt_id='"+assmtId+"'");
	}

	 if(mode.equals("del"))
	{
	
	int d=st.executeUpdate("Delete from  lbcms_dev_assmt_content_quesbody  where assmt_id='"+assmtId+"' and q_id='" + request.getParameter("qid") + "'");

	}
		
	%>
	
<%
	
}catch(Exception e){
		ExceptionsFile.postException("QuestionsList.jsp","operations on database","Exception",e.getMessage());
}finally{
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		
	}catch(SQLException se){
		ExceptionsFile.postException("QuestionsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}

}
%>
</table>
<p align="center">
<font face="Arial" size="2">
		<input type="image" src="images/bsave.gif" name="save" onclick="saveQuestions(); return false;">
		<input type="image" src="images/submit.jpg" name="submit" onclick="submitAssmt(); return false;">
</form>
</body>
<%
		}
else
{
String path="";
 courseId=request.getParameter("courseid");
assmtId=request.getParameter("exId");
path="/LBCOM/lbcms/AssmtBuilder/exams/"+courseId+"/"+assmtId+"/1.html";
//path=path+"1.html";
%>
<font size=3>Assessment Submited Sucessfully<a href="<%=path%>" target="_blank">View</a></font>
<%
}
%>


</html>