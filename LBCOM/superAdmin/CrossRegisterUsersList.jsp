<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	String schoolid="";
	String searchSchool="",linkStr="";
	String query1="",query2="",tablename="";
	String username="";
	String sid="",un="",fn="",ln="",em="",ph="";
	boolean flag=false,whereFlag=false;
	int currentPage=0,totRecords=0,start=0,c=0,end=0;
	int pageSize=10;

	searchSchool=request.getParameter("school");  // school name all=all schools, myschool= myschool
	String bgClr="",listBgClr="";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function userDetails(ce)
{
  window.open("UserDetails.jsp?schoolid=<%=schoolid%>&userid=<%=username%>&cemail="+ce,"win",250,250);
}

function gotopage(totrecords)
{
	var page=document.crossRegister.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		var start=(page-1)*<%=pageSize%>;
		parent.bottom.location.href="CrossRegisterUsersList.jsp?school=<%=searchSchool%>&totalrecords="+totrecords+"&start="+start;
		return false;
	}
}

function go(start,totrecords)
{
	parent.bottom.location.href="CrossRegisterUsersList.jsp?school=<%=searchSchool%>&totalrecords="+totrecords+"&start="+start;
	return false;
}

function selectAll()
{
	if(document.crossRegister.selectall.checked==true)
	{
		with(document.crossRegister)
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = true;
            }
		}
	}
	else
	{
		with(document.crossRegister)
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = false;
            }
		}
	}
}

</script>
</head>

