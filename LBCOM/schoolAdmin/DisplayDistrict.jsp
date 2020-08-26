<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />


<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",mode="",classId="",classDes="";
%>
<% 
	try
	{

		schoolId=request.getParameter("schoolid");
		con=db.getConnection();
		st=con.createStatement();
		rs = st.executeQuery("select dist_id,dist_desc from dist_master where school_id='"+schoolId+"' order by dist_id");
	}
	catch(Exception e) {
		ExceptionsFile.postException("DisplayDistrict.jsp","Operations on database ","Exception",e.getMessage());
		System.out.println("Error in DisplayDistrict is "+e);
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
		document.location.href = "AddEditDistrict.jsp?schoolid=<%=schoolId%>&mode="+field;
	else 
	{
		var c=0;
		var classId;
		var len = window.document.DispClasses.elements.length;
		if(len==0){
			alert("There are no districts");
			return false;
		}
	
		for(var i=0;i<len;i++)
		{
			if(window.document.DispClasses.elements[i].checked==true)
			{
				distId = window.document.DispClasses.elements[i].value;
				c=1;
			}
		}
		if(c==0)
		{ 
			  alert("Please select a district.");
			  return false;
		}
		if(field=='edit'){
			document.location.href = "AddEditDistrict.jsp?schoolid=<%=schoolId%>&mode="+field+"&distid="+distId;
		}
		else if(field=='delete')
		{
			if(confirm('Are you sure you want to delete the District ID?')) {
				document.location.href = "/LBCOM/schoolAdmin.AddEditDistrict?schoolid=<%=schoolId%>&mode="+field+"&distid="+distId;
		    }
		}
		else if(field=='manage')
		{

			document.location.href = "/LBCOM/schoolAdmin/DisplayStudents.jsp?schoolid=<%=schoolId%>&mode=all&distid="+distId;
		}
		//return false;
	}	
	return false;
}
//-->
</SCRIPT>
</head>
<body topmargin='3' leftmargin='3'>
<form name="DispClasses">
<p align="right"><img src="images/back.jpg" onclick="history.go(-1);return false;"></p>
<center>
<div align="center">
  <center>
  <br><br>
	<table width="500" height="130" cellspacing="0" cellpadding="0">
	
	<tr><td width="300"><font face="arial" size="3"><b>List of District</b></font>
		
	</td></tr>
	
	<tr><td width="300" height="20" ><img border="0" src="images/listheader.gif" width="597" height="26" >
		</td></tr>
		


<%

		boolean flag=false;
	try{
		while(rs.next()){
			out.println("<tr><td width='300' align='left'>");
			out.println("<input type='radio' name='topic' value='"+rs.getString("dist_id")+"'><font face='Arial' size='2'>"+rs.getString("dist_desc")+"</td></tr>");
			flag=true;
		} 

		if(flag==false){
			out.println("<tr><td width='300' align='center' height='50'>");
			out.println("<font face='Arial' size='3' color='red'>No district is added yet. </font></td></tr>");
		}
	}catch(Exception e){
	   ExceptionsFile.postException("DisplayDistrict.jsp","Operations on database" ,"Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
   }finally{
		try{
			if(con!=null)
				con.close();
			
		}catch(Exception se){
			ExceptionsFile.postException("DisplayDistrict.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }

%>


	<tr>
	<td width="300" align="center" height="20">
    <p align="left">
    <font face="Arial" size="2">
	<img border="0" src="images/listfooter.gif">
    </font>
    </p>
	</td></tr>


	<tr>
	<td align="center" height="47">
    <p align="center">
        <font face="Arial" size="2">
		<a href="javascript:nextPage('add');"><img src='images/add.jpg' border='0'></a>
		<a href="" onclick="javascript:return nextPage('edit');" target="_self"><img src='images/edit.jpg' border='0'></a>
		<a href="javascript://" onclick="return nextPage('delete');"><img src='images/delete.jpg' border='0'></a>
		<a href="javascript://" onclick="return nextPage('manage');">Select to Student(s)</a>
        </font>
	</td></tr>
	</table>
</div>
 
</form>
</center>
</body>
</html>
