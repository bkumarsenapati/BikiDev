<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String folderName="",docName="",tag="",categoryId="",workId="",sessid="";
%>
<%
  folderName=request.getParameter("foldername");
  workId= request.getParameter("workid");
  docName=request.getParameter("docname");
  tag=request.getParameter("tag");
  categoryId=request.getParameter("cat");

  	sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
%>

<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>

<script language="javascript">

function ltrim ( s )
{
 return s.replace( /^\s*/, "" );
}
var count = 2;

function addchildele() {

	if (count>50) {
		alert("Maximum 50 files can be uploaded at a time.");
		return false;
	}
	var parentLayer = document.getElementById("fileLayer");
	var childele = document.createElement("input");
	childele.setAttribute("type","file");
	childele.setAttribute("name","ip");
	childele.setAttribute("id","file"+count);	
	childele.style.border = "1px solid red";
	childele.setAttribute("value","This is file"+count);
	count++;

	parentLayer.appendChild(childele);
	var br = document.createElement("br");
	parentLayer.appendChild(br);
}

function check() {
  var y=document.multifiles;
  var flag=true;
  var t='<%=tag%>';
  if(t=="z")  {
	   for(i=0;i<y.length;i++) {
			if(y[i].name=="ip")  { 
				   var name=ltrim(y[i].value);
				   var j= name.indexOf('.');	
				   var exe=name.substring(name.lastIndexOf('.'),name.length);
				  // if (exe!=".zip"){
					//   alert("Is it a 'Zip' file?");
					  // y[i].focus();
//						return false;
//				     }
			   }
          }
     }
	 else if (t=="u") {
		  for(i=0;i<y.length;i++) {
			if(y[i].name=="ip")  { 
				   var name=ltrim(y[i].value);
				   var j= name.indexOf('.');	
				   var exe=name.substring(name.lastIndexOf('.'),name.length);
				   if (exe==".zip"){
					   alert("'Zip' file(s) should be uploaded separately.");
					   y[i].focus();
						return false;
				     }
			   }
          }		
	 }
	 
	 document.getElementById("firstLayer").style.visibility='hidden';
	 document.getElementById("statusLayer").style.visibility='visible';


  } 



function view()
{
   var y=document.multifiles;
   var flag=false;
  	 for(i=0;i<y.length;i++) {
         if (y[i].name=="ip")  { 
		     if (ltrim(y[i].value)!="") {
	   	        flag=true;
		      }
	      }
      }
  	if (flag==false) {
		alert("No file is selected.");
	    return false;
	} else {
		return check();
	}
}

</script>

</HEAD>

<BODY>
 <%
     
	if (tag.equals("z")) {
		  out.println("<form name='multifiles' action ='UploadZipFiles.jsp?workid="+workId+"&foldername="+folderName+"&cat="+categoryId+"&docname="+docName+"'  method='post' enctype='multipart/form-data' onsubmit='javascript: return view();'>");
    } else if(tag.equals("u"))  {
		out.println("<form name='multifiles' action ='UploadMultipleFiles.jsp?workid="+workId+"&foldername="+folderName+"&cat="+categoryId+"&docname="+docName+"' enctype='multipart/form-data' method='post' onsubmit='javascript: return    view();'>");
    }

 %>

<div name="l0" id="firstLayer" style="border:0px solid blue; background-color:'white';width=150; ">

<div name="l1" id="fileLayer" style="border:2px solid blue; background-color:'white';width=100; ">
<input name="ip" type="file" id="file1" style="border:1px solid red; "/>
</div>
<br>
<%if (!tag.equals("z")){ %>
	<input type=image src="../images/baddmore.gif"  name="addmore" onclick="addchildele(); return false;">
<% } %>

<input type="image"  src="../images/bupload.gif" name="submit">
</div>

<div name="l2" id="statusLayer"  style="border:0px solid blue; background-color:white;width=280; visibility:hidden">
<font size="2" face="Arial" color="#CC0066"><b>File is uploading. It will take some time. <br>Please wait....</b><p><center>
<img name="status" src="../images/upload.gif">
</center>

</div>

</form>
</BODY>
</HTML>
