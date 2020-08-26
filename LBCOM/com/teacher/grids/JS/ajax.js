var v="";
var result="";
var http = getHTTPObject();
function getHTTPObject() {
	
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	} return xmlhttp;
}
function handleHttpResponse() {
	var root_path="";
	if (http.readyState == 4) {
	if (http.status==200){
            
            
			var message=http.responseXML.getElementsByTagName("root");
			result="<table width=\"100%\" valign=\"top\" border=0>";
			var j=0;
			for(i=0; i<message.length;i++)
			{
				v=message[i].getElementsByTagName('data');
				
				for(j=0;j<v.length;j++)
				{
					
					
					if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Directory")
					{
						if(v[j].getElementsByTagName('name')[0].firstChild.nodeValue!="DMS_image")
						{
						result=result+"<tr><td width=\"4%\"><input type=checkbox name=c_data value=\""+v[j].getElementsByTagName('check_data')[0].firstChild.nodeValue+"\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px\"></td>";
						result=result+"<td width=\"3%\"></td><td width=\"3%\"><a href=\"list.jsp?fol_name="+
							v[j].getElementsByTagName('fol_name')[0].firstChild.nodeValue+
							"\" style=\"font-family: arial;text-decoration:none;\"><img src=../images/closed.gif width=18 height=12 border=0></a></td><td width=\"37%\">";
						result=result+"<a href=\"#\" style=\"font-family: arial;text-decoration:none;\" onclick=\"folderData('"+v[j].getElementsByTagName('fol_name')[0].firstChild.nodeValue+"')\"><font face=\"Arial\"><span style=\"font-size:10pt;\">"+
							v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td>";
						result=result+"<td width=\"3%\" align=\"center\"></td>";
						result=result+"<td width=\"10%\"><font face=\"Arial\"><span style=\"font-size:10pt;\">Directory</span></font></td>";
						result=result+"<td width=\"10%\"></td>";
						if(v[j].getElementsByTagName('date')[0].firstChild.nodeValue=="null")
							{
							result=result+"<td width=\"20%\"><font face=\"Arial\"><span style=\"font-size:10pt;\">Zip ext folder</span></font></td>";
						}else
							{
						result=result+"<td width=\"20%\"> <font face=\"Arial\"><span style=\"font-size:10pt;\">"+
						v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</span></font></td>";
							}
						result=result+"<td width=\"10%\"></td></tr>";
						}
					}
					else
					{
						result=result+"<tr><td width=\"4%\"><input type=checkbox name=c_data value=\""+v[j].getElementsByTagName('check_data')[0].firstChild.nodeValue+"\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px\"></td>";
						
						
						if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Text")
						{
							/*var v=v[j].getElementsByTagName('share')[0].firstChild.nodeValue;
							var fnl=v.substring(0,v.lastIndexOf("-"));
							
							*/
							if(v[j].getElementsByTagName('status')[0].firstChild.nodeValue=="false" || v[j].getElementsByTagName('share')[0].firstChild.nodeValue.substring(0,v[j].getElementsByTagName('share')[0].firstChild.nodeValue.lastIndexOf("-"))=="false")
							{
								
								result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=../images/text.gif width=16 height=16   border=0></a></td>";
								result+="<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=../images/text.gif width=16 height=16   border=0></a></td>";

								result=result+"<td width=\"37%\">";
							
							result=result+"<a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\" method=\"post\">";
							result=result+"<font face=\"Arial\"><span style=\"font-size:10pt;\">"+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</font></a></td>";

							result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/lock.jpg\" width=\"16\" height=\"16\" border=\"0\" alt=\"edit\" valign=\"bottom\"></a></td>";
							}
							else
							{

							result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"open_download('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\"><img src=../image/downloads.jpeg width=16 height=16 alt=\"Download\"  border=0></a></td>";
							result+="<td width=\"3%\"><a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\"><img src=../images/text.gif width=16 height=16  alt=\"View\"  border=0></a></td>";

							result=result+"<td width=37%>";
							
							result=result+"<a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\" method=\"post\">";
							result=result+"<font face=\"Arial\"><span style=\"font-size:10pt;\">"+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</font></a></td>";

							result=result+"<td width=\"3%\" align=\"center\"><a href=\"#\" onclick=\"open_new('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/edit.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Edit\" valign=\"bottom\"></a></td>";
							}
							
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Document")
						{
						
							if(v[j].getElementsByTagName('status')[0].firstChild.nodeValue=="false" || v[j].getElementsByTagName('share')[0].firstChild.nodeValue.substring(0,v[j].getElementsByTagName('share')[0].firstChild.nodeValue.lastIndexOf("-"))=="false")
							{
								
								result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/lock.jpg\" width=\"16\" height=\"16\" border=\"0\" alt=\"edit\" valign=\"bottom\"></a></td>";
								result+="<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/lock.jpg\" width=\"16\" height=\"16\" border=\"0\" alt=\"edit\" valign=\"bottom\"></a></td>";
							}
							else
							{
								
								result=result+"<td width=\"3%\"><a href=\"#\"  onclick=\"open_download('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../image/downloads.jpeg width=16 height=16 border=0></a></td>";
								result+="<td width=\"3%\"><a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../images/word.gif width=16 height=16 border=0></a></td>";
							}
							result=result+"<td width=\"37%\">";
							
							result=result+"<a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\" method=\"post\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td><td width=\"3%\" align=\"center\"></td>";
						}
				
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="html")
						{
							if(v[j].getElementsByTagName('status')[0].firstChild.nodeValue=="false" || v[j].getElementsByTagName('share')[0].firstChild.nodeValue.substring(0,v[j].getElementsByTagName('share')[0].firstChild.nodeValue.lastIndexOf("-"))=="false")
							{
								
								result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"> <img src=../images/html.gif width=16 height=16 border=0></a></td>";
								result+="<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=../images/html.gif width=16 height=16 border=0></a></td>";
							//Name	
							result=result+"<td width=\"37%\">";
							
							result=result+"<a href=\"#\"  onclick=\"alert('This file is edited with other user')\"  style=\"font-family: arial;text-decoration:none;\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td>";
							//
							result=result+"<td width=\"3%\"><a href=\"#\" onclick=\"alert('This file is edited with other user')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/lock.jpg\" width=\"16\" height=\"16\" border=\"0\" alt=\"edit\" valign=\"bottom\"></a></td>";
							}
							else
							{
								result=result+"<td width=\"3%\"><a href=\"#\"  onclick=\"open_download('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../image/downloads.jpeg width=16 height=16 alt=\"Download\" border=0></a></td>";
								result+="<td width=\"3%\"><a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../images/html.gif width=16 height=16 alt=\"View\" border=0></a></td>";
									result=result+"<td width=\"37%\">";
							
							result=result+"<a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td>";
							
							result=result+"<td width=\"3%\" align=\"center\"><a href=\"#\" onclick=\"open_word('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/edit.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"edit\" valign=\"bottom\"></a></td>";
							}
						}



						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="PDF")
						{
							result=result+"<td width=\"3%\"><a href=\"#\"  onclick=\"open_download('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../image/downloads.jpg width=16 height=16 border=0></a></td>";
							result+="<td width=\"3%\"> <a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../images/pdf.jpg width=16 height=16 border=0></a></td>";
							result=result+"<td width=\"37%\">";

							result=result+"<a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td><td width=\"3%\" align=\"center\"></td>";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="ZIP")
						{
							//result=result+"<td width=\"16\"></td>";
							result=result+"<td width=\"3%\"><a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../images/zip.gif width=16 height=16 border=0></td>";
							result+="<td width=\"3%\"><a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../images/zip.gif width=16 height=16 border=0></td>";
							result=result+"<td width=\"37%\">";

							
							result=result+"<a href=\""+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"\"  style=\"font-family: arial;text-decoration:none;\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td><td width=\"4%\" align=\"center\"><a href=\"unzipFile.jsp?unzip_file_path="+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/unzip.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"unzip\" valign=\"bottom\"></a></td>";
						}
						else
						{
							/*result=result+"<a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\">";
							*/
							result=result+"<td width=\"3%\"><td width=\"3%\"><a href=\"#\"  onclick=\"open_download('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"><img src=../image/downloads.jpg width=16 height=16 border=0></a></td><td width=\"3%\"></td>";
							result=result+"<td width=\"37%\"><a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"','"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\" method=\"post\"><font face=\"Arial\"><span style=\"font-size:10pt;\">";
							result=result+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td><td width=\"3%\" align=\"center\"><a href=\"#\"  onclick=\"open_pdf('"+v[j].getElementsByTagName('url')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\"></td>";
						}
						

						result=result+"<td width=\"10%\"><font face=\"Arial\"><span style=\"font-size:10pt;\">"+
							v[j].getElementsByTagName('type')[0].firstChild.nodeValue+"</span></font></td>";
						result=result+"<td width=\"10%\"><font ><font face=\"Arial\"><span style=\"font-size:10pt;\"><i>"+
							v[j].getElementsByTagName('size')[0].firstChild.nodeValue+"</i></span></font></td>";
						if(v[j].getElementsByTagName('date')[0].firstChild.nodeValue=="null")
							{
							result=result+"<td width=\"20%\"><font face=\"Arial\"><span style=\"font-size:10pt;\">Zip ext file</span></font></td>";
						}else
							{
						result=result+"<td width=\"20%\"><font face=\"Arial\"><span style=\"font-size:10pt;\">"+
						v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</span></font></td>";
							}
						//result=result+"<td width=100>"+							v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</td>";
						
						if(v[j].getElementsByTagName('share')[0].firstChild.nodeValue.substring(v[j].getElementsByTagName('share')[0].firstChild.nodeValue.lastIndexOf("-")+1)=="true")
						{
						
						result=result+"<td width=\"10%\" align=\"center\"><a href=\"SharedUsersList.jsp?f_path="+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"\" style=\"font-family: arial;text-decoration:none;\"><img src=\"../image/share.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Sharing\" valign=\"bottom\"></a></td></tr>";
						}
						else
						{
							result=result+"<td width=\"20%\"> <font face=\"Arial\"><span style=\"font-size:10pt;\"></span></font></td></tr>";
						}
					}
				}
				
				root_path=message[i].getElementsByTagName('rootpath')[0].firstChild.nodeValue;
				
			}
			if(j==0)
			{
				result="<tr><td colspan=\"4\" align=\"center\"><font face=\"Arial\"><span style=\"font-size:10pt;\" > There are no files or folders.</span></font></td></tr>";
			}
			result=result+"</table>";
		
			document.getElementById("test").innerHTML=result;
			
			if(root_path!="null")
					document.getElementById("path").innerHTML=root_path;
			else document.getElementById("path").innerHTML="";
            
	}
	
	}	
}

