<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.*,java.util.Calendar,qeditor.Parser" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="conq" class="sqlbean.DbBean" scope="page" />
<% 
	String    	qid,classid,courseid,topicid,subtopicid,qtype,schoolid,pathname,edittype,sqlstring,q_body="",ans_str="",scriptvar="";
	String question[] = new String[3];
	String option[] = new String[3];
	String[] hint=new String[3];
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	session=request.getSession(true);
	schoolid=(String)session.getAttribute("schoolid");
	qid=request.getParameter("qid");
	classid=request.getParameter("classid");
	courseid=request.getParameter("courseid");
	topicid=request.getParameter("topicid");
	subtopicid=request.getParameter("subtopicid");
	qtype="51";//request.getParameter("qtype");
	pathname=request.getParameter("pathname");
	edittype="self.focus();"+
			"parent.window.opener.close();"+
			"qid='"+qid+"';"+
			"classid='"+classid+"';"+
			"courseid='"+courseid+"';"+
			"topicid='"+topicid+"';"+
			"subtopicid='"+subtopicid+"';"+
			"qtype='"+qtype+"';"+
			"pathname='"+pathname+"';";
	if(qid.equals("new"))
		edittype=edittype+"init_temp(1,51);"+
		"if (INIT_TEMP) {"+
		"initSpan51('l_q_area_id', 'text', 'q_51');"+
		"initSpan51('l_h_area_id', 'text', 'h_51');"+
		"initSpan51('l_c_area_id', 'text', 'h_51');"+
		"initSpan51('l_i_area_id', 'text', 'h_51');"+
		"chgFocus('l_q_ta0_id');"+
		"}";
	else{
		try{
			edittype=edittype+"init_temp(1,51);";
			con=conq.getConnection();
				st=con.createStatement();
			sqlstring="select q_body,ans_str,hint,c_feedback,ic_feedback from "+schoolid+"_"+classid+"_"+courseid+"_quesbody where q_id ='"+qid+"'";
			rs=st.executeQuery(""+sqlstring+"");
			if(rs.next()){
				q_body=rs.getString("q_body");
				ans_str=rs.getString("ans_str");
				hint[0]=rs.getString("hint");
				hint[1]=rs.getString("c_feedback");
				hint[2]=rs.getString("ic_feedback");
			}
			con.close();
			Parser p=new Parser();
			q_body=p.doublequotes(q_body);
			question=p.getQuestion(q_body,qtype);
			edittype=edittype+question[0];
			scriptvar=scriptvar+question[1];
			edittype=edittype+
				"addToSpan('l_h_area_id', 'text', 'h_51', '<br>');"+
				"addToSpan('l_c_area_id', 'text', 'c_51', '<br>');"+
				"addToSpan('l_i_area_id', 'text', 'i_51', '<br>');"+
				"s_ans='10000';"+
				"write_review51();"+
				"chgFocus('l_q_ta0_id');";			
		}catch(Exception se){
			System.out.println(se);
			if(con!=null)
				con.close();
		}
	}
%>
<html>
  <head>
    <title>Editor</title>
	<!--[if IE]>
	<style type="text/css">
	*{
	font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
	}
	</style>
	<![endif]-->
	<link rel="stylesheet" href="q.css" type="text/css">
    <script type="text/javascript" src="q_common.js"></script>
    <script type="text/javascript" src="q_assignment.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	<%=scriptvar%>
	</SCRIPT>
	<script>
	function chktxt()
	{
		var x=document.getElementById("l_q_ta0_id");
		if(x.value.length!=0)
		return false
		return true
	}
	</script>
  </head>
  <body topmargin="0" leftmargin="0"  onContextMenu='return false;' onLoad="<%=edittype%> ">
   <table width="100%" height="100%" border="0">
  <tr>
   <td align="left" valign="middle">
  	<table id="t_ed" border="0" width="100%">
<tr><td align="center">
<hr>
<span class="q_title">General Editor</span>
<br><hr>
</td></tr>
	  <tr class="w_main_panel">
	    <td id="main_panel_l" align="left">
        <form id="l_qo_form_id" name="l_qo_form" method="post" action=""
	   		enctype="multipart/form-data">
<input name="qid" id="q_id" type="hidden" value="new">
<!--
<div id="l_q_top_id" class="f_left"><img src="images/l.gif"></div>
-->
		 <div id="l_mb_q_id" class="w_l_mb_q">
		   <div class="f_left">
		   <input type="image" src="images/symbols.gif" title="[Symbols]"
				onclick="open_window('symbols.html','sym_win','');return false;">

		   <input type="image" src="images/reset.gif" title="[Reset]"
			onclick="refreshQEd(0); return false;">

		   <input type="hidden" id="from_id">
		   <input type="hidden" id="SymWin_id">
		   <input id="r_b_continue_id" 
		   		type="image" src="images/modify.gif" title="[submit1]"
				style="visibility: visible"
		   		onClick="if (HAMode) {
					alert('Please exit HTML editor.'); return false;}
					if (chktxt()) {
					alert('Empty file should not be submited.'); return false;}
					write_review51('q_area_id', 'o_area_id'); 
					submit_form(1); //window.opener.focus();">
		   </div>
		   <div class="f_right">
             <input name="q_html_chk" class="w_m_q_buttons" type="checkbox" 
				onClick="enable_HA=(enable_HA==false)?true:false;"
				style="visibility: hidden"/>
		   </div>
	     </div>
		 <div id="l_q_area_id" class="w_l_q_area">
		 </div>
		 <!--
		 <div id="r_help_id" style="height: 0px"> </div>
		 -->
		 <div id="l_b_area_id" class="f_left"
			 style="height:5px;visibility:hidden">
		   <table border="0">
			<tr>
				  <td><font face="Arial" size="2">Hint:</font></td>
                  <td>
		   <div id="l_h_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
			<tr>
				  <td><font face="Arial" size="2">Feedback <br>(Correct response):</font></td>
                  <td>
		   <div id="l_c_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
			<tr>
				  <td><font face="Arial" size="2">Feedback <br>(Incorrect response):</font></td>
                  <td>
		   <div id="l_i_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
		   </table>
		 </div>
        </form>
        <form id="r_qo_form_id" name="r_qo_form">
		 <div id="r_qo_area_id" class="r_qo_area" 
			 style="height: 5px;visibility:hidden"> </div>
         <div id="r_f_area_id" class="r_qo_area" 
		 	style="height: 5px;visibility:hidden"> </div>
        </form>
		</td>
	  </tr>
	</table>
   </td>
  </tr>
</table>
<div id=tparam name=tparam style='visibility:hidden'></div>
  </body>
</html>

  
