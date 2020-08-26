//-----------------------------------------------------------------
	  var source_form_name = "qt_sel_id";
	  var action_url = "../../exam.AssLBCMSCreateQuestion";
	  var action_target = "debug";  //same as the last frame's name
	  var f_action_url = "f_form.cgi";
	  var f_action_target = "debug";  //same as the last frame's name
//-----------------------------------------------------------------

  URL = "";
  HA = "ha/";
  _editor_url = URL + HA;
  _editor_lang = "en";
  

  var HA_ARR = new Array();
  var arr_n = 0;
  var editor = null;
  var editor_ta_id = '';
  var enable_HA = true;
  var menu_type = 0;

  var HAMode = false;

document.write('<script src="' + URL + HA + 'htmlarea.js"><\/' + 'script>');

document.write('<script src="init.js"><\/' + 'script>');

document.write('<script src="custom.js"><\/' + 'script>');

//-----------------------------------------------------------------

function d_alert(s) {
    setTimeout('alert("'+s+'")', 2000);
}

QEdStatus = "Initiali~hsn";

function f_submit(i,sel) {
  if (sel.value == "") {
		alert("Select a question type first.");
  } else { 

 if (QEdStatus && confirm('The current editing job will be lost.')) {
 	QEdStatus = false;
 }

 if (!QEdStatus) {
  if(document.getElementById('r_sub_stat')!=null) {
	preserveStatus();
    var win = SymWin;
	if (win != null) win.close();
  }
  QEdStatus = true;
  document.forms[i].submit();
 }
 }
 return (false);
}

//-----------------------------------------------------------------

var	msg = new Array();

msg['default'] = '';
msg['common'] = 
	' A default template used. Extra text-boxes can be added at ' +
	' any stage of editing.' +
	' "Review" shows an early preview of the question. ' +
	' The answer(s) must be provided after a review. ' +
	' The button to submit' +
	' the question appears automatically, after review.';
msg['addText'] = 'Click to add a text paragraph box as and when required.' +
	' An unused (empty) text-box will be discarded automatically ' +
	' when the "Review" button is clicked.';
msg['uploadFile'] = 'Click to upload a file (image/audio/video).' +
	' If the "Title" field is left blank,'+
	' "Review" will remove the file upload box, and even if a file is ' +
	' already uploaded, the file will not be added as a part of the ' +
	' question.';
msg['symbols'] = 'Click to edit an expression involving mathematical' +
	' or other symbols. Cut and paste the edited expression ' +
	' to the question/option text area.';
msg['reset'] = 'Click to clear the question and option areas (for a new ' +
	'question). [For an existing question opened for re-editing, '+
	' it resets the text-boxes to the last saved status.]';
msg['text'] = 'Add the complete text paragraph (with the answer word ' +
	' in its place in the paragraph).';
msg['word'] = 'Add a word contained in the question text to be replced ' +
	' by blank spaces, and note it down as the answer.';
msg['addOptions'] = 'Click to add a text paragraph to the option area.' +
    ' An unused (empty) text-box will be discarded automatically ' +
	' when the "Review" button is clicked.';
msg['addPairs'] = 'Click to add a pair of option boxes. Only the minimum '+
	' of the left or right filled column items will be used.';
msg['hint'] = 'You may add a sample answer (or hint) in the text box ' +
	' provided below the question area to help evaluation.';
msg['review'] = 'Click for an early review of the question and the ' +
	' option area. "Review" discards empty question/option area boxes.' +
	' The "preview" becomes available only after submitting the question.';
msg['submit'] = 'Submit this question, and REFRESH the question/option ' +
	' form area.';
msg['submit1'] = 'Submit this question, but DO NOT REFRESH the ' +
	' question/option form area. [Useful for creating variations of a ' +
	' question (by slight modifications).]';

function help(m_t) {
	document.getElementById('r_help_id').innerHTML=msg[m_t];
}

	  var T = "##";
	  var F = "%%";

	  var uploadedFiles = "";
	  var fileNumber = 0;

//	  var s_fr = parent.frames[-1];
	  var t_fr = parent.frames[1];  //integrated
