<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
      Connection con=null;
      Statement st=null,st1=null;
      ResultSet rs=null,rs1=null;
      
      String studentId="",teacherId="",schoolId="",workFile="",workId="",categoryId="",cat="",courseName="";
	  String linkStr="",bgColor="",courseId="",docName="",fName="",lName="",emailId="",classId="",remarks="";
	  int totrecords=0,start=0,end=0,c=0,maxMarks=0,status=0,count=0;
	 
%>

<%    
      try  {   

	     session=request.getSession();
		 String sessid=(String)session.getAttribute("sessid");
		 if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		 }
		 teacherId=(String)session.getAttribute("emailid");
		 schoolId=(String)session.getAttribute("schoolid");
		 courseName=(String)session.getAttribute("coursename");
		 courseId=(String)session.getAttribute("courseid");
		 classId=(String)session.getAttribute("classid");

		 cat=request.getParameter("cat"); 
		 workId=request.getParameter("workid");
		 docName=request.getParameter("docname");


		 maxMarks=Integer.parseInt(request.getParameter("maxmarks"));
		 totrecords=Integer.parseInt(request.getParameter("totrecords"));
		 if (totrecords<=0) {
	
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No items pending for evaluation. </font></b></td></tr></table>");				
				return;


			
		 } else {
			    con=con1.getConnection();

		   
			   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			   st1=con.createStatement();
			   start=Integer.parseInt(request.getParameter("start"));
			
			   c=start+pageSize;
			   end=start+pageSize;

			   if (c>=totrecords)
				   end=totrecords;

			   rs=st.executeQuery("select answerscript,student_id,status,submitted_date,submit_count,marks_secured,stuattachments,remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2   order by status,eval_date Asc LIMIT "+start+","+pageSize);
		 }
	  }
	  catch(SQLException e) {
		  ExceptionsFile.postException("ShowStudentFile.jsp","Operations on database and reading parameters","SQLException",e.getMessage());
		  try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowStudentFile.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}	
      }	
	  catch(Exception e) {
		    ExceptionsFile.postException("ShowStudentFile.jsp","Operations on database and reading parameters","Exception",e.getMessage());
			System.out.println("The Error is:"+e);
	  }	
				
%>

		
	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--
	function go(start,totrecords,cat){		
		parent.bottompanel.location.href="ShowStudentFile.jsp?cat="+cat+"&workid=<%=workId%>&start="+start+ "&totrecords="+totrecords+"&docname=<%=docName%>&maxmarks=<%=maxMarks%>";
		return false;
	}

	function deleteFile(workid,cat){
		if(confirm("Are you sure you want to delete the file?")){		//parent.bottompanel.location.href="/servlet/coursemgmt.AddWork?mode=del&workid="+workid+"&cat="+cat;
		return false;
		}
		else
			return;
	}

	function deleteAllFiles(cat){
		if(confirm("Are you sure you want to delete the selected files?")){
			var obj=document.fileslist.selids;
			var selids=new Array();
			for(var i=0;i<obj.length;i++){
					if(obj[i].checked==true)
						selids[i]=obj[i].value;
			}
			//parent.bottompanel.location.href="/servlet/coursemgmt.AddWork?mode=deleteall&cat="+cat+"&selids="+selids;
			return false;
		}
		else
			return;
	}
	function selectAll(){
			
			if(document.fileslist.selectall.checked==true){
				with(document.fileslist) {
					 for (var i=0; i < elements.length; i++) {
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = true;
					  }
				}
			}else{

				with(document.fileslist) {
					 for (var i=0; i < elements.length; i++) {
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = false;
					  }
				}
			}

	}

	function showFile(workfile,docname,stuid){

		//var stufoldername=stuid;
		//var schoolid='<%= schoolId %>';
		window.open("../../schools/<%=schoolId%>/<%=studentId%>/coursemgmt/<%=courseId%>/<%=cat%>/"+workfile,docname,'width=600,height=600,toolbars=no');
		return false;


	}

//-->
</SCRIPT>


</head>

