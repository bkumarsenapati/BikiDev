<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	private String check4Opostrophe(String str){
		str=str.replaceAll("\'","\\\\\'");
		str=str.replaceAll("\"","&quot;");
		return(str);
	}
%>
<%
	String dirName="",schoolId="",topicDesc="";
	File file=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean flag=false;
	int fdate=0,cdate=0,uType=0;


%>
<html>
<head>
<title></title>
<style>
<!--
a{text-decoration:none}
//-->
</style>
</head>
<body>
<center>
<center>
  <table border="1" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td colspan="2" align="center"><font face="Arial" size="2" color="maroon"><b>Available Notices</td>
	</tr>
    <tr>
      <td width="70%" align="left">&nbsp;<font face="Arial" size="2" color="maroon"><b>Title</td>
      <td width="30%" align="center"><font face="Arial" size="2" color="maroon"><b>Opened Date</td>
    </tr>

<%
try{
	dirName=request.getParameter("dirname");
	schoolId=(String)session.getAttribute("schoolid");
	if(schoolId==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	flag=false;
	if(((String)session.getAttribute("logintype")).equals("student"))
		uType=2;
	else
		uType=1;
	/*file = new File("C:/Tomcat 5.0/webapps/LBCOM/schools/"+schoolId+"/"+dirName);
	String filelist[]=file.list();
	if(filelist.length>0){
		out.println("<tr><td colspan='2' align='center'><font face='Arial' size='2'><b>Available Documents are..</td></tr>");
		for(int i=0;i<filelist.length;i++)
			out.println("<tr><td width='11%' align='center'><a href='javascript://' onclick=\"return openFile('"+filelist[i]+"');\"><font face='Arial' size='2'>View</td><td width='91%'><font face='Arial' size='2'>&nbsp;<b>"+filelist[i]+"</td></tr>");
	}
	else
		out.println("<tr><td colspan='2' align='center'><font face='Arial' size='2'><b>No Documents Available</td></tr>");*/
	
	con = con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select filename,title,from_date,description,to_days(from_date) fdate,to_days(curdate()) cdate from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' and from_date<=curdate() and to_date>=curdate() and (user_type="+uType+" or user_type=0) order by from_date desc");
	while(rs.next()){
		flag=true;
		fdate=rs.getInt("fdate");
		cdate=rs.getInt("cdate");
		topicDesc=rs.getString("description");
		topicDesc=check4Opostrophe(topicDesc);
		if(rs.getString("filename").indexOf("null")==-1){
%>
   <tr>
      <td width="70%" align="left">&nbsp;<a href="javascript://" onclick="return openFile('<%=rs.getString("filename")%>','<%=topicDesc%>');"><b><font face="Arial" size="2" color="blue"><%=rs.getString("title")%>
<%
		}
	  else{
%>
<td width="70%" align=left><font face="Arial" size="2" color="blue">&nbsp;<a href="javascript://" onclick="return openMsg('<%=topicDesc%>')"><%=rs.getString("title")%></font>
<%	}
		  if(cdate-fdate==0)
			out.println("<img src='images/newitem.gif' border='0'>");
%>		  
	  </a></td>
      <td width="30%" align="center">&nbsp;<font face="Arial" size="2"><b><%=rs.getDate("from_date")%></td>
   </tr>
<%
	}
	 if(flag==false)
		 out.println("<tr><td colspan='2' align='center'><font face=\"Arial\" size=\"2\"><b>No Notices Available</td></tr>");
}
catch(Exception e){
	ExceptionsFile.postException("ShowDeptFiles.jsp","operations on database","Exception",e.getMessage());
	out.println("Exception "+e);
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null &&!con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowDeptFiles.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
%>
  
  </table>
</center>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*function openFile(file){
	//"Document","resizable=yes,scrollbars,width=800,height=550,toolbars=no");
	window.open("/LBCOM/schools/<%=schoolId%>/<%=dirName%>/"+file,"Document","resizable=yes,scrollbars=yes,width=550,height=450,toolbars=no");
	return false;
}*/
function openMsg(comment){
	var newWin=window.open('','Notice',"resizable=no,toolbars=no,scrollbar=yes,width=350,height=278,top=275,left=300");
	newWin.document.writeln("<html><head><title>Notice</title></head><body><font face='Arial' size=2 color='blue'><u>Description</u></font><br><font face='Arial' size=2>"+comment+"</font></body></html>");
	return false;
}
function openFile(file,msg){
	//window.open("/LBCOM/schools/<%=schoolId%>/<%=dirName%>/"+file,"FileWindow","toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650");
	parent.parent.studenttopframe.studentNoticeBoardWin = window.open("/LBCOM/schoolAdmin/PopFrame.jsp?dir=<%=dirName%>&file="+file+"&msg="+msg,'Notice',"resizable=no,toolbars=no,scrollbar=yes,width=650,height=450,top=75,left=100");
	return false;
}

//-->
</SCRIPT>
</html>