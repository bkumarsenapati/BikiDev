<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.StringTokenizer"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
        synchronized public void copyFile(File fin, File fout) throws Exception 
         {
                  FileInputStream fis = new FileInputStream(fin);
                  FileOutputStream fos = new FileOutputStream(fout);
                  byte[] buf = new byte[1024];
                  int i = 0;
                  while((i=fis.read(buf))!=-1) {
                         fos.write(buf, 0, i);
                    }
                  fis.close();
                  fos.close();
         }
     
       synchronized public void copyFolder(File fin, File fout) throws Exception
     	{
                fout.mkdir();
                String[] children = fin.list();
 		if (children == null) {
		 // Either dir does not exist or is not a directory
 		} else {
 			for(int p=0;p<children.length;p++){
 				File f = new File(fin+"/"+children[p]);
 				File f1 = new File(fout+"/"+children[p]);
				if(f.isDirectory())
				    copyFolder(f,f1);		
				else
				    copyFile(f,f1);
			}
 		}
        }

%>
<%
	String userId="",schoolId="",attachFlag="",fromUser="",loginType="";
	String attachmentString ="";
	String flist[] = null;
	String tempUrl="";
	String type="", eId="", message="", subject="", epath="", apath="", spath="", timeStr="",bulkId=""; // reply and forward variables
	String attachStr="",attachedMsgPath="";         // reply and forward variables
	int len = 0;
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
%>
<%
try{
	session = request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	userId = (String)session.getAttribute("emailid");
	loginType = (String)session.getAttribute("logintype");
	if(userId.equals("Admin"))
	        userId = "admin";
	attachFlag = request.getParameter("attach");
	fromUser = request.getParameter("fromuser");
	if(fromUser==null)
	     fromUser = "";

	tempUrl = application.getInitParameter("schools_path");
	tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
	
	File tempFolder = new File(tempUrl);
	
	if(attachFlag!=null)	
	{
		if(tempFolder.isDirectory())
			 flist = tempFolder.list();
		for(int i=0;i<flist.length;i++)
		{
		      if(i==0)
		          attachmentString = flist[i];
		      else
		          attachmentString = attachmentString + "," + flist[i];	  
		}	 
	}else {
	             if(tempFolder.isDirectory())
		      {   flist = tempFolder.list();
	                  for(int i=0;i<flist.length;i++)
		            {
		                 File file = new File(tempFolder,flist[i]);
				 file.delete();
		            }
			   tempFolder.delete(); 
		       }else
		             tempFolder.delete();	
	      }	

	     
	     	     
	// code for reply and forward starts here     
	    type = request.getParameter("type");
	    eId = request.getParameter("eid");

		String tUser="";
	    spath = application.getInitParameter("schools_path");
		
	    
	    if((type!=null)&&(type.equals("reply")))
	    {
	         con = con1.getConnection();
		 st = con.createStatement();
		 tUser=request.getParameter("toUser");
		 rs = st.executeQuery("select subject, receive_date, receive_time, from_user from mail_box where user_id='"+userId+"@"+schoolId+"' and email_id='"+eId+"' and from_user='"+tUser+"'");
		 if(rs.next())
		 {
		     subject = rs.getString("subject");
		     timeStr = "On " + rs.getString("receive_date") + "  " + rs.getString("receive_time") + " " + rs.getString("from_user")+" wrote : ";
		 }
		 subject = "Re : "+subject;
		 epath = spath + "/" + schoolId + "/" + userId + "/email/" + eId + ".html"; 
		 
	         File f1 = new File(epath);
		 Reader fr = new FileReader(f1); 
		 BufferedReader br = new BufferedReader(fr);
		 String buff = br.readLine();
		 while(buff!=null) {
                         message = message + "\n" + buff;
			 buff = br.readLine();
                 }
		 message = message.replaceAll("\n", "\n");
		 message = "\n\n\n\n"+timeStr + "\n" + message;
		 
	    }else if((type!=null)&&(type.equals("forward")))
	    {
	         con = con1.getConnection();
		 st = con.createStatement();
		 tUser=request.getParameter("toUser");
		 rs = st.executeQuery("select subject, receive_date, receive_time, from_user, to_user from mail_box where user_id='"+userId+"@"+schoolId+"' and email_id='"+eId+"' and from_user='"+tUser+"'");
		 if(rs.next())
		 {
		     subject = rs.getString("subject");
		     message = "\n\n\n\n---------Forwarded message-----------";
		     message +="\nFrom: "+rs.getString("from_user");
		     message +="\nDate: "+rs.getString("receive_date") + "  " + rs.getString("receive_time");
		     message +="\nSubject: "+subject;
		     message +="\nTo:"+rs.getString("to_user");		     
		 }
		 subject = "Fwd : "+subject;

		  //	 forward
		  
			epath = spath + "/" + schoolId + "/" + userId + "/email/" + eId + ".html";
			 
	         File f1 = new File(epath);
		 Reader fr = new FileReader(f1); 
		 BufferedReader br = new BufferedReader(fr);
		 String buff = br.readLine();
		 while(buff!=null) {
                         message = message + "\n" + buff;
			 buff = br.readLine();
                 }
		 message = message.replaceAll("\n", "\n");
		 message = "\n\n\n\n"+timeStr + "\n" + message;

		 //upto here

		 apath = spath + "/" + schoolId + "/" + userId + "/attachments/";
		 
		 File fin = new File(apath + eId);
		 if(fin.isDirectory())
		 {
		    File ftmp = new File(apath + "temp");
		    ftmp.mkdirs();
		    copyFolder(fin, ftmp);
		    String flist1[] = fin.list();
		    for(int i=0;i<flist1.length;i++)
		     {
			  if(i==0)
				attachStr = flist1[i];
			  else
				attachStr = attachStr + "," + flist1[i];	  
		     }	
						
		 }else{   fin.delete(); }	
		 attachedMsgPath = schoolId + "/" + userId + "/email/" + eId; 
		 
		 	 		  
	    }else if((type!=null)&&(type.equals("replybulk")))
	    {
	         con = con1.getConnection();
		 st = con.createStatement();
		 rs = st.executeQuery("select subject, receive_date, receive_time, from_user, user_id from mail_bulk where email_id='"+eId+"'");
		 if(rs.next())
		 {
		     subject = rs.getString("subject");
		     timeStr = "On " + rs.getString("receive_date") + "  " + rs.getString("receive_time") + " " + rs.getString("from_user")+" wrote : ";
		     bulkId = rs.getString("user_id");
		 }
		 subject = "Re : "+subject;
		 String tmpStr="";
		 StringTokenizer stkb = new StringTokenizer(bulkId,"@");
		 if(stkb.hasMoreTokens())
		       tmpStr = stkb.nextToken();
		 if(stkb.hasMoreTokens())
		       tmpStr = stkb.nextToken()+"/bulkmail/"+tmpStr;
		 epath = spath + "/" + tmpStr + "/email/" + eId + ".html"; 
	         File f1 = new File(epath);
		 Reader fr = new FileReader(f1); 
		 BufferedReader br = new BufferedReader(fr);
		 String buff = br.readLine();
		 while(buff!=null) {
                         message = message + "\n" + buff;
			 buff = br.readLine();
                 }
		 message = message.replaceAll("\n", "\n");
		 message = "\n\n\n\n"+timeStr + "\n" + message;
		 
	    }else if((type!=null)&&(type.equals("forwardbulk")))
	    {
	         con = con1.getConnection();
		 st = con.createStatement();
		 rs = st.executeQuery("select subject, receive_date, receive_time, from_user, to_user, user_id from mail_bulk where  email_id='"+eId+"'");
		 if(rs.next())
		 {
		     subject = rs.getString("subject");
		     message = "\n\n\n\n---------Forwarded message-----------";
		     message +="\nFrom: "+rs.getString("from_user");
		     message +="\nDate: "+rs.getString("receive_date") + "  " + rs.getString("receive_time");
		     message +="\nSubject: "+subject;
		     message +="\nTo:"+rs.getString("to_user");
		     bulkId = rs.getString("user_id");		     
		 }
		 subject = "Fwd : "+subject;
		 //	 Bulk forward
		 	epath = spath + "/" + schoolId + "/" + userId + "/email/" + eId + ".html";
			
			 File f1 = new File(epath);
		 Reader fr = new FileReader(f1); 
		 BufferedReader br = new BufferedReader(fr);
		 String buff = br.readLine();
		 while(buff!=null) {
                         message = message + "\n" + buff;
			 buff = br.readLine();
                 }
		 message = message.replaceAll("\n", "\n");
		 message = "\n\n\n\n"+timeStr + "\n" + message;

		 //upto here
		 String tmpStrF="";
		 StringTokenizer stkc = new StringTokenizer(bulkId,"@");
		 if(stkc.hasMoreTokens())
		       tmpStrF = stkc.nextToken();
		 if(stkc.hasMoreTokens())
		       tmpStrF = stkc.nextToken()+"/bulkmail/"+tmpStrF;
		 		 
		 apath = spath + "/" + schoolId + "/" + userId + "/attachments/";
		 File finfb = new File(spath + "/" + tmpStrF + "/attachments/" + eId);
		 if(finfb.isDirectory())
		 {
		    File ftmpfb = new File(apath + "temp");
		    ftmpfb.mkdirs();
		    copyFolder(finfb, ftmpfb);
		    String flist2[] = finfb.list();
		    for(int i=0;i<flist2.length;i++)
		     {
			  if(i==0)
				attachStr = flist2[i];
			  else
				attachStr = attachStr + "," + flist2[i];	  
		     }	
						
		 }else{   finfb.delete(); }	
		 attachedMsgPath = tmpStrF + "/email/" + eId; 
		 
	    }
	
	// code for reply and forward ends here
	     

}catch(IOException ioe){
                System.out.println("error is "+ioe);
	ExceptionsFile.postException("Compose.jsp","IOException","Exception",ioe.getMessage());
}
catch(Exception e){
	System.out.println("error is "+e);
	ExceptionsFile.postException("Compose.jsp","some exception","Exception",e.getMessage());

}
finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("Compose.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQLExeption in Compose.jsp is..."+se);
		}

    }