//	  var t_fr = parent.frames[3];	//standalone

	  var q_arr = new Array();
	  var o_arr = new Array();
	  var o1_arr = new Array();
	  var o2_arr = new Array();
	  
	  var q_f_arr = new Array();
	  var o_f_arr = new Array();
	  var o1_f_arr = new Array();
	  var o2_f_arr = new Array();
	  
	  var l_q_no = 0, l_o_no = 0, l_o1_no=0, l_o2_no=0;
	  var l_q_arr=-1, l_o_arr=-1;
	  var l_o1_arr=-1, l_o2_arr=-1;

	  var enum_type;
	  var enum_opt = 0;
	  var en = new Array();
	  en["arabic"] = new Array( "1","2","3","4","5",
	  							"6","7","8","9","10");
	  en["rm_n"] = new Array("i","ii","iii","iv","v",
	  								"vi","vii","viii","ix","x");
	  en["RM_N"] = new Array("I","II","III","IV","V",
	  								"VI","VII","VIII","IX","X");
	  en["roman"] = new Array("a","b","c","d","e","f","g","h","i","j",
	  								"k","l","m","n","o","p","q","r","s","t",
									"u","v","w","x","y","z");
	  en["ROMAN"] = new Array("A","B","C","D","E","F","G","H","I","J",
	  								"K","L","M","N","O","P","Q","R","S","T",
									"U","V","W","X","Y","Z");

	function review(n, a, b) {	// because of change in ordering.
								// not reqd for new qtypes
		switch (n) {
			case 0	:	write_review2(a,b); break;
			case 1	:	write_review1(a,b); break;
			case 2	:	write_review3(a,b); break;
			case 3	:	write_review5(a,b); break;
			case 4	:	write_review6(a,b); break;
			case 5	:	write_review7(a,b); break;
			case 6	:	write_review4(a,b); break;
		}
	}
//	---------------------------------
        function strltrim() {
            //Match spaces at beginning of text and replace with a null
            //string
            return this.replace(/^\s+/,'');
        }

        function strrtrim() {
            //Match spaces at end of text and replace with a null string
            return this.replace(/\s+$/,'');
        }
        function strtrim() {
              return this.replace(/^\s+/,'').replace(/\s+$/,'');
        }

        String.prototype.ltrim = strltrim;
        String.prototype.rtrim = strrtrim;
        String.prototype.trim = strtrim;

//	---------------------------------

	function init_temp(flag, type) {
		INIT_TEMP = (flag == 1)?true:false;
		INIT_TYPE = type;

		switch (type) {	// old numbering; change here requires correction
						// in all q_*.js (e.g., q_1, o_1, initBox1 to q_0,...)
			case '1':	// multiple response
			case '2':	// multiple choice
			case '3':	// multiple boolean
			case '4':	// short/long
			case '5':	// fill-in-the-blank
			case '6':	// matching
			case '7':	// ordering
			default :	break;
		}

	}

	function initBox(q_t, a, b, c, d, e) {
		eval("initBox"+q_t)(a,b,c,d, e);
	}

	  function hs_submit(i, n) {
			if((qid!="new")||(QType =="51"))
				i=1;
			var id = (i == 0)?'r_b_refresh_id':'r_b_continue_id';
			var v= 'visible';
			v = (n == 0 && QType < 50)?'hidden':'visible';
			document.getElementById(id).style.visibility=v;
	  }

	  function toggle(str) {
		var id, s;
		switch (str) {
		  case 'l_q_arr'	: l_q_arr = l_q_arr*(-1); s=l_q_arr; 
				document.l_qo_form.q_enum_chk.checked = ((s>0)?true:false);
		  		break;
		  case 'l_o_arr'	: l_o_arr = l_o_arr*(-1); s=l_o_arr;
				document.l_qo_form.o_enum_chk.checked = ((s>0)?true:false);
		}
//		return ((s > 0) ? "checked" : " ");
	  }
	  
		function unhide() {
			hide();
			document.getElementById('topic').style.visibility = 'visible';
			document.getElementById('subtopic').style.visibility = 'visible';
		}

		function hide() {
			document.getElementById('topic').style.visibility = 'hidden';
			document.getElementById('subtopic').style.visibility = 'hidden';
		}

      function incrementCurrent(qo) {
		switch (qo) {
			case "l_n_q_id"		: l_q_no = l_q_no + 1; break;
			case "l_n_o_id"		: l_o_no = l_o_no + 1; break;
			case "l_n_o1_id"	: l_o1_no = l_o1_no + 1; break;
			case "l_n_o2_id"	: l_o2_no = l_o2_no + 1; 
		}
      }

	  function get_enum_type(sel) {
		var e_t;
		e_t = sel.options[sel.selectedIndex].value;
//		enum_type = e_t.options[e_t.selectedIndex].value;
	  }

      function getCurrentNumber(qo) {
		var i;
		switch (qo) {
			case "l_n_q_id"		: i=l_q_no; break;
			case "l_n_o_id"		: i=l_o_no; break;
			case "l_n_o1_id"	: i=l_o1_no; break;
			case "l_n_o2_id"	: i=l_o2_no;
		}
		return(i);
      }

