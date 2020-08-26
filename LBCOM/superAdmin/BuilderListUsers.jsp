<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs=null,rs1=null,rs9=null;
	Statement st=null,st1=null,st9=null;
	String userType="",schoolid="";
	String searchSchool="",searchType="",linkStr="";
	String query1="",query2="",tablename="";
	String username="",userid="",fname="",lname="",emailid="",phone="";
	String sid="",un="",fn="",ln="",em="",ph="",argSelIds="",argUnSelIds="",builderId="",courseId="";
	String id1="",id2="",sta="";

	Hashtable hsSelIds=null;
	
	boolean flag=false,whereFlag=false;
	int currentPage=0,totRecords=0,start=0,c=0,end=0;
	int pageSize=100;

	//schoolid=(String)session.getAttribute("schoolid");
	schoolid=request.getParameter("schoolid");
	searchSchool=request.getParameter("school");  // school name all=all schools, myschool= myschool
	searchType=request.getParameter("utype");  // admin, teacher or student or all 3 users

	String bgClr="",listBgClr="";
	courseId=request.getParameter("ctype");
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>

var checked=new Array();
var unchecked=new Array();

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
		parent.sec.location.href="BuilderListUsers.jsp?school=<%=searchSchool%>&utype=<%=searchType%>&totalrecords="+totrecords+"&start="+start+"";
		return false;
	}
}

function go(start,totrecords)
{
	parent.sec.location.href="BuilderListUsers.jsp?schoolid=<%=searchSchool%>&school=<%=searchSchool%>&utype=<%=searchType%>&totalrecords="+totrecords+"&start="+start+"&ctype=DC005";
	return false;
}

function selectAll()
{
	if(document.searchUser.selectall.checked==true)
	{
		with(document.searchUser)
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
		with(document.searchUser)
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids'){
					elements[i].checked = false;
				}
            }
		}
	}
}	

function validate(cid,sid)
{
	var chk="false";
	var len2=window.document.searchUser.elements.length;
	var arr=document.getElementsByName("selids");
	for(var i=0,j=0,k=0;i<arr.length;i++)
	{

		if(arr[i].checked)
		{
			chk=true;
			checked[j++]=arr[i].value;
		}
		else
		{
			unchecked[k++]=arr[i].value;
		}
		document.location.href="AccessBuilder.jsp?schoolid="+sid+"&checkedids="+checked+"&uncheckedids="+unchecked+"&ctype="+cid+"";
	}

	if(chk=="false")
	{
		if(confirm("Are you sure that you don't want to assign the access to any teacher?")==true)
		{
			document.searchUser.checked.value=checked;
			document.searchUser.unchecked.value=unchecked;
		}
		else
			return false;
	}
	else
	{
		document.searchUser.checked.value=checked;
		document.searchUser.unchecked.value=unchecked;
	}
}

</script>
</head>

