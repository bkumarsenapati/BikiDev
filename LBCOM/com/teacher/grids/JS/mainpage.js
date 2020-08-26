	//cookies function start
	function delete_cookie ( cookie_name )
	{
	  var cookie_date = new Date ( );  // current date & time
	  cookie_date.setTime ( cookie_date.getTime() - 1 );
	  document.cookie = cookie_name += "=; expires=" + cookie_date.toGMTString();
	}


	function ajaxFunction()
		{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		  return xmlhttp;
		}
		/*xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {	
			
			var v=xmlhttp.responseText;
			document.getElementById("test").innerHTML=v;	
		  }
		}
		if(f_path=="files")
			{
			
			xmlhttp.open("GET","FileList.jsp",true);
			xmlhttp.send(null);
			}
		else if(f_path=="search")
			{
				var v=document.form.search_file.value;
				if(v=="")
				{
					alert('Enter the filename');

				}
				else{
					xmlhttp.open("GET","searchFile.jsp?file_name="+v,true);
					xmlhttp.send(null);
				}
			}
		else{
				xmlhttp.open("GET","getList.jsp?fol_name="+f_path,true);
				xmlhttp.send(null);
			}
		}*/
		//ajax end

		//Save 

	function cpy()
	{
		
		var c_value1 = "";
		var f_name = "";
		
		if(form.c_data.length)
		{
		for (var i=0; i < form.c_data.length; i++)
		{
		if (form.c_data[i].checked)
		  {
			
		   var vv=form.c_data[i].value;
		   
		   var ext=vv.substring(vv.lastIndexOf('.')+1);
		   
		   
				c_value1 = c_value1 + form.c_data[i].value+",";
		  }
		}
		}
		else if(form.c_data.checked)
		{
			c_value1 = form.c_data.value;
		}
		if(c_value1=="" || c_value1.length<=0)
		{
			alert('Please select at least one item!');
		}
		else
		{
			window.location.href='copy.jsp?file_path='+c_value1;
		}
		
	}


	//copy to
	function copyDirectory(fol_path,filelist)
		{
			var files = filelist.split(',');
			var test=0;
			for(var i=0; i<files.length; i++)
			{
				
				if(files[i]==fol_path)
				{
				alert("Please select other then coping folder!");
				test=1;
				return false;
				}
			}
			if(test!=1)
			{	
				window.location.href='../../cpy?dest_path='+fol_path;
			}
		}
		//End Sive
	
	
	//zip file
	function zipfile()
	{
		var c_value1 = "";
		var f_name = "";
		
		if(form.c_data.length)
		{
		for (var i=0; i < form.c_data.length; i++)
		{
		if (form.c_data[i].checked)
		  {
			
		   var vv=form.c_data[i].value;
		   
		   var ext=vv.substring(vv.lastIndexOf('.')+1);
		   
		   
				c_value1=c_value1+ form.c_data[i].value+",";
		  }
		}
		}
		else if(form.c_data.checked)
		{
			c_value1 = form.c_data.value;
			
		}
		if(c_value1=="" || c_value1.length<=0)
		{
			alert('Please select at least one item!');
		}
		else
		{
			
			window.location.href='zipfile.jsp?file_path='+c_value1;
		}
		
	}
	function path(pp)
		{
			var v=document.ff.fname.value;
			
			if(v=="" || v.length<=0)
				alert('File name should not be empty!');
			else{
				window.location.href="zipFunction.jsp?file_name="+v+"&fpath="+pp;
			}
		}
	//unzip File
		function unzipp()
	{
		var c_value1 = "";
		var f_name = "";
		
		if(form.c_data.length)
		{
		for (var i=0; i < form.c_data.length; i++)
		{
		if (form.c_data[i].checked)
		  {
			
		   var vv=form.c_data[i].value;
		   
		   
		   var ext=vv.substring(vv.lastIndexOf('.')+1,vv.lastIndexOf('.')+4);
		   
		   if(ext=='zip')
			  {
			   
				//c_value1= document.form.c_data[i].value;
				c_value1= vv;
				
			  }
		  }
		}
	}
	else if(form.c_data.checked)
		{
			c_value1 = form.c_data.value;
		}
		if(c_value1=="" || c_value1.length<=0)
		{
			alert('Please select at least one item!');
		}
		else{
			window.location.href='unzipFile.jsp?unzip_file_path='+c_value1;
		}
		
	}
	
	function unzippath(d_folder,s_name)
	{
		window.location.href='unzipFile2.jsp?s_file='+s_name+'&d_fonder='+d_folder;
	}
	//folder button

	function newFolder()
	{
		window.location.href='newFolder.jsp';
	}
	
	function newFile()
	{
		
		window.location.href='newFile.jsp';
	}
	function createFile()
	{
		var f_ext="";

		var f_name=document.newForm.file_name.value;
		if(f_name<=0 || f_name=="")
		{
			alert("Enter the file name!");
			  return false;
		}
		else{
		for (var i=0; i < document.newForm.files.length; i++)
	   {
		 if (document.newForm.files[i].checked)
			  {
			  f_ext = document.newForm.files[i].value;
			  }
		 }
		 
			if(f_ext=="text")
			{
			window.location.href='../JSP/testMessage.jsp?f_name='+f_name+".txt";
			return true;
			}
			else if(f_ext=="folder")
			{
			window.location.href="addFolder?folder_name="+f_name;
			return true;
			}
			else if(f_ext=="word")
			{
				
			window.location.href='../word/example1.jsp?f_name='+f_name+'&ext='+f_ext;			
			return true;
			}
			else if(f_ext=="html_file")
			{
				
			window.location.href='../word/example1.jsp?f_name='+f_name+'&ext='+f_ext;			
			return true;
			}
			else
		{
			alert("File type should not be empty!");
			return false;
		}
		
		
		}
	}
	//Share the files
	function share()
	{
		var c_value = "";
		var f_name = "";
		if(form.c_data.length)
		{
		for (var i=0; i <form.c_data.length; i++)
		   {
			
		   if (form.c_data[i].checked)
			  {
			   var vv = form.c_data[i].value;
			   //alert(vv.length);
			   
			   var ext = vv.substring(vv.lastIndexOf('.')+1);			   
			   
			   if(vv.lastIndexOf('.')!=-1)
				  {
			   c_value = c_value + form.c_data[i].value + ",";
				}
			  else
			   {
				  alert("You can't share a folder. Please select files only!");
				  return false;
			  }
			  } 
			}
		}else if(form.c_data.checked)
		{	var vv = form.c_data.value;
			var ext = vv.substring(vv.lastIndexOf('.'));
			if(ext!="")
			c_value = form.c_data.value;
		}
		if(c_value=="")
		{
			alert("Please select at least one item!");
		}
		else
		{
			window.location.href='shareFile.jsp?files='+c_value;
		}

	}


