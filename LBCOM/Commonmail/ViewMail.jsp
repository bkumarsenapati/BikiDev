<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.StringTokenizer"%>
<%@ page import="java.util.SortedSet,java.util.TreeSet,java.util.Iterator,java.util.Calendar,utility.FileUtility"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%

    ResultSet  rs=null;
	Connection con=null;
	Statement st=null;

	String userId="",schoolId="",queryString="",folderName="",attachPath="",emailId="",emailDetail="";
	String toUser="", fromUser="", subject="", dateString="", timeString="", message="",appPath="";;
	String sortingBy="",sortingType="", start="";
	String disPath="",emailPath="";
	String tuid="", ttime="", tdate="", tattach="";
	int attach=0;
	String frmUser="";
		
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
			appPath = application.getInitParameter("app_path");
			
	    userId = (String)session.getAttribute("emailid");
  	    schoolId = (String)session.getAttribute("schoolid");
	    if(userId.equals("Admin"))
	         userId = "admin";
	    emailId = userId + "@" + schoolId;
	    folderName = request.getParameter("folder");
	    sortingBy=(String)request.getParameter("sortby");
	    sortingType=(String)request.getParameter("sorttype");
	    emailDetail = (String)request.getParameter("detail");
		frmUser = (String)request.getParameter("fromuser");
		start = request.getParameter("start");
	    
        con=db.getConnection();
	    st=con.createStatement();
	    
	    st.executeUpdate("update mail_box set mark_read='1' where user_id='"+emailId+"' and email_id='"+emailDetail+"' and from_user='"+frmUser+"'");   

	    rs=st.executeQuery("select * from mail_box where user_id='"+emailId+"' and email_id='"+emailDetail+"' and from_user='"+frmUser+"'");
	    if(rs.next())
	    {
		     toUser = rs.getString("to_user");
			 fromUser = rs.getString("from_user");
			 subject = rs.getString("subject");
			 dateString = rs.getString("receive_date");
			 timeString = rs.getString("receive_time");
			 attach = rs.getInt("attachment");
	    }	
	    
			//disPath = (String)session.getAttribute("schoolpath")+"/"+schoolId+"/"+userId+"/attachments/"+emailDetail;
			disPath = (String)session.getAttribute("schoolpath")+""+schoolId+"/"+userId+"/attachments/"+emailDetail;
			System.out.println("disPath...."+disPath);
			System.out.println((String)session.getAttribute("schoolpath"));
            emailPath = (String)session.getAttribute("schoolpath")+""+schoolId+"/"+userId+"/email/"+emailDetail+".html"; 
            System.out.println("beofre replace emailPath...."+emailPath);
             
			emailPath = emailPath.replaceFirst("/LBCOM","");
			//emailPath = emailPath.replaceAll("//","/");
			 System.out.println("after replace emailPath...."+emailPath);
			 System.out.println("appPath+emailPath...."+appPath+emailPath);

			// Physical email file reading from here
			
			File fwdMsgFile = new File(appPath+emailPath);
			System.out.println("fwdMsgFile...."+fwdMsgFile);
			   if((fwdMsgFile.exists())&&(fwdMsgFile.isFile()))
			   {
				   System.out.println("..fwdMsgFile. is exists and is a file...");	
				   Reader fr = new FileReader(fwdMsgFile); 
						BufferedReader br = new BufferedReader(fr);
						String buff = br.readLine();
						while(buff!=null)
						{
							message = message + "\n" + buff;
							buff = br.readLine();
						}
			   }
			   message=message.replaceAll("<pre>","<p>");
			   message=message.replaceAll("</pre>","</p>");

			// Upto here
			 
	      
%>
<html>
<head>

<title></title>

