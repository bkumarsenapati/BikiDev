<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	String userType="",schoolid="";
	String searchSchool="",searchType="",searchFor="",queryTag="",searchWord="",linkStr="";
	String query1="",query2="",tablename="",addQuery1="";
	String username="",userid="",fname="",lname="",emailid="",phone="";
	String sid="",un="",fn="",ln="",em="",ph="";
	boolean flag=false,whereFlag=false;
	int currentPage=0,totRecords=0,start=0,c=0,end=0;
	int pageSize=10;

	schoolid=(String)session.getAttribute("schoolid");
	userType=request.getParameter("user");
	searchSchool=request.getParameter("school");  // school name all=all schools, myschool= myschool
	searchType=request.getParameter("utype");  // admin, teacher or student or all 3 users
	searchFor=request.getParameter("userdet"); // fname, lname,userid,phone,emailid
	queryTag=request.getParameter("like");    // query is like or exactly ot starting with or ending with
	searchWord=request.getParameter("partinfo"); // searching word
	String bgClr="",listBgClr="";

	if(userType.equals("admin"))
	{
		bgClr="#EEE0A1";
		listBgClr="#EEBA4D";
	}
	else if(userType.equals("teacher"))
	{
		bgClr="#A8B8D1";
		listBgClr="#75B7E8";

	}
	else if(userType.equals("student"))
	{
		bgClr="#CCC7B7";
		listBgClr="#E69D68";
	}
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
	var page=document.searchUser.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		var start=(page-1)*<%=pageSize%>;
		parent.sec.location.href="SearchUser.jsp?school=<%=searchSchool%>&user=<%=userType%>&utype=<%=searchType%>&userdet=<%=searchFor%>&like=<%=queryTag%>&partinfo=<%=searchWord%>&totalrecords="+totrecords+"&start="+start;
		return false;
	}
}

function go(start,totrecords)
{
	parent.sec.location.href="SearchUser.jsp?school=<%=searchSchool%>&user=<%=userType%>&utype=<%=searchType%>&userdet=<%=searchFor%>&like=<%=queryTag%>&partinfo=<%=searchWord%>&totalrecords="+totrecords+"&start="+start;
	return false;
}

</script>
</head>

<body>
<form name="searchUser" id="searchUser">
<% 
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}	

//
	if(searchType.equals("student"))
	{
		tablename="studentprofile";
		userid="username";
		fname="fname";
		lname="lname";
		emailid="con_emailid";
		phone="phone";
	}
	else if(searchType.equals("teacher"))
	{
		tablename="teachprofile";
		userid="username";
		fname="firstname";
		lname="lastname";
		emailid="con_emailid";
		phone="phone";
	}
	else if(searchType.equals("admin"))
	{
		tablename="school_profile";
		userid="schoolid";
		fname="schoolname";
		lname="schooltype";
		emailid="emailid";
		phone="phone";
	}
	
//
	if(searchFor.equals("none"))
		whereFlag=false;
	else
		whereFlag=true;
