<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.*,common.*,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
		String[] uintIds;
		
%>

<%	
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String oCourseId="",aCourseId="",schoolId="",oUnitId="",aUnitId="",mode="",developerId="",id="",lessonStr="";
	String lessonIds[];
	Hashtable lIds=null;
	String lessonId="";
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	try
	{
		mode=request.getParameter("mode");
		developerId=request.getParameter("userid");
		oCourseId=request.getParameter("ocourseid");
		aCourseId=request.getParameter("acourseid");
		oUnitId=request.getParameter("ounitid");
		aUnitId=request.getParameter("aunitid");
		lessonIds= request.getParameterValues("lessonids");
		
		System.out.println("courseid is .."+oCourseId+"...unit id is ..."+oUnitId+"...lessonIds are "+lessonIds);
		if (lessonIds != null)
		{
			for (int i = 0; i < lessonIds.length; i++)
			{
				
				if(i==0)
				{
					lessonStr=lessonIds[i];
				}
				else
				{
					lessonStr=lessonStr+","+lessonIds[i];
				}				
			}			
		}
		System.out.println("lessonIds..."+lessonIds);
		lIds=new Hashtable();
		StringTokenizer lidTokens=new StringTokenizer(lessonStr,",");
		
		while(lidTokens.hasMoreTokens())
		{
			id=lidTokens.nextToken();
			lIds.put(id,id);
		}

		
		System.out.println("lIds..."+lIds);
		con=con1.getConnection();
		st=con.createStatement();
		for(Enumeration e1 = lIds.elements() ; e1.hasMoreElements() ;)
			{
				
				lessonId=(String)e1.nextElement();
				System.out.println("lessonId..."+lessonId);					
					
				
			}							// End of Units
			
			//response.sendRedirect("CrtLessonArchives.jsp?userid="+developerId);

		}
	catch(Exception e)
	{
		System.out.println("The exception1 in CrtLessonArchives.jsp is....."+e);
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
				System.out.println("The exception2 in CrtLessonArchives.jsp is....."+se.getMessage());
			}
		}
	
%>