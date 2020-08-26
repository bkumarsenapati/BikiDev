

$(document).ready(function(){
	
	var url = "//cdn.flvsgl.com/cdn/latest/js/il/jquery-ui-1.8.21.custom.min.js";	
	importJs(url, function() {
		
			
		loadSitemap(createIndex);
		
		function createIndex(){
			//(FLVS.Sitemap);
			
			// Navigation Position
				var pos = $('#menu_inner').offset();
				$('#nav_menu').css('left',pos.left+'px');
				
				// Position Popup Menu
				$(window).bind('resize',function(){
					var pos = $('#menu_inner').offset();
					$('#nav_menu').css('left',pos.left+'px');
				});
				
				// Create Popup Menu
				createMenu();
				
				// Create Menu items on the right side of the page
				createRightMenu();
				
				// Create accordion for iPhone version
				createRightMenuMobile();
					
				    var activeAccordian = null;
					var $accordions = $(".accordion").on('click', function() {
						activeAccordian = this;
						}).accordion({
							autoHeight: false,
							clearStyle: true,
							active: false,
							collapsible: true
						}).on('accordionchange', function(event, ui) {
							$accordions.not(activeAccordian).accordion('activate', false);
		 			});
		
				//show content
				
				
				// Event for Menu Button
				$('.menubtn, .menubtn_mobile').click(function(){
						$('.nav_menu_lessons').hide();
						
						if(!$('#nav_menu').is(':visible')){
								$('body').append('<div class="menu_backdrop">&nbsp;</div>');
								$('.menu_backdrop').click(function(){
								$('#nav_menu').fadeToggle('fast');
								$(this).remove();
							});
						} 
						else {
							$('.menu_backdrop').remove();
						}
						
						var pos = $('#menu_inner').offset();
						$('#nav_menu').css('left',pos.left+'px').css('margin-top','20px');
						$('#nav_menu').fadeToggle('fast');
				});
				
				// Event for Showing Menu Lessons
				$('.modlink').click(function(){
					$('.nav_menu_lessons').hide();
					$(this).next().stop().fadeIn('fast');
				});
				
				$('h3').click(function(){
					$('h3').removeClass('turned_arrow');
					clickedLink = $(this).find('a').attr('id');
					lastMobileLink ='';
					
					if ($('#right_col').data('lastMobileLink')) {
						lastMobileLink = $('#right_col').data('lastMobileLink');
						
					}
					else {
						$(this).addClass('turned_arrow');
					}

					if (lastMobileLink == clickedLink) {
						$(this).removeClass('turned_arrow');
						lastMobileLink = '';
						$('#right_col').data('lastMobileLink', lastMobileLink)
					}

					else {
						$(this).addClass('turned_arrow');
						lastMobileLink = $(this).find('a').attr('id');
						$('#right_col').data('lastMobileLink', lastMobileLink);
					}
				});
				
				//event for clicking on the segment 1 menu on the right
				$('.seg1 li').click(function(e) {
					e.stopPropagation();
					
					//gets which index of the link that was clicked and passes to create the correct lesson
					var i = $(this).index()+1;
					createLessons(i);
					
					//grabs and stores the id of the link and the link as an object
					clickedLink = $(this).find('a').attr('data');
					clickedLinkObject = $(this).find('a');
					
					//if the user isn't clicking on the same link, position and display the lessons
					lastLink = "";
					
					if ($('#right_col').data('lastLink')) {
						lastLink = $('#right_col').data('lastLink');
					}
					if (lastLink == clickedLink) {
						if($('#submenu').is(":visible")) {
						}
						else {
							lessonPos(clickedLink, clickedLinkObject);
						}
					}
					else {
						lessonPos(clickedLink, clickedLinkObject);
					}
					
					$('#right_col').data('lastLink', clickedLink);
					
				});
				
				//event for clicking on the segment 2 menu on the right
				$('.seg2 li').click(function(e) {
					e.stopPropagation();
					
					//gets which index of the link that was clicked and passes to create the correct lesson
					var i = $(this).index()+5;
					createLessons(i);
					
					//grabs and stores the id of the link and the link as an object
					clickedLink = $(this).find('a').attr('data');
					clickedLinkObject = $(this).find('a');
					
					//if the user isn't clicking on the same link, position and display the lessons
					lastLink = "";
					
					if ($('#right_col').data('lastLink')) {
						lastLink = $('#right_col').data('lastLink');
					}
					if (lastLink == clickedLink) {	
						if($('#submenu').is(":visible")) {
						}
						else {
							lessonPos(clickedLink, clickedLinkObject);
						}
					}
					else {
						lessonPos(clickedLink, clickedLinkObject);
					}
					$('#right_col').data('lastLink', clickedLink);
				});
				
				//event for clicking on the getting started menu on the right
				/*$('#gs').click(function(e) {
					e.stopPropagation();
					
					//gets which index of the link that was clicked and passes to create the correct lesson
					var i = 0;
					createLessons(i);
					
					//grabs and stores the id of the link and the link as an object
					clickedLink = $(this).find('a').attr('id');
					clickedLinkObject = $(this).find('a');
					
					//if the user isn't clicking on the same link, position and display the lessons
					lastLink = "";
					
					if ($('#right_col').data('lastLink')) {
						lastLink = $('#right_col').data('lastLink');
					}
					
					if (lastLink == clickedLink) {
						if($('#submenu').is(":visible")) {
						}
						else {
							lessonPos(clickedLink, clickedLinkObject);
						}
					}
					else {
						lessonPos(clickedLink, clickedLinkObject);
					}
					$('#right_col').data('lastLink', clickedLink);
				});*/
		}
		
		//if there is a stray document click, close the submenu if it's open
		$(document).click(function (e) {
			if($('#submenu').is(":visible")) {
				$('#submenu').fadeToggle("fast");
				$('.arrow').fadeToggle("fast");
			}
			
		});
		
		//create the drop down menu
		function createMenu(){
		var menuNames = new Array;
		menuNames = ['Getting Started','Module One','Module Two','Module Three','Module Four','Module Five','Module Six','Module Seven','Module Eight','Module Nine','Module Ten','Module Eleven','Module Twelve'];
		var menu = '<ul class="nav_menu_modules">';
		for(var i=0; i<FLVS.Sitemap.module.length; i++){
			if (FLVS.Sitemap.module[i].visible == 'true') {
				menu += '<li>';/*'<span class="modnum">MOD '+(i+1)+'</span>'+*/
				menu += '<a href="javascript:void(0);" class="modlink">'+menuNames[i]+'</a>';
				
				// Lessons
				menu += '<ul class="nav_menu_lessons mod'+(i + 1)+'">';
				var submenu = '';
				for(var j=0; j<FLVS.Sitemap.module[i].lesson.length; j++){
					var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
					links = links.substr(3,999);
	
					var img = FLVS.Sitemap.module[i].lesson[j].thumb;
					
					if(img == '' || typeof img === 'undefined'){
						img = '';
					} else {
						img = '<img src="global/images/lesson_thumbs/'+img+'"/>';
					}
					
					submenu += '<li>';
					
					if(j == 0 || j== 2 || j==4 || j== 6 || j== 8 || j== 10 || j== 12){
						submenu += '<a href="'+links+'">'+img+'<span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+'</span>';
					} else {
						submenu += '<a href="'+links+'" class="odd">'+img+'<span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+'</span>';
					}
					
					var minutes = "mins";
					if(Number(FLVS.Sitemap.module[i].lesson[j].time) < 2){
						minutes = "min";
					}
					var points = "pts";
					if(Number(FLVS.Sitemap.module[i].lesson[j].points) < 2){
						points = "pt";
					}
					
					//submenu += '<span class="lesson_title">'+FLVS.Sitemap.module[i].lesson[j].title+'</span></a>';
					//submenu += '</a></li>';
					
					submenu += '<span class="lesson_title">'+FLVS.Sitemap.module[i].lesson[j].title+'</span><span class="lesson_nfo">'+FLVS.Sitemap.module[i].lesson[j].time+' '+minutes+' | '+FLVS.Sitemap.module[i].lesson[j].points+' '+points+'</span></a>';
					submenu += '</li>';
				}
				menu += submenu;
				menu += '</ul></li>';
			}else {menu +='';}}
			menu += '</ul>';
	
			//(menu);
			// Remove all modlinks from nav_menu_lessons
			$('#nav_menu').append(menu);
		}
		
		//create the menu in the right-hand column				
		function createRightMenu(){
			
			//Segment 1
			var menu = '<ul class="right_menu_modules seg1">';
			for(var i=1; i<=4; i++){
				numCount=i;
				if (FLVS.Sitemap.module[i].visible == 'true') {
					if(i<4){
						menu += '<li><a href="javascript:void(0);" data="'+FLVS.Sitemap.module[i].title+'" class="right_mod_link bottom_line"><strong>0'+numCount+': </strong>'+FLVS.Sitemap.module[i].title+'</a></li>';
						}
						
						//last link in the list
						else {
							menu += '<li><a href="javascript:void(0);" data="'+FLVS.Sitemap.module[i].title+'" class="right_mod_link"><strong>0'+numCount+': </strong>'+FLVS.Sitemap.module[i].title+'</a></li>';
					}
				}
			}
			menu += '</ul>';
			
			// Remove all modlinks from nav_menu_lessons
			$('#right_menu_seg1').append(menu);
			$('.nav_menu_lessons .modlink').remove();
			
			//Segment 2
			var menu = '<ul class="right_menu_modules seg2">';
			if (FLVS.Sitemap.module.length >=6){
				for(var i=5; i<=9; i++){
					numCount=i;
					
						if(i<9){
							menu += '<li><a href="javascript:void(0);" data="'+FLVS.Sitemap.module[i].title+'" class="right_mod_link bottom_line"><strong>0'+numCount+': </strong>'+FLVS.Sitemap.module[i].title+'</a></li>';
						}
						
						//last link in the list
						else {
							menu += '<li><a href="javascript:void(0);" data="'+FLVS.Sitemap.module[i].title+'" class="right_mod_link"><strong>0'+numCount+': </strong>'+FLVS.Sitemap.module[i].title+'</a></li>';
						}
			
				}
			}
			menu += '</ul>';
			
			// Remove all modlinks from nav_menu_lessons
			$('#right_menu_seg2').append(menu);
		}
						
		//position and animate the lesson submenu
		function lessonPos(clickedLink, clickedLinkObject) {
			
			//hide the arrow that points to the mod
			$('.arrow').hide();	

				linkPosition = clickedLinkObject.offset();
				linkTop = linkPosition.top;
				centerHeight = linkPosition.top -(($('#submenu').height())/2)-22;
				totalHeight = linkTop + $('#submenu').height()
				
				
				//if it's going to place the lesson menu too high, move it down to 78 pixels
				if (centerHeight<78) {
					centerHeight=78;
				}
				
				//if it's going to be place the lesson menu too low, move it up to 730px
				if (totalHeight > 764) {
					while (totalHeight > 764) {
						linkTop--;
						totalHeight = linkTop + $('#submenu').height();
					}
					
					centerHeight = linkTop -(($('#submenu').height())/2)+22;
				}

				//if it's the getting started mod, position the arrow a little differently
				
				//set the new margin-top for the submenu
				$('#submenu').css({'margin-top':centerHeight});
					
				//animate in the submenu and then the arrow

				$('#submenu').show('clip', 100).effect( 'bounce', { times: 2, distance:10}, 70 );
				$('.arrow').delay(100).effect( 'slide', { direction: 'left', distance:10}, 70 );
		};
		
		function createRightMenuMobile(){
			
			//Segment 1
			var menu = '';
			for(var i=1; i<=4; i++){

			if (FLVS.Sitemap.module[i].visible == 'true') { // JP added 10/15/2013
				if(i<4){
					menu += '<h3 class="right_mod_link bottom_line"><a class="mobile_mod" href="javascript:void(0);"> <strong>0'+i+': </strong>'+FLVS.Sitemap.module[i].title+'</a></h3>';
				}
				
				//last link in the list
				else {
					menu += '<h3><a class="mobile_mod" href="javascript:void(0);"> <strong>0'+i+': </strong>'+FLVS.Sitemap.module[i].title+'</a><h3>';
				}
				
				menu += '<div>';
				menu += '<ul class="mobile_lesson">';

				for(var j=0; j<FLVS.Sitemap.module[i].lesson.length; j++){
					if (j==FLVS.Sitemap.module[i].lesson.length-1) {
				
						var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
						links = links.substr(3,999);
				
						menu += '<li>';
						menu += '<a href="'+links+'"><span class="lesson_num"> <strong>'+i+': </strong>'+FLVS.Sitemap.module[i].lesson[j].num+' </span>';
						menu += FLVS.Sitemap.module[i].lesson[j].title+'</a>';
					menu += '</li>';
					}
					else {
						var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
						links = links.substr(3,999);
				
						menu += '<li>';
						menu += '<a class="bottom_line" href="'+links+'"><span class="lesson_num"> <strong>'+i+': </strong>'+FLVS.Sitemap.module[i].lesson[j].num+' </span>';
						
						
					menu += FLVS.Sitemap.module[i].lesson[j].title+'</a>';
					menu += '</li>';
					}
						
				}
					menu += '</ul>';
					menu += '</div>';
				}
			} // JP added 10/15/2013
			// Remove all modlinks from nav_menu_lessons
			$('#right_menu_seg1_mobile').append(menu);
			
			//Segment 2
			var menu = '';
			var menu = '';
			for(var i=5; i<=9; i++){
				if(i<9){
					menu += '<h3 class="right_mod_link bottom_line"><a class="mobile_mod" href="javascript:void(0);"><strong>0'+i+': </strong>'+FLVS.Sitemap.module[i].title+'</a></h3>';
				}
				
				//last link in the list
				else {
					menu += '<h3><a class="mobile_mod" href="javascript:void(0);"><strong>0'+i+': </strong>'+FLVS.Sitemap.module[i].title+'</a><h3>';
				}
				
				menu += '<div>';
				menu += '<ul class="mobile_lesson">';

				for(var j=0; j<FLVS.Sitemap.module[i].lesson.length; j++){
					if (j==FLVS.Sitemap.module[i].lesson.length-1) {
				
						var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
						links = links.substr(3,999);
				
						menu += '<li>';
						menu += '<a href="'+links+'"><span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+' </span>';
						menu += FLVS.Sitemap.module[i].lesson[j].title+'</a>';
					menu += '</li>';
					}
					else {
						var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
						links = links.substr(3,999);
				
						menu += '<li>';
						menu += '<a class="bottom_line" href="'+links+'"><span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+' </span>';
						
						
					menu += FLVS.Sitemap.module[i].lesson[j].title+'</a>';
					menu += '</li>';
					}
						
				}
					menu += '</ul>';
					menu += '</div>';
				}
				
		
			
			// Remove all modlinks from nav_menu_lessons
			$('#right_menu_seg2_mobile').append(menu);
		}
						
		//position and animate the lesson submenu
		function lessonPos(clickedLink, clickedLinkObject) {
		
			//hide the arrow that points to the mod
			$('.arrow').hide();	

			linkPosition = clickedLinkObject.offset();
			linkTop = linkPosition.top;
			centerHeight = linkPosition.top - (($('#submenu').height())/2)-37;
			totalHeight = linkTop + $('#submenu').height();
			
			
			//if it's going to place the lesson menu too high, move it down to 78 pixels
			if (centerHeight < 41) {
				centerHeight = 41;
			}
			//if it's going to be place the lesson menu too low, move it up
			if (totalHeight > 700 && linkTop >=460) {
				centerHeight = 600-$('#submenu').height();
			}
			
			$('#submenu').css({'margin-top':centerHeight});
			//position the arrow
			$('.arrow').css({'margin-top':linkPosition.top-45});
		
			//set the new margin-top for the submenu
			
				
			//animate in the submenu and then the arrow

			$('#submenu').show('clip', 100).effect( 'bounce', { times: 2, distance:10}, 70 );
			$('.arrow').delay(100).effect( 'slide', { direction: 'left', distance:10}, 70 );
		};
		
		
		
		//build the lesson menus
		function createLessons(i){
			var menu = '<ul class="lessons">';
		
			for(var j=-1; j<FLVS.Sitemap.module[i].lesson.length; j++){
				if (j==-1) {
					menu += '<li class="bottom_line"></li>';
				}
				else {
					var links = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
					links = links.substr(3,999);
			
					menu += '<li>';
					if (FLVS.Sitemap.module[i].lesson[j].num) {
						menu += '<a class="bottom_line" href="'+links+'"><span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+' </span>';
					}
					else {
						menu += '<a class="bottom_line" href="'+links+'">';
					}
					
					menu += FLVS.Sitemap.module[i].lesson[j].title+'</a>';
					menu += '</li>';
				}
			}
			
			menu += '</ul>';
			$('#submenu').html(menu);
		}
	});
	
	$(window).bind('resize',function(){
			$('h3').removeClass('turned_arrow');
			$('#submenu').fadeOut("fast");
			$('.arrow').fadeOut("fast");
			$('#right_menu_seg1_mobile').accordion('activate',false);
			$('#right_menu_seg2_mobile').accordion('activate',false);
			
			if ( $('#right_col').data('lastMobileLink') ) {
				lastMobileLink = $('#right_col').data('lastMobileLink');
				$(lastMobileLink).removeClass('turned_arrow');
			}
		});
		
		
	$('html').fadeIn(1000);
});