%>

<html>

<head>
<title>.::Welcome to Learnbeyond::.</title>
<!-- TinyMCE -->
<script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		nowrap : false,
		auto_focus : "mess",
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript">
<!--
        function validate(frm)
	{
		//alert("validate fn called");
		//alert("frm..."+frm);
		//alert("subject : "+frm.subject.value);
		//var sb =  trim(frm.subject.value);
		var sb =  frm.subject.value;
		//alert("sb "+sb);
		
		
		//alert("santhosh "+frm.toaddress.value);
		//alert("toaddress start");
		//alert("before if "+frm.toaddress.value);
	      
// 	     if(trim(frm.toaddress.value)=="")
// 	     {
// 	         alert("Insert User Id");
// 		 	 return false;
// 	     }
	    // alert("after if "+frm.toaddress.value);
	     if(frm.toaddress.value.length>200)
	     {
	         //alert("Please enter less than 200 characters in email address field");
		 return false;
	     }
	    // alert("after length "+frm.toaddress.value);
	    // alert("sb "+sb.length);
	     
	     if(sb.length>100)
	     {
	         //alert("Subject should be less than 100 characters ");
		 return false;
	     }
	        
	     //replacequotes();
	     
	     //alert(<%=attachedMsgPath%>);
		// alert("sent");
		// alert(frm.rtype.value);
	     if(frm.rtype.value=="normal")
	     {
	          <% 
	          if((type!=null)&&((type.equals("forward"))||(type.equals("forwardbulk")))){
	          %>
	                  
	          
	          
	          document.composeform.action = "Sent.jsp?amsg=<%=attachedMsgPath%>";
		   
		   
		   
		   <%   }else{
		   
		   %>
		        
		   document.composeform.action = "Sent.jsp";
		   <%   }    %>
	     }else if(frm.rtype.value=="bulk")
	      {
	             <% if((type!=null)&&((type.equals("forward"))||(type.equals("forwardbulk")))){%>
	                   document.composeform.action = "BulkSent.jsp?amsg=<%=attachedMsgPath%>";
		   <%   }else{%>
		           document.composeform.action = "BulkSent.jsp";
		   <%   }    %>
	      }
	      return true;
	}      

	function attachwin()
	{
	   var attach_window;
	  // alert("before calling attachment.jsp");
	  attach_window = window.open("/LBCOM/Commonmail/Attachment.jsp","attach_window","width=400,height=300");
	 //  attach_window = window.open("/LBCOM/HelloWorld.jsp","attach_window","width=400,height=300");
	   attach_window.moveTo(200,150);
	}

       function addresswin()
	{
	   var address_window;
	   var logint = '<%=loginType%>';
	   if(logint=='admin')
	   	address_window = window.open("/LBCOM/Commonmail/AddressFrame.jsp","address_window","width=700,height=400");
	   else
	   	address_window = window.open("/LBCOM/Commonmail/AddressFrame.jsp","address_window","width=600,height=400");
	   address_window.moveTo(150,150);
	}
	
	function bulkaddresswin()
	{
	   var bulk_address_window;
	   bulk_address_window = window.open("/LBCOM/Commonmail/BulkAddressFrame.jsp","address_window","width=400,height=400");
	   bulk_address_window.moveTo(200,150);
	}
		
	function resetto()
	{
	    var obj = document.getElementById("toaddress");
	    var obj1 = document.getElementById("rtype");
	    obj.value = "";
	    obj1.value = "humpy";
	}
	 
    function sendAway(){
		alert("I am here");
      document.composeform.message.focus();
      
    }
   
	
