<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page session="true"%>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
		Connection connection = null;
		Statement statement = null,statement1 = null;
		ResultSet rs = null,rs1= null;
		String image,linkStr="",c_id=null, c_name=null;
		int totRecords=0,start=0,end=0,c=0,pageSize=3,currentPage=0;
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
<SCRIPT LANGUAGE="JavaScript">
      function go(start){
       window.location.href="CourseIndex.jsp?start="+start+"";
       return false;
     }
	
</SCRIPT>
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
                    <td width="219" align="center" valign="bottom">
						<!-- <form id="form1" name="form1" method="post" action="">
						<label> &nbsp;<span class="sheet">Search</span></label>
						<label> &nbsp;<input name="textfield" type="text" size="20" />
                        </label></form> -->
					</td>
                    <td width="36" align="left" valign="baseline">
						<!-- <a href="#"><img src="lb_images/search_btn.jpg" width="20" height="22" border="0" /></a> -->
					</td>
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
                    <td width="200" height="46" valign="top" bgcolor="F6F6F4"><img src="lb_images/img_pro2.jpg" width="200" height="303" /></td>
                    <td width="561" rowspan="2" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"><br />
                    </p>
                                <table width="561" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="26">&nbsp;</td>
                                    <td width="509"><p class="sheet style28">K- 
                                    Caps:</p>
                                        <p align="justify"> <span class="sheet">We will offer 
                                        K-Caps (recorded classroom sessions) in Math, 
                                        Language Arts, Science and Social 
                                        Studies soon. Currently there are no K-Caps available. </span></p>
                                      </td>
                                    <td width="26"><p class="sheet">&nbsp;</p></td>
                                  </tr>
                                  <tr>
                                    <td colspan="3">&nbsp;</td>
                                  </tr>
                                </table>
<%
       try
	    {
		connection=con1.getConnection();
		statement = connection.createStatement();
        statement1 = connection.createStatement();
		rs= statement.executeQuery("select count(webinarid) from lb_webinar_catalog ");	   
		if(rs.next())
		  totRecords = rs.getInt(1);
                String temp=request.getParameter("start");
                 if(totRecords==0)
                   {
                     start=-1;
                   }
                 else 
		  if(temp==null||temp.equals(""))
		  {
			  start=0;
		  }
		  else
		  {
		  start=Integer.parseInt(temp);
		  }
		  c=start+pageSize;
	      currentPage=c/pageSize;
	      end=start+pageSize;
	      if (c>=totRecords)
		  end=totRecords;	
%>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="500">
     <table width="497" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="176"><img src="images/video2_03.jpg" width="176" height="33" /></td>
        <td width="321" rowspan="2" align="left" valign="bottom"><table width="321" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="321"><img src="images/video2_05.jpg" width="321" height="19" /></td>
            </tr>
        </table></td>
      </tr>
   </table>
      <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr><td>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="50%">
				<font face="verdana" size="2" color="#800000"> <%= start+1%> - <%= end%> of <%= totRecords%></font>
			</td>
			<td width="50%" align="right">
				<font face="verdana" size="2" color="black">
<%
        if(start==-1)
         {
           out.println("Previous | Next");
         }
         else if(start==0){ 
		if(totRecords>end){
		   out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\">Next</a>");
		     }else
	       out.println("Previous | Next");
             }
		    else{
           linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "');return false;\"> Previous</a> |";
             if(totRecords!=end){
			      linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\"> Next</a>";
			      }else
				linkStr=linkStr+" Next";
	            out.println(linkStr);
    }	
%>
				</font>
			</td>
     </tr>
    </table>
   </td>
  </tr>
        <tr>
          <td height="5" b><img src="images/home1_08.jpg" width="496" height="5" /></td>
        </tr>
      </table>
      <table width="496" border="0" cellspacing="0" cellpadding="0" bgcolor="#EEECEA">
