<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/TALRT/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />

<% 
	String newsId="",title="",content="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int count=0;

	try
	{
		con= db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from lb_news where status=1 order by news_id desc");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="style/sheet1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style26 {
	font-family: Verdana;
	font-size: 12px;
}
.style27 {
	color: #9a730a;
	font-weight: bold;
}
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
	color: #CC0000;;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
-->
</style>
<script type="text/JavaScript">
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

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg','images/btn_03_2.jpg','images/btn_04_2.jpg','images/btn_05_2.jpg','images/btn_06_2.jpg','images/btn_07_2.jpg')">
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
               <td colspan="2"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom"><!-- <form id="form1" name="form1" method="post" action="">
                      <label> &nbsp;<span class="sheet">Search</span></label>
                      <label> &nbsp;
                        <input name="textfield" type="text" size="20" />
                        </label>
                    </form> --></td>
                    <td width="36" align="center" valign="baseline"><!-- <img src="images/search_btn1.jpg" width="19" height="19" /> --></td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="images/btn_01.jpg" width="80" height="30" /></td>

                    <td width="74"><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','images/btn_02_2.jpg',1)"><img src="images/btn_02.jpg" alt="Home" name="Image29" width="74" height="30" border="0" id="Image29" /></a></td>

                    <td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','images/btn_03_2.jpg',1)"><img src="images/btn_03.jpg" alt="About us" name="Image30" width="95" height="30" border="0" id="Image30" /></a></td>

                    <td width="170"><a href="/LBCOM/products/CourseCatalog.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','images/btn_04_2.jpg',1)"><img src="images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83"><a href="News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','images/btn_05_2.jpg',1)"><img src="images/btn_05_2.jpg" width="83" height="30"  border="0"/></a></td>

                    <td width="96"><a href="/LBCOM/register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','images/btn_06_2.jpg',1)"><img src="images/btn_06.jpg" alt="Register" name="Image33" width="96" height="30" border="0" id="Image33" /></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','images/btn_07_2.jpg',1)"><img src="images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>

                    <td width="64"><img src="images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="201" height="38" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="images/bg_news cap.jpg" bgcolor="#585340">&nbsp;</td>
                    <td width="167" rowspan="3" valign="bottom" bgcolor="#585340"><img src="images/img1_news.jpg" width="173" height="112" /></td>
                  </tr>
                  <tr>
                    <td background="images/bg3.jpg" bgcolor="D9D9D1"><img src="images/name_news.jpg" width="200" height="41" /></td>
                    <td width="26" background="images/bg_news cap.jpg" bgcolor="#585340">&nbsp;</td>
                    <td width="367" bgcolor="#585340"><div align="left">&nbsp;</div></td>
                  </tr>
                  <tr>
                    <td height="19" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="images/bg_news cap.jpg" bgcolor="#585340">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="200" valign="top" bgcolor="#F6F6F4"><img src="images/img2_news.jpg" width="200" height="322" /></td>
                    <td width="561" rowspan="2" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"></p>
                                <table width="561" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="26">&nbsp;</td>
                                    <table border="0" cellpadding="0" cellspacing="0" align="center"  >
 
  <tr>
    <td width="2%" height="149">&nbsp;</td>
    <td width="99%" height="149">

<%
		while(rs.next())
		{
			count++;
			newsId=rs.getString("news_id");
			title=rs.getString("title");
			content=rs.getString("content");
%>

	<a name="news<%=newsId%>">
	<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%" height="62" align="center">
      <tr>
        <td width="100%" height="17"><b>
        <font face="Verdana" size="2" color="#800000"><%=title%></font></b></td>
      </tr>
      <tr>
        <td width="100%" height="44"><font face="Verdana" size="2"><%=content%></font></td>
      </tr>
    </table>
	<br>
  
<%
		}	
%>
  </td>
    <td width="1%" height="149">&nbsp;</td>
  </tr>
  <tr>
    <td width="2%" height="19">&nbsp;</td>
    <td width="99%" height="19">&nbsp;</td>
    <td width="1%" height="19">&nbsp;</td>
  </tr>
</table>

<%
	if(count==0)
	{
%>
 <p align="center"><font face="verdana" size="2">There are no News.</font></p>
<%
	}	
	}
	catch(Exception e)
	{
		System.out.println("The exception in News.jsp is..."+e);
	}
%>



                                    <td width="26"><p class="sheet">&nbsp;</p></td>
                                  </tr>
                                </table>
                         </tr>
                      </table>
                         <table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF"><span class="sheet"><a href="/LBCOM/">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="106" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="68" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="87" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/ContactUs.html">Contact Us</a></td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="109" bgcolor="#FFFFFF" class="sheet"><a href="../feedback/GiveFeedback.html">Feedback</a></td>
                              <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
							<tr>
                              <td height="30" colspan="14" background="lb_images/bg2.jpg" bgcolor="F3F2F0">
                              <p align="center"><span class="sheet style14">
                              <span style="font-size: 7pt">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></span></td>
                            </tr>
                            <tr>
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
    </table></td>
  </tr>
</table>
</body>
</html>