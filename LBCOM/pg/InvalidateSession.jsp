<%@ page session="true"%>
<%
session.invalidate();
String mode="";
mode=request.getParameter("mode");
if(mode==null||mode=="")
 {
 response.sendRedirect("/LBCOM/");
 }
else if(mode.equals("p")) //products and services
 {
  response.sendRedirect("/LBCOM/products/CourseCatalog.jsp");
 }
else if(mode.equals("pc")) //Course Index
 {
  response.sendRedirect("/LBCOM/products/CourseIndex.jsp");
 }
else if(mode.equals("pw")) //Course webinars
 {
  response.sendRedirect("/LBCOM/products/CourseWebinars.jsp");
 }
else if(mode.equals("n")) //news
 {
  response.sendRedirect("/LBCOM/news/News.jsp");
 }
else if(mode.equals("a")) //about us
 {
  response.sendRedirect("/LBCOM/AboutUs.html");
 }
else if(mode.equals("c")) //contact us
 {
  response.sendRedirect("/LBCOM/ContactUs.html");
 }
else if(mode.equals("r")) //register
 {
  response.sendRedirect("/LBCOM/register/StudentRegistration.jsp");
 }
else if(mode.equals("fb")) //feedback
 {
  response.sendRedirect("/LBCOM/feedback/GiveFeedback.html");
 }
else if(mode.equals("sm")) //site map
 {
  response.sendRedirect("/LBCOM/SiteMap.html");
 }
else if(mode.equals("faq")) //faqs
 {
  response.sendRedirect("/LBCOM/");
 }
else if(mode.equals("pp")) //privacy policy
 {
  response.sendRedirect("/LBCOM/");
 }
%>
 