 <jsp:useBean	 id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.sql.*,java.util.*,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	
	synchronized private int getPages(int tRecords,int pageSize){
		int noOfPages=0;
		try{
			if((tRecords%pageSize)>0){
				noOfPages=(tRecords/pageSize)+1;
			}else{
				noOfPages=(tRecords/pageSize);
			}
		}catch(Exception e){
			System.out.println("Error in ViewQuestions.jsp at getPages() is "+e);
		}
		return noOfPages;
	}
	synchronized public String getDifficultyLevel(int level){
		String difficultLevel="";
		if(level==0)
			difficultLevel="Very Easy";
		else if (level==1)
			difficultLevel="Easy";
		else if (level==2)
			difficultLevel="Average";
		else if (level==3)
			difficultLevel="Above Average";
		else if (level==4)
			difficultLevel="Difficult";
		return difficultLevel;
		
	}
%>
<%
	//Connection con;
	//Statement st;
	Connection  conObj=null;
	Statement   st1=null;
	ResultSet	rs=null;

	String sessid="",examName="",schoolId="",enableMode="",exmTbl="";
	String courseId="",classId="",topicId="",subTopicId="",qType="",examId="",examType="",tblName="",element="",quesType="",disable="";
	int currentPage=0;
	int pageSize=10;
	int difficultLevel=-1;
	
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="viewQuestions.js"></script>
<!--[if IE]>
<style type="text/css">
*{
font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
}
</style>
<![endif]-->
</head>
<script>

var tot_ques		 = parent.contents.tot_ques;
var wtg_ng			 = parent.contents.wtg_ng;
var sel_ques_counter = parent.contents.sel_ques_counter;

var tmp_qs_counter;
var counter=0;
var q_type=parent.contents.q_type;
var sel_ques=parent.contents.sel_ques;
var ss=0;
var ss1=0;

var qid_qtype=new Array();
var q_types=new Array();
q_types[q_types.length]="Multiple choice";
q_types[q_types.length]="Multiple answer";
q_types[q_types.length]="yes/no";
q_types[q_types.length]="Fill in the blanks";
q_types[q_types.length]="Matching";
q_types[q_types.length]="Ordering";
q_types[q_types.length]="Short/Essay";


parent.contents.visited=1;


</script>

