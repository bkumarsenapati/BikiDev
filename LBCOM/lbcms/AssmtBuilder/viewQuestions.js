function open_widow(mode){
	alert(QidList+'dg');
	if(check_all_fields('save')==false)
		return false;

	var frm=window.document.viewQuestions;
	var QidList=frm.arrQidList.value;
	alert(QidList);
	var AnsList=frm.arrAnsList.value;
	alert(AnsList);
	var QidListUchkd=frm.arrQidListUchkd.value;
	var QidAnsUchkd=frm.arrAnsListUchkd.value;
	//	var parent_q_type=parent.contents.group_status;

	var gr_q_type=new Array(26);
	var len=wtg_ng.length;
	var j=0;

	for(var i=0;i<26;i++){
		if(j<=len){
//			if(!q_type[i])
//				gr_q_type[i]=7;
//			else
				gr_q_type[i]=q_type[i];

			j++;

//			}else
//				gr_q_type[i]=7;					
	}
	}

	gr_q_type[26]=7;
	var win=window.open("ExamStatus.jsp?arrQidList="+QidList+"&arrAnsList="+AnsList+"&arrQidListUchkd="+QidListUchkd+"&arrAnsListUchkd="+QidAnsUchkd+"&mode="+mode+"&qtypes="+gr_q_type,"ExamStatus",'dependent=yes,width=750,height=250, scrollbars=yes,left=175,top=200');
		if(mode=="preview")
		 win.focus();

}

function check_status(){
    var len=wtg_ng.length;
	var sel=0;
	var tot;
	//alert(tmp_qs_counter[26]+" value at 27 is ");
	//alert("len is "+len);
    //alert("tmp_qs_counter "+tmp_qs_counter.length);
	if ((len==0)&&(tmp_qs_counter[26]==0))
	{
		alert("Select questions first");
		return false;
	}
	
	for(var i=0;i<len;i++){
		tot=tot_ques[i];
		
			//if(!tmp_qs_counter[i])
			//	sel=0;
			//else
				sel=tmp_qs_counter[i];
			if(!tot)
				break;
		if(sel!=tot && tot!=0){			
			
			alert("Different from the desired composition. Check 'Status'.");
			return false;

		}
	}
	for(var m=0;m<tmp_qs_counter.length;m++)
		sel_ques_counter[m]=tmp_qs_counter[m];
return true;
}


function assign_values(){

	var frm=window.document.viewQuestions;
	frm.arrQidList.value="";
	frm.arrAnsList.value="";
	frm.arrQidListUchkd.value="";
	frm.arrAnsListUchkd.value="";

	if(!frm.qidlist.length){

		if(frm.qidlist.checked){
			frm.arrQidList.value=frm.qidlist.value;
			frm.arrAnsList.value=frm.cans.value+":"+frm.wans.value+":"+frm.group.value;
		}else{
			frm.arrQidListUchkd.value+=frm.qidlist.value;
			frm.arrAnsListUchkd.value+=frm.cans.value+":"+frm.wans.value+":"+frm.group.value;
		}
	}else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++){
			
			if(frm.qidlist[i].checked){
				frm.arrQidList.value+=","+frm.qidlist[i].value;
				frm.arrAnsList.value+=","+frm.cans[i].value+":"+frm.wans[i].value+":"+frm.group[i].value;
			}else{
				frm.arrQidListUchkd.value+=","+frm.qidlist[i].value;
				frm.arrAnsListUchkd.value+=","+frm.cans[i].value+":"+frm.wans[i].value+":"+frm.group[i].value;
			}//end else
		}//end for
	}//end else
	return true;
}//end function



function Trim(s) {
  // Remove leading spaces and carriage returns
  
  while ((s.substring(0,1) == ' ') || (s.substring(0,1) == '\n') || (s.substring(0,1) == '\r'))
  {
    s = s.substring(1,s.length);
  }

  // Remove trailing spaces and carriage returns

  while ((s.substring(s.length-1,s.length) == ' ') || (s.substring(s.length-1,s.length) == '\n') || (s.substring(s.length-1,s.length) == '\r'))
  {
    s = s.substring(0,s.length-1);
  }
  return s;
}


