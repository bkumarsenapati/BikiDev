<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%@ include file="/common/checksession.jsp" %>
<%
	Connection connection = null;
	Statement statement = null,statement1=null;
	ResultSet rs = null,rs1=null;
	String mode,cId;
	try
	{
		mode=request.getParameter("mode");
		cId=request.getParameter("id");
		connection=con1.getConnection();
		statement = connection.createStatement();
		statement1= connection.createStatement();
		if(mode==null)
		{
			mode="";
		}
%>

<html>
<head>
<title> AddEditCourse </title>
<LINK href="images/style.css" type=text/css rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JavaScript" SRC="validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function validate(sform)
{
	if(sform.cname.value=="")
	{
		alert("Please enter course name");
		sform.cname.focus();
		return false;
	}
	else if(sform.cname.value.length<3||sform.cname.value.length>35)
	{
		alert("name must be between 3 to 35  characters");
	    sform.cname.focus();
	    return false;
	}
    if(sform.cdesc.value=="")
	{
		alert("Please enter description");
		sform.cdesc.focus();
		return false;
	}
    if(sform.cost.value=="")
	{
		alert("Please enter cost");
		sform.cost.focus();
		return false;
	}
	else if (isNaN(sform.cost.value)) 
	{
		alert("Please enter only numbers for cost");
		sform.cost.focus();
		return false;
	}
}
</SCRIPT>
</head>
<body>
<form name="courseform" method="post" action="/LBCOM/lbadmin.AddEditCourse?mode=<%= mode%>&courseId=<%= cId%>" onsubmit="return validate(this);" enctype="multipart/form-data">

<hr>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
<tr>
	<td width="25%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="25%">
    <p align="right"><b><font face="Verdana" size="2"><a href="javascript:history.back(-1);">BACK</a></font></b></td>
  </tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
   <td width="20%" height="329">&nbsp;</td>
   <td width="60%" height="329">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="119">
     <TBODY>
      <TR class=mainhead>
       <TD class=mainhead width=588 colSpan=2 height=24><P align=left> <b>Add / 
       Edit Course :</b></P>
       </TD>
      </TR>
<% 
    if(mode.equals("add"))
	{
%>
      <TR class=td>
       <TD class=tdleft align=right height="21">Course Name:</td>
       <TD height="21"><input type="text" name="cname" size="20"></td>
      </tr>
      <TR class=td>
       <TD class=tdleft align=right height="21">Description:</td> <td>
       <textarea name="cdesc" rows="3" cols="22"> </textarea></td>
      </tr>
      <TR class=td>
	<TD class=tdleft align=right height="21">Category:</td>    <TD height="21"><select name="category">
	  <option>---select subject---</option>
<%
	rs1=statement1.executeQuery("select distinct category_name from lb_categories order by category_name");
	while(rs1.next())
	  {
%>
	 <option><%= rs1.getString("category_name")%></option>
<%
	  }
%>
	 </select></td>
       </tr>
       <TR class=td>
	 <TD class=tdleft align=right height="21">Cost:</td>       <TD height="21"><input type="text" name="cost" size="20"> </td>
       </tr>
       <TR class=td>
	 <TD class=tdleft align=right height="21">Select an image to upload:</td><TD height="21"><input type="file" name="fname" size="20"></td>
       </tr>
       <TR class=td>
	 <TD class=tdleft align=right height="21">Status:</td> 
         <TD height="21"><select name="status">
            <option selected>active</option>
	    <option>inactive</option></select>
	 </td>
      </tr>

<%
	}
    else
	{
		String c_name,c_desc,c_cost,c_image,c_status,c_category;
		rs=statement.executeQuery("select * from lb_course_catalog where course_id='"+cId+"'");
		while(rs.next())
        {
			c_name=rs.getString("title");
			System.out.println("title is..."+c_name);
			c_category=rs.getString("category");
			c_desc=rs.getString("description");
			c_cost=rs.getString("cost");
			c_image=rs.getString("image_path");
			c_status=rs.getString("status");
%>
     <TR class=td>
      <TD class=tdleft align=right height="21">Course Name:</td>
      <TD height="21"><input type="text" name="cname" value="<%= c_name%>" size="20" ></td>
     </tr>
     <TR class=td>
      <TD class=tdleft align=right height="21">Description:</td>
      <td><textarea type="text" name="cdesc" rows="3" cols="23"><%= c_desc%></textarea></td>
     </tr>
    <TR class=td>
     <TD class=tdleft align=right height="21">Category:</td><TD height="21">
	<select name="category">
	 <option><%=c_category%></option>

<%
			rs1=statement1.executeQuery("select distinct category_name from lb_categories order by category_name");
			while(rs1.next())
			{
				if(!rs1.getString("category_name").equals(c_category))
				{
%>
					<option><%=rs1.getString("category_name")%></option>
<%
				}
          }
%>
	</select></td>
     </tr>
     <TR class=td>
       <TD class=tdleft align=right height="21">Cost:</td><TD height="21">
       <input type="text" name="cost" value=<%= c_cost%> size="20"></td>
     </tr>
     <TR class=td>
       <TD class=tdleft align=right height="21">Uploaded file:</td><TD height="21"><font color="red"><b><%= c_image%></b></font></td>
     </tr>
     <TR class=td>
       <TD class=tdleft align=right height="21">Select an image to upload:</td><TD height="21">
       <input type="file" name="fname" value=<%= c_image%> size="20"></td>
     </tr>
     <TR class=td>
       <TD class=tdleft align=right height="21">Status:</td><TD height="21"><select name="status"><option selected>active</option>
       <option >inactive</option></select>
	 </td>
     </tr>
<% 
			}
   		}
	}
	catch(Exception e)
  {
	  ExceptionsFile.postException("AddEditCourse.jsp","operations on database","Exception",e.getMessage());	 
      System.out.println("Error in AddEditCourse.jsp:---" + e.getMessage());
  }

  finally{     //closes the database connections at the end
		try{
			if(rs1!=null)
				rs1.close();
			if(rs!=null)
				rs.close();
			if(statement!=null)
				statement.close();
			if(statement1!=null)
				statement1.close();
			if(connection!=null && !connection.isClosed())
				connection.close();
		}
               catch(SQLException se){
			ExceptionsFile.postException("AddEditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Exception in AddEditCourse.jsp...."+se.getMessage());
		}
	}
%>
       <TR class=td>
        <TD width=588 colSpan=2 height=37>
        <P align=center><INPUT type=submit value="Add Course" name=submit></P></TD></TR>
      </TBODY>
     </TABLE>
    </td>
    <td width="20%" height="329">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" colspan="3">&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>