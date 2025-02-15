<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Ramanujam Kondaapally openWYSIWYG | Select Color</title>
</head>
<script language="JavaScript" type="text/javascript">

var qsParm = new Array();


/* ---------------------------------------------------------------------- *\
  Function    : retrieveWYSIWYG()
  Description : Retrieves the textarea ID for which the image will be inserted into.
\* ---------------------------------------------------------------------- */
function retrieveWYSIWYG() {
  var query = window.location.search.substring(1);
  var parms = query.split('&');
  for (var i=0; i<parms.length; i++) {
    var pos = parms[i].indexOf('=');
    if (pos > 0) {
       var key = parms[i].substring(0,pos);
       var val = parms[i].substring(pos+1);
       qsParm[key] = val;
    }
  }
}


/* ---------------------------------------------------------------------- *\
  Function    : insertImage()
  Description : Inserts image into the WYSIWYG.
\* ---------------------------------------------------------------------- */
function insertImage() {

/* added from here */

var sImage=document.getElementById('imageurl').value;
var aa1=sImage.lastIndexOf('\\');
aa1=aa1+1;

var aa=sImage.length;
//var aa=sImage.lastIndexOf('.');
var type=sImage.substring(aa1,aa);

var dImage, f;
//dImage = new ActiveXObject("Scripting.FileSystemObject");
//f=dImage.GetFile(""+sImage+"");
//var copyImage="/Tomcat5/webapps/LBCOM/coursedeveloper/CB_images/"+f.Name+"";
//f=dImage.CopyFile(""+sImage+"",""+copyImage+"");
//var cf=dImage.GetFile(""+copyImage+"");

var copyImage1="/LBCOM/pretest/images/"+type;
		
 /* upto here */


 /*var image = '<img src="' + document.getElementById('imageurl').value + '" alt="' + document.getElementById('alt').value + '" alignment="' + document.getElementById('alignment').value + '" border="' + document.getElementById('borderThickness').value + '" hspace="' + document.getElementById('horizontal').value + '" vspace="' + document.getElementById('vertical').value + '">';
 */
 var image = '<img src="'+copyImage1+'" alt="' + document.getElementById('alt').value + '" alignment="' + document.getElementById('alignment').value + '" border="' + document.getElementById('borderThickness').value + '" hspace="' + document.getElementById('horizontal').value + '" vspace="' + document.getElementById('vertical').value + '">';
  window.opener.insertHTML(image, qsParm['wysiwyg']);
	//window.close();
}

</script>
<body bgcolor="#EEEEEE" marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" onLoad="retrieveWYSIWYG();">
<form name="frm1" enctype="multipart/form-data" action="/LBCOM/cmgenerator.PretestSaveFile" method="POST" onsubmit="insertImage();">
<table border="0" cellpadding="0" cellspacing="0" style="padding: 10px;"><tr><td>

<span style="font-family: arial, verdana, helvetica; font-size: 11px; font-weight: bold;">Insert Image:</span>
<table width="380" border="0" cellpadding="0" cellspacing="0" style="background-color: #F7F7F7; border: 2px solid #FFFFFF; padding: 5px;">
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;" width="80">Image URL:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;" width="300"><input type="file" name="imageurl" id="imageurl" value=""  style="font-size: 16px; width: 100%;"></td>
 </tr>
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;">Alternate Text:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;"><input type="text" name="alt" id="alt" value=""  style="font-size: 10px; width: 100%;"></td>
 </tr>
</table>
	


<table width="380" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;"><tr><td>

<span style="font-family: arial, verdana, helvetica; font-size: 11px; font-weight: bold;">Layout:</span>
<table width="185" border="0" cellpadding="0" cellspacing="0" style="background-color: #F7F7F7; border: 2px solid #FFFFFF; padding: 5px;">
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;" width="100">Alignment:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;" width="85">
	<select name="alignment" id="alignment" style="font-family: arial, verdana, helvetica; font-size: 11px; width: 100%;">
	 <option value="">Not Set</option>
	 <option value="left">Left</option>
	 <option value="right">Right</option>
	 <option value="texttop">Texttop</option>
	 <option value="absmiddle">Absmiddle</option>
	 <option value="baseline">Baseline</option>
	 <option value="absbottom">Absbottom</option>
	 <option value="bottom">Bottom</option>
	 <option value="middle">Middle</option>
	 <option value="top">Top</option>
	</select>
	</td>
 </tr>
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;">Border Thickness:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;"><input type="text" name="borderThickness" id="borderThickness" value=""  style="font-size: 10px; width: 100%;"></td>
 </tr>
</table>	

</td>
<td width="10">&nbsp;</td>
<td>

<span style="font-family: arial, verdana, helvetica; font-size: 11px; font-weight: bold;">Spacing:</span>
<table width="185" border="0" cellpadding="0" cellspacing="0" style="background-color: #F7F7F7; border: 2px solid #FFFFFF; padding: 5px;">
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;" width="80">Horizontal:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;" width="105"><input type="text" name="horizontal" id="horizontal" value=""  style="font-size: 10px; width: 100%;"></td>
 </tr>
 <tr>
  <td style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;">Vertical:</td>
	<td style="padding-bottom: 2px; padding-top: 0px;"><input type="text" name="vertical" id="vertical" value=""  style="font-size: 10px; width: 100%;"></td>
 </tr>
</table>	

</td></tr></table>

<div align="right" style="padding-top: 5px;"><input type="submit" value="  Submit  " style="font-size: 12px;" >&nbsp;<input type="submit" value="  Cancel  " onClick="window.close();" style="font-size: 12px;" ></div>

</tr></td></table>
</form>
</body>
</html>