function check_all_fields(mode){
	var frm=window.document.viewQuestions;
	var the_value=frm.cansAll.value;
	if(Trim(the_value)!='')
		if(check_number(the_value)==false){
			alert("Type in a number."); 
			return false;
		}
	
	the_value=frm.cansAll.value;
	if(Trim(the_value)!='')
		if(check_number(the_value)==false){
			alert("Type in a number."); 
			return false;
		}
	if(!frm.qidlist.length){
		the_value=Trim(frm.cans.value);
		
		if(Trim(the_value)=='')
			frm.cans.value=0;
		else
			if(check_number(the_value)==false){
				alert("Type in a number."); 
				return false;
		}

		the_value=Trim(frm.wans.value);
		
		if(Trim(the_value)=='')
			frm.wans.value=0;
		else
			if(check_number(the_value)==false){
				alert("Type in a number."); 
				return false;
		}
	}else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++){
			the_value=Trim(frm.cans[i].value);
		
			if(Trim(the_value)=='')
				frm.cans[i].value=0;
			else
				if(check_number(the_value)==false){
					alert("Type in a number."); 
					return false;
				 }

			the_value=Trim(frm.wans[i].value);
			
			if(Trim(the_value)=='')
				frm.wans[i].value=0;
			else
				if(check_number(the_value)==false){
					alert("Type in a number."); 
					return false;
			    }

		}
	}
	
	if(set_qid_list()==false)
		return false;
		
	if(assign_values()==false)
		return false;
	
	if(mode=="sub"){
		return check_status();
	}
	else
		return true;

}

function check_number(the_value)
{
	var the_key="0123456789.";
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1)
		return false;

	}
}

function check_all(){
	var frm=window.document.viewQuestions;
	var flag=frm.checkAll.checked;
	if(!frm.qidlist.length)
		frm.qidlist.checked=flag;
	else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++)
			frm.qidlist[i].checked=flag;
	}
}


function set_qid_list(){
//	alert('set_qid_list()');
	var frm=window.document.viewQuestions;
	var s_q_len=sel_ques.length;//qid:qtype

	var s_q_qid_len;
	var qid_qtype_len=qid_qtype.length;
	var q_t=7;
	var g_id;
	var s;
	var q_id;
	var flag=true;
//	alert('s_q_len is '+s_q_len);
//	alert("qid_qtype_len is "+qid_qtype_len);


	if(!frm.qidlist.length){
		
		for(var i=0;i<s_q_len;i++){//for1
			if(!sel_ques[i])
				sel_ques[i]=new Array();

                //if(sel_ques[i].length){
				s_q_qid_len=sel_ques[i].length;
				q_id=frm.qidlist.value;

				for(var k=0;k<qid_qtype_len;k++){//for2 
					s=qid_qtype[k].split(":");
					if(q_id==s[0]){
						q_t=s[1];
						
					}
				}//end for2

				g_id=frm.group.value;
			//	alert("g_id is "+g_id);
					
				//if(g_id=='-'){
				 // return true;	
				//}

				if(frm.qidlist.checked&&g_id!='-'){					
					if(q_type[g_id.charCodeAt(0)-65]!=q_t && q_type[g_id.charCodeAt(0)-65]){
						if(tmp_qs_counter[g_id.charCodeAt(0)-65]>0){
//							if(q_type[g_id.charCodeAt(0)-65]!=q_t){
							alert(g_id+" : Group is selected for : "+q_types[q_type[g_id.charCodeAt(0)-65]]+"\n Check QID : "+q_id);
							return false;
						}
					}
				}

				
				for(var j=0;j<s_q_qid_len;j++){	
					if(sel_ques[i][j]==q_id+":"+q_t){
						sel_ques[i][j]="0:0";
						if(!tmp_qs_counter[i] || tmp_qs_counter[i]==0 )
							tmp_qs_counter[i]=0;
						else
							tmp_qs_counter[i]-=1;
					}//end if
				}//end for


			//}//end if

			
			
		}//end for1


		if(frm.qidlist.checked && flag==true && g_id=='-'){
						//alert("incrementing at 26");
						flag=false;
						if(!sel_ques[26])
							sel_ques[26]=new Array();
						sel_ques[26][sel_ques[26].length]=q_id+":"+q_t;
						q_type[26]=q_t;
						tmp_qs_counter[26]+=1;
		}
		if(frm.qidlist.checked && flag==true && g_id!='-'){
			    //alert("incermenting at "+g_id.charCodeAt(0));
				flag=false;
				if(!sel_ques[g_id.charCodeAt(0)-65])
					sel_ques[g_id.charCodeAt(0)-65]=new Array();

				sel_ques[g_id.charCodeAt(0)-65][sel_ques[g_id.charCodeAt(0)-65].length]=q_id+":"+q_t;
				q_type[g_id.charCodeAt(0)-65]=q_t;
				tmp_qs_counter[g_id.charCodeAt(0)-65]+=1;
				
				
				
				}//end if
		}//end if
		else{
			
			var q_len=frm.qidlist.length;
								
			for(var l=0;l<q_len;l++){
				//alert("group is "+frm.group[l].value+" l is "+l); 
					flag=true;
			   for(var i=0;i<s_q_len;i++){//for1
					if(!sel_ques[i]){
						sel_ques[i]=new Array();
					}

				    //if(sel_ques[i].length){
					s_q_qid_len=sel_ques[i].length;
					q_id=frm.qidlist[l].value;
					for(var k=0;k<qid_qtype_len;k++){//for2 
						s=qid_qtype[k].split(":");
						if(q_id==s[0])
							q_t=s[1];
					}//end for2
					g_id=frm.group[l].value; 
									
					if(frm.qidlist[l].checked && g_id!='-'){	
						if(q_type[g_id.charCodeAt(0)-65]!=q_t && q_type[g_id.charCodeAt(0)-65]){
							if(tmp_qs_counter[g_id.charCodeAt(0)-65]>0){
								alert(g_id+" : Group is selected for : "+q_types[q_type[g_id.charCodeAt(0)-65]]+"\nCheck QID : "+q_id);
								return false;
							}
						}
					}
				//	alert("se l q len is "+s_q_qid_len+" i is "+i);
					for(var j=0;j<s_q_qid_len;j++){
										
						if(sel_ques[i][j]==q_id+":"+q_t){
							//alert("i & j is "+i+" "+j+" selques is "+sel_ques[i][j]+" q_id&Q-t is "+q_id+":"+q_t);
							sel_ques[i][j]="0:0";
							if(tmp_qs_counter[i]==0 ){
								
								tmp_qs_counter[i]=0;
							}
							else {
								
								tmp_qs_counter[i]-=1;
							}
								
						}//end if
					}//end for


				//}//end if
					
					
					
				}//end for1
				//for(var j=0;j<s_q_qid_len;j++){	
					
					if(frm.qidlist[l].checked && flag==true && g_id=='-'){
						//alert("incrementing - group");
						flag=false;
						if(!sel_ques[26])
							sel_ques[26]=new Array();
						sel_ques[26][sel_ques[26].length]=q_id+":"+q_t;
						q_type[26]=q_t;
						tmp_qs_counter[26]+=1;
					}
					if(frm.qidlist[l].checked && flag==true && g_id!='-'){
						
						flag=false;
						if(!sel_ques[g_id.charCodeAt(0)-65]){
							
							sel_ques[g_id.charCodeAt(0)-65]=new Array();
						}
						sel_ques[g_id.charCodeAt(0)-65][sel_ques[g_id.charCodeAt(0)-65].length]=q_id+":"+q_t;
						q_type[g_id.charCodeAt(0)-65]=q_t;
						
						tmp_qs_counter[g_id.charCodeAt(0)-65]+=1;	
						
					}//end if
				//}
		
		  }//end for
	    }
	    return true;
}


