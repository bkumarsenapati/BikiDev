<%@ page import="java.io.*,java.sql.*,java.util.Date,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
    
	String categoryId="",linkStr="",schoolId="",teacherId="",courseName="",sectionId="",url="",type="";
	String documentName="",documentDes="",topic="",subTopic="",comments="",newTeacherId="",courseId="";
	Date createdDate=new Date();
    String cat="",mode="",workId="";
%>

<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
   schoolId=(String)session.getAttribute("schoolid");
   courseId=(String)session.getAttribute("courseid");
   cat=request.getParameter("cat");
   type=request.getParameter("type");
  
   try
		{		
			con=con1.getConnection();
		    st=con.createStatement();
			workId=request.getParameter("workid");			
			rs=st.executeQuery("select * from course_docs where work_id='"+workId+"' and school_id='"+schoolId+"'");
			if (rs.next()) {
			      documentName= rs.getString("doc_name");
				  topic=rs.getString("topic");
				  subTopic=rs.getString("sub_topic");
				  createdDate=rs.getDate("created_date");
				  comments=rs.getString("comments");
			}
		}catch(SQLException e)
		{
			ExceptionsFile.postException("EditCourseWork.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("EditCourseWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}catch(Exception e){
			ExceptionsFile.postException("editCourseWork.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
			System.out.println("The error is :"+e);
			e.printStackTrace();
		}
%>

<html>
<head>
<title></title>
<script language="javascript" src="../../validationscripts.js"></script> 
<script>
var topic=new Array();
<%
	rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
%>

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


function checkfields()
{
if(trim(window.document.f1.documentname.value)=="")
{
alert("Enter Document Name");
return false;
}
 replacequotes();
}

function cleardata(){	
	document.f1.reset();
	init();
	return false;
}

function getsubids(id,subid) {
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
<form name="f1" method="post" action="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=edit&newfoldername=&oldfoldername="  onSubmit="return checkfields();">
<BR><BR>
<center>
<table borderColor="#000000" border="0" cellspacing="0" cellpadding="0" width="500" >

<tr>
<td colspan="3"><img border="0" src="../images/createtab.gif" width="151" height="28"> </td>
</tr>


<tr>
<td colspan="3"><img border="0" src="../images/studentslistheader.gif" width="597" height="25"> </td>
</tr>


<tr>
<td align="right"><b><font size=2 face="Arial">Document Name</font></b></td>
<td><b><font face="Arial" size="2">:</font></b></td>
<td><font face="Arial" size="2"><input type=text name="documentname"  maxlength="25" value="<%=documentName%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" ></font></td>
</tr>
<tr>
<td align="right"><font face="Arial" size="2"><b>Topic</b></font></td>
<td><b><font face="Arial" size="2">:</font></b></td>
<td><font face="Arial" size="2"><select id="topic_id" name="topic" onchange="getsubids(this.value);">
    <option value="" selected>Select</option>
	<%rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
  try{
    while (rs.next()) {
			out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
	}
  }catch(Exception e){
		ExceptionsFile.postException("editCourseWork.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("editCourseWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	%>	</font></td>
</tr>
<tr>
<td align="right"><font face="Arial" size="2"><b>Subtopic</b></font></td>
<td><b><font face="Arial" size="2">:</font></b></td>
<td><font face="Arial" size="2"><select id='subtopic_id' name='subtopic'>
	  <option value="" selected>Select</option></select></font></td>
</tr>
<td align="right"><font face="Arial" size="2"><b>Comments</b></font></td>
<td><b><font face="Arial" size="2">:</font></b></td>
<td><font face="Arial" size="2"><input type="text" name="comments" value="<%=comments%>"></font></td>

<tr><td colspan=3><img border="0" src="../images/studentslistfooter.gif" width="600" height="25"></td></tr>
<tr><td colspan=3 height="30">
    <p align="center"><font face="Arial" size="2"><input type="image" src="../images/submit.gif" width="88" height="33" name="I2">
	<input type="image" onClick="return cleardata()" src="../images/reset.gif" name="I2"></font></p>
  </td></tr>
<input type="hidden" name="cat" value="<%=cat%>">
<input type="hidden" name="workid" value="<%=workId%>">
<input type="hidden" name="type" value="<%=type%>">

</table>
</center>
</form>
</body>
<script>
function init(){
document.f1.topic.value="<%=topic%>";
getsubids('<%=topic%>');
document.f1.subtopic.value="<%=subTopic%>";
}
init();

</script>
</html>
