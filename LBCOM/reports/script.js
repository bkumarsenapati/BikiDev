
// This returns true if the given date is in future
function isFeatureDate(dtstring){   
	var myDate=new Date(dtstring);
	var today = new Date()
	if(myDate.getFullYear()<1960){
           myDate.setFullYear(myDate.getFullYear()+100)
    }
	if (myDate>today)
		return true;
	else
		return false;
}
// This returns true if the given date if in format
function checkdateformat(format,dtstring){
	if(format==="mm/dd/yy"){
		var date_array=dtstring.split("/");
		if(isNaN(date_array[0])||isNaN(date_array[1])||isNaN(date_array[2]))
			return false;
		if((date_array[0]>12)||(date_array[1]>31))
			return false;
		return true;
	}
}