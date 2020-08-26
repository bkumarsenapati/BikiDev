<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st11=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs11=null;
	
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgnContent="",developerId="";
	String tableName="",sessid="",mode="";
	int assmt=0;
	boolean no=false;

		try
		{
				sessid=(String)session.getAttribute("sessid");
				if(sessid==null){
						out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
						return;
				}
		courseId=request.getParameter("courseid");
		//courseName=request.getParameter("coursename");
		//developerId=request.getParameter("userid");
		developerId = (String)session.getAttribute("cb_developer");
		unitId=request.getParameter("unitid");
		//unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		//lessonName=request.getParameter("lessonname");
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		mode=request.getParameter("mode");
			
		tableName="lbcms_dev_assessment_master";

		rs=st.executeQuery("select * from "+tableName+"");
		while(rs.next())
		{
			assmt=Integer.parseInt(rs.getString("slno"));
			assmt=assmt+1;
						
			no=true;
		}
		if(no==false)
		{
			 assmt=1;
		
		}
		rs.close();
		st.close();
		rs1=st1.executeQuery("select * from lbcms_dev_course_master where course_id='"+courseId+"'");
		if(rs1.next())
		{
			courseName=rs1.getString("course_name");
		}
		rs1.close();
		st1.close();
		if(lessonName==null)
		{
			lessonName="-";
		}



	
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Create Asseessment</title>
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" src="../../validationscripts.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
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



function cleardata()
{
	document.create.reset();
	addOptions();
	return false;
}
</script>

</head>
<body>
<form name="create" method="post" action="SavePretest.jsp?mode=add&courseid=<%=courseId%>">
<!-- <form name="create" method="post" action="#"> -->
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%" colspan="2">
      <img border="0" src="../images/logo.png" width="368" height="101"></td>
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr size="1"></td>
    </tr>
    
	<tr>
      <td width="50%" class="gridhdrNew"><font face="Verdana" size="2" ><b>Course :
      </b></font><font face="Verdana" size="2" ><%=courseName%></font></td>
      <!-- <td width="50%" class="gridhdrNew">
      <p align="right"><font face="Verdana" size="2" ><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" ><%=lessonName%></font></td> -->
    </tr>
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="175">
   <tr>
      <td width="28%" class="gridhdrNew1" height="1"><b>
      <font face="Verdana" size="2" >&nbsp;CREATE ASSESSMENT</font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
      <td width="45%" class="gridhdrNew1" height="1">
      <p align="right"><b><font face="Verdana" size="1" >
      <a href="javascript:self.close();"><font >CLOSE</font></a>&nbsp; </font></b></td>
    </tr>
    <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
    
        <input type="text" name="assgnname" id="assgnname" size="54"></td>
    </tr>
    <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
			<select id="asgncategory" name="asgncategory">
				<option value="PT" selected>Pretest</option>
			</select>
	</td>
    </tr>
	<tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Pretest Type</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
	  <!-- 

	  // cl - Course level
	  // ul - Unit level
	  -->

	  <input type="radio" name="extype" value="cl" id="extype" onClick="getsubids('cl');"/>Course level
  	  &nbsp;&nbsp;&nbsp;<input type="radio" name="extype" value="ul" id="extype" onClick="getsubids('ul');"/>Unit level

		<div id="unitlevel" style="visibility: hidden;">
			<%
				st2=con.createStatement();
				rs2=st2.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"' order by unit_id");
				while(rs2.next())
				{
					%>
						<input type="checkbox" id="chk" name="chk" value="<%=rs2.getString("unit_id")%>" onClick="selectUnits(this);"/><%=rs2.getString("unit_name")%>					
					<%
				}
				rs2.close();
				st2.close();
			%>
			
		</div>

		<div id="courselevel" style="visibility: hidden;">
			<%
		try
			{
				st3=con.createStatement();
				rs3=st3.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"' order by unit_id");
				while(rs3.next())
				{
					%>
						<input type="checkbox" id="crschk" name="crschk" value="<%=rs3.getString("unit_id")%>" checked onClick="selectUnits(this);"/><%=rs3.getString("unit_name")%>					
					<%
				}
				rs3.close();
				st3.close();

			}
			catch(Exception e)
			{
				System.out.println("Exception ..."+e.getMessage());
			}
			%>
			
		</div>
	 </td>
   </tr>
   <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Select Questions</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
	  <!-- 

	  // se - system evaluation
	  // me - manual evaluation
	  -->

	  <input type="radio" name="prtype" value="se" id="prtype" onClick="getques('se');"/><font title="Auto graded questions">System evaluation</font>
  	  &nbsp;&nbsp;&nbsp;<input type="radio" name="prtype" value="me" id="prtype" onClick="getques('me');"/><font title="Including Short/ Essay Type and Fill In The Blanks">All</font>
	 </td>
   </tr>
   <tr>
      <td width="73%" colspan="2" height="1" class="gridhdrNew1" align="center">
      <p align="left"><input type="hidden" id="check" name="check" value="Check questions availability"/></td>
    </tr>    
   
   <tr>
      <td width="73%" colspan="2" height="1" class="gridhdrNew1" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Enter the assessment 
      instructions in the below area: </font><p align="center"><font face="Verdana" size="2">
      <textarea rows="7" name="instructions" id="instructions" cols="75" ></textarea></font><p align="left">&nbsp;</td>
    </tr>
	<!-- <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Pretest pass( %):</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
    
        <input type="text" name="passpercent" id="passpercent" size="54"></td>
    </tr> -->

	<input type="hidden" name="passpercent" id="passpercent" value="80" size="54"></td>


  </table>
