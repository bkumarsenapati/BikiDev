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
		   alert("You must enter email address")
		   return false;
	   }else{
	       if((email.indexOf("@")== -1)||(email.indexOf("@")!=email.lastIndexOf("@"))||(email.indexOf("@")==0)||(email.indexOf(".")== -1)||email.indexOf(".")==email.length-1||(email.indexOf(".") <= email.indexOf("@")+1)){
		alert("Enter valid email address");
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

	function isUserId(validateData)
	{
		if(validateData==null || validateData.length==0)
		{
			alert("Enter User Id"); 
			return false;
		}
		var charAta;
		for(var i=0;i<validateData.length;i++)
		{
			charAta=validateData.charAt(i);
			if(!((charAta>='A' && charAta<='Z') ||(charAta>='a' && charAta<='z')||(charAta>='_')||(charAta>='0' && charAta<='9') ))
			{
				alert("UserId should contain only alphabets or (_) ");
				return false;
			}
		}
	}
   function isParentName(validateData)
	{
		if(validateData==null || validateData.length==0)
		{
			alert("Enter parent name"); 
			return false;
		}
		var charAta;
		for(var i=0;i<validateData.length;i++)
		{
			charAta=validateData.charAt(i);
			if(!((charAta>='A' && charAta<='Z') ||(charAta>='a' && charAta<='z') ))
			{
				alert("Parent name should be only alphabets");
				return false;
			}
		}
	}
  function isFirstName(validateData)
	{
		if(validateData==null || validateData.length==0)
		{
			alert("Enter first name"); 
			return false;
		}
		var charAta;
		for(var i=0;i<validateData.length;i++)
		{
			charAta=validateData.charAt(i);
			if(!((charAta>='A' && charAta<='Z') ||(charAta>='a' && charAta<='z') ))
			{
				alert("First name should be only alphabets");
				return false;
			}
		}
	}
	
	// script for date validation
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
return true
}	