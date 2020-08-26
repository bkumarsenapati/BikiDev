<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.*,java.util.Calendar,qeditor.Parser" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="conq" class="sqlbean.DbBean" scope="page" />
<% 
	String    qid,classid,courseid,topicid,subtopicid,qtype,schoolid,pathname,edittype,sqlstring,q_body="",ans_str="",scriptvar="",assmtid="",pointspossible="",IncorrectResponse="",courseId="";
	String[] hint=new String[3];
	String difficultLevel="";
	String timeScale="",unitId="",lessonId="";
	String estimatedTime="";
	String temp="";
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
	//unitId=request.getParameter("unitid");
	//lessonId=request.getParameter("lessonid");
	
//	courseId=courseid;
//	if(courseid==null)
	//	courseid=courseId;
	qtype="1";//request.getParameter("qtype");
	pathname=request.getParameter("pathname");
	assmtid=request.getParameter("assmtId");
	//courseid="DC040";
	//unitId="DU002";
	//lessonId="DL0003";
	//topicid="none";
	//subtopicid="none";
	//qid="new";
	System.out.print("unitid.."+unitId+qid+"in.."+topicid+subtopicid);
	
	edittype="self.focus();"+
			"parent.window.opener.close();"+
			"qid='"+qid+"';"+
			"classid='"+classid+"';"+
			"courseid='"+courseid+"';"+
			"topicid='"+topicid+"';"+
			"subtopicid='"+subtopicid+"';"+
			"qtype='1';"+
			"assmtid='"+assmtid+"';"+
			"pathname='"+pathname+"';";
	
	if(qid.equals("new"))
		edittype=edittype+"help('default');init_temp(1, 1);"+
		"if (INIT_TEMP) {"+
		"initSpan1('l_q_area_id', 'text', 'q_1');"+
		"initSpan1('l_o_area_id', 'text', 'o_1');"+"initSpan1('l_p_area_id', 'textbox', 'h_1');"+
		"initSpan1('l_n_area_id', 'textbox', 'h_1');"+
		"initSpan1('l_d_area_id', 'select', 'h_1');"+
		"initSpan1('l_e_area_id', 'textbox', 'h_1');"+
		"initSpan1('l_s_area_id', 'select', 'h_1');"+
		"initSpan1('l_h_area_id', 'text', 'h_1');"+
		"initSpan1('l_c_area_id', 'text', 'h_1');"+
		"initSpan1('l_i_area_id', 'text', 'h_1');"+
		"chgFocus('l_q_ta0_id');"+
		"}";
	else{
		try{
			edittype=edittype+"help('default');init_temp(1, 1);";
			con=conq.getConnection();
			st=con.createStatement();
			sqlstring="select q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,possible_points,incorrect_response,estimated_time,time_scale from lbcms_dev_assmt_content_quesbody where q_id ='"+qid+"'";
			rs=st.executeQuery(""+sqlstring+"");
			if(rs.next()){
				q_body=rs.getString("q_body");
				ans_str=rs.getString("ans_str");
				hint[0]=rs.getString("hint");
				hint[1]=rs.getString("c_feedback");
				hint[2]=rs.getString("ic_feedback");
					/** Added by ramesh **/
				pointspossible=rs.getString("possible_points");
				IncorrectResponse=rs.getString("incorrect_response");
				difficultLevel=rs.getString("difficult_level");
				estimatedTime=rs.getString("estimated_time");
				timeScale=rs.getString("time_scale");

				temp="addToSpan('l_p_area_id','textbox','h_2',pparam);addToSpan('l_n_area_id','textbox','h_2',nparam);addToSpan('l_d_area_id','select','h_2',dparam);addToSpan('l_e_area_id','textbox','h_2',eparam);addToSpan('l_s_area_id','select','h_2',sparam);";
			}
			con.close();
			Parser p=new Parser();
			hint=p.initParser(qtype,q_body,hint);
			ans_str=p.getAnsStr(ans_str);
			edittype=edittype+hint[0];
			scriptvar=scriptvar+hint[1];
			scriptvar+="var pparam='"+pointspossible+"'; var nparam='"+IncorrectResponse+"';var dparam='"+difficultLevel+"'; var eparam='"+estimatedTime+"'; var sparam='"+timeScale+"';";
			edittype=edittype+temp+"s_ans='"+ans_str+"';write_review1();chgFocus('l_q_ta0_id');";
			
			
			
		}catch(Exception se){
			System.out.println(se);
		}
		finally
	{
			try
			{
				if(st!=null)
					st.close();
				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in....."+se.getMessage());
			}
	}
}
%>
<html>
  <head>
    <title>Editor</title>
	<!----This is not a comment don't delete this --->
	<!--[if IE]>
	<style type="text/css">
	*{
	font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
	}
	</style>
	<![endif]-->
	<link rel="stylesheet" href="q.css" type="text/css">
    <script type="text/javascript" src="q_common.js"></script>
    <script type="text/javascript" src="q_multi_answer.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	<%=scriptvar%>
	</SCRIPT>
  </head>
  <body topmargin="0" leftmargin="0" onContextMenu='return false;' onLoad="<%=edittype%>">


  <table width="100%" height="100%" border="0">
  <tr>
   <td align="left" valign="middle">
  	<table id="t_ed" border="0">
