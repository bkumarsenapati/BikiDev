<%@ page  import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile,java.io.*,shopping.Course ,shopping.Webinar" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    int slno=0;
	float coursePrice=0,webinarPrice=0,overallSum=0,overallSum1=0,overallSum2=0;
	String codeFlag="",noCodeMsg="",pCode="",sessid=null;
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
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style28 {
	font-size: 14px;
	font-weight: bold;
	color: #9a730a;
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
	color: #CC0000;;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
-->
</style>

<link href="style/sheet1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #575767;
}
-->
</style>
<script>
function disable()
{
    document.sform.button1.disabled=true;
    return false;
}

function applyCode()
{
	var pcode=document.sform.pcode.value;
	window.location.href="Invoice.jsp?codeflag=true&pcode="+pcode;	
}

</script>
<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
      window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#000000","#000000","#D9D9D1","#999999","center","middle",3,3,500,-5,7,true,false,true,0,false,true);
  mm_menu_0515161022_0.addMenuItem("Courses","location='CourseIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("K-Caps","location='WebinarIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("Preview","location='#'");
   mm_menu_0515161022_0.hideOnMouseOut=true;
   mm_menu_0515161022_0.bgColor='#555555';
   mm_menu_0515161022_0.menuBorder=1;
   mm_menu_0515161022_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0515161022_0.menuBorderBgColor='#777777';

mm_menu_0515161022_0.writeMenus();
} // mmLoadMenus()

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" src="mm_menu.js"></script>
</head>

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg','lb_images/btn_03_2.jpg','lb_images/btn_05_2.jpg','lb_images/btn_06_2.jpg','lb_images/btn_07_2.jpg')">
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="lb_images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="lb_images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="lb_images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom"><!-- <form id="form1" name="form1" method="post" action="">
                      <label> &nbsp;<span class="sheet">Search</span></label>
                      <label> &nbsp;
                        <input name="textfield" type="text" size="20" />
                        </label>
                    </form> --></td>
                    <td width="36" align="left" valign="baseline"><!-- <a href="#"><img src="lb_images/search_btn.jpg" width="20" height="22" border="0" /></a> --></td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="lb_images/btn_01.jpg" width="80" height="30" /></td>
                    <td width="74"><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image25','','lb_images/btn_02_2.jpg',1)"><img src="lb_images/btn_02.jpg" alt="Home" name="Image25" width="74" height="30" border="0" id="Image25" /></a><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','lb_images/btn_02_2.jpg',1)"></a></td>

                    <td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image26','','lb_images/btn_03_2.jpg',1)"><img src="lb_images/btn_03.jpg" alt="Aboutus" name="Image26" width="95" height="30" border="0" id="Image26" /></a><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','lb_images/btn_03_2.jpg',1)"></a></td>

                    <td width="170"><div align="center"><a href="CourseCatalog.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','lb_images/btn_04_2.jpg',1)"><img src="lb_images/btn_04_2.jpg" name="image1" width="170" height="30" border="0" id="image1" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1');MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1');MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1')" onmouseout="MM_startTimeout();" /></a></div></td>

                    <td width="83"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image27','','lb_images/btn_05_2.jpg',1)"><img src="lb_images/btn_05.jpg" alt="News" name="Image27" width="83" height="30" border="0" id="Image27" /></a><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','lb_images/btn_05_2.jpg',1)"></a></td>

                    <td width="96"><a href="/LBCOM/register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image28','','lb_images/btn_06_2.jpg',1)"><img src="lb_images/btn_06.jpg" alt="Register" name="Image28" width="96" height="30" border="0" id="Image28" /></a><a href="/LBCOM/register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','lb_images/btn_06_2.jpg',1)"></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','lb_images/btn_07_2.jpg',1)"><img src="lb_images/btn_07.jpg" alt="Contact" name="Image29" width="113" height="30" border="0" id="Image29" /></a><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','lb_images/btn_07_2.jpg',1)"></a></td>

                    <td width="64"><img src="lb_images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="lb_images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="200" height="38" background="lb_images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                    <td width="203" rowspan="3" valign="top" bgcolor="37728C"><img src="lb_images/img_pro1.jpg" width="202" height="112" /></td>
                  </tr>
                  <tr>
                    <td background="lb_images/bg3.jpg" bgcolor="D9D9D1"><div align="center"><img src="lb_images/name_products.jpg" width="200" height="38" /></div></td>
                    <td width="26" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                    <td width="332" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" background="lb_images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="561" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"><br />
                    </p>
                                
               <form name="sform" method="POST" >
