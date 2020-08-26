<%@ page language="java" %>
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>



<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String classId="",courseName="",courseId="",examId="",examType="",disabled="",examName="",schoolId="",enableMode="",exmTbl="";
	String checked="",sortChecked="",variations="",value="",sortValue="";
	int noOfGrps=0,random=0,sort=0;
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	try{
	con= db.getConnection();
	st=con.createStatement();

	disabled="disabled";	
	checked="";
	value="0";
	variations="1";
    sortChecked="";
	sortValue="0";
    schoolId=(String)session.getAttribute("schoolid");
	examId=request.getParameter("examid");
	examType=request.getParameter("examtype");
	
	enableMode=request.getParameter("enableMode");

	 if (enableMode.equals("0"))
		exmTbl="exam_tbl";
	 else
		exmTbl="exam_tbl_tmp";
 	 

		random=1;
	    variations="1";
		sort=0;
		noOfGrps=1;
		examName=request.getParameter("assmtName");

	/*rs=st.executeQuery("select * from "+exmTbl+" where exam_id='"+examId+"' and school_id='"+schoolId+"'");
	if (rs.next()){
		random=rs.getInt("random_wise");
	    variations=rs.getString("versions");
		sort=rs.getInt("type_wise");
		noOfGrps=rs.getInt("no_of_groups");
		examName=rs.getString("exam_name");
	}*/

	}catch(Exception e){
		ExceptionsFile.postException("RandomizeDetails.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("RandomizeDetails.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}

    }
	

%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<script>
function plus(){
	var win=window.document.confirm_frm;
	var val=win.variations.value;
	if(win.random.checked==true){
		if (val<10)
			win.variations.value=parseInt(val)+1;
		else
			win.variations.value=10;
	}
	return false;
}
function minus(){
	var win=window.document.confirm_frm;
	var val=win.variations.value;
	if(win.random.checked==true){
		if (val>1)
			window.document.confirm_frm.variations.value=parseInt(val)-1;
		else
			window.document.confirm_frm.variations.value=1;
	}
	return false;


}
 function change() {
	var win=window.document.confirm_frm;
	if (win.random.checked==true) {
		win.variations.disabled=false;
		win.random.value="1";
		win.variations.focus();
	}
	else {
		win.variations.disabled=true;
		win.random.value="0";
	}

}
function check() {
	var win=window.document.confirm_frm;

	if (win.sort.checked==true){
		win.sort.value="1";
		win.sort1.value="1";
	}
	else{
		win.sort.value="0";
		win.sort1.value="0";
	}
    if (win.random.checked==true){
		if (win.variations.value<1) {
			alert("Please enter positive numbers only");
			win.variations.focus();
			return false;
		}
		if (win.variations.value>10) {
			alert("Sorry! Variations cannot be greater than 10.");
			win.variations.focus();
			return false;
		}
		win.random.value="1";
		win.random1.value="1";
	}
	else{
		win.random.value="0";
		win.random1.value="1";
	}
	win.variations.disabled=false;


		
}

</script>
</head>
<body link="#FFFFFF" leftmargin=3>
<form name="confirm_frm" action="/LBCOM/exam.AssBuilderVariations?noofgrps=<%=noOfGrps%>&examname=<%=examName%>&examid=<%=examId%>&examtype=<%=examType%>" method="post" onsubmit="return check();">

<table width="600" cellpadding="3" bordercolorlight="#EDECE9" border="1" bgcolor="#FFFFFF" cellspacing="0" bordercolordark="#EDECE9" style="border-collapse: collapse" bordercolor="#111111" height="109">
<tr>
<%if(random==0){%>
      <td width="146" height="22"><input type="checkbox" name="random" value="0" onclick="change();"><font face='Arial'  size='2'>Randomize</td>
	  <td width="740" height="22"><font face='Arial'  size='2'>&nbsp;<a href="#" onclick="return minus();"><img src='/LBCOM/images/minus.bmp' width="20" height="16"></a><input type="text" name="variations" value="1" size="2" readonly disabled><a href="#" onclick="return plus();"><img border="0" src="/LBCOM/images/plus.bmp" width="18" height="18"></a>
      variations</td>
<%}else {%>
      <td width="146" height="22"><input type="checkbox" name="random" value="1" checked onclick="change();"><font face='Arial'  size='2'>Randomize</td>
	 <td width="740" height="22"><font face='Arial'  size='2'>&nbsp;<a href="#" onclick="return minus();"><img src='/LBCOM/images/minus.bmp' width="20" height="16"></a><input type="text" name="variations" value="<%=variations%>" size="2" readonly ><a href="#" onclick="return plus();"><img border="0" src="/LBCOM/images/plus.bmp" width="18" height="18"></a>variations</td>

<%}%>


  </tr>
<tr>
   <td width="893" colspan="2" height="20">
	<%if(sort==0){%>   
      <input type="checkbox" name="sort" value="0" ><font face='Arial'  size='2'>Sort according to question type</td>
     <%}else{%>
      <input type="checkbox" name="sort" value="1" checked ><font face='Arial'  size='2'>Sort according to question type</td>
	<%}%>

      
  </tr>

<%  if (!enableMode.equals("0")){ %>

  <tr colspan="3">
	  <td  width="893" align="center" colspan="2" height="53" bgcolor="#FFFFFF" >
      <p align="left"><input type='image' name="submit" src="images/submit.gif" ></td>
  
  </tr>
  <% } %>
</table>
<input type="hidden" name="sort1" value="0">
<input type="hidden" name="random1" value="0">
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