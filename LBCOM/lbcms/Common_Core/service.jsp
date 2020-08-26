<%@page contentType="text/html; charset=UTF-8"%> 
<%@page import="org.json.simple.JSONObject"%>  
<% 
JSONObject obj=new JSONObject();
obj.put("name","foo"); 
obj.put("num",new Integer(100));   
obj.put("balance",new Double(1000.21)); 
obj.put("is_vip",new Boolean(true));
obj.put("nickname",null);
out.print(obj);  
out.flush();
%>