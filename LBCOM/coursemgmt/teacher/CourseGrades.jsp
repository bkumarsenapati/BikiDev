<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="dbCon" class="sqlbean.DbBean" scope="page" />
<%!
	String havegrades[] = {"A+","A","A-","B+","B","B-","C+","C","C-","D+","D"};
	int havemaxs[] = {100,94,89,84,79,74,69,64,59,54,49};
	int havemins[] = {95,90,85,80,75,70,65,60,55,50,0};
%>
<% 
	Connection con =null;
	Statement stmt=null;
    ResultSet rs=null;
	String courseId="",courseName="",teacherid="",schoolid="",classId="",categoryId="",schoolId="",className="";
	int i=0;
	int haveFlag = 0;
	int[] maxs = new int[11];
	int[] mins = new int[11];

	int noVal=0;
	String[] grades=new String[11];
	int exwtg=0,asswtg=0,hwwtg=0,pwwtg=0,fewtg=0,mewtg=0;

	
%>
<%
    schoolId=(String)session.getAttribute("schoolid");
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	classId=request.getParameter("classid");
	className=request.getParameter("classname");
	

%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="hotschools.net">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function clearfileds()
{
	window.document.defgrades.reset();
	return false;
}

function checkNumber(keyCode)
{
	if(keyCode>=48 && keyCode<=57)
		return true;
	else
		if(keyCode==8 || keyCode==13)
		  return true;
	   else
	   {
		alert("Enter Only Numbers");
		return false;
	   }
}

function checkall()
 {
    var frm=window.document.defgrades
	var num="0123456789"
    var txt=document.getElementsByTagName("input")
     for(i=0;i<txt.length-2;i++)
      {
	   if(txt[i].type!="hidden"){
		   if(txt[i].value=="")
		   {
			  alert("Please Enter Proper values");
			  txt[i].select()
			  i =100;
			  return false;
         }
	   if(( num.indexOf((txt[i].value).charAt(0)))==-1||
		   (num.indexOf((txt[i].value).charAt(1)))==-1||
		   (num.indexOf((txt[i].value).charAt(2)))==-1)
          {
           alert("Please Enter Numbers only");
           txt[i].select();
	       i =100;
           return false;
          } 
	   if(parseInt(txt[i].value) > 100 || parseInt(txt[i].value) < 0)
	     {
          alert("Please Enter Proper values");
		  txt[i].select();
		  i =100;
		  return false;
         }
	}
	  }
	  
 var sum=0;
 var ids=document.getElementsByName("itemid");
 var len=ids.length;
 if(len){
  for(i=0;i<len;i++){
	  var tmp=ids[i].value;
	  tmp=document.getElementsByName(tmp);
	  sum+=parseInt(tmp[0].value);
  }
  if(sum>100)
  {
	 alert("Sum of all category weightages should be equal to 100");
	 tmp=ids[0].value;
     var field=document.getElementsByName(tmp);
	 field[0].select();
	return false;
  }
  
 }
 len=(2*len);
for(i=len;i<((frm.length)-2);i=i+2){
	
  if(parseInt(frm.elements[i].value)< parseInt(frm.elements[i+1].value))
     {
	   alert("Please Enter Proper values")
	   frm.elements[i].select()
	   return false;
     }
}
for(i=len+1;i<((frm.length)-2);i=i+2){
	if((parseInt(frm.elements[i].value))!= (parseInt(frm.elements[i+1].value)+1))
     {
	   alert("Please Enter Proper values")
	   frm.elements[i].select()
	   return false;
     }
 }
}

</script>

</head>
<body topmargin=3 leftmargin="0" marginwidth="0">

<!--<form method="POST" name="defgrades" action="/servlet/coursemgmt.AddGrades?courseid=<%=courseId %>">-->
<form method="POST" name="defgrades" action="/LBCOM/coursemgmt.AddGrades?courseid=<%=courseId %>">
  <table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080"><a href="CoursesList.jsp">Courses</a> &gt;&gt; <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"><%= courseName %></a> &gt;&gt; <%=className%> &gt;&gt;</font> Grade Definitions</td>
    </tr>
  </table>
	<p align="center"><b><font face="Verdana"><span style="font-size:10pt;">Define Weightages</span></font></b><font face="Verdana"><span style="font-size:10pt;"><br>
	</span></font></p>
	<div align="center">
      <center>
	  <center>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EDF5FC" width="450" id="AutoNumber1" bordercolorlight="#EDF5FC" bordercolordark="#EDF5FC" height="65">
  
<%	

	try
	{
		con = dbCon.getConnection();
		stmt = con.createStatement();
		noVal=0;
		categoryId="";
		String catName="";
		rs=stmt.executeQuery("select * from category_item_master where category_type!='CM' and category_type!='CO' and grading_system!=0 and course_id='"+courseId+"' and school_id='"+schoolId+"' order by category_type");
    	while (rs.next()){
			if(!categoryId.equals(rs.getString("category_type"))){
				categoryId=rs.getString("category_type");
			    if (categoryId.equals("AS"))
					catName="Assignments";
				else if(categoryId.equals("EX"))
					catName="Assessments";
		%>
				<tr>
					<td width="100" colspan="3" bgcolor="#40A0E0" height="21">
					<font face="Arial" size="2">&nbsp;<%=catName%></font></td>
				</tr>
		<%}%>

		<tr>
			<td width="7%" height="19">&nbsp;</td>
			<td width="80%" height="19"><%=rs.getString("item_des")%>&nbsp;</td>
			<td width="13%" height="19"><font face="Arial"><input type="hidden" name="itemid" value="<%=rs.getString("item_id")%>">
            </font><font face="Arial"><input type="text" name="<%=rs.getString("item_id")%>" value="<%=rs.getString("weightage")%>" size="3"><font size="2">%&nbsp;</font></font></td>
		</tr>
	  <%}
	} catch(SQLException se){
		ExceptionsFile.postException("CourseGrades.jsp","Operations on category_item_master table","SQLException",se.getMessage());
		out.println(se.getMessage());
		try{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException s){
			ExceptionsFile.postException("CourseGrades.jsp","closing statement and connection  objects","SQLException",s.getMessage());
			System.out.println(s.getMessage());
		}
	}
	catch(Exception e){
		ExceptionsFile.postException("CourseGrades.jsp","Operations on category_item_master table","Exception",e.getMessage());
		out.println(e.getMessage());
	}
