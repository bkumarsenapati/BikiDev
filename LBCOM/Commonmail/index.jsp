<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%!
	synchronized  void createSession(String appPath,String schoolPath,String schoolId,String userId,String sessid)
	{
		File fileObj=null;
		Runtime runtime=null;
		try  
		{
			String seFolder=sessid+"_"+userId;
			fileObj=new File(appPath+"/sessids/"+seFolder+"/"+schoolId);
			if(!fileObj.exists()){
					runtime = Runtime.getRuntime();
			                runtime.exec("ln -s "+schoolPath+"/"+schoolId+"  "+appPath+"/sessids/"+seFolder+"/"+schoolId);
		         }
		}
		catch(Exception se)
		{
			System.out.println("Exception in Commonmail/index.jsp is...."+se.getMessage());			
		}
		
		finally
		{
			try  
			{
				if(fileObj!=null)
					fileObj=null;
				if(runtime!=null)
					runtime=null;
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("index.jsp","createSession()","Exception",e.getMessage());
			}
		}
	}
%>
<%
        int crflag = 0;
	String loginType="",schoolId="",userId="",mode="",url="";
        ResultSet  rs=null;
	Connection con=null;
	Statement st=null;

	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
  
try{	
  	schoolId=(String)session.getAttribute("schoolid");
	userId=(String)session.getAttribute("emailid");
  	loginType=(String)session.getAttribute("logintype");
  	session.setAttribute("attach",null);
	
	mode= request.getParameter("mode");
	if(mode.equals("bulk"))
	{
		url="/LBCOM/Commonmail/BulkInbox.jsp?anc=bulkmail";
	}
	if(mode.equals("inbox"))
	{
		url="/LBCOM/Commonmail/Inbox.jsp?folder=Inbox";
	}
		
  
	if(loginType.equals("student"))
	{
  		con=db.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+userId+"' and schoolid='"+schoolId+"'");
		if(rs.next())
		{
		    crflag = rs.getInt("crossregister_flag");
		}
		if(crflag==1)
		{
		        String appPath=application.getInitParameter("app_path");
			String schoolPath=application.getInitParameter("schools_path");
        		rs=st.executeQuery("select schoolid from studentprofile where username='"+schoolId+"_"+userId+"'");
			while(rs.next())
			{  
			         createSession(appPath, schoolPath, rs.getString("schoolid"), userId, sessid);         
			}
	        }
		if(crflag==2)
		    return;		
        }
  
}catch(Exception e){
		ExceptionsFile.postException("index.jsp","operations on database in email","Exception",e.getMessage());
		
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("index.jsp","closing statement and connection objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
   
%>


<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script>
//changed id since div is bad for iframes. :)
$(window).load( function()
{
var ifr1 = $( $('#iframe1').contents() ); 
var ifr2 = $( $('#iframe2').contents() );
ifr1.scroll( function()
{ 
console.log("scroll");
ifr2.scrollTop(ifr1.scrollTop());
ifr2.scrollLeft(ifr1.scrollLeft());  
});  
ifr2.scroll( function()
{      
ifr1.scrollTop(ifr2.scrollTop());    
ifr1.scrollLeft(ifr2.scrollLeft());  
});
}); 

</script> 
<title><%=application.getInitParameter("title")%></title>

<script>
//var logopath = "<%= session.getAttribute("logopath")%>";
</script>
</head>

	<frameset rows="30,0,*"name="mail" border="0" frameborder="0" framespacing="0">
		<frame src='LeftFrameMail.jsp' name="leftmail" target="mainmail" scrolling="auto" marginwidth="0" marginheight="0" border="0"  id="iframe1">
		<frame name="refreshframe" target="mainmail" scrolling="auto" noresize border="0">
		<frame src='<%=url%>' name="mainmail" scrolling="auto" noresize border="0"  id="iframe2">
	</frameset>

</html>
