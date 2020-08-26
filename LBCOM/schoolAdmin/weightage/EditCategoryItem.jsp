<!--creates the courses -->


<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String mode="",courseId="",itemId="",itemDesc="",weightage="",disable="",check="",type="",typeName="",schoolId="";
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
	rs=st.executeQuery("select sum(weightage) percentage from admin_category_item_master where school_id='"+schoolId+"'");
	if (rs.next()){
		percentage=rs.getInt("percentage");
	}

	rs=st.executeQuery("select * from admin_category_item_master where item_id='"+itemId+"' and category_type='"+type+"' and school_id='"+schoolId+"'");
	if(rs.next()){
		itemId=rs.getString("item_id");
		itemDesc=rs.getString("item_des");
		gradingSystem=rs.getInt("grading_system");
		weightage=rs.getString("weightage");
		
	}
			
	if(gradingSystem==0){
		disable="disabled";
		check="";
	}
	else{
		disable="";
		check="checked";
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
	var frm=window.document.createcategory;
	if (frm.gsystem.checked==true){
		frm.gsystem.checked=true;
	//	frm.gsystem.value=1;
		frm.weightage.disabled=false;
		frm.weightage.value=<%=maxPercentage%>-<%=percentage%>+<%=weightage%>;
	}
	else{
		frm.gsystem.checked=false;
		frm.gsystem.value=0;
		frm.weightage.disabled=true;
		frm.weightage.value=0;
	}
	
}
function validate(frm)			//checks whether  all the required fields are filled or not
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
			//frm.gsystem.value=1;
			frm.grading.value=1;
			frm.weightage.disabled=false;
		}else{
			//frm.gsystem.value=0;
			frm.grading.value=0;
			frm.weightage.disabled=false;
			frm.weightage.value=0;
		}
	}
	replacequotes();

}
</script>
<body topmargin=3>

<form action="/LBCOM/schoolAdmin.Weightage?mode=edit&cat=<%=type%>" name="createcategory" onSubmit="return validate(this);" method="post">     

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
      <td width="50%" align="left"><font face="Arial" size="2"><img border="0" src="images/createtab.gif" width="151" height="28"></font></td>
      <td width="50%" align="right"><a href="javascript:history.go(-1)">
		<font size="4">Back</font></a></td>
    </tr>
    <tr bgcolor="#eeba4d"> 
      <td colspan="2" height="20"> 
        <div align="center"></div>
      </td>
    </tr>
    <tr>		
      <td width="50%" bgcolor="#EEE0A1" height="20"><font face="Arial" size="2">&nbsp;</font></td>
      <td bgcolor="#EEE0A1">&nbsp;</td>
    </tr>
    <tr> 
      <td width="50%"> <font face="Arial" size="2">Description</font> </td>
      <td> 
        <font face="Arial" size="2"> 
        <!--<textarea rows="3" cols="28" name="description" maxlength="20" > <%=itemDesc%> </textarea>  -->
		<input type="text" name="description" maxlength="20" value="<%=itemDesc%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" > 
        </font>
      </td>
    </tr>
	<%if((type.equals("CM"))||(type.equals("CO"))){%>
		<input type="hidden" name="weightage" value="0">
	<%}else{%>
		<tr> 
		  <td width="50%" height="20"> <font face="Arial" size="2">Grading system </font> 
		  </td>
		  <td><font face="Arial" size="2">
		  <input type="checkbox" name="gsystem" value="<%=gradingSystem%>" <%=check%> onclick="changeweight();"> </font></td>

		</tr>
		<tr> 
		  <td width="50%" height="20"><font face="Arial" size="2">Weightage</font></td>
		  <td> 
			<font face="Arial" size="2"> 
			<input type="text" name="weightage" value="<%=weightage%>" <%=disable%> size="3" maxlength="3"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"  > 
			%</font></td>
		</tr>
	<%}%>
    <tr> 
      <td width="50%" bgcolor="#EEE0A1" height="20"></td>
      <td bgcolor="#EEE0A1"><font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="50%" bgcolor="#eeba4d" height="20"> </td>
      <td bgcolor="#eeba4d"> 
      </td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2> 
        <font face="Arial" size="2"> 
        <input type=image src="images/submit.gif" width="88" height="36">
        <input type=image src="images/reset.gif" onClick="return clearfileds();" width="87" height="40">
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
