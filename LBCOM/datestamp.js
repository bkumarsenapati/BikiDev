days = new Array(
"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"
);
months = new Array(
"January","February","March","April","May","June","July","August","September","October","November","December"
);

function renderDate(){
	var mydate = new Date();
	var year = mydate.getYear();
	if (year < 2000) {
		if (document.all)
			year = "19" + year;
		else
			year += 1900;
	}
	var day = mydate.getDay();
	var month = mydate.getMonth();
	var daym = mydate.getDate();
	if (daym < 10)
		daym = "0" + daym;
	var hours = mydate.getHours();
	var minutes = mydate.getMinutes();
	var dn = "AM";
	if (hours >= 12) {
		dn = "PM";
		hours = hours - 12;
	}
	if (hours == 0)
		hours = 12;
	if (minutes <= 9)
		minutes = "0" + minutes;
	document.writeln("<FONT COLOR=\"#000000\" FACE=\"Verdana,arial,helvetica,sans serif\" size=\"1\"><B>&nbsp;",days[day]," ",daym," ",months[month]," ",year,"</B> | ",hours,":",minutes," ",dn,"</FONT><BR>");
}

renderDate();