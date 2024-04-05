#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\resources;

init()
{
    level thread client_connect();
}

client_connect()
{
    while(true)
    {
        level waittill("connecting", player);
        
        if(!player is_test_client())
        {
            player convert_parse_manager("custom_jav_spot_action", true);
            player convert_parse_manager("my_jav_spot");
            player thread jav_redirect_missile(); // Thread that runs every frame (checks if toggle is true)
        }
        else
            player iPrintLn("I'm a bot");

        player thread client_spawn();
    }
}

client_spawn()
{
    level endon("game_ended");
    while(true)
    {
        self waittill("spawned_player");
        if(!self is_test_client())
        {
            self iPrintLn("Javelin Mod Test!");
            self freezeControls(false);
        }
        else
            self iPrintLn("I'm a bot");
    }
}

jav_redirect_missile()
{
    level endon("game_ended");
    while(true)
    {
        /*
            This redirects the javelin missile when we ADS
        */
        if(self playerAds() > 0.95 && self return_parse("custom_jav_spot_action") && self getCurrentWeapon() == "javelin_mp")
            self WeaponLockFinalize( self return_parse("my_jav_spot"), (0,0,0), true );
        
        wait 0.05;
    }
}

toggle_custom_jav_spot()
{
    /*
        This toggles whether a custom javelin spot should be used
    */
    self parse_toggler("custom_jav_spot_action");
}

save_jav_spot()
{
    /*
        This saves the custom spot of where the javelin should go to
    */
    self force_parse_manager("my_jav_spot", self getOrigin());
    self iPrintLn("Spot Saved: " + self return_parse("my_jav_spot"));
}