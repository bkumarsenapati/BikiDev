/////////////////////////////////////////////////////////////////my Date Function////////////////////////////////
function checkdateofbirth(d,m,y,field)
{
	alert(d+"/"+m+"/"+y)
	var TFM="<LI><font face=Verdana size=1 color=black>Enter valid date for "+field+"</font>";
	var date1=true
	var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
	tday=new Date();  
	if(y <=1900 || y >= parseInt(tday.getFullYear()) ||isNaN(y))
	  {
		date1=false
	  }
	else
	if(y %4==0 &&(y%100!=0 ||y%400==0))
		dinm[2]=29;

	if((m > 12 || m < 1)|| isNaN(m))
		{
		  date1=false
		}
	if((d<1 || d >dinm[m])||isNaN(d) )
	{
	   date1=false
	}
   if(date1==false){
		errmsg=errmsg+TFM+"</LI>";
	    res=false;
   }
}
///////////////////////////////////////////////////////it will check for date////////////////////////////////////
function checkdate(d,m,y,field)
{
	var TFM="<LI><font face=Verdana size=1 color=black>Enter valid date for "+field+"</font>";
	var date1=true
	var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
	tday=new Date();  
	if(y <=1900 || isNaN(y))
	  {
		date1=false
	  }
	else
	if(y %4==0 &&(y%100!=0 ||y%400==0))
		dinm[2]=29;

	if((m > 12 || m < 1)|| isNaN(m))
		{
		  date1=false
		}
	if((d<1 || d >dinm[m])||isNaN(d) )
	{
	   date1=false
	}
   if(date1==false){
		errmsg=errmsg+TFM+"</LI>";
	    res=false;
   }
}
///////////////////////////////////////////////////////////Struts type validations////////////////////////////////////
function Required(eles){							// REQUIRED VALIDATOR
//	var TFM="<LI>* Fields are mandatory";
	var TFM="<LI><font face=Verdana size=1 color=black>Fields marked with an asterisk<font color=red>* </font>are required</font>";
	var eles=eles.split(",")
	for(var i=0;i<eles.length;i++){
		var ele=eval(window.document.getElementById(eles[i]));
		if(trim(ele.value)=="" || ele.length==0){
			res=false;
			errmsg=errmsg+TFM+"</LI>";
			break;
		}
	}
}
function ReqNumber(eles){								    //For Number Fields
	var TFM="&nbsp;allows Numbers only";
	var eles=eles.split(",")
	for(var i=0;i<eles.length;i++){
		var ele=eval(window.document.getElementById(eles[i]));var k=0;brk=0;
		if(ele.value=="")
			continue;
		if(isNaN(parseFloat(ele.value))){  
			res=false;
			var tempeleids=""+eleids;
			var tempeleids=tempeleids.split(",");
			var tempelenames=""+elenames;
			var tempelenames=tempelenames.split(",");
			for(var j=0;j<tempeleids.length;j++){
						if(eles[i]==tempeleids[j])
							errmsg=errmsg+ "<LI><font face=Verdana size=1 color=black>"+tempelenames[j] +  TFM+"</font></LI>";
			}
		}
	}
	
}

function ShowErrors(message){								// TO SHOW ERROR MESSAGES
	errmsg="";
	var trows=document.getElementById('errshow').rows
	var tcells=trows[0].cells
	if(res==false){
		tcells[0].innerHTML="<DIV id=Err_Div><SPAN class=ct><SPAN class=cl></SPAN></SPAN><DIV>"+message+"</DIV><SPAN class=cb><SPAN class=cl></SPAN></SPAN></DIV>";
		res=true;
		window.scrollTo(0,0)
		return false;
	}else{
	replacequotes();
	return true	

	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

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
	    email=trim(email);
		var invchar=" ~`!#%^&*()+={}[];:'\|,<>?/\ ";
	    if((email.indexOf("@")== -1)||(email.indexOf("@")!=email.lastIndexOf("@"))||(email.indexOf("@")==0)||(email.indexOf(".")== -1)||email.indexOf(".")==email.length-1){
				//errmsg=errmsg+ "<LI><font face=Verdana size=1 color=black>This is not a correct Email address</font></LI>"
				//res=false;
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
					//errmsg=errmsg+ "<LI><font face=Verdana size=1 color=black>Please enter correct Email address</font></LI>";
					//res=false;
					return false;
			   }
		 }
	 	return true;  
}
function checkUserName(validateData)   ///It is used to check whether the user id id correct or not 
	{
		var charAta;
		for(var i=0;i<validateData.length;i++)
		{
			charAta=validateData.charAt(i);
			if(!( (charAta>=0 && charAta<=9) || (charAta>='A' && charAta<='Z') || 
			(charAta>='a' && charAta<='z') || (charAta=='_') ))
			{
				errmsg=errmsg+ "<LI><font face=Verdana size=1 color=black>Please enter valid UserID</font></LI>";
				res=false;
			}
		}
}

/////////////////////////////////////////Single Quotes///////////////////////////////////////////////////////////////////
function replacequotes(){
	var inputs = document.getElementsByTagName("input");
	for(i=0;i<inputs.length;i++)
		if(inputs[i].type=="text"){
			var str = replaceAll( inputs[i].value, "\"", "&quot;" );
			str = replaceAll( str, "<", "&lt;" );
			str = replaceAll( str, ">", "&gt;" );
			str = replaceAll( str, "'", "###########" );
			str = replaceAll( str, "###########", "\\\'" );
			inputs[i].value=str;
		}
	var inputs = document.getElementsByTagName("textarea");
	for(i=0;i<inputs.length;i++){		
			var str = replaceAll( inputs[i].value, "'", "###########" );
			str = replaceAll( str, "###########", "\\\'" );
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function loding(){
	document.getElementById("loading").style.visibility="visible";
	document.forms[0].style.visibility="hidden";
}
function hide_loding(){
	document.getElementById("loading").style.visibility="hidden";
	document.forms[0].style.visibility="visible";
}
//<DIV id=loading  style='WIDTH:100%;height:100%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;visibility:hidden'><IMG src="/LBRT/loding/images/loading.gif" border=0></DIV>