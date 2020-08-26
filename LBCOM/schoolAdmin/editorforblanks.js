var html='';
var flag=0;
//var im='../schoolAdmin/symbols/phy.jpg';



var im1='../schoolAdmin/symbols/que_s.jpg';
var im2='../schoolAdmin/symbols/que_e.jpg';
var im11='../schoolAdmin/symbols/C-Ans-s.jpg';
var im12='../schoolAdmin/symbols/C-Ans-e.jpg';



function EditorOnSize(select)
	{
		EditorFormat("fontsize", select[select.selectedIndex].value);
//		select.selectedIndex = 0;
	}




function EditorOnFont(select)
	{
	


		EditorFormat("fontname", select[select.selectedIndex].value);
		//select.selectedIndex = 0;
	}
	
	
var cli=0,clb=0,clu=0;	

function AdiBold(but)
{
if(clb==0)
{
but.style.color="#0000FF"
EditorFormat("bold",0);
clb=1;
}
else
{
but.style.color="#000000"
EditorFormat("bold",0);
clb=0;

}


}

function AdiItalic(but)
{
if(cli==0)
{
but.style.color="#0000FF"
EditorFormat("Italic",0);
cli=1;
}
else
{
but.style.color="#000000"
EditorFormat("Italic",0);
cli=0;

}
}
function AdiUnderline(but)
{

if(clu==0)
{
but.style.color="#0000FF"
EditorFormat("Underline",0);
clu=1;
}
else
{
but.style.color="#000000"
EditorFormat("Underline",0);
clu=0;

}



}

function Adiinsertimg(name,im)
{
//alert("hai");
var imgTag = '<img src="' + im + '">';
var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.selectionRange.pasteHTML(imgTag);
aa.focus();
}
}



	
	function EditorFormat(what, opt)
	{
	

		
		if (opt == "removeFormat") {
			what = opt;
			opt = null;
		}
		if (opt == null) {
			eval(aa).document.execCommand(what);
		}
		if (opt == 0) {
			eval(aa).document.execCommand(what);
		}
		else {
		
		
		
		

		eval(aa).document.execCommand(what, "", opt);
		
		}
	}

		html += "<br><br><select class=\"List\" onchange=\"EditorOnFont(this)\">";
		html += "<option class=\"Heading\">Font</option>";
		html += "<option value=\"Arial\">Arial</option>";
		html += "<option value=\"Arial Black\">Arial Black</option>";
		html += "<option value=\"Arial Narrow\">Arial Narrow</option>";
		html += "<option value=\"Comic Sans MS\">Comic Sans MS</option>";
		html += "<option value=\"Courier New\">Courier New</option>";
		html += "<option value=\"System\">System</option>";
		html += "<option value=\"Times New Roman\">Times New Roman</option>";
		html += "<option value=\"Verdana\">Verdana</option>";
		html += "<option value=\"Wingdings\">Wingdings</option>";
		html += "<option value=\"Webdings\">Webdings</option>";


		html += "</select>";
	   html += "<select class=\"List\" onchange=\"EditorOnSize(this)\">";
		html += "<option class=\"Heading\">Size</option>";
		html += "<option value=\"1\">1</option>";
		html += "<option value=\"2\">2</option>";
		html += "<option value=\"3\">3</option>";
		html += "<option value=\"4\">4</option>";
		html += "<option value=\"5\">5</option>";
		html += "<option value=\"6\">6</option>";
		html += "<option value=\"7\">7</option>";
		html += "</select>";
		
		//html += "<input type=\"checkbox\" onclick=\"EditorOnViewHTMLSource(this.checked)\">";
		//html += "View HTML Source";
		
		html+="<input type=\"button\" value=\" B \" onclick=\"AdiBold(this)\" style=\"color:#000000; font-weight: bold\">&nbsp;";
       html+="<input type=\"button\" value=\" I \" onclick=\"AdiItalic(this)\"  style=\"color:#000000; font-weight: bold \">&nbsp;";
        html+="<input type=\"button\" value=\" U \" onclick=\"AdiUnderline(this)\" style=\"color:#000000;  font-weight: bold\">";

//html+="<input type=\"button\" value=\" check \" onclick=\"Adiinsertimg(this,im)\" style=\"color:#000000;  font-weight: bold\">";

