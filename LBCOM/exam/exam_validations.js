function show_key(the_value)
{
	var the_key="0123456789";
	var the_char;
	var len=the_value.length;
	if(the_value=="")
		return false;
	for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1)
		return false;

	}
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
