<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	Connection con=null;
	Statement st=null;
	ResultSet resultSet=null;
	String schoolid="",userid=""; 
%>

<html>

<script>
	function goPage(){
		var win=window.document.editUser;
		var userid=win.userid.value;
		var schoolid=win.schoolid.value;
		document.location.href="../schoolAdmin/AddEditUserpage.jsp?userid="+userid+"&schoolid="+schoolid;
	}
	function nextPage()
	{
		
		var user=null;
		var c=0;
		var len = window.document.editUser.elements.length;

		for(var i=0;i<len;i++)
		{
			if(window.document.editUser.elements[i].checked)
			{
				user = window.document.editUser.elements[i].value;
				c=1;
			}
		}

		if(c==0)
		{ 
			alert("Please select a Teacher");
			return false;
		}
		window.location.href="../teacherAdmin/modifyTeacherReg.jsp?mode=admodify&user="+user;

		return false;
	}
	
</script>

<body topmargin=3 leftmargin="0" marginwidth="0">
<form name="editUser">

<div align="center">
  <center>

<table border="0" width="700" cellspacing="1" valign="center">

<tr>
    <td width="100%" colspan="2" align="right"></td>
</center>
            <td>
              <p align="right">
		<a href="javascript:goPage()"><b><font face="Verdana" size="2" style="color:blue;text-decoration:none"><img src="images/back.jpg" border=0></font></b></a></td>
</tr>


  <center>


<%
		schoolid=request.getParameter("schoolid");
		userid  =request.getParameter("userid");
		session=request.getSession(true);
		session.putValue("schoolid",schoolid);
					
		try
		{   con=db.getConnection();
			st=con.createStatement();
			//resultSet=db.execSQL("select email,username,firstname,lastname from teachprofile where schoolid='"+schoolid+"'");
			resultSet=st.executeQuery("select email,username,firstname,lastname from teachprofile where schoolid='"+schoolid+"'");
			if(resultSet.next())
			{
%>
			<tr>      
				<td width="748" colSpan="3">        
	  			<font face="Arial Black"> <b>Teachers list</b></font></p>
				</td>
			</tr>  

			<tr>      
				<td width="100%" colSpan="3">        
		  		<p align="left"><b><font face="Arial" size="2"><img src="images/listheader.gif" border="0" width="597" height="25"></font></b></p>
				</td>
			</tr>    
	
			<tr>     
				<td align="left" width="100%"><b><font face="Arial" size="2" color="#000066">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User ID</font></b></td> <td align="left" width="100%"><b><font face="Arial" size="2" color="#000066">Name</font></b></td>      
            <td width="100%"></td>
			</tr>
	

<%				do
				{
%>
					<tr><td align='left' width='100%'>
					<b><font face="Arial" size="2"><input type="radio" name="username" value="<%=resultSet.getString("username")%>"><%=resultSet.getString("username")%>
					</font></b>
					</td>
					
	
					<td align='left' width='100%'><b><font face="Arial" size="2"><%=resultSet.getString("firstname")+"  "+resultSet.getString("lastname")%></font></b></td>
            <td width="100%"></td>
</tr>

<%
				}while(resultSet.next());
%>

				<tr>
					<td width="100%" colspan="3" bgcolor="#ffffff" align="center">		<p align="left">&nbsp;</td>
	            </tr>
  
  				<tr><TD width="100%" colspan="3"> <p><img src="images/listfooter.gif" width="600" height="25" border="0"></p>
				</TD></tr>
		
				<tr>
					<TD width="100%" colspan="3" height="37" align="left"><input type="image" src="images/edit.jpg"  onclick="nextPage();return false;"  TITLE="Edit" width="90" height="37" border=0></TD>
	            </tr>
</table>
			
		

  </center>
</div>
			
		

<%		}
		else
		{
%>
			<p align="center">&nbsp;<center><font face="Verdana" size="2"><b>presently no teachers are available</b></font></center><%		}

		}
		catch(IOException ioe)
		{
			ExceptionsFile.postException("ShowTeachers.jsp","operations on database","IOException",ioe.getMessage());
			 System.out.println(ioe.getMessage());
		}
		catch(SQLException sqle)
		{
			ExceptionsFile.postException("ShowTeachers.jsp","operations on database","SQLException",sqle.getMessage());
			 System.out.println(sqle.getMessage());
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowTeachers.jsp","operations on database","Exception",e.getMessage());
			 System.out.println(e.getMessage());
		 }finally{
			try{
				if(con!=null)
				con.close();
			
			}catch(Exception se){
				ExceptionsFile.postException("ShowTeachers.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		
		}
%>
<input type=hidden name="userid" value="<%= userid %>">
<input type=hidden name="schoolid" value="<%= schoolid %>">

</form>
</body>
</html>


