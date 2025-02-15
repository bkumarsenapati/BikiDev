var pollPeriod = 60; // in seconds
var postPeriod = 180; // in seconds

var currentState = new Array();

var topRef = window.top.frames['topframe'];

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
 
// initialize currentState;

function initState() {
	
	currentState['study'] = 0;
	currentState['assessment'] = 0;
	currentState['assignment'] = 0;
	currentState['eclass'] = 0;
	currentState['chat'] = 0;
	currentState['other'] = 0;
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
	} else if (test_asgn()) {
		st = 'assignment';
		courseid = asgncid;
	} else if (test_study()) {
		st = 'study';
		courseid = studycid;
	}

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
	var URL="TeacherLogger.jsp?"+qStr+"&sessid="+sessid+"&schid="+schoolid+"&teachid="+teacherid+"&clid="+classid
	parent.frames['topframe'].frames['usage'].location.href =URL ;
	qStr = '';        
}
function test_study()
{	
        if(studycid=='other'){
	        return false;
    	} else if(temp=='study'){
      		return true;
    	} else if(teacherCourseMaterialWin!=null && !teacherCourseMaterialWin.closed)
			{
				return true;
    	}
       return false;    	  
}

function test_asgn()
{
	
         if(asgncid=='other'){
	             return false;
         } else if(temp=='assignment'){
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
        if(eclasscid=='other'){
			return false;
   	} else if(topRef.studenteClassRoomWin!=null && !topRef.studenteClassRoomWin.closed){
     		return true;
   	}
     	return false;
}

function test_chat()
{
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
