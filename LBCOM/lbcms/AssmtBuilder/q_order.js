//	---------------------------------
//	type 7: ordering	// qtype = 5 in selection list
	  var q_7_rows=3, o_7_rows=1, h_7_rows=2, c_7_rows=2, i_7_rows=2;
	  var q_7_cols=54, o_7_cols=32, h_7_cols=30, c_7_cols=30, i_7_cols=30;

	  var q_7_i = 1, o_7_i = 4, h_7_i = 1, c_7_i = 1, i_7_i = 1;
//	---------------------------------
if (navigator.appVersion.indexOf("Win")!=-1){
  if(document.all){
	q_7_cols=64; o_7_rows=2;}
  else{
	q_7_cols=50;
  }
}

//-----------------------------

var QType = 7;
var s_ans="";
var hint_str = "", fb_correct_str = "", fb_incorrect_str = "",diff_level_str="",pointspossible_str="",IncorrectResponse_str="",estimated_time_str="",time_scale_str="";

//msg['default'] = '<b>>>>> Question type: Ordering items.</b><br>' +
msg['default'] = '<b>>>>> </b>' +
		msg['common'];

	function write_review7() {
	  if (HAMode) {alert("Please exit HTML editor."); return false;}
		var b, e, rq, ro, rdiv, rqdiv, rodiv, rqodiv, l, li, lid;
		var str, str1, ostr1, str2, t_l, t_l_t, t_p;
		var i =0, j = 0, k=0;
		var e_l = new Array();
		var e_l_v = new Array();
		var e1_l_v = new Array();
		var e2_l_v = new Array();

		var cbi, kcbi;

		var enm, et, t_enm, t, tnd, csp, value, ss;

		var show_buttons = 0;
			  hs_submit(0,0);
			  hs_submit(1,0);

		rqodiv = document.getElementById("r_qo_area_id");

		while (rqodiv.hasChildNodes()) {
			rqodiv.removeChild(rqodiv.firstChild);
		}

		j = 0;
		show_buttons=1;
		for (i=0; i < l_q_no; i++) {
			e = document.getElementById(q_arr[i][1]);
			if (e == null) continue;
			if (q_arr[i][2].toLowerCase() == 'file') {
				value = e.childNodes[1].value;
			} else {
				value = e.value;
			}

			if (value == "") {
//			  if (!INIT_TEMP) 
				e.parentNode.removeChild(e);
				continue;
			} else {
				e_l_v[j] = value;
				q_f_arr[j] = new Array(q_arr[i][0], q_arr[i][1],
					q_arr[i][2], q_arr[i][3]);
				j++;
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
addtextarea(t_fr,"qo_form_id","p_ta_id","p_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","n_ta_id","n_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","d_ta_id","d_ta","hidden","80","20","virtual");// added by ramesh
addtextarea(t_fr,"qo_form_id","e_ta_id","e_ta","hidden","80","20","virtual");
addtextarea(t_fr,"qo_form_id","s_ta_id","s_ta","hidden","80","20","virtual");
var out_str="\n@@BeginQBody:qtype=5";
out_str = out_str + ":qid=" + document.getElementById('q_id').value;

addTable("r_qo_area_id", "r_q_t_id", "r_q_t", "100%", "0", "", "");

  if (show_buttons > 0) {
		var append;
	for (i = 0; i <= r_q_no; i++) {
			append = true;
			eid = q_f_arr[i][1];
            enm = q_f_arr[i][3];
            switch (q_f_arr[i][2]) {
              case "file"   :
                str1 = "File: "+e_l_v[i];
				title = document.getElementById('f_'+eid).value;
                ostr1 = q_f_arr[i][1]+"||0||0||"+title;
				ss = F;
				if (uploadedFiles.indexOf(eid) >= 0) append=true;
				else append = false;
                break;
              default       :
                str1 = e_l_v[i];
				ostr1 = str1;
				ss = T;
            }

		  if (append) {
			rid = "r_qr"+i+"_id";
// row1
addRow("r_q_t_id", rid, "r_qr_d");

			t_l = document.createElement("div");
			str1= replaceAll(str1,"\n","<br>");
			t_l.innerHTML = format(str1);
addCell(rid, "left", t_l, "", "1");
		out_str=out_str+ '\n'+ss+ss+ ostr1;
		  }
	}
out_str=out_str+"\n@@EndQBody";
  }

		j = 0;
		for (i=0; i < l_o1_no; i++) {
			e = document.getElementById(o1_arr[i][1]);
			if (e == null) continue;
			if (e.value == "") {
				e.parentNode.removeChild(e);
				continue;
			} else {
				e1_l_v[j] = e.value;
				o1_f_arr[j] = new Array(o1_arr[i][0], o1_arr[i][1],
					o1_arr[i][2], o1_arr[i][3]);
			}
			j++;
			show_buttons=1;
		}
		var r_o1_no = j - 1;

		j = 0;
		for (i=0; i < l_o2_no; i++) {
			e = document.getElementById(o2_arr[i][1]);
			if (e == null || e.value == "") continue;
//			if (e.value == "") {
//				if (!INIT_TEMP) e.parentNode.removeChild(e);
//				continue;
//			} else {
				e2_l_v[j] = e.value;
				o2_f_arr[j] = new Array(o2_arr[i][0], o2_arr[i][1],
					o2_arr[i][2], o2_arr[i][3]);
//			}
			j++;
			show_buttons=1;
		}
		var r_o2_no = j - 1;
		
addTable("r_qo_area_id", "r_o_t_id", "r_o_t", "100%", "0");

	  if (show_buttons > 0) {

		var estr1, estr2;
		var sel_id, sel_name;
		var opt_arr = new Array();
		var val_arr = new Array();
		var sel_id_arr = new Array();

		r_o_no = (r_o1_no >= r_o2_no)?r_o1_no:r_o2_no;

if (r_o_no < 1) { alert("Too few options!"); return false; }

		for (i=0; i <= r_o_no; i++) {
			if (e1_l_v[i] == "") continue;
//			opt_arr[i] = e1_l_v[i];
			opt_arr[i] = en["ROMAN"][i];
			val_arr[i] = i;
		}
//		var r_o2_no = r_o_no - 1;

		for (i=0; i <= r_o_no; i++) {
			sel_id = "sel_"+i+"_id";
			sel_name = "sel_"+i;
			
			sel_id_arr[i] = addSelectElem("r_qo_area_id", sel_id, sel_name, 
								r_o_no+1, opt_arr, val_arr, "");
		}
			
		for (i=0; i <= r_o_no; i++) {
		  if (e1_l_v[i] == "") continue;
			str1_1 = e1_l_v[i];
//			str1_2 = e2_l_v[i];
			rid = "r_or"+i+"_id";
			t_l = document.createElement("div");
			//str1_1= replaceAll(str1_1,"\n","<br>");
			t_l.innerHTML = format(str1_1);
addRow("r_o_t_id", rid, "r_or_d");

//addBlankCell(rid, "", "5");
addCell(rid, "right", document.createTextNode(en["ROMAN"][i]+'. '),"5%","1");
addCell(rid, "left", t_l, "40", "1");
addCell(rid, "left", document.getElementById(sel_id_arr[i]), "40", "1");
		}

out_str=out_str+"\n@@BeginLOBody";
        for (i=0; i <= r_o_no; i++) {
		estr1 = enum_str("ROMAN", 1, i);
out_str=out_str+ '\n' + T + estr1 + T + e1_l_v[i];
        }
out_str=out_str+"\n@@EndLOBody";

out_str=out_str+"\n@@BeginROBody";
/*
        for (i=0; i <= r_o_no; i++) {
		estr2 = enum_str("ROMAN", 1, i);
//out_str=out_str+ "\n" + T + estr2 + T + opt_arr[i];
out_str=out_str+ "\n" + T + estr2 + T + e2_l_v[i];
        }
*/
out_str=out_str+"\n@@EndROBody";
	  }

var qota=t_fr.document.getElementById('qo_ta_id');
qota.value=out_str;

var cn = 1; if (document.all) cn = 0;


/****      added by Ramesh *****/
pointspossible_str = document.getElementById('l_p_area_id').childNodes[cn].value;

var points=pointspossible_str;

addRow("r_o_t_id", "r_p_id", "r_or_d");
t_l = document.createElement("span");

t_l.innerHTML = "<b>Points Possible:</b> " + points;
addCell("r_p_id", "left", t_l, "", "3");

IncorrectResponse_str = document.getElementById('l_n_area_id').childNodes[cn].value;

var incResponse=IncorrectResponse_str;

addRow("r_o_t_id", "r_n_id", "r_or_d");
t_l = document.createElement("span");

t_l.innerHTML = "<b>Single IncorrectResponse:</b> " + incResponse;
addCell("r_n_id", "left", t_l, "", "3");

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

		set_ans(5);

		return true;
	}

      function initSpan7(v_id, t, s){
        var j, k, rw, cl;

        switch (s) {
            case 'q_7'  : j = q_7_i; break;
            case 'o_7'  : j = o_7_i; break;
            case 'h_7'  : j = h_7_i; break;
            case 'c_7'  : j = c_7_i; break;
            case 'i_7'  : j = i_7_i; break;
            default     : j = q_7_i;
        }

        for (k=0; k<j; k++) {
            addToSpan(v_id, t, s, "");
        }
      }
	
	function initBox7(s_id, n, t, s, str) {
		
		var arr='', enm;
		/**  By Ramesh **/
		var optionnames=new Array();
		var optionvalues= new Array();
		var defaultval;
		/**  By Ramesh **/
		var rw, cl;

		switch (s) {
			case 'q_7'	: rw = q_7_rows; cl = q_7_cols; break;
			case 'o_7'	: rw = o_7_rows; cl = o_7_cols; break;
			case 'h_7'	: rw = h_7_rows; cl = h_7_cols; break;
			case 'c_7'	: rw = c_7_rows; cl = c_7_cols; break;
			case 'i_7'	: rw = i_7_rows; cl = i_7_cols; break;
			default		: rw = q_7_rows; cl = q_7_cols;
		}

	    var p;
		switch (s_id) {
		  case "l_q_area_id"     : 
			p = "l_q_";
			arr = "q_arr";
			enm = l_q_arr;
                        break;
		  case "l_o1_area_id"    :
			p = "l_o1_";
			arr = "o1_arr";
			enm = l_o1_arr;
                        break;
		  case "l_o2_area_id"    :
			p = "l_o2_";
			arr = "o2_arr";
			enm = l_o2_arr;
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
		  /**  By Ramesh **/
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
			addTextArea(s_id, id1, v1, cls, cl, rw, "virtual", "0", str);
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
		var s = ans_str(r_o_no);
		for (var i = 0; i <= s.length; i++) { // validate here itself
			if (s.lastIndexOf(s.charAt(i)) > i) {
				alert("Check the answer(s).");
				return false;
			}
		}
	    if (confirm("Ensure the correctness of the answer(s).")){
		addhidden('qo_form_id');
		var ans="\n@@BeginABody:"+s_ans+"\n"+ s + "\n@@EndABody";
		t_fr.document.getElementById('a_ta_id').value=ans;
		var hta=t_fr.document.getElementById('h_ta_id');
		hta.value=hint_str;
		var cta=t_fr.document.getElementById('c_ta_id');
		cta.value=fb_correct_str;
		var ita=t_fr.document.getElementById('i_ta_id');
		ita.value=fb_incorrect_str;
		
		/********* Added by ramesh ***********************/

		var pointsposible=t_fr.document.getElementById('p_ta_id');
		pointsposible.value=pointspossible_str;

		var IncResponse=t_fr.document.getElementById('n_ta_id');
		IncResponse.value=IncorrectResponse_str;
		
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
		if(o==2)
			{
		 var sree=parent.window.opener.location.href;
			
			sree=sree.substring(0,sree.length-1);
			
			parent.window.opener.location.href=sree;
			}
			else
			{
				parent.window.opener.parent.mainmail.location.href=parent.window.opener.parent.mainmail.location.href;
			}

	    }
		document.close();
		if(o==2){
			parent.window.close();
			return false;
		}
	if (parent.window.opener != null)
		return false;
	}
	function ans_str(n) {
		var j;
		var s = "";
		s_ans="";
		for (var i=0; i<=n; i++) {
		  j=eval(document.getElementById('sel_'+i+'_id').selectedIndex);
		  s=s+en["roman"][j];
//	      s_ans+=j;
		}

		s_ans = s;
		return (s);
	}