function open_new(file_name)
	{
		window.location.href='testMessage.jsp?mode=edit&f_name='+file_name;
	}
	function open_pdf(file_name)
	{
		window.open(file_name,"new","height=600,width=800 scrollbars=yes resizable=yes");
	}

	function open_word(file_name)
	{		

		window.location.href='../word/example.jsp?mode=edit&f_name='+file_name;
	}
	function open_word1(file_name)
	{		
		window.open('./openword.jsp?f_name='+file_name,"new","height=600,width=800 scrollbars=yes resizable=yes  method=post");
//		window.location.href='./openword.jsp?mode=edit&f_name='+file_name;
	}

	function moveFile()
	{
		
	var c_value = "";
	var f_name = "";
	if(form.c_data.length)
		{
	for (var i=0; i < form.c_data.length; i++)
	   {
	   if (form.c_data[i].checked)
		  {
			c_value = c_value + form.c_data[i].value + ",";
		  }
		}
		}else if(form.c_data.checked)
		{
			c_value = form.c_data.value;
		}
		if(c_value=="")
		{
			alert("Please select at least one item!");
		}
		else{
//		f_name=document.form.move[document.form.move.selectedIndex].value;

		//window.location.href="../../move?file_name="+c_value+"&folder_name="+f_name;
		window.location.href="moveFile.jsp?file_name="+c_value;
		}

		
	}
	function movetoFile(dfol,sfils)
	{
		
		var files = sfils.split(',');
			var test=0;
			for(var i=0; i<files.length; i++)
			{
				
				if(files[i]==dfol)
				{
				alert("Please select other then coping folder!");
				test=1;
				return false;
				}
			}
			if(test!=1)
			{	
				window.location.href="../../move?file_name="+sfils+"&folder_name="+dfol;
				//window.location.href='../../cpy?dest_path='+fol_path;
			}

		
	}
	function searchs()
	{
		
		window.location.href="search.jsp";
	}
	function upload()
	{
		document.location.href='../HTML/FileUpload.html';
		return true;
	}
