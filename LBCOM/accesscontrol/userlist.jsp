<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(){
	userid=document.getElementsByName("userid");
	txt=""
	var ret=false;
	for (i=0;i<userid.length;++ i)
	{
		if (userid[i].checked)
		{
			txt=txt+userid[i].value+","
			ret=true;

		}
	}
	document.getElementById("userids").value=txt;
	if(ret==false){
		alert("You must select at least one user");
	}
	return ret;
	
}
//-->
</SCRIPT>
</head>
<body topmargin=3 leftmargin="0" marginwidth="0">
<%
	String schoolid=(String)session.getAttribute("schoolid");
	try{
		Connection con=null;
		Statement st=null;
		ResultSet  rs=null;
		con=con1.getConnection();
		st=con.createStatement();
		String pg_grp=request.getParameter("group");
		String classid=request.getParameter("classid");
		String query="";
		if(pg_grp==null)
		  pg_grp="xxx";
		if(classid==null)
		  classid="xxx";
%>
<form name="editUser" onsubmit="return validate()" method="get" action="userbody.jsp">
<CENTER><table border="0" width="596" cellspacing="1" border=1>
<tr>      
				<td colSpan="3">        
	  			<p align="left"><font face="Arial Black" color="#FDC043">Select Users</font></p>
				</td>
</tr>  
<tr>      
				<td colSpan="3">        
		  		<p align="left"><b><font face="Arial" size="2"><img src="images/listheader.gif" border="0" width="597" height="25"></font></b></p>
			</td>
</tr>    
<tr>     
				<td align="left">
					<p align="left"><b><font face="Arial" size="2" color="#000066">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User ID</font></b>
				</td>
				<td align="left">
					<p align="left"><b><font face="Arial" size="2" color="#000066">
					User Name</font></b>
				</td>
				<td align="left">
					<p align="left"><b><font face="Arial" size="2" color="#000066">
					Email</font></b>
				</td>   
            
			<%
				if((!pg_grp.equals("xxx"))&&(!classid.equals("xxx"))){
					if(pg_grp.equals("Teacher")){
						if(classid.equals("All"))
							query= "SELECT  username,con_emailid,firstname as fname FROM  teachprofile where schoolid='"+schoolid+"'";
						else
							query= "SELECT  username,con_emailid,firstname as fname FROM  teachprofile where schoolid='"+schoolid+"' and class_id='"+classid+"'";

					}else{
						if(classid.equals("All"))
							query= "SELECT  username,con_emailid,fname FROM  studentprofile where schoolid='"+schoolid+"'and crossregister_flag<2";
						else
							query= "SELECT  username,con_emailid,fname FROM  studentprofile where schoolid='"+schoolid+"' and crossregister_flag<2 and grade='"+classid+"'";
					}
					rs=st.executeQuery(query);
					if (!rs.next()) {
			%>
					</tr>				
					<tr>
					<td align='left' >

						<font face="Arial">

						<b>No Users</b>
					</font>
					</td>
					<td></td>	
					</tr>
			<%     }else{%>
					</tr>				
					<tr><td align='left'>
					<b><font face="Arial" size="2"> <INPUT TYPE="checkbox" NAME="userid" value="<%=rs.getString("username")%>"><%=rs.getString("username")%>
					</font></b>
					</td>	
					<td align='left'><b><font face="Arial" size="2"><%=rs.getString("fname")%></font></b></td>
					<td align='left'><b><font face="Arial" size="2"><%=rs.getString("con_emailid")%></font></b></td>				
					</tr>


			<% }

					while (rs.next()) {		
			%>
			</tr>				
					<tr>
						<td align='left'>
							<b><font face="Arial" size="2"> <INPUT TYPE="checkbox" NAME="userid" value="<%=rs.getString("username")%>"><%=rs.getString("username")%></font></b>
						</td>	
					<td align='left'><b><font face="Arial" size="2"><%=rs.getString("fname")%></font></b></td>
					<td align='left'><b><font face="Arial" size="2"><%=rs.getString("con_emailid")%></font></b></td>
            
			</tr>
			<%}}%>	
			<%
			con.close();
			}catch(Exception e){
					System.out.println("Exception in accesscontrol/grouplevel/top.jsp  :"+e);

		   }
		%>
			<!-- dfgdfgdddddddddddddddddddddddddddddddddddddddddd -->			

				<tr>
					<td colspan="3" bgcolor="#ffffff" align="center">		</td></tr>
					
	            </tr>
  
  				<tr><TD colspan="3"> <p>
					<img src="images/listfooter.gif" width="597" height="24" border="0"></p>
				</TD></tr>
				<tr>
					<TD colspan="2" height="37"><p align="center"><INPUT TYPE="submit" value=Next></TD>
	            </tr>
</table></CENTER>		
<input type=hidden name="userids" id="userids" value="">
<input type=hidden name="formid" id="formid" value="<%=request.getParameter("formid")%>">
<input type=hidden name="utype" id="utype" value="<%=request.getParameter("group").charAt(0)%>">
<input type=hidden name="classid" id="classid" value="<%=request.getParameter("classid")%>">
</form>
</body>
</html>


