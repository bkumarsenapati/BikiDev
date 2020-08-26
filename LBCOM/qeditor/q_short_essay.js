//	---------------------------------
//	type 4: short/long answer	// qtype = 6 in selection list
	  var q_4_rows=3, o_4_rows=3, h_4_rows=2, c_4_rows=2, i_4_rows=2;
	  var q_4_cols=54, o_4_cols=50, h_4_cols=30, c_4_cols=30, i_4_cols=30;

	  var q_4_i = 1, o_4_i = 1, h_4_i = 1, c_4_i = 1, i_4_i = 1;
//	---------------------------------
	
if (navigator.appVersion.indexOf("Win")!=-1){
  if(document.all){
	q_4_cols=64; o_4_rows=4;}
  else{
	q_4_cols=50;
	o_4_cols=47
  }
}
var QType = 4;
var s_ans="";
var hint_str = "", fb_correct_str = "", fb_incorrect_str = "",diff_level_str="",estimated_time_str="",time_scale_str="";

//msg['default'] = '<b>>>>> Question type: Short/essay-type.</b><br>' +
msg['default'] = '<b>>>>> </b>' +
		msg['common'];

	var ta=null, ta_str="";

	function write_review4() {
	  if (HAMode) {alert("Please exit HTML editor."); return false;}
		var b, e, rq, ro, rdiv, rqdiv, rodiv, rqodiv, l, li, lid;
		var str, str1, ostr1, str2, t_l, t_l_t, t_p;
		var i =0, j = 0, k=0;
		var e_l = new Array();
		var e_l_v = new Array();

		var cbi, kcbi;

		var enm, et, t_enm, t, tnd, csp, value, ss;

		var show_buttons = 0;
			  hs_submit(0,0);
			  hs_submit(1,0);

		rqodiv = document.getElementById("r_qo_area_id");

		if (ta != null) {
			ta_str = ta.value;
		}

		while (rqodiv.hasChildNodes()) {
			rqodiv.removeChild(rqodiv.firstChild);
		}

		j = 0;
		for (i=0; i < l_q_no; i++) {
			e = document.getElementById(q_arr[i][1]);
			if (e == null) continue;
			if (q_arr[i][2].toLowerCase() == 'file') {
				value = e.childNodes[1].value;
			} else {
				value = e.value;
			}

			if (value == "") {
				e.parentNode.removeChild(e);
				continue;
			} else {
				e_l_v[j] = value;
				q_f_arr[j] = new Array(q_arr[i][0], q_arr[i][1],
					q_arr[i][2], q_arr[i][3]);
				j++;
				show_buttons=1;
			}
		}
		r_q_no = j - 1;

if (r_q_no < 0) { alert("Missing question body!"); return false; }

		var dl = (document.all)?t_fr.document.body:t_fr.document;
		while (dl.hasChildNodes()) {
			dl.removeChild(dl.firstChild);
		}
addnewform(t_fr, "qo_form_id", "qo_form", "post", action_url, "1");
addtextarea(t_fr,"qo_form_id","qo_ta_id","qo_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","a_ta_id","a_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","h_ta_id","h_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","c_ta_id","c_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","i_ta_id","i_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","d_ta_id","d_ta","hidden","80","20","virtual");// added by ramesh
addtextarea(t_fr,"qo_form_id","e_ta_id","e_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","s_ta_id","s_ta","hidden","80","20","virtual");

var out_str="\n@@BeginQBody:qtype=6";
out_str = out_str + ":qid=" + document.getElementById('q_id').value;

addTable("r_qo_area_id", "r_q_t_id", "r_q_t", "100%", "0", "", "");

	  if (show_buttons > 0) {
		var append;
		k = 0;
		t_enm = 0;
		for (i=0; i <= r_q_no; i++) {
			t_enm = t_enm+(q_f_arr[i][3] > 0)?1:0;
		}	// t_enm > 0 => at least one item enumerated

		for (i=0; i <= r_q_no; i++) {
			append = true;
			eid = q_f_arr[i][1];
			enm = q_f_arr[i][3];
			switch (q_f_arr[i][2]) {
			  case "file"	:
				str1 = "File: "+e_l_v[i];
				title = document.getElementById('f_'+eid).value;
                ostr1 = q_f_arr[i][1]+"||0||0||"+title;
				ss = F;
				if (uploadedFiles.indexOf(eid) >= 0) append=true;
				else append = false;
				break;
			  default		:
				str1 = e_l_v[i];
				ostr1 = str1;
				ss = T;
			}

		  if (append) {
			cbi = "cb_q"+ i + "_id";
			rid = "r_qr"+i+"_id";
// row1
addRow("r_q_t_id", rid, "r_qr_d");

//			t = document.l_qo_form.q_enum_type;
//			t = t.options[t.selectedIndex].value;

//			var estr = enum_str(t, enm, k);

			if (enm == 1) k++; else k=0;
				
			t_l = document.createElement("div");
			str1= replaceAll(str1,"\n","<br>");
			t_l.innerHTML=format(str1);

			if (t_enm == 0) csp = "1";
			else if (enm < 0) {
				csp = "2";
			} else {
				csp = "1";
//addCell(rid, "right", document.createTextNode(estr), "20", "1");
			}
		
//if (enm < 0)
//	out_str=out_str+ '\n%%' + str1;
//else
	out_str=out_str+ '\n'+ss+ss+ ostr1;

addCell(rid, "left", t_l, "", csp);

			if (enum_opt == 1) {
			addInputElem("r_qo_area_id", cbi, "cb_q"+i, "checkbox", "", "");
addCell(rid, "center", document.getElementById(cbi), "20", "1");

			document.getElementById(cbi).checked = 
				(enm == 1) ? true : false;	
			}
		  }
		}
out_str=out_str+"\n@@EndQBody";
	  }

		j = 0;
		for (i=0; i < l_o_no; i++) {
			e = document.getElementById(o_arr[i][1]);
			if (e == null) continue;
			if (o_arr[i][2].toLowerCase() == 'file') {
				value = e.childNodes[1].value;
			} else {
				value = (e.value == null || e.value == "")?" ":e.value;
			}

			if (value == "") {
				e.parentNode.removeChild(e);
				continue;
			} else {
				e_l_v[j] = value;
				o_f_arr[j] = new Array(o_arr[i][0], o_arr[i][1],
					o_arr[i][2], o_arr[i][3]);
				j++;
//				show_buttons=1;
			}
		}
		r_o_no = j - 1;

out_str=out_str+"\n@@BeginOBody";
		
addTable("r_qo_area_id", "r_o_t_id", "r_o_t", "100%", "0");

	  if (show_buttons > 0) {

		k = 0;
		t_enm = 0;
		for (i=0; i <= r_o_no; i++) {
			t_enm = t_enm+(o_f_arr[i][3] > 0)?1:0;
		}	// t_enm > 0 => at least one item enumerated

		for (i=0; i <= r_o_no; i++) {
			append = true;
			eid = o_f_arr[i][1];
			enm = o_f_arr[i][3];
			switch (o_f_arr[i][2]) {
			  case "file"	:
				str1 = "File: "+e_l_v[i];
				title = document.getElementById('f_'+eid).value;
                ostr1 = o_f_arr[i][1]+"||0||0||"+title;
				ss = F;
				if (uploadedFiles.indexOf(eid) >= 0) append=true;
				else append = false;
				break;
			  default		:
				str1 = e_l_v[i];
				ostr1 = str1;
				ss = T;
			}

		  if (append) {
			cbi = "cb_o"+ i + "_id";
			kcbi = "k_cb_o"+ i + "_id";
			rid = "r_or"+i+"_id";
addRow("r_o_t_id", rid, "r_or_d");

//			addInputElem("r_qo_area_id", kcbi, "kcb_o", "radio", "", "");
//addCell(rid, "center", document.getElementById(kcbi), "20", "1");

			t = document.l_qo_form.o_enum_type;
//			t = t.options[t.selectedIndex].value;
			t = "roman";

			var estr = enum_str(t, enm, k);
			if (enm == 1) k++; else k=0;
				
			t_l = document.createElement("div");
			str1= replaceAll(str1,"\n","<br>");
			t_l.innerHTML=format(str1);

			if (t_enm == 0) csp = "1";
			else if (enm < 0) {
				csp = "2";
			} else {
				csp = "1";
//addCell(rid, "right", document.createTextNode(estr), "20", "1");
			}
out_str=out_str+'\n'+ostr1;		
addCell(rid, "left", t_l, "", csp);

			if (enum_opt == 1) {
			addInputElem("r_qo_area_id", cbi, "cb_o"+i, "checkbox", "", "");
addCell(rid, "center", document.getElementById(cbi), "20", "1");
			document.getElementById(cbi).checked = 
				(enm == 1) ? true : false;	
			}
		  }
		}
	  }
out_str=out_str+"\n@@EndOBody";

var qota=t_fr.document.getElementById('qo_ta_id');
qota.value=out_str;

var cn = 1; if (document.all) cn = 0;


/****      added by Ramesh *****/
diff_level_str = document.getElementById('l_d_area_id').childNodes[cn].value;
var diff=document.getElementById('l_d_area_id').childNodes[cn].options[diff_level_str].text;


addRow("r_o_t_id", "r_d_id", "r_or_d");
t_l = document.createElement("span");

t_l.innerHTML = "<b>Difficulty:</b> " + diff;
addCell("r_d_id", "left", t_l, "", "3");

estimated_time_str = document.getElementById('l_e_area_id').childNodes[cn].value;
time_scale_str = document.getElementById('l_s_area_id').childNodes[cn].value;
var time=document.getElementById('l_s_area_id').childNodes[cn].options[time_scale_str].text;

addRow("r_o_t_id", "r_e_id", "r_or_d");
t_l = document.createElement("span");
//var diff_level_str1= replaceAll(hint_str,"\n","<br>");
t_l.innerHTML = "<b>Estimated Time:</b> " + estimated_time_str+"&nbsp;"+time;
addCell("r_e_id", "left", t_l, "", "3");
	
/****      added by Ramesh *****/


hint_str = document.getElementById('l_h_area_id').childNodes[cn].value;
addRow("r_o_t_id", "r_h_id", "r_or_d");
t_l = document.createElement("span");
var hint_str1= replaceAll(hint_str,"\n","<br>");
t_l.innerHTML = "<b>Hint:</b> " + format(hint_str1);
addCell("r_h_id", "left", t_l, "", "3");
	if (hint_str == "") hint_str = "<br>";
hint_str = "\n@@BeginHBody\n" + hint_str + "\n@@EndHBody";

fb_correct_str = document.getElementById('l_c_area_id').childNodes[cn].value;
addRow("r_o_t_id", "r_c_id", "r_or_d");
t_l = document.createElement("span");
var fb_correct_str1= replaceAll(fb_correct_str,"\n","<br>");
t_l.innerHTML = "<b>Feedback (&#8730;): </b>" + format(fb_correct_str1);
addCell("r_c_id", "left", t_l, "", "3");
	if (fb_correct_str == "") fb_correct_str = "<br>";
fb_correct_str = "\n@@BeginCBody\n" + fb_correct_str + "\n@@EndCBody";

fb_incorrect_str = document.getElementById('l_i_area_id').childNodes[cn].value;
addRow("r_o_t_id", "r_i_id", "r_or_d");
t_l = document.createElement("span");
var fb_incorrect_str1= replaceAll(fb_incorrect_str,"\n","<br>");
t_l.innerHTML = "<b>Feedback (X): </b>" + format(fb_incorrect_str1);
addCell("r_i_id", "left", t_l, "", "3");
	if (fb_incorrect_str == "") fb_incorrect_str = "<br>";
fb_incorrect_str = "\n@@BeginIBody\n" + fb_incorrect_str + "\n@@EndIBody";

		if (show_buttons > 0) {
		  hs_submit(0,1);
		  hs_submit(1,1);
		} else {
		  if (!INIT_TEMP) {
			  hs_submit(0,0);
			  hs_submit(1,0);
		  }
		}

//	if (show_buttons > 0) {
//        ta = document.createElement("textarea");
//        ta.setAttribute("id", "ans_ta_id");
//        ta.setAttribute("name", "");
//        ta.setAttribute("class", "ans_ta");
//        ta.setAttribute("cols", "50");
//        ta.setAttribute("rows", "10");
//        ta.setAttribute("wrap", "virtual");
//
//		document.getElementById("r_qo_area_id").appendChild(ta);
//
//		ta.innerHTML = ta_str;
//
//		ta.focus();
//	}

		return true;
	}

      function initSpan4(v_id, t, s){
        var j, k, rw, cl;

        switch (s) {
            case 'q_4'  : j = q_4_i; break;
            case 'o_4'  : j = o_4_i; toggle('l_o_arr'); break;
            case 'h_4'  : j = h_4_i; break;
            case 'c_4'  : j = c_4_i; break;
            case 'i_4'  : j = i_4_i; break;
            default     : j = q_4_i;
        }

        for (k=0; k<j; k++) {
            addToSpan(v_id, t, s, "");
        }
      }
	
	function initBox4(s_id, n, t, s, str) {
		
		var arr='', enm;
		/**  By Ramesh **/
		var optionnames=new Array();
		var optionvalues= new Array();
		var defaultval;
		/**  By Ramesh **/
		var rw, cl;

		switch (s) {
			case 'q_4'	: rw = q_4_rows; cl = q_4_cols; break;
			case 'o_4'	: rw = o_4_rows; cl = o_4_cols; break;
			case 'h_4'	: rw = h_4_rows; cl = h_4_cols; break;
			case 'c_4'	: rw = c_4_rows; cl = c_4_cols; break;
			case 'i_4'	: rw = i_4_rows; cl = i_4_cols; break;
			default		: rw = q_4_rows; cl = q_4_cols;
		}

	    var p;
		switch (s_id) {
			case "l_q_area_id"	:
				p = "l_q_";
				arr = "q_arr";
				enm = l_q_arr;
				break;
			case "l_o_area_id"	:
				p = "l_o_";
				arr = "o_arr";
				enm = l_o_arr;
				break;
			/**  By Ramesh **/	
			case "l_d_area_id"  :

				p="l_d_";
				arr="";
				enm=0;
				optionnames[0]= "Very Easy";
				optionnames[1]= "Easy";
				optionnames[2]= "Average";
				optionnames[3]= "Above average";
				optionnames[4]= "Difficult";

				optionvalues[0]="0";
				optionvalues[1]="1";
				optionvalues[2]="2";
				optionvalues[3]="3";
				optionvalues[4]="4";
				defaultval="3";

				break;
			case "l_e_area_id"  :
				p="l_e_";
				arr="";
				enm=0;
				break;
			case "l_s_area_id"  :
				p="l_s_";
				arr="";
				enm=0;

				optionnames[0]= "Seconds";
				optionnames[1]= "Minutes";
				optionnames[2]= "Hours";

				optionvalues[0]="0";
				optionvalues[1]="1";
				optionvalues[2]="2";
				defaultval="0";
				break;
/**  By Ramesh **/
			case "l_h_area_id"	:
				p = "l_h_";
				arr = "";
				enm = 0;
				break;
			case "l_c_area_id"	:
				p = "l_c_";
				arr = "";
				enm = 0;
				break;
			case "l_i_area_id"	:
				p = "l_i_";
				arr = "";
				enm = 0;
		}

		var cls= p + "ta";
		var v1 = p + "ta" + n;
		var v2 = p + "ul" + n;
		var v3 = p + "ulc" + n;
		var id1 = v1 + "_id";
		var id2 = v2 + "_id";
		var id3 = v3 + "_id";

        div = document.getElementById(s_id);
		switch (t) {
		  case "textbox" :
			  
			  addText(s_id,id1,v1,cls,str,"3");
			  if (arr != '')
				eval(arr)[n] = new Array(s_id, id1, "text", enm);
				break;
    	  case "select" :
			  
			  addSelect(s_id,id1,v1,cls,optionnames,optionvalues,str,defaultval);
			  if (arr != '')
				eval(arr)[n] = new Array(s_id, id1, "text", enm);
				break;
	/**  By Ramesh **/
		  case "text"	:
			addTextArea(s_id, id1, v1, cls, cl, rw, "virtual", "1", str);
		   if (arr != '')
			eval(arr)[n] = new Array(s_id, id1, "text", enm);
			break;
		  case "file"	:
			addInputElem(s_id, id2, v2, "file", str, "");
		   if (arr != '')
			eval(arr)[n] = new Array(s_id, id2, "file", enm);
		}
	}
	function submit_form(o) {
		addhidden('qo_form_id');

		var ans="\n@@BeginABody:"+s_ans+"\n"+
			  ans_str(o_f_arr[0][1], r_o_no)+
			"\n@@EndABody";
		t_fr.document.getElementById('a_ta_id').value=ans;
		
		var hta=t_fr.document.getElementById('h_ta_id');
		hta.value=hint_str;
		var cta=t_fr.document.getElementById('c_ta_id');
		cta.value=fb_correct_str;
		var ita=t_fr.document.getElementById('i_ta_id');
		ita.value=fb_incorrect_str;
		/********* Added by ramesh ***********************/
		var difLevel=t_fr.document.getElementById('d_ta_id');
		difLevel.value=diff_level_str;
		
		
		var estTime=t_fr.document.getElementById('e_ta_id');
		estTime.value=estimated_time_str;
		

		var timeScale=t_fr.document.getElementById('s_ta_id');
		timeScale.value=time_scale_str;
		

		
		/********* end ***********************/

		t_fr.document.getElementById('qo_form_id').submit();
		
		
		refreshQEd(o);
		hs_submit(0,0);
		hs_submit(1,0);
	    alert("The question is submitted to the repository.");
		document.close();
		if(o==2){
			parent.window.close();
			return false;
		}
	if (parent.window.opener != null)
		return false;
	}
	function ans_str(id, n) {
		var s = document.getElementById(id).value;
//		ignore n
		return s;
	}
