<%@ include file="/common/checksession.jsp" %> 
<script language="javascript" type="text/javascript">
var http = getHTTPObject();
var v="";
function getHTTPObject() {
	var xmlhttp;
	var result="";
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	} return xmlhttp;
}
function handleHttpResponse() {
	
	if (http.readyState == 4) {
	if (http.status==200){
            alert("In HandleHTTPResponse");  
			
            
			var message=http.responseXML.getElementsByTagName("root");
			result="<table>";
			for(i=0; i<message.length;i++)
			{
				v=message[i].getElementsByTagName('data');
				
				for(j=0;j<v.length;j++)
				{
					result=result+"<tr><td width=78><input type=checkbox name=c_data value="+v[j].getElementsByTagName('check_data')[0].firstChild.nodeValue+"></td>";
					if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Directory")
					{
						result=result+"<td width=243><img src=../images/closed.gif width=18 height=12>";
						result=result+"<a href=foldersList.jsp?fol_name="+
							v[j].getElementsByTagName('fol_name')[0].firstChild.nodeValue+
							" style=font-family: times new roman;text-decoration:none; align=middle>"+
							v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</a></td>";
						result=result+"<td width=162>Directory</td>";
						result=result+"<td width=109>"+
							v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</td></tr>";
					}
					else
					{
						alert(v[j].getElementsByTagName('path')[0].firstChild.nodeValue);
						result=result+"<td width=243>";
						if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Text")
						{
							result=result+"<img src=../images/text.gif width=20 height=20>";
							
							result=result+"<a href=# onclick=open_new('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"') style=font-family: times new roman;text-decoration:none;>";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Document")
						{
							result=result+"<img src=../images/word.gif width=21 height=20>";
							
							result=result+"<a href=# onclick=open_word('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"') style=font-family: times new roman;text-decoration:none;>";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="PDF")
						{
							result=result+"<img src=../images/pdf.jpg width=20 height=20>";

							result=result+"<a href=# onclick=open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"') style=font-family: times new roman;text-decoration:none;>";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="ZIP")
						{
							result=result+"<img src=../images/pdf.jpg width=20 height=20>";

							result=result+"<a href=# onclick=open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"') style=font-family: times new roman;text-decoration:none;>";
						}
						result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</a></td>";

						result=result+"<td width=162>"+
							v[j].getElementsByTagName('type')[0].firstChild.nodeValue+"</td>";
						
						result=result+"<td width=109>"+
							v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</td></tr>";



					}
				}
				
			}
			document.getElementById("test").innerHTML=result;
            
	}
	
	}	
}
if (http.overrideMimeType);
 http.overrideMimeType('text/xml');
function filesData() {
	
               
       
	http.open("GET", "FileList.jsp", true);	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);
}
</script>
<body onload="filesData()">
<div id="test">
</div>
</body>