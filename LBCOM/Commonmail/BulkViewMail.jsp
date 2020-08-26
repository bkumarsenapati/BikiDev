<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Vector" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%

        ResultSet  rs=null;
	Connection con=null;
	Statement st=null;

	String userId="",schoolId="",attachPath="",emailId="",emailDetail="";
	String toUser="", fromUser="", subject="", dateString="", timeString="";
	String sortingBy="",sortingType="", start="";
	int attach=0;
	String toUserId="",cName="",sName="",disPath="",emailPath="",rStr="",urStr="";
	SortedSet rSet=null,urSet=null;	
	Vector rList=null,urList=null;
	
	String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}			
			
%>
<%
   try{
            attachPath = application.getInitParameter("schools_path");
	    userId = (String)session.getAttribute("emailid");
  	    schoolId = (String)session.getAttribute("schoolid");
	    if(userId.equals("Admin"))
	         userId = "admin";
	    emailId = userId + "@" + schoolId;
	    sortingBy=(String)request.getParameter("sortby");
	    sortingType=(String)request.getParameter("sorttype");
	    emailDetail = (String)request.getParameter("detail");
            start = request.getParameter("start");
	    
            con=db.getConnection();
	    st=con.createStatement();
	    
	    rs=st.executeQuery("select * from mail_bulk_student where user_id='"+emailId+"'");
	    if(rs.next())
	    {
	       rStr = rs.getString("read_bulk");
	       urStr = rs.getString("unread_bulk");
	    }
	    
	    rSet = new TreeSet();
	    urSet = new TreeSet();
	    StringTokenizer stkr = new StringTokenizer(rStr, ",");
	    while(stkr.hasMoreTokens())
	    {
	         rSet.add(stkr.nextToken());
	    }
	    StringTokenizer stkur = new StringTokenizer(urStr, ",");
	    while(stkur.hasMoreTokens())
	    {
	         urSet.add(stkur.nextToken());
	    }
	    if(urSet.contains(emailDetail))
	        urSet.remove(emailDetail);
	    if(!(rSet.contains(emailDetail)))
	         rSet.add(emailDetail);
	    urSet.removeAll(rSet);	 
		 
	    rStr="";
	    urStr="";
	    rList = new Vector(rSet);
	    urList = new Vector(urSet);
		 
	    for(int i=0;i<rList.size();i++)
	    {
	        if(i==0)
		    rStr = (String)rList.get(i);
		else
		    rStr = rStr + "," + rList.get(i);
	    }
	    for(int i=0;i<urList.size();i++)
	    {
	        if(i==0)
		    urStr = (String)urList.get(i);
		else
		    urStr = urStr + "," + urList.get(i);
	    }
	    	    	    
	    st.executeUpdate("update mail_bulk_student set read_bulk='"+rStr+"', unread_bulk='"+urStr+"' where user_id='"+emailId+"'");   
			    
	    rs=st.executeQuery("select * from mail_bulk where email_id='"+emailDetail+"'");
	    if(rs.next())
	    {
	         toUserId = rs.getString("user_id");
	         toUser = rs.getString("to_user");
		 fromUser = rs.getString("from_user");
		 subject = rs.getString("subject");
		 dateString = rs.getString("receive_date");
		 timeString = rs.getString("receive_time");
		 attach = rs.getInt("attachment");
	    }	
	    
	    StringTokenizer stk1 = new StringTokenizer(toUserId, "@");
	    if(stk1.hasMoreTokens())
	           cName = stk1.nextToken();
	    if(stk1.hasMoreTokens())
		   sName = stk1.nextToken();
	    
	     disPath = (String)session.getAttribute("schoolpath")+"/"+sName+"/bulkmail/"+cName+"/attachments/"+emailDetail;
             emailPath = (String)session.getAttribute("schoolpath")+"/"+sName+"/bulkmail/"+cName+"/email/"+emailDetail+".html"; 
             emailPath = emailPath.replaceFirst("/LBCOM","/");  	     
%>
<html>
<head>
<title></title>

<SCRIPT LANGUAGE="JavaScript">

	function deletemail(start, sortby, sorttype, str)
	{
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&delete="+str; 
	}

	function replymail(fromuser)
	{
	     window.location.href="Compose.jsp?fromuser="+fromuser+"&type=replybulk&eid="+<%=emailDetail%>; 
	}
	
	function fwdmail(fromuser)
	{
	     window.location.href="Compose.jsp?type=forwardbulk&eid="+<%=emailDetail%>; 
	}
	
	function movemail(start, sortby, sorttype, str)
	{
	     var obj=document.mailidslist.movelist;
	     var mfolder = obj.value;
	     if(mfolder=="")
	     {
	         alert("Select a folder to move from list");
		 return false;
	     }
	     window.location.href="BulkInbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&move="+str+"&mf="+mfolder; 
	}
	
	function go(name)
       {
		 window.open("<%=disPath%>/"+name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
        }
		
</SCRIPT>

</head>

<body  link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form  name="mailidslist">
 <table bgcolor="#EEE5DE" width="100%">
      <tr>
          <td ><font face="arial" size="2" color="#4B0082"><b>Bulk :</b></font><font face="arial" size="1" color="#4B0082"> Read Mail</font></td>
	  <td><font face="arial" size="1" color="#4B0082">[ <a href="#" onclick="return history.back();">Back to Bulk</a>]</font></td>
	  <td></td>
      </tr>    
 </table> 
 <table bgcolor="#F5DEB3" width="100%">
      <tr>
          <td width="10%"><input type="button" name="deletebtn" value="Delete" onclick="javascript: deletemail('<%=start%>','<%=sortingBy%>','<%=sortingType%>','<%=emailDetail%>')"></td>
	  
	  <td width="10%"><input type="button" name="replybtn" value="Reply" onclick="javascript: replymail('<%=fromUser%>')"></td>
	  
	   <td width="10%"><input type="button" name="fwdbtn" value="Forward" onclick="javascript: fwdmail('<%=fromUser%>')"></td>
	  <td width="20%"></td>
	  <td width="10%" align="right"><select name="movelist"><option value="">Select</option>
		<%
            		rs = st.executeQuery("select distinct folder from mail_folder where user_id='"+emailId+"'");
            		while(rs.next()){
		%>					  
                        <option value='<%=rs.getString("folder")%>'><%=rs.getString("folder")%></option>
		<% } %>					  
	                                  </select></td>
	  
	  <td width="40%" align="left"><input type="button" name="movebtn" value="Move" onclick="javascript: movemail('<%=start%>','<%=sortingBy%>','<%=sortingType%>','<%=emailDetail%>')"></td>
      </tr>
 </table>
 <table bgcolor="#EAEAEA" width="100%">
       
       <tr>
           <td width="60"><font face="arial" size="2" color="#4B0082"><b>From</b></font></td>
	   <td width="20"><font face="arial" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="arial" size="2" color="#4B0082"><%=fromUser%></font></td>	   
       </tr>
       
       <tr>
           <td width="60"><font face="arial" size="2" color="#4B0082"><b>To</b></font></td>
	   <td width="20"><font face="arial" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="arial" size="2" color="#4B0082"><%=toUser%></font></td>	   
       </tr>
       <tr>
           <td width="60"><font face="arial" size="2" color="#4B0082"><b>Subject</b></font></td>
	   <td width="20"><font face="arial" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="arial" size="2" color="#4B0082"><%=subject%></font></td>	   
       </tr>
       <tr>
           <td width="60"><font face="arial" size="2" color="#4B0082"><b>Date</b></font></td>
	   <td width="20"><font face="arial" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="arial" size="2" color="#4B0082"><%=dateString%> <%=timeString%></font></td>	   
       </tr>
 </table> 
 <table width='770'><tr><td width='750'>
 <font face='arial' size='3pt' color='#4B0082'><pre>
 <jsp:include page="<%=emailPath%>" flush="true"/>
 </pre></font>
 </td></tr></table>
 
 <%
 if(attach>0){
               String atUrl = attachPath + "/" + sName + "/bulkmail/" + cName + "/attachments/" + emailDetail;
               File attachFolder = new File(atUrl);
	       String flist[] = attachFolder.list();
	       if(flist.length>0)
	       {
 %>
 <table bgcolor="#EAEAEA" width="100%">
        <tr>
	     <td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="arial" size="2" color="#4B0082">Attachmets:</font></td>
	     <td width="10%"></td>
	     <td width="65%"></td>
	 </tr>
<%
               for(int i=0;i<flist.length;i++)
	       { 	
	           File f3 = new File(attachFolder, flist[i]);
		   float size = 0.0f;
		   String space = "";
		   String str1[] =null;
		   size = f3.length();
		   if(size>1048576)
	          {
			    size /=1048576;
			    space = size+"";
				space = space.replace('.','_');
				str1 = space.split("_");
			    space = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)) + "MB";
			  }
			  else if(size>1024)
			   {
	       		size /= 1024;
	       		space = size+"";
	       		space = space.replace('.','_');
	       		str1 = space.split("_");
	       		space = str1[0]+"."+((str1[1].length()<9)?str1[1].substring(0,1):str1[1].substring(0,2)) + "KB";
	    	  }else {
	       		space = size + "B";
	    	  }
%>
	
	<tr>
	    <td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="arial" size="1" color="#4B0082"><a href="#" onclick="go('<%=flist[i]%>')" target="_self"><%=flist[i]%></a></font>	           
	    </td>
	    <td width="10%"><font face="arial" size="1" color="#4B0082"><%=space%></font></td>
	    <td width="65%"></td>	     
	 </tr>
	
<%              }     %>	
	
 </table>
  
<%  } 
      }

}catch(Exception e){
		ExceptionsFile.postException("BulkViewMail.jsp","operations on database","Exception",e.getMessage());
		out.println("some error");
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("BulkViewMail.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
 
%> 
    
</form>
</body>
</html>
