if (!Array.indexOf) {
  Array.prototype.indexOf = function (obj, start) {
    for (var i = (start || 0); i < this.length; i++) {
      if (this[i] == obj) {
        return i;
      }
    }
    return -1;
  }
}

function passThroughToSF (ltiLocation) {
    callingURL = encodeURIComponent(parent.document.URL);
    ltiURL = encodeURIComponent('http://tool.studyforge.net/lti.php?resource_type=lesson&resource_id=' + ltiLocation);
	
    newlocation = '../sfframe.htm?loc=' + callingURL + '&ltiloc=' + ltiURL;
    var myWindow = window.open(newlocation);
}

$(document).ready(function(){
	
		var isInIframe = (window.location != window.parent.location) ? true : false;
		if(isInIframe){
			$('a').each(function(){
					if($(this).html() == 'Close X'){
						
						$(this).parent('.closelink').remove();
						
					}
			});
		}
	
	
	if(typeof isexternal === 'undefined' && typeof islearningobject === 'undefined'){
		// content BG images
		var content_bg = '../global/images/'+FLVS.Sitemap.module[current_module].bg;
		if(window.location.href.indexOf("checklist") >= 0){
			$('#container').css('background-image','url('+content_bg+')');
		} else {
			var img = FLVS.Sitemap.module[current_module].bg;
			//img = img.split(".");
			//img = img[0] + "_lesson." + img[1];
			$('#container').css('background-image','url(../global/'+img+')');
		}
		// breadcrumbs. yummy
		$('.breadcrumbs_course').html(FLVS.settings.course_title);
		$('.breadcrumbs_module').html(FLVS.Sitemap.module[current_module].title);
		
		// Navigation Position
		//var pos = $('#menu_inner').offset();
		//$('#nav_menu').css('left',pos.left+'px');
		//console.log($('#menu_inner').offset());
		
		$(window).bind('resize',function(){
			var pos = $('#menu_inner').offset();
			$('#nav_menu').css('left',pos.left+'px');
			
		});
		
		// run menu function
		createMenu();
		
		$('.menubtn, .menubtn_mobile').click(function(){
				$('.nav_menu_lessons').hide();
				
				
				if(!$('#nav_menu').is(':visible')){
					$('body').append('<div class="menu_backdrop">&nbsp;</div>');
					$('.menu_backdrop').click(function(){
							$('#nav_menu').fadeToggle('fast');
							$(this).remove();
					});
				} else {
							$('.menu_backdrop').remove();
				}
				var pos = $('#menu_inner').offset();
				$('#nav_menu').css('left',pos.left+'px');
				$('#nav_menu').fadeToggle('fast');
				
				
		});
		
		$('.modlink').click(function(){
			$('.nav_menu_lessons').hide();
			$(this).next().stop().fadeIn('fast');
		});
		
	}
	
	$('.home').html('Home');
	
	$('.image-container').each(function(){
		$(this).find('span.copyright').insertAfter($(this).find('span.caption'));
				var imgsize = $(this).find('img').width();
				$(this).find('span.copyright').css('max-width',(imgsize - 30) + 'px');
				$(this).find('span.caption').css('max-width', (imgsize - 30) + 'px');
	});

	
	
});


function createMenu(){
	var menuNames = new Array;
	menuNames = ['Getting Started','Module One','Module Two','Module Three','Module Four','Module Five','Module Six','Module Seven','Module Eight','Module Nine','Module Ten','Module Eleven','Module Twelve'];
	var menu = '<ul class="nav_menu_modules">';
	for(var i=0; i<FLVS.Sitemap.module.length; i++){
			menu += '<li>';
			menu += '<a href="javascript:void(0);" class="modlink">'+menuNames[i]+'</a>';
			
			// Lessons
			menu += '<ul class="nav_menu_lessons mod'+(i + 1)+'">';
			var submenu = '';
			for(var j=0; j<FLVS.Sitemap.module[i].lesson.length; j++){
				var link = FLVS.Sitemap.module[i].lesson[j].section[0].page[0].href;
				submenu += '<li>';
				if(j == 0 || j== 2 || j==4 || j== 6 || j== 8 || j== 10 || j== 12){
					submenu += '<a href="'+link+'"><span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+'</span>';
				} else {
					submenu += '<a href="'+link+'" class="odd"><span class="lesson_num">'+FLVS.Sitemap.module[i].lesson[j].num+'</span>';
				}
				
				var minutes = "mins";
				if(Number(FLVS.Sitemap.module[i].lesson[j].time) < 2){
					minutes = "min";
				}
				var points = "pts";
				if(Number(FLVS.Sitemap.module[i].lesson[j].points) < 2){
					points = "pt";
				}
				
				submenu += '<span class="lesson_title">'+FLVS.Sitemap.module[i].lesson[j].title+'</span><span class="lesson_nfo">'+FLVS.Sitemap.module[i].lesson[j].time+' '+minutes+' | '+FLVS.Sitemap.module[i].lesson[j].points+' '+points+'</span></a>';
  				submenu += '</li>';
			}
			menu += submenu;
			menu += '</ul>';
			
			menu += '</li>';
	}
	menu += '</ul>';
	
	// Remove all modlinks from nav_menu_lessons
	$('#nav_menu').append(menu);
	$('.nav_menu_lessons .modlink').remove();
}
				
		