<body>
<form name="crossRegister" id="crossRegister">
<% 
	flag=false;

	if(searchSchool.equals("all"))
	{
		query1="select * from studentprofile where crossregister_flag < 2 and status>0 order by schoolid asc";
		query2="select count(*) from studentprofile";
	}
	else
	{
		query1="select * from studentprofile where schoolid='"+searchSchool+"' and crossregister_flag < 2 and status>0 order by username";
		query2="select count(*) from studentprofile where schoolid='"+searchSchool+"' and status>0 and username!='C000_vstudent'";
	}
	
	try
	{
		con = con1.getConnection();    
		if (request.getParameter("totalrecords").equals("")) 
		{ 
			
			st=con.createStatement();
			rs=st.executeQuery(query2);
			rs.next();
			c=rs.getInt(1);
			if (c!=0 )
			{
				totRecords=rs.getInt(1);
				flag=true;
			}
			else
			{
				flag=false;
			}
		}
		else
		{
			totRecords=Integer.parseInt(request.getParameter("totalrecords"));
			flag=true;
		}
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
		if(c>=totRecords)
			end=totRecords;
	    currentPage=(start/pageSize)+1;
		query1=query1+" Limit "+start+","+pageSize;
		rs=st.executeQuery(query1);
		if(rs.next())
		{
			sid=rs.getString("schoolid");
			fn=rs.getString("fname");
	        ln=rs.getString("lname");
			em=rs.getString("con_emailid");
			un=rs.getString("username");
			ph=rs.getString("phone");
			if(ph.equals("null")||ph.equals(""))
				ph="---";
%>

<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111" height="23">
   <tr>
      <td align="right" height="23">
         <p align="left"><font face="Verdana"><b>&nbsp;<font size="4">User Details</font></b></font></p>
      </td>
      <td align="right" height="23"><font face="verdana" size="2"><b>Total number of users:<%=totRecords%></b></font></td>
   </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111" height="24">
	<tr>
		<td height="24" align="left" bgcolor="#E8CFBF">
			<font face="Tahoma" size="2">
			<SPAN class=last>&nbsp; Users <%= (start+1) %> - <%= end %> of <%= totRecords %>
			</SPAN> </font>
		</td>
		<td height="24" align="center" bgcolor="#E8CFBF">
			<SPAN class=last><font face="Tahoma" size="2">
<%
	if(start==0)
	{ 
		if(totRecords>end)
		{
			out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"');return false;\"> Next</a>&nbsp;&nbsp;");
		}
		else
			out.println("");
	}
	else
	{
		linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"');return false;\">Previous</a> |";
		if(totRecords!=end)
		{
			linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"');return false;\"> Next</a>&nbsp;&nbsp;";
		}
		else
			linkStr=linkStr+" Next&nbsp;&nbsp;";
		out.println(linkStr);
	}	
%>
			</font>
			</SPAN></td>
	   <td valign="middle" height="24" align="center" bgcolor="#E8CFBF">
			<p align="right"><SPAN class=last><font face="Tahoma" size="2">&nbsp;Page&nbsp;
<%
	int index=1;
	int str=0;
	int noOfPages=0;
	if((totRecords%pageSize)>0)
		noOfPages=(totRecords/pageSize)+1;
	else
		noOfPages=totRecords/pageSize;
%>
		<select name="page" onchange="gotopage('<%=totRecords%>');return false;">
<%
	while(index<=noOfPages)
	{
		if(index==currentPage)
		{
%>
			<option value="<%=index%>" selected><%=index%></option>
<%
		}
		else
		{
%>
			<option value="<%=index%>"><%=index%></option>
<%
		}
			index++;
			str+=pageSize;
    }
%>
	</select>
  </font></td>
    </tr>
</table>

  </center>
</div>
<div align="center">
  <center>

<table border="0" width="100%" height="28" bordercolor="#111111" cellpadding="1" cellspacing="2">
    <tr>
       <th bgcolor="#FFFFFF" colspan="5">
       <p align="left">
       <img border="0" src="images/spacer.gif" width="1" height="1"></th>
    </tr>
    <tr>
		<td width="10" height="24" bgcolor="#D3A585">
			<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all students">
		</td>
	    <th bgcolor="#D3A585" height="24"><font color="#FFFFFF" size="2" face="Verdana">School ID</font></th>
	    <th bgcolor="#D3A585" height="24"><font color="#FFFFFF" size="2" face="Verdana">Student ID</font></th>
	    <th bgcolor="#D3A585" height="24"><font color="#FFFFFF" size="2" face="Verdana">First Name</font></th>
        <th bgcolor="#D3A585" height="24"><font color="#FFFFFF" size="2" face="Verdana">Last Name</font></th>
	</tr>
    <tr>
		<td width="10"><input type="checkbox" name="selids" value="<%=un%>"></font></td>
	    <td width="140" align="left" height="1"><font size="2" face="verdana"><%=sid%></font></td>
		<td width="140" align="left" height="1"><font size="2" face="verdana"><%=un%></font></td>
     	<td width="90" align="left" height="1"><font size="2" face="verdana"><%=fn%></font></td>
		<td width="90" align="left" height="1"><font size="2" face="verdana"><%=ln%></font></td>
 </tr>
<%
	while(rs.next())
	{
		sid=rs.getString("schoolid");
		fn=rs.getString("fname");
	    ln=rs.getString("lname");
		em=rs.getString("con_emailid");
		un=rs.getString("username");
		ph=rs.getString("phone");
		if(ph.equals("null")||ph.equals(""))
			ph="---";
%>
    <tr>
		<td width="10"><input type="checkbox" name="selids" value="<%=un%>"></font></td>
        <td width="140" align="left" height="1"><font size="2" face="verdana"><%=sid%></font></td>
        <td width="140" align="left" height="1"><font size="2" face="verdana"><%=un%></font></td>
    	<td width="90" align="left" height="1"><font size="2" face="verdana"><%=fn%></font></td> 
        <td width="90" align="left" height="1"><font size="2" face="verdana"><%=ln%></font></td>
	</tr>

<%
	}
%>

</table>
</center>
</div>

<%
		}
		else
		{
%>
    </tr>
    <tr>
        <td width="968"><p align="center"><b><font face="verdana" color="#800080" size="2">Sorry, no matches found.</font></b><%
}
}
catch(Exception e)
{
	System.out.println("Exception in CrossRegisterUsersList.jsp is :"+e);
	ExceptionsFile.postException("CrossRegisterUsersList.jsp","Operations on database ","Exception",e.getMessage());
    out.println("<b>There is an error raised in the users list. Please try once again.</b>");
}

finally
{
	try
	{
		if(con!=null)
			con.close();
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CrossRegisterUsersList.jsp","Closing connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed in CrossREgistrationUsersList.jsp.");
	}
}
%>
</p>
        </td>
    </tr>
</table>
</form>
</body>
</html>