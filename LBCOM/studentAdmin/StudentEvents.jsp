<%@page language="java" %>
<%@page import="java.sql.*,java.io.*,java.util.Date,java.util.*,java.text.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
	String studentId="", schoolid="",courseId="",classId="",courseName="",className="",selDate="";
%>
<%


try
{
	
	%>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>&nbsp;<!-- <div width="80%" id="cal"></div> -->
				  
				  <span style="vertical-align:top;">
			<fieldset style="width:220px;padding:5px;">
				<!-- <legend>Calendar</legend> -->

				<input type="hidden" name="tester" id="tester" value=""/>
				<p/>
				<input type="text" name="tester_day" id="tester_day" value="" size="3" maxLength="2" />
				<select name="tester_month" id="tester_month">
					<option value="1">January</option>
					<option value="2">February</option>
					<option value="3">March</option>
					<option value="4">April</option>
					<option value="5">May</option>
					<option value="6">June</option>
					<option value="7">July</option>
					<option value="8">August</option>
					<option value="9">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select>
				<input type="text" name="tester_year" id="tester_year" value="" size="5" maxLength="4"/>
				<p/>
				<div id="cal_tester_display"></div>

				<!-- Retreiving the dates from db -->
<%

					con=con1.getConnection();
					st=con.createStatement();
					String strDate="",formattedDate="";
					int i=0;
					%>
					<script type="text/javascript">

					cal1 = new Calendar ("cal1", "tester", new Date());
					renderCalendar (cal1);
					cal1 = new Calendar ("cal1", "tester", new Date());
					cal1.eventDates = new Array(
<%				
					studentId = (String)session.getAttribute("emailid");
					rs = st.executeQuery("select sdate from event where owner='"+studentId+"'");
					while(rs.next())
					{
						i++;
						strDate =rs.getString("sdate");
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						Date dateStr = formatter.parse(strDate);
						formattedDate = formatter.format(dateStr);
						Date date1 = formatter.parse(formattedDate);

						formatter = new SimpleDateFormat("yyyy/M/d");
						formattedDate = formatter.format(date1);
						if(!rs.isLast())
						{
%>
					
					new Array("<%=formattedDate%>", <%=i%>),
<%
					}
					else
					{
						%>new Array("<%=formattedDate%>", <%=i%>)<%
					}
					}
					rs.close();
					st.close();
%>
					);
					cal1.scrolling = false;
					cal1.selectEvent = function(eventId) 
					{
						//window.location.href=window.location.href;
						
							//alert("I am here");
						$("#nav_main li").removeClass('selected');showLoading('grid');$("#calendar_main").addClass('selected');grid_content.load("/LBCOM/calendar/CalendarMain.jsp?type=teacher&sel_date="+eventId, hideLoading);
						}

					renderCalendar (cal1);
				</script>
				<!-- Uptohere -->
			</fieldset>
		</span>

				  
				  </td>
				  <tr>
                <td width="100%" height="50%">
				<!-- <div width="100%" id="cal_next">&nbsp;
				</div> -->
		</td>
		 <td width="84%" valign="top" height="100%">
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="90%" id="AutoNumber4">
              <tr>
                <td width="100%" height="20%">
					<table width="100%">
					<tr><td align="left"><div id="back">&nbsp;</div> </td>
						<td align="right"><div id="weak"></div> </td>
						<td align="right"><div id="date"></div></td>
					</tr>
					</table>
				</td>
              </tr>
              
			  <tr>
                <td width="100%" height="65%"><div id="data" height="100%"></div></td>
              </tr>
            </table>
            </td>
              </tr>
                  
              </table>

			
            
            <!-- <div class="Sbuttons" id="event_but">ADD EVENT</div>
            <div class="Sbuttons" id="address_but">ADDRESS BOOK</div> -->
          
<%
		  
}
	  catch(Exception e){
		ExceptionsFile.postException("Event.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			
			if(st!=null)
			st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("Event.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
	%>

