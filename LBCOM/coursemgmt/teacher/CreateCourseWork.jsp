<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
  Connection con=null;
  Statement st=null;
  ResultSet rs=null;	
  String cat="",mode="",workId="",courseId="",type="",schoolId="";
%>

<%
 try{
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
    cat=request.getParameter("cat");
	type=request.getParameter("type");
	
	con=con1.getConnection();
	st=con.createStatement();

%>
<html>
<head>
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title></title>
 <script language="javascript" src="../../validationscripts.js"></script> 
<%
    
	out.println("<script>\n");  
	
	out.println("var topic=new Array();\n");

	rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
	out.println("</script>\n");

}catch(SQLException e){
		ExceptionsFile.postException("CreateCourseWork.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		System.out.println("The Error: SQL - "+e.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CreateCourseWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}catch(Exception e){
		ExceptionsFile.postException("CreateCourseWork.jsp","operations on database","Exception",e.getMessage());
   }
%>

<script>
function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}

/*function mainmenu()
{
	window.location.href="../coursewaremanager/FolderList.jsp";
	return false;
}*/
function checkfields()
{
if(trim(window.document.f1.documentname.value)=="")
{
alert("Enter Document Name");
window.document.f1.documentname.focus();
return false;
} replacequotes();
}
function cleardata(){
		document.f1.reset();
		return false;
}

function getsubids(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<topic.length;i++){
			if(topic[i][0]==id){
				document.f1.subtopic[j]=new Option(topic[i][2],topic[i][1]);
				j=j+1;
			}
		} 
		if (j==1)
			document.f1.subtopic[j]=new Option("No Subtopics","");
}

function clear() {
		var i;
		var temp=document.f1.subtopic;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
}

</script>





</head>

<body>
<form name=f1 method="post" action="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=add&newfoldername=&oldfoldername=" onSubmit="return checkfields();">
<!--<form name="f1" method="post" action="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=add&newfoldername=&oldfoldername=" onSubmit="return checkfields();">-->

<center>

<table borderColor="#BBB6B6"  border="0" cellspacing="0" width="591" cellpadding="0" height="250">

<tr >
<td class="gridhdr">Create/Edit </td>
<td colspan="3" ></td>
</tr>


<tr>
<td class="gridhdr" colspan="3">&nbsp;</td>
</tr>


<tr>
<td width="193" align="right" height="25"><b><font size=2 face="Arial" color="#453F3F">Document Name</font></b></td>
<td width="7" height="25"><font face="Arial" size="2"><b>:</b></font></td>
<td width="394" height="25"><font face="Arial" size="2"><input type=text name="documentname"  maxlength="50"></font></td>
</tr>


<!--<tr>
<td width="193" align="right" height="25"><b><font face="Arial" size="2">Document Description</font></b></td>
<td width="7" height="25"><font face="Arial" size="2"><b>:</b></font></td>
<td width="394" height="25"><font face="Arial" size="2"><textarea name="documentdesc" rows="2" cols="38"></textarea></font></td>
</tr>-->

<tr>
<td width="193" align="right" height="25"><b><font face="Arial" size="2" color="#453F3F">Topic</font></b></td>
<td width="7" height="25"><font face="Arial" size="2"><b>:</b></font></td>
<td width="394" height="25"><font face="Arial" size="2"><select id="topic_id" name="topic" onChange="getsubids(this.value);">
    <option value="" selected>Select</option>
	<%
  try{
	rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
    while (rs.next()) {
		out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		
	}
  }catch(Exception e){
		ExceptionsFile.postException("CreateCourseWork.jsp","reterving from resultset","Exception",e.getMessage());
  }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CreateCourseWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	%>	
	</select></font></td>
</tr>
<tr>
<td width="193" align="right" height="25"><b><font face="Arial" size="2" color="#453F3F">Subtopic</font></b></td>
<td width="7" height="25"><font face="Arial" size="2"><b>:</b></font></td>
<td width="394" height="25"><font face="Arial" size="2"><select id='subtopic_id' name='subtopic'>
	  <option value="" selected>Select</option></select>	</font></td>
</tr>
<td width="193" align="right" height="25"><b><font face="Arial" size="2" color="#453F3F">Comments</font></b></td>
<td width="7" height="25"><font face="Arial" size="2"><b>:</b></font></td>
<td width="394" height="25"><font face="Arial" size="2"><input type="text" name="comments"></font></td>

<tr ><td colspan=3 class="gridhdr">&nbsp;</td></tr>
<tr><td colspan=3 width="606" align="center"><font face="Arial" size="2"><input type=image src="../images/submit.gif" width="88" height="33" name="I1">
<input type="image" onClick="return cleardata()" src="../images/reset.gif" name="I2"></font></td></tr>
<input type="hidden" name="cat" value="<%=cat%>">
<input type="hidden" name="type" value="<%=type%>">
</table>
</center>
</form>
</body>
</html>
