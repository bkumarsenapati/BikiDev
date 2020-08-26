<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String utype="",tag="",bcolor="",emailid="",schoolid="",warn="";
	String fid="",fname="",mode="";
%>
<html>

<head>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<script language="javascript" src="../validationscripts.js"></script>
<script language="javascript">
function validate(frm){
	var charAta;
	var validateData=frm.fname.value;
	if(trim(validateData)==""){
		alert("Enter forum name");
		frm.fname.focus();
		return false;
	}
	for(var i=0;i<validateData.length;i++){
		charAta=validateData.charAt(i);
		if(!( (charAta>='0' && charAta<='9') || (charAta>='A' && charAta<='Z') ||(charAta>='a' && charAta<='z') || (charAta=='_') || (charAta==' ') )){
			alert("Enter valid ForumName");
			return false;
		}
	}
	if(frm.fdesc.value==""){
		alert("Enter the Description");
		frm.fdesc.focus();
		return false;
	}
	replacequotes();
}
</script>
</head>

<body>
<%
	utype=request.getParameter("utype");
	System.out.println("utype..."+utype);
	fid=request.getParameter("fid");
	fname=request.getParameter("fname");
	mode=request.getParameter("mode");
	//warn=request.getParameter("tag");

	emailid=(String)session.getAttribute("emailid");
	schoolid=(String)session.getAttribute("schoolid");
	if(utype.equals("teacher")){
		bcolor="#A8B8DO";
		tag="t";
	}
	else if(utype.equals("student")){
		bcolor="#BOA891";
		tag="s";
	}
	else if(utype.equals("admin")){
		bcolor="#BOA891";
		tag="a";
	}
	if(!warn.equals("1"))
		out.println("<center><b><i><font face=\"Arial\" size=\"2\" color=\"red\">Forum with this name already exists. Please Choose another name</font></i></b></center>");
%>
<form name="frm" method="post" action="/LBCOM/forums/SelectGroup.jsp" onsubmit="return validate(this);">
<br>
<table border="1" align="center" bordercolor="<%= bcolor %>" width="298">
  <tr>
    <td width="294"><img border="0" src="../forums/images/<%= tag %>forum.gif" width="289" height="27"></td>
  </tr>
  <tr>
    <td width="294">
      <table border="0" width="305">
        <tr>
          <td width="109"><font face="Arial" size="2">Forum Name</font></td>
          <td width="182">
              <p><input type="text" name="fname" size="24"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)"></p>
          </td>
        </tr>
        <tr>
          <td width="109"><font face="Arial" size="2">Forum Description</font></td>
          <td width="182">
              <p><textarea rows="4" name="fdesc" cols="20"></textarea></p>
          </td>
        </tr>
        <tr>
          <td colspan="2" width="292">
            <p align="center">
			<a href="ShowDirTopics.jsp?schoolid=<%=schoolid%>&emailid=<%=emailid%>">
			<img border="0" src="../forums/images/<%= tag %>cancel.gif" width="89" height="36" TITLE="Cancel"></a>
			<input type="image" border="0" src="../forums/images/<%= tag %>create.gif" width="88" height="35" TITLE="Create"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>

</html>
