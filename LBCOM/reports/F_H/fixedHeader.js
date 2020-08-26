function tb(idh){
	var n;
	if(document.all) {
		n = 0;
	} else {
		n = 1;
	}

        var h = document.getElementById(idh);
//	var r = h.childNodes[n];
//        var r = document.getElementById('tb0').childNodes[n];

        var cl = h.cloneNode(true);

        cl.id = 'th1';

        h.style.visibility = 'hidden';

        document.getElementById('tbl0').appendChild(cl);

	

	var w = document.getElementById('tbl1').offsetWidth;
	document.getElementById('tbl0').width = w;
	(document.getElementById('tableHeader').style.width = (w+16)+'px');
	(document.getElementById('tableContainer').style.width = (w+16)+'px');
if(document.all) {
	document.getElementById('tableContainer').style.overflowX = 'hidden';
}

	var c = document.getElementById('th1').childNodes[n];
	var r = document.getElementById('th0').childNodes[n];
for (i=n; i<c.childNodes.length;i+=(n+1)){
	(c.childNodes[i].width = r.childNodes[i].offsetWidth-1);
}

/*
for (i=n; i<c.childNodes.length;i+=(n+1)){
alert(document.getElementById('th0').childNodes[1].offsetWidth);
alert(document.getElementById('tableHeader').offsetWidth);
alert(document.getElementById('th1').childNodes[1].offsetWidth);
alert(document.getElementById('tableContainer').offsetWidth);
}
*/
}
