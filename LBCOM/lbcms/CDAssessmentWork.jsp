<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",asmtContent="",developerId="",	classId="";
	String tableName="",mode="";
	int asmtNo=0;
	boolean no=false;
        session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		classId=(String)session.getAttribute("classid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		mode=request.getParameter("mode");
		if(mode==null||mode.equals(""))
		mode="notadd";
		else
		mode="add";
		//System.out.print(mode);
		con=con1.getConnection();
		st=con.createStatement();

		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="dev_asmt_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="dev_asmt_science_content_master";
		
		}
		else
		{
			tableName="dev_asmt_math_content_master";
		
		}

		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs.next())
		{
			asmtNo=Integer.parseInt(rs.getString("asmt_no"));
			asmtNo=asmtNo+1;
			
			no=true;
		}
		if(no==false)
		{
			 asmtNo=1;
		
		}


	
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>CREATE ASSESSMENT</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/asmtwysiwyg.js"></script> 
<script type="text/javascript" src="q_common.js"></script>
<script type="text/javascript" src="q_yes_no.js"></script>
<script language="javascript">

function show_key(the_form)
{
	var the_key="0123456789";
	var the_value=the_form.value;
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++)
	{
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) 
		{
			alert("Please enter numbers only");
			the_form.focus();
			return false;
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

function validate()
{
	var win=window.document.create;
	var btn = valButton(create.qtype);
	if(win.asmtname.value == "")
	{
		alert("Please enter the document name");
		window.document.create.asmtname.focus();
		return false;
	}
	var cat=window.document.create.asmtcategory.value

	if(cat=="all")
	{
		alert("Please select category");
		window.document.create.asmtcategory.focus();
		return false;
	}
	if(win.points.value == "")
	{
		alert("Please enter maximum points");
		window.document.create.points.focus();
		return false;
	}

     if (btn == null) 
	{
	alert('No radio button selected');
	return false;
	}
	if(win.asmtname.value != ""&&btn != null&&win.points.value != ""&&cat!="all"&&win.points.value>1)
	{
		
         var win=window.document.create;
		 var asmtname=win.asmtname.value;
		 var asmtcategory=win.asmtcategory.value;
		 var points=win.points.value;
		 //document.location.href="SaveQueston.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points;
		 document.location.href="q_yes_no.jsp?qid=new&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points;
	 return true;
	}
	else 
	{
		if(win.points.value<1)
		{
			alert("Maximum points should be greater than zero");
			window.document.create.points.focus();
			return false;
		}
	}	
	
	//replacequotes();
}

function cleardata()
{
	document.create.reset();
	addOptions();
	return false;
}
</script>   

</head>
<body>
<form name="create" method="post" enctype="multipart/form-data">
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
  <table border="1" cellspacing="1" width="80%" id="AutoNumber1" bordercolor="#111111" height="146">
    <tr>
      <td width="73%" bgcolor="#FFFFFF" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="28%" bgcolor="#7C7C7C" height="1"><b>
      <font face="Verdana" size="2" color="#FFFFFF">&nbsp;CREATE ASSESSMENT</font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
      <td width="45%" bgcolor="#7C7C7C" height="1">
      <p align="right"><b><font face="Verdana" size="1" color="#FFFFFF">
      <a href="javascript:self.close();"><font color="#FFFFFF">CLOSE</font></a>&nbsp; </font></b></td>
    </tr>
    <tr>
      <td width="12%" height="10" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
	  <%
		String asmtname="",asmtcategory="",points="";
		String submit="";
        if(request.getParameter("submit")!=null)
		{
			submit=request.getParameter("submit");
		}
		if(request.getParameter("asmtname")!=null)
		{
          asmtname=request.getParameter("asmtname");
          asmtcategory=request.getParameter("asmtcategory");
          points=request.getParameter("points");
		}
        else{
        asmtname="";
		asmtcategory="Select Category";
		points="";
		submit="";
		}
		%>
      <td width="61%" height="10" bgcolor="#EBEBEB">
    
        <input type="text" name="asmtname" size="54">
		<script>
		document.create.asmtname.value='<%=asmtname%>';
        </script>
		</td>
    </tr>
    <tr>
      <td width="12%" height="1" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="1" bgcolor="#EBEBEB"><select id="asmtcategory" name="asmtcategory">
			<option value="all" selected>Select Category</option>
			<option value="AS">Assessment</option>
            <option value="EX">Exam</option>
            <option value="QZ">Quiz</option>
      </select>
	  <%
	  	if(request.getParameter("asmtcategory")!=null)
		{
			%>
	  <script>
	  document.create.asmtcategory.value='<%=asmtcategory%>';
       </script>
	   <%
		}
	   %>
	  </td>
    </tr>
    <tr>
      <td width="12%" height="1" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Maximum Points</font></td>
      <td width="61%" height="1" bgcolor="#EBEBEB">
    
        <input type="text" name="points" size="8">
		<script>
		document.create.points.value='<%=points%>';
        </script>
		</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="8" bgcolor="#C0C0C0" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Create the assessment 
      in the below area&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onclick="addQuestion();">Add a Question</a></font>
	   <tr>
	  </td>
   
	<%
	if(mode.equals("add")){
	%>
	<tr>
<td width="73%" colspan="2" height="8" align="center">
<p>Select Question 
      type<p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="0" name="qtype" id="mc">&nbsp;Multiple choice</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="1" name="qtype" id="ma">&nbsp;Multiple answers</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="2" name="qtype" id="yn">&nbsp;Yes/No</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="3" name="qtype" id="fb">&nbsp;Fill in the blanks</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="4" name="qtype" id="mt">&nbsp;Matching</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="5" name="qtype" id="od">&nbsp;Ordering</p>
      <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" value="6" name="qtype" id="et">&nbsp;Short/Essay-type</p>
      <p align="left"></td>
    </tr>
   <tr>
  <td width="73%" colspan="2" height="8" align="center">
  <p align="center"><input type="button" value="ok" name="B1"  onclick="goSubmit();">
  <input type="button" value="cancel" name="B2"></p>
  </td>
  </tr>

<%
	  
	 	  }
		  if(submit.equals("yes")){
			  String Qtype=request.getParameter("qtype");
			 // int qtype=Integer.parseInt(Qtype);
			 String qid=request.getParameter("qid");
			 System.out.println(qid);
			 String edittype="";
			  edittype="self.focus();"+
			"parent.window.opener.close();"+
			"qid='"+qid+"';"+
			"classid='"+classId+"';"+
			"courseid='"+courseId+"';"+
			"qtype='2';";
	if(qid.equals("new"))
		edittype=edittype+"help(\'default');init_temp(1, 3);"+
		"if (INIT_TEMP) {"+
		"initSpan3('l_q_area_id', 'text', 'q_3');"+
		"initSpan3('l_o_area_id', 'text', 'o_3');"+
		"initSpan3('l_d_area_id', 'select', 'h_3');"+
		"initSpan3('l_e_area_id', 'textbox', 'h_3');"+
		"initSpan3('l_s_area_id', 'select', 'h_3');"+
		"initSpan3('l_h_area_id', 'text', 'h_3');"+
		"initSpan3('l_c_area_id', 'text', 'h_3');"+
		"initSpan3('l_i_area_id', 'text', 'h_3');"+
		"}";
			%>
<html>
  <head>
    <title>Question Editor</title>
	<!-- dont dalete this as this will work in ie -->
	<!--[if IE]>
	<style type="text/css">
	*{
	font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
	}
	</style>
	<![endif]-->
	<link rel="stylesheet" href="q.css" type="text/css">
    <script type="text/javascript" src="q_common.js"></script>
    <script type="text/javascript" src="q_yes_no.js"></script>
	
  </head>
  <body topmargin="0" leftmargin="0" onContextMenu='return false;' onLoad="<%=edittype%>">
  <tr>
   <td width="73%" colspan="2" height="8" align="center">
  	<table id="t_ed" border="0">
<tr><td align="center">
<hr>
<span class="q_title">Yes/No (or True/False) Type</span>
<br><hr>
</td></tr>
	  <tr class="main_panel" vAlign="top">
	    <td id="main_panel_l" align="left" colspan="2">
        <form id="l_qo_form_id" name="l_qo_form" method="post" action=""
	   		enctype="multipart/form-data">
<input name="qid" id="q_id" type="hidden" value="new">
<div id="l_q_top_id" class="f_left">
  <img src="images/l.gif" width="423" height="23"></div>
		 <div id="l_mb_q_id" class="l_mb_q">
		   <div class="f_left">
           
<!--
           <input class="m_qf_buttons" type="image" src="images/file.gif" title="[file]" 
				onMouseOver="help('uploadFile');"
				onMouseOut="help('default');"
				onClick="addToSpan('l_q_area_id','file','q_3','');
				return false;"/>
-->
			

		   

			<input type="hidden" id="from_id">
		   <input type="hidden" id="SymWin_id">
		   </div>
		   
<!--
		   <div class="f_right">
		   <img src="images/enum.gif" title="enum: ">
           <input name="q_enum_chk" class="m_q_buttons" type="checkbox" 
		   		value="" onClick="toggle('l_q_arr')"/>
		   <select name="q_enum_type">
		   	<option value="bullet">bullet</option>
		   	<option value="arabic">1,2,...</option>
		   	<option value="RM_N">I,II,...</option>
		   	<option value="rm_n">i,ii,...</option>
		   	<option value="ROMAN">A,B,...</option>
		   	<option value="roman" selected>a,b,...</option>
		   </select>
		   </div>
-->
		 </div>
		 <div id="l_q_area_id" class="l_q_area">
		 </div>
		 <div id="l_mb_o_id" class="l_mb_o">
		   <div class="f_left">
		   <img src="images/choices.gif">
		   </div>
		   <div class="f_right">
		   <select name="o_choices" onChange="sel_handler3(this, 'o')">
				<option value=''>-- Y/N T/F... --</option>
				<option value='0'>Yes/No</option>
				<option value='1'>True/False</option>
				<option value='2'>Agree/Disagree</option>
				<option value='new'>Other</option>
		   </select>
		   </div>
		 </div>
		 <div id="l_o_area_id" class="l_o_area" style="height:100">
		 </div>
		
        </form>
		</td>
	    <td id="main_panel_r" align="left" colspan="2">
        <form id="r_qo_form_id" name="r_qo_form">
         <div id="r_mb_qo_id" class="r_mb_qo">
		  
		   <div class="f_right">

		   <input id="r_b_refresh_id" class="hide"
		   		type="image" src="images/submit.gif" title="[submit]"
		   		onClick="submit_form(0);
				return false;" width="142" height="31">
			
		   </div>
		 </div>
		 <div id="r_qo_area_id" class="r_qo_area"> </div>
         	 <div id="r_f_area_id" class="r_qo_area" style="height:20px"> </div>
        </form>
		 <div id="r_fsub_stat" class="f_left" style="width: 400px; height: 60px; overflow: auto"></div>
		 <div id="r_sub_stat" class="f_left" style="width: 400px; height: 150px; overflow: auto"></div>
		</td>
	  </tr>
	</table>
   </td>
  </tr>
<div id=tparam name=tparam style='visibility:hidden'></div>
  </body>
</html>

		<%
		  }
		%>
   </table>
  </center>
</div><br><center>
      </form>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="cancel" name="B2"></center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     </body>
	  <script>
	 function addQuestion(){
		 var win=window.document.create;
		
		 var asmtname=win.asmtname.value;
		 var asmtcategory=win.asmtcategory.value;
		 var points=win.points.value;
		 window.document.location.href="CDAssessmentWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points+"&mode=add";
   
 	//window.document.location.href="addQuestion.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points+"&optionMode=add";
	//win=window.open("/LBCOM/qeditor/fetchassmtQuestion.jsp?qid=new&classid=<%=classId%>&courseid=<%=courseId%>&qtype="+qtype,"qed_win","width=875,height=525,scrollbars=yes");

	
	  }
	   function goSubmit(){
		 var win=window.document.create;
		 var asmtname=win.asmtname.value;
		 var asmtcategory=win.asmtcategory.value;
		 var points=win.points.value;	
         var qtype = valButton(create.qtype);

	window.document.location.href="CDAssessmentWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points+"&qid=new&qtype="+qtype+"&submit=yes";

//window.open("q_yes_no.jsp?qid=new&classid=<%=classId%>&courseid=<%=courseId%>&qtype="+qtype);
	  }
	   function addOptiont(t){
		 var win=window.document.create;
		 var asmtname=win.asmtname.value;
		 var asmtcategory=win.asmtcategory.value;
		 var points=win.points.value;	
		
   	window.document.location.href="CDAssessmentWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asmtname="+asmtname+"&asmtcategory="+asmtcategory+"&points="+points+"&submit=yes&optionMode=add&i="+t;
	  }
	  </script>
	  </html>