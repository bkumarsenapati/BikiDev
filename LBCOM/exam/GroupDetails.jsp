<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" %>
<%@ page import ="java.io.*,java.sql.*,java.util.*,coursemgmt.ExceptionsFile,sqlbean.DbBean"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="dbBean" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;


	String classId="",courseName="",courseId="",mode="",examId="",examType="",checked="",grpTable="",examName="",schoolId="",enableMode="";
	Vector grpName=null,grpInstructions=null,totQtns=null,maxQtns=null,anyAll=null,posMarks=null,negMarks=null;
	int noOfGrps=0;
%>
<%
	session=request.getSession(true);

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	session.removeValue("qidlist");

	examId=request.getParameter("examid");
	examName=request.getParameter("examname");
	examType=request.getParameter("examtype");
	enableMode=request.getParameter("enableMode");

	noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
	
	 if (enableMode.equals("0"))
		grpTable=schoolId+"_"+examId+"_"+"group_tbl";
	 else
		grpTable=schoolId+"_"+examId+"_"+"group_tbl_tmp";
 	 
	System.out.println("exam ......... grpTable..."+grpTable);
	grpName=new Vector();
	grpInstructions=new Vector();
	totQtns=new Vector();
	maxQtns=new Vector();
	posMarks=new Vector();
	negMarks=new Vector();
	anyAll=new Vector();
	try{
		con=dbBean.getConnection();
		st=con.createStatement();

	rs=st.executeQuery("select * from "+grpTable);
	while(rs.next()) {
		grpName.add(rs.getString("group_id"));
		grpInstructions.add(rs.getString("instr"));
		totQtns.add(rs.getString("tot_qtns"));
		maxQtns.add(rs.getString("ans_qtns"));
		anyAll.add(rs.getString("any_all"));
		posMarks.add(rs.getString("weightage"));
		negMarks.add(rs.getString("neg_marks"));
	
	}
	}catch(Exception e){
		ExceptionsFile.postException("GroupDetails.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("GroupDetails.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}

    }
	
%>
<HTML>
<HEAD>
<title></title>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript" src="../validationscripts.js"></script> 

<SCRIPT LANGUAGE="JavaScript">
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


function fun()
{
   var inst=document.getElementsByName("instructions");
   var tot=document.getElementsByName("tot_qtns");
   var max=document.getElementsByName("max_qtns");
   var corr=document.getElementsByName("pos_marks");
   var neg=document.getElementsByName("neg_marks");
   var anyAll=document.getElementsByName("any_all");
   var len=tot.length;
   for(var i=0;i<len;i++){
		if((dot(tot[i]))||(dot(max[i])))
			 return false
		if((num(tot[i]))||(num(max[i]))||(num(corr[i]))||(num(neg[i])))
			 return false
		if((gt0(tot[i]))||(gt0(corr[i])))
			return false
		 if((trim(neg[i].value)<0)&&(trim(neg[i].value)!="")){
			  alert("Please enter positive numbers only")
			  neg[i].select()
			  return false
		}
	    if(anyAll[i].value=="0"){
			max[i].value=tot[i].value;
		}else if (anyAll[i].value=="1"){
			if(gt0(max[i])){
				return false;
			}
			if(trim(max[i].value)>=trim(tot[i].value)){
				alert("You cannot select more than the available questions");
				max[i].select();
				return false;
			}
		} 
		if(trim(tot[i].value)<trim(max[i].value)){
			  alert("Please check the total questions value")
			  tot[i].select()
			  return false
		}
		if(trim(neg[i].value)==""){
			neg[i].value=0;
		}
		
  }
			  return true;
}
//||(isNaN(max.value))||(isNaN(corr.value))||(isNaN(neg.value)))
function dot(k)
{
    if(k.value.indexOf(".")>=0){
          alert("Please enter Integers only")
          k.select()
          return true;
    }

return false

}
function num(k)
{
    if(isNaN(trim(k.value))){
          alert("Please enter Numbers only")
          k.select()
          return true;
    }

return false

}
function setMaxQtns(field){
	
}

function gt0(k)
{

    if((trim(k.value)<1)&&(trim(k.value)!="")){
          alert("Please enter positive numbers only")
          k.select()
          return true;
    }
      if(trim(k.value)==""){
         
          alert("Please enter all fields")
          k.select()
          return true;
    }
return false

}

function go1() {

	if(fun()){     				
		window.document.groupdet.action="/LBCOM/exam.SaveGroupsDet?examid=<%=examId%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>&examname=<%=examName%>";
//		window.groupdet.submit();
		 replacequotes();
		return;
	}
	else 
		return false;
}

function go() {				
	parent.parent.top_fr.location.href="CETopPanel.jsp?status=2&editMode=edit&examId=<%=examId%>&examName=<%=examName%>&examType=<%=examType%>&noOfGrps=<%=noOfGrps%>";
	parent.location.href="CreateExamFrames.jsp?enableMode=<%=enableMode%>&examid=<%=examId%>&examtype=<%=examType%>&noofgrps=<%=noOfGrps%>&examname=<%=examName%>";
	
 replacequotes();
	return;
}

