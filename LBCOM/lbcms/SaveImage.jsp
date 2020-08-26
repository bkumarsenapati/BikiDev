<%@ page import="java.sql.*"%> 

<%@ page import="java.io.*"%> 

<%

Connection con=null; 

ResultSet rs=null; 

PreparedStatement psmt=null; 

FileInputStream fis;

String url="jdbc:mysql://localhost:3306/lbcomrtdb"; 

try{ 

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

con=DriverManager.getConnection(url,"root","whizkids");
System.out.println("con..."+con);

File image=new File("C:/Tomcat5/webapps/LBCOM/images/1.5.gif"); 


psmt=con.prepareStatement("insert into lbcms_dev_sec_icons(name,city,image)"+"values(?,?,?)"); 

psmt.setString(1,"sultan"); 

psmt.setString(2,"Hyd"); 


fis=new FileInputStream(image); 


psmt.setBinaryStream(3, (InputStream)fis, (int)(image.length())); 

int s = psmt.executeUpdate(); 


if(s>0) { 

%> 
<b><font color="Blue"> 
<% out.println("Image Uploaded successfully !"); %> 
</font></b> 
<% 
}

else { 

out.println("unsucessfull to upload image."); 

}

con.close();

psmt.close();

}catch(Exception ex){ 

out.println("Error in connection : "+ex); 

}


%>
 
