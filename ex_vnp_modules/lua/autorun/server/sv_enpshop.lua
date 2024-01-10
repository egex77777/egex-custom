hook.Add( "PlayerSay", "CharCount", function( ply, text )
	if ( string.StartWith( string.lower( text ), "/upgrade " ) ) then
		RunConsoleCommand("enpshop")
		return ""
	end
end )