// t, s, and f are just passed to initBox!
      function addToSpan(v_id, t, s, str){
	    var n = 0;
	    var e;
	    var qo;
		switch (v_id) {
			case "l_q_area_id"	: qo = "l_n_q_id"; break;
			case "l_o_area_id"	: qo = "l_n_o_id"; break;
			case "l_o1_area_id"	: qo = "l_n_o1_id"; break;
			case "l_o2_area_id"	: qo = "l_n_o2_id"; break;
			default				: qo = "";
		}

		if ( qo != "") n = getCurrentNumber(qo);
//		var i = v_id + n;

/*
		if (n == 0) {
			e = document.getElementById(v_id);
			e.appendChild(document.createElement("br"));
		}
*/
		initBox(INIT_TYPE, v_id, n, t, s, str);	// for question type 1!

	  if (QType < 50)
		document.getElementById("b_review").style.visibility="visible";
        incrementCurrent(qo);
//		return(i);
      }
	
	function enum_str(t, ev, k) {
		var s = "";
		var m = en[t].length;

		if (ev == 1) {
		  switch (t) {
		  	case "none"		: 	break;
			case "bullet"	: 	s = "o"; break;
			default			:	s = ((k < m)?en[t][k]:en[t][m]) + ".";
		  }
		}
		return(s);
	}

	function makeNewForm(v_id, v_name, method, v_action, flag) {
		var f = document.createElement("form");
		f.setAttribute("id", v_id);
		f.setAttribute("name", v_name);
		f.setAttribute("method", method);
		f.setAttribute("action", v_action);
		if (flag == 1)
			f.setAttribute("enctype", "multipart/form-data");
		return f;
	}
	
	function addCheckBox(sid, v_id, v_name, type, val) {
	
	}
	
	function addRadioButton(sid, v_id, v_name, type, val) {
	
	}
	
	function chgFocus(t) {
		var e;
		e = document.getElementById(t);
//		switch (t) {
//			case 'l_q_l_area_id':
//				e.style.color = '#aa0000';
//				document.getElementById('l_q_r_area_id').style.color='#00aa00';
//				break;
//			case 'l_q_r_area_id':
//				e.style.color = '#aa0000';
//				document.getElementById('l_q_l_area_id').style.color='#00aa00';
//				break;
//			case 'l_o_l_area_id':
//				e.style.color = '#aa0000';
//				document.getElementById('l_o_r_area_id').style.color='#00aa00';
//				break;
//			case 'l_o_r_area_id':
//				e.style.color = '#aa0000';
//				document.getElementById('l_o_l_area_id').style.color='#00aa00';
//				break;
//			default:
//				break;
//		}
//		e.focus();
	}
	
	function sel_handler(selector, t) {
		var v = selector.options[selector.selectedIndex].value;
		var i;
		switch (t) {
			case 'o':	i = 'l_o_area_id'; break;
			case 'q':	i = 'l_q_area_id'; break;
			default :	i = 'l_q_area_id';
		}

		switch (v) {
			case "text"		:	addToSpan(i, v, 'q_1'); break;
			case "file"	:	addToSpan(i, v, ''); break;
			default			:	break;
		}
		selector.options.selectedIndex = selector.options.defaultIndex;
	}

	function addTable(sid, tid, tname, w, b, hs, vs) {
		var e, t;

		t = document.createElement("table");
		t.setAttribute("id", tid);
		t.setAttribute("name", tname);
		t.setAttribute("border", b);
		t.setAttribute("width", w);
		t.setAttribute("hspace", hs);
		t.setAttribute("vspace", vs);

		tb = document.createElement("tbody");
		t.appendChild(tb);

		e=document.getElementById(sid);
		e.appendChild(t);

		return(tid);
	}

	function addRow(tid, rid, cls) {
		var t, tr;
		t = document.getElementById(tid);
		tr = document.createElement("tr");
		tr.setAttribute("id", rid);
		if(document.all)
			tr.setAttribute("className", cls);	
		else
			tr.setAttribute("class", cls);

		//tr.setAttribute("class", cls);
		t.tBodies[0].appendChild(tr);

		return(rid);
	}

	function addCell(rid, al, nd, w, csp) {
		var td;
		tr = document.getElementById(rid);
		td = document.createElement("td");
		td.setAttribute("align", al);
		td.setAttribute("width", w);
		td.setAttribute("colSpan", csp);
		td.appendChild(nd);
		tr.appendChild(td);

		return(rid);
	}

	function addBlankCell(rid, al, w) {
		var td;
		tr = document.getElementById(rid);
		td = document.createElement("td");
		td.setAttribute("align", al);
		td.setAttribute("width", w);
//		td.appendChild(document.createTextNode(""));
		tr.appendChild(td);

		return(rid);
	}

	function addSelectElem(sid, v_id, v_name, n, optarr, valarr, xtra) {
//	function createSelectElem(v_id, v_name, n, optarr, valarr, xtra) {
		var e = document.createElement("select");
		var i;
		e.setAttribute("id", v_id);
		e.setAttribute("name", v_name);

		for (i=0; i<n; i++) {
			oe = document.createElement("option");
			oe.setAttribute("value", valarr[i]);
			oe.appendChild(document.createTextNode(optarr[i]));
		    e.appendChild(oe);
		}
		document.getElementById(sid).appendChild(e);
		return(v_id);
	}

	function fileUploadStatus(fid) {
		if (uploadedFiles.indexOf(fid) >= 0)
			alert("File uploaded.");
		else
			alert("File not uploaded.");
	}

	function file_upload(frm, fid, stid, fNo) {
		var u, urls;
		var e = document.getElementById('r_fsub_stat');
		var f = document.getElementById(fid);

		u = e.childNodes[0].elements[5].value; //depends on elem position
		e.childNodes[0].elements[4].value = u;

		if (uploadedFiles.indexOf(fid) >= 0 &&
			!confirm("The existing file will be overwritten.")) {
			return false;
		}
		
		urls="<!-- uploaded_file -->" + fNo +
		"<a href=\"file://" + u + "\">" + u + "</a>";
		e.childNodes[0].elements[2].value = urls;
		
		document.getElementById(frm).submit();

//		f.innerHTML += urls;

		if (uploadedFiles.indexOf(fid) < 0) 
			uploadedFiles += fid + " ";
//alert(uploadedFiles);

		document.getElementById(stid).style.visibility="hidden";
		hs_submit(0,0);
		hs_submit(1,0);
		return false;
	}

	function vFileUpload(vid,fid,stid, fNo) {
		if (document.getElementById(fid).value == "") {
			alert("A \"title\" is mandatory for file upload.");
		} else if (
			(uploadedFiles.indexOf(fid) >= 0) && 
			confirm("Do you want to replace the previously uploaded file?")
		  ) {
			fileUpload(vid, fid, stid, fNo);
		} else {
			fileUpload(vid, fid, stid, fNo);
		}
//		return(false);
	}

	function fileUpload(vid,fid,stid,fNo) {
	  var e = parent.frames[0].document.getElementById('r_fsub_stat');
	  var frm = new RegExp('<form.*form>','');
	  var eh = e.innerHTML.replace(frm, '');
	  var enc = (document.all)?"encoding":"enctype"; // for IE, use encoding
//    var str=
	  e.innerHTML=
	    "<form id='file_upload_id' name='f_upload' method='post' action='" +
		f_action_url + "' target='" + f_action_target + "' " +
		enc + "='multipart/form-data'>" + fNo +
		"<input type='hidden' id='qf_id' name='qfid' " +
		" value='" + document.getElementById('q_id').value + "'>" +
		"<input type='hidden' id='t_file_id' name='t_file' " +
		" value='" + fid + "'>" +
		"<input type='hidden' id='dummy_id' name='dummy'>" + // added to
			// fix prob of this child node getting overwritten somewhere!
		"<input type='hidden' id='tf_title_id' name='tf_title' " +
		" value='" + document.getElementById(fid).value + "'>" +
		"<input type='hidden' id='t_url_id' name='t_url'>" +
		"<input type='file' id='t_nm_id' name='t_nm'>" + 
		"<input type='button' value='Upload' " + 
		" onClick='if (document.getElementById(\"t_nm_id\").value == \"\"){" +
		" alert(\"No file selected.\"); return(false); } else {" +
		" file_upload(\"file_upload_id\",\""+
		fid+"\",\""+ stid+"\", \"" + fNo + "\");" +
//		" document.getElementById(\"file_upload_id\").submit();" +
//		" alert(\"" + document.getElementById('t_nm_id').name + "\");" +
		" }'>" +
		"</form>" + eh;
	}

	function addInputElem(sid, v_id, v_name, type, val, xtra) {
		var e = document.getElementById(sid);
		var inputElem, is, c1, c2, c3, c4, fid, stid, fNo,br;

		fid = "f_"+v_id;
		stid = "s_"+v_id;

		switch (type) {
		  case "file"	:
			inputElem = document.createElement("span");
			inputElem.setAttribute("id", v_id);
			if(document.all)
				inputElem.setAttribute("className", "f_left");	
			else
				inputElem.setAttribute("class", "f_left");

			//inputElem.setAttribute("class", "f_left");
			e.appendChild(inputElem);
//			 br = document.createElement("br");
//			 e.appendChild(br);

		
			inputElem.appendChild(document.createTextNode("Title:"));

			fNo = "[" + (++fileNumber) + "]";

			c1 = document.createElement("input");
			c1.setAttribute("id", fid);
			c1.setAttribute("type", "text");
			c1.setAttribute("size", "20");
			c1.setAttribute("value", val);

		if (document.all) {
		  c1.setAttribute('onfocus',function k(){hs_submit(0,0); hs_submit(1,0);});
		} else {
		  c1.setAttribute("onFocus",
			"hs_submit(0,0); hs_submit(1,0);");
		}

			c2 = document.createElement("input");
			c2.setAttribute("type", "button");
			c2.setAttribute("value", "Select File");
			if (document.all) {
		         c2.setAttribute('onclick',function k(){vFileUpload(v_id,fid,stid,fNo);});
		    } else 
		     c2.setAttribute("onClick", "vFileUpload('"+v_id+"','"+fid+"','"+stid+"','"+fNo+"')");
			c3 = document.createElement("input");
			c3.setAttribute("id", stid);
			c3.setAttribute("type", "button");
			c3.setAttribute("value", "X");
			if (document.all) {
		         c3.setAttribute('onclick',function k(){fileUploadStatus(fid, stid);});
		    } else
			c3.setAttribute("onClick",  "fileUploadStatus('"+fid+"', '"+stid+"')");

			if (val != "") { //for re-edit
				c3.style.visibility = "hidden"; 
				uploadedFiles += fid + " ";
			}
			
			c4 = document.createElement("span");
			c4.appendChild(document.createTextNode(fNo));
//			c4.style.visibility="hidden";

			inputElem.appendChild(c1);
			inputElem.appendChild(c2);
			inputElem.appendChild(c3);
			inputElem.appendChild(c4);

			c1.focus();

			break;
		  default		:
		
			if (document.all && type == "radio") {
// this is a strange fix for IE, needs to be tested
				inputElem=document.createElement("<input id=" + v_id +
					" name=" + v_name + " type=" + type + ">");
				e.insertBefore(inputElem);
			} else {
				inputElem = document.createElement("input");
				inputElem.setAttribute("id", v_id);
				inputElem.setAttribute("name", v_name);
				inputElem.setAttribute("type", type);

	if (type.toLowerCase() == 'text')
		if (document.all) {
		  inputElem.onFocus = 'function (){hs_submit(0,0); hs_submit(1,0);}';
		} else {
		  inputElem.setAttribute("onFocus",
			"hs_submit(0,0); hs_submit(1,0);");
		}

				e.appendChild(inputElem);
			}
			inputElem.setAttribute("value", val);
			inputElem.focus();
		}

		return(v_id);
	}

	function addL(sid, l_id, l_cl, enm, t) {
		var e, l;
		if (enm == "ol") 
			l = document.createElement("ol");
		else
			l = document.createElement("ul");
		l.setAttribute("id", l_id);
		if(document.all)
			l.setAttribute("className", l_cl);	
		else
			l.setAttribute("class", l_cl);

		//l.setAttribute("class", l_cl);
		l.setAttribute("type", t);

		e = document.getElementById(sid);
		e.appendChild(l);

		return(l_id);
	}

	function addLI(sid, eid) {
		document.getElementById(lid, document.getElementById(eid));
	}

	function set_m_t(sid) {
	  if (QType > 50) {
			menu_type = 1;
	  } else {
		switch (sid) {
			case "l_q_area_id"	: menu_type = 1; break;
			case "l_o_area_id"	: menu_type = 2; break;
			case "l_o1_area_id"	: menu_type = 2; break;
			case "l_o2_area_id"	: menu_type = 2; break;
			case "l_h_area_id"	: menu_type = 2; break;
			case "l_c_area_id"	: menu_type = 2; break;
			case "l_i_area_id"	: menu_type = 2;
		}
	  }
	}

	function show_kill(id1, id2) {
		document.getElementById(id1).style.visibility="visible";
		var e = document.getElementById(id2);
		e.parentNode.removeChild(e);
	}

	function insertIframe(p_id, v_id) {
		var f_id = 'if_' + v_id;
		var d_id = 'if_d_' + v_id;
		var p = document.getElementById(p_id);
		var e = document.getElementById(v_id);
		var f = document.createElement("iframe");
		f.style.width = "400px";
		f.style.height = "75px";
		p.insertBefore(f,e);
		f.setAttribute("id", f_id);
//		f.setAttribute("z-index", 2);
		f.setAttribute("name", "fid");
		f.designMode="On";
		f.setAttribute("onMouseOut", "show_kill('"+v_id+"', '"+f_id+"');")
//		f.contentWindow.document.onmouseout = "show_kill('"+v_id+"', '"+f_id+"')";
//		document.getElementById(f_id).contentDocument.body.innerHTML= e.value;
		f.document.body.innerHTML = e.value;
//		e.style.visibility = "hidden";
	}
	function replaceAll( str, from, to ) {
    var idx = str.indexOf( from );
    while ( idx > -1 ) {
        str = str.replace( from, to ); 
        idx = str.indexOf( from );
    }
    return str;
	}
		
	function addTextArea(sid, v_id, v_name, v_cls, cols, rows, wrap, xtra,
						 str) {
		str=replaceAll(str,"&quot;","\"");
		var tmp =document.getElementById("tparam")
		tmp.innerHTML=str;
		str=tmp.innerHTML;
		var e;
		var m_t = 0;
		var ta = document.createElement("textarea");
		ta.setAttribute("id", v_id);
		ta.setAttribute("name", v_name);
		if(document.all)
			ta.setAttribute("className", v_cls);	
		else
			ta.setAttribute("class", v_cls);
		//ta.setAttribute("class", v_cls);
		ta.setAttribute("cols", cols);
		ta.setAttribute("rows", rows);
//		ta.setAttribute("wrap", wrap);
		ta.setAttribute("wrap", "virtual");
		if ((str != undefined)&&(!document.all)){
			ta.appendChild(document.createTextNode(str));
		}
		e = document.getElementById(sid);
		e.appendChild(ta);
		if ((str != undefined)&&(document.all)){
			ta.setAttribute("value",str);
		}
		e = document.getElementById(sid);
		e.appendChild(ta);

		

		if (document.all) {
		  ta.setAttribute("onclick",
		    function() {
			 if(event.shiftKey) {
				 insertIframe("'"+sid+"'", "'"+v_id+"'");}
			 }
		  );
		  ta.setAttribute("ondblclick",
			function (){
				set_m_t(sid);toHA('"'+ v_id + '"',cols,rows);
				hs_submit(0,0); hs_submit(1,0);
			}
		  );
		}else {
		  ta.setAttribute("onClick",
		    "if(event.shiftKey) { \
			 insertIframe('"+sid+"', '"+v_id+"');} \
			 else if (event.ctrlKey) alert('ctrl');");
		  ta.setAttribute("onDblclick",
			"set_m_t(\""+sid+"\");toHA(\""+ v_id +
			"\",cols,rows);hs_submit(0,0); hs_submit(1,0);");
	  }
		return(v_id);
	}

	function addText(sid, v_id, v_name, v_cls,str,size) {
		var tmp =document.getElementById("tparam")
		tmp.innerHTML=str;
		//str=tmp.innerHTML;
		var e;
		var m_t = 0;
		var ta = document.createElement("input");
		ta.setAttribute("id", v_id);
		ta.setAttribute("name", v_name);
		ta.setAttribute("size",size);
		

		if ((str != undefined)&&(!document.all)){
			//alert('in 1st if ');
			ta.appendChild(document.createTextNode(str));
		}
		e = document.getElementById(sid);
		e.appendChild(ta);
		ta.setAttribute("value",str);
		if ((str != undefined)&&(document.all)){
			//alert('in 2nd if ');
			ta.setAttribute("value",str);
		}
		e = document.getElementById(sid);
		e.appendChild(ta);

		return(v_id);
	}
	
	function addSelect(sid, v_id, v_name, v_cls, optionnames, optionvalues, str,defaultval) {
		var tmp =document.getElementById("tparam")
		tmp.innerHTML=str;
		//str=tmp.innerHTML;
		var e;
		var m_t = 0;
		var ta = document.createElement("select");
		ta.setAttribute("id", v_id);
		ta.setAttribute("name", v_name);
		if(document.all)
			ta.setAttribute("className", v_cls);	
		else
			ta.setAttribute("class", v_cls);
	    for(var i=0;i<optionnames.length;i++){
			opt=document.createElement("option");
			txt=document.createTextNode(optionnames[i]);
			opt.appendChild(txt);
			opt.setAttribute("value",optionvalues[i]);
//			alert('optionnames is '+optionvalues[i]+" and str is "+str);
			if(str!=undefined && str.trim()!="" && optionvalues[i]==str){
				opt.setAttribute("selected",true);
			}
			if((str==undefined || str.trim()=="") && optionvalues[i]==defaultval){
				opt.setAttribute("selected",true);
			}
			ta.appendChild(opt);
		}
		
		if ((str != undefined)&&(!document.all)){
//			alert('in second if ');
			ta.appendChild(document.createTextNode(str));
		
		}
		e = document.getElementById(sid);
		e.appendChild(ta);
	//	ta.setAttribute("selectedIndex",str);
		//ta.selectedIndex(
	//	if ((str != undefined)&&(document.all))
	//		ta.setAttribute("value",str);
	//	alert('st is '+str);
	//	ta.setAttribute("selectedIndex",str);
		e = document.getElementById(sid);
		e.appendChild(ta);

		

		/*if (document.all) {
		  ta.setAttribute("onclick",
		    function() {
			 if(event.shiftKey) {
				 insertIframe("'"+sid+"'", "'"+v_id+"'");}
			 }
		  );
		  ta.setAttribute("ondblclick",
			function (){
				set_m_t(sid);toHA('"'+ v_id + '"',cols,rows);
				hs_submit(0,0); hs_submit(1,0);
			}
		  );
		} else {
		  ta.setAttribute("onClick",
		    "if(event.shiftKey) { \
			 insertIframe('"+sid+"', '"+v_id+"');} \
			 else if (event.ctrlKey) alert('ctrl');");
		  ta.setAttribute("onDblclick",
			"set_m_t(\""+sid+"\");toHA(\""+ v_id +
			"\",cols,rows);hs_submit(0,0); hs_submit(1,0);");
//		ta.setAttribute("onBlur", "noHA();");
		}

//		e = document.getElementById(sid);
//		e.appendChild(ta);

//		if (xtra != 0) ta.focus();*/
	
		return(v_id);
	}

	function addnewform(fr, v_id, v_name, method, v_action, flag) {
		var f;
		
		if (fr.document.getElementById(v_id) == null) {
			f = fr.document.createElement("form");
		f.setAttribute("accept-charset", "ISO-8859-1");
		f.setAttribute("id", v_id);
		f.setAttribute("name", v_name);
		f.setAttribute("method", method);
		f.setAttribute("target", action_target);
		f.setAttribute("action", (v_action == "")?action_url:v_action);
		if (flag == 1)
			f.setAttribute(((document.all)?"encoding":"enctype"), 
				"multipart/form-data");

		var b = (document.all)?fr.document.body:fr.document;
		b.appendChild(f);
		}
	}

	function addhidden(fid) {
		var f = t_fr.document.getElementById(fid);
//		var s = s_fr.document.getElementById(source_form_name);
		var el;

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "class_id");
		el.setAttribute("name", "classid");
		f.appendChild(el);

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "course_id");
		el.setAttribute("name", "courseid");
		f.appendChild(el);
		
		// Added assmtId of Builder from here
		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "assmt_id");
		el.setAttribute("name", "assmtid");
		f.appendChild(el);

		// Upto here

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "topic_id");
		el.setAttribute("name", "topicid");
		f.appendChild(el);

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "subtopic_id");
		el.setAttribute("name", "subtopicid");
		f.appendChild(el);

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "qtype_id");
		el.setAttribute("name", "qtype");
		f.appendChild(el);

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "q_id");
		el.setAttribute("name", "qid");
		f.appendChild(el);

		el=t_fr.document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("id", "pathname_id");
		el.setAttribute("name", "pathname");
		f.appendChild(el);

		t_fr.document.getElementById('class_id').value=classid;
		t_fr.document.getElementById('course_id').value=courseid;
		
		// Added from here

		t_fr.document.getElementById('assmt_id').value=assmtid;
		alert(t_fr.document.getElementById('assmt_id').value);
		
		// Upto here


		t_fr.document.getElementById('topic_id').value=topicid;
		t_fr.document.getElementById('subtopic_id').value=subtopicid;
		t_fr.document.getElementById('qtype_id').value=qtype;
		t_fr.document.getElementById('q_id').value=qid;
		t_fr.document.getElementById('pathname_id').value=pathname;
	}

	function addtextarea(fr, fid, v_id, v_name, v_cls, cols, rows, wrap) {
		var ta = fr.document.createElement("textarea");
		ta.setAttribute("id", v_id);
		ta.setAttribute("name", v_name);
		if(document.all)
			ta.setAttribute("className", v_cls);	
		else
			ta.setAttribute("class", v_cls);

		//ta.setAttribute("class", v_cls);
		ta.setAttribute("cols", cols);
		ta.setAttribute("rows", rows);
		ta.setAttribute("wrap", wrap);

//		var b = (document.all)?fr.document.body.eval(fo):fr.document.eval(fo);
//		var b = fr.document.eval(fo);
		var b = fr.document.getElementById(fid);

		(document.all)?b.appendChild(ta):b.insertBefore(ta,b.firstChild);
	}

