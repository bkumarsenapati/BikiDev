<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function checkall()
{
/*if(window.document.defgrades.exwtg.value==""||window.document.defgrades.asswtg.value==""||window.document.defgrades.hwwtg.value==""||window.document.defgrades.pwwtg.value==""
||window.document.defgrades.mewtg.value==""||window.document.defgrades.fewtg.value=="")
	{
		alert("Please Enter all values");
		return false;
	}
if(isNaN(window.document.defgrades.exwtg.value)||isNaN(window.document.defgrades.asswtg.value)||isNaN(window.document.defgrades.hwwtg.value)||isNaN(window.document.defgrades.pwwtg.value)||isNaN(window.document.defgrades.mewtg.value)||isNaN(window.document.defgrades.fewtg.value))
	{
		alert("Please Enter only numbers");
		return false;
	}
var i;
i=parseFloat(window.document.defgrades.exwtg.value)+parseFloat(window.document.defgrades.asswtg.value)+parseFloat(window.document.defgrades.hwwtg.value)+parseFloat(window.document.defgrades.pwwtg.value)+parseFloat(window.document.defgrades.fewtg.value)+parseFloat(window.document.defgrades.mewtg.value);
if(i!=100)
	{
	alert("Sum of all category weightages should be equal to 100");
	return false;
	}*/
 var frm=window.document.defgrades
	var num="0123456789"
    var txt=document.getElementsByTagName("input")
     for(i=0;i<txt.length-2;i++)
      {
	     if(txt[i].value=="")
		   {
			  alert("Please Enter Proper values");
			  txt[i].select()
			  i =100;
			  return false;
         }
	   if(( num.indexOf((txt[i].value).charAt(0)))==-1||
		   (num.indexOf((txt[i].value).charAt(1)))==-1||
		   (num.indexOf((txt[i].value).charAt(2)))==-1)
          {
           alert("Please Enter Numbers only");
           txt[i].select();
	       i =100;
           return false;
          } 
	  }
if(window.document.defgrades.T0max.value==""||window.document.defgrades.T0min.value==""||window.document.defgrades.T1max.value==""||window.document.defgrades.T1min.value==""||
window.document.defgrades.T2max.value==""||window.document.defgrades.T2min.value==""||window.document.defgrades.T3max.value==""||window.document.defgrades.T3min.value==""||
window.document.defgrades.T4max.value==""||window.document.defgrades.T4min.value==""||window.document.defgrades.T5max.value==""||window.document.defgrades.T5min.value==""||
window.document.defgrades.T6max.value==""||window.document.defgrades.T6min.value==""||window.document.defgrades.T7max.value==""||window.document.defgrades.T8min.value==""||
window.document.defgrades.T8max.value==""||window.document.defgrades.T8min.value==""||window.document.defgrades.T9max.value==""||window.document.defgrades.T9min.value==""||
window.document.defgrades.T10max.value==""||window.document.defgrades.T10min.value=="")
{
alert("please Enter all values");
return false;
}


if(isNaN(window.document.defgrades.T0max.value)||isNaN(window.document.defgrades.T0min.value)||isNaN(window.document.defgrades.T1max.value)||isNaN(window.document.defgrades.T1min.value)||isNaN(window.document.defgrades.T2max.value)||isNaN(window.document.defgrades.T2min.value)||isNaN(window.document.defgrades.T3max.value)||isNaN(window.document.defgrades.T3min.value)||isNaN(window.document.defgrades.T4max.value)||isNaN(window.document.defgrades.T4min.value)||isNaN(window.document.defgrades.T5max.value)||isNaN(window.document.defgrades.T5min.value)||isNaN(window.document.defgrades.T6max.value)||isNaN(window.document.defgrades.T6min.value)||isNaN(window.document.defgrades.T7max.value)||isNaN(window.document.defgrades.T7min.value)||isNaN(window.document.defgrades.T8max.value)||isNaN(window.document.defgrades.T8min.value)||isNaN(window.document.defgrades.T9max.value)||isNaN(window.document.defgrades.T9min.value)||isNaN(window.document.defgrades.T10max.value)||isNaN(window.document.defgrades.T10max.value))
{
alert("please Enter only Numbers");
return false;
}

if(parseInt(window.document.defgrades.T0max.value) > 100 || parseInt(window.document.defgrades.T0max.value) <=parseInt(window.document.defgrades.T0min.value)|| parseInt(window.document.defgrades.T0min.value) <= parseInt(window.document.defgrades.T1max.value)||parseInt(window.document.defgrades.T1max.value) <= parseInt(window.document.defgrades.T1min.value)||parseInt(window.document.defgrades.T1min.value) <= parseInt(window.document.defgrades.T2max.value)||parseInt(window.document.defgrades.T2max.value) <= parseInt(window.document.defgrades.T2min.value)||parseInt(window.document.defgrades.T2min.value) <= parseInt(window.document.defgrades.T3max.value)||parseInt(window.document.defgrades.T3max.value) <= parseInt(window.document.defgrades.T3min.value)||parseInt(window.document.defgrades.T3min.value) <= parseInt(window.document.defgrades.T4max.value)||parseInt(window.document.defgrades.T4max.value) <= parseInt(window.document.defgrades.T4min.value)||parseInt(window.document.defgrades.T4min.value) <= parseInt(window.document.defgrades.T5max.value)||parseInt(window.document.defgrades.T5max.value) <= parseInt(window.document.defgrades.T5min.value)||parseInt(window.document.defgrades.T5min.value) <= parseInt(window.document.defgrades.T6max.value)||parseInt(window.document.defgrades.T6max.value) <= parseInt(window.document.defgrades.T6min.value)||parseInt(window.document.defgrades.T6min.value) <= parseInt(window.document.defgrades.T7max.value)||parseInt(window.document.defgrades.T7max.value) <= parseInt(window.document.defgrades.T7min.value)||parseInt(window.document.defgrades.T7min.value) <= parseInt(window.document.defgrades.T8max.value)||parseInt(window.document.defgrades.T8max.value) <= parseInt(window.document.defgrades.T8min.value)||parseInt(window.document.defgrades.T8min.value) <= parseInt(window.document.defgrades.T9max.value)||parseInt(window.document.defgrades.T9max.value) <= parseInt(window.document.defgrades.T9min.value)||parseInt(window.document.defgrades.T9min.value) <= parseInt(window.document.defgrades.T10max.value)||parseInt(window.document.defgrades.T10max.value) <= parseInt(window.document.defgrades.T10min.value))
	{
	alert("Please Enter Proper values");
	return false;
	}

return true;
	
}

