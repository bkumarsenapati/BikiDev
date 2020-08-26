function showAll(n) {
	var kids = n.childNodes;
	var l = kids.length;
	for (var i = 0; i < l; i++) {
//		if (kids[i].tagName.toLower() == 'body') {
			alert(i+":"+kids[i].nodeValue);
			alert(kids[i].innerHTML);
//		}
	}
}

if (!winList) { var winList = new Array(); }

function showSlide(schid,uid,utype,sid,w,h,flag) {
  if (flag > 0) {
	var href;
    try {
	href = window.frames['if_content'].location.href;
    } catch (e) {
	href = "about:blank";
    }

	winList['slideShow'] = openPopup('slideShow','./show.php?schoolid='+schid+'&emailid='+uid+'&usertype='+utype+'&sessid='+sid+'&url='+href,w,h);
	winList['slideShow'].focus();
  } else {
	alert('not enough privilege.');
  }
}

function openPopup(target,url,width,height)
{
  var w;
/*
  if (winList) w = winList[target];
  if (w && w.open) {
alert('open');
	if (w.location.href != url) w.location.href = url;
	w.focus();	
  } else {
alert('reopen');
*/
    if(width > 0 && height > 0) {
        var centered;
        x = (screen.availWidth - width) / 2;
        y = (screen.availHeight - height) / 2;
        centered =',width=' + width + ',height=' + height + ',left=' + x + ',top=' + y + ',location=no,toolbar=no,directories=no,menubar=no,scrollbars=yes,resizable=yes,status=no';
    } else {
        centered = 'location=no,toolbar=no,directories=no,menubar=no,scrollbars=yes,resizable=yes,status=no';
    }
    w = window.open(url, target, centered);
/*
    if (!w.opener) w.opener = self;
    w.focus();
*/
	winList[target]=w;
/*
  }
*/
  return(w);
}

function closePopups() {

	var wins = new Array('eClassRoom','slideShow','studentView');
	var w;

	for (var i = 0; i < wins.length; i++) {
		if ((w=winList[wins[i]]) && !w.closed) w.close();
//		if (w=winList[wins[i]]) w.close();
	}
}

function listFrames(){
    var i, frm = parent.frames, key;
    for (i = 0; i < frm.length; i++) {
	alert('--'+i+'--'+frm[i].name);
    }
}

function noteUsage() {

//    setTimeout('listFrames()', 10000);

}
