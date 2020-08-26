var pollPeriod = 60; // in seconds
var postPeriod = 180; // in seconds

var currentState = new Array();

var topRef = window.top.frames['studenttopframe'];

var temp = 'other';
var eclasscid = 'other';
var chatcid = 'other';
var asmtcid = 'other';
var asgncid = 'other';
var studycid = 'other';
var qStr = '';
var postVar = 0;
var fpv = 0;
var spv = 0;
var courseval;
var assgnval;
var assmtval;

//
	
//

// initialize currentState;

function initState() {
	currentState['study'] = 0;
	currentState['assessment'] = 0;
	currentState['assignment'] = 0;
	currentState['eclass'] = 0;
	currentState['chat'] = 0;
	currentState['other'] = 0;
	//alert(courseval);
}

function pollState() {
	
	var st = 'other';
	var courseid = 'other';
	
	
        initState();
        postVar++;	

    if (test_eclass()) {
		st = 'eclass';
		courseid = eclasscid;
	} else if (test_chat()) {
		st = 'chat';
		courseid = chatcid;
	} else if (test_asmt()) {
		st = 'assessment';
		courseid = asmtcid;
	} else if (test_study()) {
		st = 'study';
		courseid = studycid;
		
		//alert("else if study.."+courseid)
	}else if (test_asgn()) {
		st = 'assignment';
		courseid = asgncid;
	} 
	
	 
	  /*
	  
	  if (test_eclass()) {
		st = 'eclass';
		courseid = eclasscid;
	} 
	if (test_chat()) {
		st = 'chat';
		courseid = chatcid;
	} 
	if (test_asmt()) {
		st = 'assessment';
		courseid = asmtcid;
	} 
	if (test_study()) {
		st = 'study';
		courseid = studycid;
		//alert("else if study.."+courseid)
	}
	if (test_asgn()) {
		st = 'assignment';
		courseid = asgncid;
	} 
*/
	currentState[st] = pollPeriod;
	if(qStr==''){
                    qStr = courseid + '=' + Math.round(currentState['study']/60) +
			   '_' + Math.round(currentState['assessment']/60) +
			   '_' + Math.round(currentState['assignment']/60) +
			   '_' + Math.round(currentState['eclass']/60) +
			   '_' + Math.round(currentState['chat']/60) +
			   '_' + Math.round(currentState['other']/60);	
	} else {
	          qStr = qStr + '&' + courseid + '=' + Math.round(currentState['study']/60) +
			                         '_' + Math.round(currentState['assessment']/60) +
			                         '_' + Math.round(currentState['assignment']/60) +
			                         '_' + Math.round(currentState['eclass']/60) +
			                         '_' + Math.round(currentState['chat']/60) +
			                         '_' + Math.round(currentState['other']/60);
	}
       	
       if((postVar%3)==1)
        {    
	 	if(fpv==0)
       		{
            		qStr = qStr + '&other=0_0_0_0_0_1';
            		fpv++;
       		}else if(spv==0)
       		{
            		qStr = qStr + '&other=0_0_0_0_0_1';
            		spv++;
       		}
	    	postState();
         }      
}

function postState() {
	//alert("before..poststate");
	//alert(qStr);
	var URL="Logger.jsp?"+qStr+"&sessid="+sessid+"&schid="+schoolid+"&stuid="+studentid+"&clid="+classid
	//parent.frames['studenttopframe'].frames['usage'].location.href =URL ;
	frames['usage'].location.href =URL ;
	qStr = '';  
	
	
	
}
function test_study()
{
	//alert("test_study");
	courseval=parent.frames['left'].studycid;
	//alert(courseval);
	if(courseval!=undefined && courseval!='')
	{
	if (courseval.indexOf('c') !=-1)
	{
		//alert("/ matched in else");
		studycid=courseval;
		temp='study';
	}
	}
	else
	{
		courseval="other";
		return false;
	}
	    if(studycid=='other'){
			//alert("other");
	        return false;
    	} else if(temp=='study'){
			//alert("study");
      		return true;
    	} else if(parent.parent.studenttopframe.studentViewMatWin!=null && !parent.parent.studenttopframe.studentViewMatWin.closed){
      		return true;
    	}
       return false;    	  
	
}

function test_asgn()
{
	
		//alert("test_asgn");
		assgnval=parent.frames['left'].asgncid;
		if(assgnval!=undefined && assgnval!='')
		{
		if (assgnval.indexOf('c') !=-1)
		{
			//alert("/ matched in assgn");
			asgncid=assgnval;
			temp='assignment';
		}
		}
		else
		{
			assgnval="other";
			return false;
		}

         if(asgncid=='other'){
	             return false;
         } else if(temp=='assignment'){
			 //alert("assignment");
	             return true;
	 } else if(topRef.stuAsgnHtmlEditorWin!=null && !topRef.stuAsgnHtmlEditorWin.closed){
	             return true;
	 } else if(topRef.stuAsgnAttemptsWin!=null && !topRef.stuAsgnAttemptsWin.closed){
	             return true;
	 } else if(topRef.stuAsgnAttemptsFileWin!=null && !topRef.stuAsgnAttemptsFileWin.closed){
	             return true;
	 }
	return false;	
}

function test_asmt()
{
	//alert("test_asmt");
	assmtval=parent.frames['left'].asmtcid;
		if(assmtval!=undefined && assmtval!='')
		{
		if (assmtval.indexOf('c') !=-1)
		{
			//alert("/ matched in assmt");
			asmtcid=assmtval;
			temp='assessment';
		}
		}
		else
		{
			assmtval="other";
			return false;
		}
         if(asmtcid=='other'){
	             return false;
         } else if(temp=='assessment'){
	             return true;
	 } else if(topRef.studentExamWin!=null && !topRef.studentExamWin.closed){
	             return true;
	 } else if(topRef.stuExamHistoryWin!=null && !topRef.stuExamHistoryWin.closed){
	             return true;
	 }
	 return false;
}

function test_eclass()
{
	//alert("test_eclass");
        if(eclasscid=='other'){
	        return false;
   	} else if(topRef.studenteClassRoomWin!=null && !topRef.studenteClassRoomWin.closed){
     		return true;
   	}
     	return false;
}

function test_chat()
{
	//alert("test_chat");
        if(chatcid=='other'){
	        return false;
   	}
	else if(temp=='chat'){
	             return true;
	}	
	else if(topRef.studentChatWin!=null && !topRef.studentChatWin.closed){
     		return true;
   	}
     	return false;  
}

// setInterval takes time in milliseconds!
var intvPoll = setInterval('pollState()', pollPeriod*1000);
