function noChars(e)   // Not to allow the characters and pressing 'enter button' in the marks field. Allows numbers and . only
{
  var keynum;
  var keychar;
  var numcheck;
  
  if(window.event) // IE
  {     
	  keynum = e.keyCode;  
  }
  else if(e.which) // Netscape/Firefox/Opera
  {
	  keynum = e.which;  
  }

  keychar = String.fromCharCode(keynum);
  if(keychar!='.')
  {
     numcheck = /\d/;
     return numcheck.test(keychar);
  }
}

function checkMarked(obj,qId,qType)
{
	var q=frm.elements[qId];
	if(qType==0 || qType==1 || qType==2)
	{
		if (obj.checked==false)
		{
			if(confirm("Are you sure that you don't want to submit this answer?")==true)
			{
				for(var i=0;i<q.length;i++)
					q[i].checked=false;						
			}
			else
				obj.checked=true;
		}
		else
		{
			var flag=false;
			for(var i=0;i<q.length;i++)
			if(q[i].checked==true)
			{
				flag=true;
				break;
			}
			if (flag==false)
			{
				alert("You have not answered this question.");
				obj.checked=false;
			}	
		}	
	}
	else if (qType==4 || qType==5)
	{
		if (obj.checked==false)
		{
			if(confirm("Are you sure that you don't want to submit this answer?")==true)
				for(var j=0;j<q.length;j++)
					q[j].value='';
			else
				obj.checked=true;
		}
		else
		{
			flag=false;
			for(var i=0;i<q.length;i++)
				if(q[i].value!='')
				{
				   flag=true;
				   break;
			    }
				if (flag==false)
				{
					alert("You have not answered this question.");
					obj.checked=false;
				}					
		}
	}
	else		//  fill in the blanks
	{ 
		if (obj.checked==false)
		{
			if(confirm("Are you sure that you don't want to submit this answer?")==true)
			{
				if(q.length>0)
				{			
					for(var j=0;j<q.length;j++)
						q[j].value==''
				}
				else
					q.value==''
			}
			else
				 obj.checked=true;			
		}
		else
		{
			flag=false;
			if(q.length>0)
			{
				for(var j=0;j<q.length;j++)
				{
					if(q[j].value!='')
					{
						flag=true;
						break;
					}
				}
			}
			else
			{
				if(q.value!="")				
					flag=true;						
			}
			if (flag==false)
			{
				alert("You have not answered this question.");
				obj.checked=false;
			}
		}
	} 
}

function setMark(qNo)
{
	frm.elements[qNo].checked=true;		
}

function setMark_oth(qNo,v)
{
	if(v!='')
		frm.elements[qNo].checked=true;		
}

function ltrim ( s ) 
{
	return s.replace( /^\s*/, "" );
}

function rtrim ( s )
{	
	return s.replace( /\s*$/, "" );
}

function trim ( s ) 
{
	return rtrim(ltrim(s));
}

function show_key(the_value)
{
	var the_key=".0123456789";
	var the_char;
	var len=the_value.length;
	if(the_value=="")
	return false;
		for(var i=0;i<len;i++)
		{
			the_char=the_value.charAt(i);
			if(the_key.indexOf(the_char)==-1)
				return false;
		}
}

function verify(m,max)
{
	var kk=0;

	var txt= document.getElementsByName(m.name)	
	var tFldId=document.getElementById(m.id);

	alert(tFldId.type);
	return;
	if(tFldId.readOnly==false)
	{
		for(var i=0;i<txt.length;i++)

		
		if(txt[i]==m)
		{
			var kk=i;
			break;
		}
		//if(isNaN(m.value)) 
		//{
		//	alert('Enter Points!');
		//	txt[kk].select();
		//}
		if(m.value>max) 
		{ 
			alert('Maximum points for this answer are '+max+'.');
			txt[kk].select();
		}
		else 
		{
			if(m.value!="")
			{
				calc();
				for(var j=0;j<txt.length;j++)
				{
					if(trim(txt[j].value)=="")
					{
						txt[j].focus();
						break;
					}
				}
			}
		}
	}
}
 
