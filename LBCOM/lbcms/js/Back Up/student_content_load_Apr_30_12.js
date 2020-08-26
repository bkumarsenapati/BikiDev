//References
var loading = $("#loading");
var grid_content = $("#grid_content");
var grid_top = $("#grid_top");
var sections = $(".Sbuttons");
var right_content = $("#sform_content");	
$(document).ready(function(){  
  //Manage click events
  sections.click(function(){right_content_load(this.id)});	
  animatedcollapse.addDiv('Sform', 'fade=1,height=400px');
  animatedcollapse.addDiv('Cform', 'fade=1,height=640px');
animatedcollapse.ontoggle=function($, divobj, state){ //fires each time a DIV is expanded/contracted
	//$: Access to jQuery
	//divobj: DOM reference to DIV being expanded/ collapsed. Use "divobj.id" to get its ID
	//state: "block" or "none", depending on state
}
animatedcollapse.init();
$("#organizer_main").click();
});
function showLoading(type){if(type!= undefined && type =='right_menu'){loading .css({right:"250px"}) .css({top:"400px"})}else{loading .css({left:"400px"}) .css({top:"400px"})}loading .css({visibility:"visible"}) .css({opacity:"1"}) .css({display:"block"});}
//hide loading bar
function hideLoading(){loading.fadeTo(1000, 0, function(){loading .css({display:"none"});});};
function right_content_load(id, dataString){
	alert(id);
	alert(dataString);
if(id != undefined && id != null){if(dataString == undefined || dataString == null)dataString = '';else dataString = '?'+ dataString;
  showLoading('right_menu');
  switch(id){
	 	  
	  case "event_but":$("#sform_title").html('ADD EVENT');$("#nav_main li").removeClass('selected');grid_content.load("forms/event.html");right_content.load("forms/event.html"+dataString, hideLoading);break;
	  case "address_but":$("#sform_title").html('ADD ADDRESS BOOK');loadAddressbook();right_content.load("forms/addressbook.html"+dataString, hideLoading);break;
	  case "profile_but":$("#sform_title").html('ADD PROFILE');right_content.load("forms/profile.html"+dataString, hideLoading);break;
	  case "chat_but":$("#cform_content").load("../chat/chat.html"+dataString, hideLoading);animatedcollapse.show('Cform');return;
	  //case "email_but":$("#sform_title").html('EMAIL FORM');right_content.load("forms/email.html"+dataString, hideLoading);break;
	  case "email_but":$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/Commonmail/EmailMain.jsp", hideLoading);break;



	  //
	   case "notice_delete":$("#sform_title").html('Delete');$("#sform_content li").removeClass('selected');grid_content.load("forms/event.html");right_content.load("forms/event.html"+dataString, hideLoading);break;

	  //
	 
	  default:hideLoading();break;
  }
  animatedcollapse.show('Sform');
}
}
$("#organizer_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/student/CourseHomeMain.jsp", hideLoading);
});

//
$("#notice_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("grids/ShowNotices.jsp", hideLoading);
});

$("#notice_delete").click(function(){

	var checked = $('input[type=checkbox]:checked').val() != undefined;
	alert(checked);

$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("grids/ShowNotices.jsp", hideLoading);
});


/*
$("#privatedocs_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("grids/perdocs.jsp", hideLoading);
});
*/
$("#privatedocs_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/DMS/DMSMain.jsp?type=student", hideLoading);
});



$("#grade_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/grades/GradesMain.jsp", hideLoading);
});
$("#calendar_main").click(function(){
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/com/teacher/grids/calendar/StudentCalendarMain.jsp?type=student", hideLoading);
});

//

function loadAddressbook(){
$("#nav_main li").removeClass('selected');grid_content.load("grids/addressbook.html");
}