/*	function addSelect(fr,fid,v_id,v_name,v_cls,vals,dipVals){
		var ta=fr.document.createElement("select");
		ta.setAttribute("id",v_id);
		ta.setAttribute("name",v_name);
		if(document.all)
			ta.setAttribute("className", v_cls);	
		else
			ta.setAttribute("class", v_cls);


		var b = fr.document.getElementById(fid);

		(document.all)?b.appendChild(ta):b.insertBefore(ta,b.firstChild);
	}*/

function preserveStatus() { //from divs to frames
 var e;
 if ((e=parent.frames[0].document.getElementById('r_fsub_stat')) != null)
  parent.frames[1].document.body.innerHTML=e.innerHTML;
 if ((e=parent.frames[0].document.getElementById('r_sub_stat')) != null)
  parent.frames[2].document.body.innerHTML=e.innerHTML;
}

function reSet() { // from frames to divs.
  parent.frames[0].document.getElementById('r_fsub_stat').innerHTML=
	  parent.frames[1].document.body.innerHTML;
  parent.frames[0].document.getElementById('r_sub_stat').innerHTML=
	  parent.frames[2].document.body.innerHTML;
}

function refreshQEd(o) {
	if (o == 0) {
		if (SymWin != null) SymWin.close();
		setTimeout("window.self.location.reload(true)",500);
		
	}
}

