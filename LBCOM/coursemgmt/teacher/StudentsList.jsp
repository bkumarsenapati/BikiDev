<%@ page language="java" import="java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String schoolId="",teacherId="",studentId="",courseName="",folderName="",courseDes="",state="",classId="",subject="",acYear="",sess="",mode="",selectedIds="",id="",courseId="";
String className="";
Connection con=null;
ResultSet rs=null;
Statement st=null;
boolean flag=false;
File folder=null;
Hashtable selectedIdsHTable=null;
%>
<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}

	if(session==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");

		return;

	}

	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");

	
	classId=request.getParameter("classid");
	courseName=request.getParameter("coursename");
	courseId=request.getParameter("courseid");
	className=request.getParameter("classname");
	String subsectionId=request.getParameter("subsectionid");
	
	String query="";
	Hashtable hs=null;
	if(subsectionId==null){
		
		query="";
	}else{
		if (subsectionId.equals("all")){
			query="";
		}else{
			StringTokenizer stk=new StringTokenizer(subsectionId,",");
			if(stk.hasMoreTokens()){
				query=" and (subsection_id='"+stk.nextToken()+"'";
				while(stk.hasMoreTokens()){
					query+=" or subsection_id='"+stk.nextToken()+"'";
				}
				query+=")";
			}else{
				//query=" where (subsection_id='"
			}
		}
	}

	mode=request.getParameter("mode");
	con=con1.getConnection();

	st=con.createStatement();
	
	//if(mode.equals("mod")){ //commented by rajesh
		//rs=st.executeQuery("select student_id from coursewareinfo_det where course_id='"+courseId+"'");
		rs=st.executeQuery("select student_id from coursewareinfo_det ci inner join studentprofile sp on sp.schoolid=ci.school_id and sp.username=ci.student_id and status=1 where school_id='"+schoolId+"' and course_id='"+courseId+"' ");
		selectedIdsHTable=new Hashtable();
		while(rs.next()){
			id=rs.getString(1);
			selectedIdsHTable.put(id,id);
		}
		if(!selectedIdsHTable.contains(classId+"_vstudent")){
			selectedIdsHTable.put(classId+"_vstudent",classId+"_vstudent");
		}
		session.setAttribute("selectedids",selectedIdsHTable);
//	}
//	rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and grade='"+classId+"'");

	
%>
<html>
<head>
<title></title>
<script>
var checked=new Array();
var unchecked=new Array();
function selectAll()
{
	var len=window.document.studentslist.elements.length;
	for(i=0;i<len;i++)
	{
		window.document.studentslist.elements[i].checked=true;
	}
	return false;
}

function deselectAll()
{
	var len1=window.document.studentslist.elements.length;
	for(j=0;j<len1;j++)
	{
		if(window.document.studentslist.elements[j].value != "<%=classId%>_vstudent")
			window.document.studentslist.elements[j].checked=false;
	}
	return false;
}

function validate()
{
	var chk="false";
	var len2=window.document.studentslist.elements.length;
	/*for(k=0;k<len2;k++)
	{
		if(window.document.studentslist.elements[k].checked==true)
		chk="true";
	}*/

	var arr=document.getElementsByName("studentids");
	for(var i=0,j=0,k=0;i<arr.length;i++){
		if(arr[i].checked){
			chk=true;
			checked[j++]=arr[i].value;
		}else{
			unchecked[k++]=arr[i].value;
		}
	}
	if(chk=="false")
	{
		alert("Select at least one student ");
		return false;
	}else{
		document.studentslist.checked.value=checked;
		document.studentslist.unchecked.value=unchecked;
	}
	//
	$("#nav_main li").removeClass('selected');grid_content.load("grids/coursemgmt/teacher/CourseEdit.jsp?courseid=<%= courseId %>&checked="+checked+"&unchecked="+unchecked,hideLoading);

	//

}

function call(courseid,coursename,classid,classname,mode){
	
	var sec=document.getElementsByName("subsection_id");
	var subsec="";
	var flag=false;
	
	for(var i=0;i<sec[0].length;i++){
		flag=true;
		if(sec[0].options[i].selected){
			if(sec[0].options[i].value=="all"){
				subsec="all,";
				//i=sec[0].length;
				break;
			}
			subsec+=sec[0].options[i].value+",";
			
		}
	}
	subsec=subsec.substr(0,subsec.length-1);
	
	if(flag==true){		
		document.location.href="StudentsList.jsp?mode="+mode+"&coursename="+coursename+"&classid="+classid+"&courseid="+courseid+"&classname="+classname+"&subsectionid="+subsec;
	}else{
		alert('Select the Group / Subsection');
		return false;
	}
}
</script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
<script src="http://malsup.github.com/jquery.form.js"></script> 
</head>
<form name="studentslist"  method="post" onSubmit="return validate();">
<table border="0" width="100%" cellspacing="1">
  <tr>
    <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><!-- <a href="CoursesList.jsp">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"> --><%=courseName %><!-- </a> --> &gt;&gt; <%=className %> &gt;&gt; <font color=black> Distribute Course</span></font></td>
  </tr>
</table>

