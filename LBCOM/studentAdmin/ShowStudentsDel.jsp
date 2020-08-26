<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	Connection con=null;
	Statement st=null;
	ResultSet resultSet=null;
	String schoolid="",userid="",grade=""; 
%>

<html>
<head>
<title></title>
<script>
	function goPage(){
		var win=window.document.editUser;
		var userid=win.userid.value;
		var schoolid=win.schoolid.value;
		parent.location.href="AddEditUserpage.jsp?userid="+userid+"&schoolid="+schoolid;
	}
	function nextPage()
	{
		var field=window.document.editUser;
		var user=null;
		var school=field.schoolid.value;
		for(var i=0;i<field.elements.length;i++)
			if(field.elements[i].checked){
				user = field.elements[i].value;
				break;
			}
		if(user==null){
			alert("Select a student to delete");
			return false;
		}
		if(confirm('Are you sure..you want to delete this user'))							
			document.location.href="/LBCOM/studentAdmin.RegisterStudent?mode=delete&user="+user+"&school="+school;
		
		return false;
	}
</script>
</head>
<body topmargin=3 leftmargin="0" marginwidth="0">
<form name="editUser">
<table border="0" width="100%" cellspacing="1">

<tr>
    <td width="50%"></td>
    <td width="50%">
       <p align="right">
		<a href="javascript:goPage()"><b><font face="Verdana" size="2" style="color:blue;text-decoration:none"><img src="images/back.jpg" border=0></font></b></a></td>
            <td></td>
</tr>


<%
		schoolid=request.getParameter("schoolid");
		userid  =request.getParameter("userid");
		grade   =request.getParameter("grade");
			
		try{
			con=db.getConnection();
			st=con.createStatement();
			if(grade.equalsIgnoreCase("All")){
				//resultSet=db.execSQL("select username,fname,lname from studentprofile where schoolid='"+schoolid+"'");
				resultSet=st.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolid+"' and crossregister_flag < 3");
			}else{
				resultSet=st.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolid+"' and grade='"+grade+"' and crossregister_flag < 3");
			}
			if(resultSet.next()){%>
			<tr>      
				<td width="748" colSpan="3">        
	  			<p align="left"><font face="Arial Black" color="#FDC043">Students List</font></p>
				</td>
			</tr>  

			<tr>      
				<td width="748" colSpan="3">        
		  		<p align="left"><b><font face="Arial" size="2"><img src="images/listheader.gif" border="0" width="597" height="25"></font></b></p>
				</td>
			</tr>    
	
			<tr>     
				<td align="left" width="244"><b><font face="Arial" size="2" color="#000066">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User ID</font></b></td> <td align="left" width="314"><b><font face="Arial" size="2" color="#000066">Name</font></b></td>      
            <td></td>
			</tr>
	

				<%do{%>
					<tr><td align='left' width='19'>
					<b><font face="Arial" size="2"><input type="radio" name="username" value="<%=resultSet.getString("username")%>"><%=resultSet.getString("username")%>
					</font></b>
					</td>
					
	
					<td align='left' width='244'><b><font face="Arial" size="2"><%=resultSet.getString("fname")+"  "+resultSet.getString("lname")%></font></b></td>
            <td></td>
</tr>

					<%
				}while(resultSet.next());%>

				<tr>
					<td width="100%" colspan="3" bgcolor="#ffffff" align="center">		<p align="left">&nbsp;</td>
	            </tr>
  
  				<tr><TD width="100%" colspan="3"> <p><img src="images/listfooter.gif" width="600" height="25" border="0"></p>
				</TD></tr>
		
				<tr>
					<TD width="100%" colspan="3" height="37"><p align="center"><a href="" onclick="javascript:return nextPage();" ><input type="image"  TITLE="Edit" src="images/delete.jpg" width="90" height="37"></a></TD>
	            </tr>
</table>
			
		

		<%}else{%>
			<p align="center">&nbsp;<center><font face="Verdana" size="2"><b>presently no students are available</b></font></center>		<%}

		}catch(IOException ioe){
			ExceptionsFile.postException("ShowStudentDel.jsp","operations on database","IOException",ioe.getMessage());
			 System.out.println(ioe.getMessage());
		 }
		 catch(SQLException sqle){
			 ExceptionsFile.postException("ShowStudentDel.jsp","operations on database","SQLException",sqle.getMessage());
			 System.out.println(sqle.getMessage());
		 }
		 catch(Exception e){
			 ExceptionsFile.postException("ShowStudentDel.jsp","operations on database","Exception",e.getMessage());
			 System.out.println(e.getMessage());
		 }finally{
			try{
				if(con!=null)
					con.close();
				
			}catch(Exception se){
				ExceptionsFile.postException("ShowStudentsDel.jsp","closing statement and connection  objects","Exception",se.getMessage());
				System.out.println(se.getMessage());
			}
			

	   }
%>
<input type=hidden name="userid" value="<%= userid %>">
<input type=hidden name="schoolid" value="<%= schoolid %>">

</form>
</body>
</html>
