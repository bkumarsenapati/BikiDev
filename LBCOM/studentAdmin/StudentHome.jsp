<%@page language="java" import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%

	Connection con = null;
	Statement st = null,st1=null,st2=null;
	ResultSet rs = null,rs1=null,rs2=null;
	char ac_id_arry[]=null;
	char ac_ids_arry[]=null;
	String schoolId="",userId="",status="",status1="";
	boolean flag=false;
%>

<%

try
{
	schoolId=(String)session.getAttribute("schoolid");
	userId=(String)session.getAttribute("emailid");
	//schoolId=request.getParameter("schoolid");
	//userId=request.getParameter("emailid");
	
	con=con1.getConnection();
	//st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	rs1=st1.executeQuery("select * from form_access_user_level where school_id='"+schoolId+"' and form_id='F00003' and uid='"+userId+"' and utype='S'");
	if(rs1.next())
	{
		status=rs1.getString("status");
		/*
			ac_id_arry=new char[emailStatus.length()];

		emailStatus.getChars(0,emailStatus.length(),ac_id_arry,0);
		if(ac_id_arry[7]=='1')
		{
			flag=true;
		}
		*/
		
	}
	rs1.close();
	st1.close();
	if(status==null || status=="")
		{
			status="00000000000";
		}
	rs2=st2.executeQuery("select S_status from form_access_group_level where form_id='F00003' and school_id='"+schoolId+"'");
	if(rs2.next())
	{
		status1=rs2.getString("S_status");
		/*
		ac_ids_arry=new char[emailStatus1.length()];
		
		if(emailStatus1.length()>4)
		{

			emailStatus1.getChars(0,emailStatus1.length(),ac_ids_arry,0);
			if(ac_ids_arry[7]=='1')
			{
				//url="/LBCOM/common/accessdenaid.html";
				flag=true;
			}
		}
		*/
				
	}
	rs2.close();
	st2.close();
	
	if(status1==null || status1=="")
	{
		status1="00000000000";
	}
	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function init()
{
	hide_loding();
}
</SCRIPT>
</head>
<!-- <DIV id=loading  style='WIDTH:100%; height:90%; POSITION: absolute; TEXT-ALIGN: center;border: 0px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0>
</DIV> -->
<!-- <body onload="init();" topmargin="20" leftmargin="20">
<form> -->
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
  <tr>
    <td valign="top" width="55%">
		<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
		  <tr>
			<td width="100%" valign="top"><jsp:include page="../coursemgmt/student/CourseHomeDB.jsp"/>
				   
		  </tr>
		</table>
    </td>
    <td valign="top" width="45%">
		<!-- <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
      <tr> -->
<%
		 if(status.charAt(10)=='0' && status1.charAt(10)=='0')
		{
%>
		<!-- <td valign="top"> --><jsp:include page="../WhiteBoard/student/StudentBoardsDB.jsp"/><!-- </td> -->
<%
		}
%>
      <!-- </tr>
	  </table> -->
	 <BR>
	 
    </td>
  </tr>
</table>
			
<!-- </form> -->
<%
}
catch(SQLException se)
	{
	        ExceptionsFile.postException("StudentHome.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
	   ExceptionsFile.postException("StudentHome.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}

	finally{
		try{
			
			
			if(st1!=null)
				st1.close();                //finally close the statement object
			if(st2!=null)
				st2.close();			
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("StudentHome.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
<!-- </body> -->
</html>