<tr><td align="center" colspan="4">
<hr>
<span class="q_title">Multiple Answers Type</span>
<br><hr>
</td></tr>
	  <tr class="main_panel" vAlign="top">
	    <td id="main_panel_l" align="left" colspan="2">
        <form id="l_qo_form_id" name="l_qo_form" method="post" action=""
	   		enctype="multipart/form-data">
<input name="qid" id="q_id" type="hidden" value="new">
<div id="l_q_top_id" class="f_left"><img src="images/l.gif"></div>
		 <div id="l_mb_q_id" class="l_mb_q">
		   <div class="f_left">
           <input class="m_q_buttons" type="image" src="images/text.gif" title="[text]" 
				onMouseOver="help('addText');"
				onMouseOut="help('default');"
		   		onClick="addToSpan('l_q_area_id','text','q_1','');
				return false;" width="100" height="31"/>
<!--
           <input class="m_qf_buttons" type="image" src="images/file.gif" title="[file]" 
				onMouseOver="help('uploadFile');"
				onMouseOut="help('default');"
				onClick="addToSpan('l_q_area_id','file','q_1','');
				return false;"/>
-->
			<input type="image" src="images/symbols.gif" title="[Symbols]"
				onMouseOver="help('symbols');"
				onMouseOut="help('default');"
				onclick="open_window('symbols.html','sym_win','');return false;">

		   <input type="image" src="images/reset.gif" title="[Reset]"
				onMouseOver="help('reset');"
				onMouseOut="help('default');"
			onclick="refreshQEd(0); return false;">

			<input type="hidden" id="from_id">
		   <input type="hidden" id="SymWin_id">
		   </div>
		   <div class="f_right">
             <input name="q_html_chk" class="m_q_buttons" type="checkbox" 
				onClick="enable_HA=(enable_HA==false)?true:false;"
				style="visibility: hidden"/>
		   </div>
<!--
		   <div class="f_right">
		   <img src="images/enum.gif" title="enum: ">
           <input name="q_enum_chk" class="m_q_buttons" type="checkbox" 
		   		value="" onClick="toggle('l_q_arr')"/>
		   <select name="q_enum_type">
		   	<option value="bullet">bullet</option>
		   	<option value="arabic">1,2,...</option>
		   	<option value="RM_N">I,II,...</option>
		   	<option value="rm_n">i,ii,...</option>
		   	<option value="ROMAN">A,B,...</option>
		   	<option value="roman" selected>a,b,...</option>
		   </select>
		   </div>
