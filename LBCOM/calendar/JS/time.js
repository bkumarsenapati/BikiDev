      var baseText = null;
      function showPopup(w,h){
      var popUp = document.getElementById("stime");
      popUp.style.top = "200px";
      popUp.style.left = "200px";
      popUp.style.width = w + "px";
      popUp.style.height = h + "px";
      if (baseText == null) baseText = popUp.innerHTML;
      popUp.innerHTML = baseText +
      "<select id=\"st\" name=\"st\" onchange=\"hidePopup();\">"+
		  "<option>12:00 AM</option>"+
		  +"<\select>";
      var sbar = document.getElementById("st");
      sbar.style.marginTop = (parseInt(h)-40) + "px";
	  
      popUp.style.visibility = "visible";

      }

	   function hidePopup(){
      var popUp = document.getElementById("popupcontent");
      popUp.style.visibility = "hidden";
    }