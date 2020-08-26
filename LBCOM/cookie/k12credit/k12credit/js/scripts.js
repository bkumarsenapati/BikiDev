// <![CDATA[

$(function () {
	

	//##########################################
	// Nivo Slider
	//##########################################
	
	
	$(window).load(function() {
        $('#slider').nivoSlider();
    });
	
	//##########################################
	// Superfish
	//##########################################
	$("ul.sf-menu").superfish({ 
        animation: {height:'show'},   // slide-down effect without fade-in 
        delay:     200 ,              // 1.2 second delay on mouseout 
        autoArrows:  false,
        speed: 200
    });
	
	var arr_links = location.href.split('/');
	var length = arr_links.length;
	$('ul.sf-menu li').each(function () {
		if ($(this).children('a').attr('href') == arr_links[(length-1)]) {
			$(this).addClass('active');
			$(this).children('a').addClass('active');
			$(this).parents('li').addClass('active');
			$(this).parents('li').children('a').addClass('active');
		}
	})
	
	
	
	//##########################################
	// Mobile nav
	//##########################################

	selectnav('nav');
	
	//##########################################
	// preloader Photo
	//##########################################
	
	$("a[rel^='prettyPhoto']").prettyPhoto({
			social_tools: false,
		});
	

	$("#gallery, #gallery-imgs").preloader({not_preloader:'img.h, img.r_plus'});
	
	
	$().UItoTop();

});


  $(function() {

$('img.banner:hover').css({"-webkit-box-shadow": "2px 2px 2px 2px #ededed", "-moz-box-shadow":"2px 2px 2px 2px #ededed", "box-shadow":"2px 2px 2px 2px #ededed"});

$('.center_side_border').css({"border-radius":"5px", "-moz-border-radius":"5px", "-webkit-border-radius":"5px"});

$('#contactform input,#contactform textarea').css({"border-radius":"4px", "-moz-border-radius":"4px", "-webkit-border-radius":"4px"});
$('.small_box h2 img').css({"border-radius":"20px", "-moz-border-radius":"20px", "-webkit-border-radius":"20px"});

});	

// DC Twitter Settings
jQuery(function ($) {
    $("#ticker").tweet({
        username: "microsoft", // define your twitter username
        page: 1,
        avatar_size: 32, // avatar size in px
        count: 20, // how many tweets to show
        loading_text: "loading ..."
    }).bind("loaded", function () {
        var ul = $(this).find(".tweet_list");
        var ticker = function () {
                setTimeout(function () {
                    ul.find('li:first').animate({
                        marginTop: '-4em'
                    }, 500, function () {
                        $(this).detach().appendTo(ul).removeAttr('style');
                    });
                    ticker();
                }, 4000); // duration before next tick (4000 = 4 secs)
            };
        ticker();
    });
});
// DC Twitter Settings End 
 

// ]]>