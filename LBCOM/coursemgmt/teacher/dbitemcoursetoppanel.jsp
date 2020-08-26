<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String courseId="",courseName="",mode="",type="",flage="",schoolId="";
%>
<%
	try{
	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	courseId=(String)session.getAttribute("courseid");
    schoolId=(String)session.getAttribute("schoolid"); 
	con=con1.getConnection();
	st=con.createStatement();

	type=request.getParameter("type");
	flage=request.getParameter("flage");

	System.out.println("select * from category_item_master where category_type='"+type+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
	
	rs=st.executeQuery("select * from category_item_master where category_type='"+type+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title></title>
<base target="main">

<script language="javascript" >

	function go(tag,idxTag){
		
		var cat=document.leftpanel.asgncategory.value;
		
		
			if (tag=="C"){
				if (cat=="all"){
					alert("Select category");
					return false;
				}if (cat=="add"){
				    parent.bottompanel.location.href="AddCategoryItem.jsp?mode=add&type=<%=type%>";
					return false;
				}
				else {
				   parent.bottompanel.location.href="CreateCourseWork.jsp?workid=&cat="+cat+"&type=<%=type%>";
					return false;
				}
			}else if(tag=="L"){
				if(cat=="add"){
					parent.bottompanel.location.href="CategoriesList.jsp?type=<%=type%>";
					return false;
				}else {					  				  
				    
					parent.bottompanel.location.href="CoursesDocList.jsp?totrecords=&start=0&cat="+cat+"&type=<%=type%>&tag="+idxTag;				
					return false;
		       }
		   }
}
</script>


</head>
<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>
<body topmargin=2 leftmargin=0>

<form name="leftpanel" action="--WEBBOT-SELF--" method="POST">
  <div align="center">
    <center>
  <table border="1" width="100%" cellspacing="0" bordercolordark="#BBB6B6" height="8">
    <tr >
      <td class="topbar1" ><b>
	  <select name="asgncategory" onChange="go('L',true);return false;">
	    <option value="all" >.....All.....</option>
    <%	while(rs.next()) {
		    out.println("<option value="+rs.getString("item_id")+">"+rs.getString("item_des")+"</option>");
        }			
	 %>	
	 <!-- <option value="add">...Add / Modify...</option> -->
	 </select>
	  
	  <%
		  if(flage==null){
			if (type.equals("CO")){%>
				<!-- <script>document.leftpanel.asgncategory.value='WC'; go('L',true);</script> -->
				<script>document.leftpanel.asgncategory.value='SD'; go('L',true);</script>
		    <%}
	     }else if (flage.equals("true")){%>
				<script>document.leftpanel.asgncategory.value='add';</script>

	     <%}
}catch(Exception e){
		ExceptionsFile.postException("dbitemcoursetoppanel.jsp","operations on database","Exception",e.getMessage());
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("dbitemcoursetoppanel.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

}
%>	  
      </b></td>
      <td width="527" class="topbar1"><a href="#" onClick="return go('C',false);">Create</a></td>
      <td width="238" class="topbar1" ><a href="#" onClick="return go('L',false)">List</a></td>
    </tr>
  </table>
    </center>
  </div>
</form>

</body>
</html>
