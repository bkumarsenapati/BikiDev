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
 
<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
      window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#000000","#000000","#D9D9D1","#999999","center","middle",3,3,1000,-5,7,true,false,true,0,false,true);
  mm_menu_0515161022_0.addMenuItem("Courses","location='/LBCOM/products/CourseIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("K-Caps","location='/LBCOM/products/WebinarIndex.jsp'");
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

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg','images/btn_03_2.jpg')">
<script language="JavaScript1.2">mmLoadMenus();</script>
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
						<!-- <form id="form1" name="form1" method="post" action="">
						<label> &nbsp;<span class="sheet">Search</span></label>
						<label> &nbsp;<input name="textfield" type="text" size="20" />
                        </label>
						</form> -->
					</td>
                    <td width="36" align="center" valign="baseline">
						<!-- <img src="images/search_btn1.jpg" width="19" height="19" /> -->
					</td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2" height="4">
                <table width="761" border="0" cellspacing="0" cellpadding="0" height="30">
                  <tr>
                    <td width="80" height="30"><img src="images/btn_01.jpg" width="80" height="30" /></td>
                    <td width="74" height="30"><a href="/LBCOM/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image24','','images/btn_02_2.jpg',1)"><img src="images/btn_02.jpg" alt="About us" name="Image24" width="74" height="30" border="0" id="Image24" /></a><a href="/LBCOM/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','images/btn_02_2.jpg',1)"></a></td>

                    <td width="95" height="30"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image20','','images/btn_03_2.jpg',1)"><img src="images/btn_03.jpg" alt="Aboutus" name="Image20" width="95" height="30" border="0" id="Image20" /></a><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','images/btn_03_2.jpg',1)"></a></td>

                    <td width="170" height="30"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','images/btn_04_2.jpg',1)"><img src="images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83" height="30"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','images/btn_05_2.jpg',1)"><img src="images/btn_05.jpg" alt="News" name="Image32" width="83" height="30" border="0" id="Image32" /></a></td>

                    <td width="96" height="30"><a href="StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','images/btn_06_2.jpg',1)"><img src="images/btn_06.jpg" alt="Register" name="Image33" width="96" height="30" border="0" id="Image33" /></a></td>

                    <td width="99" height="30"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','images/btn_07_2.jpg',1)"><img src="images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>
                    <td width="64" height="30"><img src="images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2" bgcolor="#FFFFFF" height="405"><p>&nbsp;</p>
<table width="756" border="0" cellspacing="0" cellpadding="0" height="206">
<tr>
 <td height="113">
<table border="1" bordercolor="#C0C0C0" width="741"  cellspacing="1"">
  <tr>
    <td width=41 align="center" bgcolor="#C0C0C0" height="16">
    <b><font face="Verdana" size="2" color="#800000">Sl.No.</font></b></td>
    <td  align="center" bgcolor="#C0C0C0" height="16" width="317">
    <font face="Verdana" size="2" color="#800000"><b>Course Name</b></font></td>
    <td  align="center" bgcolor="#C0C0C0" height="16" width="136">
    <font face="Verdana" size="2" color="#800000"><b>Amount($)</b></font></td>
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
    <td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= anOrder.getPrice() %></font></td>
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
    <td  height="19" align="center" width="136"><font face="Verdana" size="2"><%= webOrder.getPrice() %></font></td>
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
    <p align="center"><font face="Verdana" size="2">There are no Courses/Webinars in your Cart.</font></td>
   </tr>
  <%
      }
  %>
  <tr>
    <td height="16" align="right" bgcolor="#C0C0C0" colspan="2" width="363">
		<font face="Verdana" size="2" color="#800000"><b>Total :</b></font>
	</td>
    <td height="16" align="center" bgcolor="#C0C0C0" width="136">
		<font face="Verdana" size="2"><b>$ <%= overallSum%></b></font>
    </td>
    <td width="114" height="16" bgcolor="#C0C0C0" align="right">&nbsp;</td>
  </tr>
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
	    con=con1.getConnection();
		st=con.createStatement();
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
	session.invalidate();  
%>

<tr>
 <td height="59">
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
		</table>
 </td>
 </tr>
 </table>
<br>
</form>

               </td>
              </tr>
              <tr>
                <td colspan="2" height="89"><table width="761" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
                            <tr>
                              <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="88" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="66" bgcolor="#FFFFFF"><span class="sheet"><a href="/LBCOM/">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="112" bgcolor="#FFFFFF" class="sheet"><a href="#">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="89" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF" class="sheet"><a href="#">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="96" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/ContactUs.html">Contact Us</td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/feedback/GiveFeedback.html"> Feedback</a></td>
                              <td width="90" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="35" colspan="14" bgcolor="F3F2F0"><div align="center"><span class="sheet style14">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></div></td>
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