<body>
<form name="searchUser" id="searchUser">
<% 
	flag=false;

	if(searchType.equals("teacher"))
	{
		tablename="teachprofile";
		userid="username";
		fname="firstname";
		lname="lastname";
		emailid="con_emailid";
		phone="phone";
	}
		
	if(searchSchool.equals("all"))
	{
		query1="select * from "+tablename+" order by schoolid asc";
		query2="select count(*) from "+tablename+"";
	}
	else
	{
		query1="select * from "+tablename+" where schoolid='"+searchSchool+"'";
		query2="select count(*) from "+tablename+" where schoolid='"+searchSchool+"'";
	}
	
	try
	{
		con = con1.getConnection();    
		if (request.getParameter("totalrecords").equals("")) 
		{ 
			
			st=con.createStatement();
			st1=con.createStatement();
			st9=con.createStatement();
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

%>

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
		<th bgcolor="#D3A585" height="24">
		<input type="checkbox" name="selectall" onclick="javascript:selectAll()" value="ON" title="Select or deselect all teachers"></th>
<%
	if(searchSchool.equals("all"))
	{
%>
		<th bgcolor="#D3A585" height="24">
	   <font color="#FFFFFF" size="2" face="Verdana">School ID</font></th>
<%
	}
%>
<%
			if(!searchType.equals("admin"))
			{
%>
	   <th bgcolor="#D3A585" height="24">
	   <font color="#FFFFFF" size="2" face="Verdana">UserID</font></th>
<%
			}
%>
<%
			if(searchType.equals("admin"))
			{
%>
	   <th bgcolor="#D3A585" height="24">
       <font color="#FFFFFF" size="2" face="Verdana">School Name</font></th>
       <th bgcolor="#D3A585" height="24">
       <font color="#FFFFFF" size="2" face="Verdana">School Type</font></th>
<%
			}
			else
			{
%>
	   <th bgcolor="#D3A585" height="24">
       <font color="#FFFFFF" size="2" face="Verdana">First Name</font></th>
       <th bgcolor="#D3A585" height="24">
       <font color="#FFFFFF" size="2" face="Verdana">Last Name</font></th>

<%
			}	
%>
	   <th bgcolor="#D3A585" height="24">
       <font color="#FFFFFF" size="2" face="Verdana">Email</font></th>
	   
    </tr>

	<tr>
   
<%

	rs9=st9.executeQuery("select teacher_id from lbcms_dev_course_permissions where dev_course_id='"+courseId+"'");
		hsSelIds=new Hashtable();
		while(rs9.next())
		{
			id1=rs9.getString(1);
			hsSelIds.put(id1,id1);
		}
		session.setAttribute("selectedids",hsSelIds);

		int i=0;
		rs=st.executeQuery(query1);
		while(rs.next())
		{
			String bgclr="white";
			sid=rs.getString("schoolid");
			fn=rs.getString(fname);
	        ln=rs.getString(lname);
			em=rs.getString(emailid);
			un=rs.getString(userid);

				if(hsSelIds.contains(un))
				{
					bgclr="green";
%>
    	
	<td width="10" align="left" height="1">
	<input type='checkbox' name='selids'  value="<%=un%>" checked></td>
<%
			}else{
	%>
	
		<td width="10" align="left" height="1">
	<input type='checkbox' name='selids'  value="<%=un%>"></td>
	<%
					}
	%>
<%
	if(searchSchool.equals("all"))
	{
%>
       <td width="160" align="center" height="1" bgcolor="<%=bgclr%>"><font size="2" face="verdana"><%=sid%></font></td>
<%
	}
%>
<%
			if(!searchType.equals("admin"))
			{
%>
       <td width="160" align="center" height="1" bgcolor="<%=bgclr%>"><font size="2" face="verdana"><%=un%></font></td>
<%
			}	

%>
     <!--   <td width="90" align="center" height="1">
		   <font size="2" face="verdana"><a href="javascript:userDetails('<%=un%>');"><%=fn%></a></font></td>  -->
	   <td width="120" align="left" height="1">
		   <font size="2" face="verdana"><%=fn%></font></td> 
       <td width="100" align="left" height="1"><font size="2" face="verdana"><%=ln%></font></td>
	   <td width="200" align="left" height="1">
	       <font size="2" face="verdana"><a href="mailto:<%=em%>"><%=em%></a></font></td>
	   
   </tr>
 

<%
		}
hsSelIds.clear();
%>
<tr>
   <td colspan="6"><input type="button" value="ACCESS" name="submit" onclick="return validate('<%=courseId%>','<%=schoolid%>');"></td>
   </tr>
   <tr>
   <td colspan="6">&nbsp;</td>
   </tr>
</table>

  </center>
<%
		if(flag==false)
		{
%>
        
  
    <tr>
        <td width="968"><p align="center"><b><font face="verdana" color="#800080" size="2">Sorry, no matches found.</font></b>

<%
}
%>
</p>

        </td>
    </tr>
</table>
<%
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


</form>
</body>
</html>