
//////////////////////////////////////////////
//To change the button image
function showhide(bno){
    showSym(bno-1);
	var off=document.getElementsByName("off")
	var on=document.getElementsByName("on")
	for(i=0;i<4;i++){
		 on[i].style.zIndex=-1
		 off[i].style.zIndex=0
	}
	on[bno-1].style.zIndex=1
	off[bno-1].style.zIndex=0
	
	
}

//////////////////////////////////////

var greek_sym          =new Array();
var math_op_sym        =new Array();
var arrows_sym         =new Array();
var currency_sym       =new Array();
var super_subscript_sym=new Array();
var num_forms_sym      =new Array();
var unicode_values;
var sym_per_row=8;
var txtarea_name="question";
var current="";

function initialize_arr_values(ind){
//  if (sym_t.length == 0) {
	var i, j=0;
	switch (ind) {
	  case 0:
		//For Greek Alphabets
		for(i=945;i<=978;i++){ 
		if(i==975)
			continue;
		greek_sym[j++]=i;
		}
		for(i=913;i<=944;i++) {
			if(i==930)
				continue;
		greek_sym[j++]=i;
		}
		break;

	  case 1:
		//For Mathematical Operators
		for(i=8704;i<=8716;i++) 
		math_op_sym[j++]=i;

		for(i=8719;i<=8778;i++){
		 if(i==8729)
			continue;
		math_op_sym[j++]=i;
		}
		math_op_sym[j++]=8788;

		math_op_sym[j++]=8797;

		for(i=8800;i<=8801;i++)
		math_op_sym[j++]=i;

		for(i=8804;i<=8811;i++)
		math_op_sym[j++]=i;

		for(i=8814;i<=8825;i++)
		math_op_sym[j++]=i;

		for(i=8834;i<=8843;i++)
		math_op_sym[j++]=i;

		for(i=8894;i<=8900;i++)
		math_op_sym[j++]=i;

		math_op_sym[j++]=8902;

		math_op_sym[j++]=8904;

		math_op_sym[j++]=8917;

		for(i=8920;i<=8925;i++)
		math_op_sym[j++]=i;

		break;

	  case 2:
		//For Arrows
		for(i=8592;i<=8682;i++){
		 if((i==8634)||(i==8635))
			continue;
		arrows_sym[j++]=i;
		}
		break;

	  case 3:
		//For Currency Symbols
		 currency_sym[j++]=36;
		 currency_sym[j++]=162;
		 currency_sym[j++]=163;
		 currency_sym[j++]=164;
		 currency_sym[j++]=165;
		 currency_sym[j++]=3647;
		 for(i=8352;i<=8367;i++){
			 if((i==8363)||(i==8365)||(i==8366)||(i==8367))
				continue;
		 currency_sym[j++]=i;
		 }
		 break;

		
	  case 4:
		//for superscript and subscripts
		super_subscript_sym[j++]=8304;
		for(i=8308;i<=8334;i++)
		 super_subscript_sym[j++]=i;
		break;

	  case 5:
		//For Number forms
		for(i=8531;i<=8575;i++)
		 num_forms_sym[j++]=i;
		
	}
	return (j);
//  }
}

function insert_value(myValue){
 
  var myField;
  if(current=="")
    current='ta'
	myField=document.getElementById(current)
	//IE support
  if (document.selection) {
    myField.focus();
    sel = document.selection.createRange();
    sel.text = myValue;
  }
  //MOZILLA/NETSCAPE support
  else if (myField.selectionStart || myField.selectionStart == '0') {
    var startPos = myField.selectionStart;
    var endPos = myField.selectionEnd;
    myField.value = myField.value.substring(0, startPos)
    + myValue
    + myField.value.substring(endPos, myField.value.length);
  } else {
  myField.value += myValue+"raj";
}
}

function supsub(Value){
 if(Value=="<sub></sub>"||Value=="<sup></sup>"||Value.charAt(0)=="<"||Value.indexOf("></")>1){
    alert("The expression is incomplete.");return false;
}
     current='ta'
      insert_value(Value)
}




function showSym(ind){

var symbols, value;

var len = initialize_arr_values(ind);

switch (ind) {
	case	0:	symbols = greek_sym; break;
	case	1:	symbols = math_op_sym; break;
	case	2:	symbols = arrows_sym; break;
	case	3:	symbols = currency_sym; break;
	case	4:	symbols = super_subscript_sym; break;
	case	5:	symbols = num_forms_sym; break;
}

var symbolsTable="<table style='width:380px;background-color: white;' align='center' border='1'><tr>";
if(len%sym_per_row!=0)
	len=sym_per_row-len%sym_per_row+len;
for(var i=0;i<len;i++){
if(i>0 && i%sym_per_row==0)
symbolsTable+="</tr><tr>";
value=symbols[i];
if (value==null)
symbolsTable+="<td style='height:12; width:100px;' align=center>&nbsp;</td>";
else{
	if(document.all)
	    symbolsTable+="<td style='height:12; width:100px;color:black;font-family:Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol;' onMouseover=\"this.style.backgroundColor='gray';this.style.color='white';this.style.cursor='hand'\" onMouseout=\"this.style.backgroundColor='white';this.style.color='black'\" onClick='insert_value(this.innerHTML);' align=center>&#"+ value + ";</td>";
	else
		symbolsTable+="<td style='height:12; width:100px;color:black;' onMouseover=\"this.style.backgroundColor='gray';this.style.color='white';this.style.cursor='pointer'\" onMouseout=\"this.style.backgroundColor='white';this.style.color='black'\" onClick='insert_value(this.innerHTML);' align=center>&#"+ value + ";</td>";
}}
symbolsTable+="</tr></table>";
document.getElementById('sTable_id').innerHTML=symbolsTable;
}

