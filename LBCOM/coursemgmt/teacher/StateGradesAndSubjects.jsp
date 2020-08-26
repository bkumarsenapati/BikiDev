<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">


</HEAD>

<BODY border="0" topmargin="0" leftmargin="0">
<form name="state_grades_subjects" method="post" action="">
<%@ page language="java" import="java.util.Vector,java.util.Enumeration,java.util.Hashtable,teacherAdmin.CourseBean"%>
<%
	session=request.getSession(false);
	String stateName=null;
	try{
		Vector grades=null;
		Hashtable subjects=null;
		Hashtable topics=null;
		Hashtable subtopics=null;
		
		CourseBean coursebean=(CourseBean)request.getAttribute("coursebean");
		stateName=(String)request.getAttribute("statename");
		String stateStandards=(String)session.getAttribute("statestandard");
		out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
		out.println("<tr>");
		out.println("<td width='100%' colspan='2' valign='middle' align='left' bgcolor='#E8ECF4'><font color='#800080' face='arial' size='2'><a href='javascript://'  onclick='goTo();'>Courses</a>&gt; Create Course&nbsp;&gt;<b>");


if(!stateStandards.equals("none"))
	out.println(" "+stateStandards+" State Standards");

out.println("</font></td>");
	    out.println("</tr>");
	    //out.println("<tr width='100%' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");
		//out.println("<tr width='100%'><td width='100%' colspan='2'><font face='Arial' size='2'><b>"+stateStandards+" State Standards</b></font></td></tr>");
		
	
	
		if(coursebean!=null ){ 
			out.println("<td align='left' width='50%'><font face='Arial' size='2' >Select the Grade :</font>");
		    out.println("<select id='grd' name='grades' onchange='get_subjects(this.value);return false;';><option value='none'>Select Grade</option>");
			grades=coursebean.getGrades();
			Enumeration enum=grades.elements();
			String grade="";
			while(enum.hasMoreElements()){
				grade=(String)enum.nextElement();
				out.println("<option value='"+grade+"'>"+grade+"</option>");
			}
			out.println("</select></td>");
			out.println("<td align='left' width='50%'><font face='Arial' size='2' >Select the Subject:</font>");
			out.println("<select id='sub' name='subjects'><option value='none'>Select Subject</option></select>&nbsp;&nbsp;<input type='button' name='button' value='Create' onclick='go();return false;'/></td>");
			out.println("<script>\n");  
			out.println("var grade=new Array();\n");
			subjects=coursebean.getSubjects();
			enum=subjects.keys();
			String subj="";
			int i=0;
			String temp;
			while (enum.hasMoreElements()) {
				
				grade=(String)enum.nextElement();
				temp=grade.substring(0,grade.indexOf('@'));
				subj=(String)subjects.get(grade);
				out.println("grade["+i+"]=new Array('"+temp+"','"+subj+"','"+subj+"');\n"); 
				i++;
			}
			out.println("</script>\n");
			
		}else {
			out.println("<td align='left' width='50%'><font face='Arial' size='2' >State Standards not available.</font></td>");
			
		}
		out.println("</tr></table>");	
	}catch(Exception e){
		System.out.println("Exception in States.jsp is "+e);
	}
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
	function get_subjects(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<grade.length;i++){
			if(grade[i][0]==id){
				document.state_grades_subjects.subjects[j]=new Option(grade[i][2],grade[i][1]);
				j=j+1;
			}
		} 
		return false;
	}

	function clear() {
		var i;
		var temp=document.state_grades_subjects.subjects;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	function go(){
		var grade=document.state_grades_subjects.grades.value;
		var subject=document.state_grades_subjects.subjects.value;
		if(grade!="none" && subject=="none"){
			//parent.courseinformation.location.href="about:blank";
			alert("Select the subject");
			return false;
		}else {
			parent.courseinformation.location.href="/LBCOM/coursemgmt/teacher/CreateCourse.jsp?statename=<%=stateName%>&grade="+grade+"&subject="+subject;
			return false;
		}
	}
	function goTo(){
		parent.window.location.href='/LBCOM/coursemgmt/teacher/CoursesList.jsp';
		return false;
	}
//-->
</SCRIPT>	
</form>
</BODY>
</HTML>
