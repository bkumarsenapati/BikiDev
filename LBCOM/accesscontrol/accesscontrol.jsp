<script language="javascript" src="/LBCOM/accesscontrol/ac.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	<%
		try{
			String schoolid1=(String)session.getAttribute("schoolid");			
			String logintype=(String)session.getAttribute("logintype");
			String uid=(String)session.getAttribute("emailid");
			String username1=request.getParameter("user");
			con = db.getConnection();	
			st = con.createStatement();
			stmt = con.createStatement();
			String query="SELECT field_ids FROM form_access where form_id='"+formid+"'";
			rs=st.executeQuery(query);
			if(rs.next())
			{
	%>		
	var ac_ids="<%=rs.getString("field_ids")%>";
	<%
			}
			query="SELECT  status FROM  form_access_user_level where school_id='"+schoolid1+"' and form_id='"+formid+"' and uid='"+uid+"' and utype='"+logintype.charAt(0)+"'";
			rs=st.executeQuery(query);
			if(rs.next())
			{
	%>
	var ac_status="<%=rs.getString("status")%>";
	<%
			}else{
				query="SELECT "+logintype.charAt(0)+"_status FROM  form_access_group_level where school_id='"+schoolid1+"' and form_id='"+formid+"'";
				rs=st.executeQuery(query);
				if(rs.next())
				{
					%>
					var ac_status="<%=rs.getString(1)%>";
					<%

				}
				else{
					%>
					var ac_status="";
					<%				
				}}
		con.close();
		}catch(Exception e){
			System.out.println("Rajesh"+e);
		}
	%>	
</SCRIPT>