function calc()
{
	var len,win,q,tot,temp;
	var ar;
	tot=0;
	alert(q);

	for(var i=0;i<arr.length;i++) 
	{
		q=arr[i];
		win=document.q_paper.elements[q];
		len=win.length;
		ar=new Array(len);
		if(!win.length) 
		{
			if (trim(win.value)=='')
				tot=parseFloat(tot+0);
			else 
				tot=parseFloat(tot+parseFloat(win.value));
		}
		else
		{
			for(var j=0;j<len;j++) 
				if(trim(win[j].value)=='')
					ar[j]=0;
				else
					ar[j]=win[j].value;
			for(j=0;j<len-1;j++) 
			{
				for(var k=j+1;k<len;k++) 
				{
					if(parseInt(ar[j])<parseInt(ar[k])) 
					{
						temp=ar[j];
						ar[j]=ar[k];
						ar[k]=temp;
					}
				}
			}
			for(j=0;j<maxarr[i];j++) 
			{
				if((ar[j]=='')||(!ar[j]))
					tot=parseFloat(tot+0)
				else 
					tot=parseFloat(tot+parseFloat(ar[j]));
			}
		}
	}
	if(isNaN(tot))
		alert('Enter proper values!');
	else
		parent.fb_f.document.sub.marks.value=tot;
}

var arr=new Array();
var maxarr=new Array();
arr[0]="-";
maxarr[0]="100";

/////////////////////////////////Ans Script///////////////////////////////////

function setTableProperties(tableid,msg){
	try{
		var x=top.mid_f.document.getElementById(tableid);
		var y=top.mid_f.document.getElementById(tableid).rows[0].cells;
		if(msg=='Correct'){
			x.bgColor='#F7FBF7';
			y[2].innerHTML="<font face='arial' size='2' color='#008000'>"+y[2].innerHTML+"</font>";
		}else if(msg=='Incorrect'){
			x.bgColor='#FFF4F4';
			y[2].innerHTML="<font face='arial' size='2' color='red'>"+y[2].innerHTML+"</font>";
		}else if (msg=='teacher'){
			//x.bgColor='#DFD5FF';
		}
	}catch(err){
		onld();
	}
}
function setAnsFileLink(tableid,file){
	var x=top.mid_f.document.getElementById(tableid).rows[0].cells
   var desc='';
   if (file.length>0){
		desc=file.substring(file.lastIndexOf('/')+1,file.length)
 }
	x[2].innerHTML=x[2].innerHTML+'&nbsp;&nbsp;'+"<a href='#' onclick=\"window.open('"+file+"','t','width=400,height=400,resizable=yes,scrollbars=yes'); return false;\"><font face='arial' size='2' color='blue'>"+desc+"</font></a>";
}
function setMultipleOptionsProperties(id,option){
	var ind=0;
	var ele=top.mid_f.document.getElementsByName(id);
	if(ele.length>0 && option.length>0){
		for(var i=0;i<option.length;i++){
			if(option.charAt(i)==1){
				ele[i].checked=true;
			}else if(option.charAt(i)==0){
				ele[i].checked=false;
			}
		}
	}
}
function setFillInTheBlanks(id,option){
  var winele=top.mid_f.document.getElementsByName(id);
  if(winele.length>0){
	if(winele.length>1){
		var arr=option.split('~');
		if(arr.length>0){
		  for(var i=0;i<arr.length;i++){
			winele[i].value=arr[i];
		  }
		}else{
			winele[0].value=option;
		}
	}else{
		winele[0].value=option;
	}
 }
}
function setShortTypeQuestion(id,option){
	top.mid_f.document.getElementsByName(id)[0].value=option;
}
function setMatching(id,option){
	var ind=0;
	var ele=top.mid_f.document.getElementsByName(id);
	if(ele.length>0 && option.length>0){
		for(var i=0;i<option.length;i++){
				ele[i].value=option.charAt(i);
		}
	}
}
function onld(){
	var t=setTimeout('change()',1000);
}