<%
try{
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
    schoolId=(String)session.getAttribute("schoolid");

	//Connection  conObj;
	//Statement   st1;
	//ResultSet	rs;
    
	Hashtable qidlist,groupDetails,diffLevelList;
	Hashtable qidType=new Hashtable();
	ArrayList totQts;

	StringTokenizer stk,stk1;

	StringBuffer groupString=new StringBuffer();
	String groupString1=new String();
	String dbString=new String();
	String chkd="",linkStr,cans,wans,qId,qT,qBody,qList,qAnsList,qListUchkd,key,grpTable;

	int length=0;
	int totRecords,c=0,start,end;
	
	byte visitFlag=0;
	byte samePage;
	boolean groupFlag=true,flage=true,saveFlage=true;

	char gId;

	
	String diffQuery="";
  
    conObj=db.getConnection();
	st1=conObj.createStatement();
	totRecords=0;
	disable="";

	topicId		  = request.getParameter("topicid");
	subTopicId	  = request.getParameter("subtopicid");
	//qType		  = request.getParameter("qtype");
	//quesType	  = qType;
	examId		  = request.getParameter("assmtId");
	examName	  =request.getParameter("asname");
	examType	  = request.getParameter("examtype");
	visitFlag	  = Byte.parseByte(request.getParameter("visited"));
	samePage      = Byte.parseByte(request.getParameter("samePage"));
	classId		  = (String)session.getAttribute("classid");
	//courseId	  = (String)session.getAttribute("courseid");
	courseId	  = request.getParameter("courseid");
	//tblName		  = schoolId+"_"+classId+"_"+courseId;
	tblName="lbcms_dev_assmt_content_quesbody";
    
	enableMode=request.getParameter("enableMode");
	 //if (enableMode.equals("0"))
		//grpTable=schoolId+"_"+examId+"_group_tbl";
	//else
		//grpTable=schoolId+"_"+examId+"_group_tbl_tmp";

	//qidlist=(Hashtable)session.getAttribute("qidlist");

	qidlist=null;

	/*if(request.getParameter("difflevel")!=null){
		difficultLevel=Integer.parseInt(request.getParameter("difflevel"));
		if(difficultLevel>=0){
			diffQuery=" and difficult_level="+difficultLevel+" ";
		}else{
			diffQuery="";
		}
	}else{
		difficultLevel=-1;
	}
	diffLevelList=new Hashtable();*/

	session.putValue("examid",examId);
	if(qidlist==null){
		qidlist=new Hashtable();
	}
	
	
	qListUchkd=request.getParameter("arrQidListUchkd");

	if(qListUchkd!=null){
		stk=new StringTokenizer(qListUchkd,",");
		while(stk.hasMoreTokens()){
			key=stk.nextToken();
			if(qidlist.containsKey(key))
				qidlist.remove(key);
		}
	}

	qList=request.getParameter("arrQidList");
	qAnsList=request.getParameter("arrAnsList");

	if(qList!=null){
			
		stk=new StringTokenizer(qList,",");
		stk1=new StringTokenizer(qAnsList,",");
		while(stk.hasMoreTokens()){
			qidlist.put(stk.nextToken(),stk1.nextToken());
			
		}
	}
		

	if(visitFlag==0){//begin visitflag

	   // groupDetails=new Hashtable();
		totQts=new ArrayList(20);   

		// Group details are reading from the table
	    
		//rs=st1.executeQuery("select * from "+grpTable);
		
	   /*	while(rs.next()) 
		{
			if(!rs.getString("group_id").equals("-"))
			{
				groupDetails.put(rs.getString("group_id"),rs.getString("weightage")+":"+rs.getString("neg_marks"));
			  
			   totQts.add(rs.getString("tot_qtns"));
			   groupFlag=true;
			}

		}
*/
		//Stoing in session 
		session.putValue("totQts",totQts);
		//session.putValue("groupDetails",groupDetails);
		StringBuffer queryString=new StringBuffer();
		boolean tmpFlag=false;

			if(totQts!=null){// creating script array total qtns in the app. group 
				out.print("<script>");
				Iterator ii=totQts.iterator();
				int n;
				while(ii.hasNext()){
					n=Integer.parseInt((String)ii.next());
					out.println("tot_ques[counter++]="+n+";");
				}
				out.print("</script>");
			}//end totQts

			// If groups are created then it takes wieghtage of each group and creating a script array
			/*if(groupFlag){
				Enumeration keys=groupDetails.keys();
				String groupKey;			
				out.println("<script>");
				while(keys.hasMoreElements()){
					groupKey=(String)keys.nextElement();
					out.println("wtg_ng[wtg_ng.length]='"+groupDetails.get(groupKey)+"'");
				}//end while
				out.println("</script>");
			}//end if
*/

		//  reading question list from the table

	    if (enableMode.equals("0"))
			exmTbl="exam_tbl";
		else
			exmTbl="lbcms_dev_assessment_master";

		rs=st1.executeQuery("select ques_list from "+exmTbl+" where exam_id='"+examId+"' and school_id='"+schoolId+"'");

		if(rs.next()){//begin rs.next		
			char ch;
			String quesDet[]=new String[4];
			stk=new StringTokenizer(rs.getString("ques_list"),"#");

			out.println("<script>");
			while(stk.hasMoreTokens()){
				quesDet=stk.nextToken().split(":");
				if(groupFlag){//beging groupFlag
					ch=(quesDet[3]).charAt(0);
					
					if(ch!='-'){
						out.println(" if(!sel_ques_counter["+(ch-65)+"])");
						out.println("	sel_ques_counter["+(ch-65)+"]=1;");
						out.println(" else sel_ques_counter["+(ch-65)+"]++;");
					}
					else{
						int x=26;
						out.println(" if(!sel_ques_counter["+x+"])");
						out.println("	sel_ques_counter["+x+"]=1;");
						out.println(" else sel_ques_counter["+x+"]++;");
					}
					if(tmpFlag){
						queryString.append(" or q_id='"+quesDet[0]+"' ");
					}
					else{
						queryString.append(" q_id='"+quesDet[0]+"' ");
						tmpFlag=true;
					}
					
				}//end groupFlag

				if(quesDet.length==4){
				qidlist.put(quesDet[0],quesDet[1]+":"+quesDet[2]+":"+quesDet[3]);
				qidType.put(quesDet[0],quesDet[3]);

			}
			}//end while
			out.println("</script>");

			session.putValue("qidlist",qidlist);
		

			if(groupFlag){
				if(queryString.length()>0)
				//rs=db.execSQL("select q_id,q_type from "+tblName+"_quesbody where "+queryString);
				
				rs=st1.executeQuery("select q_id,q_type,status,difficult_level from "+tblName+"_quesbody where "+queryString);
				
				out.print("<script>");
				while(rs.next()){
					qId=rs.getString("q_id");
					qT=rs.getString("q_type");
					if(rs.getInt("status")==2){
						if(qidType.containsKey(qId)){
							gId=((String)qidType.get(qId)).charAt(0);
							qidType.remove(qId);
							qidlist.remove(qId);
							
							if (gId!='-'){
								out.print("sel_ques_counter["+(gId-65)+"]--;");	
							}else{
								out.print("sel_ques_counter[26]--;");	
							}
							
						}
					}
					
					if(qidType.containsKey(qId)){
						//diffLevelList.put(qId,rs.getString("difficult_level"));
						gId=((String)qidType.get(qId)).charAt(0);
						if(gId!='-'){
						out.print("if(!sel_ques["+(gId-65)+"] || !sel_ques["+(gId-65)+"].length)");
						out.print("sel_ques["+(gId-65)+"]=new Array();");
						
						out.print("sel_ques["+(gId-65)+"][sel_ques["+(gId-65)+"].length]='"+qId+":"+qT+"';");
						out.print("q_type["+(gId-65)+"]="+qT+";");
						}else{
						out.print("if(!sel_ques[26] || !sel_ques[26].length)");
						out.print("sel_ques[26]=new Array();");
						out.print("sel_ques[26][sel_ques[26].length]='"+qId+":"+qT+"';");
						out.print("q_type[26]="+qT+";");
				
						}
					}
				}
				out.print("</script>");
				
			}

		}//end rs.next
	}//end visitflag

	totQts=(ArrayList)session.getAttribute("totQts");
	groupDetails=(Hashtable)session.getAttribute("groupDetails");
	groupString.append("<option value='-'>-</option>");
	if(groupDetails==null)
		groupFlag=false;
	else
	{
		length=groupDetails.size();
		for(char gCh='A';gCh<(length+65);gCh++)
			groupString.append("<option value='"+gCh+"'>"+gCh+"</option>");
	}

		
	String tot=request.getParameter("totrecords");
	

	if (tot.equals("none")){//if tot==none
		  dbString="show tables like '"+tblName+"'";
		  //rs=db.execSQL(dbString);
		  rs=st1.executeQuery(dbString);
		  if(rs.next()){
			if((topicId.equals("none") && subTopicId.equals("none") && qType.equals("none") && difficultLevel==-1 )){

				c=qidlist.size();
				pageSize=c;
			}else{
			   if(!(subTopicId.equals("none") && qType.equals("none")))
				dbString="select count(*) from "+tblName+" q where q.assmt_id='"+examId+"' and q.status!='2' order by q.q_id";
			  
				   
			   //rs=db.execSQL(dbString);
			   rs=st1.executeQuery(dbString);
			   if (rs.next()) {
					c=rs.getInt(1);
			   }
			}
			if (c!=0 ){
			   totRecords=c;
			} else{
				flage=false;
				out.println("<table border='0' width='100%' cellspacing='1' 	bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      	<b><font face='Arial' color='#FF0000' size='2'>Sorry! Questions not found</font></b></td></tr></table>");				
				//sreturn;
			}//end else
			rs.close();
			
		}else{
			out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
			out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Sorry! Questions not Created</font></b></td></tr></table>");				
			return;
		}

	}//end if tot==none
	else 
		totRecords=Integer.parseInt(request.getParameter("totrecords"));
	   
		  
	   st1.close();
	   st1=conObj.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	   start=Integer.parseInt(request.getParameter("start"));

	   c=start+pageSize;
	   end=start+pageSize;

	   if (c>=totRecords) 
		   end=totRecords;
       
	   dbString="select q.q_id,q.q_type,q.q_body,q.difficult_level from "+tblName+" q where q.assmt_id='"+examId+"' and q.status!='2' order by q.q_id  LIMIT "+start+","+pageSize;
	rs=st1.executeQuery(dbString);

	if(pageSize==0)
		pageSize=1;
	currentPage=(start/pageSize)+1;

	
%>


<body topmargin="0" leftmargin="0" onload="init_counter();">
<form name="viewQuestions" method="post" action="ExamStatus.jsp?mode=submit&qtype=<%=qType%>&examname=<%=examName%>">
<!--<form name="viewQuestions" method="post" >-->
<%
	if (!flage)
	{
%>
		<p align="center"><font face="Arial" size="2">
<%
	if (qList!=null)
	{
%>
		<input type="hidden" name="arrQidList" value="<%=qList%>">
<%
	}
	else
	{
%>
		<input type="hidden" name="arrQidList" value="">
<%
	}
	if (qAnsList!=null)
	{
%>
		<input type="hidden" name="arrAnsList" value="<%=qAnsList%>">
<%
	}
	else
	{
%>
		<input type="hidden" name="arrAnsList" value="">
<%
	}
	if (qListUchkd!=null)
	{
%>
		<input type="hidden" name="arrQidListUchkd" value="<%=qListUchkd%>">
<%
	}
	else
	{
%>
		<input type="hidden" name="arrQidListUchkd" value="">
<%
	}
%>
	<input type="hidden" name="arrAnsListUchkd" value="">
	<input type="hidden" name="examtype" value="<%=examType%>">
	<input type="image" src="images/submit.jpg" name="submit" onclick="return check_status();" ></font></p>

<script>
	function go2() {
	    var frm=window.document.viewQuestions;
		var QidList=frm.arrQidList.value;
		var AnsList=frm.arrAnsList.value;
		var QidListUchkd=frm.arrQidListUchkd.value;
		var QidAnsUchkd=frm.arrAnsListUchkd.value;
		var gr_q_type=new Array(26);
		var len=wtg_ng.length;
		var j=0;

		for(var i=0;i<26;i++){
			if(j<=len){
				gr_q_type[i]=q_type[i];
				j++;
			}
		}
		gr_q_type[26]=7;

		var win=window.open("ExamStatus.jsp?arrQidList="+QidList+"&arrAnsList="+AnsList+"&arrQidListUchkd="+QidListUchkd+"&arrAnsListUchkd="+QidAnsUchkd+"&mode=preview&qtypes="+gr_q_type,"examStatus",'dependent=yes,width=750,height=250, scrollbars=yes,left=175,top=200');
		win.close();
		//open_widow('preview','noques');
	
	}
	
</script>
</form>
</body>
</html>
<%	return;}%>
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" >
        <div align="center">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" height="119" >
  <tr>
    <!--<td width="100%" bgcolor="#C2CCE0" height="18" colspan="14">
      <font face="Arial" size="2">
      <sp align="right"><span class="last">Questions <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span><font color="#000080">-->
	  <td colspan='8'>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	   <td bgcolor="#C2CCE0" height="18" align="left"><font face="Arial" size="2">
      <sp align="right"><span class="last">Questions 
	  <%

		if((topicId.equals("none")&&subTopicId.equals("none"))){
			out.println(""+(start+1)+" - "+end+" of "+totRecords +" &nbsp;&nbsp;</span></td>");
			out.println("<td bgcolor='#C2CCE0' height='18' align='center'><font face='arial' size='2' color='#000080'>");
			if(start==0 ) { 
				
				if(totRecords>end){
					out.println("Previous | <a href=\"#\" onclick=\"if(check_all_fields('save')==true)go('"+(start+pageSize)+ "','"+totRecords +"','"+qType+"',0);return false;\"> Next</a>&nbsp;&nbsp;");

				}else
					out.println("Previous | Next &nbsp;&nbsp;");


			}
			else{

				linkStr="<a href=\"#\" onclick=\" if(check_all_fields('save')==true)go('"+(start-pageSize)+ "','"+totRecords+"','"+qType+"',0);return false;\">Previous</a> |";


				if(totRecords!=end){
					linkStr=linkStr+"<a href=\"#\" onclick=\"if(check_all_fields('save')==true)go('"+(start+pageSize)+ "','"+totRecords +"','"+qType+"',0);return false;\"> Next</a>&nbsp;&nbsp;";
				}
				else
					linkStr=linkStr+" Next&nbsp;&nbsp;";
				out.println(linkStr);

			}
		out.println("</font></td>");
	    out.println("<td  bgcolor='#C2CCE0' height='21' align='right' ><font face='arial ' size='2'>Page&nbsp;");
	  
		int index=1;
		int begin=0;
		int noOfPages=getPages(totRecords,pageSize);
		out.println("<select name='page' onchange=\"if(check_all_fields('save')==true)gotopage('"+totRecords+"','"+qType+"',0,'"+pageSize+"');return false;\"> <option vlaue='0'>Select Page</option>");
		while(index<=noOfPages){
			if(index==currentPage){
			    out.println("<option value='"+index+"' selected>"+index+"</option>");
			}else{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			begin+=pageSize;


		}
		out.println("</select></font>");
	  }
	  
	  %>
	  </td></tr></table>
	  
	 
	  
	  </td>
	  </tr>

  </tr>

  <td height="100%">




<table border="0" width="100%" cellspacing="1">
<tr><td bgcolor='#DEDBD6'><b><font face="Arial" size="2" color="#000080">Group</font></b></td>
<td width="3%" bgcolor="#DEDBD6">
    <p align="center"><font face="Arial" size="2"><input type="checkbox" name="checkAll" value="checkAll" onClick="return check_all();"></font></p>
  <!--</td></center><td width="8%" bgcolor="#DEDBD6">
  <p align="center"><b><font face="Arial" size="2" color="#000080">Q. ID</font></b></p>
</td>-->
<td width="18" bgcolor="#DEDBD6" height="18" align="center" valign="middle">&nbsp;</td>

<center>
  <td width="46%" bgcolor="#DEDBD6">
    <p align="center"><b><font face="Arial" size="2" color="#000080">Question
    Description</font></b></p>
  </td></center><td width="4%" bgcolor="#DEDBD6">
  <p align="right"><font face="Arial" size="2" color="#000080"><input type="text" name="cansAll" onblur="change_marks(this.value);" size="3"></font></p>
</td>

<center>
  <td width="17%" bgcolor="#DEDBD6"><b><font face="Arial" size="2" color="#000080">Single
    Correct Response</font></b></td></center><td width="4%" bgcolor="#DEDBD6">
  <p align="right"><font face="Arial" size="2" color="#000080"><input type="text" size="3" name="wansAll" onblur="neg_change_marks(this.value);"></font></p>
</td>

<center>
  <td width="18%" bgcolor="#DEDBD6"><b><font face="Arial" size="2" color="#000080">Single
    Incorrect Response</font></b></td>
	<%if(difficultLevel<0){%>
		 <td width="18%" bgcolor="#DEDBD6"><b><font face="Arial" size="2" color="#000080">Difficult Level</font></b></td>
	<%}%>
	</tr>		




<%	String quesDet[]=new String[3];
String qnTblName=tblName+"_quesbody";
String qt="",st="",tp="";
int theId=0;
int diffLevel=0;
	while(rs.next()){
		qId=rs.getString(1);
		qT=rs.getString(2);
		diffLevel=-1;
		qBody=QuestionFormat.getQString(rs.getString("q_body"),40);
		diffLevel=rs.getInt("difficult_level");
		cans="1";
		wans="0";
		chkd="";
		disable="";
		gId='-';
		
		out.print("<script>qid_qtype[qid_qtype.length]='"+qId+":"+rs.getString("q_type")+"';</script>");
		if(topicId.equals("none")&&subTopicId.equals("none")&&qType.equals("none")){
			if(qidlist.containsKey(qId)){
				saveFlage=false;
				qt=rs.getString("q_type");
				st=rs.getString("sub_topic_id");
				tp=rs.getString("topic_id");
				chkd="checked";
				quesDet=((String)qidlist.get(qId)).split(":");
				cans=quesDet[0];
				wans=quesDet[1];
				gId=quesDet[2].charAt(0);
				//diffLevel=Integer.parseInt((String)diffLevelList.get(qId));
				if (gId!='-')
					disable="disabled";
				else
				   disable="";
				groupString1="";
				/*groupString1+=("<option value='-'>-</option>");
				for(char gCh='A';gCh<(length+65);gCh++){
					if(gId==gCh)
						groupString1+=("<option selected value='"+gCh+"'>"+gCh+"</option>");
					else
						groupString1+=("<option  value='"+gCh+"'>"+gCh+"</option>");
				}
				
				out.print("<tr><td bgcolor='#E7E7E7'><select name=\"group\" onchange='as_cwans_values("+theId+",this.value);'>");
				out.print(groupString1);
				out.println("</select></td>");*/
				out.print("<tr><td bgcolor='#E7E7E7'><select name=\"group\" onclick=\" gotoquestype('"+qt+"','"+tp+"','"+st+"',0); return false;\">");
				//out.println(" onchange=\" as_cwans_values('"+theId+"',this.value); return false;\" >");
				
				out.print("<option  selected value='"+gId+"'>"+gId+"</option>");
				out.println("</select></td>");
				
				/*out.println("<td bgcolor='#E7E7E7'>"+
							"<input type=\"checkbox\" name=\"qidlist\"  onclick='group_on_change("+theId+");'value=\""+qId+"\" "+chkd+" ></td>");*/
				out.println("<td bgcolor='#E7E7E7'>"+
							"<input type=\"checkbox\" name=\"qidlist\"  onclick=\" gotoquestype('"+qt+"','"+tp+"','"+st+"',0); return false;\" value=\""+qId+"\" "+chkd+" ></td>");
				//out.println("<td bgcolor='#E7E7E7'>"+qId+"</td>");
				if(enableMode.equals("0"))
					out.println("<td width='18' height='18' bgcolor='#E7E7E7' align='center' valign='middle'><img border='0' src='images/iedit.gif' TITLE='Edit.' ></font></td>");	
				else
					out.println("<td width='18' height='18' bgcolor='#E7E7E7' align='center' valign='middle'><a disabled href='#' onclick=\"return editQuestion('"+qId+"','"+qt+"','"+tp+"','"+st+"');\"> <img border='0' src='images/iedit.gif' TITLE='Edit.' ></font></td>");	

				out.println("<td bgcolor='#E7E7E7'><a href='#'                     onclick=\"showQtn('"+qId+"','"+qnTblName+"')\">"+qBody+"</td>");
				out.println("<td colspan=2 bgcolor='#E7E7E7'><input type=\"text\" name=\"cans\" size='3' value=\""+cans+"\""+disable+">"+"</td>");
				out.println("<td colspan=2 bgcolor='#E7E7E7'><input type=\"text\" name=\"wans\" size='3' value=\""+wans+"\""+disable+">"+"</td>");
				//out.println("<td colspan=1 bgcolor='#E7E7E7'><font face='arial' size='2'>"+getDifficultyLevel(diffLevel)+"</td></tr>");
				theId++;

		  } else{
				//groupString1=groupString.toString();
				continue;
		  }
		
		}else{
			if(qidlist.containsKey(qId)){
				saveFlage=true;
				chkd="checked";
				quesDet=((String)qidlist.get(qId)).split(":");
				cans=quesDet[0];
				wans=quesDet[1];
				gId=quesDet[2].charAt(0);
				groupString1="";
				groupString1+=("<option value='-'>-</option>");
					for(char gCh='A';gCh<(length+65);gCh++){
						if(gId==gCh)
							groupString1+=("<option selected value='"+gCh+"'>"+gCh+"</option>");
						else
							groupString1+=("<option  value='"+gCh+"'>"+gCh+"</option>");
					}
				if (gId!='-')
					disable="disabled";
				else
					disable="";
			}else
				groupString1=groupString.toString();
			
			
			out.print("<tr><td bgcolor='#E7E7E7'><select name=\"group\" onchange='as_cwans_values("+theId+",this.value);'>");
			out.print(groupString1);
			out.println("</select></td><td bgcolor='#E7E7E7'>"+
						"<input type=\"checkbox\" name=\"qidlist\"  onclick='group_on_change("+theId+");'value=\""+qId+"\" "+chkd+" ></td>");
			//out.println("<td bgcolor='#E7E7E7'>"+qId+"</td>");

			if(enableMode.equals("0"))
				out.println("<td width='18' height='18' bgcolor='#E7E7E7' align='center' valign='middle'><img border='0' src='images/iedit.gif' TITLE='Edit.' ></font></td>");	
			else
				out.println("<td width='18' height='18' bgcolor='#E7E7E7' align='center' valign='middle'><a  href='#' onclick=\"return editQuestion('"+qId+"','"+qType+"','"+topicId+"','"+subTopicId+"');\"> <img border='0' src='images/iedit.gif' TITLE='Edit.' ></font></td>");	


			out.println("<td bgcolor='#E7E7E7'><a href='#'                     onclick=\"showQtn('"+qId+"','"+qnTblName+"')\">"+qBody+"</td>");
			out.println("<td colspan=2 bgcolor='#E7E7E7'><input type=\"text\" name=\"cans\" size='3' value=\""+cans+"\""+disable+">"+"</td>");
			out.println("<td colspan=2 bgcolor='#E7E7E7'><input type=\"text\" name=\"wans\" size='3' value=\""+wans+"\""+disable+">"+"</td>");
			//out.println("<td colspan=1 bgcolor='#E7E7E7'><font face='arial' size='2'>"+getDifficultyLevel(diffLevel)+"</font></td></tr>");
			theId++;
		}

		if(difficultLevel<0){
			out.println("<td colspan=1 bgcolor='#E7E7E7'><font face='arial' size='2'>"+getDifficultyLevel(diffLevel)+"</font></td></tr>");
		}
	}//end while 
%>

<%  if (!enableMode.equals("0")){ %>


<% 
	if (saveFlage==true)
	{
%>
		</table>
		<p align="center"><font face="Arial" size="2">
		<input type="image" src="images/bsave.gif" name="Save" onclick="if(check_all_fields('save')==true)go('<%=start%>','<%=totRecords%>','<%=quesType%>',1); return false;">
		<input type="image" src="images/bstatus.gif" onclick="if(set_qid_list()==true) go1();return false;">
		<input type="image" src="images/submit.jpg" title="SUBMIT FORM" name="submit" onclick="return check_all_fields('sub');" >
<%
	}
	else
	{
%>
		</table>
		<p align="center"><font face="Arial" size="2">
		<input type="image" src="images/bstatus.gif" onclick="if(set_qid_list()==true) go1();return false;">
		<input type="image" src="images/submit.jpg" name="submit" onclick="return check_all_fields('sub');" >
<%
	}
%>

<% } %>


</font></p></table>
<%

}catch(Exception e){
	ExceptionsFile.postException("ViewQuestions.jsp","creating connection object","Exception",e.getMessage());
	System.out.println("The error in ViewQuestion.jsp is : "+e);
} finally{
		try{
			if(st1!=null)
				st1.close();
			if(conObj!=null && !conObj.isClosed())
				conObj.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ViewQuestions.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
<script>
function editQuestion(qid,qtype,topicid,subtopicid){
	win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid="+qid+"&classid=<%=classId%>&courseid=<%=courseId%>&topicid="+topicid+"&subtopicid="+subtopicid+"&qtype="+qtype,"qed_win","width=875,height=525,scrollbars=yes");
	win.focus();
}

function a(){

var s='';
for(var i=0;i<sel_ques_counter.length;i++){
	s+=(String.fromCharCode(i+65))+"  : "+sel_ques_counter[i]+"\n";
}


}

function checkAllFields(mode)
{
	return true;
}

function gotoquestype(qtype,topic,subtopic,same_page)
{
	parent.contents.document.examform.topicid.value=topic;
	parent.contents.document.examform.topicid.onchange();
	parent.contents.document.examform.subtopicid.value=subtopic;
	parent.contents.document.examform.subtopicid.onchange();
	parent.contents.document.examform.qtype.value=qtype;
	
	parent.contents.same_page=same_page;	
	parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start=0&totrecords=none&examname=<%=examName%>&examid=<%=examId%>&qtype="+qtype+"&cat=none&examtype=<%=examType%>&topicid="+topic+"&subtopicid="+subtopic+"&samePage="+same_page+"&visited=0"+"&difflevel=<%=difficultLevel%>";

	return false;
}


function go(start,totrecords,qType,same_page)
{	
	parent.contents.same_page=same_page
	var frm=window.document.viewQuestions;
	var arrQidList=frm.arrQidList.value;
	var arrAnsList=frm.arrAnsList.value;
	var arrQidListUchkd=frm.arrQidListUchkd.value;
	for(var m=0;m<tmp_qs_counter.length;m++)
	{
		sel_ques_counter[m]=tmp_qs_counter[m];
	}
	parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start="+start+"&totrecords="+totrecords+"&examid=<%=examId%>&qtype="+qType+"&cat=none&examname=<%=examName%>&examtype=<%=examType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&samePage="+same_page+"&visited=1&arrQidListUchkd="+arrQidListUchkd+"&arrQidList="+arrQidList+"&arrAnsList="+arrAnsList+"&difflevel=<%=difficultLevel%>";
	return false;
}


function gotopage(totrecords,qType,same_page,pSize){
		var page=document.viewQuestions.page.value;
		if(page==0){
			alert("Select page");
			return false;
		}else{
			start=(page-1)*pSize;
			
			parent.contents.same_page=same_page;
			var frm=window.document.viewQuestions;
			var arrQidList=frm.arrQidList.value;
			var arrAnsList=frm.arrAnsList.value;
			var arrQidListUchkd=frm.arrQidListUchkd.value;
			for(var m=0;m<tmp_qs_counter.length;m++){
				sel_ques_counter[m]=tmp_qs_counter[m];
			}
			parent.create_fr.location.href="ViewQuestions.jsp?enableMode=<%=enableMode%>&start="+start+"&totrecords="+totrecords+"&examid=<%=examId%>&qtype="+qType+"&cat=none&examname=<%=examName%>&examtype=<%=examType%>&topicid=<%=topicId%>&subtopicid=<%=subTopicId%>&samePage="+same_page+"&visited=1&arrQidListUchkd="+arrQidListUchkd+"&arrQidList="+arrQidList+"&arrAnsList="+arrAnsList+"&difflevel=<%=difficultLevel%>";
			return false;
		}
	}
function go1() {
	
	var frm=window.document.viewQuestions;
	for(var m=0;m<tmp_qs_counter.length;m++)
			sel_ques_counter[m]=tmp_qs_counter[m];
    open_widow('preview');

}


function showQtn(qId,qnTbl){
		var w=window.open("ShowQuestion.jsp?qid="+qId+"&qntbl="+qnTbl,"Question","width=600,height=300,scrollbars=yes");
		
}
</script>

<input type="hidden" name="arrQidList" value=''>
<input type="hidden" name="arrAnsList" value=''>
<input type="hidden" name="arrQidListUchkd" value=''>
<input type="hidden" name="arrAnsListUchkd" value=''>
<input type="hidden" name="examtype" value="<%=examType%>">

</form>
</body>

<script language='javascript'>	
<%  if (enableMode.equals("0")){ %>
		var frm=document.viewQuestions;
		for (var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;

		<% } %>
</script>

</html>
