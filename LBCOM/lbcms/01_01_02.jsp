<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",currentSlide="",slideNo="",slideContent="";
	String schoolId="",schoolPath="",developerId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	currentSlide=request.getParameter("slideno");
	developerId=request.getParameter("userid");
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select * from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no");
%>
<html>
<head>
<style type="text/css">
a:link {
	text-decoration: none;
	color: #4D0909;
}
a:visited {
	text-decoration: none;
	color: #4D0909;
}
a:hover {
	text-decoration: none;
	color: #0196E3;
}
a:active {
	text-decoration: none;
	color: #0196E3;
}</style>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
	function removeSlide(developerid,courseid,coursename,unitid,unitname,lessonid,lessonname,slid)
	{
		if(confirm("Are you sure you want to delete the lesson?")==true)
		{
			
			window.location.href="RemoveSlide.jsp?userid="+developerid+"&courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&unitname="+unitname+"&lessonid="+lessonid+"&lessonname="+lessonname+"&slideno="+slid+"&mode=delete"
			return false;
		}
		else
			return false;
	}

	function changeOrder(developerid,courseid,coursename,unitid,unitname,lessonid,lessonname)
	{
		window.open("OrderOfSlides.jsp?start=0&userid="+developerid+"&courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&unitname="+unitname+"&lessonid="+lessonid+"&lessonname="+lessonname+"");
	}

//-->
</SCRIPT>
<title><%=courseName%> Content Developer</title>
<!-- TinyMCE -->
<script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		convert_urls : false,
		relative_urls : false,
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,youtube",
// Valid elements

		valid_elements : ""+"a[accesskey|charset|class|coords|dir<ltr?rtl|href|hreflang|id|lang|name" 
  +"|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|rel|rev" 
  +"|shape<circle?default?poly?rect|style|tabindex|title|target|type]," 
