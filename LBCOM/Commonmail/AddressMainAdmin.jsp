<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Hashtable" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
        String userId="",schoolId="",queryString="",toGroup="",toSchool="",toUser="",userType="",corcId="",groupType="";	
	Hashtable userTable = new Hashtable();
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
            schoolId=(String)session.getAttribute("schoolid");
	    userId=(String)session.getAttribute("emailid");
	    userType=(String)session.getAttribute("logintype");
	
  	    toUser = request.getParameter("userparam");
  	    toSchool = request.getParameter("schoolparam");
	    corcId = request.getParameter("corcparam");
	    groupType = request.getParameter("groupparam");
	    
	     
 try{
            con=db.getConnection();
	    st=con.createStatement();
	    
                   
    if((toUser!=null)&&(toUser.equals("teacher")))
    {    
     	  if((groupType!=null)&&(groupType.equals("class")))
      	  {
                rs=st.executeQuery("select username, firstname, lastname from teachprofile where schoolid='"+toSchool+"' and class_id='"+corcId+"'");
		while(rs.next())
		{
		    userTable.put(rs.getString("username")+"@"+toSchool, rs.getString("firstname")+" "+rs.getString("lastname"));
		}
           }else if((groupType!=null)&&(groupType.equals("course")))
	   {
	         rs=st.executeQuery("select username, firstname, lastname from teachprofile where username=any(select teacher_id from coursewareinfo where course_id='"+corcId+"' and school_id='"+toSchool+"') and schoolid='"+toSchool+"'");
		 while(rs.next())
		 {
		      userTable.put(rs.getString("username")+"@"+toSchool, rs.getString("firstname")+" "+rs.getString("lastname"));
		 }
	   }	    
    }else if((toUser!=null)&&(toUser.equals("student")))
    {
           if((groupType!=null)&&(groupType.equals("class")))
      	   {
                rs=st.executeQuery("select username, fname, lname from studentprofile where grade='"+corcId+"' and schoolid='"+toSchool+"' and crossregister_flag in(0,1,2)");
                while(rs.next())
		 {
		      userTable.put(rs.getString("username")+"@"+toSchool, rs.getString("fname")+" "+rs.getString("lname"));
		 }
	   }else if((groupType!=null)&&(groupType.equals("course")))
	   {
	          rs=st.executeQuery("select username, fname, lname from studentprofile where username=any(select student_id from coursewareinfo_det where course_id='"+corcId+"' and school_id='"+toSchool+"') and schoolid='"+toSchool+"' and crossregister_flag in(0,1,2)");
	          while(rs.next())
		  {
		      userTable.put(rs.getString("username")+"@"+toSchool, rs.getString("fname")+" "+rs.getString("lname"));
		  }
	   }
    }else if((toUser!=null)&&(toUser.equals("admin")))
    {
           rs=st.executeQuery("select schoolname from school_profile where schoolid='"+toSchool+"'");
	   while(rs.next())
	   {
	         userTable.put("admin@"+toSchool, rs.getString("schoolname"));
	   }
    }
	    
    SortedSet userSet = new TreeSet(userTable.keySet()); 
	      
%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
	var str = "";
	var limit =0;	
	
	function validate(){	
		var flag;
		var obj=document.menuidslist;
		var openerwin = parent.opener.window.document.getElementById("toaddress");
	  	var rtype = parent.opener.window.document.getElementById("rtype");
		getSelectedIds();
		if(limit>15)
		 {    
		    alert("You can select a maximum of 15 ids at a time");
	       	    return false;
		  }
		if(rtype.value=="normal")
		  {
		 	if(openerwin.value=="") 
		       		openerwin.value = str;
		 	else{
		       		openerwin.value = openerwin.value + "," +str;
		           }
		  }else{
		         rtype.value = "normal";
		         openerwin.value = str;
		    }	      
		parent.window.close();
		}

   	function getSelectedIds()
   	{
		  str="";
		  limit=0;
		  var obj=document.menuidslist;
		  	  
     		  for(i=0;i<obj.elements.length;i++)
		   {
		     	if (obj.elements[i].type=="checkbox"){
				 if(obj.elements[i].name=="selids" && obj.elements[i].checked==true)
	                  	   {
				         limit++;
					 if(str=="")
				   	     str = obj.elements[i].value;
					 else
					     str = str + "," + obj.elements[i].value;    
				   }
			   }
		    }	   
   	}

   function selectAll(){
		var obj=document.menuidslist.selids;
		if(document.menuidslist.selectall.checked==true){
			for(var i=0;i<obj.length;i++){
				obj[i].checked=true;
			}

		}else{
			for(var i=0;i<obj.length;i++){
				obj[i].checked=false;
			}

		}
	}


</SCRIPT>
</head>
<body>
<form name="menuidslist" onsubmit="return validate();">

<table border="0" cellspacing="1" width="100%" id="AutoNumber1" height="41" bordercolorlight="#FFFFFF">
  <tr>
    <td width="5%" bgcolor="#EBEADB" height="18">
    <input type="checkbox" name="selectall" onclick="javascript:selectAll()" value="ON" ></td>
    <td width="47%" bgcolor="#EBEADB" height="18"><font face="Arial" size="1">&nbsp;Id</font></td>
    <td width="48%" bgcolor="#EBEADB" height="18"><font face="Arial" size="1">&nbsp;Name</font></td>
  </tr>
  <tr>
           <td></td>
         <td><input type="submit" value="Add"></td>
         <td></td>
</tr>
<%  
  Iterator itr = userSet.iterator();
  while(itr.hasNext())
  {
         String id = (String)itr.next();
%>	   
  	<tr>
    	   <td height="19" bgcolor="#F7F7F7"><input type="checkbox" name="selids" value="<%=id%>"></td>	
    	   <td height='19' bgcolor='#F7F7F7'><font face="Arial" size="1">&nbsp;<%=id%></font></td>
           <td height='19' bgcolor='#F7F7F7'><font face="Arial" size="1">&nbsp;<%=userTable.get(id)%></font></td>
	</tr>
 
 <% }		
 }catch(Exception e){
		ExceptionsFile.postException("AddressMain.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddressMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }

%>
      <tr>
         <td></td>
         <td><input type="submit" value="Add"></td>
         <td></td>
      </tr>	 
</table>
</form>
</body>
</html>