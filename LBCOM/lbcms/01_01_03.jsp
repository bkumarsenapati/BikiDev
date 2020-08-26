<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assmtId="",assmtName="",catId="";
	String activity="",assessment="",assignment="",lessonLength="",developerId="",tableName="",tableName1="";
	String secTitle="",secContent="",secStatus="";
	String aTitle="",aAssessTitle="",aAssgnTitle="",acts="",assgns="",assmts="";

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	developerId=request.getParameter("userid");

%> 
<%     
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs10=null,rs11=null;
	Statement st=null,st1=null,st2=null,st10=null,st11=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
			tableName1="lbcms_dev_asmt_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
			tableName1="lbcms_dev_asmt_science_content_master";
		
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
			tableName1="lbcms_dev_asmt_math_content_master";
		
		}
		rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>

<html>
<head>
<title><%=courseName%> Content Developer</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'>
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
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'></script>
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

<!-- Script for Modal popup menu -->
<link type="text/css" href="styles/lbstyles/jquery.window.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<!-- Script for Window -->
<script type="text/javascript" src="js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript" src="js/jquery/window/jquery.window.min.js"></script>
<script type="text/javascript" src="js/assgncustom.js"></script>
<script type="text/javascript" src="js/assmtcustom.js"></script>


<!-- /TinyMCE -->
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/3wysiwyg.js"></script>  -->
<SCRIPT LANGUAGE="JavaScript">



<!--
function validate()
{
	var win=document.thirdpage;
	var act=document.thirdpage.activity.value;
	var ass=document.thirdpage.assessment.value;
	var asg=document.thirdpage.assignment.value;

		replacequotes();
		//win.submit();
	
	
}

function goAssgn()
{
	var assgnNo=document.thirdpage.assgnlist.value;
	if(assgnNo!="assgnall")
	{
		
		var win
			win=window.open("AssignmentPreview.jsp?course_id=<%=courseId%>&unit_id=<%=unitId%>&lesson_id=<%=lessonId%>&assgn_no="+assgnNo+"");
	}
}
function goAssmt()
{
	var assmtNo=document.thirdpage.assmtlist.value;
	if(assmtNo!="assmtall")
	{
		var win;
			win=window.open("/LBCOM/lbcms/AssmtBuilder/index.jsp?mode=edit&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assmt="+assmtNo);
	}
}
function hide(x)
{
	document.getElementById(x).style.display='none';	
}

function show(x)
{	
	document.getElementById(x).style.display='';
}


function show1(x)
{
		
	show('divactmain');
	show('divact');
	show('rmv');
	hide('divwwtp');
}


