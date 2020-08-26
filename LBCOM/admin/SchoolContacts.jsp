<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.io.*,coursemgmt.ExceptionsFile" 
autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<HTML>

<%!  
      String emailaddress,firstname,lastname,schoolname,reg_date;
      Connection con;
	  Statement st;
	  ResultSet rs;

     int totrecords=0;				//total no of work documents
	 int pageSize=10;				//no.of documents have to be display per page
	 int start=0;						//from which record we hve to start
	 int end;						//up to which record we have to display
	 int c,pages,pageNo,currentPage;
	
	 boolean flag=false;
	 String studentId,teacherId,schoolId,courseName,courseId,classId;
	 String url,docName,linkStr,foreColor;
     
	 private int getPages(int tRecords){
		int noOfPages;
		if((tRecords%pageSize)>0){
			noOfPages=(tRecords/pageSize)+1;
		}else{
			noOfPages=(tRecords/pageSize);
		}
		return noOfPages;
	}

%>
<%
    
	session=request.getSession();
	
	String uname=(String)session.getAttribute("uname");

	if (uname==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
   
%>
<%
        
	 try { 
			con=con1.getConnection();
			st=con.createStatement();

			if (request.getParameter("totrecords").equals("")) { 
				   
					st=con.createStatement();
					flag=true;
					rs=st.executeQuery("select count(schoolname) from schoolregistration ORDER BY reg_date");
					rs.next();
					c=rs.getInt(1);
					if (c!=0 ) {                 
						totrecords=c;
						
					} else	{					
						flag=false;					
					}

					rs.close();
			} else			{
				flag=true;
				//if the parameter totrecords is not empty
				
                totrecords=Integer.parseInt(request.getParameter("totrecords"));    
				

			}
						   
			start=Integer.parseInt(request.getParameter("start")); 
			
			c=start+pageSize;
			end=start+pageSize;
			

			if (c>=totrecords)
				   end=totrecords;
			currentPage=(start/pageSize)+1;
			
			

															 //select the fields to be displayed		
			
			rs=st.executeQuery("select * from schoolregistration LIMIT "+start+","+pageSize);

			
        }
	
		catch(SQLException e) {
			ExceptionsFile.postException("SchoolContacts.jsp","Operations on database","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
		}	
	    catch(Exception e) {
			ExceptionsFile.postException("SchoolContacts.jsp","Operations on database","Exception",e.getMessage());
			System.out.println("Error:  -" + e.getMessage());
		}

    

%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>School Contacts</title>

<base target="main">

<SCRIPT LANGUAGE="JavaScript">

								
	function go(start,totrecords){			 //script for calling a page

		window.location.href="SchoolContacts.jsp?start="+start+"&totrecords="+totrecords;
		return false;
	}
	function gotopage(totrecords){
		var page=window.filelist.page.value;
		if (page==0)
			{
			 alert("Select page");
			 return false;
		     }else
			    {
			     start=(page-1)*<%=pageSize%>;
			     window.location.href="SchoolContacts.jsp?start="+start+"&totrecords="+totrecords;
			     return false;
		        }
    	}
	function delet(fn1,sn1){


	if (confirm("Are you sure, you want to delete?")){
		window.location.href="/LBCOM/admin/DeleteSchoolContact.jsp?firstname="+fn1+"&schoolname="+sn1;
	}else{
		return false;
	}
 }
function details(sn,fn)
{
  var win=window.open("SchoolContactDetails.jsp?schoolname="+sn+"&firstname="+fn,"Hotschools","height=400,width=400");
  win.focus();
}

</script>

</head>
<body topmargin=0 leftmargin=3>
<form name="filelist">

<center>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="0">
    <tr>
        <td width="208" height="24">
            <p>
            <img src="images/hsn/logo.gif"  border="0" width="204" height="42" ></p>
        </td>
        <td width="387" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="212" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="104" height="24" align="center" valign="top">
            <p align="left">&nbsp;</p>
        </td>
        
    </tr>
</table>

<center>
<center>
	
	<table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" height="21">
       <div align="center" style="width: 929; height: 57">

                                <font color="#CCCCCC">
		<table border="0" width="100%" cellspacing="0" bordercolordark="#C2CCE0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
  <table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
   <td colspan="5">
   <b><font face="verdana" color="#000000" size="4" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   </font><font face="verdana" size="4" align="center" color="#0000FF">Schools 
   Contacts Information</font></b><table width="925" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111"></td>
   <td colspan="1" align=right>
   <b><font face="verdana" color="#000000" size="2" align="right">
   </font><font face="verdana" size="2" align="center" color="#0000FF"><a href="Logout.jsp" target="_self">Logout</a>
   </font></b></td></tr>
   <table width="925" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
	<tr>


<%

	if (flag==false){		//if there are no work documents to the student
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21' align='center'><b><font face='Arial' color='#FF0000' size='2'>There are no contacts available....</font></b></td></tr></table></td></tr></table>");				
		return;
	}

%>
    <td bgcolor="#BC946B" height="21" width="433"><font size="2" face="Arial"><span class="last">Files <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp; </span>
      </font></td>
	  <td bgcolor="#BC946B" height="21" align="center" width="203"><font size="2" face="Arial" color="#000080">

<%

		/*to provide navigation like prev|next if the documents are more than the pagesize*/
	   	if(start==0 ) {    
			
			if(totrecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totrecords+"'); return false;\" target='contents'>Previous</a> |";


			if(totrecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"'); return false; \" target='contents'> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	
		
	  
	  %>
	  </font></td>
	  <td  bgcolor='#BD966B' height='21' align='right'><font face="arial" size="2">Page&nbsp;
	  <%
		int index=1;
		int begin=0;
		int noOfPages=getPages(totrecords);
		out.println("<select name='page' onchange=\"gotopage('"+totrecords+"');return false;\"> ");
		while(index<=noOfPages){
			if(index==currentPage){
			    out.println("<option value='"+index+"' selected>"+index+"</option>");
			}else{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			begin+=pageSize;


		}
	  %>
	  </font></td>
	  </tr>
	</table>
                                </font>
                            </div>
   </td>
  </tr>
<!-- For displaying the details the of the work documents in a tabular format -->

 <tr>
   
  
                        <td></td>
                    </tr>
</table>
<div align="center">
  <center>
  
<table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111">
    <tr>
	<!--<td width="25" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><b><font color="#282858" face="Verdana"><span style="font-size:10pt;">Actions</span></font><span style="font-size:10pt;"><font face="Verdana"></font></span></b></td>-->
	<td width="67" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center"><b><font color="#282858" face="Verdana"><span style="font-size:10pt;">&nbsp;
    Actions</span></font></b></td>


    <td width="231" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center">
    <font color="#282858" face="Verdana"><span style="font-size:10pt;"><b>School Name</b></span></font></td>
	<td width="176" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center">
    <font color="#282858" face="Verdana"><span style="font-size:10pt;"><b>First Name</b></span></font></td>
    <td width="176" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center">
    <font color="#282858" face="Verdana"><span style="font-size:10pt;"><b>Last Name</b></span></font></td>
    <td width="176" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center">
    <font color="#282858" face="Verdana"><span style="font-size:10pt;"><b>eMail</b></span></font></td>
	<td width="172" style="background-color: #F0B850" align="left" bgcolor="#F0B850" height="25" valign="middle"><p align="center"><font color="#282858" face="Verdana" align="center"><span style="font-size:10pt;"><b>Registered 
                                    on<br>YYYY-MM-DD</b></span></font></td>
    </tr>

  <%
   try{
	   		

   	     while(rs.next())
         {
             firstname=rs.getString("firstname");
			 lastname=rs.getString("lastname");
			 emailaddress=rs.getString("emailaddress");
			
	         schoolname=rs.getString("schoolname");
			 if(rs.getString("reg_date")==null)
				 reg_date="-";
			 else
				 reg_date=rs.getString("reg_date");

			 
%>

	<tr>
      <td width="67" align="left" height="22" valign="middle"><b><a href="javascript://" onclick="delet('<%=firstname%>','<%=schoolname%>');return false;"><font size="2" face="verdana" style="text-decoration:none;color:blue">&nbsp;Delete</font></a></b></td>
	  <td width="231" align="left" height="22" valign="middle">&nbsp;<font size="2" face="verdana"><a href='#'  onclick="details('<%=schoolname%>','<%=firstname%>');return false;"><%=schoolname%></a></font></td>
      <td width="176" align="left" height="22" valign="middle">
      <font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= firstname %></font></td>
      <td width="176" align="left" height="22" valign="middle"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=lastname%></font></td>
	  <td width="176" align="left" height="22" valign="middle"><font size="2" face="verdana"><a href="mailto:<%=emailaddress%>" style="text-decoration:none;color:blue"><%= emailaddress %></a></font></td>
	  <td width="172" align="left" height="22" valign="middle"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=reg_date%></font></td>
   </tr>
		
  <%        
			
		}
  }catch(Exception e){
	ExceptionsFile.postException("SchoolContacts.jsp","displaying","Exception",e.getMessage());

  }finally{
	try{
		   if(st!=null)
				st.close();			//finally close the statement object
		   if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("SchoolContacts.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
  %>  
	
        
</table>
 
  </center>
</div>

</form>
</BODY>
</HTML>