</script>

</head>
<body>

<form method="POST" name="defgrades" action="admindefinegrades.jsp">
<!--<p align="center"><b><font face="Verdana"><span style="font-size:10pt;">Define Weightages</span></font></b><font face="Verdana"><span style="font-size:10pt;"><br>
</span></font></p>-->
<div align="center">
<center>

<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="connection" class="sqlbean.DbBean" scope="page" />
<%	
	//This is Jsp file is used by the teacher to define grades for particular Course.But before defining grades a teacher will
	//get defult grades defined by Admin people for particular school.

	Statement stmt = null,stmt1=null;
	ResultSet rs = null,rs1=null;
	String teacherid,classid,foldername;
	
	//teacherid=(String)session.getAttribute("emailid");
	String schoolid=(String)session.getAttribute("schoolid");
	//String schoolid=request.getParameter("schoolid");
	//classid=(String)session.getAttribute("grade");
	Connection con = connection.getConnection();
	
	int exwtg=0,asswtg=0,pwwtg=0,fewtg=0,hwwtg=0,mewtg=0;
	
try
{
	
	stmt1 = con.createStatement();
	/*rs1=stmt1.executeQuery("select * from defaultweightages where schoolid='"+schoolid+"'");

	//	rs1=stmt1.executeQuery("select * from weightages where emailid='"+teacherid+"' and schoolid='"+schoolid+"' and coursename='"+foldername+"'");
		if(rs1.next())
		{	
			//examwtg=?,assignmentwtg=?,quizwtg=?,homeworkwtg=?,midtermwtg=?,finalewtg=?
			int exwtg=rs1.getInt("examwtg");
			int asswtg=rs1.getInt("assignmentwtg");
			int hwwtg=rs1.getInt("quizwtg");
			int pwwtg=rs1.getInt("homeworkwtg");
			int fewtg=rs1.getInt("finalexwtg");
			int mewtg=rs1.getInt("midtermexwtg");*/

%>
	
<!--	<table width="459" style="border-collapse:collapse;" cellspacing="0" bordercolor="#EEB84E">
    <tr>
      <td width="22" height="19" style="border-top-width:2; border-right-width:0; border-bottom-width:0; border-left-width:2; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:solid;">
        <p align="left">&nbsp;</td>
      <td width="120" height="19" style="border-top-width:2; border-right-width:0; border-bottom-width:0; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
        <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Exams/Quiz</span></font></b></td>
      <td width="41" height="19" style="border-top-width:2; border-right-width:0; border-bottom-width:0; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78);  border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
        <p><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;">
        <input type="text" name="exwtg" value="<%= exwtg %>" size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>

      <td width="57" height="19" style="border-top-width:2; border-right-width:0; border-bottom-width:0; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                <p align="right"><b><font face="Verdana"><span style="font-size:10pt;">&nbsp;&nbsp;&nbsp; </span></font></b></td>
      <td width="103" height="19" style="border-top-width:2; border-right-width:0; border-bottom-width:0; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Assignments&nbsp;</span></font></b></td>
      <td width="100" height="19" style="border-top-width:2; border-right-width:2; border-bottom-width:0; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-right-style:solid; border-bottom-style:none; border-left-style:none;"><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;">
      <input type="text" name="asswtg" value="<%= asswtg %>" size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>
    
	</tr>
    <tr>
      <td width="22" height="17" style="border-top-width:0; border-right-width:0; border-bottom-width:0; border-left-width:2; border-top-color:black; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:none; border-left-style:solid;">
        <p align="left">&nbsp;</td>
      <td width="120" height="17" style="border-width:0; border-color:black; border-style:none;">
        <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Homework</span></font></b></td>
      <td width="41" height="17" style="border-width:0; border-color:black; border-style:none;">
        <p><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;"><input type="text" name="hwwtg" value="<%= hwwtg %>" size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>
      <td width="57" height="17" style="border-width:0; border-color:black; border-style:none;">
                <p align="right"><b><font face="Verdana"><span style="font-size:10pt;">&nbsp;&nbsp;&nbsp; </span></font></b></td>
      <td width="103" height="17" style="border-width:0; border-color:black; border-style:none;">
                <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Project Work&nbsp;</span></font></b></td>
      <td width="100" height="17" style="border-top-width:0; border-right-width:2; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;"><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;">
      <input type="text" name="pwwtg" value="<%= pwwtg %>" size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>
    </tr>
    <tr>
      <td width="22" height="19" style="border-top-width:0; border-right-width:0; border-bottom-width:2; border-left-width:2; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:solid;">
        <p align="left">&nbsp;</td>
      <td width="120" height="19" style="border-top-width:0; border-right-width:0; border-bottom-width:2; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
        <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Midterm Exam  </span></font></b></td>
      <td width="41" height="19" style="border-top-width:0; border-right-width:0; border-bottom-width:2; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
        <p><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;">
        <input type="text" name="mewtg" value="<%= mewtg %>" size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>
      <td width="57" height="19" style="border-top-width:0; border-right-width:0; border-bottom-width:2; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                <p align="right"><b><font face="Verdana"><span style="font-size:10pt;">&nbsp;&nbsp;&nbsp; </span></font></b></td>
      <td width="103" height="19" style="border-top-width:0; border-right-width:0; border-bottom-width:2; border-left-width:0; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                <p align="left"><b><font face="Verdana"><span style="font-size:10pt;">Final Exam&nbsp;</span></font></b></td>
      <td width="100" height="19" style="border-top-width:0; border-right-width:2; border-bottom-width:2; border-left-width:0; border-top-style:none; border-right-style:solid; border-bottom-style:solid; border-left-style:none"><b><font face="Arial" color="#40A0E0"><span style="font-size:10pt;">
      <input type="text" name="fewtg" value="<%= fewtg %>"  size="3"></span></font><span style="font-size:10pt;"><font face="Arial" color="#EEB84E">%</font></span></b></td>
    </tr>
  </table>

      </center>
    </div>-->
<%  
  //}
}
catch(Exception e)
{
	 ExceptionsFile.postException("Admindefine_percentages.jsp","operations on defaultweightages table ","Exception",e.getMessage());
	//out.println(e);
}
%>

  <p align="center"><b><font face="Verdana"><span style="font-size:10pt;">Define Grades</span></font></b></p>
    <div align="center">
      <center>
      <table width="566" style="border-collapse:collapse;" cellspacing="0" bordercolor="#EEB84E" align="center">
        <tr> 
          <td width="192" bgcolor="#EEB84E" bordercolor="#EEB84E" style="border-top-width:2; border-bottom-width:2; border-left-width:2; border-top-color:rgb(238,184,78); border-bottom-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-left-style:solid;" colspan="2" align="center"> 
            <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Grade 
              Definition</span></font></b>
          </td>
          <td width="202" bgcolor="#EEB84E" bordercolor="#EEB84E" style="border-top-width:2; border-bottom-width:2; border-left-width:2; border-top-color:rgb(238,184,78); border-bottom-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-left-style:solid;" align="center"> 
            <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Maximum 
              Percentage</span></font></b> 
          </td>
          <td width="162" bgcolor="#EEB84E" bordercolor="#EEB84E" style="border-top-width:2; border-bottom-width:2; border-left-width:2; border-top-color:rgb(238,184,78); border-bottom-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-top-style:solid; border-left-style:solid;" align="center"> 
            <p align="center"><b><font face="Verdana" color="white"><span style="font-size:10pt;">Minimum 
              Percentage</span></font></b>
          </td>
        </tr>
        <%
			int[] maxs = new int[11];
			int[] mins = new int[11];
			//String grades[]={"A+","A","A-","B+","B","B-","C+","C","C-","D+","D"};
			String[] grades=new String[11];
			int i=0;
	try
	{   if(con.isClosed()){
		}else
			
		stmt = con.createStatement();
		rs=stmt.executeQuery("select * from defaultgradedefinitions where schoolid='"+schoolid+"' order by max desc ");
		while(rs.next())
		{	
			//out.println("grades are" +rs.getString(1));
			mins[i]=rs.getInt("min");
			maxs[i]=rs.getInt("max");
			grades[i]=rs.getString("grade");
%>
        <tr> 
          <td width="72" style="border-left-width:2; border-top-color:rgb(238,184,78); border-left-color:rgb(238,184,78); border-left-style:solid;" bordercolor="#EEB84E"> 
          <td width="118" tyle="font-size:10pt;" bordercolor="#EEB84E">
            <p align="left"><b><font face="Verdana"><span style="font-size:10pt;"><%=grades[i]%></span></font></b><font face="Verdana"><span style="font-size:10pt;">&nbsp;</span></font>	
              &nbsp;
          </td>
          <td width="202" bordercolor="#EEB84E"> 
            <p align="center"><b><font face="Verdana"><span style="font-size:10pt;">
              <input type="text" name="T<%=i%>max" value=<%=maxs[i]%> size="4">
              </span></font></b>
          </td>
          <td width="162" style="border-right-width:2; border-right-color:rgb(238,184,78); border-right-style:solid;" bordercolor="#EEB84E"> 
            <p align="center"><b><font face="Verdana"><span style="font-size:10pt;">
              <input type="text" name="T<%=i%>min" value=<%=mins[i]%> size="4">
              </span></font></b>
          </td>
        </tr>
        <%
			i++;
		}
	}
	catch(Exception e)
	{
		 ExceptionsFile.postException("Admindefine_percentages.jsp","operations on definegardes table","Exception",e.getMessage());
		//out.println(e);
	}finally{
		try{
			if(stmt!=null)
				stmt.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("Admindefine_percentages.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }

	%>
        <tr> 
          <td width="192" bgcolor="#EEB84E" style="border-top-width:2; border-left-width:2; border-top-style:solid; border-left-style:solid" colspan="2" bordercolor="#EEB84E"> 
          </td>
          <td width="202" bgcolor="#EEB84E" style="border-top-width:2; border-top-color:rgb(238,184,78); border-top-style:solid;" bordercolor="#EEB84E"> 
          </td>
          <td width="162" bgcolor="#40A0E0" style="border-top-width:2; border-right-width:2; border-top-color:rgb(238,184,78); border-right-color:rgb(238,184,78); border-top-style:solid; border-right-style:solid;" bordercolor="#EEB84E"> 
          </td>
        </tr>
      </table>
    </center>
    </div>
    <p align="center"><b><font face="Verdana"><span style="font-size:10pt;"><input type="submit" value="Submit" name="B1" onclick="return checkall()" ><input type="reset" value="Reset" name="B2"></span></font></b></p>
</form>
</body>
</html>