//Download file
	function download()
	{
		var c_value = "";
		var f_name = "";
		var x=0;
		if(form.c_data.length)
		{
		for (var i=0; i <form.c_data.length; i++)
		   {
			
		   if (form.c_data[i].checked)
			  {
			   var vv = form.c_data[i].value;
			   var ext = vv.substring(vv.lastIndexOf('.'));
			   if(ext != "")
			   c_value = form.c_data[i].value;
			   x++;
			   
				
			  }
			 
			}
		}else if(form.c_data.checked)
		{
			c_value = form.c_data.value;
		}
		if(x>1)
		{
			alert("please select only one file");
		}
		else if(c_value=="")
			{
				alert('should select one item :');
			}
			else{
				var j=1;
				while(j>0)
				{
					j=0;
				j=c_value.indexOf("\\");
				c_value=c_value.replace("\\","/");
				
				}
				
				var temp="http://183.82.48.154:8080/"+c_value.substring(c_value.indexOf("LBCOM"));
				
				document.location.href=temp;
				}
	}

	//delete files and folders
	
	function del()
	{	
		var vv="";			
		var c_value = "";
		var f_name = "";
		if(form.c_data.length)
		{
			
		for (var i=0; i <form.c_data.length; i++)
		   {
			
		   if (form.c_data[i].checked)
			  {
				c_value = c_value + form.c_data[i].value + ",";
				
			  }
			 
			}
		}else if(form.c_data.checked)
		{
			c_value = form.c_data.value;
		}
			if(c_value=="")
			{
				alert('Please select at least one item!');
			}
			else{
				var con=confirm("Are you sure that you want to delete?");
					if(con)
					{
						var http=ajaxFunction();
						http.open("GET","result.jsp?files="+c_value,true);
						http.send(null);
						http.onreadystatechange=function()
						{
							if(http.readyState==4)
							  {
								if (http.status==200){
									
								var message=http.responseXML.getElementsByTagName("root");
								result="<table width=100% valign=\"top\">";
								for(i=0; i<message.length;i++)
								{
									v=message[i].getElementsByTagName('data');
									
									for(j=0;j<v.length;j++)
									{
										
										if(v[j].getElementsByTagName('status')[0].firstChild.nodeValue=="true")
										{
											vv=vv+v[j].getElementsByTagName('path')[0].firstChild.nodeValue+",";
							
										}
										else
											alert("You are not authorized  to delete the file!");
									}
								}
								
								document.location.href="Function.jsp?button=Delete&file_name="+vv;	
							}				
															
							}
					
						}
				}
				
		}
	}
		String.prototype.trim = function() {

return this.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g,"");

}

	function back()
	{
		document.location.href="list.jsp";
	}