<html>

<head>
  <title>Insert Image</title>

<script type="text/javascript" src="popup.js"></script>

<script type="text/javascript">

window.resizeTo(500, 100);

function chk_title() {
	if (document.getElementById('f_alt').value == '' ) {
		alert("A title or caption is mandatory.");
		return false;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
var base_URL = "/schools/resource/im/";
//var base_URL = "http://216.83.97.131:9080/LBCOM/schools/resource/im/"
function Init() {
  __dlg_init();
  var param = window.dialogArguments;
  if (param) {
	  var raj= param.f_url;
	  if(raj.indexOf(".")!=-1)
	      document.getElementById("f_url").value =param["f_url"];
	  else 	
      document.getElementById("f_url").value = base_URL+param["f_url"];
      document.getElementById("f_alt").value = param["f_alt"];
      document.getElementById("f_border").value = param["f_border"];
      document.getElementById("f_align").value = param["f_align"];
      document.getElementById("f_vert").value = param["f_vert"];
      document.getElementById("f_horiz").value = param["f_horiz"];
      window.ipreview.location.replace(param.f_url);
  }
window.document.frm2.preview.disabled=true;
};

function onOK() {
  var required = {
    "f_url": "You must enter a URL." //,
//	"f_alt": "You must supply a title/caption."
  };
  for (var i in required) {
    var el = document.getElementById(i);
    if (!el.value) {
      alert(required[i]);
      el.focus();
      return false;
    }
  }
  // pass data back to the calling window
  var fields = ["f_url", "f_alt", "f_align", "f_border",
                "f_horiz", "f_vert"];
  var param = new Object();
  for (var i in fields) {
    var id = fields[i];
    var el = document.getElementById(id);
    param[id] = el.value;
  }
  __dlg_close(param);
  return false;
};

function onCancel() {
  __dlg_close(null);
  return false;
};

function onPreview() {
  var f_url = document.getElementById("f_url");
  var url = f_url.value;
  if (!url) {
    alert("You have to enter a URL first");
    f_url.focus();
    return false;
  }
  window.ipreview.location.replace(url);
  return false;
};
</script>

  <style type="text/css">
html, body {
  background: ButtonFace;
  color: ButtonText;
  font: 11px Tahoma,Verdana,sans-serif;
  margin: 0px;
  padding: 0px;
}
body { padding: 5px; }
table {
  font: 11px Tahoma,Verdana,sans-serif;
}
form p {
  margin-top: 5px;
  margin-bottom: 5px;
}
.fl { width: 9em; float: left; padding: 2px 5px; text-align: right; }
.fr { width: 6em; float: left; padding: 2px 5px; text-align: right; }
fieldset { padding: 0px 10px 5px 5px; }
select, input, button { font: 11px Tahoma,Verdana,sans-serif; }
button { width: 70px; }
.space { padding: 2px; }
.title { background: #ddf; color: #000; font-weight: bold; font-size: 120%; padding: 3px 10px; margin-bottom: 10px;
border-bottom: 1px solid black; letter-spacing: 2px;
}


form { padding: 0px; margin: 0px; }
</style>

</head>

<body onload="Init()">
  <div class="title" style="width: 600; height: 20">Insert Image</div>
  <iframe name="view" id="view" scrolling="no" src="upload.html"
   frameborder="0" style="border : 0px solid gray;" height="50" width="600" >
  
  </iframe>
<form name="frm2" action="" method="get">
<table border="0" width="100%" style="padding: 0px; margin: 0px">
  <tbody>

<!--
  <tr>
    <td style="width: 7em; text-align: right"></td>
    <td><input type="text" name="url" id="f_url" /> </td>
  </tr>
-->
  <tr>
    <input type="hidden" name="url" id="f_url" />
    <td style="text-align: left">Title/Caption:</td>
    <td><input type="text" size="40" name="alt" id="f_alt" /></td>
  </tr>
  </tbody>
</table>

<p />

<fieldset style="float: left; margin-left: 5px;">
<legend>Layout</legend>

<div class="space"></div>

<div class="fl">Alignment:</div>
<select size="1" name="align" id="f_align"
  TITLE="Positioning of this image">
  <option value=""                             >Not set</option>
  <option value="left"                         >Left</option>
  <option value="right"                        >Right</option>
  <option value="texttop"                      >Texttop</option>
  <option value="absmiddle"                    >Absmiddle</option>
  <option value="baseline" selected="1"        >Baseline</option>
  <option value="absbottom"                    >Absbottom</option>
  <option value="bottom"                       >Bottom</option>
  <option value="middle"                       >Middle</option>
  <option value="top"                          >Top</option>
</select>

<p />

<div class="fl">Border thickness:</div>
<input type="text" name="border" id="f_border" size="5"
TITLE="Leave empty for no border" />

<div class="space"></div>

</fieldset>

<fieldset style="float:right; margin-right: 5px;">
<legend>Spacing</legend>

<div class="space"></div>

<div class="fr">Horizontal:</div>
<input type="text" name="horiz" id="f_horiz" size="5"
TITLE="Horizontal padding" />

<p />

<div class="fr">Vertical:</div>
<input type="text" name="vert" id="f_vert" size="5"
TITLE="Vertical padding" />

<div class="space"></div>

</fieldset>
<br clear="all" />
<table width="100%" style="margin-bottom: 0.2em">
 <tr>
  <td valign="bottom">
     <button name="preview" id="preview" onclick="return onPreview();"
      TITLE="Preview the image in a new window">Preview</button>  
  </td>
  <td valign="bottom" style="text-align: right" rowspan="2">
    <button type="button" name="ok" onclick="return onOK();">OK</button><br>
    <button type="button" name="cancel" onclick="return onCancel();">Cancel</button>
  </td>
  </tr>
  <tr>
  <td>
        <iframe name="ipreview" id="ipreview" frameborder="0" style="border : 1px solid gray;" height="200" width="300" src=""></iframe>
  </td>
 </tr>
</table>
</form>
</body>
</html>