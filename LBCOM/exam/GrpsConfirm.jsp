<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String classId="",courseName="",courseId="",examId="",examType="",checked="",disabled="",examName="",enableMode="";
	int noOfGrps=0;
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	disabled="";	
	
	examId=request.getParameter("examid");
	examName=request.getParameter("examname");
	examType=request.getParameter("examtype");
	enableMode=request.getParameter("enableMode");
	noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
	if (noOfGrps>=1)
		disabled="";
	else
	    disabled="disabled";	
	
	//puts the values of classid,coursename,courseid in the session
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">

<script>
	function plus(){
		var win=window.document.confirm_frm;
		var val=win.noofgrps.value;
		if (win.allow_grps.checked==true){
			if (val<20){
				window.document.confirm_frm.noofgrps.value=parseInt(val)+1;			   parent.grpcontents.location.href="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps="+win.noofgrps.value+"&examtype=<%=examType%>&examname=<%=examName%>";			}else
				window.document.confirm_frm.noofgrps.value=20;
		}
		return false;
	}
	function minus(){
		var win=window.document.confirm_frm;
		var val=win.noofgrps.value;
		if (win.allow_grps.checked==true){
			if (val>1){
				window.document.confirm_frm.noofgrps.value=parseInt(val)-1;
			    parent.grpcontents.location.href="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps="+win.noofgrps.value+"&examtype=<%=examType%>&examname=<%=examName%>";
			}else
				window.document.confirm_frm.noofgrps.value=1;
		}
		return false;

   }
  function change() {
		var win=window.document.confirm_frm;
		var grps=<%=noOfGrps%>;
		if (win.allow_grps.checked==true) {
			win.noofgrps.disabled=false;
			/*if (grps>=1)
				win.noofgrps.options[grps].selected=true;
			else
				win.noofgrps.options[1].selected=true;*/
			if (grps>=1)
				win.noofgrps.value=<%=noOfGrps%>
			else
				win.noofgrps.value=1;
		}
		else {
			//win.noofgrps.options[0].selected=true;
			win.noofgrps.value=0;
			win.noofgrps.disabled=true;
		}
	    //parent.grpcontents.location.href="GroupDetails.jsp?examid=<%=examId%>&noofgrps="+win.noofgrps.options.value+"&examtype=<%=examType%>&examname=<%=examName%>";
		parent.grpcontents.location.href="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps="+win.noofgrps.value+"&examtype=<%=examType%>&examname=<%=examName%>";
		return;

  }
 function go(){
		var win=window.document.confirm_frm;
		if (win.noofgrps.value<1){
			win.allow_grps.checked=false;
		   // parent.grpcontents.location.href="GroupDetails.jsp?examid=<%=examId%>&noofgrps="+win.noofgrps.options.value+"&examtype=<%=examType%>&examname=<%=examName%>";
		   parent.grpcontents.location.href="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps="+win.noofgrps.value+"&examtype=<%=examType%>&examname=<%=examName%>";
		    return;
		}
		else							  
			parent.grpcontents.location.href="GroupDetails.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&noofgrps="+win.noofgrps.value+"&examtype=<%=examType%>&examname=<%=examName%>";
 }

</script>
</head>

<body link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF">
<form name="confirm_frm">
<table width="463">
  <tr>
     <%if(noOfGrps>=1) {%>
		 <td width="274"><font face="Arial" size="2"><input type="checkbox" name="allow_grps" checked onclick="change();">Enable grouping</font></td>
    	 <td width="175"><font face="Arial" size="2">No of groups :<a href="#" onclick="return minus();"><img src='/LBCOM/images/minus.bmp' width="20" height="16"></a><input type="text" name="noofgrps" value="<%=noOfGrps%>" readonly size="2" onchange="return go();"><a href="#" onclick="return plus();"><img border="0" src="/LBCOM/images/plus.bmp" width="18" height="18"></a></td>
		 
	 <%}else {%>
		 <td width="274"><font face="Arial" size="2"><input type="checkbox" name="allow_grps"  onclick="change();">Enable grouping</font></td>
		 <td width="175"><font face="Arial" size="2">No of groups :<a href="#" onclick="return minus();"><img src='/LBCOM/images/minus.bmp' width="20" height="16"></a><input type="text" name="noofgrps" value="0" disabled readonly size="2" onchange="return go();"><a href="#" onclick="return plus();"><img border="0" src="/LBCOM/images/plus.bmp" width="18" height="18"></a></td>
	 <%}%>
	 
<!--	 <td width="175"><font face="Arial" size="2">No of groups :<select name="noofgrps"  <%=disabled%> onchange="return go();">
      <option value='0' >-</option>
     <%for(byte b=1;b<=20;b++){
		 if(noOfGrps==b){%>
	     <option value='<%=b%>'selected><%=b%></option>
		 <%} else {%>
         <option value='<%=b%>'><%=b%></option>
	    <%}
     }%>
	
     </select>
	
     </font></td>-->
  </tr>
</table>
</form>
</body>
<script language='javascript'>	
<%  if (enableMode.equals("0")){ %>
		var frm=document.confirm_frm;
		for (var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;

		<% } %>
</script>
</html>

