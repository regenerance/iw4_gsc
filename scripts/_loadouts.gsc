init()
{
	// Fix class loadouts to include scavenger by default and also removes the Bling Perk check
	replaceFunc( maps\mp\gametypes\_class::giveLoadout, ::giveLoadoutHook );
}

giveLoadoutHook( team, class, allowCopycat )
{
	self takeAllWeapons();
	
	primaryIndex = 0;
	
	self.specialty = [];

	if ( !isDefined( allowCopycat ) )
		allowCopycat = true;

	primaryWeapon = undefined;

	if ( isDefined( self.pers["copyCatLoadout"] ) && self.pers["copyCatLoadout"]["inUse"] && allowCopycat )
	{
		self maps\mp\gametypes\_class::setClass( "copycat" );
		self.class_num = maps\mp\gametypes\_class::getClassIndex( "copycat" );

		clonedLoadout = self.pers["copyCatLoadout"];

		loadoutPrimary = clonedLoadout["loadoutPrimary"];
		loadoutPrimaryAttachment = clonedLoadout["loadoutPrimaryAttachment"];
		loadoutPrimaryAttachment2 = clonedLoadout["loadoutPrimaryAttachment2"] ;
		loadoutPrimaryCamo = clonedLoadout["loadoutPrimaryCamo"];
		loadoutSecondary = clonedLoadout["loadoutSecondary"];
		loadoutSecondaryAttachment = clonedLoadout["loadoutSecondaryAttachment"];
		loadoutSecondaryAttachment2 = clonedLoadout["loadoutSecondaryAttachment2"];
		loadoutSecondaryCamo = clonedLoadout["loadoutSecondaryCamo"];
		loadoutEquipment = clonedLoadout["loadoutEquipment"];
		loadoutPerk1 = clonedLoadout["loadoutPerk1"];
		loadoutPerk2 = clonedLoadout["loadoutPerk2"];
		loadoutPerk3 = clonedLoadout["loadoutPerk3"];
		loadoutOffhand = clonedLoadout["loadoutOffhand"];
		loadoutDeathStreak = "specialty_copycat";		
	}
	else if ( isSubstr( class, "custom" ) )
	{
		class_num = maps\mp\gametypes\_class::getClassIndex( class );
		self.class_num = class_num;

		loadoutPrimary = maps\mp\gametypes\_class::cac_getWeapon( class_num, 0 );
		loadoutPrimaryAttachment = maps\mp\gametypes\_class::cac_getWeaponAttachment( class_num, 0 );
		loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo( class_num, 0 );
		loadoutPrimaryCamo = maps\mp\gametypes\_class::cac_getWeaponCamo( class_num, 0 );
		loadoutSecondaryCamo = maps\mp\gametypes\_class::cac_getWeaponCamo( class_num, 1 );
		loadoutSecondary = maps\mp\gametypes\_class::cac_getWeapon( class_num, 1 );
		loadoutSecondaryAttachment = maps\mp\gametypes\_class::cac_getWeaponAttachment( class_num, 1 );
		loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo( class_num, 1 );
		loadoutSecondaryCamo = maps\mp\gametypes\_class::cac_getWeaponCamo( class_num, 1 );
		loadoutEquipment = maps\mp\gametypes\_class::cac_getPerk( class_num, 0 );
		loadoutPerk1 = maps\mp\gametypes\_class::cac_getPerk( class_num, 1 );
		loadoutPerk2 = maps\mp\gametypes\_class::cac_getPerk( class_num, 2 );
		loadoutPerk3 = maps\mp\gametypes\_class::cac_getPerk( class_num, 3 );
		loadoutOffhand = maps\mp\gametypes\_class::cac_getOffhand( class_num );
		loadoutDeathStreak = maps\mp\gametypes\_class::cac_getDeathstreak( class_num );
	}
	else
	{
		class_num = maps\mp\gametypes\_class::getClassIndex( class );
		self.class_num = class_num;
		
		loadoutPrimary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, class_num, 0 );
		loadoutPrimaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 0 , 0);
		loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 0, 1 );
		loadoutPrimaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, class_num, 0 );
		loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, class_num, 1 );
		loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, class_num, 1 );
		loadoutSecondaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 1 , 0);
		loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 1, 1 );;
		loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, class_num, 1 );
		loadoutEquipment = maps\mp\gametypes\_class::table_getEquipment( level.classTableName, class_num, 0 );
		loadoutPerk1 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 1 );
		loadoutPerk2 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 2 );
		loadoutPerk3 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 3 );
		loadoutOffhand = maps\mp\gametypes\_class::table_getOffhand( level.classTableName, class_num );
		loadoutDeathstreak = maps\mp\gametypes\_class::table_getDeathstreak( level.classTableName, class_num );
	}

	if ( !(isDefined( self.pers["copyCatLoadout"] ) && self.pers["copyCatLoadout"]["inUse"] && allowCopycat) )
	{
		isCustomClass = isSubstr( class, "custom" );
		
		if ( !maps\mp\gametypes\_class::isValidPrimary( loadoutPrimary ) || (isCustomClass && !self isItemUnlocked( loadoutPrimary )) )
			loadoutPrimary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, 10, 0 );
		
		if ( !maps\mp\gametypes\_class::isValidAttachment( loadoutPrimaryAttachment ) || (isCustomClass && !self isItemUnlocked( loadoutPrimary + " " + loadoutPrimaryAttachment )) )
			loadoutPrimaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, 10, 0 , 0);
		
		if ( !maps\mp\gametypes\_class::isValidAttachment( loadoutPrimaryAttachment2 ) || (isCustomClass && !self isItemUnlocked( loadoutPrimary + " " + loadoutPrimaryAttachment2 )) )
			loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, 10, 0, 1 );
		
		if ( !maps\mp\gametypes\_class::isValidCamo( loadoutPrimaryCamo ) || (isCustomClass && !self isItemUnlocked( loadoutPrimary + " " + loadoutPrimaryCamo )) )
			loadoutPrimaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, 10, 0 );
		
		if ( !maps\mp\gametypes\_class::isValidSecondary( loadoutSecondary ) || (isCustomClass && !self isItemUnlocked( loadoutSecondary )) )
			loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, 10, 1 );
		
		if ( !maps\mp\gametypes\_class::isValidAttachment( loadoutSecondaryAttachment ) || (isCustomClass && !self isItemUnlocked( loadoutSecondary + " " + loadoutSecondaryAttachment )) )
			loadoutSecondaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, 10, 1 , 0);
		
		if ( !maps\mp\gametypes\_class::isValidAttachment( loadoutSecondaryAttachment2 ) || (isCustomClass && !self isItemUnlocked( loadoutSecondary + " " + loadoutSecondaryAttachment2 )) )
			loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, 10, 1, 1 );;
		
		if ( !maps\mp\gametypes\_class::isValidCamo( loadoutSecondaryCamo ) || (isCustomClass && !self isItemUnlocked( loadoutSecondary + " " + loadoutSecondaryCamo )) )
			loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, 10, 1 );
		
		if ( !maps\mp\gametypes\_class::isValidEquipment( loadoutEquipment ) || (isCustomClass && !self isItemUnlocked( loadoutEquipment )) )
			loadoutEquipment = maps\mp\gametypes\_class::table_getEquipment( level.classTableName, 10, 0 );
		
		if ( !maps\mp\gametypes\_class::isValidPerk1( loadoutPerk1 ) || (isCustomClass && !self isItemUnlocked( loadoutPerk1 )) )
			loadoutPerk1 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, 10, 1 );
		
		if ( !maps\mp\gametypes\_class::isValidPerk2( loadoutPerk2 ) || (isCustomClass && !self isItemUnlocked( loadoutPerk2 )) )
			loadoutPerk2 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, 10, 2 );
		
		if ( !maps\mp\gametypes\_class::isValidPerk3( loadoutPerk3 ) || (isCustomClass && !self isItemUnlocked( loadoutPerk3 )) )
			loadoutPerk3 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, 10, 3 );
		
		if ( !maps\mp\gametypes\_class::isValidOffhand( loadoutOffhand ) )
			loadoutOffhand = maps\mp\gametypes\_class::table_getOffhand( level.classTableName, 10 );
		
		if ( !maps\mp\gametypes\_class::isValidDeathstreak( loadoutDeathstreak ) || (isCustomClass && !self isItemUnlocked( loadoutDeathstreak )) )
			loadoutDeathstreak = maps\mp\gametypes\_class::table_getDeathstreak( level.classTableName, 10 );
	}
	
	if ( loadoutPerk1 != "specialty_onemanarmy" && loadoutSecondary == "onemanarmy" )
		loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, 10, 1 );

	loadoutSecondaryCamo = "none";

	if ( level.killstreakRewards )
	{
		loadoutKillstreak1 = self getPlayerData( "killstreaks", 0 );
		loadoutKillstreak2 = self getPlayerData( "killstreaks", 1 );
		loadoutKillstreak3 = self getPlayerData( "killstreaks", 2 );
	}
	else
	{
		loadoutKillstreak1 = "none";
		loadoutKillstreak2 = "none";
		loadoutKillstreak3 = "none";
	}
	
	secondaryName = maps\mp\gametypes\_class::buildWeaponName( loadoutSecondary, loadoutSecondaryAttachment, loadoutSecondaryAttachment2 );
	self maps\mp\_utility::_giveWeapon( secondaryName, int(tableLookup( "mp/camoTable.csv", 1, loadoutSecondaryCamo, 0 ) ) );

	self.loadoutPrimaryCamo = int(tableLookup( "mp/camoTable.csv", 1, loadoutPrimaryCamo, 0 ));
	self.loadoutPrimary = loadoutPrimary;
	self.loadoutSecondary = loadoutSecondary;
	self.loadoutSecondaryCamo = int(tableLookup( "mp/camoTable.csv", 1, loadoutSecondaryCamo, 0 ));
	
	self SetOffhandPrimaryClass( "other" );
	
	self maps\mp\_utility::_SetActionSlot( 1, "" );
	self maps\mp\_utility::_SetActionSlot( 3, "altMode" );
	self maps\mp\_utility::_SetActionSlot( 4, "" );

	self maps\mp\_utility::_clearPerks();
	self maps\mp\gametypes\_class::_detachAll();
	
	if ( level.dieHardMode )
		self maps\mp\perks\_perks::givePerk( "specialty_pistoldeath" );
	
	scav_perks = strTok("specialty_scavenger|specialty_extraammo", "|");
	foreach(perk in scav_perks)
		self maps\mp\perks\_perks::givePerk( perk ); // Sets Scavenger By Default
	
	if ( loadoutDeathStreak != "specialty_null" && getTime() == self.spawnTime )
	{
		deathVal = int( tableLookup( "mp/perkTable.csv", 1, loadoutDeathStreak, 6 ) );
				
		if ( self maps\mp\gametypes\_class::getPerkUpgrade( loadoutPerk1 ) == "specialty_rollover" || self maps\mp\gametypes\_class::getPerkUpgrade( loadoutPerk2 ) == "specialty_rollover" || self maps\mp\gametypes\_class::getPerkUpgrade( loadoutPerk3 ) == "specialty_rollover" )
			deathVal -= 1;
		
		if ( self.pers["cur_death_streak"] == deathVal )
		{
			self thread maps\mp\perks\_perks::givePerk( loadoutDeathStreak );
			self thread maps\mp\gametypes\_hud_message::splashNotify( loadoutDeathStreak );
		}
		else if ( self.pers["cur_death_streak"] > deathVal )
			self thread maps\mp\perks\_perks::givePerk( loadoutDeathStreak );
	}

	self maps\mp\gametypes\_class::loadoutAllPerks( loadoutEquipment, loadoutPerk1, loadoutPerk2, loadoutPerk3 );
		
	self maps\mp\gametypes\_class::setKillstreaks( loadoutKillstreak1, loadoutKillstreak2, loadoutKillstreak3 );
		
	if ( self hasPerk( "specialty_extraammo", true ) && maps\mp\_utility::getWeaponClass( secondaryName ) != "weapon_projectile" )
		self giveMaxAmmo( secondaryName );

	primaryName = maps\mp\gametypes\_class::buildWeaponName( loadoutPrimary, loadoutPrimaryAttachment, loadoutPrimaryAttachment2 );
	self maps\mp\_utility::_giveWeapon( primaryName, self.loadoutPrimaryCamo );
	
	if ( primaryName == "riotshield_mp" && level.inGracePeriod )
		self notify ( "weapon_change", "riotshield_mp" );

	if ( self hasPerk( "specialty_extraammo", true ) )
		self giveMaxAmmo( primaryName );

	self setSpawnWeapon( primaryName );
	
	primaryTokens = strtok( primaryName, "_" );
	self.pers["primaryWeapon"] = primaryTokens[0];
	
	offhandSecondaryWeapon = loadoutOffhand + "_mp";
	if ( loadoutOffhand == "flash_grenade" )
		self SetOffhandSecondaryClass( "flash" );
	else
		self SetOffhandSecondaryClass( "smoke" );
	
	self giveWeapon( offhandSecondaryWeapon );
	if( loadOutOffhand == "smoke_grenade" )
		self setWeaponAmmoClip( offhandSecondaryWeapon, 1 );
	else if( loadOutOffhand == "flash_grenade" )
		self setWeaponAmmoClip( offhandSecondaryWeapon, 2 );
	else if( loadOutOffhand == "concussion_grenade" )
		self setWeaponAmmoClip( offhandSecondaryWeapon, 2 );
	else
		self setWeaponAmmoClip( offhandSecondaryWeapon, 1 );
	
	primaryWeapon = primaryName;
	self.primaryWeapon = primaryWeapon;
	self.secondaryWeapon = secondaryName;

	self maps\mp\gametypes\_teams::playerModelForWeapon( self.pers["primaryWeapon"], maps\mp\_utility::getBaseWeaponName( secondaryName ) );
		
	self.isSniper = (weaponClass( self.primaryWeapon ) == "sniper");
	
	self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );

	self maps\mp\perks\_perks::cac_selector();
	
	self notify ( "changed_kit" );
	self notify ( "giveLoadout" );
}