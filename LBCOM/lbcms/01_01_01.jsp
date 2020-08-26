<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String secTitle="",secContent="",secStatus="";
	String webTitle="",webUrl="";
	String strandDesc="",strndId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
%>
<%
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs10=null,rs11=null,rs3=null,rs4=null,rs5=null;
	Statement st=null,st1=null,st2=null,st10=null,st11=null,st3=null,st4=null,st5=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		

		rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>

<html>
<head>
<title><%=courseName%> Content Developer</title>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
function revealModal(divID)
{
    window.onscroll = function () { document.getElementById(divID).style.top = document.body.scrollTop; };
    document.getElementById(divID).style.display = "block";
    document.getElementById(divID).style.top = document.body.scrollTop;
}

function hideModal(divID)
{
    document.getElementById(divID).style.display = "none";
}
</script>
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
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/2wysiwyg.js"></script> --> 
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	
	replacequotes();
	//win.submit();
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
		
	show('divwwtmain');
	show('divwwt');
	show('rmv');
	
}

// Remove sections from here
function hide1(x)
{
		
	//document.getElementById(x).style.display='none';
	if(x=='rmv')
	{
		
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			alert(document.getElementById('chkwwt').value);
		document.getElementById('chkwwt').checked= true;
		document.getElementById('chkwwt').value = 'none';
		alert(document.getElementById('chkwwt').value);
		hide('chkwwt');
		hide('divwwtmain');
		hide('divwwt');
		hide('rmv');
		hide('wwttitleicon');
		hide('wwtrmv');
		hide('wwtclmn');
		hide('wwtsecimg');
				
		}
	}
	if(x=='rmvcq')
	{
		
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			alert(document.getElementById('chkcq').value);
			document.getElementById('chkcq').checked= true;
			document.getElementById('chkcq').value = 'none';
			alert(document.getElementById('chkcq').value);
			hide('chkcq');
			hide('rmvcrq');
			hide('cqmain');
			hide('divcq');
			hide('cqtitleicon');
			hide('cqrmv');
			hide('cqclmn');
			hide('cqsecimg');
		}
		
		
	}
	if(x=='rmvwml')
	{
		
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			document.getElementById('chkwm').checked= true;
		document.getElementById('chkwm').value = 'none';
		hide('chkwm');
		hide('divwmlmain');
		hide('divwml');
//		hide('divwmltext');
		hide('wmtitleicon');
		hide('wmrmv');
		hide('wmclmn');
		hide('wmsecimg');
		hide('strandid');
		}
						
	}
	
	
}

// Remove sections upto here


function showSec1(x)
{	
	document.getElementById('section1').style.display='';
	hide('seccontrol');
	show('sec2');
	show('sec1');
	
}
function showSec2(x)
{	
	document.getElementById('section2').style.display='';
	hide('sec2');
	show('sec3');
	hide('seccontrol');
	
}
function showSec3(x)
{	
	document.getElementById('section3').style.display='';
	hide('sec3');
	show('sec4');
	hide('seccontrol');
	hide('sec2');
	
}
function showSec4(x)
{	
	document.getElementById('section4').style.display='';
	hide('sec4');
	show('sec5');
	hide('seccontrol');
	hide('sec2');
	hide('sec3');
	
}
function showSec5(x)
{	
	document.getElementById('section5').style.display='';
	hide('sec5');
	show('sec6');
	hide('seccontrol');
	hide('sec2');
	hide('sec3');
	hide('sec4');
	
}
function hidesec(x)
{
		
	if(x=='rmvsec1')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
			document.getElementById('sect1').checked = true;
			document.getElementById('sect1').value = 'none';
			hide('section1');
			hide('sec2');
			hide('sectitleicon1');
			hide('secrmv1');
			hide('secimg1');
			show('seccontrol');
		}
		
	}
	if(x=='rmvsec2')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect2').value = 'none';
		
		hide('section2');
		hide('sectitleicon2');
			hide('secrmv2');
			hide('secimg2');
		show('sec3');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec3')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect3').value = 'none';
		hide('section3');
		hide('sectitleicon3');
			hide('secrmv3');
			hide('secimg3');
		show('sec4');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec4')
	{
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect4').value = 'none';
		hide('section4');
		hide('sectitleicon4');
			hide('secrmv4');
			hide('secimg4');
		show('sec5');
		hide('seccontrol');
		}
		
	}
	if(x=='rmvsec5')
	{
		
		if(confirm("Are you sure that you want to delete this section?")==true)
		{
		document.getElementById('sect5').value = 'none';
		hide('section5');
		hide('sectitleicon5');
			hide('secrmv5');
			hide('secimg5');
		show('sec6');
		hide('seccontrol');
		}
		
	}
	
}
function showWebSec1(x)
{	
	document.getElementById('websection1').style.display='';
	hide('secwebcontrol');
	show('secweb2');
	show('secweb3');
	
}
function showWebSec2(x)
{	
	document.getElementById('websection2').style.display='';
	hide('secweb2');
	show('secweb3');
	hide('secwebcontrol');
	
}
function showWebSec3(x)
{	
	document.getElementById('websection3').style.display='';
	hide('secweb3');
	show('secweb4');
	hide('secwebcontrol');
	hide('secweb2');
	
}
function showWebSec4(x)
{	
	document.getElementById('websection4').style.display='';
	hide('secweb4');
	show('secweb5');
	hide('secwebcontrol');
	hide('secweb2');
	hide('secweb3');
	
}
function showWebSec5(x)
{	
	document.getElementById('websection5').style.display='';
	hide('secweb5');
	show('secweb6');
	hide('secwebcontrol');
	hide('secweb2');
	hide('secweb3');
	hide('secweb4');
	
}
-->
</SCRIPT>