<SCRIPT LANGUAGE="JavaScript">

	function deletemail(start, foldername, sortby, sorttype, str)
	{
	     window.location.href="Inbox.jsp?start="+start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&delete="+str; 
	}

	function replymail(fromuser)
	{
	     window.location.href="Compose.jsp?fromuser="+fromuser+"&toUser=<%=frmUser%>&type=reply&eid=<%=emailDetail%>"; 
	}
	
	function fwdmail(fromuser)
	{
	     window.location.href="Compose.jsp?type=forward&eid=<%=emailDetail%>&toUser=<%=frmUser%>"; 
	}
	
	function movemail(start, foldername, sortby, sorttype, str)
	{
	     var obj=document.mailidslist.movelist;
	     var mfolder = obj.value;
	     if(mfolder=="")
	     {
	         alert("Select a folder to move from list");
		 return false;
	     }
	     window.location.href="Inbox.jsp?start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&folder="+foldername+"&move="+str+"&mf="+mfolder; 
	}
	
       function go(name)
       {
		 //alert("<%=disPath%>");
		 //alert(name);
    	   window.open("<%=disPath%>/"+name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
    	 //  window.open(name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
        }

		
</SCRIPT>

</head>

<body  link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form  name="mailidslist">
 <table bgcolor="#EEE5DE" width="100%">
      <tr>
          <td ><font face="verdana" size="2" color="#4B0082"><b><%=folderName%> :</b></font><font face="verdana" size="1" color="#4B0082"> Read Mail</font></td>
	  <td><font face="verdana" size="1" color="#4B0082">[ <a href="#" onclick="return history.back();">Back to <%=folderName%></a>]</font></td>
	  <td></td>
      </tr>    
 </table> 
 <table bgcolor="#F5DEB3" width="100%">
      <tr>
          <td width="10%"><input type="button" name="deletebtn" value="Delete" onclick="javascript: deletemail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>','<%=emailDetail%>')"></td>
	  
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
	  
	  <td width="40%" align="left"><input type="button" name="movebtn" value="Move" onclick="javascript: movemail('<%=start%>','<%=folderName%>','<%=sortingBy%>','<%=sortingType%>','<%=emailDetail%>')"></td>
      </tr>
 </table>
 <table bgcolor="#EAEAEA" width="100%">
       <%  if(!folderName.equals("Sent")){    %>
       <tr>
           <td width="60"><font face="verdana" size="2" color="#4B0082"><b>From</b></font></td>
	   <td width="20"><font face="verdana" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="verdana" size="2" color="#4B0082"><%=fromUser%></font></td>	   
       </tr>
       <%    }        %>
       <tr>
           <td width="60"><font face="verdana" size="2" color="#4B0082"><b>To</b></font></td>
	   <td width="20"><font face="verdana" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="verdana" size="2" color="#4B0082"><%=toUser%></font></td>	   
       </tr>
       <tr>
           <td width="60"><font face="verdana" size="2" color="#4B0082"><b>Subject</b></font></td>
	   <td width="20"><font face="verdana" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="verdana" size="2" color="#4B0082"><%=subject%></font></td>	   
       </tr>
       <tr>
           <td width="60"><font face="verdana" size="2" color="#4B0082"><b>Date</b></font></td>
	   <td width="20"><font face="verdana" size="2" color="#4B0082"><b>:</b></font></td>
	   <td width="670"><font face="verdana" size="2" color="#4B0082"><%=dateString%> <%=timeString%></font></td>	   
       </tr>
 </table> 



<table width='100%'>
 <tr>
	<td width="100%"><%=message%></td>
</tr>
</table>

 <%
	 
 if(attach>0){
               String atUrl = attachPath + "/" + schoolId + "/" + userId + "/attachments/" + emailDetail;
               String fileUrl="";
	       File attachFolder = new File(atUrl);
	       attachFolder.mkdirs();
	       
		   

		   String flist[] = attachFolder.list();
	       int length = flist.length;
	       if(length>0)
	       {
 %>
 <table bgcolor="#EAEAEA" width="100%">
        <tr>
	     <td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" size="2" color="#4B0082">Attachmets:</font></td>
	     <td width="10%"></td>
	     <td width="65%"></td>
	 </tr>
<%
               for(int i=0;i<flist.length;i++)
	       {  
	           File f3 = new File(attachFolder, flist[i]);
		   
		  
		   FileUtility fu=new FileUtility();
		   
		   String renName=flist[i];
		   renName=renName.replace('#','_');
		   renName=renName.replaceAll("'","_");
		   renName=renName.replaceAll("&","_");
		   fu.renameFile(attachFolder+"/"+flist[i],attachFolder+"/"+renName);
		   flist[i]=renName;
		   

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
 	<td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" size="1" color="#4B0082"><a href="#" onclick="go('<%=flist[i]%>')" target="_self"><%=flist[i]%></a></font></td>
<%-- <td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" size="1" color="#4B0082"><a href="#" onclick="go('http://localhost:4480/LBCOM/schools/training/teacher5/attachments/2019415/Penguins.jpg')" target="_self"><%=flist[i]%></a></font></td> --%>
<%-- <td width="25%">&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" size="1" color="#4B0082"><a href="#" onclick="go('http://localhost:4480/LBCOM/coursemgmt/teacher/images/iassign.gif')" target="_self"><%=flist[i]%></a></font></td> --%>

	    <td width="10%"><font face="verdana" size="1" color="#4B0082"><%=space%></font></td>
	    <td width="65%"></td>
	 </tr>
	
<%              }     %>	
	
 </table>
  
<%  } 
      }

}catch(Exception e){
		ExceptionsFile.postException("ViewMail.jsp","operations on database","Exception",e.getMessage());
		out.println("some error");
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ViewMail.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
 
%> 
    
</form>
</body>
</html>