function open_window(url, nm, pr){
	if (SymWin != null) {
	  SymWin.focus();
	} else {
	var property;
	if (pr == "") {
	  property =
		"dependent=yes,width=450,height=550,scrollbars=yes,left=600,top=275";
	}
	SymWin=window.open(url, nm, property);
	SymWin.focus();
	}
}

var SymWin = null;

function format(str) {
	var s = str;
	var sp = new RegExp(' ', 'g');
//	var q1 = new RegExp("'", 'g');
//	var q2 = new RegExp('"', 'g');
	var nl = new RegExp('\n', 'g');

	s = s.replace(sp, '&nbsp;');
	s = s.replace(nl, '<br>');
//	s = s.replace(q1, "\\'");
//	s = s.replace(q1, '&apos;');
//	s = s.replace(q2, '&quot;');
////	return(s);
	return(str);   // return as it is until tested with mysql.
}

function set_ans(type) {
	var ans = s_ans;
	var n;
	var id;

  if (s_ans != "") {
	switch (type) {
		case 0	:
		case 1	:
		case 2	:
				  n = ans.length;
				  for (var i=0; i<n; i++) {
					id = document.getElementById('k_cb_o'+i+'_id');
					if(id!=null)
					 id.checked = (ans.charAt(i)== '1')?true:false; 
					
				  }
				  break;
		case 3	:
				  break;
		case 4	:
		case 5	:
			  n = ans.length;
				  for (var i=0; i<n; i++) {
					id = document.getElementById('sel_'+i+'_id');
////				  	id.selectedIndex = ans.charAt(i);
					if(id!=null)
				  	id.selectedIndex = 
						en["roman"].join('').indexOf(ans.charAt(i));
				  }
				  break;
		case 6	:
	}
  }
}

function replaceAll(oldStr,findStr,repStr) {
  var srchNdx = 0;  // srchNdx will keep track of where in the whole line
                    // of oldStr are we searching.
  var newStr = "";  // newStr will hold the altered version of oldStr.
  while (oldStr.indexOf(findStr,srchNdx) != -1)  
                    // As long as there are strings to replace, this loop
                    // will run. 
  {
    newStr += oldStr.substring(srchNdx,oldStr.indexOf(findStr,srchNdx));
                    // Put it all the unaltered text from one findStr to
                    // the next findStr into newStr.
    newStr += repStr;
                    // Instead of putting the old string, put in the
                    // new string instead. 
    srchNdx = (oldStr.indexOf(findStr,srchNdx) + findStr.length);
                    // Now jump to the next chunk of text till the next findStr.           
  }
  newStr += oldStr.substring(srchNdx,oldStr.length);
                    // Put whatever's left into newStr.             
  return newStr;
}
