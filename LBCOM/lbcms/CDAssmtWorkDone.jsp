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
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",instruct="",s="",schoolId="";
	String assmtName="",assmtContent="",cat="",mode="",destUrl="",tableName="",qt="",ExamId="",assmtId="";
	 String Question="",Qtype="";
	int points=0,assmto=0;
	try
	{	 
		session=request.getSession();
		s=(String)session.getAttribute("sessid");
		schoolId=(String)session.getAttribute("schoolid");
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

		con=con1.getConnection();
		st=con.createStatement();
		
		int k=0;
		
		
			if(mode.equals("add"))
			{
				
				courseName=request.getParameter("coursename");
				
				lessonName=request.getParameter("lessonname");
				
				
				assmtName=request.getParameter("asname");
				
				cat=request.getParameter("cattype");
				
				instruct=request.getParameter("instruct");
             
				
				String schoolPath = application.getInitParameter("schools_path");
				Utility utility= new Utility(schoolId,schoolPath);
				ExamId=utility.getId("ExamId");
				if (ExamId.equals(""))
					{
					utility.setNewId("ExamId","e0000");
					ExamId=utility.getId("ExamId");
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
<script language="javascript">

</script>

</head>

<form name="form1" method="post" action="QuestionId_genrate.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&assmtId=<%=assmtId%>&qt=save&qtype=<%=Qtype%>" onsubmit="return genQId();">
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
      <a href="javascript:self.close();"><font color="#FFFFFF">CLOSE</font></a>&nbsp; </font></b></td>
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
      in the below area&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>&mode=q">Add a Question</a></font>
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
  <input type="button" value="cancel" name="B2"></p>
  </td>
  </tr>

<%
	  
	 	  }
		  if(mode.equals("q")&&qt.equals("yes")){
			  Qtype=request.getParameter("qtype");
			  int ch=0;
			  char data[] = {'E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};

			   if(Qtype.equals("0"))
                 Question="Multiple choice";
			    if(Qtype.equals("1"))
                 Question="Multiple answers";
                  if(Qtype.equals("2"))
                 Question="Yes/No";
				  if(Qtype.equals("3"))
                 Question="Fill in the blanks";
				  if(Qtype.equals("4"))
                 Question="Matching";
				  if(Qtype.equals("5"))
                 Question="Ordering";
				  if(Qtype.equals("6"))
                 Question="Short/Essay-type";
			   int i=0;
                
		 %>
		 
		  <tr>
      <tr>
<td width="73%" colspan="2" height="8" align="center"><p align="center">
  Create Question       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QuestionType:<%=Question%></font></p></td>
  <tr>
  <td width="73%" colspan="2" height="8" align="center">
  <p align="left">&nbsp;&nbsp;&nbsp;Enter Your Question Here  
  <center><textarea rows="3" name="question" cols="50" id="question"></textarea><script language="JavaScript">
			generate_wysiwyg('question');
		 </script></center></p></td></tr>
	 
  <%
			 if(Qtype.equals("0")){
			 %>
			 <tr>
	<td width="73%" colspan="2" height="8" align="center">
  <p align="center">&nbsp;</p>
  
  <!-- <p align="center"><input type="radio" value="ans1" name="R1"> <textarea rows="2" name="ans1" cols="40"></textarea></p>
  
  <p align="center">&nbsp;<input type="radio" value="ans2" name="R1">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p>
  <p align="center">&nbsp;<input type="radio" value="ans3" name="R1">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p>
  <p align="center">&nbsp;<input type="radio" value="ans4" name="R1">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p> -->
  <div name="l1" id="optLayer" style="border:2px solid blue; background-color:'white';width=100; ">
	<input type="radio" name="ip" value="ans1">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea>
</div>

 <%
String ass="ass",val="ans";

if(request.getParameter("i")==null)
i=5;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=5;j<i;j++){
 %> 
  
<p align="center">&nbsp;
  <input type="radio" value="<%=val%>" name="R1">&nbsp;
  <textarea rows="2" name="ans1" value="dg" cols="40"></textarea></p>
  
 <%
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p>
	  </td>
	  </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("2")){
			 %>
			 <tr>
	<td width="73%" colspan="2" height="8" align="center">
  <p align="center">&nbsp;</p>
  
  <p align="center"><input type="radio" value="ans1" name="R1"> <textarea rows="2" name="ans1" cols="40"></textarea></p>
  
  <p align="center">&nbsp;<input type="radio" value="ans2" name="R1">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p>
 
 <%
String ass="ass",val="ans";

if(request.getParameter("i")==null)
i=3;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=3;j<i;j++){
 %> 
  
<p align="center">&nbsp;
  <input type="checkbox" value="<%=val%>" name="R1">&nbsp;
  <textarea rows="2" name="ans1" value="dg" cols="40"></textarea></p>
  
 <%
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p></td>
    </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("1")){
			 %>
			 <tr>
	<td width="73%" colspan="2" height="8" align="center">
  <p align="center">&nbsp;</p>
  
  <p align="center">&nbsp;<input type="checkbox" name="C1" value="ans1"> <textarea rows="2" name="ans1" cols="40"></textarea></p>
  
  <p align="center">&nbsp;<input type="checkbox" name="C1" value="ans2"> <textarea rows="2" name="ans1" cols="40"></textarea></p>
  <p align="center">&nbsp;<input type="checkbox" name="C1" value="ans3">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p>
  <p align="center">&nbsp;<input type="checkbox" name="C1" value="ans4">&nbsp; <textarea rows="2" name="ans1" cols="40"></textarea></p>

 <%
String ass="ass",val="ans";

if(request.getParameter("i")==null)
i=5;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=5;j<i;j++){
 %> 
  
<p align="center">&nbsp;
  <input type="checkbox" value="<%=val%>" name="C1">&nbsp;
  <textarea rows="2" name="ans1" cols="40"></textarea></p>
  
 <%
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p></td>
    </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("3")){
			 %>

	<tr>
	<td width="73%" colspan="2" height="8" align="center">
    <p align="center">&nbsp<BR>
   &nbsp;<input type="text" name="f1" size="10"/>&nbsp;&nbsp;<textarea rows="2" name="ans1" cols="20" ></textarea></p>

  <%
String ass="ass",val="V";

if(request.getParameter("i")==null)
i=2;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=2;j<i;j++){
		
 %> 
  <p align="center">&nbsp
<input type="text" name="f1" size="10"/>&nbsp;
  &nbsp;<textarea rows="2" name="ans1"  cols="20" ></textarea></p>
  
 <%
		
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p></td>
    </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("4")){
	
			 %>
			 <tr>
	<td width="73%" colspan="2" height="3" align="center">
  <p align="center">&nbsp;</p>
  
  1.<textarea rows="2" name="matchL" cols="20"></textarea>
 
&nbsp;A.<textarea rows="2" name="matchR" cols="20"></textarea>&nbsp;&nbsp;<select size="1" name="m1">
  <option selected>A</option>
  <option>B</option>
  <option>C</option>
  <option>D</option>
  <%
	
	if(request.getParameter("char")!=null)
	{
	i=Integer.parseInt(request.getParameter("i"));
	int maching=0;
	for(int cha=9;cha<i;cha++)
		{
	%>
 <option><%=data[maching]%></option>
  
  <%
	  maching++;
		}
	}
  %>
  </select></td></tr>
<tr>
	<td width="73%" colspan="2" height="3" align="center">
  <p align="center">&nbsp;</p>
  
  &nbsp;2.<textarea rows="2" name="matchL" cols="20"></textarea>
 
&nbsp;B.<textarea rows="2" name="matchR" cols="20"></textarea>&nbsp;&nbsp;<select size="1" name="m1">
  <option selected>A</option>
  <option>B</option>
  <option>C</option>
  <option>D</option>
  <%
	
	if(request.getParameter("char")!=null)
	{
	i=Integer.parseInt(request.getParameter("i"));
	int maching4=0;
	for(int cha=9;cha<i;cha++)
		{
	%>
 <option><%=data[maching4]%></option>
  
  <%
	  maching4++;
		}
	}
  %>
  </select></td></tr>
<tr>
	<td width="73%" colspan="2" height="3" align="center">
  <p align="center">&nbsp;</p>
  
 &nbsp;3.<textarea rows="2" name="matchL" cols="20"></textarea>
 
&nbsp;C.<textarea rows="2" name="matchR" cols="20"></textarea>&nbsp;&nbsp;<select size="1" name="m1">
  <option selected>A</option>
  <option>B</option>
  <option>C</option>
  <option>D</option>
  <%
	
	if(request.getParameter("char")!=null)
	{
	i=Integer.parseInt(request.getParameter("i"));
	int maching1=0;
	for(int cha=9;cha<i;cha++)
		{
	%>
 <option><%=data[maching1]%></option>
  
  <%
	  maching1++;
		}
	}
  %>
 </select></td></tr>
<tr>
<tr>
	<td width="73%" colspan="2" height="3" align="center">
  <p align="center">&nbsp;</p>
  
  &nbsp;4.<textarea rows="2" name="matchL" cols="20"></textarea>
 
&nbsp;D.<textarea rows="2" name="matchR" cols="20"></textarea>&nbsp;&nbsp;<select size="1" name="m1">
  <option selected>A</option>
  <option>B</option>
  <option>C</option>
  <option>D</option>
  <%
	
	if(request.getParameter("char")!=null)
	{
	i=Integer.parseInt(request.getParameter("i"));
	int maching2=0;
	for(int cha=9;cha<i;cha++)
		{
	%>
 <option><%=data[maching2]%></option>
  
  <%
	  maching2++;
		}
	}
  %>
  </select></td></tr>
<tr>

 <%
String ass="ass",val="V";
int no=5;

if(request.getParameter("i")==null)
	{
	i=9;
	}
else
i=Integer.parseInt(request.getParameter("i"));

if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	
	for(int j=9;j<i;j++){
 %> 
<tr>
	<td width="73%" colspan="2" height="3" align="center">
  <p align="center">&nbsp;</p>
  
  &nbsp;<%=no%>.<textarea rows="2" name="matchL" cols="20"></textarea>
 
&nbsp;<%=data[ch]%>.<textarea rows="2" name="matchR" cols="20"></textarea>&nbsp;&nbsp;<select size="1" name="m1">
  <option selected>A</option>
  <option>B</option>
  <option>C</option>
  <option>D</option>
  <%
	
	if(request.getParameter("char")!=null)
	{
	i=Integer.parseInt(request.getParameter("i"));
	int maching3=0;
	for(int cha=9;cha<i;cha++)
		{
	%>
 <option><%=data[maching3]%></option>
  
  <%
	  maching3++;
		}
	}
  %>
  </select></td></tr>
<tr>
 <%
	no++;
ch++;
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p></td>
    </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("5")){
			 %>
			 <tr>
	<td width="73%" colspan="2" height="8" align="center">
  <p align="center">&nbsp;</p>
  
  <p align="center">&nbsp;&nbsp; <textarea rows="2" name="ans1" cols="25"></textarea></p>
  
  <p align="center">&nbsp;&nbsp; <textarea rows="2" name="ans1" cols="25"></textarea></p>
  <p align="center">&nbsp;&nbsp; <textarea rows="2" name="ans1" cols="25"></textarea></p>
  <p align="center">&nbsp;&nbsp; <textarea rows="2" name="ans1" cols="25"></textarea></p>

 <%
String ass="ass",val="V";

if(request.getParameter("i")==null)
i=5;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=5;j<i;j++){
 %> 
  
<p align="center">&nbsp;
  &nbsp;
  <textarea rows="2" name="ans1" cols="25"></textarea></p>
  
 <%
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p>
	  </td>
	  </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
			 if(Qtype.equals("6")){
			 %>
			 <tr>
	<td width="73%" colspan="2" height="8" align="center">
  <p align="center">&nbsp;</p>
  
  <p align="center">&nbsp;&nbsp; <textarea rows="5" name="ans1" cols="35"></textarea></p>
  
  <%
String ass="ass",val="V";

if(request.getParameter("i")==null)
i=2;
else
i=Integer.parseInt(request.getParameter("i"));
if(request.getParameter("optionMode")!=null){
	ass=ass+""+i+"";
	val=val+""+i+"";
	for(int j=2;j<i;j++){
 %> 
  
<p align="center">&nbsp;
  &nbsp;
  <textarea rows="2" name="ans1" cols="25"></textarea></p>
  
 <%
	  }
}
	  %>&nbsp; 
      <p>&nbsp;</p>
	  </td>
	  </tr>
  </table>
<p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		 }
%>
<%
	 if(!(Qtype.equals("2")||Qtype.equals("6"))){
	
	%>
	<input type=image src="../images/baddmore.gif"  name="addmore" onclick="addchildele(); return false;">
	
	 <!--  <a href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=yes&optionMode=add&i=<%=(i+1)%>&qtype=<%=Qtype%>&char=<%=data[ch]%>">Add option</a> --></p>
  <p align="center">&nbsp;</p>
  <p align="center"><input type="submit" value="Save" name="B1"></p>
<%
	
	  }

  else
	  {
%>
<p align="center">&nbsp;</p>
  <p align="center"><input type="submit" value="Save" name="B1"></p>
<%
        }
		  }
%>
   </table>
  </center>
</div><br><center>
      <p></p>

<%
	}

		
%>
</tr>

</table>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CDAssesment.jsp is....."+e);
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
				System.out.println("The exception2 in CDAssesment.jsp is....."+se.getMessage());
			}
		}
%>
</form>
</BODY>
<script>
	 function addQuestion(){
		 
		 alert('<%=ExamId%>')
			 window.document.location.href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>";
   
 
	  }
	  function goSubmit(){
		  
				var questioncategory=document.getElementById("questioncategory").value;
			    if(questioncategory=="")
					{
					alert('plz select Question Type')
						return false
					}
					else 
						{
					window.document.location.href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&assmtId=<%=assmtId%>&cattype=<%=cat%>&qt=yes&qtype="+questioncategory;
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
	
		var ans1=document.form1.ans1.value;
		var quest=document.getElementById("question").value;
		if(quest=="")
		  {
			alert('Plz exit html editor mode')
			return false;

		  }
		  var btn = valButton(form1.R1);
			if (btn == null||ans1=="")
			{
				alert('plz select one Question');
				return false;
			}

	//	else
		  //window.document.location.href="AssmtId_genrate.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=save&qtype=<%=Question%>";
		  
	  }
	function addchildele()
	{
	alert("santhosh1");
	var count=2;
	
	var parentLayer = document.getElementById("optLayer");
	var childele1 = document.createElement("input");
	childele1.setAttribute("type","radio");
	childele1.setAttribute("name","ip1");
	childele1.setAttribute("value","ans"+count);
	alert(document.getElementById("value"));
	count++;

	var childele = document.createElement("input");
	childele.setAttribute("type","textarea");
	childele.setAttribute("name","ip");
	//childele.setAttribute("id","file"+count);	
	//childele.style.border = "1px solid red";
	childele.setAttribute("value","");
	
	
	parentLayer.appendChild(childele1);
	parentLayer.appendChild(childele);
	var br = document.createElement("br");
	parentLayer.appendChild(br);
	alert("santhosh2");
	}
	  </script>
</html>




