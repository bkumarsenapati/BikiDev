<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,utility.*,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",instruct="",s="",schoolId="",developerId="";
	String assmtName="",assmtContent="",cat="",mode="",destUrl="",tableName="",qt="",ExamId="",assmtId="",classId="";
	 String Question="",Qtype="";
	int points=0,assmto=0;
	try
	{	 
		session=request.getSession();
		s=(String)session.getAttribute("sessid");
		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		developerId=request.getParameter("userid");
		
		if(s==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		if(request.getParameter("mode")!=null)
			mode=request.getParameter("mode");
		else
			mode="q";
		
		courseId=request.getParameter("courseid");
		qt=request.getParameter("qt");
		//out.print("inn."+mode+qt);
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		Qtype=request.getParameter("qtype");
		courseName=request.getParameter("coursename");
		lessonName=request.getParameter("lessonname");
		assmtName=request.getParameter("asname");
		cat=request.getParameter("cattype");
		instruct=request.getParameter("instruct");
		con=con1.getConnection();
		st=con.createStatement();
		
		int k=0;

		
		
		
			if(mode.equals("add"))
			{
				
             
				
				String schoolPath = application.getInitParameter("schools_path");
				
				if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
				
				Utility utility= new Utility(schoolId,schoolPath);
				ExamId=utility.getId("DevExamId");
				if (ExamId.equals(""))
					{
						utility.setNewId("DevExamId","d0000");
						ExamId=utility.getId("DevExamId");
					}

				k=st.executeUpdate("insert into lbcms_dev_assessment_master(course_id,course_name,unit_id,lesson_id,lesson_name,assmt_id,assmt_name,category_id,assmt_instructions) values ('"+courseId+"','"+courseName+"','"+unitId+"','"+lessonId+"','"+lessonName+"','"+ExamId+"','"+assmtName+"','"+cat+"','"+instruct+"')");

				assmto++;
			assmtId=ExamId;	
			
			}
			
%>

<%
	if(k>0||mode.equals("q"))
	{
	
	if(request.getParameter("assmtId")!=null)
		assmtId=request.getParameter("assmtId");
	else
		assmtId=ExamId;
	
	if(mode.equals("q"))
		{
				courseName=request.getParameter("coursename");
				
				lessonName=request.getParameter("lessonname");
				
				
				assmtName=request.getParameter("asname");
				
				cat=request.getParameter("cattype");
		}
	
%>
<html>
<head>
<script language="JavaScript" type="text/javascript" src="wysiwyg/3wysiwyg.js"></script> 
</head>

<form name="qt_new" id='qt_new_id' action='fetchQuestion.jsp' target='qed_win' method="get">
<body>
<input type="hidden" id="from_id">
<input name="qid" id="q_id" type="hidden" value="new">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%" bgcolor="#F1F8FA" colspan="2">
      <img border="0" src="images/hscoursebuilder.gif" width="194" height="70"></td>
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr color="#C0C0C0" size="1"></td>
    </tr>
    
	<tr>
      <td width="50%"><font face="Verdana" size="2" color="#000080"><b>Course :
      </b></font><font face="Verdana" size="2" color="#800000"><%=courseName%></font></td>
      <td width="50%">
      <p align="right"><font face="Verdana" size="2" color="#000080"><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" color="#800000"><%=lessonName%></font></td>
    </tr>
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="1" cellspacing="1" width="80%" id="AutoNumber1" bordercolor="#111111" height="1">
    <tr>
      <td width="73%" bgcolor="#FFFFFF" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="28%" bgcolor="#7C7C7C" height="1"><b>
      <font face="Verdana" size="2" color="#FFFFFF"></font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
      <td width="45%" bgcolor="#7C7C7C" height="1">
      <p align="right"><b><font face="Verdana" size="1" color="#FFFFFF">
      <!-- <a href="javascript:window.close();"><font color="#FFFFFF">CLOSE</font></a>&nbsp; </font> --></b></td>
    </tr>
    <tr>
      <td width="12%" height="10" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
	 
      <td width="61%" height="10" bgcolor="#EBEBEB">
    
       <%=assmtName%>
		</td>
    </tr>
    <tr>
      <td width="12%" height="1" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="1" bgcolor="#EBEBEB"><%=cat%>
	  </td>
    </tr>
    
    <tr>
      <td width="73%" colspan="2" height="8" bgcolor="#C0C0C0" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Create the assessment 
      in the below area&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>&mode=q">Add a Question</a></font>
	  <font face="Verdana" size="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onclick="call();">List</a>&nbsp;&nbsp;&nbsp;<a href="EditAssessment.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtid=<%=assmtId%>&mode=q&userid=<%=developerId%>" target="_parent">Edit</a></font>
	  </font>


	   <tr>
	  </td>
   
	<%
	if(mode.equals("q")&&qt.equals("no")){
	%>
	<tr>
<td width="73%" colspan="2" height="8" align="center">
<p>Select Question 
      type<p align="left"><center>
<select size="1" name="D1" id="questioncategory">
<option selected>Select Qtype</option>
<option value="0">Multiple choice</option>
<option value="1">Multiple answers</option>
<option value="2">Yes/No</option>
<option value="3">Fill in the blanks</option>
<option value="4">Matching</option>
<option value="5">Ordering</option>
<option value="6">Short/Essay-type</option>
</select></p></center>
      <p align="left"></td>
    </tr>
	<tr>
  <td width="73%" colspan="2" height="31" align="center">
  <p align="center"><input type="button" value="ok" name="B1"  onclick="return goSubmit();">
  <!-- <input type="button" value="cancel" name="B2"> --></p>
  </td>
  </tr>
   </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
	 }
%>
   </table>
  </center>
</div><center>

</tr>

</table>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CDAssesmentWorkDone.jsp is....."+e);
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
				System.out.println("The exception2 in CDAssesmentWorkDone.jsp is....."+se.getMessage());
			}
		}
%>
</form>
</BODY>
<script>
	 function addQuestion(){
		 
		window.document.location.href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>";
   
 
	  }
	  function goSubmit()
	  {
		  
				var questioncategory=document.getElementById("questioncategory").value;
				
				   if(questioncategory=="")
					{
						alert('Please select a Question Type')
							return false;
					}
					else 
					{
					//window.document.location.href="fetchQuestion.jsp?courseid=<%=courseId%>&cattype=<%=cat%>&topicid=none&subtopicid=none&qtype="+questioncategory;
						var win=window.open("fetchQuestion.jsp?qid=new&classid=C000&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&assmtId=<%=assmtId%>&cattype=<%=cat%>&topicid=none&subtopicid=none&qtype="+questioncategory,"Document","width=875,height=525,scrollbars=yes");

						winFlag=true;
						//top.topframe.questionEditorWindow=win;
						//win.focus();
						}
	  }
	  
function valButton(btn) {
    var cnt = -1;
    for (var i=btn.length-1; i > -1; i--) {
        if (btn[i].checked) {cnt = i; i = -1;}
    }
    if (cnt > -1) return btn[cnt].value;
    else return null;
}
                  
	  function genQId(){
	
		var ans1=document.qt_new.ans1.value;
	
		var sel=document.getElementById("m1").selectedIndex;
		var sel1=document.getElementById("m2").selectedIndex;
		var sel2=document.getElementById("m3").selectedIndex;
		var sel3=document.getElementById("m4").selectedIndex;
		
		if(sel==sel1||sel1==sel2||sel2==sel||sel3==sel1||sel3==sel2||sel3==sel)
		  {
		alert("Check the answer(s).");
		return false;
		  }

		
		var quest=document.getElementById("question").value;
		//var matchl=document.getElementById("matchL").value;
		//alert(matchL)
		if(quest=="")
		  {
			alert('Plz exit html editor mode')
			return false;
		  }
		  var btn = valButton(qt_new.R1);
if (btn == null||ans1=="") {
	alert('plz select one Question');
	return false;
}

	//	else
		  //window.document.location.href="AssmtId_genrate.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=save&qtype=<%=Question%>";
		  
	  }

	  function call()
	{
		var win;
		parent.mainmail.location.href="QuestionsList.jsp?enableMode=null&start=0&totrecords=&start=&topicid=none&subid=none&samePage=0&visited=1&difflevel=-1&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assmtname=<%=assmtName%>&classid=C000&assmtId=<%=assmtId%>&examtype=<%=cat%>&userid=<%=developerId%>";
		

	}
	  </script>

</html>