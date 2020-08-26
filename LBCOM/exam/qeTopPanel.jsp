<%@page import="java.io.*,java.sql.*,utility.Utility,coursemgmt.ExceptionsFile"%>
<%@ page language="java" import="java.sql.*,java.io.*" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>
<%
String courseName="",classId="",courseId="",qId="",type="",mode="",examId="",examType="",sessionId="",schoolId="";
String qepath="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
Utility utility=null;
boolean flag=false;
%>
<%
	session=request.getSession();

	sessionId=(String)session.getAttribute("sessid");
	if(sessionId==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
    qepath = application.getInitParameter("q_editor_path");
	schoolId=(String)session.getAttribute("schoolid");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title></title>

<script language="JavaScript">

QEdStatus = "Initialized";

function f_submit(i,sel) 
{
	if (sel.value == "")
	{
		alert("Please select question type");
		return (false);
	}

	if (QEdStatus && confirm('The current editing job will be lost.'))
	{
 		QEdStatus = false;
	}
	
	if (!QEdStatus)
	{
		if(parent.frames[2].document.getElementById('r_sub_stat')!=null) 
		{
			parent.frames[2].preserveStatus();
			var win = parent.frames[2].SymWin;
			if (win != null) 
				win.close();
		}
		QEdStatus = true;
		document.forms[i].submit();
	}
}

function t_change(stat)
{
	if (QEdStatus == "Initialized")
	{
		parent.frames[2].location.href='q_editor.html';
		QEdStatus = false;
	} 
	else if(QEdStatus && confirm('The current editing job will be lost.')) 
	{
		parent.frames[2].location.href='q_editor.html';
		QEdStatus = false;
	} 
	else 
	{
		return(false);
	}
}

</script>

</head>
<body topmargin=2 leftmargin=0 onUnload="if(parent.frames[2].SymWin != null)
        parent.frames[2].SymWin.close();">
<%

%>
<form name="qt_new" id='qt_new_id' action='/LBCOM/qeditor/fetchQuestion.jsp' target='qed_win' method="get"> 




<%	
	classId=request.getParameter("classid");
	courseId=request.getParameter("courseid");	 
			
	out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='white' height='24'>");
    out.println("<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");
    out.println("<td align=right><font face='Arial' size='2' >Topic :</font></td>");
	
	out.println("<td><select id='topic_id' name='topicid' onchange='getsubids(this.value)';>");
	out.println("<option value='none' selected>Select</option>");
	try{
		con=db.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
	
	rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
    while (rs.next()) {
		out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		
	}	
	out.println("</select></td>");
			
	
	out.println("<td align=right><font face='Arial' size='2' >Subtopic</font></td><td><select id='subtopic_id' name='subtopicid' onchange=\"document.qt_new.qtype.value='none'\">");
	out.println("<option value='none' selected>Select</option></select></td>");		
	out.println("<td align=right><font face='Arial' size='2' >Question type</font></td><td>");
	out.println("<select id='qtype_id' name='qtype' onchange=\"call('L')\">");
	out.println("<option value='none'>........Select........</option>");
	out.println("<option value=0>Multiple choice </option>");
	out.println("<option value=1>Multiple answer</option>");
	out.println("<option value=2>Yes/No</option>");
	out.println("<option value=3>Fill in the blanks</option>");
	out.println("<option value=4>Matching</option>");
	out.println("<option value=5>Ordering</option>");
	out.println("<option value=6>Short/Essay-type</option>");			
	out.println("</select>");
	out.println("</td>");

	out.println("<td><a href='#'  onclick=\"call('C')\"><font face='Arial' size='2' ><b>Create</b></A></td>");
out.println("<td><a href='#'  onclick=\"call('L')\"><font face='Arial' size='2' ><b>List</b></a></td>");

	out.println("</tr></table>");
	

%>


<input type="hidden" id="class_id" name="classid" value="<%= classId %>">
<input type="hidden" id="course_id" name="courseid" value="<%= courseId %>">
<input type="hidden" id="q_id" name="qid" value="new">
<input type="hidden" id="session_id" name="sessionid" value="<%= sessionId %>">
</form>

</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var topic=new Array();\n");

	rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+ rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
	out.println("</script>\n");
}catch(Exception e){
		ExceptionsFile.postException("qeTopPanel.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("qeTopPanel.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}

    }
%>

	<script language="javascript">

/*		var tot_ques = new Array(26);
	var sel_ques_counter =new Array();
	for(var i=0;i<26;i++) {
	//	alert(sel_ques_counter.length+"---selected questions counter.length");
		sel_ques_counter[sel_ques_counter.length]=0;
	}
	var q_type=new Array();
	for(var i=0;i<26;i++)
		q_type[q_type.length]=7;
	var sel_ques = new Array(26);
	var wtg_ng	 = new Array();
	var visited	 =0;

//This variables are temp. 	
	var sel_group_status=new Array(27);
	var group_status=new Array(27);
	var gr_tot_qtns =new Array(27);
	var gr_sel_qtns=new Array(27);
	var same_page   =0;
	var flag=false;

	var group_status=new Array(27);
	var same_page   =0;
//end temp */



	function call(tag)
	{
		var qtype=document.qt_new.qtype.value;
		var tid=document.qt_new.topicid.value;
		var stid=document.qt_new.subtopicid.value;
		
		var win;
		//String qepath = application.getInitParameter("q_editor_path");
       	if (qtype=="none")
		{
           alert("Please select question type");
           return;
        }
        if(tag=="C")
		{
			win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid=new&classid=<%=classId%>&courseid=<%=courseId%>&topicid="+tid+"&subtopicid="+stid+"&qtype="+qtype,"qed_win","width=875,height=525,scrollbars=yes");
			//document.qt_new.submit();
			//top.refreshframe.location.href='/LBCOM/refresh.html';
						
			winFlag=true;
			top.topframe.questionEditorWindow=win;
			win.focus();
		}
		else
		{						
			win=parent.q_ed_fr.location.href="QuestionsList.jsp?topicid="+tid+"&subid="+stid+"&qtype="+qtype+"&classid=<%=classId%>&courseid=<%=courseId%>&totrecords=&start=0&status=";
		}

	}

	function getsubids(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<topic.length;i++){
			if(topic[i][0]==id){
				document.qt_new.subtopicid[j]=new Option(topic[i][2],topic[i][1]);
				j=j+1;
			}
		} 
	}

	function clear() {
		var i;
		var temp=document.qt_new.subtopicid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}



</script>
</html>
