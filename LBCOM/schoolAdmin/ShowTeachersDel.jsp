<jsp:useBean id="db" class="sqlbean.DbBean" scope="session">
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
<head>
<script language="javascript">
	function goPage(){
		var win=window.document.editUser;
		var userid=win.userid.value;
		var schoolid=win.schoolid.value;
		document.location.href="/LBCOM/schoolAdmin/AddEditUserpage.jsp?userid="+userid+"&schoolid="+schoolid;
	}
	function nextPage(){
		
		var user=null;
		var c=0;
		var len = window.document.editUser.elements.length;
		for(var i=0;i<len;i++){
			if(window.document.editUser.elements[i].checked){
				user = window.document.editUser.elements[i].value;
				c=1;
			}
		}
		if(c==1){
               // document.location.href="/LBCOM/teacherAdmin.RegisterTeacher?mode=delete&user="+user+"&school="+document.editUser.schoolid.value;
			   document.location.href="/LBCOM/schoolAdmin/teach_del_courselist.jsp?user="+user+"";
			   //teacherAdmin.RegisterTeacher?mode=delete&user="+user+"&school="+document.editUser.schoolid.value;
				return false;
		}
        else{ 
			alert("Please select a Teacher");
			return false;
		}
		//return false;
	}
	
</script>
</head>
<body topmargin=3 leftmargin="0" marginwidth="0">
<form name="editUser">
<center>
<table border="0" width="80%" cellspacing="1">

<tr>
    <td width="50%"></td>
    <td width="50%">
       <p align="right">
		<a href="javascript:goPage()"><b><font face="Verdana" size="2" style="color:blue;text-decoration:none"><img src="images/back.jpg" border=0></font></b></a></td>
            <td></td>
</tr>


<%
		userid  =request.getParameter("userid");
		session=request.getSession(true);
		schoolid=request.getParameter("schoolid");
					
		try
		{
			con=db.getConnection();
			st=con.createStatement();
			//resultSet=db.execSQL("select email,username,firstname,lastname from teachprofile where schoolid='"+schoolid+"'");
			resultSet=st.executeQuery("select email,username,firstname,lastname from teachprofile where schoolid='"+schoolid+"'");
			if(resultSet.next())
			{
%>
			<tr>      
				<td width="748" colSpan="3">        
	  			<p align="left"><font face="Arial Black" color="#000000">Teachers List</font></p>
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
	

<%				do
				{
%>
					<tr><td align='left' width='19'>
					<b><font face="Arial" size="2"><input type="radio" name="username" value="<%=resultSet.getString("username")%>"><%=resultSet.getString("username")%>
					</font></b>
					</td>
					
	
					<td align='left' width='244'><b><font face="Arial" size="2"><%=resultSet.getString("firstname")+"  "+resultSet.getString("lastname")%></font></b></td>
            <td></td>
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
					<TD width="100%" colspan="3" height="37"><p align="center"><a href="javascript://" onclick="return nextPage();" ><img src="images/next.jpg"  TITLE="NEXT" width="90" height="37" border=0></a></TD>
	            </tr>
</table>
</center>	
		

<%		}
		else
		{
%>
			<p align="center">&nbsp;<center><font face="Verdana" size="2"><b>presently no teachers are available</b></font></center><%		}

		}
		catch(IOException ioe)
		{
			ExceptionsFile.postException("ShowTeachersDel.jsp","operations on database","IOException",ioe.getMessage());
			 System.out.println(ioe.getMessage());
		}
		catch(SQLException sqle)
		{
			ExceptionsFile.postException("ShowTeachersDel.jsp","operations on database","SQLException",sqle.getMessage());
			 System.out.println(sqle.getMessage());
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ShowTeachersDel.jsp","operations on database","Exception",e.getMessage());
			 System.out.println(e.getMessage());
		 }finally{
			try{
				if(con!=null)
					con.close();
			
		}catch(Exception se){
			ExceptionsFile.postException("ShowTeachersDel.jsp","closing statement and connection  objects","Exception",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
%>
<input type=hidden name="userid" value="<%= userid %>">
<input type=hidden name="schoolid" value="<%= schoolid %>">

</form>
</body>
</html>