html+="<table align=center><tr><td>";
html+="<input type=\"image\" src=\"../schoolAdmin/symbols/que_s.jpg\" onclick=\"Adiinsertimg(this,im1)\">";
html+="</td><td>";
html+="<input type=\"image\" src=\"../schoolAdmin/symbols/que_e.jpg\" onclick=\"Adiinsertimg(this,im2)\">";

html+="</td><td>";
html+="<input type=\"image\" src=\"../schoolAdmin/symbols/C-Ans-s.jpg\" onclick=\"Adiinsertimg(this,im11)\">";
html+="</td><td>";
html+="<input type=\"image\" src=\"../schoolAdmin/symbols/C-Ans-e.jpg\" onclick=\"Adiinsertimg(this,im12)\">";
html+="</td></tr></table>";


		
document.writeln(html);

document.writeln("<iframe id=\"aa\" width=\"90%\" height=\"190\">");
document.writeln("</iframe>");
aa.document.designMode="on";
function adit()
{


//aa.document.writeln(text);

var htmlcode= eval(aa).document.body.innerHTML;
var findque="startques";
var findop1="startop1";
var findop2="startop2";
var findop3="startop3";
var findop4="startop4";
var findcorrect="correctans";
var findend="end";




var stimgq='<IMG src="../schoolAdmin/symbols/que_s.jpg">';
var endimgq='<IMG src="../schoolAdmin/symbols/que_e.jpg">';


var curansims='<IMG src="../schoolAdmin/symbols/C-Ans-s.jpg">';
var curansime='<IMG src="../schoolAdmin/symbols/C-Ans-e.jpg">';


if(htmlcode.search(stimgq)==-1)
{
alert("Please insert Que_s image before starting the question");


var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.focus();
}
return false;
}

if(htmlcode.search(endimgq)==-1)
{
alert("Please insert que_e image after ending the question");


var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.focus();
}
return false;
}


if(htmlcode.search(curansims)==-1)
{
alert("Please insert C_Ans_s image before starting the correctanswer");


var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.focus();
}
return false;
}

if(htmlcode.search(curansime)==-1)
{
alert("Please insert C_Ans_e image after ending the correctanswer");


var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.focus();
}
return false;
}

//alert(htmlcode); here html code will print
var state,subject,grade,topic,schoolid,teacherid;
state=window.document.valu.state.value;
subject=window.document.valu.subject.value;
grade=window.document.valu.grade.value;
topic=window.document.valu.topic.value;
schoolid=window.document.valu.schoolid.value;
teacherid=window.document.valu.teacherid.value; 


rehash=/#/gi;
reper=/%/gi;

//htmlcode=htmlcode.replace(reper,"percentagescript");
htmlcode=htmlcode.replace(reper,"~");

htmlcode=htmlcode.replace(rehash,"hashscript");


window.location.href="/LBRT/servlet/schoolAdmin.Divqueblanks?m="+htmlcode+"&state="+state+"&subject="+subject+"&grade="+grade+"&topic="+topic+"&schoolid="+schoolid+"&teacherid="+teacherid;






}


function EditorOnViewHTMLSource(textMode)
	{
		if (textMode) {
			//EditorCleanHTML();
			//EditorCleanHTML();
			eval(aa).document.body.innerText = eval(aa).document.body.innerHTML;
		}
		else {
	
			eval(aa).document.body.innerHTML = eval(aa).document.body.innerText;
		}
		eval(aa).focus();
	}



function EditorCleanHTML()
	{
//	alert("EditorCleanHTML(id)="+id);

		var fonts = eval(aa).document.body.all.tags("FONT");
		
		for (var i = fonts.length - 1; i >= 0; i--) {
			var font = fonts[i];

			if (font.style.backgroundColor == "#ffffff") {
				font.outerHTML = font.innerHTML;
				
			}
		}
	}