// -->
</script>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
<form name="composeform" method="post" onsubmit="return validate(this);">

<table bgcolor="#EEE5DE" width="100%">
<tr>
	<td width="100%" height="18" align="left">
		<font face="verdana" size="2" color="#000000"><b>Compose Mail - </b></font>
		<font face="verdana" size="1">Plain Text</font>
	</td>
</tr>
</table>

<table width="100%" bgcolor="#FFD89D">
<tr>
	<td width="100%" align="left">
		<input type="submit" name="submit" value="Send">&nbsp;&nbsp;
		<input type="button" name="cancelbtn" value="Cancel" onClick="javascript: history.back();">
	</td>
</tr>
</table>

<table width="100%" border="0">
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">To:</font></td>
	<td width="85%">
 		<input type="text" name="toaddress" id="toaddress" value='<%=fromUser%>'size="60" oncontextmenu="return false" onkeydown="return true" onkeypress="return true">
<!-- <input type="text" name="toaddress" id="toaddress" value="teacher5@training"size="60" oncontextmenu="return false" onkeydown="return true" onkeypress="return true"> -->
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="addressbtn" value="Insert Address" onclick="javascript: addresswin()">&nbsp;
<%  
		if(!(loginType.equals("student")))
		{
%>	    
		    <input type="button" name="addressbtn" value="Insert bulk Address" onclick="javascript: bulkaddresswin()">&nbsp;
<% 
		}
