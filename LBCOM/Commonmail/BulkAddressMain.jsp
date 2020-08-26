<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Hashtable" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
        String loginType="", type="", schoolId="", userId="";	
	Hashtable idTable = new Hashtable();
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String sessId;
	sessId=(String)session.getAttribute("sessid");
			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}

  	    loginType = (String)session.getAttribute("logintype");
  	    schoolId =  (String)session.getAttribute("schoolid");
	    userId = (String)session.getAttribute("emailid");
	    type = request.getParameter("typeparam"); 
 try{
            con=db.getConnection();
	    st=con.createStatement();
     
     if(type.equals("class"))
     {
          if(loginType.equals("teacher"))     
          {
	     rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+userId+"' and school_id='"+schoolId+"')");
	       while(rs.next())
	       {
	          idTable.put(rs.getString("class_id"), rs.getString("class_des"));
	       }
	     
	  }else if(loginType.equals("admin"))
	        { 
	           rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where  school_id='"+schoolId+"')");
	       		while(rs.next())
	       		{
	          		idTable.put(rs.getString("class_id"), rs.getString("class_des"));
	       		}		  
	        }
     }else if(type.equals("course"))     
          {
	     if(loginType.equals("teacher"))     
              {
	         rs=st.executeQuery("select course_id, course_name from coursewareinfo where teacher_id='"+userId+"' and school_id='"+schoolId+"' and status>0");
	       while(rs.next())
	       {
	          idTable.put(rs.getString("course_id"), rs.getString("course_name"));
	       }
	     
	  }else if(loginType.equals("admin"))
	        { 
	            rs=st.executeQuery("select course_id, course_name from coursewareinfo where school_id='"+schoolId+"' and status>0");
	       		while(rs.next())
	       		{
	          		idTable.put(rs.getString("course_id"), rs.getString("course_name"));
	       		}		  
	        }
      }	          
	      
%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
	//var checked=new Array();
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
		  if(rtype.value=="bulk")
		  {
		 	if(openerwin.value=="") 
		       		openerwin.value = str;
		 	else{
		       		openerwin.value = openerwin.value + "," +str;
		           }
		  }else{
		         rtype.value = "bulk";
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

<table border="0" cellspacing="1" width="420" id="AutoNumber1" height="41" bordercolorlight="#FFFFFF">
  <tr>
    <td width="20" bgcolor="#EBEADB" height="18">
    <input type="checkbox" name="selectall" onclick="javascript:selectAll()" value="ON" ></td>
    <td width="200" bgcolor="#EBEADB" height="18"><font face="Arial" size="1">&nbsp;Id</font></td>
    <td width="200" bgcolor="#EBEADB" height="18"><font face="Arial" size="1">&nbsp;Name</font></td>
  </tr>
  <tr>
           <td></td>
         <td><input type="submit" value="Add"></td>
         <td></td>
</tr>
<%  
  SortedSet userSet = new TreeSet(idTable.keySet());
  Iterator itr = userSet.iterator();
  while(itr.hasNext())
  {
         String id = (String)itr.next();
%>	   
  	<tr>
    	   <td width="20" height="19" bgcolor="#F7F7F7"><input type="checkbox" name="selids" value="<%=id%>"></td>	
    	   <td width='200' height='19' bgcolor='#F7F7F7'><font face="Arial" size="1">&nbsp;<%=id%></font></td>
           <td width='200' height='19' bgcolor='#F7F7F7'><font face="Arial" size="1">&nbsp;<%=idTable.get(id)%></font></td>
	</tr>
 
 <% }		
 }catch(Exception e){
		ExceptionsFile.postException("BulkAddressMain.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("BulkAddressMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
      <tr>
         <td width="20"></td>
         <td width="200"><input type="submit" value="Add"></td>
      </tr>	 
</table>
</form>
</body>
</html>