<!-- Script for Modal popup menu -->


<link type="text/css" href="styles/lbstyles/jquery.window.css" rel="stylesheet" />

<script type="text/javascript" src="js/jquery.min.js"></script>



<!-- Script for Window -->
<script type="text/javascript" src="js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript" src="js/jquery/window/jquery.window.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>



</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' onLoad="hide('divwwt');hide('divcq');hide('divwml');">

<!-- <form method="POST" name="firstpage" action="FirstPageContent.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>"> -->
<form method="POST" name="firstpage" action="FirstPageContent.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">

<%
		if(rs.next())
		{

			String lToday,cQuestions,matNeed,lt,cq,wm;
			String lttitle,cqtitle,wmtitle;
			lToday=rs.getString("what_i_learn_today");
			if(lToday==null)
			{
				lToday=" ";
			}
			cQuestions=rs.getString("critical_questions");
			if(cQuestions==null)
				cQuestions=" ";
			matNeed=rs.getString("materials_i_need");
			if(matNeed==null)
				matNeed=" ";

			lttitle=rs.getString("ltoday");
			cqtitle=rs.getString("cquestions");
			wmtitle=rs.getString("wmaterial");

			lt=rs.getString("ltodaystatus");
			cq=rs.getString("cquestionsstatus");
			wm=rs.getString("wmaterialstatus");


%>
<table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'>
  <div align="center">
    <center>
    <table id='Table_01' width='800' border='0' cellpadding='0' cellspacing='0' bordercolor="#111111">
	<tr>
		<td rowspan='14' width='1'><img src='images/content_01.jpg' width='1' alt=''></td>
		<td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
			<font size="4" face="Verdana">&nbsp;<b><font color="#FFFFFF"><%=courseName%></font></b></font>
		</td>
		<td colspan='2' rowspan='2' width='328' height='1'><img src='images/content_03.jpg' width='328' alt=''></td>
		<td colspan='3' rowspan='2' width='129' height='1'><img src='images/content_04.jpg' width='129' height='58' alt=''></td>
		<td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td>
		<td width='23' height='1'><img src='images/spacer.gif' width='1' height='20' alt=''></td>
	</tr>
	<tr><td colspan='2' rowspan='2' width='65' height='1' valign='top'>
        <!-- <a href="CourseUnits.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>"><img src='images/content_06.jpg' width='87' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>  -->
		<a href="CourseUnitLessons.jsp?&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>"><img src='images/content_06.jpg' width='87' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>
		
  <font face="Verdana" size="2">&nbsp;<b><%=unitName%>:</b>&nbsp;<%=lessonName%></font></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr>
  <tr><td colspan='12' width='776' align='left' valign='top' rowspan='8'>
    <table width='795' border='0' cellspacing='0' cellpadding='0' style="border-collapse: collapse" bordercolor="#111111">
<%
	  
		if(!lt.equals("none"))
			{
%>
	<tr>
	<div id="divwwtmain">
		
		<!-- 3 -->

		<%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='wwttitleicon'");
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
		<td width='8' height='25' id="wwtsecimg" align='center' rowspan="2" valign="top">
		<div id='wwttitleicon'>
		<a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=wwttitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>		
		</div>
		</td>
		
		 <td width='680' class='main' height='32' id="wwtclmn"><b>
        <font face="Verdana" size="2" color="#FF0000"><a onClick="show('divwwt')"><%=lttitle%><a></font></b>
		<!-- <input type="button" value="Edit" onClick="show('divwwt')">
		<input type="button" value="Hide" onClick="hide('divwwt')"> -->
		<input type="button"  id="wwtrmv" value="Remove" onClick="hide1('rmv')">
		

		<%
			if(lt.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkwwt" id="chkwwt"  value="hide" Title="Hide from Course Viewer" checked>
			<%

			}
			else
			{
			%>
				<input type="checkbox" name="chkwwt" id="chkwwt" value="hide" Title="Hide from Course Viewer">
			<%
			}
			%>

				
		
		</div>
		<!-- 1 -->
			<div id="divwwt">
				<input type="text" name="wwt" id="wwt" value="<%=lttitle%>" onClick="this.value='<%=lttitle%>';">
				
			</div>
		</td>
		
		</tr><tr>
       <!--  <td height='19' width='8'>&nbsp;</td> -->
        <td height='10' width='680'>
		<!-- 1 -->
         <div id="rmv">
		 <textarea name="learn_today" id="learn_today" rows="1" cols="82"><%=lToday%></textarea>

		 <!-- <script language="JavaScript">
			generate_wysiwyg('learn_today');
		 </script> -->
		 <hr color="#008080" width="700" size="1" align="left" noshade><BR></td>
		
		 </div>
		</td>
		
		</tr>

		<%
			
				 
		}
		else
			{
			%>
				<input type="hidden" name="chkwwt" id="chkwwt"  value="none">
			<%

			}
	  
		if(!cq.equals("none"))
			{
%>
	  <tr>
	  <div id='cqmain'>
	 
        
		<%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='cqtitleicon'");
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
		<td width='8' height='4' id="cqsecimg" align='center' rowspan="2" valign="top">
		 <div id='cqtitleicon'><a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=cqtitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
		
      <td width='1370' class='main' height='32'  id="cqclmn"><b>
      <font face="Verdana" size="2" color="#FF0000"><a onClick="show('divcq')"><%=cqtitle%></a></font></b>
	  
	 <!--  <input type="button" value="Edit" onClick="show('divcq')">
		<input type="button" value="Hide" onClick="hide('divcq')"> -->
		<input type="button" id="cqrmv" value="Remove" onClick="hide1('rmvcq')">
		<%
		  
			if(cq.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkcq" id="chkcq"  value="hide" Title="Hide from Course Viewer" checked>
		<%
			}
			else
			{%>
			
				<input type="checkbox" name="chkcq" id="chkcq" value="hide" Title="Hide from Course Viewer">
				<%
			}
			%>
			

		</div>
			<div id="divcq">
				<input type="text" name="crq" id="crq" value="<%=cqtitle%>" onClick="this.value='<%=cqtitle%>';">
				
			</div>
	  
	  </td></tr>

	  <tr>
        <!-- <td height='38' width='8'>&nbsp;</td> -->
        <td height='38' width='1370'>
		<div id="rmvcrq">
         <textarea rows="3" name="questions" id="questions" cols="82"><%=cQuestions%></textarea>
		 <!--  <script language="JavaScript">
			generate_wysiwyg('questions');
		 </script> -->
		 <hr noshade color="#008080" width="700" size="1" align="left"><BR>
		  </div>
		</td></tr>
<%
			}
		if(!wm.equals("none"))
			{
%>

		<tr>
		 <div id='divwmlmain'>
		
		<%
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='wmtitleicon'");
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
		<td width='8' height='4' id="wmsecimg" align='center' rowspan="2" valign="top">
		<div id='wmtitleicon'>        	  
		<a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=wmtitleicon" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" style="padding-top:50px;" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
        </td>
      <td class='main' height='32' width='1370'  id="wmclmn">
	 <b>
      <font face="Verdana" size="2" color="#FF0000"><a onClick="show('divwml')"><%=wmtitle%></a></font></b>
		
		<!-- <input type="button" value="Edit" onClick="show('divwml')">
		<input type="button" value="Hide" onClick="hide('divwml')"> -->
		<input type="button" id="wmrmv" value="Remove" onClick="hide1('rmvwml')">
		<%
			if(wm.equals("hide"))
			{
				
			%>
				<input type="checkbox" name="chkwm" id="chkwm"  value="hide" Title="Hide from Course Viewer" checked>
		<%
			}
			else
			{%>
			
				<input type="checkbox" name="chkwm" id="chkwm" value="hide" Title="Hide from Course Viewer">
				<%
			}
			%>
		
			<div id="divwml">
				<input type="text" name="wml" id="wml" value="<%=wmtitle%>" onClick="this.value='<%=wmtitle%>';">
				
			</div>

	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>
	 <!-- <a href="/LBCOM/lbcms/Common_Core/StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" target="_blank"><span style="padding-left:25px">Common Core</span></b></a> -->

	 <a href="javascript:createWindowWithBoundary();">Common Core</b></a>
	  </td></tr>

<%
	st4=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

System.out.println("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");

	  	  
	  rs4=st4.executeQuery("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs4.next())
		 {
			strndId=rs4.getString("standard_code");
			st5=con.createStatement();
			rs5=st5.executeQuery("select * from lbcms_dev_cc_standards where standard_type='common' and standard_code='"+strndId+"'");
			if(rs5.next())
			 {
				strandDesc=rs5.getString("standard_desc");
				strandDesc=strndId+"&nbsp;&nbsp;"+strandDesc;
				
			}
			rs5.close();
			st5.close();
			matNeed=matNeed+"<BR><BR>"+strandDesc;
			
		}
		 rs4.close();
		 st4.close();
		 
 %>
	  <tr>
		
		<!--  <td height='38' width='8'>&nbsp;</td> -->
        <td height='19' class='main_s' width='1370' >
			<div id='strandid'>
         <textarea rows="3" name="materials" id="materials" cols="82"><%=matNeed%></textarea>
		 </div>
		 <!--  <script language="JavaScript">
			generate_wysiwyg('materials');
		 </script> -->
		</td></tr><tr>
      <td height='18' width='64'>
      </td>
      <td height='18' width='697'>
      <hr color="#008080" width="700" size="1" align="left" noshade><BR>
	   </div>
	  </td>
	  
      </tr>
<%
			}
%>
	 


<!-- Added from here --->

<!-- 1 -->

<%
		
			int i=0;
			st2=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

			System.out.println("select * from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no<6 order by section_no");

			rs2=st2.executeQuery("select * from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no<6 order by section_no");
			while(rs2.next())
			{
				 i++;
				 secTitle=rs2.getString("section_title");
				 secContent=rs2.getString("section_content");
				 secStatus=rs2.getString("sectionstatus");
							
%>	
		<tr>
        
	  
	  <b>
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
		<div id='sectitleicon<%=i%>'><a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=i%>" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
		</td>
        <td height='19' class='main_s' width='1370' id="secrmv<%=i%>">
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="sect<%=i%>" id="sect<%=i%>" value="<%=secTitle%>" onClick="this.value='';"></font></b><input type="button" value="Remove" onClick="hidesec('rmvsec<%=i%>')">
	  <%
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
		 <tr><td><div id='sec<%=i+1%>'><font face='Arial' color='blue' title="Add Section Here"><span id='span94' style='cursor: hand;' onClick="showSec<%=i+1%>('sec<%=i+1%>')"> <b>+</b> </span></font></div></td></tr>
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
	 for(int k=i+1;k<=5;k++)
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
		<a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=k%>" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></a>
		</div>
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="sect<%=k%>" id="sect<%=k%>" value="Enter title here" onClick="this.value='';"></font></b><input type="button" value="Remove" onClick="hidesec('rmvsec<%=k%>')">
	  <input type="checkbox" name="secstatus<%=k%>" id="secstatus<%=k%>"  value="hide" Title="Hide from Course Viewer"><BR>
		 <textarea name="seca<%=k%>" id="seca<%=k%>" rows="1" cols="82">&nbsp;</textarea>
		 <tr><td><div id='sec<%=k+1%>'><span id='span94' style='cursor: hand;' onClick="showSec<%=k+1%>('sec<%=k+1%>')"><font face='Arial' color='blue' title="Add Section Here"> <b>+</b></span></font></div></td></tr>

		 </div>
		 <script type="text/javascript">
			  hide('sec<%=k+1%>');
		

	  </script>  
		 </td>
		 </tr>
<%

			}
			if(i==0)
			{
%>

		<!--   Main  --->
		 <tr><td><div id='seccontrol'><span id='span94' style='cursor: hand;' onClick="showSec1('section1')"><font face='Arial' color='blue' title="Add Section Here"> <b>+</b></span></font></div></td></tr>

		 <!-- Upto here --->
<%
			}
		}
		st.close();
		%>


<!-- Web Resourcrs Start from here-->
<tr>
      <td height='18' width='8'></td>
      <td class='main' height='18' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000">WEB RESOURCES :</font></b></td></tr>
<%
		
			int m=0;
			st3=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		
			rs3=st3.executeQuery("select * from lbcms_dev_lesson_web_resource where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slno");
			while(rs3.next())
			{
				 m++;
				 webTitle=rs3.getString("web_title");
				 webUrl=rs3.getString("web_url");
							System.out.println("webTitle....."+webTitle+"..."+m);
%>	
		<tr>
        
        <td height='19' class='main_s' width='1370'>
	  
	  <b>
	  <div id="websection<%=m%>">
	  <script type="text/javascript">
		 hide('websection<%=m%>');
		 
	  </script>  
	  
      <td height='19' class='main_s' width='1370' id="secwebtitlermv<%=m%>">
      
	  
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="secwebt<%=m%>" id="secwebt<%=m%>" value="<%=webTitle%>" onClick="this.value='';"></font></b> 
	  &nbsp;&nbsp;&nbsp;<font face="Verdana" size="2" color="#FF0000"><input type="text" name="secwebu<%=m%>" id="secwebu<%=m%>" value="<%=webUrl%>" onClick="this.value='';"></font></b>&nbsp;&nbsp;&nbsp;
		 
		 <div id='secweb<%=m+1%>'><span id='span94' style='cursor: hand;' onClick="showWebSec<%=m+1%>('secweb<%=m+1%>')"><font face='Arial' color='blue' title="Add Section Here"> <b>&nbsp;</b></span></font></div></td></tr>

		 </div>
		 <script type="text/javascript">
			  hide('secweb<%=m+1%>');
		

	  </script>  
		 </td>
		 </tr><BR>
<%		
		}
		  for(int n=m+1;n<=5;n++)
			{

%>			 
		
		
		<tr>
        
        <td height='19' class='main_s' width='1370'>
	  
	  <b>
	  <div id="websection<%=n%>">
	  <script type="text/javascript">
		 hide('websection<%=n%>');
		 
	  </script>  
	  
      <td height='19' class='main_s' width='1370' id="secwebtitlermv<%=n%>">
      
	  
      <font face="Verdana" size="2" color="#FF0000"><input type="text" name="secwebt<%=n%>" id="secwebt<%=n%>" value="Enter title here" onClick="this.value='';"></font></b> 
	  &nbsp;&nbsp;&nbsp;<font face="Verdana" size="2" color="#FF0000"><input type="text" name="secwebu<%=n%>" id="secwebu<%=n%>" value="Enter url here" onClick="this.value='';"></font></b>&nbsp;&nbsp;&nbsp;
		 
		 <div id='secweb<%=n+1%>'><span id='span94' style='cursor: hand;' onClick="showWebSec<%=n+1%>('secweb<%=n+1%>')"><font face='Arial' color='blue' title="Add Section Here"> <b>+</b></span></font></div></td></tr>

		 </div>
		 <script type="text/javascript">
			  hide('secweb<%=n+1%>');
		

	  </script>  
		 </td>
		 </tr>
<%

			}
			if(m==0)
			{
%>

		<!--   Main  --->
		 <tr><td><div id='secwebcontrol'><span id='span94' style='cursor: hand;' onClick="showWebSec1('websection1')"><font face='Arial' color='blue' title="Add Section Here"> <b>&nbsp;</b></span></font></div></td></tr>

		 <!-- Upto here --->
<%
			}
%>
<!-- Web Resourcrs Upto here -->


<%
		st1=con.createStatement();
		
		rs1=st1.executeQuery("select word,description from lbcms_dev_lesson_words where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>	  <BR><BR>
	  <tr>
      <td height='18' width='8'></td>
      <td class='main' height='18' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000">WORDS I NEED TO KNOW :</font></b></td></tr><tr>
        <td height='28' width='8'>&nbsp;</td>
         <td class='main_s' height='28' valign='top' width='1370'>
<%
		int i=1;
		
		if(rs1.first())
		{
			//rs1.last();
			do 
			{
%>
		        <input type="text" name="word<%=i%>" size="20" value="<%=rs1.getString("word")%>">&nbsp;
<%	
				if(i%4==0)
				{
%>	
					<p>
<%
				}
				i++;
			}while(rs1.next());	
		}

		while(i<=12)
		{
%>
			
			<input type="text" name="word<%=i%>" size="20">&nbsp;
<%
			if(i%4==0)
			{
%>
				<p>
<%
			}
			i++;
		}	
		st1.close();
%>
		</tr>
		<tr>
        <td height='1' width='64'>
        </td>
        <td height='1' width='697'>
        <hr color="#008080" width="700" size="1" align="left" noshade><BR></td></tr>
		</table></td>
		<td width='23'>
		<img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' ><img src='images/spacer.gif' width='1' height='30' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'>&nbsp;</td><td colspan='4' width='148' height='47'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='images/content_30.jpg' width='73' height='39' alt=''><td colspan='2' rowspan='2' width='48' height='39'>
      <a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>"><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><input type="image" src='images/content_32.jpg' width='49' height='39' alt='Save and move to the next page' border='0' onClick="return validate();"></td><td width='23' height='19'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table>
    </center>
  </div>
  </td></tr></table>

 <!-- Modal popup start from here -->
<div id="window_block2" style="display:none;">


  
  
  <!-- <iframe src="/LBCOM/lbcms/course_bundles/Testcourse/Lessons.html" width="100%" height="700px" frameborder="0" scrolling="auto"></iframe> -->
  <iframe id="modal" src="/LBCOM/lbcms/Common_Core/StandardsMapping.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>" width="100%" height="8000px" frameborder="0" scrolling="auto"></iframe>
  
  
  
  
</div>
<div id="wrapper" align="center">
  
    <div id="content">
 <div id="plank">
                  <div id="imgt">&nbsp;</div>
                  <div id="imgp"><a href="#" rel="toggle[assignmentDiv]" ></a></div>
                </div>
<div id="assignmentDiv"></div>
</div>
</div>

 <!-- Modal popup upto here -->
<%	
		
	
		
	}
		catch(Exception e)
		{
			System.out.println("The exception1 in 01_01_01.jsp is....."+e);
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
				System.out.println("The exception2 in 01_01_01.jsp is....."+se.getMessage());
			}

    }
%>
<script>
function fnCallback(data) {

			//$(document.firstpage).find("window_block2").hide(1); 
			//animatedcollapse.addDiv('assignmentDiv', 'hide=1');
			//animatedcollapse.addDiv('window_block2', 'hide=1');
			
			alert("Hi");
			//options.onClose(_this);
			$(document.firstpage).find('#strandid').html(data);
			document.getElementById('window_0').style.display = 'none';
			document.getElementById('window_1').style.display = 'none';
			
			/*
			document.getElementById('imgp').style.display='none';
			document.getElementById('window_block2').style.display='none';
			document.getElementById('assignmentDiv').style.display='none';
			
			var headerFuncPanel=null;
			headerFuncPanel.children(".closeImg").click(function(){close();});
			*/
			
		}
</script>
</form>
</body>
</html>