<font face=Arial size=2><br>

		</font><center>
		<table border="0" width="600" cellspacing="0">
		<tr>

		<%
			hs=new Hashtable();
			rs=st.executeQuery("select * from subsection_tbl where school_id='"+schoolId+"' and class_id='"+classId+"'");
			if(rs.next()){
				out.println("<td width='400' colspan='2'><p align='left'><font face='arial' size='2'><b>Group / Subsection :</b></font>");
				out.println("<select name='subsection_id' size='1' multiple='true'>");
				out.println("<option value='all'>All</option>");
				out.println("<option value='nil'>Default</option>");
				do{
					out.println("<option value='"+rs.getString("subsection_id")+"'>"+rs.getString("subsection_des")+"</option>");
					hs.put(rs.getString("subsection_id"),rs.getString("subsection_des"));
				}while(rs.next());
				out.println("</select>&nbsp;&nbsp<input type='button' value='>>' name='list' onclick=\"call('"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+mode+"'); \"></td>");
			}
			
			rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and status=1 and grade='"+classId+"' "+query+" order by subsection_id");
		%>
		<td width="602" colSpan="4">
		<p align="right">
  		<input type="image" onClick="return selectAll()" TITLE="Check All" src="../../coursemgmt/images/checkall.jpg" width="88" height="37"><input type="image" onClick="return deselectAll()" TITLE="Clear All" src="../../coursemgmt/images/clearall.jpg" width="89" height="37">
		</td>
		</tr>  
		<tr>      
			<td width="748" colSpan="4">        
	  		<p align="left"><img src="../../coursemgmt/images/selectstudent.gif" width="151" height="28" border="0"></p>
		</td>
		</tr>    
		<tr>      
			<td width="748" colSpan="4">        
	  		<p align="left"><b><font face="Arial" size="2"><img src="../../coursemgmt/images/studentslistheader.gif" border="0" width="597" height="25"></font></b></p>
		</td>
		</tr>    
	  	<tr>      
  			<td align="left" width="19"><font color="#000066">&nbsp;</font></td>      
			<td align="left" width="244"><b><font face="Arial" size="2" color="#000066">Name</font></b></td> 
			<td align="left" width="314"><b><font face="Arial" size="2" color="#000066">Email ID</font></b></td>      
			<td align="left" width="244"><b><font face="Arial" size="2" color="#000066">Group</font></b></td>
		</tr>
	
	<%
			while(rs.next())
			{
				studentId=rs.getString("emailid");
				//if(mode.equals("mod")){			//commented by rajesh
					if(studentId.equals(selectedIdsHTable.get(studentId))){
						String block="";
						if(studentId.equals(classId+"_vstudent")) block="onclick='this.checked=true'";
						out.println("<tr><td align='left' width='19'><input type='checkbox' name='studentids' checked value='"+studentId+"' "+block+"> </td>");      
					}else
						out.println("<tr><td align='left' width='19'><input type='checkbox' name='studentids'  value='"+studentId+"'> </td>");      


				//}					//commented by rajesh
				//else{
				//	out.println("<tr><td align='left' width='19'><input type='checkbox' name='studentids'  value='"+studentId+"'> </td>");      
				//}


				out.println("<td align='left' width='244'><b><font face='Arial' size='2'>"+rs.getString("fname")+" "+rs.getString("lname")+"</font></b></td><td align='left' width='314'><font face='Arial' size='2'>"+rs.getString("con_emailid")+"</font></td>");
				if(!rs.getString("subsection_id").equals("nil")){
					out.println("<td align='left' width='244'><b><font face='Arial' size='2'>"+(String)hs.get(rs.getString("subsection_id"))+"</font></b></td></tr>");
				}else{
					out.println("<td align='left' width='244'><b><font face='Arial' size='2'>Default</font></b></td></tr>");
				}
				flag=true;
			}	

			if (!flag){
				out.println("<tr><td colspan=4><font size='2' face='arial'><b> Students are not available</b></font> </td></tr>");
			}

	
	
%>
<tr>
<td width="100%" colspan="4" bgcolor="#ffffff" align="center">		<p align="left">&nbsp;</td>
            </tr>
  
  		<tr><TD width="100%" colspan="4"> <p><img src="../../coursemgmt/images/studentslistfooter.gif" width="600" height="25" border="0"></p>
		</TD></tr>
            <tr>
<TD width="100%" colspan="4" height="37"> 		<p align="center"><input type="image"  TITLE="Done" src="../../coursemgmt/images/done.jpg" width="90" height="37">		</TD>
            </tr>
</table>
</center>
<input type="hidden" name="checked" value="">
<input type="hidden" name="unchecked" value="">
<font face=Arial size=2><%
}
catch(Exception e)
{
	ExceptionsFile.postException("StudentsList.jsp","Operations on database and reading parameters","Exception",e.getMessage());
	out.println(e);
}finally{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		
	}
	catch(Exception e)
	{  ExceptionsFile.postException("StudentsList.jsp","closing connections","Exception",e.getMessage());
		System.out.println("Error : Finallly  - "+e.getMessage()); }
}
%></font>
</form>
</html>