function hide1(x)
{
		
	//document.getElementById(x).style.display='none';
	if(x=='rmv')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			document.getElementById('chkact').checked = true;
		document.getElementById('chkact').value = 'none';
		hide('chkact');
		hide('divactmain');
		hide('divact');
		hide('rmv');
		hide('acttitleicon');
			hide('actrmv');
			hide('actclmn');
			hide('actsecimg');
		show('divwwtp');
		}
	}
	if(x=='rmvassess')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			document.getElementById('chkassmt').checked = true;
		document.getElementById('chkassmt').value = 'none';
			hide('chkassmt');
		hide('rmvassess');
		hide('assessmain');
		hide('divassess');
		hide('assmttitleicon');
			hide('assmtrmv');
			hide('assmtclmn');
			hide('assmtsecimg');
		}
		
		
	}
	if(x=='rmvassgn')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			document.getElementById('chkassgn').checked = true;
		document.getElementById('chkassgn').value = 'none';
			hide('chkassgn');
		hide('divassgnmain');
		hide('divassgn');
		hide('divassgntext');
		hide('assgntitleicon');
			hide('assgnrmv');
			hide('assgnclmn');
			hide('assgnsecimg');
		}
						
	}
	
	
}
function showSec6(x)
{	
	document.getElementById('section6').style.display='';
	hide('seccontrol');
	show('sec7');
	show('sec6');
	
}
function showSec7(x)
{	
	document.getElementById('section7').style.display='';
	hide('sec7');
	show('sec8');
	hide('seccontrol');
	
}
function showSec8(x)
{	
	document.getElementById('section8').style.display='';
	hide('sec8');
	show('sec9');
	hide('seccontrol');
	hide('sec7');
	
}
function showSec9(x)
{	
	document.getElementById('section9').style.display='';
	hide('sec9');
	show('sec10');
	hide('seccontrol');
	hide('sec7');
	hide('sec8');
	
}
function showSec10(x)
{	
	document.getElementById('section10').style.display='';
	hide('sec10');
	show('sec11');
	hide('seccontrol');
	hide('sec7');
	hide('sec8');
	hide('sec9');
	
}
function hidesec(x)
{
		
	if(x=='rmvsec6')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect6').value = 'none';
		
		hide('section6');
		hide('sec7');
		show('seccontrol');
		hide('sectitleicon6');
		hide('secrmv6');
		hide('secimg6');
		
		}
		
	}
	if(x=='rmvsec7')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect7').value = 'none';
		
		hide('section7');
		hide('sectitleicon7');
			hide('secrmv7');
			hide('secimg7');
		show('sec8');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec8')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect8').value = 'none';
		hide('section8');
		hide('sectitleicon8');
			hide('secrmv8');
			hide('secimg8');
		show('sec9');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec9')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect9').value = 'none';
		hide('section9');
		hide('sectitleicon9');
			hide('secrmv9');
			hide('secimg9');
		show('sec10');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec10')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect10').value = 'none';
		hide('section10');
		hide('sectitleicon10');
			hide('secrmv10');
			hide('secimg10');
		show('sec11');
		hide('seccontrol');
		}
		
	}
	
}
-->
</SCRIPT>
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' onLoad="hide('divact');hide('divassess');hide('divassgn');">

<form method="POST" name="thirdpage" action="ThirdPageContent.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">

<table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'><table id='Table_01' width='800' height='601' border='0' cellpadding='0' cellspacing='0' align='center'><tr>
  <td rowspan='10' width='1'></td>
  <td colspan='5' rowspan='2' width='254' background="images/content_03.jpg">
  <font color="#FFFFFF">&nbsp; </font>
  <font face="Verdana" size="4" color="#FFFFFF"><b><%=courseName%></b></font></td><td colspan='2' rowspan='2' width='328'><img src='images/content_03.jpg' width='328' height='58' alt=''></td><td colspan='3' rowspan='2' width='129'><img src='images/content_04.jpg' width='129' height='58' alt=''></td><td colspan='2' width='65'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td><td width='23'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td colspan='2' rowspan='2' width='65'><a href='CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>'><img src='images/content_06.jpg' width='87' height='78' alt='' border='0'></a></td><td width='23'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711'><font face="Verdana" size="2">&nbsp;<b><%=unitName%>:</b>&nbsp;<%=lessonName%></font></td><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr>
  <td colspan='12' width='776' align='left' valign='top' rowspan='4'>
