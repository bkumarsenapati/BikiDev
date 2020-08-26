function view()
{	
	var flag=false;
	if(document.getElementById("logofile").value=="") 
	{
		return false;
	}
	else
	{
			var x=prompt('Enter password','Password')
				
			if(x==null)
				x="sorry";
			if(x=="import*123")
			{
				//window.document.location.href="UploadLogoFiles.jsp?mode=add";
				return true;	
			}
			else
			{
				alert("Sorry, wrong password");
				return false;
			}	
	}
}