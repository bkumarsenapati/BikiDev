<%@ page import="java.io.*,java.util.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String checked="",unchecked="",fileName="",workId="",docName="",categoryId="";
	String sessid="",path="";
	Hashtable hsFiles=null;
%>
<%
	
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if (sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	hsFiles=(Hashtable)session.getAttribute("hsfiles");
	

	workId=request.getParameter("workid");
	docName=request.getParameter("docname");
	categoryId=request.getParameter("cat");
	checked=request.getParameter("checked");
	unchecked=request.getParameter("unchecked");
	
	StringTokenizer stk=new StringTokenizer(unchecked,",");
	String id,del;
	del=" ";
	while(stk.hasMoreTokens()) {
			 id=stk.nextToken();			
			 if ((hsFiles.containsKey(id))) {	  

				 del=id+",";
				 hsFiles.remove(id);
			 }
	}
	stk=new StringTokenizer(checked,",");

	while(stk.hasMoreTokens()){
			id=stk.nextToken();
			
			 if (!(hsFiles.containsKey(id)))
				 hsFiles.put(id,id);
	}




	path=request.getParameter("path");
    if ((hsFiles.size()==0)&&(del.equals(" "))) {
		out.println("<script>alert('Already Published');");		out.println("parent.bottompanel.location.href='CourseFileManager.jsp?foldername="+path+"&docname="+docName+"&cat="+categoryId+"&workid="+workId+"&tag=&status=';</script>");
    }else {%>	
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<script language="javascript" src="../../validationscripts.js"></script> 
<META NAME="Generator" CONTENT="Microsoft FrontPage 4.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">

<script>
  
  function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}

  function goback() {
	    parent.bottompanel.location.href='CourseFileManager.jsp?foldername=<%=path%>&docname=<%=docName%>&cat=<%=categoryId%>&workid=<%=workId%>&tag=&status=';
 }
	
  function check(){
	window.document.desc.delet.value="<%=del%>";
	
	var obj=window.document.desc;
	for(i=0;i<obj.elements.length;i++) {
		if (obj.elements[i].type=="text") {
			if (trim(obj.elements[i].value)=="") {
				alert("You forgot to enter description");
				return false;
			}

		}
	}
//	alert('<%=del%>');
	return true;

  }
</script>

</HEAD>
<BODY>
<form name="desc" method="post" action="/LBCOM/coursemgmt.Publish?mode=AV&workid=<%=workId%>&cat=<%=categoryId%>&docname=<%=docName%>&path=<%=path%>&checked=<%=checked%>&unchecked=<%=unchecked%>" onsubmit=" return check();">
<div align="center">
<table border="0" width="700" cellspacing="1" bordercolordark="#C2CCE0" >
<tr>
<td>
<a href="#" onclick="goback();"><font face="arial" size="2"><b> Back</b></font></a>

</td>
</tr>
</table>

<div align="center">
  <center>
	<!--workid=<%=workId%>&cat=<%=categoryId%>&docname=<%=docName%>&path=<%=path%>&checked=<%=checked%>&unchecked=<%=unchecked%>-->

<table border="0" width="700" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
    <td width='300' bgcolor="#BEC9DE" height='21'><b><font size='2' face='Arial' color='#000080'><b> File Name </b></font></td>
	<td width='400' bgcolor="#BEC9DE" height='21'>
      <p align="center"><b><font size='2' face='Arial' color='#000080'><b> Enter Description </b></font></p>
      </b></td></tr>
 <%
    /*Enumeration e=hsFiles.elements();	
	while(e.hasMoreElements()) {
	    	fileName=(String)e.nextElement();
		    out.println("<tr><td width='100' bgcolor='#CECBCE' height='21'><b><font size='2' face='Arial' color='#000080'><b>"+fileName+"</b></font></td>");
		    out.println("<td width='254' bgcolor='#CECBCE' height='21'><b><font size='2' face='Arial' color='#000080'><b><textarea name='"+fileName+"'cols='65'row='1'></textarea></b></font></td></tr>");
	}*/
	Enumeration e=hsFiles.keys();	
	while(e.hasMoreElements()) {
			
	    	fileName=(String)e.nextElement();
			
		    out.println("<tr><td  bgcolor='#EEEEEE' height='21'><b><font size='2' face='Arial' color='#000080'><b>"+fileName+"</b></font></td>");
			if (fileName.equals((String)hsFiles.get(fileName))) {
			    out.println("<td  bgcolor='#EEEEEE' height='21'><b><font size='2' face='Arial' color='#000080'><b><input size='75' maxlength='100' name='"+fileName+"' type='text' oncontextmenu=\"return false\" onkeypress=\"return AlphaNumbersOnly(this, event)\" ></b></font></td></tr>");
			}
			else {
				out.println("<td  bgcolor='#EEEEEE' height='21'><b><font size='2' face='Arial' color='#000080'><input size='75' maxlength='100' type='text' name='"+fileName+"' oncontextmenu=\"return false\" onkeypress=\"return AlphaNumbersOnly(this, event)\" value=\""+(String)hsFiles.get(fileName)+"\"></font></td></tr>");

			}
	}
	session.putValue("hsfiles",hsFiles);
  }
%>
</table>
  </center>
</div>
<input type="image" src="../images/submit.gif">
<input type="hidden" name="delet" value="">
</form>
</BODY>
</HTML>