+"abbr[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"acronym[class|dir<ltr?rtl|id|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"address[class|align|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"applet[align<bottom?left?middle?right?top|alt|archive|class|code|codebase" 
  +"|height|hspace|id|name|object|style|title|vspace|width]," 
+"area[accesskey|alt|class|coords|dir<ltr?rtl|href|id|lang|nohref<nohref" 
  +"|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup" 
  +"|shape<circle?default?poly?rect|style|tabindex|title|target]," 
+"base[href|target]," 
+"basefont[color|face|id|size]," 
+"bdo[class|dir<ltr?rtl|id|lang|style|title]," 
+"big[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"blockquote[cite|class|dir<ltr?rtl|id|lang|onclick|ondblclick" 
  +"|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout" 
  +"|onmouseover|onmouseup|style|title]," 
+"body[alink|background|bgcolor|class|dir<ltr?rtl|id|lang|link|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onload|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|onunload|style|title|text|vlink]," 
+"br[class|clear<all?left?none?right|id|style|title]," 
+"button[accesskey|class|dir<ltr?rtl|disabled<disabled|id|lang|name|onblur" 
  +"|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|style|tabindex|title|type" 
  +"|value]," 
+"caption[align<bottom?left?right?top|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"center[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"cite[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"code[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"col[align<center?char?justify?left?right|char|charoff|class|dir<ltr?rtl|id" 
  +"|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|span|style|title" 
  +"|valign<baseline?bottom?middle?top|width]," 
+"colgroup[align<center?char?justify?left?right|char|charoff|class|dir<ltr?rtl" 
  +"|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|span|style|title" 
  +"|valign<baseline?bottom?middle?top|width]," 
+"dd[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]," 
+"del[cite|class|datetime|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"dfn[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"dir[class|compact<compact|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"div[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"dl[class|compact<compact|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"dt[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]," 
+"em/i[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"fieldset[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"font[class|color|dir<ltr?rtl|face|id|lang|size|style|title]," 
+"form[accept|accept-charset|action|class|dir<ltr?rtl|enctype|id|lang" 
  +"|method<get?post|name|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|onreset|onsubmit" 
  +"|style|title|target]," 
+"frame[class|frameborder|id|longdesc|marginheight|marginwidth|name" 
  +"|noresize<noresize|scrolling<auto?no?yes|src|style|title]," 
+"frameset[class|cols|id|onload|onunload|rows|style|title]," 
+"h1[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"h2[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"h3[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"h4[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"h5[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"h6[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"head[dir<ltr?rtl|lang|profile]," 
+"hr[align<center?left?right|class|dir<ltr?rtl|id|lang|noshade<noshade|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|size|style|title|width]," 
+"html[dir<ltr?rtl|lang|version]," 
+"iframe[align<bottom?left?middle?right?top|class|frameborder|height|id" 
  +"|longdesc|marginheight|marginwidth|name|scrolling<auto?no?yes|src|style" 
  +"|title|width]," 
+"img[align<bottom?left?middle?right?top|alt|border|class|dir<ltr?rtl|height" 
  +"|hspace|id|ismap<ismap|lang|longdesc|name|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|src|style|title|usemap|vspace|width]," 
+"input[accept|accesskey|align<bottom?left?middle?right?top|alt" 
  +"|checked<checked|class|dir<ltr?rtl|disabled<disabled|id|ismap<ismap|lang" 
  +"|maxlength|name|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|onselect" 
  +"|readonly<readonly|size|src|style|tabindex|title" 
  +"|type<button?checkbox?file?hidden?image?password?radio?reset?submit?text" 
  +"|usemap|value]," 
+"ins[cite|class|datetime|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"isindex[class|dir<ltr?rtl|id|lang|prompt|style|title]," 
+"kbd[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"label[accesskey|class|dir<ltr?rtl|for|id|lang|onblur|onclick|ondblclick" 
  +"|onfocus|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout" 
  +"|onmouseover|onmouseup|style|title]," 
+"legend[align<bottom?left?right?top|accesskey|class|dir<ltr?rtl|id|lang" 
  +"|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"li[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title|type" 
  +"|value]," 
+"link[charset|class|dir<ltr?rtl|href|hreflang|id|lang|media|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|rel|rev|style|title|target|type]," 
+"map[class|dir<ltr?rtl|id|lang|name|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"menu[class|compact<compact|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"meta[content|dir<ltr?rtl|http-equiv|lang|name|scheme]," 
+"noframes[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"noscript[class|dir<ltr?rtl|id|lang|style|title]," 
+"object[align<bottom?left?middle?right?top|archive|border|class|classid" 
  +"|codebase|codetype|data|declare|dir<ltr?rtl|height|hspace|id|lang|name" 
  +"|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|standby|style|tabindex|title|type|usemap" 
  +"|vspace|width]," 
+"ol[class|compact<compact|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|start|style|title|type]," 
+"optgroup[class|dir<ltr?rtl|disabled<disabled|id|label|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"option[class|dir<ltr?rtl|disabled<disabled|id|label|lang|onclick|ondblclick" 
  +"|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout" 
  +"|onmouseover|onmouseup|selected<selected|style|title|value]," 
+"p[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|style|title]," 
+"param[id|name|type|value|valuetype<DATA?OBJECT?REF]," 
+"pre/listing/plaintext/xmp[align|class|dir<ltr?rtl|id|lang|onclick|ondblclick" 
  +"|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout" 
  +"|onmouseover|onmouseup|style|title|width]," 
+"q[cite|class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"s[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]," 
+"samp[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"script[charset|defer|language|src|type]," 
+"select[class|dir<ltr?rtl|disabled<disabled|id|lang|multiple<multiple|name" 
  +"|onblur|onchange|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|size|style" 
  +"|tabindex|title]," 
+"small[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"span[align<center?justify?left?right|class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"strike[class|class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title]," 
+"strong/b[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"style[dir<ltr?rtl|lang|media|title|type]," 
+"sub[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"sup[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]," 
+"table[align<center?left?right|bgcolor|border|cellpadding|cellspacing|class" 
  +"|dir<ltr?rtl|frame|height|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|rules" 
  +"|style|summary|title|width]," 
+"tbody[align<center?char?justify?left?right|char|class|charoff|dir<ltr?rtl|id" 
  +"|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|style|title" 
  +"|valign<baseline?bottom?middle?top]," 
+"td[abbr|align<center?char?justify?left?right|axis|bgcolor|char|charoff|class" 
  +"|colspan|dir<ltr?rtl|headers|height|id|lang|nowrap<nowrap|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|rowspan|scope<col?colgroup?row?rowgroup" 
  +"|style|title|valign<baseline?bottom?middle?top|width]," 
+"textarea[accesskey|class|cols|dir<ltr?rtl|disabled<disabled|id|lang|name" 
  +"|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|onselect" 
  +"|readonly<readonly|rows|style|tabindex|title]," 
+"tfoot[align<center?char?justify?left?right|char|charoff|class|dir<ltr?rtl|id" 
  +"|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|style|title" 
  +"|valign<baseline?bottom?middle?top]," 
+"th[abbr|align<center?char?justify?left?right|axis|bgcolor|char|charoff|class" 
  +"|colspan|dir<ltr?rtl|headers|height|id|lang|nowrap<nowrap|onclick" 
  +"|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove" 
  +"|onmouseout|onmouseover|onmouseup|rowspan|scope<col?colgroup?row?rowgroup" 
  +"|style|title|valign<baseline?bottom?middle?top|width]," 
+"thead[align<center?char?justify?left?right|char|charoff|class|dir<ltr?rtl|id" 
  +"|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown" 
  +"|onmousemove|onmouseout|onmouseover|onmouseup|style|title" 
  +"|valign<baseline?bottom?middle?top]," 
+"title[dir<ltr?rtl|lang]," 
+"tr[abbr|align<center?char?justify?left?right|bgcolor|char|charoff|class" 
  +"|rowspan|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title|valign<baseline?bottom?middle?top]," 
+"tt[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]," 
+"u[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress|onkeyup" 
  +"|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]," 
+"ul[class|compact<compact|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown" 
  +"|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover" 
  +"|onmouseup|style|title|type]," 
+"var[class|dir<ltr?rtl|id|lang|onclick|ondblclick|onkeydown|onkeypress" 
  +"|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style" 
  +"|title]",
		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft,youtube",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/wysiwyg.js"></script>  -->
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	
	var win=document.secondpage;
	var e=document.secondpage.slidecontentgen.value;
	//replacequotes();
	//	win.submit();
}

function gotoThirdPage()
{
	window.location.href="01_01_03.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>";
}
-->
</SCRIPT>
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>

<form method="POST" name="secondpage" action="SaveSlide.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=currentSlide%>">

<table width='770' border='1' align='center' cellpadding='0' cellspacing='0' height="486"><tr>
		<td align='left' valign='top' width='766' height="484"><table id='Table_01' width='800' height='400' border='0' cellpadding='0' cellspacing='0' align='center'><tr><td rowspan='14' width='1' height='399'><img src='images/content_01.jpg' width='1' height='600' alt=''></td>
    <td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
    <b><font face="Verdana" size="4">&nbsp;<font color="#FFFFFF"><%=courseName%></font></font></b></td><td colspan='2' rowspan='2' width='328' height='1'><img src='images/content_03.jpg' width='328' height='58' alt=''></td><td colspan='3' rowspan='2' width='129' height='1'><img src='images/content_04.jpg' width='129' height='58' alt=''></td><td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td colspan='2' rowspan='2' width='65' height='1' valign='top'>
    <a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>"><img src='images/content_06.jpg' width='87' height='78' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>&nbsp;<font face="Verdana" size="2">&nbsp;<b><%=unitName%>:</b>&nbsp;<%=lessonName%></font></td>
	  <td width='23' height='1'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td colspan='12' width='776' align='left' valign='top' rowspan='8' height='376'>
      
		<table width='795' border='0' cellspacing='0' cellpadding='0' height='1'><tr>
			<td width='5' height='26'></td>
			<td width='653' height='26' colspan="2">
				<b><font size="2" face="Verdana" color="#FFFFFF">
<%
			int slidedisplay=1;
			while(rs.next())
			{
				slideNo=rs.getString("slide_no");
				
				if(currentSlide.equals(slideNo))
				{
					slideContent=rs.getString("slide_content");
%>
					<span style="background-color: #FF0000">&nbsp;<%=slidedisplay%>&nbsp;</span>
<%
				}
				else
				{
%>
					<span style="background-color: #C0C0C0">&nbsp;<a href="01_01_02.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=slideNo%>"><%=slidedisplay%></a>&nbsp;</span>
<%
				}	
				slidedisplay++;
			}
%>
				</font></b>
			</td>

				<td width='137' class='main' height='26'></td>
		</tr>
		<tr>
			<td width='5' height='1'></td>
			<td width='362' height='18' align='left'>
				<font color="#800080" face="Verdana" size="2">&nbsp;Enter the slide content in the following box:</font>
			</td>
			<td width='291' height='18' align='right'>
				<b><font size="1" face="Verdana">
				<a href="AddANewSlide.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=slideNo%>">ADD A NEW SLIDE</a></font></b></td>
        <td width='137' class='main' height='1'></td></tr><tr>
        <td width='5' height='92'>
        <p align="center">&nbsp;</td>
			<td width='653' height='181' align='center' colspan="2">
				<textarea name="slidecontentgen" id="slidecontentgen" rows="1" cols="40"><%=slideContent%></textarea>
				<script language="JavaScript">
					//generate_wysiwyg('slidecontentgen');			
				</script>
			</td><td width='137' class='main' height='92'>&nbsp;</td></tr><tr>
          <td height='22' width='5'></td>
          <td height='22' width='430'>
          <p align="left"><b><font size="1" face="Verdana">
          <a href="#" onClick="javascript:return removeSlide('<%=developerId%>','<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=unitName%>','<%=lessonId%>','<%=lessonName%>','<%=currentSlide%>')">
		  <!-- <a href="RemoveSlide.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=slideNo%>"> -->REMOVE THIS SLIDE</a></font></b>&nbsp;&nbsp;&nbsp;

		  <b><font size="1" face="Verdana">
		  <a href="#" onClick="javascript:return changeOrder('<%=developerId%>','<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=unitName%>','<%=lessonId%>','<%=lessonName%>','<%=currentSlide%>');">Manage SLIDES</a></font></b></td>
          <td height='22'>
          <p align="right"><b><font size="1" face="Verdana">
          <a href="javascript:void(0)" onClick="return validate();"></a> <input type="submit" alt='Save and move to the next page' border='0' onClick="return validate();" value="SAVE THIS SLIDE"></font></b></td>
          <td class='main_s' height='22' valign='top' width='137'>&nbsp;</td></tr></table></td><td width='23' height='25'><img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23' height='38'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' height='30'><img src='images/spacer.gif' width='1' height='30' alt=''></td></tr><tr><td width='23' height='40'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='40'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='58'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'><img src='images/content_26.jpg' width='628' height='47' alt=''></td><td colspan='4' width='148' height='47'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='images/content_30.jpg' width='73' height='39' alt=''></td>
		  <td colspan='2' rowspan='2' width='48' height='39'><a href="01_01_01.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>"><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><input type="image" src='images/content_32.jpg' width='49' height='39' alt='Save and move to the next page' border='0' onClick="gotoThirdPage(); return false;"></td><td width='23' height='19'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table></td></tr></table>
</form>

<%
		}
		catch(Exception e)
		{
			System.out.println("The exception1 in 01_01_02.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in 01_01_02.jsp is....."+se.getMessage());
			}

    }
%>

</body>


</html>