<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.io.*,coursemgmt.ExceptionsFile" 
autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<HTML>
<%!
	int pageSize=15;				//no.of weblinks have to be display per page
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
     Connection con=null;
	 Statement st=null,st1=null;
	 ResultSet rs=null;

     int totrecords=0;				//total no of work weblinks

	 int start=0;						//from which record we hve to start
	 int end=0;						//up to which record we have to display
	 int c=0,pages=0,pageNo=0,currentPage=0;
	
	 boolean flag=false;
	 String studentId="",teacherId="",schoolId="",courseName="",courseId="",classId="";
	 String url="",docName="",linkStr="",foreColor="";
     
	 
%>
<%
			//session=request.getSession();  //validating the existence of session
	        String sessid=(String)session.getAttribute("sessid");
		   	if(sessid==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
	 try {
			foreColor="";			
			schoolId=(String)session.getAttribute("schoolid");
			studentId=(String)session.getAttribute("emailid");
			courseId=(String)session.getAttribute("courseid");
			classId  = (String)session.getAttribute("classid");

			courseId=request.getParameter("courseid");
     		courseName=request.getParameter("coursename");
						
			con=con1.getConnection();
			if (request.getParameter("totrecords").equals("")) { 
							   
					st1=con.createStatement();
					flag=true;
					rs=st1.executeQuery("select count(distinct title) from courseweblinks where school_id='"+schoolId+"' and course_id='"+courseId+"'");
					
					rs.next();
					
					c=rs.getInt(1);
					if (c!=0 ) {                 
						totrecords=c;
					} else	{					
						flag=false;					
					}
					rs.close();
			} else	{						         //if the parameter totrecords is not empty
					totrecords=Integer.parseInt(request.getParameter("totrecords"));    
					flag=true;   
			}
					
			  
			st=con.createStatement();
						
			
			start=Integer.parseInt(request.getParameter("start")); 
			c=start+pageSize;
			end=start+pageSize;

			if (c>=totrecords)
				   end=totrecords;
			currentPage=(start/pageSize)+1;
															 //select the fields to be displayed		
			
			rs=st.executeQuery("select * from courseweblinks where school_id='"+schoolId+"' and course_id='"+courseId+"' LIMIT "+start+","+pageSize);

			
        }catch(SQLException e) {
			ExceptionsFile.postException("WebLinksList.jsp","Operations on database","SQLException",e.getMessage());
			try{
				if(st!=null)
					st.close();			//finally close the statement object
				if(con!=null && !con.isClosed())
					con.close();
			}catch(SQLException se){
				ExceptionsFile.postException("stuInBox.jsp","closing connection object","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
			System.out.println("The Error: SQL - "+e.getMessage());
		}	
	    catch(Exception e) {
			ExceptionsFile.postException("WebLinksList.jsp","Operations on database","Exception",e.getMessage());
			System.out.println("Error:  -" + e.getMessage());
		}

    

%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>

<base target="main">
<link href="images/style.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">

								
	function go(start,totrecords){			 //script for calling a page

		window.location.href="WeblinksList.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>";
		return false;
	}
	function gotopage(totrecords){
		var page=document.filelist.page.value;
		if (page==0){
			alert("Select page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="WeblinksList.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>";
			return false;
		}
	}
	function showURL(url){
		
		window.open(url,"HistoryWindow","resizable=yes,scrollbars=yes,width=600,height=400,toolbar=yes,statusbar=yes,menubar=yes,location=yes");
	}

							

</script>

</head>
<body topmargin=0 leftmargin=3>
<form name="filelist">

<center>
<center>
	
	<table border="0" width="100%" cellspacing="1">

<!--provides links to the courses,to the contents and to the Results page  -->
    <tr>
      <td bgcolor="#FBF4EC"><b><font color="#800000" face="verdana" size="2"><a href="CourseHome.jsp">Courses</a> 
        </font><font color="#800000" face="verdana" size="2"> &gt;&gt;</font><font color="#464649" face="verdana" size="2">
        </font>  
       </b><b><!-- <a href="StudentCourseContent.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>"> --><%=courseName%>
	  </a> 
        <font face="verdana" size="2" color="#464649">&gt;&gt;Weblinks</font>
		
		</b></td>
	</tr>
  <table>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" height="21">
        <div align="center">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
   <td colspan="6">
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

	<% if (flag==false){		//if there are no work documents to the student
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No Weblink is created for this course.</font></b></td></tr></table></td></tr></table>");				
		return;
	}
	%>
    <td bgcolor="#BC946B" height="21" >
      <p align="left"><font size="2" face="Arial"><span class="last">Files <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp;</span></td>
	  <td bgcolor="#BC946B" height="21" align="center"><font size="2" face="Arial" color="#000080">


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
	  <td  bgcolor='#BD966B' height='21' align='right' ><font face="arial" size="2">Page&nbsp;
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
   </td>
  </tr>
<!-- For displaying the details the of the work documents in a tabular format -->

 <tr>
   <td width="50%" bgcolor="#DBD9D5" height="21" align="center"><b><font size="2" face="Arial" color="#000080">Title</font></b></td>
	  <td width="50%" bgcolor="#DBD9D5" height="21" align="center"><b><font size="2" face="Arial" color="#000080">Link</font></b></td>

    
	
  </tr>

  <%
   try{
   	    while(rs.next())
	    { url=rs.getString("titleurl");
		 if (!(url.startsWith("http://")))
			 url="http://"+url;
		 
		 %>
			
			
		   
  	<tr>
     
    
 	
	<td width="50%" height="18" bgcolor="#E7E7E7" align="left" ><font size="2" face="Arial" color="<%= foreColor%>"><%=rs.getString("title")%></font></td>
	<td width="50%" height="18" bgcolor="#E7E7E7" align="left" ><font size="2" face="Arial" color="<%= foreColor%>"><a href="javascript://" onclick="showURL('<%=url%>');"><%=rs.getString("titleurl")%></a></font></td>

    
   
    
  </tr>
		
  <%        
			
		}
  }catch(Exception e){
	ExceptionsFile.postException("StudentInbox.jsp","displaying","Exception",e.getMessage());

  }finally{
	try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();		//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("stuInBox.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
  %>  
	
        
</table>

</form>
</BODY>
