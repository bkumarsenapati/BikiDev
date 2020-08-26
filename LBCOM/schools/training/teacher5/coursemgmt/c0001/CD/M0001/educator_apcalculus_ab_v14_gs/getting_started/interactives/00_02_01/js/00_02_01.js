$(document).ready(function(){

// Animation of the glow class. Parameter is a jQuery object.
	var glow = function(elem){
		elem.animate({
			opacity: .2
		}, 1500, function(){
			elem.animate({
				opacity: 1
			}, 1500, glow(elem));}
		);
	}
	
	glow($('a.ui_custom_dialog_trigger'));
});