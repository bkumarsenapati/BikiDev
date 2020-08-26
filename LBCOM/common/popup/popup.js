var left;
	var top;
	function setMouseCoordinate(e) {
		if (document.all) {
			left = document.body.scrollLeft + event.clientX
			top = document.body.scrollTop + event.clientY
		}
		else{
			left = e.pageX; 
			top = e.pageY;
		}
	}
	if (document.layers) 
	  document.captureEvents(Event.MOUSEMOVE);
	document.onmousemove = setMouseCoordinate;
	//var Popup=document.getElementById("Popup");
    function Show(obj)
    {
		var zz=obj.id
		x =left;
		y =top;
		var zz=document.getElementById("Popup");
		if (document.all) {
			zz.style.pixelLeft = x + 25;
			zz.style.pixelTop = y;
			zz.style.display = "block";
		}
		  else{
			zz.style.left = left + 25;
			zz.style.top = top;
			zz.style.display = "block";
		}
		changelayer_content(eval(obj.id));
     }
    function Hide()
    {
      document.getElementById("Popup").style.display="none";
    }
	//////////////////////////////////CHANGE LAYER CONTENT/////////////////////////////////
	function changelayer_content(content){
		var fredlayer;
		msgstring=content;
		var popup=document.getElementById("des")
		if(document.layers)
		{
		 //thisbrowser="NN4";
			popup.document.open();
			popup.document.write(msgstring);
			popup.document.close();
		  }

		 if(document.all)
		 {		
			popup.innerHTML=msgstring;
		 }
		if(document.getElementById)
		{
			//thisbrowser="NN6";
			popup.innerHTML =msgstring;
		}
  }

/////////////////////////////////////////////////////HTML CODE?/////////////////////////////////////////////////////////
  /*
	In head>>>>>>>>>>>>>>>>>>>>>>
		<SCRIPT LANGUAGE="JavaScript" src="script.js"></SCRIPT>
		<link rel="stylesheet" type="text/css" href="popup.css" /></style>

	In Body >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		<div id="Popup" class="popup">
			<div class="title" >&nbsp;&nbsp;hotschools.net</div>
			<div id="des" name="des" class="des" ></div>
		</div>

   Calling >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..
	<a id="raj" href="" onMouseOut="Hide()" onMouseOver="Show(this)" onMouseMove="Show(this)">Move the mouse over here</a><br>
	  <SCRIPT LANGUAGE="JavaScript">
		var raj="fdkdgfjsgdkjf gskjdfkjsgdfjhgsdjfgskjdfg"
	   </SCRIPT>
*/
/////////////////////////////////////////////////////HTML CODE?/////////////////////////////////////////////////////////
 