-->
		 </div>
		 <div id="l_q_area_id" class="l_q_area">
		 </div>
		 <div id="l_mb_o_id" class="l_mb_o">
		   <div class="f_left">
           <input class="m_o_buttons" type="image" src="images/option.gif"
			   title="[option]" 
				onMouseOver="help('addOptions');"
				onMouseOut="help('default');"
		   		onClick="addToSpan('l_o_area_id','text','o_1','');
				return false;"/>
<!--
           <input class="m_of_buttons" type="image" src="images/file.gif" title="[file]" 
				onMouseOver="help('uploadFile');"
				onMouseOut="help('default');"
				onClick="addToSpan('l_o_area_id','file','q_1','');
				return false;"/>
-->
		   </div>
		   <div class="hide">
		   <img src="images/enum.gif" title="enum: ">
           <input name="o_enum_chk" class="m_o_buttons" type="checkbox" 
		   		value="" onClick="toggle('l_o_arr')"/>
		   <select name="o_enum_type">
		   	<option value="bullet">bullet</option>
		   	<option value="arabic">1,2,...</option>
		   	<option value="RM_N">I,II,...</option>
		   	<option value="rm_n">i,ii,...</option>
		   	<option value="ROMAN">A,B,...</option>
		   	<option value="roman" selected>a,b,...</option>
		   </select>
		   </div>
		 </div>
		 <div id="l_o_area_id" class="l_o_area">
		 </div>
		 <div id="l_b_area_id" class="l_b_area" style="height:185">
		   <table border="0">
		   <tr>
				  <td><font face="Arial" size="2">Points Possible:</font></td>
                  <td>
		   <div id="l_p_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
			<tr>
				  <td><font face="Arial" size="2">IncorrectResponse:</font></td>
                  <td>
		   <div id="l_n_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
		    <tr>
				  <td><font face="Arial" size="2">Difficulty Level:</font></td>
                  <td>
		   <div id="l_d_area_id" class="f_left">
		   </div>
                  </td>
			</tr>
			
			<tr>
				  <td><font face="Arial" size="2">Estimated Time:</font></td>
                  <td>
					 <div id="l_e_area_id" class="f_left">
					 </div><div id="l_s_area_id" class="f_left">
						</div>
                  </td>				
			</tr>

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
		</td>
	    <td id="main_panel_r" align="left" colspan="2">
        <form id="r_qo_form_id" name="r_qo_form">
<div id="r_qo_top_id" class="f_left"><img src="images/r.gif"></div>
		 <div id="r_mb_qo_id" class="r_mb_qo">
		   <div class="f_left">
		   <input id="b_review" class="t_buttons" 
		   		type="image" src="images/review.gif" title="[review]"
		   		onClick="write_review1('q_area_id', 'o_area_id');
//				document.getElementById('b_review').focus();
				return false;">
		   </div>
		   <div class="f_right">

		   <input id="r_b_refresh_id" class="hide"
		   		type="image" src="images/submit.gif" title="[submit]"
		   		onClick="submit_form(0); return false;">

		   <% if(!qid.equals("new")){%>
		   		 <input id="r_b_continue_id" class="t_buttons"
		   		type="image" src="images/modify.gif" title="[submit]"
		   		onClick="submit_form(2);
				return false;">
			<% }else{ %>
	
				<input id="r_b_continue_id" class="t_buttons"
		   		type="image" src="images/submit1.gif" title="[submit1 & Continue]"
		   		onClick="submit_form(1);
				return false;">

			<% } %>
			 </div>
		 </div>
		 <div id="r_qo_area_id" class="r_qo_area" style="height: 385px;> </div>
              <div id="r_f_area_id" class="r_qo_area" style="height:20px"> </div>
		 <div id="r_help_id" class="r_help"> </div>
        </form>
		 <div id="r_fsub_stat" class="f_left" style="width: 400px; height: 60px; overflow: auto"></div>
		 <div id="r_sub_stat" class="f_left" style="width: 400px; height: 150px; overflow: auto"></div>
		</td>
	  </tr>
	</table>
   </td>
  </tr>
</table>
<div id=tparam name=tparam style='visibility:hidden'></div>
  </body>
</html>