</script>
</HEAD>

<BODY>
<form name="groupdet" method="post">
<table width="100%">
<% int i=0;
   int index=0;
  for(char c='A';i<noOfGrps;c++,i++){
    	if(grpName.contains(Character.toString(c))){
	 		index=grpName.indexOf(Character.toString(c));
						
%>
</table>
<div align="center">
  <center>
	
			<table width="669" height="116" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" bgcolor="#EDECE9" bordercolorlight="#FFFFFF" border="1" bordercolordark="#FFFFFF">
			<tr>
			  <td width="152" height="22"><font face="Arial" size="2">&nbsp;Group Id :</font></td>
			  <td width="252" height="22">
              <font face="Arial">
              <input type="text" name="<%=c%>" value="<%=c%>" disabled size="20"></font></td>
			  <td width="265" height="22"> &nbsp;</td>
			</tr>
			  <tr>
			  <td width="152" height="36"><font face="Arial" size="2">&nbsp;Instructions:</font></td>
			  <td width="517" colspan="2" height="36">
              <font face="Arial">
              <textarea name="instructions" rows="2" cols="55" ><%=grpInstructions.get(index)%></textarea></font></td>
			  </tr>
			  <td width="152" height="23"><font face="Arial" size="2">&nbsp;Total no. of Questions :</font></td>
			  <td width="252" height="23">
              <font face="Arial">
              <input type="text" name="tot_qtns" value="<%=totQtns.get(index)%>" size="6" onblur="setMaxQtns(this);return false;"></font></td>
			  <td width="265" height="23">
			  <font face="Arial"><font size="2">&nbsp;To be answered
<%
					if(Integer.parseInt((String)anyAll.get(index))==0)
					{
%>
</font>
							<select name="any_all"><option value="0" selected>All</option>
							<option value="1">Any</option></select><font size="2">
<%
					}
					else
					{
%>
</font>
					<select name="any_all"><option value="0">All</option>
				 <option value="1" selected>Any</option></select></font>
			  <%}%>
			  <input type="text" name="max_qtns" value="<%=maxQtns.get(index)%>"  size="4">
				  
			  
			  </td>
			   
			<tr>
			  <td width="152" height="19"><font face="Arial" size="2">&nbsp;Points:</font></td>
			  <td width="252" height="19">
              <font face="Arial">
              <input type="text" name="pos_marks" value="<%=posMarks.get(index)%>" size="6"><font size="2"> 
              for (single) correct answer.</font></font></td>
			  <td width="265" height="19">
              <font face="Arial">
              <input type="text" name="neg_marks" value="<%=negMarks.get(index)%>" size="5"><font size="2"> for (single) incorrect answer.</font></font></td>
			</tr>
			</table>
			</center>
</div>
			<br>
   <%} else {%>
<div align="center">
  <center>
	
			<table width="669" height="116" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" bgcolor="#EDECE9" bordercolorlight="#FFFFFF" border="1" bordercolordark="#FFFFFF">
			<tr>
			  <td width="152" height="22"><font face="Arial" size="2">&nbsp;Group Id :</font></td>
			  <td width="252" height="22">
              <font face="Arial">
              <input type="text" name="<%=c%>" value="<%=c%>" disabled size="20"></font></td>
			  <td width="265" height="22"> &nbsp;</td>
			</tr>
			  <tr>
			  <td width="152" height="36"><font face="Arial" size="2">&nbsp;Instructions:</font></td>
			  <td width="517" colspan="2" height="36">
              <font face="Arial">
              <textarea name="instructions" rows="2" cols="55" ></textarea></font></td>
			  </tr>
			  <td width="152" height="23"><font face="Arial" size="2">&nbsp;Total no. of Questions :</font></td>
			  <td width="252" height="23">
              <font face="Arial">
              <input type="text" name="tot_qtns" value="" size="6"></font></td>
			  <td width="265" height="23"><font face="Arial"><font size="2">&nbsp;To 
              be answered</font>
				<select name="any_all"><option value="0" selected>All</option>
				 <option value="1">Any</option></select><font size="2">
			     </font>
			     <input type="text" name="max_qtns" value=""  size="4">  
			  </td>			   
			<tr>
			  <td width="152" height="19"><font face="Arial" size="2">&nbsp;Points:</font></td>
			  <td width="252" height="19">
              <font face="Arial">
              <input type="text" name="pos_marks" value="" size="6"><font size="2"> 
              for (single) correct answer.</font></font></td>
			  <td width="265" height="19">
              <font face="Arial">
              <input type="text" name="neg_marks" value="" size="5"><font size="2"> for (single) incorrect answer.</font></font></td>
			</tr>
			</table>
			</center>
</div>
			<br>

	<%}
  }%>

<center>
<%  if (!enableMode.equals("0")){ %>
<input type='image' src="images/submit1.gif" onclick="return go1();">
<input type="image" src="images/continue.gif" onclick="return go();">
<% } %>
</center>

</form>
</BODY>

<script language='javascript'>	
<%  if (enableMode.equals("0")){ %>
		var frm=document.groupdet;
		for (var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;

		<% } %>
</script>
</HTML>