function crlayer()
{
if(flag==0)
{
flag=1;
//alert("hello");
var tabimg='<table><tr>';
tabimg+='<td><input type=image value="../schoolAdmin/symbols/0EQUAL.JPG" src="../schoolAdmin/symbols/0EQUAL.JPG" onclick="satya(this.value);"></td>'

tabimg+='<td><input type=image value="../schoolAdmin/symbols/1232.JPG" src="../schoolAdmin/symbols/1232.JPG" onclick="satya(this.value);"></td>'

tabimg+='<td><input type=image value="../schoolAdmin/symbols/A.JPG" src="../schoolAdmin/symbols/A.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/ALPHA.JPG" src="../schoolAdmin/symbols/ALPHA.JPG" onclick="satya(this.value);"></td>'

tabimg+='<td><input type=image value="../schoolAdmin/symbols/BELONG.JPG" src="../schoolAdmin/symbols/BELONG.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/BITA.JPG" src="../schoolAdmin/symbols/BITA.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/DEL.JPG" src="../schoolAdmin/symbols/DEL.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/E.JPG" src="../schoolAdmin/symbols/E.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/FUNCTION.JPG" src="../schoolAdmin/symbols/FUNCTION.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/graterequ.jpg" src="../schoolAdmin/symbols/graterequ.jpg" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/LAMBDA.JPG" src="../schoolAdmin/symbols/LAMBDA.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/LESSEQU.JPG" src="../schoolAdmin/symbols/LESSEQU.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/MU.JPG" src="../schoolAdmin/symbols/MU.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/N.JPG" src="../schoolAdmin/symbols/N.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/OHM.JPG" src="../schoolAdmin/symbols/OHM.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/perpendicular.jpg" src="../schoolAdmin/symbols/perpendicular.jpg" onclick="satya(this.value);"></td>'

tabimg+='<td><input type=image value="../schoolAdmin/symbols/PHI.JPG" src="../schoolAdmin/symbols/PHI.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/PHY.JPG" src="../schoolAdmin/symbols/PHY.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/PHY2.JPG" src="../schoolAdmin/symbols/PHY2.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/PHYSI.JPG" src="../schoolAdmin/symbols/PHYSI.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/POLUSMIN.JPG" src="../schoolAdmin/symbols/POLUSMIN.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/ROOT.JPG" src="../schoolAdmin/symbols/ROOT.JPG" onclick="satya(this.value);"></td>'
tabimg+='<td><input type=image value="../schoolAdmin/symbols/SIGMA.JPG" src="../schoolAdmin/symbols/SIGMA.JPG" onclick="satya(this.value);"></td>';

tabimg+='<td><input type=image value="../schoolAdmin/symbols/SYM.JPG" src="../schoolAdmin/symbols/SYM.JPG" onclick="satya(this.value);"></td>';
tabimg+='<td><input type=image value="../schoolAdmin/symbols/TITA.JPG" src="../schoolAdmin/symbols/TITA.JPG" onclick="satya(this.value);"></td>';
tabimg+='<td><input type=image value="../schoolAdmin/symbols/TRIANGLE.JPG" src="../schoolAdmin/symbols/TRIANGLE.JPG" onclick="satya(this.value);"></td></tr><table>';


//document.body.insertAdjacentHTML('BeforeEnd','<DIV ID= "TheTip"   STYLE="position:absolute; TOP:10; LEFT:380; width: 102; height: 33; background-color: white"><table><tr><td><input type=image value="../schoolAdmin/symbols/phy.jpg" src="../schoolAdmin/symbols/phy.jpg" onclick="satya(this.value);"></td><td><input type=image value="../schoolAdmin/symbols/a.jpg" src="../schoolAdmin/symbols/a.jpg" onclick="satya(this.value);"></td></tr><table></DIV>');
document.body.insertAdjacentHTML('BeforeEnd','<DIV ID= "TheTip"   STYLE="position:absolute; TOP:10; LEFT:200; width: 102; height: 33; background-color: white">'+tabimg+'</DIV>');
}

}
function satya(v)
{
//var imgTag = '<img src="../schoolAdmin/symbols/phy.jpg">';
var imgTag = '<img src='+v+'>';

var bodyRange = eval(aa).document.body.createTextRange();
aa.selectionRange = eval(aa).document.selection.createRange();
if (bodyRange.inRange(aa.selectionRange)) {
aa.selectionRange.pasteHTML(imgTag);
aa.focus();
}
}

function hidesymbols()
{
if(flag==1)
{
flag=0;
TheTip.innerHTML = "";
TheTip.outerHTML = "";
}

}
