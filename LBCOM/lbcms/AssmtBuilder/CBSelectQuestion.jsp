<jsp:useBean	 id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.sql.*,java.util.*,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	int pageSize=15;
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
	String mode="",dbString="",linkStr="",schoolId="",assmtId="";
	String qId="",qT="",qBody="",bgColor="",forecolor="";
	String courseId="",classId="",topicId="",subTopicId="",qType="",tblName="",status="";
	int totRecords=0,start=0,c=0,end=0,currentPage=0;

%>
<%
	    sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}

		schoolId=(String)session.getAttribute("schoolid");
		classId		  = request.getParameter("classid");
	    courseId	  = request.getParameter("courseid");
	    qType=request.getParameter("qtype");
		topicId="none";
		subTopicId="none";
		status="0";
		assmtId=request.getParameter("assmtId");

		tblName="lbcms_dev_assmt_content_quesbody";
		
try{
	
	con=db.getConnection();
	st=con.createStatement();

	
	if (request.getParameter("totrecords").equals("")) {
		
				
		   dbString="select  count(*) from lbcms_dev_assmt_content_quesbody s where course_id='"+courseId+"' and q_type='"+qType+"' and assmt_id!='"+assmtId+"' order by q_id";

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
       
	 
			dbString="select  * from lbcms_dev_assmt_content_quesbody as q where q.course_id='"+courseId+"' and q.q_type='"+qType+"' and assmt_id!='"+assmtId+"' order by q.q_id LIMIT "+start+","+pageSize;

	   rs=st.executeQuery(dbString);
	   bgColor="#EFEFEF";
	   forecolor="#666699";
	   currentPage=(start/pageSize)+1;
  }catch(SQLException se){
	ExceptionsFile.postException("QuestionsList.jsp","operations on database","SQLException",se.getMessage());
	System.out.println("The error in QuestionsList.jsp is : "+se);
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
	System.out.println("The error in QuestionsList.jsp is : "+e);
  }

%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
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
		
		parent.location.href="CBSelectQuestion.jsp?courseid=<%=courseId%>&classid=<%=classId%>&topicid=<%=topicId%>&subid=<%=subTopicId%>&qtype=<%=qType%>&assmtId=<%=assmtId%>&totrecords="+totrecords+"&start="+start+"&status=";
		return false;
}
function gotopage(totrecords){
		var page=document.viewQuestions.page.value;
		if(page==0){
			alert("Please select page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			parent.location.href="CBSelectQuestion.jsp?courseid=<%=courseId%>&classid=<%=classId%>&topicid=<%=topicId%>&subid=<%=subTopicId%>&qtype=<%=qType%>&assmtId=<%=assmtId%>&totrecords="+totrecords+"&start="+start+"&status=";
			return false;
		}
}


function deleteQuestion(qid){
		if(confirm("Are you sure that you want to delete the question?")==true){		
	     window.location.href="/LBCOM/exam.EditQuestions?mode=del&courseid=<%=courseId%>&classid=<%=classId%>&qid="+qid+"&qtype=<%=qType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>";
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
function editQuestion(qid)
{
    
	var win;        
	win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid="+qid+"&classid=<%=classId%>&courseid=<%=courseId%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&qtype=<%=qType%>","qed_win","width=875,height=525,scrollbars=yes");
	win.focus();
}

function subQues()
{
	var selid=new Array();
		with(document.viewQuestions) {
			 for (var i=0,j=0; i < elements.length; i++) {
					if (elements[i].type == 'checkbox' && elements[i].name == 'qidlist'&& elements[i].checked==true) {
							selid[j++]=elements[i].value;
							alert(elements[i].value);

					}
			  }
		}	
		if (j>0) {
			if(confirm("Are you sure that you want to add the selected question(s)?")==true){		 										window.location.href="/LBCOM/lbcms/AssmtBuilder/CBCreateQuestions.jsp?mode=add&classid=<%=classId%>&courseid=<%=courseId%>&qtype=<%=qType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&assmtid=<%=assmtId%>&selids="+selid;
			}else
				return false;
		}else {
			alert("Please select the question(s) first");
			return false;
		}
}



//-->
</script>
</head>
<body topmargin="0" leftmargin="0" >
<form name="viewQuestions" >
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="1" bordercolordark="#000000" cellpadding="0">
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

<tr>
    <td width="13" bgcolor="#CECBCE" height="18" align="center" valign="middle"><input type="checkbox" name="checkAll" onclick="return check_all();" ></td>
    <td width="13" bgcolor="#CECBCE" height="18" align="center" valign="middle"><font size="2" face="Arial" color="#000080"><b><a href="#" onclick="return deleteAllQuestions()" ><!-- <img border="0" src="images/idelete.gif"  TITLE="Delete all."> --></b></font></a></td>
   <td width="13" bgcolor="#CECBCE" height="18" align="center" valign="middle">&nbsp;</td>
   
   <td width="100" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Difficulty Level</font></b></td>
   
</tr>
 
<%	try{
	int difficultLevel=0;
	while(rs.next()){
		qId=rs.getString("q_id");
		qT=rs.getString("q_type");
		qBody=QuestionFormat.getQString(rs.getString("q_body"),50);
		difficultLevel=rs.getInt("difficult_level");

		String qnTblName="lbcms_dev_assmt_content_quesbody";
		out.println("<tr>");
		out.println("<td width='13' height='18' bgcolor='"+bgColor+"'align='center' valign='middle'><font size='2' face='Arial' color='"+forecolor+"'><input type='checkbox' name='qidlist' value='"+qId+"'></font></td>");
		out.println("<td width='13' height='18' bgcolor='"+bgColor+"' valign='middle' align='center'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"return deleteQuestion('"+qId+"');\"> <!-- <img border='0 ' src='images/idelete.gif' TITLE='Delete.' > --></font></td>");
		out.println("<td width='13' height='18' bgcolor='"+bgColor+"' align='center' valign='middle'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"return editQuestion('"+qId+"');\"> <!-- <img border='0' src='images/iedit.gif' TITLE='Edit.' > --></font></td>");	
		out.println("<td width='650' height='18' bgcolor='"+bgColor+"'><font size='2' face='Arial' color='"+forecolor+"'><a href='#' onclick=\"showQtn('"+qId+"','"+qnTblName+"');\">"+qBody+"</a> </font></td>");
		out.println("<td width='100' height='18' bgcolor='"+bgColor+"'><font size='2' face='Arial' color='"+forecolor+"'>"+getDifficultyLevel(difficultLevel)+"</font></td></tr>");
		


	}//end while 
%>
<tr>
	<td><input type="button" name="b1" value="Submit" onclick="subQues(); return false;"></td>
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
</form>
</body>
