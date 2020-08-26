function checkNum(keyCode)
{

   if(keyCode==8 || keyCode==13)
		return true;

	if(keyCode<48 || keyCode>57)
	{

		alert("Enter Numbers Only");
		return false;
	}
	return true;

}
	
	function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}