<p>&nbsp;</p>
<table border="1" bordercolor="#C0C0C0" width="741"  cellspacing="1"">
  <tr>
    <td width=41 align="center" bgcolor="#C0C0C0" height="16">
    <b><font face="Verdana" size="2" color="#800000">Sl.No.</font></b></td>
    <td  align="center" bgcolor="#C0C0C0" height="16" width="317">
    <font face="Verdana" size="2" color="#800000"><b>Course Name</b></font></td>
   
	<td  align="center" bgcolor="#C0C0C0" height="16" width="136">&nbsp;</td>

   <!--   Just for this summer school we are removing the pricing info. Remove the above td and uncomment the below portion to display the pricing.
   <td  align="center" bgcolor="#C0C0C0" height="16" width="136">
    <font face="Verdana" size="2" color="#800000"><b>Amount($)</b></font></td> -->
   
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
    
	<!-- Just for this summer school we are removing the pricing info
	<td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= anOrder.getPrice() %></font></td> -->
    
	<td  height="19"  width="114"><font face="Verdana" size="1">
     <a href="/LBCOM/products.ShoppingServlet?action=DeleteCourse&delindex=<%= index %>"> Remove from Cart</a></font></td>

	 <td  height="19" align="center" width="136">&nbsp;</td>
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

	<!-- Just for this summer school we are removing the pricing info
    <td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= webOrder.getPrice() %></font></td> -->
    
	<td  height="19"  width="114"><font face="Verdana" size="1">
     <a href="/LBCOM/products.ShoppingServlet?action=DeleteWeb&delindex=<%= index %>"> Remove from Cart</a></font></td>

	 <td  height="19" align="center" width="136">&nbsp;</td>

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
  <tr>
    <td height="16" align="right" bgcolor="#C0C0C0" colspan="2" width="363">

		<!-- Just for this summer school we are removing the pricing info
		<font face="Verdana" size="2" color="#800000"><b>Total :</b></font> -->
	
	</td>
    <td height="16" align="center" bgcolor="#C0C0C0" width="136">

	<!-- Just for this summer school we are removing the pricing info
		<font face="Verdana" size="2"><b>$ <%= overallSum%></b></font> -->

    </td>
    <td width="114" height="16" bgcolor="#C0C0C0" align="right">&nbsp;</td>
  </tr>
</table>
<br>
<%
	codeFlag=request.getParameter("codeflag");
	if(codeFlag==null)
		codeFlag="";
	if(codeFlag.equals("true"))
	{
		con=con1.getConnection();
		st=con.createStatement();

		pCode=request.getParameter("pcode");

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
		session.setAttribute("PromoCode",pCode);
%>

		<!-- Just for this summer school we are removing the pricing info
		<table border="1" cellpadding="0" cellspacing="0" width="741" height="1">
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
<%
	}
	else
	{
%>
		<!-- Just for this summer school we are removing the pricing info
		<table border="0" cellpadding="0" cellspacing="0" width="741" height="1" bordercolor="#111111">
		<tr>
			<td width="250">
				<font face="verdana" size="2">&nbsp;Enter promotion code here:
				<font face="verdana" size="1"> (if any)</font>
			</td>
			<td width="500">
				<input type="text" name="pcode" size="10">
				<input type="button" name="gobutton" value="Go!" onclick="javascript:applyCode();"></td>  
		</tr>
		</table> -->
<%
	}	
%>
&nbsp;<p>
<br>
</p>
<table border="0" cellpadding="0" cellspacing="0" width="741" height="1" bordercolor="#111111">
  <tr>
    <td width="247" align="center"><input type="button" value="Back to Courses List" onclick="document.location.href='CourseIndex.jsp?mode=fromcart'" name="B2">
    </td>
    <td width="247" align="center"><input type="button" value="Back to K-Caps List" onclick="document.location.href='WebinarIndex.jsp?mode=fromcart'" name="B2">
    </td>
 	<td width="247" align="center">
     
<%
      if(user==null||user.equals("")) 
       {
%>
     <input type="button" value="Proceed..." name="button1"  onclick="document.location.href='/LBCOM/register/StudentLogin.jsp'"> 
<%
       }
      else
       {
%>
     <input type="button" value="Proceed..." name="button1"  onclick="document.location.href='/LBCOM/products.PaymentServlet'"> 
<%     
       }
%>
    </td>
  </tr>
  <%
      if(overallSum==0)
	{
 %>
    <script type="text/javascript">
        disable();     
	</script>
  <%
	}
	
  %>
</table>
<p>&nbsp;</p>
</form></td>
                  </tr>
                  </table>
                          <table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF"><span class="sheet"><a href="../">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="106" bgcolor="#FFFFFF" class="sheet">
                              <a href="../PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="../SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="68" bgcolor="#FFFFFF" class="sheet">
                              <a href="../Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="87" bgcolor="#FFFFFF" class="sheet"><a href="../ContactUs.html">Contact Us</a></td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="109" bgcolor="#FFFFFF" class="sheet"><a href="../feedback/GiveFeedback.html"> Feedback</a></td>
                              <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="30" colspan="14" background="lb_images/bg2.jpg" bgcolor="F3F2F0">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/bottom_stip.jpg" width="761" height="7" /></td>
                            </tr>
                        </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="lb_images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>