<!-- MathResources Graphing tool scripts

isWindow=false;
child=null;

function centerWindow() {
	var xMax = screen.width, yMax = screen.height;
	<!-- Calculate Center /-->
	if ( navigator.appName == "Netscape" ) {
		var xOffset = (xMax - window.outerWidth)/2, yOffset = (yMax - window.outerHeight)/2; 
	}
	else{
		var xOffset = (xMax - document.body.offsetWidth)/2, yOffset = (yMax - document.body.offsetHeight)/2; 
	}
	self.moveTo(xOffset,yOffset);
	<!-- Set Minimize on time out /-->
	window.focus();
	idTimer=setTimeout('window.blur()',10000);
}

function openFunctionPlotWindow() {
   if(!isWindow || child.closed) {
      child=window.open("../../Plots/FunctionPlot.htm",'theWin','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=500,height=150,top=0,left=0');
      isWindow=true;
   }
   else{
      child.focus();
   }
}
function openScatterPlotWindow() {
   if(!isWindow || child.closed) {
      child=window.open("../../Plots/ScatterPlot.htm",'theWin','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=500,height=150,top=0,left=0');
      isWindow=true;
   }
   else{
      child.focus();
   }
}

function openRegressionPlotWindow() {
   if(!isWindow || child.closed) {
      child=window.open("../../Plots/RegressionPlot.htm",'theWin','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=500,height=150,top=0,left=0');
      isWindow=true;
   }
   else{
      child.focus();
   }
}

//-->