function filesHttpResponse() {
	alert("test1234");
	if (http.readyState == 4) {
	if (http.status==200){
            
			
            
			var message=http.responseXML.getElementsByTagName("root");
			result="<table width=100%>";
			for(i=0; i<message.length;i++)
			{
				v=message[i].getElementsByTagName('data');
				
				for(j=0;j<v.length;j++)
				{
					
					
						result=result+"<tr><td width=\"10%\"><input type=checkbox name=c_data value=\""+v[j].getElementsByTagName('check_data')[0].firstChild.nodeValue+"\"></td>";
						result=result+"<td width=243>";
						
						if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Text")
						{
							result=result+"<img src=../images/text.gif width=16 height=16>";
							
							result=result+"<a href=\"#\" onclick=\"open_new('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\">";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="Document")
						{
							result=result+"<img src=../images/word.gif width=16 height=16>";
							
							result=result+"<a href=\"#\"  onclick=\"open_word('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\"  style=\"font-family: arial;text-decoration:none;\">";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="PDF")
						{
							result=result+"<img src=../images/pdf.jpg width=16 height=16>";

							result=result+"<a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\">";
						}
						else if(v[j].getElementsByTagName('type')[0].firstChild.nodeValue=="ZIP")
						{
							result=result+"<img src=../images/zip.gif width=16 height=16>";

							/*result=result+"<a href=\"#\" onclick=\"open_pdf('"+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"')\" style=\"font-family: arial;text-decoration:none;\">";
							*/
							
							result=result+"<a href=\""+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+"\"  style=\"font-family: arial;text-decoration:none;\">";
						}
						result=result+"<font face=\"Arial\"><span style=\"font-size:10pt;\">"+v[j].getElementsByTagName('name')[0].firstChild.nodeValue+"</span></font></a></td>";

						result=result+"<td width=162><font face=\"Arial\"><span style=\"font-size:10pt;\">"+
							v[j].getElementsByTagName('type')[0].firstChild.nodeValue+"</span></font></td>";
						
						result=result+"<td width=109><font face=\"Arial\"><span style=\"font-size:10pt;\">"+
							v[j].getElementsByTagName('date')[0].firstChild.nodeValue+"</span></font></td></tr>";


				
					
				}
				
			}
			if(j==0)
			{
				result="<tr><td colspan=\"4\" align=\"center\"><font face=\"Arial\"><span style=\"font-size:10pt;\" > There are no files or folders.</span></font></td></tr>";
			}
			result=result+"</table>";
			document.getElementById("test").innerHTML=result;
            
	}
	
	}	
}


if (http.overrideMimeType)
 http.overrideMimeType('text/xml');

function folderData(f_path) {
	
	
	http.open("GET", "getList.jsp?fol_name="+f_path, true);	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);
}
function searchData(f_name) {
	
	http.open("GET", "searchList.jsp?f_name="+f_name, true);	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);
}

//for sharing files
function sharedData(shareduser) {
	
	http.open("GET", "sharedList.jsp?shareduser="+shareduser, true);	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);
}
function folderDataHome() {
	  
	http.open("GET", "getList.jsp", true);	
	http.onreadystatechange = handleHttpResponse;
	http.send(null);
}
function filesData() {
	
	http.open("GET", "FileList.jsp", true);	
	http.onreadystatechange = filesHttpResponse;
	http.send(null);
}
function open_download(path,cpath)
{
	var pp=cpath.substring(0,cpath.lastIndexOf("/"));
	document.location.href="../../FileDownload?source="+path+"&fol_name="+pp;
}
