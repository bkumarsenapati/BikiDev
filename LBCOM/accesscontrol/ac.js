function addcontrol(){
	ac_ids_arry = ac_ids.split(",")
try {
	for(var i=0;i<ac_ids_arry.length;i++){
		if(ac_status.charAt(i)==="1"){
			if(eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].type=="text")
				eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].readOnly=true;
			else if(eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].type=="button")
				eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].disabled=true;
			else if(eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].tagName=="A"){
				eval("document.getElementsByName('"+ac_ids_arry[i]+"')")[0].href="javascript:disable();";
			}
		}
	}
} catch(e) { }
}
/// This function is for controlling left panel if u restrict any page it will show error page in main panel
function disable(){
   parent.main.location.href="/LBRT/common/accessdenaid.html";
}
