//	---------------------------------
//	type 5: fill-in-the-blanks	// qtype = 3 in selection list
	  var q_5_rows=3, o_5_rows=1, h_5_rows=2, c_5_rows=2, i_5_rows=2;
	  var q_5_cols=54, o_5_cols=30, h_5_cols=30, c_5_cols=30, i_5_cols=30;

	  var q_5_i = 1, o_5_i = 1, h_5_i = 1, c_5_i = 1, i_5_i = 1;
//	---------------------------------
if (navigator.appVersion.indexOf("Win")!=-1){
  if(document.all){
	q_5_cols=64; o_5_rows=2;}
  else{
	q_5_cols=47;
	o_5_cols=20;
  }
}
//	---------------------------------

var BLANK = "bspace";
var BLANK = "__________";
var QType = 5;
var s_ans="";
var hint_str = "", fb_correct_str = "", fb_incorrect_str = "",diff_level_str="",pointspossible_str="",IncorrectResponse_str="",estimated_time_str="",time_scale_str="";

//msg['default'] = '<b>>>>> Question type: Fill-in-the-blanks</b><br>' +
msg['default'] = '<b>>>>> Use "__________" (ten underscore symbols - '+
	'without double quotes) to represent an in-line blank space to' +
	' be filled.</b><br/>' + msg['common'];

	var inBl = "__________";
	var outBl = "==========";

	function write_review5() {
	  if (HAMode) {alert("Please exit HTML editor."); return false;}
		var b, e, rq, ro, rdiv, rqdiv, rodiv, rqodiv, l, li, lid;
		var str, str2, t_l, t_l_t, t_p;
		var i =0, j = 0, k=0;
		var e_l = new Array();
		var e_l_v = new Array();
		var qe_l_v = new Array();

		var cbi, kcbi;

		var enm, et, t_enm, t, tnd, csp, value;

		var show_buttons = 0;
		  hs_submit(0,0);
		  hs_submit(1,0);

		rqodiv = document.getElementById("r_qo_area_id");

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
				if (!INIT_TEMP) 
				e.parentNode.removeChild(e);
				continue;
			} else {
//				e_l_v[j] = e.value;
				qe_l_v[j] = e.value;
				q_f_arr[j] = new Array(q_arr[i][0], q_arr[i][1],
					q_arr[i][2], q_arr[i][3]);
				j++;
				show_buttons=1;
			}
		}
		r_q_no = j;

if (r_q_no < 1) { alert("Missing question body!"); return false; }

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
var out_str="\n@@BeginQBody:qtype=3";
out_str = out_str + ":qid=" + document.getElementById('q_id').value;

out_str = out_str + '\n' + T + T;

		j = 0;
		for (i=0; i < l_o_no; i++) {
			e = document.getElementById(o_arr[i][1]);
			if (e == null) continue;
			if (o_arr[i][2].toLowerCase() == 'file') {
				value = e.childNodes[1].value;
			} else {
				value = e.value;
			}

			if (value == "") {
//				if (!INIT_TEMP) 
				e.parentNode.removeChild(e);
				continue;
			} else {
				e_l_v[j] = e.value.trim(); //need to trim!

				o_f_arr[j] = new Array(o_arr[i][0], o_arr[i][1],
					o_arr[i][2], o_arr[i][3]);
				j++;
				show_buttons=1;
			}
		}
		r_o_no = j-1;
		
//if (r_o_no < 0) { alert("No blank space(s) to fill!"); return false; }

		// reorder e_l_v's
		var i_arr = new Array();
		var j_str = "";
		// join all q_str
		for (i=0; i < r_q_no; i++) j_str = j_str+qe_l_v[i]+" ";

		var offset = -1;
		k = -1;

		while ((i = j_str.indexOf(BLANK, offset+1)) > -1) {
			i_arr[++k] = offset = i;
		}
if (k>r_o_no) { alert("Number of blank space(s) is more than that of the word(s) supplied.");
				return false; }
		while (k++ < r_o_no) {
			j_str = j_str + '<br>' + BLANK;
		}

addTable("r_qo_area_id", "r_q_t_id", "r_q_t", "100%", "0", "", "");

	  if (show_buttons > 0) {
		for (i=0; i < r_q_no; i++) {
addRow("r_q_t_id", rid="r_qr"+i+"_id", "r_qr_d");
			t_l = document.createElement("div");
			j_str= replaceAll(j_str,"\n","<br>");
			t_l.innerHTML = blank_to_fill(j_str, 1);
addCell(rid, "left", t_l, "", csp);
out_str = out_str + blank_to_fill(j_str, 0);
out_str=out_str+"\n@@EndQBody";
		}
	  }

out_str=out_str+"\n@@BeginOBody";

