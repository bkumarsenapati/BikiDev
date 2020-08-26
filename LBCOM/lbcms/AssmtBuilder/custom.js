/*
var menu = new Array();
menu['font'] = new Array("fontname", "space", 
	"fontsize", "space", "formatblock");
menu['font_face'] = new Array("bold", "italic", "underline", "strikethrough");
menu['sup_sub'] = new Array("subscript", "superscript");
menu['color'] = new Array("forecolor", "hilitecolor");
menu['justify'] = new Array("justifyleft", "justifycenter", 
	"justifyright", "justifyfull");
menu['indent'] = new Array("insertorderedlist", "insertunorderedlist");
menu['list'] = new Array("outdent", "indent");
menu['general'] = new Array(menu['font'], "space", menu['font_face'],
	"separator", menu['color']);

var menu_all = new Array(menu['color'], menu['list']);
m_color = '"forecolor", "hilitecolor"';
m_list = '"outdent", "indent"';
m_all = m_color + ',"separator",' + m_list;
var t1 = new Array("subscript", "superscript" ,
		  "inserthorizontalrule", "createlink", "insertimage");
*/
function customize(ed, wd, ht, m_t) {
	ed.config.width = wd;
	ed.config.height = ht;
//	ed.config.sizeIncludesToolbar = false;

	switch (m_t) {
	  case 0:
		ed.config.toolbar = [ 
        [ "fontname", "space",
          "fontsize", "space",
          "formatblock", "space",
          "bold", "italic", "underline", "strikethrough", "separator",
		  "htmlmode", "separator"],

        [ "justifyleft", "justifycenter", "justifyright", "justifyfull", "separator",
//          "lefttoright", "righttoleft", "separator",
          "insertorderedlist", "insertunorderedlist", "outdent", "indent", "separator",
          "subscript", "superscript", "separator",
          "forecolor", "hilitecolor", "separator",
          "inserthorizontalrule", "createlink", "insertimage",
		  "inserttable", "separator", "undo", "separator"
//          "popupeditor", "separator", "showhelp", "about" 
//          "copy", "cut", "paste",
//          "space", "undo", "redo" 
		]
		]; break;

	  case 1:
		ed.config.toolbar = [ 
        [ "formatblock", "fontsize", "space", "separator",
          "bold", "italic", "underline", "strikethrough", "separator",
          "subscript", "superscript", "separator", "undo", "separator" ],

        [ "justifyleft", "justifycenter", "justifyright", "justifyfull", "separator",
//          "lefttoright", "righttoleft", "separator",
          "insertorderedlist", "insertunorderedlist", "outdent", "indent", "separator",
          "forecolor", "hilitecolor", "separator",
          "inserthorizontalrule", "createlink", "insertimage",
		  "inserttable", "separator", "htmlmode", "separator"
//          "popupeditor", "separator", "showhelp", "about" 
//          "copy", "cut", "paste",
//          "space", "undo", "redo" 
		]
		]; break;

	  case 2:
	    ed.config.toolbar = [
        [ "subscript", "superscript", "separator",
          "createlink", "insertimage", "separator", 
		  "undo", "separator",
		  "htmlmode", "separator" //, "popupeditor"
		]
        ]; break;

	  default :
		ed.config.toolbar = [
        [ "fontname", "space",
          "fontsize", "space",
          "formatblock", "space",
          "bold", "italic", "underline", "strikethrough",
		  "separator", "htmlmode"],

        [ "justifyleft", "justifycenter", "justifyright", "justifyfull", "separator",
//          "lefttoright", "righttoleft", "separator",
          "insertorderedlist", "insertunorderedlist", "outdent", "indent", "separator",
          "subscript", "superscript", "separator",
          "forecolor", "hilitecolor", "separator",
          "inserthorizontalrule", "createlink", "insertimage",
		  "inserttable", "separator", "undo", "separator"
//		    "htmlmode", "separator"
//          "popupeditor", "separator", "showhelp", "about" 
//          "copy", "cut", "paste",
//          "space", "undo", "redo" 
		]
        ];
	}
ed.config.statusBar = false;
}
