$('document').ready(function (){
// initThemeRoller();

animatedcollapse.addDiv('assmtDiv', 'fade=1')

animatedcollapse.ontoggle=function($, divobj, state){ //fires each time a DIV is expanded/contracted
	//$: Access to jQuery
	//divobj: DOM reference to DIV being expanded/ collapsed. Use "divobj.id" to get its ID
	//state: "block" or "none", depending on state
}

animatedcollapse.init()


});

function initMethods() {
	// do nothing now
}

function initThemeRoller() {	
	$("#theme_selector").change(function() {
		var theme = $(this).val();
		var loader = $("#jquery_ui_theme_loader");
		loader.attr("href", "js/jquery/themes/"+theme+"/jquery-ui.css");
	});
}

function createWindowWithBoundary1(parentElmId) {
	if( parentElmId != null ) {
		var iconUrl = 'http://mail.google.com/favicon.ico';
		if( parentElmId == 'my_boundary_panel2' ) {
			iconUrl = 'https://picasaweb.google.com/favicon.ico';
		}
		$("#"+parentElmId).window({
			icon: iconUrl,
			title: "This window only can be dragged within its parent element",
			content: "<div style='padding:10px; font-weight:bold;'>I only can be dragged within my boss...@@</div>",
			checkBoundary: true,
			width: 200,
			height: 160,
			maxWidth: 400,
			maxHeight: 300,
			x: 80,
			y: 80,
			onSelect: function(wnd) { //  a callback function while user select the window
				log('select');
			},
			onUnselect: function(wnd) { // a callback function while window unselected
				log('unelect');
			}
		});
	} else {
		
		$.window({
			//icon: 'http://www.fstoke.me/favicon.ico',
			title: "Assessment Archives",
			content: $('#window_block22').html(),
			checkBoundary: true,
			width: 720,
			height: 460,
			x: 200,
			y: 80,
			z: 2100
		});
	}
}









			$(document).ready( function() {



				//

				// Enable selectBox control and bind events

				//



				$("#create").click( function() {

					$("SELECT").selectBox();

				});



				$("#destroy").click( function() {

					$("SELECT").selectBox('destroy');

				});



				$("#enable").click( function() {

					$("SELECT").selectBox('enable');

				});



				$("#disable").click( function() {

					$("SELECT").selectBox('disable');

				});



				$("#serialize").click( function() {

					$("#console").append('<br />-- Serialized data --<br />' + $("FORM").serialize().replace(/&/g, '<br />') + '<br /><br />');

					$("#console")[0].scrollTop = $("#console")[0].scrollHeight;

				});



				$("#value-1").click( function() {

					$("SELECT").selectBox('value', 1);

				});



				$("#value-2").click( function() {

					$("SELECT").selectBox('value', 2);

				});



				$("#value-2-4").click( function() {

					$("SELECT").selectBox('value', [2, 4]);

				});



				$("#options").click( function() {

					$("SELECT").selectBox('options', {



						'Opt Group 1': {

							'1': 'Value 1',

							'2': 'Value 2',

							'3': 'Value 3',

							'4': 'Value 4',

							'5': 'Value 5'

						},

						'Opt Group 2': {

							'6': 'Value 6',

							'7': 'Value 7',

							'8': 'Value 8',

							'9': 'Value 9',

							'10': 'Value 10'

						},

						'Opt Group 3': {

							'11': 'Value 11',

							'12': 'Value 12',

							'13': 'Value 13',

							'14': 'Value 14',

							'15': 'Value 15'

						}



					});

				});



				$("#default").click( function() {

					$("SELECT").selectBox('settings', {

						'menuTransition': 'default',

						'menuSpeed' : 0

					});

				});



				$("#fade").click( function() {

					$("SELECT").selectBox('settings', {

						'menuTransition': 'fade',

						'menuSpeed' : 'fast'

					});

				});



				$("#slide").click( function() {

					$("SELECT").selectBox('settings', {

						'menuTransition': 'slide',

						'menuSpeed' : 'fast'

					});

				});





				$("SELECT")

					.selectBox()

					.focus( function() {

						$("#console").append('Focus on ' + $(this).attr('name') + '<br />');

						$("#console")[0].scrollTop = $("#console")[0].scrollHeight;

					})

					.blur( function() {

						$("#console").append('Blur on ' + $(this).attr('name') + '<br />');

						$("#console")[0].scrollTop = $("#console")[0].scrollHeight;

					})

					.change( function() {

						$("#console").append('Change on ' + $(this).attr('name') + ': ' + $(this).val() + '<br />');

						$("#console")[0].scrollTop = $("#console")[0].scrollHeight;

					});



			});



<!-- Script to Hide Content Area -->

function toggle(element) {
	
	document.getElementById(element).style.display = (document.getElementById(element).style.display == "none") ? "" : "none";	
}

function spawnwindow(element) {
    //document.getElementById(element).style.display = 'block';
	document.getElementById(element).style.display = (document.getElementById(element).style.display == "none") ? "" : "none";	
}