addTable("r_qo_area_id", "r_o_t_id", "r_o_t", "100%", "0");

	  if (show_buttons > 0) {

		k = 0;
		t_enm = 0;
		for (i=0; i <= r_o_no; i++) {
			t_enm = t_enm+(o_f_arr[i][3] > 0)?1:0;
		}	// t_enm > 0 => at least one item enumerated

		var ans_str = "";
		var ans_body = "";

		for (i=0; i <= r_o_no; i++) {
			enm = o_f_arr[i][3];
			str1 = e_l_v[i];

			rid = "r_or"+i+"_id";
addRow("r_o_t_id", rid, "r_or_d");

			t = document.l_qo_form.o_enum_type;
//			t = t.options[t.selectedIndex].value;
			t = "roman";

			enm = 1;
			var estr = enum_str(t, enm, k);
			if (enm == 1) k++; else k=0;
				
			t_l = document.createElement("span");
			str1= replaceAll(str1,"\n","<br>");
			t_l.innerHTML = format(str1);

			if (t_enm == 0) csp = "1";
			else if (enm < 0) {
				csp = "2";
			} else {
				csp = "1";
addCell(rid, "right", document.createTextNode(estr), "20", "1");
			}

	out_str=out_str+ '\n'+T+estr+T+ str1;
//	out_str=out_str+ '\n'+T+" "+T+ str1;
		
addCell(rid, "left", t_l, "", csp);
ans_body=ans_body+","+str1;

		}
out_str=out_str+"\n@@EndOBody";
	  }

var qota=t_fr.document.getElementById('qo_ta_id');
qota.value=out_str;

ans_str="\n@@BeginABody:"+s_ans+"\n"+ ans_body.substring(1,ans_body.length) + 
		"\n@@EndABody";
var ata=t_fr.document.getElementById('a_ta_id');
ata.value=ans_str;

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

		return true;
	}

	function blank_to_fill(qstr, i) {
		var r = new RegExp(BLANK, "g");
		var s = (i>0)?"<input type=\"text\" size=\"10\">":inBl;

		return(qstr.replace(r, s));
	}
/*
	function blank_to_fill(qstr, sstr, rstr) {
		var i, j = 0;
		var ostr = new Array("", "", "");
		if (rstr == "") {
		  m = sstr.length;
		  n = qstr.length;
		  i = qstr.indexOf(sstr);
		  if (i != -1) {
		  	ostr[0] = qstr.substring(0, i);
			  for (j=0; j < m; j++) ostr[1] = ostr[1]+"_";
			  ostr[2] = qstr.substring(i+m);
		  } else { 
		  	  ostr[0] = qstr; 
		  }
		} else {

		}
		return (ostr);
	}
*/

      function initSpan5(v_id, t, s){
        var j, k, rw, cl;

        switch (s) {
            case 'q_5'  : j = q_5_i; break;
            case 'o_5'  : j = o_5_i; toggle('l_o_arr'); break;
            case 'h_5'  : j = h_5_i; break;
            case 'c_5'  : j = c_5_i; break;
            case 'i_5'  : j = i_5_i; break;
            default     : j = q_5_i;
        }

        for (k=0; k<j; k++) {
            addToSpan(v_id, t, s, "");
        }
      }
	
	function initBox5(s_id, n, t, s, str) {
		
		var arr='', enm;
		/**  By Ramesh **/
		var optionnames=new Array();
		var optionvalues= new Array();
		var defaultval;
		/**  By Ramesh **/
		var rw, cl;

		switch (s) {
			case 'q_5'	: rw = q_5_rows; cl = q_5_cols; break;
			case 'o_5'	: rw = o_5_rows; cl = o_5_cols; break;
			case 'h_5'	: rw = h_5_rows; cl = h_5_cols; break;
			case 'c_5'	: rw = c_5_rows; cl = c_5_cols; break;
			case 'i_5'	: rw = i_5_rows; cl = i_5_cols; break;
			default		: rw = q_5_rows; cl = q_5_cols;
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

	function rewrite(qstr, astr) {
		var i=0, j=0, n;
		var s = astr+',';
		var a = new Array();
		var ri = new RegExp(inBl, "");
		var ro = new RegExp(outBl, "g");

		while (i = s.indexOf(',')) {
		  if ( (n = s.length) > 0) {
			a[j++] = s.substring(0,i);
			s = s.substring(i+1, n);
		  } else break;
		}
//		s = qstr.replace(ro, "");
		s = qstr;
		for (i=0; i < j; i++) {
			s = s.replace(ri, a[i]);
		}

//alert(document.getElementById('l_q_ta0_id').innerHTML);
//alert(s);

		document.getElementById('l_q_ta0_id').value = s;
		return(true);
	}

//rewrite("asd asf " +inBl+ " bb " + inBl + " cc\n"+outBl+"\n"+outBl, "xxx,yyy");
	
	function submit_form(o) {
		addhidden('qo_form_id');

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

////		var eh = document.getElementById('r_sub_stat').innerHTML;
		
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

		document.close();
		if(o==2){
			parent.window.close();
			return false;
		}
		if (parent.window.opener != null)
			return false;
		}
