

<%@page language="Java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<% 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",classId="";
	try
	{
		session=request.getSession();

		String s=(String)session.getAttribute("sessid");
		if(s==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		classId = request.getParameter("classid");
		
		con=db.getConnection();
		st=con.createStatement();
		
		rs =st.executeQuery("select subsection_id,subsection_des from subsection_tbl where  class_id='"+classId+"' and school_id='"+schoolId+"' order by subsection_des");

	}
	catch(Exception e) {
		ExceptionsFile.postException("DisplaySubsections.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Error in DisplaySubsections is "+e);
	}

	

%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function nextPage(field)
{
	if(field=='add')
		document.location.href = "AddEditSubsection.jsp?mode="+field+"&classid=<%=classId%>";

	else 
	{
		var c=0;
		var subtopicid;
		var len = window.document.Displaysubsections.elements.length;
		if(len==0){
			alert("There are no Sections ");
			return false;
		}
	
		for(var i=0;i<len;i++)
		{
			if(window.document.Displaysubsections.elements[i].checked)
			{
				subsectionid = window.document.Displaysubsections.elements[i].value;
				c=1;
			}
		}
		if(c==0)
		{ 
			  alert("Select a Section");
			  return false;
		}
		if(field=='edit'){
			document.location.href = "AddEditSubsection.jsp?mode="+field+"&classid=<%=classId%>&subsectionid="+subsectionid;		}
		else if(field=='delete')
			if(confirm('Are you sure? You want to delete the sub topic.')) {
				document.location.href = "/LBCOM/subsection?mode="+field+"&classid=<%=classId%>&subsectionid="+subsectionid;

		    }
		return false;
	}	
	return false;
}
//-->
</SCRIPT>
</head>
<body topmargin='3' leftmargin='3'>
<form name="Displaysubsections">
<div align="center">
  <center>
  <br><br>
	<table width="500" height="130" cellspacing="0" cellpadding="0">
	
	<tr><td width="300"  >
		<img border="0" src="/LBCOM/schoolAdmin/images/listofcourses.gif">
	</td></tr>
	
	<tr><td width="300" height="20" ><img border="0" src="/LBCOM/schoolAdmin/images/listheader.gif" width="597" height="26" >
		</td></tr>

		


<%
    try{
		boolean flag=false;
		while(rs.next()){
			out.println("<tr><td width='300' align='left'>");
			out.println("<input type='radio' name='subsection' value='"+rs.getString("subsection_id")+"'>"+rs.getString("subsection_des")+"</td></tr>");
			flag=true;
		} 

		if(flag==false){
			if(classId.equals("None")){
				out.println("<tr><td width='300' align='center' height='50'>");
				out.println("<font face='Arial' size='3' color='red'>Select a class from the above list. </font></td></tr>");

			}else{
			out.println("<tr><td width='300' align='center' height='50'>");
			out.println("<font face='Arial' size='3' color='red'>Sections are not available. </font></td></tr>");
			}
		}
   }catch(Exception e){
		ExceptionsFile.postException("DisplaySubsections.jsp","reterving data from resultset","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				db.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("DisplaySubsections.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>


	<tr>
	<td width="300" align="center" height="20">
    <p align="left">
    <font face="Arial" size="2">
	<img border="0" src="/LBCOM/schoolAdmin/images/listfooter.gif">
    </font>
    </p>
	</td></tr>


	<tr>
	<td align="center" height="47">
    <p align="center">
        <font face="Arial" size="2">
		<a href="javascript:nextPage('add');"><img src='/LBCOM/schoolAdmin/images/add.jpg' border='0'></a>
		<a href="" onclick="javascript:return nextPage('edit');" target="_self"><img src='/LBCOM/schoolAdmin/images/edit.jpg' border='0'></a>
		<a href="javascript://" onclick="return nextPage('delete');"><img src='/LBCOM/schoolAdmin/images/delete.jpg' border='0'></a>
        </font>
	</td></tr>
	</table>
</div>
 
</form>
</center>
</body>
</html>