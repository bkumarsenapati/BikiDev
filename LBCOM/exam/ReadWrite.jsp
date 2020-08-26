<%@ page import="java.io.*,java.lang.*"  %> 
<html> 
<head> 
<title>Read write file JSP</title> 
</head> 

<body> 
<% 
System.out.println("1.........Hi");
String fileName="santhosh.html"; 
System.out.println("2........Hi");

File f=new File(fileName); 
System.out.println("3........Hi"+f);

InputStream in = new FileInputStream("C:/1.html"); 

System.out.println("4........Hi"+in);

BufferedInputStream bin = new BufferedInputStream(in); 
System.out.println("5........Hi");

DataInputStream din = new DataInputStream(bin); 
System.out.println("6........Hi");
StringBuffer sb=new StringBuffer(); 
System.out.println("7........Hi");
	while(din.available()>0) 
	{ 
		System.out.println("8...while.....Hi");
		sb.append(din.readLine()); 
    } 
	System.out.println("9 after while........Hi");

	try
	{    
		PrintWriter pw = new PrintWriter(new FileOutputStream("C:/1_1.html"));// save file 
		System.out.println("10 after while........Hi.."+sb);
		System.out.println("Length..."+sb.length());

		sb=sb.replace(309,381,"<script>function verify(m,max){	var kk=0;var txt= document.getElementsByName(m.name)	var tFldId=document.getElementById(m.id);alert(tFldId.type);	return;	if(tFldId.readOnly==false)	{for(var i=0;i<txt.length;i++)		if(txt[i]==m)		{var kk=i;break;}				var max1=100;if(m.value>max1) 		{ alert('Maximum points for this answer are '+max+'.');txt[kk].select();}else {			if(m.value!=\"\"){calc();for(var j=0;j<txt.length;j++){if(trim(txt[j].value)==\"\"){txt[j].focus();break;}}}}}}function calc(){var len,win,q,tot,temp;	var ar;	tot=0;	alert(q);	for(var i=0;i<arr.length;i++) 	{q=arr[i];		win=document.q_paper.elements[q];len=win.length;ar=new Array(len);if(!win.length) {if (trim(win.value)=='')				tot=parseFloat(tot+0);else tot=parseFloat(tot+parseFloat(win.value));}else{for(var j=0;j<len;j++) if(trim(win[j].value)=='')ar[j]=0;else					ar[j]=win[j].value;for(j=0;j<len-1;j++) {for(var k=j+1;k<len;k++) {					if(parseInt(ar[j])<parseInt(ar[k])) {temp=ar[j];ar[j]=ar[k];ar[k]=temp;}}}for(j=0;j<maxarr[i];j++) {if((ar[j]=='')||(!ar[j]))					tot=parseFloat(tot+0)else tot=parseFloat(tot+parseFloat(ar[j]));}}}if(isNaN(tot))alert('Enter proper values!');	else		parent.fb_f.document.sub.marks.value=tot;}</script>");
		
		//381sb=sb.insert(309,"<script language='javascript' src='/LBCOM/common/evaluation.js'></script><script>function verify(m,max){	var kk=0;var txt= document.getElementsByName(m.name)	var tFldId=document.getElementById(m.id);alert(tFldId.type);	return;	if(tFldId.readOnly==false)	{for(var i=0;i<txt.length;i++)		if(txt[i]==m)		{var kk=i;break;}				var max1=100;if(m.value>max1) 		{ alert('Maximum points for this answer are '+max+'.');txt[kk].select();}else {			if(m.value!=\"\"){calc();for(var j=0;j<txt.length;j++){if(trim(txt[j].value)==\"\"){txt[j].focus();break;}}}}}}function calc(){var len,win,q,tot,temp;	var ar;	tot=0;	alert(q);	for(var i=0;i<arr.length;i++) 	{q=arr[i];		win=document.q_paper.elements[q];len=win.length;ar=new Array(len);if(!win.length) {if (trim(win.value)=='')				tot=parseFloat(tot+0);else tot=parseFloat(tot+parseFloat(win.value));}else{for(var j=0;j<len;j++) if(trim(win[j].value)=='')ar[j]=0;else					ar[j]=win[j].value;for(j=0;j<len-1;j++) {for(var k=j+1;k<len;k++) {					if(parseInt(ar[j])<parseInt(ar[k])) {temp=ar[j];ar[j]=ar[k];ar[k]=temp;}}}for(j=0;j<maxarr[i];j++) {if((ar[j]=='')||(!ar[j]))					tot=parseFloat(tot+0)else tot=parseFloat(tot+parseFloat(ar[j]));}}}if(isNaN(tot))alert('Enter proper values!');	else		parent.fb_f.document.sub.marks.value=tot;}</script>");
		
		pw.println(sb.toString()); 
		pw.close(); 
	}
	catch(IOException e)
	{ 
		e.getMessage(); 
	} 
          
in.close(); 
bin.close(); 
din.close(); 
%> 
Successfully write file .................)))))((((( Hi
</body> 
</html> 