<body topmargin=0 leftmargin=2>
<form name="fileslist">
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
<tr>
    <td width="100%" bgcolor="#FFFFFF" height="21" colspan="7"><span><b><font color="#800080" face="Arial" size="2">	
		<%
			out.println("Document Name : "+docName);

		%>	
      </font></b></span></td>
  </tr>
  <tr>
      <td width="100%" >
       
  <table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" height="20" >
   <tr>

    <td width="100%" bgcolor="#C2CCE0" height="10" colspan=7 >
      <p align="right"><font size="2" face="Arial"><span class="last">
	  Files <%= (start+1) %> - <%= end %> of <%=totrecords%> &nbsp;&nbsp;</span><font color="#000080">
	  <%

	  	if(start==0 ) { 
			
			if(totrecords>end){
				out.println("Previous | <a href=\"javascript:\" onclick=go('"+(start+pageSize)+ "','"+totrecords +"','"+cat+"');return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"javascript:\" onclick=go('"+(start-pageSize)+ "','"+totrecords+"','"+cat+"');return false;\">Previous</a> |";


			if(totrecords!=end){
				linkStr=linkStr+"<a href=\"javascript:\" onclick= go('"+(start+pageSize)+ "','"+totrecords +"','"+cat+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
	  </font></td>
  </tr>
  <tr>
    <!--<td width="20" bgcolor="#DBD9D5" height="21" align="center" valign="middle"><input type="checkbox" name="selectall" onclick="javascript:selectAll()" ></td>
              <td width="18" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font size="2" face="Arial" color="#000080"><b><a href="javascript:" onclick="javascript:return deleteAllFiles('<%= cat%>')" ><img border="0" src="../images/idelete.gif"  TITLE="Delete  selected files"></b></font></a></td>-->
     <td width="18" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font size="2" face="Arial" color="#000080"><b></b></font></a></td>
	<td width="200" bgcolor="#DBD9D5" height="21"><b><font size="2" face="Arial" color="#000080">Student Name</font></b></td>
    <td width="166" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>User Id</b></font></td>
    <td width="125" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Submitted Date</b></font></td>
    <td width="242" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>File&nbsp;</b></font> </td>
	<td width="110" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Submit No.&nbsp;</b></font> </td>
   <!-- <td width="110" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Comments&nbsp;</b></font> </td>-->
  </tr>

	<%

	try{
		while(rs.next())
			  {
				
		    	workFile=rs.getString("answerscript");
				studentId=rs.getString("student_id");
				status=rs.getInt("status");
				remarks=rs.getString("remarks");
				count=rs.getInt("submit_count");
				rs1=st1.executeQuery("select fname,lname,emailid from studentprofile where emailid='"+studentId+"' and schoolid='"+schoolId+"'");

				
				if(status>=4)
					bgColor="#E7E3E7";
				else 
					bgColor="#F5F5F5";
			

			    if (!rs1.next()) {
				}
				else {
					fName=rs1.getString("fname");
					lName=rs1.getString("lname");
					emailId=rs1.getString("emailid");
				}
			    String url="../../schools/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+cat+"/"+workFile;
				
		%>

		  <tr>
<!--    <td width="20" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial"><input type="checkbox" name="selids" value="<%=workId %>"></font></td>

	<td width="18" height="18" bgcolor="<%= bgColor %>" valign="middle" align="center"><font size="2" face="Arial"><a href="javascript:" onclick="javascript:return deleteFile('<%= workId %>','<%= cat%>')" ><img border="0" src="../images/idelete.gif" TITLE="Delete File" ></a></font></td>-->
	<td width="18" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle">
		<font size="2" face="Arial"><a href="Frames.jsp?cat=<%=cat%>&workid=<%=workId%>&workfile=<%=workFile%>&totrecords=<%=totrecords%>&docname=<%=docName%>&status=<%=status%>&studentid=<%=studentId%>&maxmarks=<%=maxMarks%>&marks=<%=rs.getString("marks_secured")%>&comments=<%=rs.getString("stuattachments")%>&remarks=<%=remarks%>&submitdate=<%=rs.getDate("submitted_date")%>&count=<%=count%>">
		<img border="0" src="../images/ieval.gif" TITLE="Evaluate Submission"></a></font>
	</td>
	<td width="200" height="18" bgcolor="<%=bgColor%>">
		<font size="2" face="Arial"><%=fName+" "+lName%></font></td>
    <td width="166" height="18" bgcolor="<%=bgColor%>">
		<font size="2" face="Arial"><%=emailId%></font></td>
    <td width="125" height="18" bgcolor="<%=bgColor%>">
		<font size="2" face="Arial"><%=rs.getDate("submitted_date")%></font></td>
    <td width="242" height="18" bgcolor="<%=bgColor%>">
		<font size="2" face="Arial">
	<%
	workFile = workFile.substring(workFile.indexOf('_')+1,workFile.length());
	workFile = workFile.substring(workFile.indexOf('_')+1,workFile.length());
	out.println(workFile);
	%></font></td>
    <td width="110" height="18" bgcolor="<%=bgColor%>" align="center">
		<font size="2" face="Arial"><%=count%></font>
	</td>
  </tr>

<%          
		}
	}catch(Exception e){
		ExceptionsFile.postException("ShowStudentFile.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowStudentFile.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
  %> 

</table>

      </td>
    </tr>
  </table>
  </center> 
</form>
</body>

</html>		
