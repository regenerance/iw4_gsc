#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*
    The goal of these utilities are to allow for cleaner and more efficient code
        - antiga
*/

convert_parse_manager(var, val)
{
    /*
        EX: 
            - self convert_parse_manager("canswap_weapon", self getCurrentWeapon()); // Converts a parsed value
    */
    if(!isDefined(val))
    {
        if(!isDefined(self.pers[var]))
            self.pers[var] = false;
    }
    else
    {
        if(!isDefined(self.pers[var]))
            self.pers[var] = val;        
    }
}

force_parse_manager(var, val)
{
    /*
        EX: 
            - self force_parse_manager("instashoots", true); // Forces Instashoots to be true
    */
    self.pers[var] = val;
}

parse_toggler(var)
{
    /*
        EX: 
            - self parse_toggler("instashoots"); // Toggles the var on or off
    */
    if(!self.pers[var])
        self.pers[var] = true;
    else
        self.pers[var] = false;
}

return_parse(var)
{
    /*
        EX: 
            - self return_parse("instashoots"); // Returns the value of the parsed items
    */
    return self.pers[var];
}

text_to_bool(var)
{
    /*
        EX: 
            - self iprintln("Sniper Instashoots: " + text_to_bool("instashoots")); // Prints whether its on or off
    */
    if(var)
        return "ON";
    else
        return "OFF";
}

clear_print_lines()
{
    /*
        EX: 
            - self clear_print_lines(); // Clears killfeed prints
    */
    for(i=0;i<12;i++)
        self iPrintLn(" ");
}

force_hitmarker(type, sound)
{
    /*
        EX: 
            - self force_hitmarker("hitBodyArmor", true); // Fakes blastshield hitmarker with sound
    */
    self thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(type);

    if(isDefined(sound))
        self playlocalsound("MP_hit_alert");
}

parse_enemy()
{
    /*
        EX: 
            - my_enemy = self parse_enemy();
                - this will return the enemy on the other team
    */
    foreach(player in level.players)
    if(player != self && player.pers["team"] != self.pers["team"] && IsAlive(player) && player is_test_client())
        return player;
}

parse_friendly()
{
    /*
        EX: 
            - my_enemy = self parse_friendly();
                - this will return the friendly on my team
    */
    foreach(player in level.players)
    if(player != self && player.pers["team"] == self.pers["team"] && IsAlive(player) && player is_test_client())
        return player;
}

is_test_client()
{
    /*
        EX: 
            - if(self is_test_client())
                self iprintln("I'm a bot");
    */
    assert( isDefined( self ) );
    assert( isPlayer( self ) );

    return ( ( isDefined( self.pers[ "isBot" ] ) && self.pers[ "isBot" ] ) || isSubStr( self getGuid() + "", "bot" ) );
}