%>	  
			<input type="button" name="resetbtn" value="Reset" onclick="javascript: resetto()"></td>
</tr>
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">Subject:</font></td>
	<td width="85%">
 		<input type="text" id="subject" name="subject" value="<%=subject%>" size="60"> &nbsp;&nbsp; 
<!-- <input type="text" id="subject" name="subject" value="Hi123" size="60">&nbsp;&nbsp; -->
		<input type="checkbox" name="sentcheck" value="sent" checked>&nbsp;
		<font face="verdana" size="1">Save in Sent Mails</font>
	</td>
</tr>
<tr>
	<td width="15%" align="right"><font face="verdana" size="2">Attachments:</font></td>
	<td width="85%">
 		<input type="text" name="attachment" id="attachid" size="60" value="<%=attachStr%>" disabled>&nbsp;&nbsp; 
<!-- <input type="text" name="attachment" id="attachid" size="60" value="psk.jpg" disabled>&nbsp;&nbsp; -->
		<input type="button" id="attachbtn" name="attachbtn" value="Add/Remove Attachment" onclick="javascript: attachwin()">
	</td>
</tr>

<%
		if((type!=null)&&((type.equals("forward"))||(type.equals("forwardbulk"))))
		{
%>
<tr>
	<td width="15%">&nbsp;</td>
	<td width="85%" align="center"><font face="verdana" size="2">Note: forwarded message attached.</font></td>
</tr>
<%     
		}
%>	
<tr>
	<td width="15%"></td>
 	 <td width="85%"><textarea cols="70" rows="13" name="message" wrap="off" id="message"><%=message%></textarea></td>
<!-- <td width="85%"><textarea cols="70" rows="13" name="message" wrap="off" id="message">Santhosh123</textarea></td> -->
</tr>
</table>
<table width="100%" bgcolor="#FFD89D">
<tr>
	<td width="100%" align="left">
		<input type="submit" name="submit" value="Send">&nbsp;&nbsp;
		<input type="button" name="cancelbtn" value="Cancel" onClick="javascript: history.back();">
	</td>
</tr>
</table>

<input type="hidden" id="rtype" name="rtype" value="normal">

</form>
</body>
</html>