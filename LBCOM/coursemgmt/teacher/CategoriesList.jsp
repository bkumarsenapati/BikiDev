<!--Lists the courses that are created by a particular teacher   -->


<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseId="",category="",type="",itemId="",itemDes="",percentage="",status="",typeName="",schoolId="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;
boolean flag=false;
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
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
	type=request.getParameter("type");

	con=con1.getConnection();
	st=con.createStatement();

		
	if(type.equals("CM")){
		typeName="Course material";
	
	}
	if(type.equals("AS")){
		typeName="Assignment";
		
	}
	if(type.equals("EX")){
		typeName="Assessment";
		
	}
	if(type.equals("CO")){
		typeName="Course outline";
		
	}
	
	rs=st.executeQuery("select * from category_item_master where category_type='"+type+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");


%>

<html>
<head>
<title></title>

</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="5" leftmargin="5">
<form name="categorieslist">

<div align="center">
  <center>

<table border="1" width="616" cellspacing="0" bordercolordark="#FFFFFF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="71" bordercolorlight="#FFFFFF">
<tr >
	<!--<td width="511" height="15" colspan="6">
    <img src="../images/listofcourses.gif" width="151" height="28" border="0"></td>-->
	<td width="614" align="center" bgcolor="#C2CCE0" colspan="4" height="24"><b><font face="arial" size="2" color="#800080"><%=typeName%> categories</font></b></td>
</tr>
<tr>
    <td width="22" height="22" bgcolor="#CECBCE"></td>
	<td width="25" height="22" bgcolor="#CECBCE"></td>
    <td width="419" height="22" bgcolor="#CECBCE">
    <span style="font-size:10pt;"><font face="Arial" color="#000080"><b>Category Description</b></font></span></td>
    <td width="145" height="22" bgcolor="#CECBCE">
    <p align="center"><font face="Arial" color="#000080"><b><span style="font-size: 10pt">Percentage</span></b></font></td>

</tr>

	<% while(rs.next()){ 
				itemDes=rs.getString("item_des");
				itemId=rs.getString("item_id");
				percentage=rs.getString("weightage");
				status=rs.getString("status");
	 %>

	<tr>
        <td width="22" height="25" bgcolor="#E7E7E7">
			<p align="center"><a href="#" onclick="deleteCategory('<%=itemId%>','<%=status%>')"><img border="0" src="../images/idelete.gif" width="16" height="19" TITLE="Delete Category"></a></p>
        </td>
		<td width="25" height="25" bgcolor="#E7E7E7">
			<p align="center"><a href="#" onclick="editCategory('<%=itemId%>')"><img border="0" src="../images/iedit.gif" width="16" height="19" TITLE="Edit Category"></a></p>
        </td>
        <td width="419" height="25" bgcolor="#E7E7E7">
			<p><span style="font-size:10pt;"><font face="Arial"><%= itemDes %></font></span></p>
        </td>
        <td width="145" height="25" bgcolor="#E7E7E7">           
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><%=percentage%></font></span></p>
        </td>
       
        
    </tr>

	<% 
		flag=true;
	} 
		if (!flag){
				out.println("<tr><td width='100%' colspan='11' height='21' align='center' bgcolor='#E7E7E7'><font face='Arial' color='#000000' size='2'>Categories are not created yet.</font> </td></tr>");			
		}	

	
	}	
	catch(SQLException se){
		ExceptionsFile.postException("CategoriesList.jsp","Operations on database and reading  parameters","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("CategoriesList.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());

	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CategoriesList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
</table>
  </center>
</div>
<!--<table>
  <tr>
	<td width="23" height="19">  <a href="AddCategoryItem.jsp?mode=add&type=<%=type%>"><img border="0" src="../images/create.gif"  align="left" TITLE="Create Category"></a>&nbsp;</td>
	<td width="490" height="19">  <font face="verdana" size="2">Click here to create a new category. </font></td>
	<td width="473" height="19">&nbsp;</td>
  </tr>
</table>-->
</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function editCategory(itemid){
		parent.bottompanel.location.href="EditCategoryItem.jsp?mode=edit&itemid="+itemid+"&cat=<%=type%>";
	}
	function deleteCategory(itemid,status){
		if(status>0){
			alert("Already files exist in this category");
			return false;
		}else{
			if(confirm("Are you sure? You want to delete the category.")==true){				       parent.bottompanel.location.href="/LBCOM/coursemgmt.AddCategoryItem?mode=del&type=<%=type%>&itemid="+itemid;
			}else
			return;
		}
	}

//-->
</SCRIPT>
</html>
