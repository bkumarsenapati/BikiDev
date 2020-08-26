<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	String schoolId="",courseId="",topicId="",topicDes="",mode="",courseName="",classId="",dispName="",className="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
    try {
			session=request.getSession();
			String s=(String)session.getAttribute("sessid");
			if(s==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			schoolId=(String)session.getAttribute("schoolid");
			courseId = request.getParameter("courseid");
			classId=   request.getParameter("classid");
			courseName=request.getParameter("coursename");
			className=request.getParameter("classname");
			System.out.println("May...in addedit..."+courseName);
			
			
			mode = request.getParameter("mode");
			topicId = request.getParameter("topicid");
			System.out.println("courseName...in addedit..."+mode+"..topicId.."+topicId);

			con=db.getConnection();
			st=con.createStatement();
			System.out.println("courseName...in addedit..."+mode+"..topicIdddddddddd.."+topicId);

					
			if (mode.equals("add")) {
				dispName="Add Topic";
				topicId="";
				topicDes="";
			}else {
				dispName="EditTopic";
				rs = st.executeQuery("select topic_des from topic_master where topic_id='"+topicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				if (rs.next()) 
					topicDes=rs.getString("topic_des");
				
			}
			System.out.println("courseName...in addedit..."+mode+"..topicId.."+topicId);
    }
	catch(Exception e) {
			ExceptionsFile.postException("AddEditTopic.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
			System.out.println("Error in AddEditTopic is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditTopic.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" src='../../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{

	var tdesc=trim(document.AddEditTopics.topicdesc.value);

	if(tdesc==''){
		alert("Topic name should be entered.");
		document.AddEditTopics.topicdesc.focus();
		return false;
	}
replacequotes();

//
	 $(document).ready(function(){
		 
		var cName="<%=courseName%>";
		 cName=cName.replace(/ /g,"+");
          
            $('#AddEditTopics').ajaxForm(function(data) { 
               
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("grids/DisplayTopics.jsp?coursename="+cName+"&courseid=<%=courseId%>&classid=<%=classId%>&classname=<%=className%>", hideLoading);
            }); 
        }); 

	//

//document.location.href="/LBCOM/coursemgmt.AddEditTopic?coursename=<%=courseName%>&courseid=<%=courseId%>&classid=<%=classId%>&mode=<%=mode%>&topicdesc="+tdesc+"&topicid="+tid;
	//document.location.href="/LBCOM/coursemgmt.AddEditTopic?coursename=<%=courseName%>&courseid=<%=courseId%>&classid=<%=classId%>&mode=<%=mode%>&topicdesc="+tdesc+"&topicid="+tid;
	
}
//-->

</SCRIPT>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
<script src="http://malsup.github.com/jquery.form.js"></script> 
</head>
<form name="AddEditTopics" id="AddEditTopics" action="/LBCOM/coursemgmt.AddEditTopic?coursename=<%=courseName%>&courseid=<%=courseId%>&classid=<%=classId%>&mode=<%=mode%>&classname=<%=className%>" method="post" onsubmit="return validate();">
<table border="0" width="100%" cellspacing="1">
  <tr>
    <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080" face="Arial" size=2><a href="CoursesList.jsp">Courses</a> &gt;&gt <a href="DropBox.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId %>&classname=<%=className%>"><%=courseName %></a> &gt;&gt; <%=className %> &gt;&gt; <a href="DisplayTopics.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>">Topics</a> &gt;&gt <font color=black> <%=dispName%></span></font></font></td>
  </tr>
</table>
<center><br>
  <table align=center width=491 border="0" height="192" cellspacing="1">
    <tr> 
      <td colspan=2 width="481" height="13"> 
      </td>
    </tr>
    <tr> 
      <td colspan=2 bgcolor="#40A0E0" width="481" height="13"> 
        <div align="center"><b><font face="Arial" color="#FFFFFF" size="3">Add/Edit
          Topic</font></b></div>
      </td>
    </tr>
   <tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">Topic Name :</font></div>
      </td>
      <td width="303" height="67"> 
        <font face="Arial" size="2"> 
		<input type='text' name='topicdesc' value="<%=topicDes%>" size='28'  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)"></font>
		<input type='hidden' name='topicid' value="<%=topicId%>">	
      </td>
    </tr>
  
  <tr><td colspan=2 align=center width="481" height="1" bgcolor="#42A2E7">&nbsp;</td></tr>
<tr><td colspan=2 align=right width="481" height="47">
    <p align="center"><input type="image" src="../../coursemgmt/images/submit.jpg">
	
</td>
</tr>
</table>
<p></p>
		<p>
	
</center>
</form>
</html>