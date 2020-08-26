<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function go(){
		//var ele=document.getElementsById("st");
		var val=document.states_form.states.value;
		//alert(val);
		if(val=="none")
			parent.courseinformation.location.href='CreateCourse.jsp';
		else{
			parent.courseinformation.location.href='about:blank';
			parent.otherdetails.location.href='/LBCOM/StateStandards?doctype=onestate&statename='+val;
			
		}
		return false;
	}
	function goTo(){
		parent.window.location.href='/LBCOM/coursemgmt/teacher/CoursesList.jsp';
		return false;
	}
//-->
</SCRIPT>
</HEAD>

<BODY border="0" topmargin="1" leftmargin="0">
<form name='states_form' method='post' action="">
<table border="0" width="100%" cellspacing="0">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face='arial' size='2'><a href="javascript://"  onclick='goTo();'>Courses</a>
        &gt; Create Course</font></td>
    </tr>
</table>
<%@ page language="java" import="java.util.Vector,java.util.Enumeration" %>

<%
	session=request.getSession(false);
	try{
		Vector states=(Vector)request.getAttribute("states");
		out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
	    out.println("<tr width='100%' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");
		if(states!=null && !states.isEmpty()){ 
			out.println("<td align='left' width='50%'><font face='Arial' size='2' >Select the State :</font>");
		    out.println("<select id='st' name='states'><option value='none'>Select the State Standards</option>");
			Enumeration enum=states.elements();
			String state="";
			while(enum.hasMoreElements()){
				state=(String)enum.nextElement();
				out.println("<option value='"+state+"'>"+state+"</option>");
			}
			out.println("</select><input type='button' name='button' value='>>' onclick='go();return false;'/></td>");
			//out.println("<td align='left' width='50%'><font face='Arial' size='2' ></font></td>");
		}else{
			out.println("<td align=right width='50%'><font face='Arial' size='2' >There are no Specific State Standards</td");
		}
		out.println("</tr></table>");
	}catch(Exception e){
		System.out.println("Exception in States.jsp is "+e);
	}
%>

</form>
</BODY>
</HTML>
