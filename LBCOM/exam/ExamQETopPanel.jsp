<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 

<title></title>
</head>

<body topmargin=2 leftmargin=0>

<form name="examform" id='qt_sel_id'>

<%@page import="java.io.*,java.sql.*,utility.Utility,coursemgmt.ExceptionsFile"%>
<%@ page language="java" import="java.sql.*,java.io.*" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String courseName="",classId="",courseId="",qId="",type="",mode="",examId="",examType="",examName="",schoolId="",enableMode="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
Utility utility=null;
boolean flag=false;
%>


<%
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	try{
	con=db.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	
	
	type=request.getParameter("type");
	enableMode=request.getParameter("enableMode");
	session.removeValue("qidlist");
	 if (type.equals("create")) {
		 classId=(String)session.getAttribute("classid");
		 courseName=(String)session.getAttribute("coursename");
		 courseId=(String)session.getAttribute("courseid");
		 mode=request.getParameter("mode");
		 examId=request.getParameter("examid");
		 examType=request.getParameter("examtype");
		 examName=request.getParameter("examname");
		
	 }
	 else {
		classId=request.getParameter("classid");
		courseId=request.getParameter("courseid");
		
	}
	  
	
		
	out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
    out.println("<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");
    out.println("<td><b><font face='Arial' size='2' color='#FF65CE'><td align=right>Topic :</td>");
	
	out.println("<td><select id='topic_id' name='topicid' onchange='getsubids(this.value)';>");
	out.println("<option value='none' selected>Select</option>");
    rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
	
    while (rs.next()) {
		
		out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		
	}	
	out.println("</select></td>");




	
	out.println("<td align=right>SubTopic</td><td><select id='subtopic_id' name='subtopicid' onchange=\"document.examform.qtype.value='none'\">");
	out.println("<option value='none' selected>Select</option></select></td>");	
	
	

	out.println("<td align=right>Question type</td><td>");
	out.println("<select id='qtype_id' name='qtype' onchange='changeval();'>");
	out.println("<option value='none' selected>........Select........</option>");
	out.println("<option value=0>Multiple choice </option>");
	out.println("<option value=1>Multiple answer</option>");
	out.println("<option value=2>yes/no</option>");
	out.println("<option value=3>Fill in the blanks</option>");
	out.println("<option value=4>Matching</option>");
	out.println("<option value=5>Ordering</option>");
	if (!examType.equals("ST"))
		out.println("<option value=6>Short/Essay-type</option>");		
	out.println("</select>");

	out.println("</td>");

	out.println("<td align=right><font face='Arial' size='2' >Difficulty Level</font></td><td>");
	out.println("<select id='diff_id' name='diff_level' onchange='call();return false;'>");
	out.println("<option value='-1'>........Select........</option>");
	out.println("<option value='0'>Very Easy</option>");
	out.println("<option value='1'>Easy</option>");
	out.println("<option value='2'>Average</option>");
	out.println("<option value='3'>Above Average</option>");
	out.println("<option value='4'>Difficult</option>");
	out.println("</select>");
	out.println("</td>");
	
	//out.println("<td align=right><a href='javascript://' onclick='call();return false;'><font face='arial' size='2'><b>>></b></font></a></td>");
	out.println("</tr></table>");
	
	//category=request.getParameter("category");
%>


<input type="hidden" id="grade_id" name="gradeid" value="<%= classId %>">
<input type="hidden" id="course_id" name="courseid" value="<%= courseId %>">
<input type="hidden" id="q_id" name="qid" value="<%= qId %>">

</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var topic=new Array();\n");
    rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
	out.println("</script>\n");
 }catch(Exception e){
		ExceptionsFile.postException("ExamQETopPanel.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ExamQETopPanel.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

	<script language="javascript">

	var tot_ques = new Array(26);
	var sel_ques_counter =new Array();
	for(var i=0;i<=26;i++) {//7-12-2004
		sel_ques_counter[sel_ques_counter.length]=0;
	}

	var q_type=new Array();
	for(var i=0;i<=26;i++)
		q_type[q_type.length]=7;
	var sel_ques = new Array(27);
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
//	var same_page   =0;
//end temp


	function call(obj){
		var v=obj.value;
		var tid=document.examform.topicid.value;
		var stid=document.examform.subtopicid.value;
		var difflevel=document.examform.diff_level.value;
		var t="<%=type%>";
		if (t=="qe") {
			if (v==0)
				parent.qed_fr.location.href='qeditor/t92.html';
			else if(v==1)
				parent.qed_fr.location.href='qeditor/t91.html';
			else if(v==2)
				parent.qed_fr.location.href='qeditor/t93.html';
			else if(v==3)
				parent.qed_fr.location.href='qeditor/t95.html';
			else if(v==4)
				parent.qed_fr.location.href='qeditor/t96.html';
			else if(v==5)
				parent.qed_fr.location.href='qeditor/t97.html';
			else if(v==6)
				parent.qed_fr.location.href='qeditor/t94.html';
		}else {
			parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype="+v+"&cat=none&examtype=<%=examType%>&topicid="+tid+"&subtopicid="+stid+"&samePage="+same_page+"&visited="+visited+"&difflevel="+difflevel;
			
			
		}

	}
	function call(){
		var v=document.examform.qtype.value;
		var tid=document.examform.topicid.value;
		var stid=document.examform.subtopicid.value;
		var difflevel=document.examform.diff_level.value;
		var t="<%=type%>";
		if (t=="qe") {
			if (v==0)
				parent.qed_fr.location.href='qeditor/t92.html';
			else if(v==1)
				parent.qed_fr.location.href='qeditor/t91.html';
			else if(v==2)
				parent.qed_fr.location.href='qeditor/t93.html';
			else if(v==3)
				parent.qed_fr.location.href='qeditor/t95.html';
			else if(v==4)
				parent.qed_fr.location.href='qeditor/t96.html';
			else if(v==5)
				parent.qed_fr.location.href='qeditor/t97.html';
			else if(v==6)
				parent.qed_fr.location.href='qeditor/t94.html';
		}else {
			if(v=="none"){
				alert("Please select the question type");
				return false;
			}else{
				parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype="+v+"&cat=none&examtype=<%=examType%>&topicid="+tid+"&subtopicid="+stid+"&samePage="+same_page+"&visited="+visited+"&difflevel="+difflevel;
			}			
		}

	}
	function changeval(){
		
		document.examform.diff_level.value="-1";
		var v=document.examform.qtype.value;
		var tid=document.examform.topicid.value;
		var stid=document.examform.subtopicid.value;
		var difflevel=document.examform.diff_level.value;
		
		parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype="+v+"&cat=none&examtype=<%=examType%>&topicid="+tid+"&subtopicid="+stid+"&samePage="+same_page+"&visited="+visited+"&difflevel="+difflevel;
	}
	function getsubids(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<topic.length;i++)
		{
			if(topic[i][0]==id)
			{
				document.examform.subtopicid[j]=new Option(topic[i][2],topic[i][1]);
				j=j+1;
			}
		} 
	}

	function clear() {
		var i;
		var temp=document.examform.subtopicid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype=none&cat=none&examtype=<%=examType%>&topicid=none&subtopicid=none&samePage=0&visited=0";


<%  if (enableMode.equals("0")){ %>
		var frm=document.examform;
		for (var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;

		<% } %>


</script>
</html>
