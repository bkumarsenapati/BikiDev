<html>
<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<SCRIPT LANGUAGE="JavaScript">

//added from here

var ChatzyBoxDimensions = 'height:360px;width:480px;';
var ChatzyBoxStyle = 'background-color:gray;padding:10px;';
var ChatzyShadeStyle = 'background-color:#333333;opacity:0.75;filter:alpha(opacity=75);';
var ChatzyCloseImage = 'http://www.chatzy.com/elements/frame/close32.gif';
var ChatzyCloseStyle = 'top:-12px;right:-11px;';
function ChatzyObject (x) {
	with (document) { if (getElementById) { return getElementById (x); } else if (all) { return all (x); } else if (layers) { return layers (x); } }
}
function ChatzyOpen (x) {
	ChatzyObject ("ChatzyDiv").innerHTML = '<DIV style="position:absolute;top:0;left:0;height:100%;width:100%;z-index:9;' + ChatzyShadeStyle + '"></DIV><TABLE cellSpacing="0" style="position:absolute;top:0;left:0;height:100%;width:100%;z-index:9;"><TR><TD style="vertical-align:middle;text-align:center;"><DIV id="ChatzyBox" style="position:relative;margin:0 auto;' + ChatzyBoxDimensions + ChatzyBoxStyle + '"><IFRAME src="' + x + '" scrolling="no" border="0" marginwidth="0" frameborder="0" style="background-color:white;' + ChatzyBoxDimensions + '"></IFRAME><IMG id="ChatzyCloseImage" src="' + ChatzyCloseImage + '" onClick="window.ChatzyClose();" style="position:absolute;' + ChatzyCloseStyle + 'cursor:pointer;"></DIV></TD></TR></TABLE>';
	ChatzyObject ("ChatzyDiv").style.display = '';
}
function ChatzyClose () {
	ChatzyObject ("ChatzyDiv").style.display = 'none';
	ChatzyObject ("ChatzyDiv").innerHTML = '<IFRAME></IFRAME>';
}

// Upto here
    function getCookieVal (offset) {
      var endstr = document.cookie.indexOf (";", offset);
      if (endstr == -1)
      endstr = document.cookie.length;
      return unescape(document.cookie.substring(offset, endstr));
    }
    function GetCookie (name) {
      var arg = name + "=";
      var alen = arg.length;
      var clen = document.cookie.length;
      var i = 0;
      while (i < clen) {
      var j = i + alen;
      if (document.cookie.substring(i, j) == arg)
        return getCookieVal (j);
      i = document.cookie.indexOf(" ", i) + 1;
      if (i == 0) break; 
      }
      return null;
   }
   function SetCookie (name, value) {
      var argv = SetCookie.arguments;
      var argc = SetCookie.arguments.length;
      var expires = (argc > 2) ? argv[2] : null;
      var path = (argc > 3) ? argv[3] : null;
      var domain = (argc > 4) ? argv[4] : null;
      var secure = (argc > 5) ? argv[5] : false;
      document.cookie = name + "=" + escape (value) +
      ( (expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
      ((path == null) ? "" : ("; path=" + path)) +
      ((domain == null) ? "" : ("; domain=" + domain)) +
      ((secure == true) ? "; secure" : "" )
     }
    function DeleteCookie(name) {
        var exp = new Date();
       // FixCookieDate (exp); 
       exp.setTime (exp.getTime() - 1); 
       var cval = GetCookie (name);
       if (cval != null)
       document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString();
    }  
    function storage() {
		var c = prompt("Please enter in your name for storage purposes","")
		var thenewdate = new Date ();
		thenewdate.setTime(thenewdate.getTime() + (5*24*60*60*1000));
		SetCookie('yz',c,thenewdate);
    }

    function change() {
		var c = prompt("Please enter in your name for storage purposes","")
		var thenewdate = new Date ();
		thenewdate.setTime(thenewdate.getTime() + (5*24*60*60*1000));
		SetCookie('yz',c,thenewdate);
    }
	function storecookie(n,v) {
		//var c = prompt("Please enter in your name for storage purposes","")
		var thenewdate = new Date ();
		thenewdate.setTime(thenewdate.getTime() + (5*24*60*60*1000));
		SetCookie(n,v,thenewdate);
    }
	var logout=false;
	function logcookie() {
		logout=true;
		var hiddsid=window.document.getElementById("sid").value;
		DeleteCookie(hiddsid);

	}
	function checkcookie() {
		checking();
		var raj=1;
		if (raj==1 && logout==false){//infinite loop
			Id = window.setTimeout("checkcookie()",1000); 
		} 
		else{
			window.close();
		}	
	}
	function checking()
	{
		var time = new Date()
		var minutes = time.getSeconds();
		var hiddsid=window.document.getElementById("sid").value;
		if((minutes%20)==0)
		{
			var b = GetCookie(hiddsid)
			if (b == null) {
				window.top.location="/LBCOM/NoSession.html"
			}
		}
		
	}
</SCRIPT>
<%
	String uid="",tempuid="",schoolid="",tempschoolid="",sid="",tempsid="";
%>
<%
	uid=(String)session.getAttribute("emailid");
	schoolid=(String)session.getAttribute("schoolid");
	sid=session.getId();
	tempuid="\'"+uid+"\'";
	tempschoolid="\'"+schoolid+"\'";
	tempsid="\'"+sid+"\'";

%>
</head>
	<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" onload="checkcookie()">
	<DIV id="ChatzyDiv" style="display:none;"></DIV>
<A href="http://www.chatzy.com/frame/santhosh" onClick="ChatzyOpen(this.href);return false;">Click here to chat with me</A>
	<!-- <iframe name="imchat" src="http://220.227.250.172/chat/sampleb.php?userid=student1" width="100%" target="_parent" allowTransparency="true">
					</iframe> -->
		<SCRIPT LANGUAGE="JavaScript">
			//storecookie(<%=tempsid%>,<%=tempuid%>);
			document.cookie =" <%=sid%>=<%=uid%>";
		</SCRIPT>
		<input type="hidden" value="<%=sid%>" id="sid" name="sid">
		<input type="hidden" value="<%=uid%>" id="uid" name="uid">
		<input type="hidden" value="<%=schoolid%>" id="schoolid" name="schoolid">
	</body>
</html>
