try {
HTMLArea.loadPlugin("TableOperations");
HTMLArea.loadPlugin("SpellChecker");
HTMLArea.loadPlugin("FullPage");
HTMLArea.loadPlugin("CSS");
HTMLArea.loadPlugin("ContextMenu");
} catch (er) {
//	alert("Error ocurred. Close this window, and retry.");
	alert("Please retry.");
	window.close();
}

function toHA(ta,cols,rows) {

  var wd = "400px";
  var ht = "150px";

////  var ha = HA_ARR[ta];
	var ha;

  if (cols >= 75) {
  	wd = "750px"; 
	if (rows > 2) ht = "350px";
	else ht = "100px";
  } else {
	if (cols < 50) wd = "100px";
	if (rows < 3) { wd = "275px"; ht = "75px"; }
  }

  // create an editor for the textbox with id ta
  if (enable_HA && editor_ta_id == '') {
   if (ha == null || ha == undefined){
    HAMode = true;
  	editor = new HTMLArea(ta);
//////alert(editor);
	HA_ARR[ta] = editor;
//////alert(HA_ARR['l_q_ta0_id']);
   initEditor();
   customize(editor, wd, ht, menu_type);
   } else {
	editor = ha;
   }
   editor_ta_id = ta;
//////alert(ta);
  }
}

function noHA(ha_id, if_id, ta_id) {
  // transfer html data from iframe to textarea
    var e = document.getElementById(ha_id);
    var f = document.getElementById(if_id);
    //alert(e);
    //alert(f);
    var t = document.getElementById(ta_id);
    t.value = HTMLArea.getHTML(this._doc.body, false, this);
    //alert("val:" + t.value);

    t.style.display="block";

    e.parentNode.removeChild(e);
    e = null;
    editor_ta_id = '';
}

function initEditor() {

  // register the FullPage plugin
//  editor.registerPlugin(FullPage);

//alert("here");

  // register the SpellChecker plugin
  editor.registerPlugin(TableOperations);

  // register the SpellChecker plugin
  editor.registerPlugin(SpellChecker);

  // register the CSS plugin
  editor.registerPlugin(CSS, {
    combos : [
      { label: "Syntax:",
                   // menu text       // CSS class
        options: { "None"           : "",
                   "Code" : "code",
                   "String" : "string",
                   "Comment" : "comment",
                   "Variable name" : "variable-name",
                   "Type" : "type",
                   "Reference" : "reference",
                   "Preprocessor" : "preprocessor",
                   "Keyword" : "keyword",
                   "Function name" : "function-name",
                   "Html tag" : "html-tag",
                   "Html italic" : "html-helper-italic",
                   "Warning" : "warning",
                   "Html bold" : "html-helper-bold"
                 },
        context: "pre"
      },
      { label: "Info:",
        options: { "None"           : "",
                   "Quote"          : "quote",
                   "Highlight"      : "highlight",
                   "Deprecated"     : "deprecated"
                 }
      }
    ]
  });

  // add a contextual menu
  editor.registerPlugin("ContextMenu");

  // load the stylesheet used by our CSS plugin configuration
  editor.config.pageStyle = "@import url(custom.css);";

  setTimeout(function() {
    editor.generate();
  }, 500);

  return editor;
}

function insertHTML() {
  var html = prompt("Enter some HTML code here");
  if (html) {
    editor.insertHTML(html);
  }
}
function highlight() {
  editor.surroundHTML('<span style="background-color: yellow">', '</span>');
}

