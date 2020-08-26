<!--creates the courses -->


<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String mode="",courseId="",itemId="",itemDesc="",weightage="",disable="",check="",excheck="",type="",typeName="",schoolId="";
int percentage=0,maxPercentage=0,gradingSystem=0;
%>
<%
	try
	{

	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}	
	
	con=con1.getConnection();
	st=con.createStatement();
	//mode=edit&itemid=WA&cat=AS&coursename=Course1&classid=C001&courseid=c0001&classname=class1
	courseId=request.getParameter("courseid");
	schoolId=(String)session.getAttribute("schoolid");	
	itemId=request.getParameter("itemid");
	type=request.getParameter("cat");
	if(type.equals("AS"))
		typeName="Assignment";
	else if(type.equals("EX"))
		typeName="Assessment";
	else if(type.equals("CM"))
		typeName="Course material";
	else if(type.equals("CO"))
		typeName="Course outline";	
	maxPercentage=100;
	rs=st.executeQuery("select sum(weightage) percentage from category_item_master where course_id='"+courseId+"' and school_id='"+schoolId+"' and grading_system < 2");
	if (rs.next()){
		percentage=rs.getInt("percentage");
	}

	rs=st.executeQuery("select * from category_item_master where item_id='"+itemId+"' and category_type='"+type+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
	if(rs.next()){
		itemId=rs.getString("item_id");
		itemDesc=rs.getString("item_des");
		gradingSystem=rs.getInt("grading_system");
		weightage=rs.getString("weightage");
		
	}
			
	if(gradingSystem==0){
		disable="hidden";
		check="";
		excheck="";
	}
	else if(gradingSystem==1)
	{
		disable="visible";
		check="checked";
		excheck="";
	}
	else
	{
		disable="visible";
		check="checked";
		excheck="checked";
	}
	
	}catch(Exception e){
		ExceptionsFile.postException("EditCategoryItem.jsp","Operations on database ","SQLException",e.getMessage());
		System.out.println("Error in EditCategoryItem.jsp is "+e);
	}finally{
	 try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("EditCategoryItem.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}

}

	%>

<html>
<head>
<title></title>
</head>

<script language="javascript" src="validationscripts.js"></script>
<script language="javascript" src="../../validationscripts.js"></script>

<script>

function clearfileds()					//resets the create course form
{
	window.document.createcategory.reset();
	return false;
}
function changeweight(){
	document.getElementById("tr_waitht").style.visibility="visible"
	var frm=window.document.createcategory;
	if (frm.gsystem.checked==true){
		frm.gsystem.checked=true;
	//	frm.gsystem.value=1;
		frm.weightage.disabled=false;
		frm.weightage.value=<%=weightage%>;
	}
	else{
		document.getElementById("tr_waitht").style.visibility="hidden"
		/*
		frm.gsystem.checked=false;
		frm.gsystem.value=0;
		frm.weightage.disabled=true;
		frm.weightage.value=0;
		*/
	}
	
}
function extraweight()
{
	document.getElementById("tr_waitht").style.visibility="visible"
	var frm=window.document.createcategory;
	if (frm.gsystem1.checked==true){
		frm.gsystem1.checked=true;
	//	frm.gsystem.value=1;
		frm.weightage.disabled=false;
		frm.weightage.value=<%=weightage%>;
	}
	else{
		document.getElementById("tr_waitht").style.visibility="visible"
		
		frm.gsystem.checked=true;
		frm.gsystem.value=1;
		frm.weightage.disabled=false;
		frm.weightage.value=<%=weightage%>;
		
	}
	
}
function validate(frm)			//checks whether  all the required fields are filled or not
{
	if(frm.gsystem1.checked==true)
	{
		
		if(trim(frm.id.value)=="")   //if the course name  field is empty
		{
			frm.id.focus();
			return false;
		}
		if(trim(frm.description.value)=="")   //if the course name  field is empty
		{
			frm.description.focus();
			return false;
		}
		if(("<%=type%>"!="CM")&&("<%=type%>"!="CO"))
		{
			if(frm.gsystem.checked==true)
			{
				if(trim(frm.weightage.value)=="" || isNaN(!trim(frm.weightage.value)))
				{
					alert("Enter weightage in numbers");
					frm.weightage.focus();
					return false;
				}
				if(parseInt(frm.weightage.value)>max)
				{
					alert("Maximum value is "+max);
					frm.weightage.focus();
					return false;
				}
				frm.grading.value=2;
				frm.weightage.disabled=false;
			}
			else
			{
				frm.grading.value=0;
				frm.weightage.disabled=false;
				frm.weightage.value=0;
			}
		}
	}
	else
	{
	var max=<%=maxPercentage%>-<%=percentage%>+<%=weightage%>;
	if(trim(frm.id.value)=="")   //if the course name  field is empty
	{
		frm.id.focus();
		return false;
	}
	if(trim(frm.description.value)=="")   //if the course name  field is empty
	{
		frm.description.focus();
		return false;
	}
	if(("<%=type%>"!="CM")&&("<%=type%>"!="CO")){
		if(frm.gsystem.checked==true){
			if(trim(frm.weightage.value)=="" || isNaN(!trim(frm.weightage.value))){
				alert("Enter weightage in numbers");
				frm.weightage.focus();
				return false;
			}
			if(parseInt(frm.weightage.value)>max){
				alert("Maximum value is "+max);
				frm.weightage.focus();
				return false;
			}
			frm.grading.value=1;
			frm.weightage.disabled=false;
		}else{
			frm.grading.value=0;
			frm.weightage.disabled=false;
			frm.weightage.value=0;
		}
	}
	replacequotes();

}
}
</script>
<body topmargin=3>
<form action="/LBCOM/coursemgmt.AddCategoryItem?mode=edit&cat=<%=type%>" name="createcategory" onSubmit="return validate(this);" method="post">     
  <table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="center" bgcolor="#E8ECF4"><b><font face="arial" size="2" color="#800080">
      <%=typeName%> categories</font></b></td>
    </tr>
  </table>
  
  <br>
  <br><br>
  <table cellspacing="0" width="59%" bordercolordark="#48A0E0" bordercolorlight="#48A0E0" style="border-collapse:collapse;" align="center">
    <tr> 
      <td width="50%" align="left" colspan="2"><font face="Arial" size="2"><img border="0" src="../images/createtab.gif" width="151" height="28"></font></td>
    </tr>
    <tr bgcolor="#40A0E0"> 
      <td colspan="2" height="20"> 
        <div align="center"></div>
      </td>
    </tr>
    <tr>		
      <td width="50%" bgcolor="#A8B8D0" height="20"><font face="Arial" size="2">&nbsp;</font></td>
      <td bgcolor="#A8B8D0">&nbsp;</td>
    </tr>
    <tr> 
      <td width="50%"> <font face="Arial" size="2">Description</font> </td>
      <td> 
        <font face="Arial" size="2"> 
        <!--<textarea rows="3" cols="28" name="description" maxlength="20" > <%=itemDesc%> </textarea>  -->
		<input type="text" name="description" maxlength="20" value="<%=itemDesc%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" > 
        </font>
      </td>
	  <td><font face="Arial" size="2">
	  <%if((type.equals("CM"))||(type.equals("CO"))){%>
	  <input type="hidden" name="gsystem1"></font>
	  <%}else{%>
      <!-- <input type="checkbox" name="gsystem1" title="Extra Credit" value="<%=gradingSystem%>" <%=excheck%> onclick="extraweight();"></font> -->
	  <%}%>
      </td>

    </tr>
	<%if((type.equals("CM"))||(type.equals("CO"))){%>
		<input type="hidden" name="weightage" value="0">
	<%}else{%>
		<tr> 
		  <td width="50%" height="20"> <font face="Arial" size="2">Grading</font> 
		  </td>
		  <td><font face="Arial" size="2">
		  <input type="checkbox" name="gsystem" value="<%=gradingSystem%>" <%=check%> onclick="changeweight();"> </font></td>

		</tr>
<tr> 
		  <td width="50%" height="20"> <font face="Arial" size="2">Extra Credit</font> 
		  </td>
		  <td><font face="Arial" size="2">
		  <input type="checkbox" name="gsystem1" title="Extra Credit" value="<%=gradingSystem%>" <%=excheck%> onclick="extraweight();"></font></td>

		</tr>
		<tr id="tr_waitht" style="visibility:<%=disable%>"> 
		  <td width="50%" height="20"><font face="Arial" size="2">Weightage</font></td>
		  <td> 
			<font face="Arial" size="2"> 
			<input type="text" name="weightage" value="<%=weightage%>"  size="3" maxlength="3"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"  > 
			%</font></td>
		</tr>
	<%}%>
    <tr> 
      <td width="50%" bgcolor="#A8B8D0" height="20"></td>
      <td bgcolor="#A8B8D0"><font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="50%" bgcolor="#40A0E0" height="20"> </td>
      <td bgcolor="#40A0E0"> 
      </td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2> 
        <font face="Arial" size="2"> 
        <input type=image src="../images/submit.gif">
        <input type=image src="../images/reset.gif" onClick="return clearfileds();">
        </font>
      </td>
    </tr>
  </table>
  <input type="hidden" name="id" value="<%=itemId%>">
  <input type="hidden" name="grading" value="<%=gradingSystem%>">
  <INPUT TYPE="hidden" name="courseid" value="<%=request.getParameter("courseid")%>">
  <INPUT TYPE="hidden" name="coursename" value="<%=request.getParameter("coursename")%>">
  <INPUT TYPE="hidden" name="classid" value="<%=request.getParameter("classid")%>">
  <INPUT TYPE="hidden" name="classname" value="<%=request.getParameter("classname")%>">
 </form>

</body>
</html>