//
	if(whereFlag==true)
	{
		if(searchFor.equals("fname"))
		{
			if(queryTag.equals("exactly"))
			{
				addQuery1=""+fname+" = '"+searchWord+"'";
			}
			else if(queryTag.equals("like"))
			{
				addQuery1=""+fname+" like '%"+searchWord+"%'";
			}
			else if(queryTag.equals("startwith"))
			{
				addQuery1=""+fname+" like '"+searchWord+"%'";
			}
			else if(queryTag.equals("endwith"))
			{
				addQuery1=""+fname+" like '%"+searchWord+"'";
			}
		}
		else if(searchFor.equals("lname"))
		{
			if(queryTag.equals("exactly"))
			{
				addQuery1=""+lname+" ='"+searchWord+"'";
			}
			else if(queryTag.equals("like"))
			{
				addQuery1=""+lname+" like '%"+searchWord+"%'";
			}
			else if(queryTag.equals("startwith"))
			{
				addQuery1=""+lname+" like '"+searchWord+"%'";
			}
			else if(queryTag.equals("endwith"))
			{
				addQuery1=""+lname+" like '%"+searchWord+"'";
			}
		}
		else if(searchFor.equals("userid"))
		{
			if(queryTag.equals("exactly"))
			{
				addQuery1=""+userid+" ='"+searchWord+"'";
			}
			else if(queryTag.equals("like"))
			{
				addQuery1=""+userid+" like '%"+searchWord+"%'";
			}
			else if(queryTag.equals("startwith"))
			{
				addQuery1=""+userid+" like '"+searchWord+"%'";
			}
			else if(queryTag.equals("endwith"))
			{
				addQuery1=""+userid+" like '%"+searchWord+"'";
			}
		}
		else if(searchFor.equals("emailid"))
		{
			if(queryTag.equals("exactly"))
			{
				addQuery1=""+emailid+" ='"+searchWord+"'";
			}
			else if(queryTag.equals("like"))
			{
				addQuery1=""+emailid+" like '%"+searchWord+"%'";
			}
			else if(queryTag.equals("startwith"))
			{
				addQuery1=""+emailid+" like '"+searchWord+"%'";
			}
			else if(queryTag.equals("endwith"))
			{
				addQuery1=""+emailid+" like '%"+searchWord+"'";
			}
		}
		else if(searchFor.equals("phone"))
		{
			if(queryTag.equals("exactly"))
			{
				addQuery1=""+phone+" ='"+searchWord+"'";
			}
			else if(queryTag.equals("like"))
			{
				addQuery1=""+phone+" like '%"+searchWord+"%'";
			}
			else if(queryTag.equals("startwith"))
			{
				addQuery1=""+phone+" like '"+searchWord+"%'";
			}
			else if(queryTag.equals("endwith"))
			{
				addQuery1=""+phone+" like '%"+searchWord+"'";
			}
		}
		if(tablename.equals("studentprofile"))
			addQuery1=addQuery1+"and crossregister_flag!=3";
		if(searchSchool.equals("all"))
		{
			query1="select * from "+tablename+" where "+addQuery1;
			query2="select count(*) from "+tablename+" where "+addQuery1;
		}
		else if(searchSchool.equals("myschool"))
		{
			query1="select * from "+tablename+" where schoolid='"+schoolid+"' and "+addQuery1;
			query2="select count(*) from "+tablename+" where schoolid='"+schoolid+"' and "+addQuery1;
		}
		else
		{
			query1="select * from "+tablename+" where schoolid='"+searchSchool+"' and "+addQuery1;
			query2="select count(*) from "+tablename+" where schoolid='"+searchSchool+"' and "+addQuery1;
		}
	}
	else
	{
			
		if(searchSchool.equals("all"))
		{
			if(tablename.equals("studentprofile"))
				tablename=tablename+" where crossregister_flag!=3";
			query1="select * from "+tablename+" order by schoolid asc";
			query2="select count(*) from "+tablename+"";
		}
		else if(searchSchool.equals("myschool"))
		{
			String flag1="";
			if(tablename.equals("studentprofile"))
				flag1="and crossregister_flag!=3";	
			query1="select * from "+tablename+" where schoolid='"+schoolid+"' "+flag1;
			query2="select count(*) from "+tablename+" where schoolid='"+schoolid+"' "+flag1;
		}
		else
		{
			String flag1="";
			if(tablename.equals("studentprofile"))
				flag1="and crossregister_flag!=3";	
			query1="select * from "+tablename+" where schoolid='"+searchSchool+"'"+flag1;
			query2="select count(*) from "+tablename+" where schoolid='"+searchSchool+"' "+flag1;
		}
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
			if (c!=0 ){
				totRecords=rs.getInt(1);
				flag=true;
			}
			else{
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
			fn=rs.getString(fname);
	        ln=rs.getString(lname);
			em=rs.getString(emailid);
			un=rs.getString(userid);
			ph=rs.getString(phone);
			if(ph.equals("null")||ph.equals(""))
				ph="---";
%>
<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111" height="23">
   <tr>
      <td align="right" height="23">
         <p align="left"><font face="Verdana"><b>&nbsp;<font size="4">Search Results</font></b></font></p>
      </td>
      <td align="right" height="23"><font face="verdana" size="2"><b>Total records matched:<%=totRecords%></b></font></td>
   </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111" height="24">
	<tr>
		<td height="24" align="left" bgcolor="<%=bgClr%>">
			<SPAN class=last><font face="Tahoma" size="2">&nbsp; Results <%= (start+1) %> - <%= end %> of <%= totRecords %>
			</SPAN> </font>
		</td>
		<td height="24" align="center" bgcolor="<%=bgClr%>">
			<SPAN class=last><font face="Tahoma" size="2">
<%
	if(start==0 )
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
	   <td valign="middle" height="24" align="center" bgcolor="<%=bgClr%>">
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
<%
	if(searchSchool.equals("all"))
	{
%>
       <th bgcolor="<%=listBgClr%>" height="24">
	   <font color="#282858" size="2" face="Verdana">School ID</font></th>
<%
	}
%>
<%
			if(!searchType.equals("admin"))
			{
%>
	   <th bgcolor="<%=listBgClr%>" height="24">
	   <font color="#282858" size="2" face="Verdana">UserID</font></th>
<%
			}
%>
<%
			if(searchType.equals("admin"))
			{
%>
	   <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">School Name</font></th>
       <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">School Type</font></th>
<%
			}
			else
			{
%>
	   <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">First Name</font></th>
       <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">Last Name</font></th>

<%
			}	
%>
	   <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">Email</font></th>
	   <th bgcolor="<%=listBgClr%>" height="24">
       <font color="#282858" size="2" face="Verdana">Phone</font></th>
    </tr>
    <tr>
<%
	if(searchSchool.equals("all"))
	{
%>
       <td width="140" align="left" height="1"><font size="2" face="verdana"><%=sid%></font></td>
<%
	}
%>
<%
			if(!searchType.equals("admin"))
			{
%>
      <td width="140" align="left" height="1"><font size="2" face="verdana"><%=un%></font></td>
<%
			}	
%>
     <!--  <td width="90" align="center" height="1">
		<font size="2" face="verdana"><a href="javascript:userDetails('<%=un%>');" ><%=fn%></a></font></td> -->
	<td width="90" align="left" height="1">
		<font size="2" face="verdana"><%=fn%></font></td>
	  <td width="90" align="left" height="1"><font size="2" face="verdana"><%=ln%></font></td>
	  <td width="180" align="left" height="1">
		<font size="2" face="verdana"><a href="mailto:<%=em%>"><%= em%></a></font></td>
	  <td width="110" align="left" height="1"><font size="2" face="verdana"><%=ph%></font></td>
   </tr>
<%
	while(rs.next())
	{
		sid=rs.getString("schoolid");
		fn=rs.getString(fname);
	    ln=rs.getString(lname);
		em=rs.getString(emailid);
		un=rs.getString(userid);
		ph=rs.getString(phone);
		
		if(ph.equals("null")||ph.equals(""))
				ph="---";
%>
    <tr>
<%
	if(searchSchool.equals("all"))
	{
%>
       <td width="140" align="left" height="1"><font size="2" face="verdana"><%=sid%></font></td>
<%
	}
%>
<%
			if(!searchType.equals("admin"))
			{
%>
       <td width="140" align="left" height="1"><font size="2" face="verdana"><%=un%></font></td>
<%
			}	
%>
     <!--   <td width="90" align="center" height="1">
		   <font size="2" face="verdana"><a href="javascript:userDetails('<%=un%>');"><%=fn%></a></font></td>  -->
	   <td width="90" align="left" height="1">
		   <font size="2" face="verdana"><%=fn%></font></td> 
       <td width="90" align="left" height="1"><font size="2" face="verdana"><%=ln%></font></td>
	   <td width="180" align="left" height="1">
	       <font size="2" face="verdana"><a href="mailto:<%=em%>"><%=em%></a></font></td>
	   <td width="110" align="left" height="1"><font size="2" face="verdana"><%=ph%></font></td>
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
	System.out.println(e);
	ExceptionsFile.postException("Contactst.jsp","Operations on database ","Exception",e.getMessage());
    out.println("<b>There is an error raised in the search. Please try once again.</b>");
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
		ExceptionsFile.postException("Contactst.jsp","Closing connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
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