function as_cwans_values(the_id,the_value){
	var frm=window.document.viewQuestions;
	if(the_value!='-'){
		var s=wtg_ng[the_value.charCodeAt(0)-65].split(":");
	}
	if(!frm.qidlist.length){
		if(frm.qidlist.checked && the_value!='-'){
			frm.cans.value=s[0];
			frm.wans.value=s[1];
			frm.cans.disabled=true;
			frm.wans.disabled=true;

		}else{
			frm.cans.disabled=false;
			frm.wans.disabled=false;
		}
	}else{

		if(frm.qidlist[the_id].checked && the_value!='-'){
			frm.cans[the_id].value=s[0];
			frm.wans[the_id].value=s[1];
			frm.cans[the_id].disabled=true;
			frm.wans[the_id].disabled=true;

		}else{
			frm.cans[the_id].disabled=false;
			frm.wans[the_id].disabled=false;
		}
	}
}


function neg_change_marks(the_value){
	var frm=window.document.viewQuestions;
	if(!frm.qidlist.length){
		if(frm.group.value=='-')
			if(frm.qidlist.checked)
				frm.wans.value=the_value;
	}else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++){
			if(frm.group[i].value=='-')
				if(frm.qidlist[i].checked)
					frm.wans[i].value=the_value;
		}
	}
}

function change_marks(the_value){
	var frm=window.document.viewQuestions;
	if(!frm.qidlist.length){
		if(frm.group.value=='-')
			if(frm.qidlist.checked)
				frm.cans.value=the_value;
	}else{
		var len=frm.qidlist.length;
		for(var i=0;i<len;i++){
			if(frm.group[i].value=='-')
				if(frm.qidlist[i].checked)
					frm.cans[i].value=the_value;
		}
	}
}





function group_on_change(the_id){

	var frm=window.document.viewQuestions;
	if(!frm.qidlist.length){
		frm.group.onchange();
	}else{
		frm.group[the_id].onchange();
	}

}


function init_counter(){
	tmp_qs_counter=new Array();
	for(var m=0;m<sel_ques_counter.length;m++)
		tmp_qs_counter[m]=sel_ques_counter[m];	
}
