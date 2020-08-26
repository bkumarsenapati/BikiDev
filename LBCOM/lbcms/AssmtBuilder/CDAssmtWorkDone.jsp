<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,utility.*,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement st=null,st1=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",instruct="",s="",schoolId="",developerId="";
	String assmtName="",assmtContent="",cat="",mode="",destUrl="",tableName="",qt="",ExamId="",assmtId="",classId="";
	 String Question="",Qtype="",categoryName="";
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
				
				cat=request.getParameter("cattype");
				
				instruct=request.getParameter("instruct");
				
				con=con1.getConnection();
				st=con.createStatement();
				if(cat.equals("EX"))
					categoryName="Exam";
				if(cat.equals("AS"))
					categoryName="Assessment";
				if(cat.equals("QZ"))
					categoryName="Quiz";
				if(cat.equals("SV"))
					categoryName="Survey";
				int k=0;
				
		
		
			if(mode.equals("add"))
			{
				
				courseName=request.getParameter("coursename");	
				
				lessonName=request.getParameter("lessonname");	
				
				assmtName=request.getParameter("asname");
				
				assmtName=assmtName.replaceAll("@","&");
				assmtName=assmtName.replaceAll("\'","&#39;");
				instruct=instruct.replaceAll("@","&");
				instruct=instruct.replaceAll("\'","&#39;");
				             			
				String schoolPath = application.getInitParameter("schools_path");
				
				//if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
				
				Utility utility= new Utility(schoolId,schoolPath);
				ExamId=utility.getId("DevExam_Id");
				if (ExamId.equals(""))
					{
						utility.setNewId("DevExam_Id","d0000");
						ExamId=utility.getId("DevExam_Id");
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
			cat=request.getParameter("cattype");
			//assmto=Integer.parseInt(request.getParameter("assmt"));
			st1=con.createStatement();	
							
			rs1=st1.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+courseId+"'and assmt_id='"+assmtId+"'");
			if(rs1.next())
			{
				assmtName=rs1.getString("assmt_name");
				unitId=rs1.getString("unit_id");
				lessonId=rs1.getString("lesson_id");
				lessonName=rs1.getString("lesson_name");
				assmtName=rs1.getString("assmt_name");
				instruct=rs1.getString("assmt_instructions");
				courseName=rs1.getString("course_name");
				cat=rs1.getString("category_id");
				
				if(cat.equals("EX"))
					categoryName="Exam";
				if(cat.equals("AS"))
					categoryName="Assessment";
				if(cat.equals("QZ"))
					categoryName="Quiz";
				if(cat.equals("SV"))
					categoryName="Survey";
				
			}
						
				
		}
	
%>
<html>
<head>
<script language="JavaScript" type="text/javascript" src="wysiwyg/3wysiwyg.js"></script>
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" /> 
</head>

<form name="qt_new" id='qt_new_id' action='fetchQuestion.jsp' target='qed_win' method="get">
<body>
<input type="hidden" id="from_id">
<input name="qid" id="q_id" type="hidden" value="new">

<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%" colspan="2">
      <img border="0" src="images/hscoursebuilder.gif" width="284" height="90"></td>
	 <!--   <td width="100%" bgcolor="#F1F8FA" colspan="2"><a href="parent.mainmail.self.close();">Close</a></td> -->
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr size="1"></td>
    </tr>
    
	<tr>
      <td width="50%" class="gridhdrNew"><font face="Verdana" size="2" ><b>Course :
      </b></font><font face="Verdana" size="2" ><%=courseName%></font></td>
      <td width="50%" class="gridhdrNew">
      <p align="right"><font face="Verdana" size="2"><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" ><%=lessonName%></font></td>
    </tr>
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table  cellspacing="1" width="80%" id="AutoNumber1"  height="1">
    <!-- <tr>
      <td width="73%" bgcolor="#FFFFFF" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr> -->
  
    <tr>
      <td width="26%" height="10" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
	 
      <td width="33%" height="10" class="gridhdrNew1">
    
       <%=assmtName%>
		</td>
          <td width="8%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="33%" height="1"class="gridhdrNew1"><%=categoryName%>
	  </td>
    </tr>
   
    </table>
     <table cellspacing="1" width="80%" id="AutoNumber1"  height="1">
    <tr>
      <td width="73%" colspan="2" height="8" class="gridhdrNew1" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Create the assessment 
      in the below area&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>&mode=q">Add a Question</a></font>
	  <font face="Verdana" size="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="call();">List</a>&nbsp;&nbsp;&nbsp;<a href="EditAssessment.jsp?courseid=<%=courseId%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&cattype=<%=cat%>&qt=no&assmtid=<%=assmtId%>&mode=q&userid=<%=developerId%>" target="_parent">Edit</a></font>
	  </font>


	   <tr>
	  </td>
   
	<%
	if(mode.equals("q")&&qt.equals("no")){
	%>
	<tr>
<td width="53%" colspan="2" height="8" class="gridhdrNew1" align="center">
Select Question type<center><br>
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
      </td>
    </tr>
	<tr>
		<td width="73%" colspan="2" height="41" align="center" class="gridhdrNew1">
  <p align="center"><input type="button" value="ok" name="B1"  onclick="return goSubmit();">
  <!-- <input type="button" value="cancel" name="B2"> --></p>
  </td>
  </tr>
   </table>
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
				if(st1!=null)
					st1.close();
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
		 
		window.document.location.href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>";
   
 
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

						var tc=confirm("Do you want create from existing questions?");
						if (tc==true)
						{
							
							var win=window.open("CBSelectQuestion.jsp?qid=new&classid=C000&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&assmtId=<%=assmtId%>&cattype=<%=cat%>&topicid=none&subtopicid=none&totrecords=&start=0&qtype="+questioncategory,"Document","width=875,height=525,scrollbar=yes");

							winFlag=true;
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
		parent.mainmail.location.href="QuestionsList.jsp?enableMode=null&start=0&totrecords=&start=&topicid=none&subid=none&samePage=0&visited=1&difflevel=-1&courseid=<%=courseId%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&classid=C000&assmtId=<%=assmtId%>&examtype=<%=cat%>&userid=<%=developerId%>";
		

	}
	  </script>

</html>