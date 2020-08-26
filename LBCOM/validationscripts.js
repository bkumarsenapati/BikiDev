function checkNum(keyCode)
{

   if(keyCode==8 || keyCode==13)
		return true;

	if(keyCode<48 || keyCode>57)
	{
		alert("Enter Numbers Only");
		return false;
	}
	return true;

}
	
	function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}


	function isValidEmail(email){
				var invchar=" ~`!#%^&*()+={}[];:'\|,<>?/\ ";
	    if (email.length == 0){
		   alert("You must enter email address" )
		   return false;
	   }else{
	       if((email.indexOf("@")== -1)||(email.indexOf("@")!=email.lastIndexOf("@"))||(email.indexOf("@")==0)||(email.indexOf(".")== -1)||email.indexOf(".")==email.length-1){
				alert("Enter valid email address");
				//||(email.indexOf(".") <= email.indexOf("@")+1)
				return false;
		   } else {
				var i=0;
				var ch;
				while ((i< email.length)){
					ch=email.charAt(i);
					i++;
					if(invchar.indexOf(ch)!= -1)
						break;
			   }

			   if(i<email.length){
					alert("This is not a correct Email address")
					return false;
			   }
		 }
	 	  return true;
	  }

    }

	function isUserName(validateData)
	{
		if(validateData==null || validateData.length==0)
		{
			return false;
		}
		var charAta;
		for(var i=0;i<validateData.length;i++)
		{
			charAta=validateData.charAt(i);
			if(!( (charAta>=0 && charAta<=9) || (charAta>='A' && charAta<='Z') || 
			(charAta>='a' && charAta<='z') || (charAta=='_')|| (charAta=='-')|| (charAta=='.')|| (charAta==':') ))
			{
				alert("Enter valid username");
				return false;
			}
		}
	}

	function popUpWindow(popStr,imgName,title){		

		var w=window.open("popup","","width=398,height=127");
		
		w.document.write("<html><head><title>"+title+"</title></head><body bgcolor='#40A0E0' topmargin='2' leftmargin='2'>");
		w.document.write("<table border='1' width='100%' cellspacing='0' bordercolorlight='#EDECE9' height='123'>");
		w.document.write("<tr>");
		w.document.write("<td width='100%' bgcolor='#FFFFFF' height='27'><img border='0' src='/LBRT/images/"+imgName+"' ></td>");
		w.document.write("</tr>");
		w.document.write("<tr><td width='100%' valign='top' bgcolor='#EDECE9' height='88'>"+popStr+"</td></tr></table></body></html>");		
		w.document.close();
		w.focus();
	}

////////////////////////////////////////////////////Functions for replace Quotes//////////////////////////////////////////
	function replacequotes(){
		
	var inputs = document.getElementsByTagName("input");
	for(i=0;i<inputs.length;i++)
		if(inputs[i].type=="text"){
			var str = replaceAll( inputs[i].value, "\"", "&quot;" );
			str = replaceAll( str, "<", "&lt;" );
			str = replaceAll( str, ">", "&gt;" );
			str = replaceAll( str, "'", "####" );
			str = replaceAll( str, "####", "\\\'" );
			inputs[i].value=str;
		}
	var inputs = document.getElementsByTagName("textarea");
	for(i=0;i<inputs.length;i++){		
			var str = replaceAll( inputs[i].value, "'", "####" );
			str = replaceAll( str, "####", "\\\'" );
			str = replaceAll( str, "<", "&lt;" );
			str = replaceAll( str, ">", "&gt;" );
			inputs[i].value=str;
		}
	}
	function replaceAll( str, from, to ) {
		var idx = str.indexOf( from );
		while ( idx > -1 ) {
			str = str.replace( from, to ); 
			idx = str.indexOf( from );
		}
		return str;
}
/////////////////////////////////Function for input restriction///////////////////////////////////////////////////////
function restrictctrl(MyField,e){ ////this is for ctrl only
	if(e.keyCode==17){
		var pres=MyField.value;
		alert("This key is not permited");
		MyField.value=pres;
		return false;
	}
}
function NumbersOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;

else if ((("0123456789").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

function AlphaOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;
   
else if ((("qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM ").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

function AlphaNumbersOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;
   
else if ((("0123456789qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM_-:. ").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}
/// this is for passwords
function pwdOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;

else if ((("\'\"").indexOf(keychar) > -1))
   return false;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return true;
}
// this is for school names and teacher names and student names
function NameOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;
   
else if ((("qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM. ").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

// This is for schoolid /teacher id/student id
function UIDOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;
// don't give "." in user ids
   
else if ((("0123456789qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM_-:. ").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

// This function is for to set phone and fax numbers
function PhoneOnly(MyField, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

if ((key==null) || (key==0) || (key==8) ||
    (key==9) || (key==13) || (key==27) )
   return true;

else if ((("0123456789").indexOf(keychar) > -1))
   return true;

else if (dec && (keychar == "."))
   {
   MyField.form.elements[dec].focus();
   return false;
   }
else
   return false;
}