<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.util.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String folderName="",fileName="",url="",courseId="",categoryId="",teacherId="",schoolId="",sessid="",workId="",docName="";
	boolean flag=false;
%>
<%

String schoolPath = application.getInitParameter("schools_path");
	sessid=(String)session.getAttribute("sessid");
	
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");

	fileName=request.getParameter("filename");
	folderName=request.getParameter("foldername");
	categoryId=request.getParameter("cat");
	workId=request.getParameter("workid");
	docName=request.getParameter("docname");

	System.out.println("fileName..."+fileName);
	

	url=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;
	%>
<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>
<script language="javascript" src="../../validationscripts.js"></script> 
<script>
 function check(){

	var obj=window.document.desc;
	alert(obj.ftitle.value);
	alert(obj.filecontent.value);
}
	</script>
<!-- TinyMCE -->
<script type="text/javascript" src="/LBCOM/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		convert_urls : false,
		relative_urls : false,
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,youtube,advhrftp",

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
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft,youtube,advhrftp",
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
</HEAD>

<BODY>
<form name="desc" method="post" action="HTMLFileSub.jsp?workid=<%=workId%>&cat=<%=categoryId%>&docname=<%=docName%>&foldername=<%=folderName%>" onsubmit="return false();">


<%
	
	
	
			String disPath = url+"/"+fileName;

			String message="";

			System.out.println("	 disPath..."+disPath);
			
			File fwdMsgFile = new File(disPath);
			   if((fwdMsgFile.exists())&&(fwdMsgFile.isFile()))
			   {
						Reader fr = new FileReader(fwdMsgFile); 
						BufferedReader br = new BufferedReader(fr);
						String buff = br.readLine();
						while(buff!=null)
						{
							message = message + "\n" + buff;
							buff = br.readLine();
							
						}
			   
			   //message=message.replaceAll("http://oh.learnbeyond.net/LBCOM","http://oh.learnbeyond.net:8080/LBCOM");
			 
			  /*
			  RandomAccessFile XMLDataRead=null;
			  XMLDataRead=new RandomAccessFile(disPath,"rw");
			  XMLDataRead.writeBytes(message);
			  XMLDataRead.close();

			  */
			   }
						
	

			// Upto here

%>
<table>
<tr>
        <td height='19' width='8'>&nbsp;</td>
		<td height='19' width='8'>&nbsp;</td>
        <td height='19' width='1370'>
		
         <textarea rows="3" name="filecontent" id="filecontent" cols="82"><%=message%></textarea>
	
		 
		</td></tr><tr>
<tr>
<td height='19' width='8'>&nbsp;</td>
        <td height='19' width='1370'>
<td align="center"><input type="image"  src="../images/submit.gif" name="submit"></td></tr>
	  </table>

	  <input type="hidden" name="ftitle" value="<%=fileName%>">
	   <input type="hidden" name="fpath" value="<%=disPath%>">

</form>
</BODY>
</HTML>	