<input type="hidden" name="noofunits" id="noofunits" value=""/>
<input type="hidden" name="selque" id="selque" value=""/>
<input type="hidden" name="evaltype" id="evaltype" value=""/>
  </center>
</div>
&nbsp;</p>
<div id="unitlesson" name="unitlesson">
</div>
<center> <input type="submit" value="Submit" name="B1" onClick="return validate(); return false;">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata()"> </center>
 </form>
	  <%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CreatePretest.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				if(st4!=null)
					st4.close();
				if(st5!=null)
					st5.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in CreatePretest.jsp is....."+se.getMessage());
			}
	}
%>
      <p>&nbsp;
	  <script>
function validate()
{
	var win=window.document.create;
	
	//
			var count=new Array();
			
			with(document.create)
			{
					
					for(var i=0,j=0; i < elements.length; i++)
					{
						
						
					   if (elements[i].type == 'text')
						{
						   //alert("Textbox...");
						   //alert("name.."+elements[i].name);
							//alert("value..."+elements[i].name.value);
						}
					}
					
					
			 }

	//
	
	
	
	if(win.assgnname.value == "")
	{
		alert("Please enter the assessment name");
		window.document.create.assgnname.focus();
		return false;
	}
	var cat=window.document.create.asgncategory.value

	if(cat=="all")
	{
		alert("Please select category");
		window.document.create.asgncategory.focus();
		return false;
	}
	if(win.extype.value == "")
	{
		//alert(win.extype.value);
		alert("Please select the Pre-Test type");
		//window.document.create.assgnname.focus();
		return false;
	}
	if(win.prtype.value == "")
	{
		//alert(win.prtype.value);
		alert("Please select \"Select Questions\" option");
		//window.document.create.assgnname.focus();
		return false;
	}
	
}

function checkQues(id,value) 
{
	var win=document.create;
	var max=value;
	//alert(document.getElementById(id).value);
	
	if (isNaN(trim(document.getElementById(id).value))) {
		alert("Please enter only numbers");
		document.getElementById(id).focus();
		return false;
	}
	
	if(document.getElementById(id).value > max || document.getElementById(id).value == "")
	{
			alert("Maximum questions should be less than or equal to "+max);
			//win.id.focus();
			//document.getElementById(id).focus();
			return false;
}
}


function getsubids(id) {
	//alert(id);
		if(id == 'ul') {
         document.getElementById("unitlevel").style.visibility = "visible";
		 window.document.create.selque.value="ul";
      }
	  else
		{
		  document.getElementById("unitlevel").style.visibility = "hidden";
		  window.document.create.selque.value="cl";

		  // disselect unit level
			var selid=new Array();
			
			with(document.create)
			{
					for(var i=0,j=0; i < elements.length; i++)
					{
					   if (elements[i].type == 'checkbox' && elements[i].name == 'chk')
						{
							elements[i].checked=false;
						}
					}
					window.document.create.noofunits.value="";
					//alert("getsubids..."+window.document.create.noofunits.value);
					
			 }

		  //

		  // select course level
				var crsselid=new Array();
				
				with(document.create)
				{
						for(var i=0,j=0; i < elements.length; i++)
						{
						   if (elements[i].type == 'checkbox' && elements[i].name == 'crschk' && elements[i].checked==true)
							{
							  // alert(elements[i].value);         
							   crsselid[j++]=elements[i].value;
							   //alert(selid);
							}
						}
						window.document.create.noofunits.value=crsselid;
						
				 }
		 //
		}
}

function getques(id) {
	//alert(id);
		if(id == 'se')
			window.document.create.evaltype.value="se";
		else
			window.document.create.evaltype.value="me";
		
		//document.getElementById("check").click();

		window.document.create.check.click();
		
}


function selectUnits()
{
	
		var selid=new Array();
		var unitstr="";
        with(document.create)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'chk' && elements[i].checked==true)
					{
					  // alert(elements[i].value);         
					   selid[j++]=elements[i].value;
					   //alert(selid);
					}
				}
				window.document.create.noofunits.value=selid;
				
         }
		// unitstr="noofunits";
		
		 
	
}

</script>
<script>
 //$("#prtype").click(function (){
	 $("#check").click(function (){
 //alert("entered into fn");
	var courseid="<%=courseId%>";
	var selque=$("#selque").val();
	//alert(selque);
    var evaltype=$("#evaltype").val();
	if(evaltype=="")
	{
		alert("Please select \"Select Questions\" option");
		return;

	}
	//alert("evaltype..."+evaltype);
	var noofunits = $("#noofunits").val();
	//alert(noofunits);
   	$.post( "/LBCOM/lbcms/AssmtBuilder/PretestUnits.jsp", { courseid: courseid,noofunits: noofunits,selque: selque,evaltype: evaltype})
				.done(function(data) {
				//alert(data);
				$("#unitlesson").html(data);
				});
  })
 </script>

</body>

</html>