<%
		if(rs.next())
		{
			activity=rs.getString("activity");
			if(activity==null)
			{
				activity="None";
				
			}
			assessment=rs.getString("assessment");
			if(assessment==null)
				assessment="None";
			assignment=rs.getString("assignment");
			if(assignment==null)
				assignment="None";
			lessonLength=rs.getString("lesson_length");
			if(lessonLength==null)
				lessonLength="One Day";
			aTitle=rs.getString("lesson_activity");
			aAssessTitle=rs.getString("lesson_assessment");
			aAssgnTitle=rs.getString("lesson_assignment");

			acts=rs.getString("activitystatus");
			assgns=rs.getString("assignmentstatus");
			assmts=rs.getString("assessmentstatus");
%>
  <table width='795' border='0' cellspacing='0' cellpadding='0' height='1'>
  <%
   if(!acts.equals("none"))
	{
%>
<tr>
<div id="divactmain">
	
	<%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='acttitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
		%>
		<td width='8' height='25' id="actsecimg" align='center' rowspan="2" valign="top">
		<div id='acttitleicon'>
		<a href="/LBCOM/lbcms/SelectSecImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=acttitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
		   
	   <td width='1370' class='main' height='32' id="actclmn">  
	
        <font face="Verdana" size="2" color="#FF0000"><b>&nbsp;<a onClick="show('divact')"><%=aTitle%></a></b></font></b>
		<!-- <input type="button" value="Edit" onClick="show('divact')">
		<input type="button" value="Hide" onClick="hide('divact')"> -->
		<input type="button"  id="actrmv" value="Remove" onClick="hide1('rmv')">
		<%
			if(acts.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkact" id="chkact"  value="hide" Title="Hide from Course Viewer" checked>
			<%

			}
			else
			{
			%>
				<input type="checkbox" name="chkact" id="chkact" value="hide" Title="Hide from Course Viewer">
			<%
			}
			%>

		</div>
		
		<div id="divact">
				<input type="text" name="activitytitle" id="activitytitle" value="<%=aTitle%>" onClick="this.value='<%=aTitle%>';">
			</div>
		</td></tr>
		<tr>
			<td width='1383' height='64' align='center' valign='top'>
      <p align="left">
	  <div id="rmv">
      <textarea rows="5" name="activity" id="activity" cols="83"><%=activity%></textarea>
	 <!--  <script language="JavaScript">
			generate_wysiwyg('activity');
		 </script> -->
		</td></tr><tr><td width='23' height='14' align='center' valign='top'></td><td width='1383' height='14' align='center' valign='top'>
      <hr color='#008080' width='700' size='1' align='left' noshade>
	   </div>
	  </td></tr>

	  <%
			}
		 %>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>

<%
			  if(!assmts.equals("none"))
			{
%>
	  <tr>
	  
    <%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		
		System.out.println("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
		
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
		%>
		<div id='assessmain'>
		<td width='8' height='4' id="assmtsecimg" align='center' rowspan="2" valign="top">
		<div id='assmttitleicon'>
		<a href="/LBCOM/lbcms/SelectSecImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=assmttitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
		
    <td width='1370' class='main' height='32'  id="assmtclmn"><b>
	
    
    <p align="left"><font face="Verdana" size="2" color="#FF0000"><b>&nbsp; 
      <font face="Verdana" size="2" color="#FF0000"><a onClick="show('divassess')"><%=aAssessTitle%></a></font></b>
	  
	  <!-- <input type="button" value="Edit" onClick="show('divassess')">
		<input type="button" value="Hide" onClick="hide('divassess')"> -->
		<input type="button" id="assmtrmv" value="Remove" onClick="hide1('rmvassess')">

		<%
		  
			if(assmts.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkassmt" id="chkassmt"  value="hide" Title="Hide from Course Viewer" checked>
		<%
			}
			else
			{%>
			
				<input type="checkbox" name="chkassmt" id="chkassmt" value="hide" Title="Hide from Course Viewer">
				<%
			}
			%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="/LBCOM/lbcms/AssmtBuilder/AssessmentDeveloperWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" target="_blank"><img src="/LBCOM/lbcms/images/add.gif" border="0" title="Create Assessment"></a>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <!-- <a href="/LBCOM/lbcms/AssmtBuilder/AssmtArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" target="_blank"> <span style="padding-left:25px">Assessments Archived </span></a> -->

			<a href="javascript:createWindowWithBoundary1();"><img src="/LBCOM/lbcms/images/createnew.gif" border="0" title="Assessment Archives"></a>
		</div>
		
		
			<div id="divassess">
				<input type="text" name="assessmenttitle" id="assessmenttitle" value="<%=aAssessTitle%>" onClick="this.value='<%=aAssessTitle%>';">
			</div></b></font>
					<div id="assmtcount">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="assmtlist" style="margin-left:20px" onChange ="goAssmt('<%=courseId%>'); return false;">
						<option value="assmtall" selected >-- Assessments --</option>
<%
			 int asmtNo=1;
			st1=con.createStatement();
			st2=con.createStatement();
			//rs2=st2.executeQuery("show tables like 'dev_assessment_master'");
			//if(rs2.next())
			//{

				//System.out.println("select * from lbcms_dev_assessment_master  where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
			rs1=st1.executeQuery("select * from lbcms_dev_assessment_master  where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
			
			while(rs1.next())
			{
				assmtId=rs1.getString("assmt_id");
				assmtName=rs1.getString("assmt_name");
				catId=rs1.getString("category_id");
			 %>
		<!-- <span style="background-color: #C0C0C0">&nbsp;<a href="AssmtBuilder/index.jsp?mode=edit&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assmt=<%=rs1.getString("slno")%>&asname=<%=assmtName%>&cattype=<%=catId%>&assmtId=<%=assmtId%>" target="_blank">&nbsp;<%=asmtNo%></a></span> -->

					 <option value="<%=rs1.getString("slno")%>"> <%=assmtName%> </option>
			 <%
				// asmtNo++;
			}
			st1.close();
			rs1.close();
			//}
			st2.close();
			//rs2.close();
%>
						
						
						
						</select>
					</div>
					</td>
					</tr>


			<tr>
			<td width='1383' height='61' align='center' valign='top'>
      
	  <p align="left">
	  <div id="rmvassess">
      <textarea rows="5" name="assessment" id="assessment" cols="83"><%=assessment%></textarea>
	   <!-- <script language="JavaScript">
			generate_wysiwyg('assessment');
		 </script> -->
		</td></tr>
<%
			}
		else
			{
			%>
				<input type="hidden" name="chkassmt" id="chkassmt"  value="none">
			<%

			}
	  
%>
		
		
		<tr><td width='23' height='19' align='center' valign='top'>&nbsp;</td><td width='1383' height='19' align='center' valign='top'>
      <hr color='#008080' align='left' width='700' size='1' noshade>
	  </div>
	  </td></tr>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <!-- Add Assignments Later! -->
	  <%
			 if(!assgns.equals("none"))
			{
%>
	  <tr>
	  <div id='divassgnmain'>
    
    <%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assgntitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
		%>
		<td width='8' height='4' id="assgnsecimg" align='center' rowspan="2" valign="top">
		<div id='assgntitleicon'><a href="/LBCOM/lbcms/SelectSecImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=assgntitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
		
		 <td width='1370' class='main' height='32'  id="assgnclmn"><b>
	
    
	
      <font face="Verdana" size="2" color="#FF0000"><b><a onClick="show('divassgn')"><%=aAssgnTitle%></a></b></font>
		
		<!-- <input type="button" value="Edit" onClick="show('divassgn')">
		<input type="button" value="Hide" onClick="hide('divassgn')"> -->
		<input type="button"  id="assgnrmv" value="Remove" onClick="hide1('rmvassgn')">

		<%
		  
			if(assgns.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkassgn" id="chkassgn"  value="hide" Title="Hide from Course Viewer" checked>
		<%
			}
			else
			{%>
			
				<input type="checkbox" name="chkassgn" id="chkassgn" value="hide" Title="Hide from Course Viewer">
				<%
			}
			%>  &nbsp;&nbsp;&nbsp;&nbsp;
			<a href="CourseDeveloperWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" target="_blank"><span style="padding-left:15px"><img src="/LBCOM/lbcms/images/add.gif" border="0" title="Create Assignment"></span></a>
			<!-- <a href="/LBCOM/lbcms/AssgnmtArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" target="_blank"> <span style="padding-left:25px">Assignments Archived </span></a> -->
			  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:createWindowWithBoundary();"><img src="/LBCOM/lbcms/images/createnew.gif" border="0" title="Assignment Archives"></a>


			
               <!--  <a href="#"> <span style="padding-left:25px">Select </span></a> -->
               
			<div id="divassgn">
				<input type="text" name="assignmenttitle" id="assignmenttitle" value="<%=aAssgnTitle%>" onClick="this.value='<%=aAssgnTitle%>';">
                
			</div>
			
				
				<div id="assgncount">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="assgnlist" style="margin-left:20px" onChange ="goAssgn('<%=courseId%>'); return false;">
						<option value="assgnall" selected> -- Assignments --</option>
			<%

				// Assignment count start from here
					
					st1=con.createStatement();
					System.out.println("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

					rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
					
					while(rs1.next())
					{				
					 %>
						
						<option value="<%=rs1.getString("assgn_no")%>"> <%=rs1.getString("assgn_name")%> </option>
						
					 <%
					
					}
					st1.close();
					rs1.close();
					

		 %>
					</select>	
					</div>
					</td>
					</tr>


   
   
   <tr>
      <td width='1383' height='42' align='center' valign='top'>
      <p align="left">
	  <div id='divassgntext'>
      <textarea rows="5" name="assignment" id="assignment" cols="83"><%=assignment%></textarea>
	   
	  </td></tr><tr><td width='23' height='18' align='center' valign='top'></td><td width='1383' height='18' align='center' valign='top'>
      <hr color='#008080' align='left' width='700' size='1' noshade>
	  </div>
	  </td></tr>

<%
			}
%>
	  
	  <!-- Sections added fro here  -->
<%
		
			int i=5;
			st2=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs2=st2.executeQuery("select * from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no>5 order by section_no");
			while(rs2.next())
			{
				 i++;
				 secTitle=rs2.getString("section_title");
				 secContent=rs2.getString("section_content");
				 secStatus=rs2.getString("sectionstatus");
							
%>	
		<tr>
			 <div id="section<%=i%>">
			
    	  
	  <%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+i+"'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
		%>
		<td height='19' width='8' id="secimg<%=i%>" align='center' rowspan="2" valign="top">
		<div id='sectitleicon<%=i%>'><a href="/LBCOM/lbcms/SelectSecImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=i%>" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
		<td height='19' class='main_s' width='1370' id="secrmv<%=i%>">
	 
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="sect<%=i%>" id="sect<%=i%>" value="<%=secTitle%>" onClick="this.value='';"></font></b><input type="button" value="Remove" onClick="hidesec('rmvsec<%=i%>')">
	  <%
			System.out.println("&&&&&&&&&^^^^ secStatus..."+secStatus);
			if(secStatus.equals("hide"))
			{

		  %>
				 <input type="checkbox" name="secstatus<%=i%>" id="secstatus<%=i%>"  value="hide" Title="Hide from Course Viewer" checked>
				 <%
			}
		  else
			{
			 %>
					<input type="checkbox" name="secstatus<%=i%>" id="secstatus<%=i%>"  value="hide" Title="Hide from Course Viewer">
			  <%
			}
			  %>
	 
	  <BR>
		 <textarea name="seca<%=i%>" id="seca<%=i%>" rows="1" cols="82"><%=secContent%></textarea>
		 <tr><td><div id='sec<%=i+1%>'><font face='Arial' color='blue' title="Add Section Here"><span id='span94' style='cursor: hand;' onClick="showSec<%=i+1%>('sec<%=i+1%>')">  <b>+</b></span></font></div></td></tr>
		 </div>
		
		<script type="text/javascript">
			 hide('sec<%=i%>');
			 show('section<%=i%>');
		 </script> 

		 </td>
		 </tr>
<%		
		}
		  

	  st2.close();
	  System.out.println("i value=="+i);
	  for(int k=i+1;k<=10;k++)
			{

%>			 
		
		<tr>
        <td height='19' width='8'>&nbsp;</td>
        <td height='19' class='main_s' width='1370'>
	  
	  <b>
	  <div id="section<%=k%>">
	  <script type="text/javascript">
		 hide('section<%=k%>');
		 
	  </script>  
 <div id='<%=k%>'>
		
		<%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+k+"'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
		%>
		<a href="/LBCOM/lbcms/SelectSecImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=k%>" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="sect<%=k%>" id="sect<%=k%>" value="Enter title here" onClick="this.value='';"></font></b><input type="button" value="Remove" onClick="hidesec('rmvsec<%=k%>')"> <input type="checkbox" name="secstatus<%=k%>" id="secstatus<%=k%>"  value="hide" Title="Hide from Course Viewer"><BR>
		 <textarea name="seca<%=k%>" id="seca<%=k%>" rows="1" cols="82">&nbsp;</textarea>
		 <tr><td><div id='sec<%=k+1%>'><font face='Arial' color='blue' title="Add Section Here"><span id='span94' style='cursor: hand;' onClick="showSec<%=k+1%>('sec<%=k+1%>')">  <b>+</b> </span></font></div></td></tr>

		 </div>
		 <script type="text/javascript">
			  hide('sec<%=k+1%>');
		

	  </script>  
		 </td>
		 </tr>
<%

			}
			if(i==5)
			{
%>

		<!--   Main  --->
		 <tr><td><div id='seccontrol'><font face='Arial' color='blue' title="Add Section Here"><span id='span94' style='cursor: hand;' onClick="showSec6('section6')">  <b>+</b></span></font></div></td></tr>

		 <!-- Upto here --->
<%
			}
		
		%>


	  <!--         Upto here ---- -->

	  
	  <tr>
    <td width='23' height='1' align='center' valign='top'></td>
    <td width='1383' height='1' align='center' valign='top'>
    <p align="left"><b><font face="Verdana" size="2" color="#FF0000">&nbsp;LENGTH</font></b></td></tr><tr>
      <td width='23' height='1' align='center' valign='top'></td>
      <td width='1383' height='1' align='left' valign='top'>
        <input name="lessonlength" size="26" value="<%=lessonLength%>"></td></tr>
<%
		}	
%>
		<tr><td width='23' height='18' align='center' valign='top'></td><td width='1383' height='18' align='center' valign='top'>
      <hr color='#008080' align='left' width='700' size='1' noshade></td></tr><tr><td width='23' height='18' align='center' valign='top'></td><td width='1383' height='18' align='center' valign='top'></td></tr></table>
	  </td><td width='23'><img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628'><img src='images/content_26.jpg' width='628' height='47' alt=''></td><td colspan='4' width='148'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73'><img src='images/content_30.jpg' width='73' height='39' alt=''></td><td colspan='2' rowspan='2' width='48'><a href='01_01_02.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1'><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27'>
  <input type="image" src='images/content_32.jpg' width='49' height='39' alt='Save and goto Lessons page' onClick="return validate();" border='0'></a></td><td width='23'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23'>	<img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30'>	<img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46'>	<img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73'>	<img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10'>	<img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38'>	<img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27'>	<img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23'></td></tr></table></td></tr></table></ul></ul></ul>


<!-- Modal popup start from here  for Assignment-->
<div id="window_block2" style="display:none;">


  <div style="padding:40px;">
  
 
  <iframe id="modal" src="/LBCOM/lbcms/AssgnmtArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" width="100%" height="8000px" frameborder="0" scrolling="auto"></iframe>
  
  
  </div>
</div>
<div id="wrapper" align="center">
  
    <div id="content">
 <div id="plank">
                  <div id="imgt"><b>Click to see lesson</b></div>
                  <div id="imgp"><a href="#" rel="toggle[assignmentDiv]" ></a></div>
                </div>
<div id="assignmentDiv"></div>
</div>
</div>

 <!-- Modal popup upto here -->


 <!-- Modal popup start from here  for Assessment-->
<div id="window_block22" style="display:none;">


  <div style="padding:40px;">
  
 
  <iframe id="modalassmt" src="/LBCOM/lbcms/AssmtBuilder/AssmtArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" width="100%" height="8000px" frameborder="0" scrolling="auto"></iframe>
  
  
  </div>
</div>
<div id="wrapperassmt" align="center">
  
    <div id="content">
 <div id="plankassmt">
                  <div id="imgtassmt"><b>Click to see lesson</b></div>
                  <div id="imgpassmt"><a href="#" rel="toggle[assmtDiv]" ></a></div>
                </div>
<div id="assmtDiv"></div>
</div>
</div>

 <!-- Modal popup upto here -->

<script>
function fnCallback(data) {

  	
			$(document.thirdpage).find('#assgncount').html(data);
			
		}
		function fnCallbackAssmt(data) {

			$(document.thirdpage).find('#assmtcount').html(data);
			
		}
</script>
</form>
<%
		}
		catch(SQLException se)
		{
			System.out.println("The exception1 in 01_01_03.jsp is....."+se.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("The exception2 in 01_01_03.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 finally in 01_01_03.jsp is....."+se.getMessage());
			}
		}
%>

</body>
</html>