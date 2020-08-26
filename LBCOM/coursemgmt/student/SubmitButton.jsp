<!DO12/12/2004CTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
	/**
	 *Displays a form where the user can browse for a file to submit & give any comments to the teacher */ 
-->
<HTML>
<%@ page import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%

    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String date=null,time=null;
    String workId=null,workFile=null,categoryId=null,courseName=null,status=null,comments=null,schoolId=null,classId=null,courseId=null,studentId=null,topicId=null,subTopicId=null,edFileName=null;
	StringTokenizer wFile=null,mSecured=null;
	int submitCount=0;
		
%>
<%
	int wfile=0,msecured=0;
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
		
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	try{
		
	schoolId = (String)session.getAttribute("schoolid");
	studentId = (String)session.getAttribute("emailid");
	classId = (String)session.getAttribute("classid");
	courseId = (String)session.getAttribute("courseid");
	con=con1.getConnection();
	st=con.createStatement();

    workId=request.getParameter("workid");
    workFile=request.getParameter("workfile");
    categoryId=request.getParameter("cat");
    courseName=request.getParameter("coursename");
//	submitCount=request.getParameter("submitcount");
	submitCount=Integer.parseInt(request.getParameter("submitcount"));			

	
	
	rs=st.executeQuery("select topic,subtopic,instructions,curtime() time,curdate() date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
	if (rs.next()){
		comments=rs.getString("instructions");
		topicId=rs.getString("topic");
		subTopicId=rs.getString("subtopic");
		time=rs.getString("time");
		date=rs.getString("date");
		date=date.substring(2,date.length());
	}
	StringBuffer s=new StringBuffer(date+time);
	
	int i;
	while(((i=s.indexOf("-"))!=-1)||((i=s.indexOf(":"))!=-1))
		s.replace(i,i+1,"");
	
	if (submitCount==0)
		edFileName="1_"+workId+s.toString();
	else
		edFileName=(submitCount+1)+"_"+workId+s.toString();
	

	/*rs=st.executeQuery("select marks_secured,work_file from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and submit_count>0");
	if(rs.next()){
		wFile = new StringTokenizer(rs.getString("work_file"),"#");
		mSecured = new StringTokenizer(rs.getString("marks_secured"),"#");
	}*/
}catch(Exception e){
		System.out.println("error is "+e);
	ExceptionsFile.postException("SubmitButton.jsp","Operations on database","Exception",e.getMessage());

}finally{

	try{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("SubmitButton.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
%>

<head><title>Samp Doc</title>
</head>
<SCRIPT LANGUAGE="JavaScript" src="../teacher/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
 
 var flag;
  
   function validate() {
		var win=document.sub;

		if(trim(win.stuworkfile.value)=="" && trim(win.pdfile.value)=="" && trim(win.editorfile.value)=="") {
			alert("Select a document to submit.");
			win.stuworkfile.focus();
			return false;
		}

		if(trim(win.stuworkfile.value)!="" && trim(win.pdfile.value)!="" && trim(win.editorfile.value)!="") {
			alert("More than one document selected.");
			win.stuworkfile.focus();
			return false;
		}
		replacequotes();
    }
	function checkBrowse(){
		if (trim(document.sub.pdfile.value)!="" || trim(document.sub.editorfile.value)!=""){
			alert("A document is already selected.	");
			return false;
		}
	}
	function openwin() {

		if (trim(document.sub.stuworkfile.value)!="" || trim(document.sub.editorfile.value)!=""){
			alert("A document is already selected.	");
			return false;
		}
	 var win=window.open("/LBCOM/coursemgmt/teacher/personaldocs/dbpersonaldocs.jsp?tag=S&foldername=","Personaldocuments",'dependent=yes,width=500,height=220, scrollbars=yes,left=175,top=200');
	 window.top.frames['studenttopframe'].stuAsgnPerDocWin = win;
// 	 win.focus();
	}
function showHint(remark){
	var newWin=window.open('','TeacherHints',"resizable=no,toolbars=no,scrollbar=yes,width=250,height=225,top=275,left=300");
	newWin.document.writeln("<html><head><title>Teacher's Instructions</title></head><body><font face='Arial' size=2 color='blue'><u>Teacher's Instructions</u></font><br><font face='Arial' size=2>"+remark+"</font></body></html>");
	window.top.frames['studenttopframe'].stuAsgnTeacherInstWin = newWin;
}

function openEditor(session,classid,courseid,topic,subtopic)
{
	
	var d=window.document.sub;

	if (trim(d.stuworkfile.value)!="" || trim(d.pdfile.value)!="")
	{
		alert("Already selected.");
		return false;
	}
	if(flag==true)
	{
		var win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid=<%=edFileName%>&classid="+classid+"&courseid="+courseid+"&topicid="+topic+"&subtopicid="+subtopic+"&qtype=51&pathname=<%=categoryId%>/<%=edFileName%>","qed_win","width=875,height=525,scrollbars=yes");
		window.top.frames['studenttopframe'].stuAsgnHtmlEditorWin = win;
		window.document.sub.editorfile.value='<%=edFileName%>.html';
	}
	else
	{
		var win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid=new&classid="+classid+"&courseid="+courseid+"&topicid="+topic+"&subtopicid="+subtopic+"&qtype=51&pathname=<%=categoryId%>/<%=edFileName%>","qed_win","width=875,height=525,scrollbars=yes");
		window.top.frames['studenttopframe'].stuAsgnHtmlEditorWin = win;
		window.document.sub.editorfile.value='<%=edFileName%>.html';
	}
		win.focus();

}
 function cleardata(){
		//win.stuworkfile.value="";
		//win.pdfile.value="";
		//win.editorfile.value="";
		document.sub.reset();
		return false;
		
}
</SCRIPT>

<BODY topmargin="3" leftmargin="3">
<!--<form name="sub" method="post" action="Submit.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>">-->
<form name="sub"  enctype="multipart/form-data" method="post" action="Submit.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&submitcount=<%=submitCount%>" onsubmit="return validate();">
    <div align="center">
      <center>
      <table border="1" width="100%" cellspacing="0" bgcolor="#FBF4EC" bordercolordark="#FFFFFF" height="51" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" bordercolorlight="#FFFFFF">
        <tr>
          <td width="334" height="14" colspan="3" align="left"><font face="Arial" size="2">&nbsp;<a href="javascript://" onclick="return showHint('<%=comments%>');">Teacher's Instructions</font></td>
		  <td colspan="2" align="left" width="578"><font face="Arial" size="2">&nbsp;</font></td>
         <!-- <td width="6" height="14"><font face="Arial" size="2">:</font></td>
          <td width="709" colspan="3" height="14"><font face="Arial" size="2"><%=comments%>
            </font></td>-->
        </tr>
        <tr>
          <td width="83" height="1"><font face="Arial" size="2">Select File To
            Submit</font></td>
          <td width="4" height="1"><font face="Arial" size="2">:</font></td>
          <td width="245" height="1"><font face="Arial" size="2">
          <input type="file" name="stuworkfile" size="20" onclick="return checkBrowse();">
            </font></td>
          <td width="304" height="1">
            <p align="right"><font face="Arial" size="2">&nbsp;
            <input type="text" name="pdfile" readonly size="15"><input type="button" value="Personal Docs." onclick="return openwin();" name="pd">
            </font></td>
          <td width="273" height="1"><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" name="editorfile" readonly size="15"><input type="button" value="HTML Editor" onclick="return openEditor('<%=sessid%>','<%=classId%>','<%=courseId%>','<%=topicId%>','<%=subTopicId%>');"></font></td>
        </tr>
        <tr>
          <td width="83" height="23"><font face="Arial" size="2">Comments&nbsp;
            </font></td>
          <td width="4" height="23"><font face="Arial" size="2">:</font></td>
          <td width="824" colspan="3" height="23"><font face="Arial" size="2">
          <!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="200" --><input type="text" name="stucomments" size="116" >
            </font></td>
        </tr>
        <tr>
          <td width="913" height="23"  colspan="5"bgcolor="#B0A890">
            <p align="center">
			<input type="image" src="../images/std_submit.gif" >
			<input type="image"  onClick="return cleardata()" src="../images/stu_reset.gif" >
          </td>
        </tr>
      </table>
      </center>
    </div>
</form>
</BODY>
</HTML>