%>
    
	</table>
    </center>
    </div>

  <p align="center"><b><font face="Verdana"><span style="font-size:10pt;">Define Grades</span></font></b></p>
    <p align="center">  <table width="610" style="border-collapse:collapse;" cellspacing="0">
    <tr>
      <td width="192" bgcolor="#40A0E0" style="border-top-width:2; border-left-width:2; border-top-color:rgb(64,160,224); border-left-color:rgb(64,160,224); border-top-style:solid; border-left-style:solid;" colspan="2">
        <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Grade Definition</span></font></b></td>
	  <td width="202" bgcolor="#40A0E0" style="border-top-width:2; border-top-color:rgb(64,160,224); border-top-style:solid;">
         <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Maximum Percentage</span></font></b>
        </td>
     <td width="206" bgcolor="#40A0E0" style="border-top-width:2; border-right-width:2; border-top-color:rgb(64,160,224); border-right-color:rgb(64,160,224); border-top-style:solid; border-right-style:solid;">
     <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Minimum Percentage</span></font></b></td>
    </tr>	
<%
	try
	{
		i=0;		
		rs.close();
		rs=stmt.executeQuery("select * from gradedefinitions where course_id= '"+courseId+"' and  school_id='"+schoolId+"' order by max desc");

		while(rs.next())
		{	
			
			mins[i]=rs.getInt("min");
			maxs[i]=rs.getInt("max");
			grades[i]=rs.getString("grade");
			noVal=1;
			%>
			<tr>
			<td width="72" style="border-left-width:2; border-left-color:rgb(64,160,224); border-left-style:solid;">
			<td width="118" style="font-size:10pt;"><p align="left"><b><font face="Verdana"><span style="font-size:10pt;">"<%=grades[i]%>"</span></font></b><font face="Verdana"><span style="font-size:10pt;">&nbsp;</span></font>			     
			&nbsp;</td>
			<td width="202">
			<p align="center"><b><font face="Verdana"><span style="font-size:10pt;"><input type="text" name="T<%=i%>max" value="<%=maxs[i]%>" size="4" maxlength=3 > </span></font></b></td>
			<td width="206" style="border-right-width:2; border-right-color:rgb(64,160,224); border-right-style:solid;">
			<p align="center"><b><font face="Verdana"><span style="font-size:10pt;"><input type="text" name="T<%=i%>min" value="<%=mins[i]%>" size="4" maxlength=2 > </span></font></b></td>
			</tr>
			<%
			i=i+1;
			
		}
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("CourseGrades.jsp","Operations on gradedefinitions table ","SQLException",se.getMessage());
		out.println(se.getMessage());
	}		

	catch(Exception e)
	{
		ExceptionsFile.postException("CourseGrades.jsp","Operations on gradedefinitions table ","Exception",e.getMessage());
		out.println(e.getMessage());
	}finally{
		try{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CourseGrades.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }		

	if(noVal==0){
		out.println("Default Grades");
		for(int have=0;have<11;have++){
				%>
				<tr>
			   <td width="72" style="border-left-width:2; border-left-color:rgb(64,160,224); border-left-style:solid;">
			    <td width="118" style="font-size:10pt;"><p align="left"><b><font face="Verdana"><span style="font-size:10pt;"><%=havegrades[have]%></span></font></b><font face="Verdana"><span style="font-size:10pt;">&nbsp;</span></font>				     
			    &nbsp;</td>
			    <td width="202">
			    <p align="center"><b><font face="Verdana"><span style="font-size:10pt;"><input type="text" name="T<%=have%>max" value="<%=havemaxs[have]%>" size="4"></span></font></b></td>
			    <td width="206" style="border-right-width:2; border-right-color:rgb(64,160,224); border-right-style:solid;">
			    <p align="center"><b><font face="Verdana"><span style="font-size:10pt;"><input type="text" name="T<%=have%>min" value="<%=havemins[have]%>" size="4"></span></font></b></td>
			    </tr>
				<%
		}
				
	}
	%>
	<tr>
    <td width="192" bgcolor="#40A0E0" style="border-top-width:2; border-left-width:2; border-top-color:rgb(64,160,224); border-left-color:rgb(64,160,224); border-top-style:solid; border-left-style:solid;" colspan="2">
    </td>
	<td width="202" bgcolor="#40A0E0" style="border-top-width:2; border-top-color:rgb(64,160,224); border-top-style:solid;">
    </td>
    <td width="206" bgcolor="#40A0E0" style="border-top-width:2; border-right-width:2; border-top-color:rgb(64,160,224); border-right-color:rgb(64,160,224); border-top-style:solid; border-right-style:solid;">
    </td>
    </tr>	
    </table>
        <p align="center">
		<input type="image" src="../images/submit.gif" width="89" height="34" value="submit" onClick="return checkall()">
		<!--<input type="image" src="../images/submit.gif" width="89" height="34" value="submit" >-->
		<input type=image src="../images/reset.gif" onClick="return clearfileds();"></p>
</form>
</body>
</html>