<%
        if(start!=-1)
         {
	rs = statement.executeQuery("select * from lb_webinar_catalog LIMIT "+start+"," +pageSize);
	while (rs.next())
        {
	     image="videos/images/"+rs.getString("image_path");
	     float w_cost;
	  //w_cost=Float.parseFloat(rs.getString("cost"));
          c_id=rs.getString("courseid");
          rs1=statement1.executeQuery("select title from lb_course_catalog where course_id='"+c_id+"'");
           if(rs1.next())
            {
            c_name=rs1.getString("title");
            } 
            else
            {
             c_name="";
            }
			
%>
        <tr>
          <td width="18" rowspan="3" valign="bottom" background="images/index_09.jpg" bgcolor="EEECEA">&nbsp;</td>
          <td width="105" bgcolor="#EEECEA">&nbsp;</td>
          <td width="355" rowspan="3" align="left" valign="middle" bgcolor="EEECEA">
		  <table width="340" border="0" align="right" cellpadding="0" cellspacing="0" height="159">
            <tr>
              <%         
            if(!c_name.equals(""))
               {
%>
              <td width="60%" height="30"><font face="verdana" size="2"><%=rs.getString("title")%></font><font face="verdana" size="1">(<%= c_name%>)</font> </td>
              <%
               }
               else
               { 
%>
              <td width="70%" height="30"><font face="verdana" size="2" color="brown"><b><%= rs.getString("title")%></b></font></td>
              <%
               }
%>
              <td width="30%" height="30" align="right"><font face="verdana" size="2"  color="brown"><b><%= rs.getString("category")%></b></font> </td>
            </tr>
            <tr>
              <td colspan="2" align="justify" valign="top" height="113"><font face="verdana" size="2"><%=rs.getString("description")%></font><br />
                  <br /></td>
            </tr>
            <tr>
              <!-- <td height="16"><font face="verdana" size="2"  color="brown"><b>Cost : $<%=rs.getString("cost")%> </b></font></td> -->
              <td height="16"><font face="verdana" size="2" color="brown"><b>Cost : </b></font> <font face="verdana" size="1" color="black" title="Contact your School Administrator">Contact your School Administrator</font> </td>
              <td align="right" height="16"><b><a href="/LBCOM/products.ShoppingServlet?action=AddWeb&amp;wid=<%=rs.getString("webinarid")%>">
			  <font face="verdana" size="2"  color="brown">Add to Cart</font></a></b></td>
            </tr>
          </table></td>
          <td width="18" rowspan="3" align="left" valign="middle" background="images/index_09_1jpg.jpg" bgcolor="EEECEA">&nbsp;</td>
        </tr>
        <tr>
          <td height="122" bgcolor="EEECEA" class="box" align="center" > <img border="0" src="<%= image%>" width="96" height="96"></td>
        </tr>
        <tr>
          <td colspan="5" align="center" color="white">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="5" valign="top" bgcolor="#FFFFFF"><img src="images/home1_08.jpg" width="496" height="5" /></td>
          </tr>
<%       }
        }
       
%>
      </table>
       <%-- <div><img src="images/home1_08.jpg" width="496" height="5" /></div> --%>
      <table width="450" border="0" cellspacing="0" cellpadding="0">
 <tr><td>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="50%">&nbsp;</td>
		<td width="50%" align="right">
			<font face="verdana" size="2" color="black">
		
<%
        if(start==-1)
         {
           out.println("Previous | Next");
         }
         else if(start==0){ 
		if(totRecords>end){
		   out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\">Next</a>");
		     }else
	       out.println("Previous | Next");
             }
		    else{
           linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "');return false;\"> Previous</a> |";
             if(totRecords!=end){
			      linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\"> Next</a>";
			      }else
				linkStr=linkStr+" Next";
	            out.println(linkStr);
         }	
    }
    	catch(Exception e)
        { 
          ExceptionsFile.postException("WebinarIndex.jsp","operations on database","Exception",e.getMessage());	 
          System.out.println("Error in WebinarIndex.jsp:---" + e.getMessage());
        }
        finally{     //closes the database connections at the end
		   try{
			if(rs!=null)
				rs.close();
			if(statement!=null)
				statement.close();
			if(connection!=null && !connection.isClosed())
				connection.close();
		   }catch(SQLException se){
			 ExceptionsFile.postException("WebinarIndex.jsp","closing statement object","SQLException",se.getMessage());	 
			 System.out.println("Error in WebinarIndex.jsp:---" + se.getMessage());
		}
	}
%>
			</font>
      </td>
     </tr>
    </table>
   </td>
  </tr>
        <tr>
          <td><img src="images/video2_08.jpg" width="497" height="15" /></td>
        </tr>
      </table>
     </td>
  </tr>
 
</table></td>
                  </tr>
                  <tr>
                    <td background="lb_images/bg_img down.jpg" bgcolor="F6F6F4">&nbsp;</td>
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
                              <td height="30" colspan="14" background="lb_images/bg2.jpg" bgcolor="F3F2F0">
                              <p align="center"><span class="sheet style14">
                              <span style="font-size: 7pt">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></span></td>
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