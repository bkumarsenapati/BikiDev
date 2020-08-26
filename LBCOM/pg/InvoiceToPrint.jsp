<%@ page  import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile,java.io.*,shopping.Course ,shopping.Webinar" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    int slno=0;
	float coursePrice=0,webinarPrice=0,overallSum=0,overallSum1=0,overallSum2=0;
	String codeFlag="",noCodeMsg="",pCode=null,sessid=null;
	int discount=0;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	Vector buylist = (Vector) session.getAttribute("courselist");
	Vector weblist = (Vector) session.getAttribute("wblist");

	String user=(String)session.getAttribute("User");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #575767;
}
.style29 {font-size: 9px}
-->
</style>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style9 {
	color: #CC0000;
	font-weight: bold;
}
.style10 {font-size: 11px}
body {
	background-color: #575767;
}
a:link {
	text-decoration: none;
	color: #000000;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #CC0000;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
.style14 {font-size: 9px}
.style15 {
	color: #9a730a;
	font-weight: bold;
}
-->
</style>
<LINK href="style/table.css" type=text/css rel=stylesheet>
</head>

<body topmargin="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
            <table width="756" border="0" cellspacing="0" cellpadding="0" height="525">
              <tr>
                <td colspan="2" height="4"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="98" bgcolor="#FFFFFF"><img src="../images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="98" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom">
		    </td>
                    <td width="36" align="center" valign="baseline">
		    </td>				
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2" bgcolor="#FFFFFF" height="405"><p>&nbsp;</p>
<table width="756" border="0" cellspacing="0" cellpadding="0" height="206">

<tr>
  <td>
    <table border="1" bordercolor="#C0C0C0" width="741"  cellspacing="1">
<%
   con=con1.getConnection();
   st=con.createStatement();
   Calendar rightNow = Calendar.getInstance();
   rs=st.executeQuery("select fname,lname from lb_users where userid='"+user +"'");
    if(rs.next())
      {
%>
    <tr>
    <td><font face="Verdana" size="2">UserID : <%= user%></font></td>
    <td><font face="Verdana" size="2">First Name : <%= rs.getString("fname")%> <%= rs.getString("lname")%></font></td>
    <td><font face="Verdana" size="2">Date :<%= (rightNow.get(Calendar.DATE)<10?"0":"") + rightNow.get(Calendar.DATE) + "/" + (rightNow.get(Calendar.MONTH)<9?"0":"") + (rightNow.get(Calendar.MONTH)+1) + "/" + rightNow.get(Calendar.YEAR)%></font></td>
<%
      }
%>
    </table>
  </td>
</tr>
<tr>
 <td height="113">
<table border="1" bordercolor="#C0C0C0" width="741"  cellspacing="1">
  <tr>
    <td width=41 align="center" bgcolor="#C0C0C0" height="16">
    <b><font face="Verdana" size="2" color="#800000">Sl.No.</font></b></td>
    <td  align="center" bgcolor="#C0C0C0" height="16" width="317">
    <font face="Verdana" size="2" color="#800000"><b>Course Name</b></font></td>
    <td  align="center" bgcolor="#C0C0C0" height="16" width="136">&nbsp;

    <!-- <font face="Verdana" size="2" color="#800000"><b>Amount($)</b></font> -->
	
	</td>
    <td  height="16" bgcolor="#C0C0C0" width="114"></td>
  </tr>
<%
		 if (buylist != null && (buylist.size() > 0)) {
		  for (int index=0; index < buylist.size();index++) {
		    Course anOrder = (Course) buylist.elementAt(index);
		    slno=slno+1;
			coursePrice=anOrder.getPrice();
%>
  <tr>
    <td  height="19" align="center" width="41"><font face="Verdana" size="2"><%= slno%></font></td>
    <td  height="19" width="317"><font face="Verdana" size="2" color="#FF0000"><%= anOrder.getCourseName() %></font></td>
    <td  height="19" align="center" width="136">&nbsp;</td>
   <!--  <td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= anOrder.getPrice() %></font></td> -->
   
	<td  height="19"  width="114"><font face="Verdana" size="1"></font></td>
  </tr>
  <tr>

<%
         overallSum1=overallSum1+coursePrice;
        }
     }
%>

<%
		 if (weblist != null && (weblist.size() > 0)) {
		  for (int index=0; index < weblist.size();index++) {
			Webinar webOrder = (Webinar) weblist.elementAt(index);
			slno=slno+1;
			 webinarPrice=webOrder.getPrice();
%>
  <tr>
    <td  height="19" align="center" width="41"><font face="Verdana" size="2"><%= slno%></font></td>
    <td  height="19" width="317"><font face="Verdana" size="2" color="#FF0000"><%= webOrder.getWebinarName() %></font></td>
    
	<td  height="19" align="center" width="136">&nbsp;</td>
	<!-- <td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= webOrder.getPrice() %></font></td> -->
    
	<td  height="19"  width="114"><font face="Verdana" size="1"></font></td>
  </tr>
  <tr>

<%
        overallSum2=overallSum2+webinarPrice;
       }
    }
    overallSum=overallSum1+overallSum2;
	if(overallSum==0)
	 {

  %>
    <tr>
    <td width="733" height="19" align="center" colspan="7">
    <p align="center"><font face="Verdana" size="2">There are no Courses/K-Caps in your Cart.</font></td>
   </tr>
  <%
      }
  %>

 <!--  <tr>
    <td height="16" align="right" bgcolor="#C0C0C0" colspan="2" width="363">
		<font face="Verdana" size="2" color="#800000"><b>Total :</b></font>
	</td>
    <td height="16" align="center" bgcolor="#C0C0C0" width="136">
		<font face="Verdana" size="2"><b>$ <%= overallSum%></b></font>
    </td>
    <td width="114" height="16" bgcolor="#C0C0C0" align="right">&nbsp;</td>
  </tr> -->

</table>
</td>
</tr>
<tr>
<td height="34">&nbsp;</td>
</tr>

<%
    pCode=(String)session.getAttribute("PromoCode");
	if(pCode==null)
	{
		pCode="";
	}
	        
		rs=st.executeQuery("select * from lb_promotion_codes where prom_code='"+pCode+"' and active_date <= CURDATE() and CURDATE() <= closing_date and status=1");
		
		if(rs.next())
		{  
			discount=Integer.parseInt(rs.getString("discount_perc"));
		}
		else
		{
			discount=0;
			noCodeMsg="(The code is not available)";
		}
	overallSum=Math.round(((100-discount)*overallSum)/100);
	if(pCode==null||pCode=="")
	{
		noCodeMsg="No promotion code entered ";
	}
	//session.invalidate();  
%>

<tr>
 <td height="59">
		<!-- <table border="1" cellpadding="0" cellspacing="0" width="741" height="1">
		<tr>
			<td width="26%"><font face="Verdana" size="2">Promotion Code :</font></td>
			<td width="74%"><font face="Verdana" size="2"><%=pCode%>&nbsp;&nbsp;<%=noCodeMsg%></font></td>  
		</tr>
		<tr>
			<td width="26%"><font face="Verdana" size="2">Discount :</font></td>
			<td width="74%"><b><font face="Verdana" size="2"><%=discount%>%</font></b></td>  
		</tr>
		<tr>
			<td width="100%" colspan="2">
				<font face="Verdana" size="2">The total amount that you have to pay now is :</font>
				<font face="Verdana" size="2"><b>$<%=overallSum%></b></font>
			</td>
		</tr>
		</table> -->
 </td>
 </tr>
 </table>
<br>
</form>

               </td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF"></td>
                <td align="right" bgcolor="#FFFFFF"><font face="Verdana" size="2"><p>Accounts In charge,<br>
                                  Learnbeyond Inc.<br>
                                  Learnbeyond.</p></font>
                </td>
              </tr>
                             <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="35" colspan="14" bgcolor="#FFFFFF"><div align="center"><span class="sheet style14">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></div></td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/bottom_stip.jpg" width="761" height="7" /></td>
                            </tr>
                        </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
<script>
   window.print();
</script>
</html>