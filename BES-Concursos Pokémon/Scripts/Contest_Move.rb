################################################################################
# Contest Move Data System - Plug & Play
# Configuración centralizada de movimientos de concurso sin necesidad de PBS
################################################################################

module ContestMoveConfig
#-----------------------------------------------------------------------------
# Configuración de efectos especiales (por ID de movimiento)
# Formato: [ID_MOVIMIENTO1, ID_MOVIMIENTO2, ...] => código_efecto
#-----------------------------------------------------------------------------
  EFFECTS = {
    # A very appealing move, but after using this move, the user is more easily startled.
    [getID(PBMoves, :BRAVEBIRD), getID(PBMoves, :FLAREBLITZ), 
     getID(PBMoves, :HIGHJUMPKICK), getID(PBMoves, :JUMPKICK),
     getID(PBMoves, :OUTRAGE), getID(PBMoves, :SUBMISSION),
     getID(PBMoves, :VCREATE), getID(PBMoves, :VOLTTACKLE)] => 18,
    
    # Makes the audience quickly grow bored when an appeal move has little effect.
    [getID(PBMoves, :FALSESWIPE), getID(PBMoves, :HOLDBACK), 
     getID(PBMoves, :VOLTSWITCH)] => 3,
    
    # Quite an appealing move.
    [getID(PBMoves, :AIRCUTTER), getID(PBMoves, :BRICKBREAK), 
     getID(PBMoves, :CUT), getID(PBMoves, :DARKPULSE),
     getID(PBMoves, :DRAGONCLAW), getID(PBMoves, :FIREFANG),
     getID(PBMoves, :FOCUSBLAST), getID(PBMoves, :FORCEPALM),
     getID(PBMoves, :HORNATTACK), getID(PBMoves, :ICEFANG),
     getID(PBMoves, :IRONTAIL), getID(PBMoves, :METALCLAW),
     getID(PBMoves, :PECK), getID(PBMoves, :PSYCHOCUT),
     getID(PBMoves, :RAZORLEAF), getID(PBMoves, :ROLLINGKICK),
     getID(PBMoves, :SHADOWCLAW), getID(PBMoves, :SLASH),
     getID(PBMoves, :SPARK), getID(PBMoves, :THUNDERFANG),
     getID(PBMoves, :THUNDERPUNCH), getID(PBMoves, :THUNDERSHOCK),
     getID(PBMoves, :THUNDERBOLT), getID(PBMoves, :TWISTER),
     getID(PBMoves, :VINEWHIP), getID(PBMoves, :WINGATTACK)] => 0,
    
    # Startles all other Pokémon. User cannot act in the next turn.
    [getID(PBMoves, :FRENZYPLANT), getID(PBMoves, :HYPERBEAM)] => 42,
    
    # Affected by how well the previous Pokémon's move went.
    [getID(PBMoves, :CROSSCHOP), getID(PBMoves, :DRILLPECK),
     getID(PBMoves, :NIGHTSLASH), getID(PBMoves, :RAZORWIND),
     getID(PBMoves, :RETALIATE), getID(PBMoves, :SKYATTACK),
     getID(PBMoves, :SOLARBEAM), getID(PBMoves, :STEELWING)] => 35,
    
    # An appealing move that can be used repeatedly without boring the audience.
    [getID(PBMoves, :BLAZEKICK), getID(PBMoves, :DRAGONRAGE),
     getID(PBMoves, :FURYCUTTER), getID(PBMoves, :HYPERFANG),
     getID(PBMoves, :LEAFBLADE), getID(PBMoves, :LEAFTORNADO),
     getID(PBMoves, :MEGAHORN), getID(PBMoves, :METEORMASH),
     getID(PBMoves, :NIGHTDAZE), getID(PBMoves, :PSYSTRIKE),
     getID(PBMoves, :RAZORSHELL), getID(PBMoves, :SEARINGSHOT),
     getID(PBMoves, :SONICBOOM), getID(PBMoves, :TRIPLEKICK)] => 19,
    
    # Causes the user to move earlier on the next turn.
    [getID(PBMoves, :AGILITY), getID(PBMoves, :AQUAJET),
     getID(PBMoves, :EXTREMESPEED), getID(PBMoves, :MACHPUNCH),
     getID(PBMoves, :QUICKATTACK), getID(PBMoves, :TAILWIND),
     getID(PBMoves, :VACUUMWAVE), getID(PBMoves, :WATERSHURIKEN)] => 16,
    
    # Causes the user to move later on the next turn.
    [getID(PBMoves, :CIRCLETHROW), getID(PBMoves, :ROAR)] => 24,
    
    # Excites the audience a lot if used first.
    [getID(PBMoves, :ELECTROBALL)] => 25,
    
    # Excites the audience a lot if used last.
    [getID(PBMoves, :AEROBLAST), getID(PBMoves, :PARTINGSHOT),
     getID(PBMoves, :PRECIPICEBLADES)] => 29,
    
    # Badly startles all Pokémon that successfully showed their appeal.
    [getID(PBMoves, :GUILLOTINE), getID(PBMoves, :HORNDRILL),
     getID(PBMoves, :ZAPCANNON)] => 10,
    
    # Badly startles Pokémon that the audience has high expectations of.
    [getID(PBMoves, :DYNAMICPUNCH), getID(PBMoves, :LEER),
     getID(PBMoves, :PUNISHMENT)] => 11,
    
    # Badly startles Pokémon that used a move of the same type.
    [getID(PBMoves, :CROSSPOISON), getID(PBMoves, :DOUBLEHIT),
     getID(PBMoves, :DOUBLEKICK), getID(PBMoves, :EXTRASENSORY),
     getID(PBMoves, :SKYUPPERCUT), getID(PBMoves, :TWINEEDLE),
     getID(PBMoves, :XSCISSOR)] => 4,
    
    # Excites the audience in any kind of contest.
    [getID(PBMoves, :SACREDSWORD), getID(PBMoves, :STORMTHROW)] => 19,
    
    # Makes the remaining Pokémon nervous.
    [getID(PBMoves, :STEALTHROCK)] => 13,
    
    # Startles all of the Pokémon to act before the user.
    [getID(PBMoves, :HYPERVOICE)] => 9,
    
    # Startles the last Pokémon to act before the user.
    [getID(PBMoves, :DRAGONBREATH)] => 8,
    
    # Works great if the user goes first this turn.
    [getID(PBMoves, :AERIALACE), getID(PBMoves, :DEFOG),
     getID(PBMoves, :MAGNETBOMB), getID(PBMoves, :QUICKGUARD),
     getID(PBMoves, :SHOCKWAVE), getID(PBMoves, :SWIFT)] => 14,
    
    # Works great if the user goes last this turn.
    [getID(PBMoves, :HOWL), getID(PBMoves, :METALBURST),
     getID(PBMoves, :VITALTHROW)] => 15,
    
    # Badly startles all of the Pokémon to act before the user.
    [getID(PBMoves, :MATBLOCK), getID(PBMoves, :THUNDERWAVE)] => 10,
    
    # Badly startles the last Pokémon to act before the user.
    [getID(PBMoves, :AIRSLASH), getID(PBMoves, :CRUSHCLAW)] => 12,
    
    # Effectiveness varies depending on when it is used.
    [getID(PBMoves, :BULLETSEED), getID(PBMoves, :FURYATTACK),
     getID(PBMoves, :PINMISSILE), getID(PBMoves, :SPIKECANNON)] => 21,
    
    # Gets the Pokémon pumped up. Helps prevent nervousness, too.
    [getID(PBMoves, :BULKUP), getID(PBMoves, :DOUBLETEAM),
     getID(PBMoves, :DRAGONDANCE), getID(PBMoves, :FOCUSENERGY)] => 31,
    
    # Prevents the user from being startled until the turn ends.
    [getID(PBMoves, :BARRIER), getID(PBMoves, :DETECT),
     getID(PBMoves, :KINGSSHIELD), getID(PBMoves, :PHANTOMFORCE),
     getID(PBMoves, :SHADOWFORCE), getID(PBMoves, :TELEPORT)] => 1,
    
    # Shows off the Pokémon's appeal about as well as all the moves before it this turn.
    [getID(PBMoves, :OBLIVIONWING)] => 34,
    
    # Works better the later it is used in a turn.
    [getID(PBMoves, :FUSIONBOLT), getID(PBMoves, :GYROBALL),
     getID(PBMoves, :REVERSAL), getID(PBMoves, :TRUMPCARD)] => 23,
    
    # Works better the more the crowd is excited.
    [getID(PBMoves, :FELLSTINGER), getID(PBMoves, :MEGAKICK),
     getID(PBMoves, :RAPIDSPIN), getID(PBMoves, :THUNDER)] => 26,
    
    # Works well if the user is pumped up.
    [getID(PBMoves, :ACROBATICS), getID(PBMoves, :FLAMECHARGE),
     getID(PBMoves, :TECHNOBLAST)] => 38,
     
    # A move of huge appeal, but using it prevents the user from taking further contest moves.
    [getID(PBMoves, :EXPLOSION), getID(PBMoves, :HEALINGWISH), 
     getID(PBMoves, :LUNARDANCE), getID(PBMoves, :SELFDESTRUCT),
     getID(PBMoves, :DESTINYBOND), getID(PBMoves, :FINALGAMBIT)] => 41,
    
    # A very appealing move, but after using this move, the user is more easily startled.
    [getID(PBMoves, :DRACOMETEOR), getID(PBMoves, :DRAGONASCENT),
     getID(PBMoves, :ERUPTION), getID(PBMoves, :LEAFSTORM),
     getID(PBMoves, :LIGHTOFRUIN), getID(PBMoves, :OVERHEAT),
     getID(PBMoves, :PETALDANCE), getID(PBMoves, :SEEDFLARE),
     getID(PBMoves, :SPACIALREND), getID(PBMoves, :WATERSPOUT)] => 18,
    
    # Affected by how well the previous Pokémon's move went.
    [getID(PBMoves, :AVALANCHE), getID(PBMoves, :FLAMEWHEEL),
     getID(PBMoves, :FREEZESHOCK), getID(PBMoves, :ICEBURN)] => 35,
    
    # An appealing move that can be used repeatedly without boring the audience.
    [getID(PBMoves, :BLUEFLARE), getID(PBMoves, :BOLTSTRIKE),
     getID(PBMoves, :ECHOEDVOICE), getID(PBMoves, :FREEZEDRY),
     getID(PBMoves, :JUDGMENT), getID(PBMoves, :MYSTICALFIRE),
     getID(PBMoves, :SECRETSWORD), getID(PBMoves, :WEATHERBALL)] => 19,
    
    # Badly startles all of the Pokémon to act before the user.
    [getID(PBMoves, :BLIZZARD), getID(PBMoves, :SPORE)] => 10,
    
    # Badly startles all Pokémon that successfully showed their appeal.
    [getID(PBMoves, :HAIL), getID(PBMoves, :SHEERCOLD)] => 10,
    
    # Badly startles Pokémon that the audience has high expectations of.
    [getID(PBMoves, :COTTONSPORE), getID(PBMoves, :ELECTROWEB)] => 11,
    
    # Badly startles Pokémon that used a move of the same type.
    [getID(PBMoves, :ACIDSPRAY), getID(PBMoves, :THOUSANDARROWS)] => 4,
    
    # Badly startles the last Pokémon to act before the user.
    [getID(PBMoves, :BUGBUZZ), getID(PBMoves, :ICEBEAM),
     getID(PBMoves, :INFERNO), getID(PBMoves, :MOONBLAST),
     getID(PBMoves, :PSYSHOCK)] => 12,
    
    # Brings down the energy of any Pokémon that have already used a move this turn.
    [getID(PBMoves, :HAZE)] => 20,
    
    # Causes the user to move earlier on the next turn.
    [getID(PBMoves, :ICESHARD)] => 16,
    
    # Effectiveness varies depending on when it is used.
    [getID(PBMoves, :ICICLESPEAR), getID(PBMoves, :MOONLIGHT),
     getID(PBMoves, :MORNINGSUN), getID(PBMoves, :TRIATTACK)] => 21,
    
    # Excites the audience a lot if used first.
    [getID(PBMoves, :GRASSYTERRAIN), getID(PBMoves, :MISTYTERRAIN),
     getID(PBMoves, :ORIGINPULSE)] => 25,
    
    # Excites the audience a lot if used last.
    [getID(PBMoves, :DIAMONDSTORM), getID(PBMoves, :DOOMDESIRE),
     getID(PBMoves, :ICICLECRASH), getID(PBMoves, :SACREDFIRE),
     getID(PBMoves, :STEAMERUPTION)] => 29,
    
    # Excites the audience in any kind of contest.
    [getID(PBMoves, :FIREPLEDGE), getID(PBMoves, :GRASSPLEDGE),
     getID(PBMoves, :HEALPULSE), getID(PBMoves, :WATERPLEDGE)] => 19,
    
    # Gets the Pokémon pumped up. Helps prevent nervousness, too.
    [getID(PBMoves, :AQUARING), getID(PBMoves, :AROMATICMIST),
     getID(PBMoves, :AUTOTOMIZE), getID(PBMoves, :COSMICPOWER),
     getID(PBMoves, :GEOMANCY), getID(PBMoves, :GROWTH),
     getID(PBMoves, :MEDITATE), getID(PBMoves, :OMINOUSWIND),
     getID(PBMoves, :QUIVERDANCE), getID(PBMoves, :SILVERWIND),
     getID(PBMoves, :SWORDSDANCE), getID(PBMoves, :TAILGLOW)] => 31,
    
    # Makes audience expect little of other contestants.
    [getID(PBMoves, :FLAMEBURST), getID(PBMoves, :FLASH),
     getID(PBMoves, :PSYBEAM), getID(PBMoves, :SIGNALBEAM),
     getID(PBMoves, :WATERPULSE), getID(PBMoves, :WILLOWISP)] => 28,
    
    # Makes the audience quickly grow bored when an appeal move has little effect.
    [getID(PBMoves, :FROSTBREATH), getID(PBMoves, :ICYWIND),
     getID(PBMoves, :LOVELYKISS), getID(PBMoves, :PERISHSONG)] => 3,
    
    # Makes the remaining Pokémon nervous.
    [getID(PBMoves, :MEANLOOK), getID(PBMoves, :RELICSONG)] => 13,
    
    # Prevents the user from being startled one time this turn.
    [getID(PBMoves, :DIVE), getID(PBMoves, :LIGHTSCREEN),
     getID(PBMoves, :SAFEGUARD)] => 1,
    
    # Prevents the user from being startled until the turn ends.
    [getID(PBMoves, :FLOWERSHIELD), getID(PBMoves, :HEALBELL),
     getID(PBMoves, :MIST)] => 1,
    
    # Quite an appealing move.
    [getID(PBMoves, :AQUATAIL), getID(PBMoves, :DAZZLINGGLEAM),
     getID(PBMoves, :DRAGONPULSE), getID(PBMoves, :EARTHPOWER),
     getID(PBMoves, :ENERGYBALL), getID(PBMoves, :FAIRYWIND),
     getID(PBMoves, :FLAMETHROWER), getID(PBMoves, :FLASHCANNON),
     getID(PBMoves, :ICEPUNCH), getID(PBMoves, :POWDERSNOW),
     getID(PBMoves, :POWERGEM)] => 0,
    
    # Startles all of the Pokémon to act before the user.
    [getID(PBMoves, :DISCHARGE), getID(PBMoves, :HEATWAVE),
     getID(PBMoves, :LANDSWRATH), getID(PBMoves, :PETALBLIZZARD),
     getID(PBMoves, :SURF)] => 9,
    
    # Startles all other Pokémon. User cannot act in the next turn.
    [getID(PBMoves, :BLASTBURN), getID(PBMoves, :HYDROCANNON),
     getID(PBMoves, :ROAROFTIME)] => 42,
    
    # Startles the last Pokémon to act before the user.
    [getID(PBMoves, :AURORABEAM), getID(PBMoves, :BUBBLEBEAM),
     getID(PBMoves, :MIRRORSHOT)] => 8,
    
    # Temporarily stops the crowd from growing excited.
    [getID(PBMoves, :FIRESPIN), getID(PBMoves, :GLACIATE),
     getID(PBMoves, :ICEBALL), getID(PBMoves, :IONDELUGE),
     getID(PBMoves, :WHIRLPOOL)] => 3,
    
    # Works better the later it is used in a turn.
    [getID(PBMoves, :FUSIONFLARE)] => 23,
    
    # Works better the more the crowd is excited.
    [getID(PBMoves, :FIREBLAST), getID(PBMoves, :HYDROPUMP),
     getID(PBMoves, :NATUREPOWER), getID(PBMoves, :RAINDANCE),
     getID(PBMoves, :SUNNYDAY)] => 26,
    
    # Works great if the user goes first this turn.
    [getID(PBMoves, :AURASPHERE), getID(PBMoves, :CLEARSMOG),
     getID(PBMoves, :MAGICALLEAF)] => 14,
    
    # Works great if the user goes last this turn.
    [getID(PBMoves, :FEATHERDANCE), getID(PBMoves, :MAGICCOAT),
     getID(PBMoves, :MIRRORCOAT)] => 15,
    
    # Works well if it is the same type as the move used by the last Pokémon.
    [getID(PBMoves, :CONVERSION), getID(PBMoves, :CONVERSION2),
     getID(PBMoves, :ROUND), getID(PBMoves, :VENOSHOCK)] => 27,
    
    # Works well if the user is pumped up.
    [getID(PBMoves, :CHARGEBEAM), getID(PBMoves, :FIERYDANCE)] => 38,

    # A very appealing move, but after using this move, the user is more easily startled.
    [getID(PBMoves, :BELLYDRUM)] => 18,
    
    # An appealing move that can be used repeatedly without boring the audience.
    [getID(PBMoves, :HEARTSTAMP), getID(PBMoves, :PRESENT), 
     getID(PBMoves, :ROLLOUT)] => 19,
    
    # Badly startles Pokémon that the audience has high expectations of.
    [getID(PBMoves, :CHARM), getID(PBMoves, :SOAK), 
     getID(PBMoves, :UPROAR)] => 11,
    
    # Badly startles Pokémon that used a move of the same type.
    [getID(PBMoves, :ENTRAINMENT), getID(PBMoves, :NUZZLE), 
     getID(PBMoves, :TRICKORTREAT)] => 4,
    
    # Brings down the energy of any Pokémon that have already used a move this turn.
    [getID(PBMoves, :BUGBITE), getID(PBMoves, :CHATTER), 
     getID(PBMoves, :CONFIDE), getID(PBMoves, :FLING), 
     getID(PBMoves, :MUDSLAP), getID(PBMoves, :PLAYROUGH), 
     getID(PBMoves, :PLUCK), getID(PBMoves, :SIMPLEBEAM), 
     getID(PBMoves, :SWAGGER), getID(PBMoves, :TICKLE)] => 20,
    
    # Causes the user to move earlier on the next turn.
    [getID(PBMoves, :BABYDOLLEYES)] => 16,
    
    # Causes the user to move later on the next turn.
    [getID(PBMoves, :AFTERYOU)] => 24,
    
    # Effectiveness varies depending on when it is used.
    [getID(PBMoves, :ASSIST), getID(PBMoves, :BARRAGE), 
     getID(PBMoves, :DOUBLESLAP), getID(PBMoves, :METRONOME), 
     getID(PBMoves, :SLEEPTALK), getID(PBMoves, :TAILSLAP)] => 21,
    
    # Excites the audience a lot if used last.
    [getID(PBMoves, :WISH)] => 29,
    
    # Excites the audience in any kind of contest.
    [getID(PBMoves, :CELEBRATE), getID(PBMoves, :HAPPYHOUR), 
     getID(PBMoves, :MUDSPORT), getID(PBMoves, :WATERSPORT)] => 19,
    
    # Gets the Pokémon pumped up. Helps prevent nervousness, too.
    [getID(PBMoves, :HONECLAWS), getID(PBMoves, :LUCKYCHANT), 
     getID(PBMoves, :SHARPEN)] => 31,
    
    # Makes audience expect little of other contestants.
    [getID(PBMoves, :DIZZYPUNCH), getID(PBMoves, :SANDATTACK)] => 28,
    
    # Makes the audience quickly grow bored when an appeal move has little effect.
    [getID(PBMoves, :CAPTIVATE), getID(PBMoves, :FAKETEARS), 
     getID(PBMoves, :SLACKOFF), getID(PBMoves, :SNORE), 
     getID(PBMoves, :SPLASH), getID(PBMoves, :UTURN)] => 3,
    
    # Makes the remaining Pokémon nervous.
    [getID(PBMoves, :ATTRACT), getID(PBMoves, :BLOCK), 
     getID(PBMoves, :ENCORE), getID(PBMoves, :SING), 
     getID(PBMoves, :SWEETKISS), getID(PBMoves, :YAWN)] => 13,
    
    # Prevents the user from being startled one time this turn.
    [getID(PBMoves, :DEFENSECURL), getID(PBMoves, :PROTECT), 
     getID(PBMoves, :REFRESH), getID(PBMoves, :SUBSTITUTE), 
     getID(PBMoves, :SWEETSCENT), getID(PBMoves, :WITHDRAW)] => 1,
    
    # Prevents the user from being startled until the turn ends.
    [getID(PBMoves, :AMNESIA), getID(PBMoves, :BOUNCE), 
     getID(PBMoves, :COTTONGUARD), getID(PBMoves, :HOLDHANDS), 
     getID(PBMoves, :MINIMIZE), getID(PBMoves, :REST)] => 1,
    
    # Quite an appealing move.
    [getID(PBMoves, :BUBBLE), getID(PBMoves, :EGGBOMB), 
     getID(PBMoves, :EMBER), getID(PBMoves, :RETURN), 
     getID(PBMoves, :WATERGUN)] => 0,
    
    # Shows off the Pokémon's appeal about as well as all the moves before it this turn.
    [getID(PBMoves, :DRAININGKISS)] => 34,
    
    # Shows off the Pokémon's appeal about as well as the move used just before it.
    [getID(PBMoves, :COPYCAT), getID(PBMoves, :COVET), 
     getID(PBMoves, :MIMIC), getID(PBMoves, :ROLEPLAY)] => 34,
    
    # Startles all other Pokémon. User cannot act in the next turn.
    [getID(PBMoves, :TEETERDANCE)] => 42,
    
    # Startles the last Pokémon to act before the user.
    [getID(PBMoves, :ASTONISH), getID(PBMoves, :FAKEOUT), 
     getID(PBMoves, :FRUSTRATION), getID(PBMoves, :LICK), 
     getID(PBMoves, :MUDBOMB)] => 8,
    
    # Temporarily stops the crowd from growing excited.
    [getID(PBMoves, :FOLLOWME), getID(PBMoves, :INFESTATION)] => 3,
    
    # Works better the later it is used in a turn.
    [getID(PBMoves, :FLAIL), getID(PBMoves, :GRASSKNOT)] => 23,
    
    # Works better the more the crowd is excited.
    [getID(PBMoves, :BESTOW), getID(PBMoves, :PLAYNICE)] => 26,
    
    # Works great if the user goes first this turn.
    [getID(PBMoves, :DISARMINGVOICE), getID(PBMoves, :MILKDRINK), 
     getID(PBMoves, :SOFTBOILED)] => 14,
    
    # Works great if the user goes last this turn.
    [getID(PBMoves, :FACADE), getID(PBMoves, :GROWL), 
     getID(PBMoves, :STRUGGLEBUG), getID(PBMoves, :TAILWHIP)] => 15,
    
    # Works well if the user is pumped up.
    [getID(PBMoves, :BATONPASS), getID(PBMoves, :LASTRESORT)] => 38,
    
    # A very appealing move, but after using this move, the user is more easily startled.
    [getID(PBMoves, :PSYCHOBOOST)] => 18,
    
    # An appealing move that can be used repeatedly without boring the audience.
    [getID(PBMoves, :ATTACKORDER), getID(PBMoves, :HIDDENPOWER), 
     getID(PBMoves, :KINESIS), getID(PBMoves, :NIGHTSHADE), 
     getID(PBMoves, :TRANSFORM)] => 19,
    
    # Badly startles all of the Pokémon to act before the user.
    [getID(PBMoves, :EERIEIMPULSE), getID(PBMoves, :HYPNOSIS), 
     getID(PBMoves, :METALSOUND), getID(PBMoves, :NIGHTMARE), 
     getID(PBMoves, :SLEEPPOWDER)] => 10,
    
    # Badly startles all Pokémon that successfully showed their appeal.
    [getID(PBMoves, :FORESTSCURSE), getID(PBMoves, :MISTBALL), 
     getID(PBMoves, :STUNSPORE)] => 10,
    
    # Badly startles Pokémon that the audience has high expectations of.
    [getID(PBMoves, :CONFUSERAY), getID(PBMoves, :TAUNT)] => 11,
    
    # Badly startles Pokémon that used a move of the same type.
    [getID(PBMoves, :ELECTRIFY), getID(PBMoves, :FORESIGHT), 
     getID(PBMoves, :HEALORDER), getID(PBMoves, :HEX), 
     getID(PBMoves, :LUSTERPURGE), getID(PBMoves, :PURSUIT), 
     getID(PBMoves, :SWITCHEROO), getID(PBMoves, :TRICK)] => 4,
    
    # Badly startles the last Pokémon to act before the user.
    [getID(PBMoves, :GIGADRAIN)] => 12,
    
    # Brings down the energy of any Pokémon that have already used a move this turn.
    [getID(PBMoves, :ACID), getID(PBMoves, :EMBARGO), 
     getID(PBMoves, :POISONPOWDER), getID(PBMoves, :POISONTAIL), 
     getID(PBMoves, :TOXIC), getID(PBMoves, :VENOMDRENCH)] => 20,
    
    # Causes the user to move earlier on the next turn.
    [getID(PBMoves, :FEINT), getID(PBMoves, :LOCKON), 
     getID(PBMoves, :MEFIRST), getID(PBMoves, :MINDREADER), 
     getID(PBMoves, :QUASH), getID(PBMoves, :SHADOWSNEAK)] => 16,
    
    # Causes the user to move later on the next turn.
    [getID(PBMoves, :WHIRLWIND)] => 24,
    
    # Effectiveness varies depending on when it is used.
    [getID(PBMoves, :PSYWAVE), getID(PBMoves, :SYNTHESIS)] => 21,
    
    # Excites the audience a lot if used first.
    [getID(PBMoves, :CRAFTYSHIELD), getID(PBMoves, :ELECTRICTERRAIN), 
     getID(PBMoves, :HYPERSPACEHOLE), getID(PBMoves, :SUCKERPUNCH)] => 25,
    
    # Excites the audience in any kind of contest.
    [getID(PBMoves, :PAYDAY)] => 19,
    
    # Gets the Pokémon pumped up. Helps prevent nervousness, too.
    [getID(PBMoves, :CALMMIND), getID(PBMoves, :CHARGE), 
     getID(PBMoves, :INGRAIN), getID(PBMoves, :LEECHSEED), 
     getID(PBMoves, :MAGNETICFLUX), getID(PBMoves, :NASTYPLOT), 
     getID(PBMoves, :SHIFTGEAR)] => 31,
    
    # Makes audience expect little of other contestants.
    [getID(PBMoves, :POISONGAS), getID(PBMoves, :ROCKTOMB), 
     getID(PBMoves, :SCREECH), getID(PBMoves, :SUPERSONIC)] => 28,
    
    # Makes the audience quickly grow bored when an appeal move has little effect.
    [getID(PBMoves, :POWDER), getID(PBMoves, :ROOST)] => 3,
    
    # Makes the remaining Pokémon nervous.
    [getID(PBMoves, :DARKVOID), getID(PBMoves, :DISABLE), 
     getID(PBMoves, :FLATTER), getID(PBMoves, :GRAVITY), 
     getID(PBMoves, :MAGNETRISE), getID(PBMoves, :SPIDERWEB),
     getID(PBMoves, :SPIKES), getID(PBMoves, :TELEKINESIS), 
     getID(PBMoves, :TOXICSPIKES), getID(PBMoves, :WORRYSEED)] => 13,
    
    # Prevents the user from being startled one time this turn.
    [getID(PBMoves, :DEFENDORDER), getID(PBMoves, :FLY), 
     getID(PBMoves, :GRASSWHISTLE), getID(PBMoves, :ODORSLEUTH), 
     getID(PBMoves, :REFLECT)] => 1,
    
    # Prevents the user from being startled until the turn ends.
    [getID(PBMoves, :AROMATHERAPY)] => 1,
    
    # Quite an appealing move.
    [getID(PBMoves, :ABSORB), getID(PBMoves, :CONFUSION), 
     getID(PBMoves, :GEARGRIND), getID(PBMoves, :HELPINGHAND),
     getID(PBMoves, :NEEDLEARM), getID(PBMoves, :POISONFANG), 
     getID(PBMoves, :PSYCHIC), getID(PBMoves, :SHADOWBALL), 
     getID(PBMoves, :ZENHEADBUTT)] => 0,
    
    # Scrambles the order in which Pokémon will move on the next turn.
    [getID(PBMoves, :ALLYSWITCH), getID(PBMoves, :TOPSYTURVY), 
     getID(PBMoves, :TRICKROOM), getID(PBMoves, :WONDERROOM)] => 2,
    
    # Shows off the Pokémon's appeal about as well as all the moves before it this turn.
    [getID(PBMoves, :CAMOUFLAGE), getID(PBMoves, :GUARDSPLIT), 
     getID(PBMoves, :GUARDSWAP), getID(PBMoves, :HEARTSWAP),
     getID(PBMoves, :PAINSPLIT), getID(PBMoves, :PARABOLICCHARGE), 
     getID(PBMoves, :POWERSPLIT), getID(PBMoves, :POWERSWAP)] => 34,
    
    # Shows off the Pokémon's appeal about as well as the move used just before it.
    [getID(PBMoves, :FOULPLAY), getID(PBMoves, :LEECHLIFE), 
     getID(PBMoves, :MIRRORMOVE), getID(PBMoves, :RECYCLE), 
     getID(PBMoves, :SKETCH), getID(PBMoves, :SKILLSWAP), 
     getID(PBMoves, :SNATCH)] => 34,
    
    # Startles the last Pokémon to act before the user.
    [getID(PBMoves, :GUST), getID(PBMoves, :KNOCKOFF), 
     getID(PBMoves, :LOWSWEEP), getID(PBMoves, :MEGADRAIN), 
     getID(PBMoves, :POISONSTING), getID(PBMoves, :SMOKESCREEN), 
     getID(PBMoves, :STRINGSHOT)] => 8,
    
    # Temporarily stops the crowd from growing excited.
    [getID(PBMoves, :FAIRYLOCK), getID(PBMoves, :HEALBLOCK), 
     getID(PBMoves, :IMPRISON), getID(PBMoves, :MAGICROOM), 
     getID(PBMoves, :RAGEPOWDER), getID(PBMoves, :SANDTOMB)] => 3,
    
    # Works better the later it is used in a turn.
    [getID(PBMoves, :ASSURANCE)] => 23,
    
    # Works better the more the crowd is excited.
    [getID(PBMoves, :NATURALGIFT)] => 26,
    
    # Works great if the user goes first this turn.
    [getID(PBMoves, :FEINTATTACK), getID(PBMoves, :MIRACLEEYE), 
     getID(PBMoves, :SHADOWPUNCH)] => 14,
    
    # Works great if the user goes last this turn.
    [getID(PBMoves, :PSYCHOSHIFT)] => 15,
    
    # Works well if it is the same type as the move used by the last Pokémon.
    [getID(PBMoves, :DREAMEATER), getID(PBMoves, :FUTURESIGHT), 
     getID(PBMoves, :POWERTRICK), getID(PBMoves, :PSYCHUP), 
     getID(PBMoves, :RECOVER), getID(PBMoves, :REFLECTTYPE), 
     getID(PBMoves, :SYNCHRONOISE)] => 27,
    
    # Works well if the user is pumped up.
    [getID(PBMoves, :BEATUP), getID(PBMoves, :SECRETPOWER), 
     getID(PBMoves, :STOREDPOWER)] => 38,
    
    # A very appealing move, but after using this move, the user is more easily startled.
    [getID(PBMoves, :CLOSECOMBAT), getID(PBMoves, :DOUBLEEDGE), 
     getID(PBMoves, :HAMMERARM), getID(PBMoves, :HEADCHARGE), 
     getID(PBMoves, :HEADSMASH), getID(PBMoves, :SUPERPOWER), 
     getID(PBMoves, :TAKEDOWN), getID(PBMoves, :THRASH), 
     getID(PBMoves, :WILDCHARGE), getID(PBMoves, :WOODHAMMER)] => 18,
    
    # Affected by how well the previous Pokémon's move went.
    [getID(PBMoves, :BRINE), getID(PBMoves, :DRAGONRUSH), 
     getID(PBMoves, :DRILLRUN), getID(PBMoves, :SKULLBASH),
     getID(PBMoves, :SMELLINGSALTS), getID(PBMoves, :STONEEDGE), 
     getID(PBMoves, :WAKEUPSLAP)] => 35,
    
    # An appealing move that can be used repeatedly without boring the audience.
    [getID(PBMoves, :BONECLUB), getID(PBMoves, :CRABHAMMER), 
     getID(PBMoves, :CRUSHGRIP), getID(PBMoves, :MEGAPUNCH),
     getID(PBMoves, :OCTAZOOKA), getID(PBMoves, :SEISMICTOSS), 
     getID(PBMoves, :STEAMROLLER)] => 19,
    
    # Badly startles all of the Pokémon to act before the user.
    [getID(PBMoves, :GLARE), getID(PBMoves, :RAGE)] => 10,
    
    # Badly startles all Pokémon that successfully showed their appeal.
    [getID(PBMoves, :EARTHQUAKE), getID(PBMoves, :FISSURE), 
     getID(PBMoves, :GUNKSHOT), getID(PBMoves, :HURRICANE), 
     getID(PBMoves, :SANDSTORM), getID(PBMoves, :SPITE), 
     getID(PBMoves, :SUPERFANG)] => 10,
    
    # Badly startles Pokémon that the audience has high expectations of.
    [getID(PBMoves, :SLUDGEBOMB), getID(PBMoves, :SMACKDOWN), 
     getID(PBMoves, :STICKYWEB), getID(PBMoves, :WRINGOUT)] => 11,
    
    # Badly startles Pokémon that used a move of the same type.
    [getID(PBMoves, :BONEMERANG), getID(PBMoves, :DUALCHOP)] => 4,
    
    # Badly startles the last Pokémon to act before the user.
    [getID(PBMoves, :BODYSLAM), getID(PBMoves, :CRUNCH)] => 12,
    
    # Brings down the energy of any Pokémon that have already used a move this turn.
    [getID(PBMoves, :CONSTRICT), getID(PBMoves, :GASTROACID), 
     getID(PBMoves, :SCARYFACE), getID(PBMoves, :SLUDGEWAVE), 
     getID(PBMoves, :THOUSANDWAVES)] => 20,
    
    # Causes the user to move earlier on the next turn.
    [getID(PBMoves, :BULLETPUNCH), getID(PBMoves, :ROCKPOLISH)] => 16,
    
    # Causes the user to move later on the next turn.
    [getID(PBMoves, :BIDE), getID(PBMoves, :CURSE), 
     getID(PBMoves, :DRAGONTAIL), getID(PBMoves, :ENDURE)] => 24,
    
    # Effectiveness varies depending on when it is used.
    [getID(PBMoves, :ACUPRESSURE), getID(PBMoves, :ARMTHRUST), 
     getID(PBMoves, :BONERUSH), getID(PBMoves, :COMETPUNCH), 
     getID(PBMoves, :FURYSWIPES), getID(PBMoves, :ROCKBLAST)] => 21,
    
    # Excites the audience a lot if used first.
    [getID(PBMoves, :HYPERSPACEFURY), getID(PBMoves, :WORKUP)] => 25,
    
    # Excites the audience a lot if used last.
    [getID(PBMoves, :HEATCRASH), getID(PBMoves, :HEAVYSLAM), 
     getID(PBMoves, :SHELLSMASH)] => 29,
    
    # Excites the audience in any kind of contest.
    [getID(PBMoves, :CHIPAWAY), getID(PBMoves, :FLYINGPRESS)] => 19,
    
    # Gets the Pokémon pumped up. Helps prevent nervousness, too.
    [getID(PBMoves, :ANCIENTPOWER), getID(PBMoves, :COIL), 
     getID(PBMoves, :ROTOTILLER), getID(PBMoves, :STOCKPILE)] => 31,
    
    # Makes audience expect little of other contestants.
    [getID(PBMoves, :INCINERATE), getID(PBMoves, :ROCKCLIMB)] => 28,
    
    # Makes the audience quickly grow bored when an appeal move has little effect.
    [getID(PBMoves, :SNARL)] => 3,
    
    # Makes the remaining Pokémon nervous.
    [getID(PBMoves, :SCALD), getID(PBMoves, :TORMENT)] => 13,
    
    # Prevents the user from being startled one time this turn.
    [getID(PBMoves, :DIG), getID(PBMoves, :HARDEN), 
     getID(PBMoves, :SWALLOW)] => 1,
    
    # Prevents the user from being startled until the turn ends.
    [getID(PBMoves, :ACIDARMOR), getID(PBMoves, :IRONDEFENSE), 
     getID(PBMoves, :SPIKYSHIELD), getID(PBMoves, :WIDEGUARD)] => 1,
    
    # Quite an appealing move.
    [getID(PBMoves, :FIREPUNCH), getID(PBMoves, :HEADBUTT), 
     getID(PBMoves, :IRONHEAD), getID(PBMoves, :KARATECHOP), 
     getID(PBMoves, :MUDSHOT), getID(PBMoves, :POISONJAB),
     getID(PBMoves, :POUND), getID(PBMoves, :ROCKSMASH), 
     getID(PBMoves, :ROCKTHROW), getID(PBMoves, :SCRATCH), 
     getID(PBMoves, :SEEDBOMB), getID(PBMoves, :SLAM),
     getID(PBMoves, :SMOG), getID(PBMoves, :STOMP), 
     getID(PBMoves, :STRENGTH), getID(PBMoves, :STRUGGLE), 
     getID(PBMoves, :TACKLE), getID(PBMoves, :VICEGRIP), 
     getID(PBMoves, :WATERFALL)] => 0,
    
    # Shows off the Pokémon's appeal about as well as the move used just before it.
    [getID(PBMoves, :DRAINPUNCH), getID(PBMoves, :HORNLEECH), 
     getID(PBMoves, :THIEF)] => 34,
    
    # Startles all of the Pokémon to act before the user.
    [getID(PBMoves, :BULLDOZE), getID(PBMoves, :LAVAPLUME), 
     getID(PBMoves, :MUDDYWATER), getID(PBMoves, :ROCKSLIDE)] => 9,
    
    # Startles all other Pokémon. User cannot act in the next turn.
    [getID(PBMoves, :BOOMBURST), getID(PBMoves, :GIGAIMPACT), 
     getID(PBMoves, :GRUDGE), getID(PBMoves, :ROCKWRECKER)] => 42,
    
    # Startles the last Pokémon to act before the user.
    [getID(PBMoves, :BITE), getID(PBMoves, :SLUDGE)] => 8,
    
    # Temporarily stops the crowd from growing excited.
    [getID(PBMoves, :BIND), getID(PBMoves, :CLAMP), 
     getID(PBMoves, :MAGMASTORM), getID(PBMoves, :SKYDROP), 
     getID(PBMoves, :WRAP)] => 3,
    
    # Works better the later it is used in a turn.
    [getID(PBMoves, :LOWKICK)] => 23,
    
    # Works better the more the crowd is excited.
    [getID(PBMoves, :MAGNITUDE), getID(PBMoves, :POWERWHIP)] => 26,
    
    # Works great if the user goes first this turn.
    [getID(PBMoves, :NOBLEROAR)] => 14,
    
    # Works great if the user goes last this turn.
    [getID(PBMoves, :COUNTER), getID(PBMoves, :ENDEAVOR), 
     getID(PBMoves, :FOCUSPUNCH), getID(PBMoves, :PAYBACK), 
     getID(PBMoves, :REVENGE)] => 15,
    
    # Works well if the user is pumped up.
    [getID(PBMoves, :BELCH), getID(PBMoves, :POWERUPPUNCH), 
     getID(PBMoves, :SPITUP)] => 38,

  }
  
  #-----------------------------------------------------------------------------
  # Configuración de corazones (por ID de movimiento)
  # Formato: [ID_MOVIMIENTO1, ID_MOVIMIENTO2, ...] => número_de_corazones
  #-----------------------------------------------------------------------------
  HEARTS = {
    # 6 corazones
    [getID(PBMoves, :BRAVEBIRD), getID(PBMoves, :FLAREBLITZ), 
     getID(PBMoves, :HIGHJUMPKICK), getID(PBMoves, :JUMPKICK),
     getID(PBMoves, :OUTRAGE), getID(PBMoves, :SUBMISSION),
     getID(PBMoves, :VCREATE), getID(PBMoves, :VOLTTACKLE)] => 6,
    
    # 4 corazones
    [getID(PBMoves, :FALSESWIPE), getID(PBMoves, :HOLDBACK), 
     getID(PBMoves, :VOLTSWITCH),
     getID(PBMoves, :AIRCUTTER), getID(PBMoves, :BRICKBREAK), 
     getID(PBMoves, :CUT), getID(PBMoves, :DARKPULSE),
     getID(PBMoves, :DRAGONCLAW), getID(PBMoves, :FIREFANG),
     getID(PBMoves, :FOCUSBLAST), getID(PBMoves, :FORCEPALM),
     getID(PBMoves, :HORNATTACK), getID(PBMoves, :ICEFANG),
     getID(PBMoves, :IRONTAIL), getID(PBMoves, :METALCLAW),
     getID(PBMoves, :PECK), getID(PBMoves, :PSYCHOCUT),
     getID(PBMoves, :RAZORLEAF), getID(PBMoves, :ROLLINGKICK),
     getID(PBMoves, :SHADOWCLAW), getID(PBMoves, :SLASH),
     getID(PBMoves, :SPARK), getID(PBMoves, :THUNDERFANG),
     getID(PBMoves, :THUNDERPUNCH), getID(PBMoves, :THUNDERSHOCK),
     getID(PBMoves, :THUNDERBOLT), getID(PBMoves, :TWISTER),
     getID(PBMoves, :VINEWHIP), getID(PBMoves, :WINGATTACK),
     getID(PBMoves, :FRENZYPLANT), getID(PBMoves, :HYPERBEAM)] => 4,
    
    # 3 corazones
    [getID(PBMoves, :CROSSCHOP), getID(PBMoves, :DRILLPECK),
     getID(PBMoves, :NIGHTSLASH), getID(PBMoves, :RAZORWIND),
     getID(PBMoves, :RETALIATE), getID(PBMoves, :SKYATTACK),
     getID(PBMoves, :SOLARBEAM), getID(PBMoves, :STEELWING),
     getID(PBMoves, :BLAZEKICK), getID(PBMoves, :DRAGONRAGE),
     getID(PBMoves, :FURYCUTTER), getID(PBMoves, :HYPERFANG),
     getID(PBMoves, :LEAFBLADE), getID(PBMoves, :LEAFTORNADO),
     getID(PBMoves, :MEGAHORN), getID(PBMoves, :METEORMASH),
     getID(PBMoves, :NIGHTDAZE), getID(PBMoves, :PSYSTRIKE),
     getID(PBMoves, :RAZORSHELL), getID(PBMoves, :SEARINGSHOT),
     getID(PBMoves, :SONICBOOM), getID(PBMoves, :TRIPLEKICK),
     getID(PBMoves, :AGILITY), getID(PBMoves, :AQUAJET),
     getID(PBMoves, :EXTREMESPEED), getID(PBMoves, :MACHPUNCH),
     getID(PBMoves, :QUICKATTACK), getID(PBMoves, :TAILWIND),
     getID(PBMoves, :VACUUMWAVE), getID(PBMoves, :WATERSHURIKEN),
     getID(PBMoves, :CIRCLETHROW), getID(PBMoves, :ROAR),
     getID(PBMoves, :ELECTROBALL),
     getID(PBMoves, :AEROBLAST), getID(PBMoves, :PARTINGSHOT),
     getID(PBMoves, :PRECIPICEBLADES)] => 3,
    
    # 2 corazones
    [getID(PBMoves, :GUILLOTINE), getID(PBMoves, :HORNDRILL),
     getID(PBMoves, :ZAPCANNON),
     getID(PBMoves, :DYNAMICPUNCH), getID(PBMoves, :LEER),
     getID(PBMoves, :PUNISHMENT),
     getID(PBMoves, :CROSSPOISON), getID(PBMoves, :DOUBLEHIT),
     getID(PBMoves, :DOUBLEKICK), getID(PBMoves, :EXTRASENSORY),
     getID(PBMoves, :SKYUPPERCUT), getID(PBMoves, :TWINEEDLE),
     getID(PBMoves, :XSCISSOR),
     getID(PBMoves, :SACREDSWORD), getID(PBMoves, :STORMTHROW),
     getID(PBMoves, :STEALTHROCK),
     getID(PBMoves, :HYPERVOICE),
     getID(PBMoves, :DRAGONBREATH),
     getID(PBMoves, :AERIALACE), getID(PBMoves, :DEFOG),
     getID(PBMoves, :MAGNETBOMB), getID(PBMoves, :QUICKGUARD),
     getID(PBMoves, :SHOCKWAVE), getID(PBMoves, :SWIFT),
     getID(PBMoves, :HOWL), getID(PBMoves, :METALBURST),
     getID(PBMoves, :VITALTHROW)] => 2,
    
    # 1 corazón
    [getID(PBMoves, :MATBLOCK), getID(PBMoves, :THUNDERWAVE),
     getID(PBMoves, :AIRSLASH), getID(PBMoves, :CRUSHCLAW),
     getID(PBMoves, :BULLETSEED), getID(PBMoves, :FURYATTACK),
     getID(PBMoves, :PINMISSILE), getID(PBMoves, :SPIKECANNON),
     getID(PBMoves, :BULKUP), getID(PBMoves, :DOUBLETEAM),
     getID(PBMoves, :DRAGONDANCE), getID(PBMoves, :FOCUSENERGY),
     getID(PBMoves, :BARRIER), getID(PBMoves, :DETECT),
     getID(PBMoves, :KINGSSHIELD), getID(PBMoves, :PHANTOMFORCE),
     getID(PBMoves, :SHADOWFORCE), getID(PBMoves, :TELEPORT),
     getID(PBMoves, :OBLIVIONWING),
     getID(PBMoves, :FUSIONBOLT), getID(PBMoves, :GYROBALL),
     getID(PBMoves, :REVERSAL), getID(PBMoves, :TRUMPCARD),
     getID(PBMoves, :FELLSTINGER), getID(PBMoves, :MEGAKICK),
     getID(PBMoves, :RAPIDSPIN), getID(PBMoves, :THUNDER),
     getID(PBMoves, :ACROBATICS), getID(PBMoves, :FLAMECHARGE),
     getID(PBMoves, :TECHNOBLAST)] => 1,
     
    # 8 corazones
    [getID(PBMoves, :EXPLOSION), getID(PBMoves, :HEALINGWISH), 
     getID(PBMoves, :LUNARDANCE), getID(PBMoves, :SELFDESTRUCT),
     getID(PBMoves, :DESTINYBOND), getID(PBMoves, :FINALGAMBIT)] => 8,
    
    # 6 corazones
    [getID(PBMoves, :DRACOMETEOR), getID(PBMoves, :DRAGONASCENT),
     getID(PBMoves, :ERUPTION), getID(PBMoves, :LEAFSTORM),
     getID(PBMoves, :LIGHTOFRUIN), getID(PBMoves, :OVERHEAT),
     getID(PBMoves, :PETALDANCE), getID(PBMoves, :SEEDFLARE),
     getID(PBMoves, :SPACIALREND), getID(PBMoves, :WATERSPOUT),
     getID(PBMoves, :BELLYDRUM), getID(PBMoves, :PSYCHOBOOST),
     getID(PBMoves, :CLOSECOMBAT), getID(PBMoves, :DOUBLEEDGE), 
     getID(PBMoves, :HAMMERARM), getID(PBMoves, :HEADCHARGE), 
     getID(PBMoves, :HEADSMASH), getID(PBMoves, :SUPERPOWER), 
     getID(PBMoves, :TAKEDOWN), getID(PBMoves, :THRASH), 
     getID(PBMoves, :WILDCHARGE), getID(PBMoves, :WOODHAMMER)] => 6,
    
    # 4 corazones
    [getID(PBMoves, :FROSTBREATH), getID(PBMoves, :ICYWIND),
     getID(PBMoves, :LOVELYKISS), getID(PBMoves, :PERISHSONG),
     getID(PBMoves, :AQUATAIL), getID(PBMoves, :DAZZLINGGLEAM),
     getID(PBMoves, :DRAGONPULSE), getID(PBMoves, :EARTHPOWER),
     getID(PBMoves, :ENERGYBALL), getID(PBMoves, :FAIRYWIND),
     getID(PBMoves, :FLAMETHROWER), getID(PBMoves, :FLASHCANNON),
     getID(PBMoves, :ICEPUNCH), getID(PBMoves, :POWDERSNOW),
     getID(PBMoves, :POWERGEM),
     getID(PBMoves, :BLASTBURN), getID(PBMoves, :HYDROCANNON),
     getID(PBMoves, :ROAROFTIME),
     getID(PBMoves, :CAPTIVATE), getID(PBMoves, :FAKETEARS), 
     getID(PBMoves, :SLACKOFF), getID(PBMoves, :SNORE), 
     getID(PBMoves, :SPLASH), getID(PBMoves, :UTURN),
     getID(PBMoves, :AMNESIA), getID(PBMoves, :BOUNCE), 
     getID(PBMoves, :COTTONGUARD), getID(PBMoves, :HOLDHANDS), 
     getID(PBMoves, :MINIMIZE), getID(PBMoves, :REST),
     getID(PBMoves, :BUBBLE), getID(PBMoves, :EGGBOMB), 
     getID(PBMoves, :EMBER), getID(PBMoves, :RETURN), 
     getID(PBMoves, :WATERGUN),
     getID(PBMoves, :COPYCAT), getID(PBMoves, :COVET), 
     getID(PBMoves, :MIMIC), getID(PBMoves, :ROLEPLAY),
     getID(PBMoves, :TEETERDANCE),
     getID(PBMoves, :POISONGAS), getID(PBMoves, :ROCKTOMB), 
     getID(PBMoves, :SCREECH), getID(PBMoves, :SUPERSONIC),
     getID(PBMoves, :AROMATHERAPY),
     getID(PBMoves, :INCINERATE), getID(PBMoves, :ROCKCLIMB),
     getID(PBMoves, :ACIDARMOR), getID(PBMoves, :IRONDEFENSE), 
     getID(PBMoves, :SPIKYSHIELD), getID(PBMoves, :WIDEGUARD),
     getID(PBMoves, :FIREPUNCH), getID(PBMoves, :HEADBUTT), 
     getID(PBMoves, :IRONHEAD), getID(PBMoves, :KARATECHOP), 
     getID(PBMoves, :MUDSHOT), getID(PBMoves, :POISONJAB),
     getID(PBMoves, :POUND), getID(PBMoves, :ROCKSMASH), 
     getID(PBMoves, :ROCKTHROW), getID(PBMoves, :SCRATCH), 
     getID(PBMoves, :SEEDBOMB), getID(PBMoves, :SLAM),
     getID(PBMoves, :SMOG), getID(PBMoves, :STOMP), 
     getID(PBMoves, :STRENGTH), getID(PBMoves, :STRUGGLE), 
     getID(PBMoves, :TACKLE), getID(PBMoves, :VICEGRIP), 
     getID(PBMoves, :WATERFALL),
     getID(PBMoves, :BULLDOZE), getID(PBMoves, :LAVAPLUME), 
     getID(PBMoves, :MUDDYWATER), getID(PBMoves, :ROCKSLIDE),
     getID(PBMoves, :BOOMBURST), getID(PBMoves, :GIGAIMPACT), 
     getID(PBMoves, :GRUDGE), getID(PBMoves, :ROCKWRECKER)] => 4,
    
    # 3 corazones
    [getID(PBMoves, :AVALANCHE), getID(PBMoves, :FLAMEWHEEL),
     getID(PBMoves, :FREEZESHOCK), getID(PBMoves, :ICEBURN),
     getID(PBMoves, :BLUEFLARE), getID(PBMoves, :BOLTSTRIKE),
     getID(PBMoves, :ECHOEDVOICE), getID(PBMoves, :FREEZEDRY),
     getID(PBMoves, :JUDGMENT), getID(PBMoves, :MYSTICALFIRE),
     getID(PBMoves, :SECRETSWORD), getID(PBMoves, :WEATHERBALL),
     getID(PBMoves, :HAZE),
     getID(PBMoves, :GRASSYTERRAIN), getID(PBMoves, :MISTYTERRAIN),
     getID(PBMoves, :ORIGINPULSE),
     getID(PBMoves, :DIAMONDSTORM), getID(PBMoves, :DOOMDESIRE),
     getID(PBMoves, :ICICLECRASH), getID(PBMoves, :SACREDFIRE),
     getID(PBMoves, :STEAMERUPTION),
     getID(PBMoves, :FIREPLEDGE), getID(PBMoves, :GRASSPLEDGE),
     getID(PBMoves, :HEALPULSE), getID(PBMoves, :WATERPLEDGE),
     getID(PBMoves, :AQUARING), getID(PBMoves, :AROMATICMIST),
     getID(PBMoves, :AUTOTOMIZE), getID(PBMoves, :COSMICPOWER),
     getID(PBMoves, :GEOMANCY), getID(PBMoves, :GROWTH),
     getID(PBMoves, :MEDITATE), getID(PBMoves, :OMINOUSWIND),
     getID(PBMoves, :QUIVERDANCE), getID(PBMoves, :SILVERWIND),
     getID(PBMoves, :SWORDSDANCE), getID(PBMoves, :TAILGLOW),
     getID(PBMoves, :FLAMEBURST), getID(PBMoves, :FLASH),
     getID(PBMoves, :PSYBEAM), getID(PBMoves, :SIGNALBEAM),
     getID(PBMoves, :WATERPULSE), getID(PBMoves, :WILLOWISP),
     getID(PBMoves, :FIRESPIN), getID(PBMoves, :GLACIATE),
     getID(PBMoves, :ICEBALL), getID(PBMoves, :IONDELUGE),
     getID(PBMoves, :WHIRLPOOL),
     getID(PBMoves, :AURORABEAM), getID(PBMoves, :BUBBLEBEAM),
     getID(PBMoves, :MIRRORSHOT),
     getID(PBMoves, :HEARTSTAMP), getID(PBMoves, :PRESENT), 
     getID(PBMoves, :ROLLOUT),
     getID(PBMoves, :BUGBITE), getID(PBMoves, :CHATTER), 
     getID(PBMoves, :CONFIDE), getID(PBMoves, :FLING), 
     getID(PBMoves, :MUDSLAP), getID(PBMoves, :PLAYROUGH), 
     getID(PBMoves, :PLUCK), getID(PBMoves, :SIMPLEBEAM), 
     getID(PBMoves, :SWAGGER), getID(PBMoves, :TICKLE),
     getID(PBMoves, :BABYDOLLEYES),
     getID(PBMoves, :AFTERYOU),
     getID(PBMoves, :WISH),
     getID(PBMoves, :HONECLAWS), getID(PBMoves, :LUCKYCHANT), 
     getID(PBMoves, :SHARPEN),
     getID(PBMoves, :DIZZYPUNCH), getID(PBMoves, :SANDATTACK),
     getID(PBMoves, :ASTONISH), getID(PBMoves, :FAKEOUT), 
     getID(PBMoves, :FRUSTRATION), getID(PBMoves, :LICK), 
     getID(PBMoves, :MUDBOMB),
     getID(PBMoves, :FOLLOWME), getID(PBMoves, :INFESTATION),
     getID(PBMoves, :ATTACKORDER), getID(PBMoves, :HIDDENPOWER), 
     getID(PBMoves, :KINESIS), getID(PBMoves, :NIGHTSHADE), 
     getID(PBMoves, :TRANSFORM),
     getID(PBMoves, :ACID), getID(PBMoves, :EMBARGO), 
     getID(PBMoves, :POISONPOWDER), getID(PBMoves, :POISONTAIL), 
     getID(PBMoves, :TOXIC), getID(PBMoves, :VENOMDRENCH),
     getID(PBMoves, :FEINT), getID(PBMoves, :LOCKON), 
     getID(PBMoves, :MEFIRST), getID(PBMoves, :MINDREADER), 
     getID(PBMoves, :QUASH), getID(PBMoves, :SHADOWSNEAK),
     getID(PBMoves, :WHIRLWIND),
     getID(PBMoves, :PSYWAVE), getID(PBMoves, :SYNTHESIS),
     getID(PBMoves, :CRAFTYSHIELD), getID(PBMoves, :ELECTRICTERRAIN), 
     getID(PBMoves, :HYPERSPACEHOLE), getID(PBMoves, :SUCKERPUNCH),
     getID(PBMoves, :CALMMIND), getID(PBMoves, :CHARGE), 
     getID(PBMoves, :INGRAIN), getID(PBMoves, :LEECHSEED), 
     getID(PBMoves, :MAGNETICFLUX), getID(PBMoves, :NASTYPLOT), 
     getID(PBMoves, :SHIFTGEAR),
     getID(PBMoves, :ABSORB), getID(PBMoves, :CONFUSION), 
     getID(PBMoves, :GEARGRIND), getID(PBMoves, :HELPINGHAND),
     getID(PBMoves, :NEEDLEARM), getID(PBMoves, :POISONFANG), 
     getID(PBMoves, :PSYCHIC), getID(PBMoves, :SHADOWBALL), 
     getID(PBMoves, :ZENHEADBUTT),
     getID(PBMoves, :ALLYSWITCH), getID(PBMoves, :TOPSYTURVY), 
     getID(PBMoves, :TRICKROOM), getID(PBMoves, :WONDERROOM),
     getID(PBMoves, :FOULPLAY), getID(PBMoves, :LEECHLIFE), 
     getID(PBMoves, :MIRRORMOVE), getID(PBMoves, :RECYCLE), 
     getID(PBMoves, :SKETCH), getID(PBMoves, :SKILLSWAP), 
     getID(PBMoves, :SNATCH),
     getID(PBMoves, :GUST), getID(PBMoves, :KNOCKOFF), 
     getID(PBMoves, :LOWSWEEP), getID(PBMoves, :MEGADRAIN), 
     getID(PBMoves, :POISONSTING), getID(PBMoves, :SMOKESCREEN), 
     getID(PBMoves, :STRINGSHOT),
     getID(PBMoves, :FAIRYLOCK), getID(PBMoves, :HEALBLOCK), 
     getID(PBMoves, :IMPRISON), getID(PBMoves, :MAGICROOM), 
     getID(PBMoves, :RAGEPOWDER), getID(PBMoves, :SANDTOMB),
     getID(PBMoves, :BRINE), getID(PBMoves, :DRAGONRUSH), 
     getID(PBMoves, :DRILLRUN), getID(PBMoves, :SKULLBASH),
     getID(PBMoves, :SMELLINGSALTS), getID(PBMoves, :STONEEDGE), 
     getID(PBMoves, :WAKEUPSLAP),
     getID(PBMoves, :BONECLUB), getID(PBMoves, :CRABHAMMER), 
     getID(PBMoves, :CRUSHGRIP), getID(PBMoves, :MEGAPUNCH),
     getID(PBMoves, :OCTAZOOKA), getID(PBMoves, :SEISMICTOSS), 
     getID(PBMoves, :STEAMROLLER),
     getID(PBMoves, :BODYSLAM), getID(PBMoves, :CRUNCH),
     getID(PBMoves, :CONSTRICT), getID(PBMoves, :GASTROACID), 
     getID(PBMoves, :SCARYFACE), getID(PBMoves, :SLUDGEWAVE), 
     getID(PBMoves, :THOUSANDWAVES),
     getID(PBMoves, :BULLETPUNCH), getID(PBMoves, :ROCKPOLISH),
     getID(PBMoves, :BIDE), getID(PBMoves, :CURSE), 
     getID(PBMoves, :DRAGONTAIL), getID(PBMoves, :ENDURE),
     getID(PBMoves, :ACUPRESSURE), getID(PBMoves, :ARMTHRUST), 
     getID(PBMoves, :BONERUSH), getID(PBMoves, :COMETPUNCH), 
     getID(PBMoves, :FURYSWIPES), getID(PBMoves, :ROCKBLAST),
     getID(PBMoves, :HYPERSPACEFURY), getID(PBMoves, :WORKUP),
     getID(PBMoves, :HEATCRASH), getID(PBMoves, :HEAVYSLAM), 
     getID(PBMoves, :SHELLSMASH),
     getID(PBMoves, :CHIPAWAY), getID(PBMoves, :FLYINGPRESS),
     getID(PBMoves, :ANCIENTPOWER), getID(PBMoves, :COIL), 
     getID(PBMoves, :ROTOTILLER), getID(PBMoves, :STOCKPILE),
     getID(PBMoves, :BITE), getID(PBMoves, :SLUDGE),
     getID(PBMoves, :BIND), getID(PBMoves, :CLAMP), 
     getID(PBMoves, :MAGMASTORM), getID(PBMoves, :SKYDROP), 
     getID(PBMoves, :WRAP)] => 3,
    
    # 2 corazones
    [getID(PBMoves, :HAIL), getID(PBMoves, :SHEERCOLD),
     getID(PBMoves, :COTTONSPORE), getID(PBMoves, :ELECTROWEB),
     getID(PBMoves, :ACIDSPRAY), getID(PBMoves, :THOUSANDARROWS),
     getID(PBMoves, :MEANLOOK), getID(PBMoves, :RELICSONG),
     getID(PBMoves, :DISCHARGE), getID(PBMoves, :HEATWAVE),
     getID(PBMoves, :LANDSWRATH), getID(PBMoves, :PETALBLIZZARD),
     getID(PBMoves, :SURF),
     getID(PBMoves, :FIREBLAST), getID(PBMoves, :HYDROPUMP),
     getID(PBMoves, :NATUREPOWER), getID(PBMoves, :RAINDANCE),
     getID(PBMoves, :SUNNYDAY),
     getID(PBMoves, :AURASPHERE), getID(PBMoves, :CLEARSMOG),
     getID(PBMoves, :MAGICALLEAF),
     getID(PBMoves, :FEATHERDANCE), getID(PBMoves, :MAGICCOAT),
     getID(PBMoves, :MIRRORCOAT),
     getID(PBMoves, :CHARM), getID(PBMoves, :SOAK), 
     getID(PBMoves, :UPROAR),
     getID(PBMoves, :ENTRAINMENT), getID(PBMoves, :NUZZLE), 
     getID(PBMoves, :TRICKORTREAT),
     getID(PBMoves, :CELEBRATE), getID(PBMoves, :HAPPYHOUR), 
     getID(PBMoves, :MUDSPORT), getID(PBMoves, :WATERSPORT),
     getID(PBMoves, :ATTRACT), getID(PBMoves, :BLOCK), 
     getID(PBMoves, :ENCORE), getID(PBMoves, :SING), 
     getID(PBMoves, :SWEETKISS), getID(PBMoves, :YAWN),
     getID(PBMoves, :BESTOW), getID(PBMoves, :PLAYNICE),
     getID(PBMoves, :DISARMINGVOICE), getID(PBMoves, :MILKDRINK), 
     getID(PBMoves, :SOFTBOILED),
     getID(PBMoves, :FACADE), getID(PBMoves, :GROWL), 
     getID(PBMoves, :STRUGGLEBUG), getID(PBMoves, :TAILWHIP),
     getID(PBMoves, :FORESTSCURSE), getID(PBMoves, :MISTBALL), 
     getID(PBMoves, :STUNSPORE),
     getID(PBMoves, :CONFUSERAY), getID(PBMoves, :TAUNT),
     getID(PBMoves, :ELECTRIFY), getID(PBMoves, :FORESIGHT), 
     getID(PBMoves, :HEALORDER), getID(PBMoves, :HEX), 
     getID(PBMoves, :LUSTERPURGE), getID(PBMoves, :PURSUIT), 
     getID(PBMoves, :SWITCHEROO), getID(PBMoves, :TRICK),
     getID(PBMoves, :POWDER), getID(PBMoves, :ROOST),
     getID(PBMoves, :DARKVOID), getID(PBMoves, :DISABLE), 
     getID(PBMoves, :FLATTER), getID(PBMoves, :GRAVITY), 
     getID(PBMoves, :MAGNETRISE), getID(PBMoves, :SPIDERWEB),
     getID(PBMoves, :SPIKES), getID(PBMoves, :TELEKINESIS), 
     getID(PBMoves, :TOXICSPIKES), getID(PBMoves, :WORRYSEED),
     getID(PBMoves, :CAMOUFLAGE), getID(PBMoves, :GUARDSPLIT), 
     getID(PBMoves, :GUARDSWAP), getID(PBMoves, :HEARTSWAP),
     getID(PBMoves, :PAINSPLIT), getID(PBMoves, :PARABOLICCHARGE), 
     getID(PBMoves, :POWERSPLIT), getID(PBMoves, :POWERSWAP),
     getID(PBMoves, :NATURALGIFT),
     getID(PBMoves, :FEINTATTACK), getID(PBMoves, :MIRACLEEYE), 
     getID(PBMoves, :SHADOWPUNCH),
     getID(PBMoves, :PSYCHOSHIFT),
     getID(PBMoves, :EARTHQUAKE), getID(PBMoves, :FISSURE), 
     getID(PBMoves, :GUNKSHOT), getID(PBMoves, :HURRICANE), 
     getID(PBMoves, :SANDSTORM), getID(PBMoves, :SPITE), 
     getID(PBMoves, :SUPERFANG),
     getID(PBMoves, :SLUDGEBOMB), getID(PBMoves, :SMACKDOWN), 
     getID(PBMoves, :STICKYWEB), getID(PBMoves, :WRINGOUT),
     getID(PBMoves, :BONEMERANG), getID(PBMoves, :DUALCHOP),
     getID(PBMoves, :SNARL),
     getID(PBMoves, :SCALD), getID(PBMoves, :TORMENT),
     getID(PBMoves, :DRAINPUNCH), getID(PBMoves, :HORNLEECH), 
     getID(PBMoves, :THIEF),
     getID(PBMoves, :MAGNITUDE), getID(PBMoves, :POWERWHIP),
     getID(PBMoves, :NOBLEROAR),
     getID(PBMoves, :COUNTER), getID(PBMoves, :ENDEAVOR), 
     getID(PBMoves, :FOCUSPUNCH), getID(PBMoves, :PAYBACK), 
     getID(PBMoves, :REVENGE)] => 2,
    
    # 1 corazón
    [getID(PBMoves, :BLIZZARD), getID(PBMoves, :SPORE),
     getID(PBMoves, :BUGBUZZ), getID(PBMoves, :ICEBEAM),
     getID(PBMoves, :INFERNO), getID(PBMoves, :MOONBLAST),
     getID(PBMoves, :PSYSHOCK),
     getID(PBMoves, :ICESHARD),
     getID(PBMoves, :ICICLESPEAR), getID(PBMoves, :MOONLIGHT),
     getID(PBMoves, :MORNINGSUN), getID(PBMoves, :TRIATTACK),
     getID(PBMoves, :DIVE), getID(PBMoves, :LIGHTSCREEN),
     getID(PBMoves, :SAFEGUARD),
     getID(PBMoves, :FLOWERSHIELD), getID(PBMoves, :HEALBELL),
     getID(PBMoves, :MIST),
     getID(PBMoves, :FUSIONFLARE),
     getID(PBMoves, :CONVERSION), getID(PBMoves, :CONVERSION2),
     getID(PBMoves, :ROUND), getID(PBMoves, :VENOSHOCK),
     getID(PBMoves, :CHARGEBEAM), getID(PBMoves, :FIERYDANCE),
     getID(PBMoves, :ASSIST), getID(PBMoves, :BARRAGE), 
     getID(PBMoves, :DOUBLESLAP), getID(PBMoves, :METRONOME), 
     getID(PBMoves, :SLEEPTALK), getID(PBMoves, :TAILSLAP),
     getID(PBMoves, :DEFENSECURL), getID(PBMoves, :PROTECT), 
     getID(PBMoves, :REFRESH), getID(PBMoves, :SUBSTITUTE), 
     getID(PBMoves, :SWEETSCENT), getID(PBMoves, :WITHDRAW),
     getID(PBMoves, :DRAININGKISS),
     getID(PBMoves, :FLAIL), getID(PBMoves, :GRASSKNOT),
     getID(PBMoves, :BATONPASS), getID(PBMoves, :LASTRESORT),
     getID(PBMoves, :EERIEIMPULSE), getID(PBMoves, :HYPNOSIS), 
     getID(PBMoves, :METALSOUND), getID(PBMoves, :NIGHTMARE), 
     getID(PBMoves, :SLEEPPOWDER),
     getID(PBMoves, :GIGADRAIN),
     getID(PBMoves, :PAYDAY),
     getID(PBMoves, :DEFENDORDER), getID(PBMoves, :FLY), 
     getID(PBMoves, :GRASSWHISTLE), getID(PBMoves, :ODORSLEUTH), 
     getID(PBMoves, :REFLECT),
     getID(PBMoves, :ASSURANCE),
     getID(PBMoves, :DREAMEATER), getID(PBMoves, :FUTURESIGHT), 
     getID(PBMoves, :POWERTRICK), getID(PBMoves, :PSYCHUP), 
     getID(PBMoves, :RECOVER), getID(PBMoves, :REFLECTTYPE), 
     getID(PBMoves, :SYNCHRONOISE),
     getID(PBMoves, :BEATUP), getID(PBMoves, :SECRETPOWER), 
     getID(PBMoves, :STOREDPOWER),
     getID(PBMoves, :GLARE), getID(PBMoves, :RAGE),
     getID(PBMoves, :DIG), getID(PBMoves, :HARDEN), 
     getID(PBMoves, :SWALLOW),
     getID(PBMoves, :LOWKICK),
     getID(PBMoves, :BELCH), getID(PBMoves, :POWERUPPUNCH), 
     getID(PBMoves, :SPITUP)] => 1,
  }
  
  #-----------------------------------------------------------------------------
  # Configuración de JAM (por ID de movimiento)
  # Formato: [ID_MOVIMIENTO1, ID_MOVIMIENTO2, ...] => valor_jam
  #-----------------------------------------------------------------------------
  JAM = {
    # Jam 4
    [getID(PBMoves, :FRENZYPLANT), getID(PBMoves, :HYPERBEAM),
     getID(PBMoves, :BUGBUZZ), getID(PBMoves, :ICEBEAM),
     getID(PBMoves, :INFERNO), getID(PBMoves, :MOONBLAST),
     getID(PBMoves, :PSYSHOCK),
     getID(PBMoves, :BLASTBURN), getID(PBMoves, :HYDROCANNON),
     getID(PBMoves, :ROAROFTIME), getID(PBMoves, :GIGADRAIN),
     getID(PBMoves, :BODYSLAM), getID(PBMoves, :CRUNCH),
     getID(PBMoves, :BULLDOZE), getID(PBMoves, :LAVAPLUME), 
     getID(PBMoves, :MUDDYWATER), getID(PBMoves, :ROCKSLIDE),
     getID(PBMoves, :BOOMBURST), getID(PBMoves, :GIGAIMPACT), 
     getID(PBMoves, :GRUDGE), getID(PBMoves, :ROCKWRECKER)] => 4,
    
    # Jam 3
    [getID(PBMoves, :DRAGONBREATH),
     getID(PBMoves, :MATBLOCK), getID(PBMoves, :THUNDERWAVE),
     getID(PBMoves, :BLIZZARD), getID(PBMoves, :SPORE),
     getID(PBMoves, :AURORABEAM), getID(PBMoves, :BUBBLEBEAM),
     getID(PBMoves, :MIRRORSHOT),
     getID(PBMoves, :ASTONISH), getID(PBMoves, :FAKEOUT), 
     getID(PBMoves, :FRUSTRATION), getID(PBMoves, :LICK), 
     getID(PBMoves, :MUDBOMB),
     getID(PBMoves, :EERIEIMPULSE), getID(PBMoves, :HYPNOSIS), 
     getID(PBMoves, :METALSOUND), getID(PBMoves, :NIGHTMARE), 
     getID(PBMoves, :SLEEPPOWDER),
     getID(PBMoves, :FOULPLAY), getID(PBMoves, :LEECHLIFE), 
     getID(PBMoves, :MIRRORMOVE), getID(PBMoves, :RECYCLE), 
     getID(PBMoves, :SKETCH), getID(PBMoves, :SKILLSWAP), 
     getID(PBMoves, :SNATCH),
     getID(PBMoves, :GLARE), getID(PBMoves, :RAGE),
     getID(PBMoves, :BITE), getID(PBMoves, :SLUDGE)] => 3,
    
    # Jam 2
    [getID(PBMoves, :DISCHARGE), getID(PBMoves, :HEATWAVE),
     getID(PBMoves, :LANDSWRATH), getID(PBMoves, :PETALBLIZZARD),
     getID(PBMoves, :SURF),
     getID(PBMoves, :DRAINPUNCH), getID(PBMoves, :HORNLEECH), 
     getID(PBMoves, :THIEF)] => 2,
    
    # Jam 1
    [getID(PBMoves, :GUILLOTINE), getID(PBMoves, :HORNDRILL),
     getID(PBMoves, :ZAPCANNON),
     getID(PBMoves, :DYNAMICPUNCH), getID(PBMoves, :LEER),
     getID(PBMoves, :PUNISHMENT),
     getID(PBMoves, :CROSSPOISON), getID(PBMoves, :DOUBLEHIT),
     getID(PBMoves, :DOUBLEKICK), getID(PBMoves, :EXTRASENSORY),
     getID(PBMoves, :SKYUPPERCUT), getID(PBMoves, :TWINEEDLE),
     getID(PBMoves, :XSCISSOR),
     getID(PBMoves, :HAIL), getID(PBMoves, :SHEERCOLD),
     getID(PBMoves, :COTTONSPORE), getID(PBMoves, :ELECTROWEB),
     getID(PBMoves, :ACIDSPRAY), getID(PBMoves, :THOUSANDARROWS),
     getID(PBMoves, :CHARM), getID(PBMoves, :SOAK), 
     getID(PBMoves, :UPROAR),
     getID(PBMoves, :ENTRAINMENT), getID(PBMoves, :NUZZLE), 
     getID(PBMoves, :TRICKORTREAT),
     getID(PBMoves, :FORESTSCURSE), getID(PBMoves, :MISTBALL), 
     getID(PBMoves, :STUNSPORE),
     getID(PBMoves, :CONFUSERAY), getID(PBMoves, :TAUNT),
     getID(PBMoves, :ELECTRIFY), getID(PBMoves, :FORESIGHT), 
     getID(PBMoves, :HEALORDER), getID(PBMoves, :HEX), 
     getID(PBMoves, :LUSTERPURGE), getID(PBMoves, :PURSUIT), 
     getID(PBMoves, :SWITCHEROO), getID(PBMoves, :TRICK),
     getID(PBMoves, :EARTHQUAKE), getID(PBMoves, :FISSURE), 
     getID(PBMoves, :GUNKSHOT), getID(PBMoves, :HURRICANE), 
     getID(PBMoves, :SANDSTORM), getID(PBMoves, :SPITE), 
     getID(PBMoves, :SUPERFANG),
     getID(PBMoves, :SLUDGEBOMB), getID(PBMoves, :SMACKDOWN), 
     getID(PBMoves, :STICKYWEB), getID(PBMoves, :WRINGOUT),
     getID(PBMoves, :BONEMERANG), getID(PBMoves, :DUALCHOP)] => 1,
  }

  #-----------------------------------------------------------------------------
  # Configuración de categoría de concurso (por ID de movimiento)
  # Formato: [ID_MOVIMIENTO1, ID_MOVIMIENTO2, ...] => "Categoría"
  # Categorías válidas: "Cool", "Beauty", "Cute", "Smart", "Tough"
  #-----------------------------------------------------------------------------
  CATEGORIES = {
    [getID(PBMoves, :BRAVEBIRD), getID(PBMoves, :FLAREBLITZ), 
     getID(PBMoves, :HIGHJUMPKICK), getID(PBMoves, :JUMPKICK),
     getID(PBMoves, :OUTRAGE), getID(PBMoves, :SUBMISSION),
     getID(PBMoves, :VCREATE), getID(PBMoves, :VOLTTACKLE),
     getID(PBMoves, :FALSESWIPE), getID(PBMoves, :HOLDBACK), 
     getID(PBMoves, :VOLTSWITCH),
     getID(PBMoves, :AIRCUTTER), getID(PBMoves, :BRICKBREAK), 
     getID(PBMoves, :CUT), getID(PBMoves, :DARKPULSE),
     getID(PBMoves, :DRAGONCLAW), getID(PBMoves, :FIREFANG),
     getID(PBMoves, :FOCUSBLAST), getID(PBMoves, :FORCEPALM),
     getID(PBMoves, :HORNATTACK), getID(PBMoves, :ICEFANG),
     getID(PBMoves, :IRONTAIL), getID(PBMoves, :METALCLAW),
     getID(PBMoves, :PECK), getID(PBMoves, :PSYCHOCUT),
     getID(PBMoves, :RAZORLEAF), getID(PBMoves, :ROLLINGKICK),
     getID(PBMoves, :SHADOWCLAW), getID(PBMoves, :SLASH),
     getID(PBMoves, :SPARK), getID(PBMoves, :THUNDERFANG),
     getID(PBMoves, :THUNDERPUNCH), getID(PBMoves, :THUNDERSHOCK),
     getID(PBMoves, :THUNDERBOLT), getID(PBMoves, :TWISTER),
     getID(PBMoves, :VINEWHIP), getID(PBMoves, :WINGATTACK),
     getID(PBMoves, :FRENZYPLANT), getID(PBMoves, :HYPERBEAM),
     getID(PBMoves, :CROSSCHOP), getID(PBMoves, :DRILLPECK),
     getID(PBMoves, :NIGHTSLASH), getID(PBMoves, :RAZORWIND),
     getID(PBMoves, :RETALIATE), getID(PBMoves, :SKYATTACK),
     getID(PBMoves, :SOLARBEAM), getID(PBMoves, :STEELWING),
     getID(PBMoves, :BLAZEKICK), getID(PBMoves, :DRAGONRAGE),
     getID(PBMoves, :FURYCUTTER), getID(PBMoves, :HYPERFANG),
     getID(PBMoves, :LEAFBLADE), getID(PBMoves, :LEAFTORNADO),
     getID(PBMoves, :MEGAHORN), getID(PBMoves, :METEORMASH),
     getID(PBMoves, :NIGHTDAZE), getID(PBMoves, :PSYSTRIKE),
     getID(PBMoves, :RAZORSHELL), getID(PBMoves, :SEARINGSHOT),
     getID(PBMoves, :SONICBOOM), getID(PBMoves, :TRIPLEKICK),
     getID(PBMoves, :AGILITY), getID(PBMoves, :AQUAJET),
     getID(PBMoves, :EXTREMESPEED), getID(PBMoves, :MACHPUNCH),
     getID(PBMoves, :QUICKATTACK), getID(PBMoves, :TAILWIND),
     getID(PBMoves, :VACUUMWAVE), getID(PBMoves, :WATERSHURIKEN),
     getID(PBMoves, :CIRCLETHROW), getID(PBMoves, :ROAR),
     getID(PBMoves, :ELECTROBALL),
     getID(PBMoves, :AEROBLAST), getID(PBMoves, :PARTINGSHOT),
     getID(PBMoves, :PRECIPICEBLADES),
     getID(PBMoves, :GUILLOTINE), getID(PBMoves, :HORNDRILL),
     getID(PBMoves, :ZAPCANNON),
     getID(PBMoves, :DYNAMICPUNCH), getID(PBMoves, :LEER),
     getID(PBMoves, :PUNISHMENT),
     getID(PBMoves, :CROSSPOISON), getID(PBMoves, :DOUBLEHIT),
     getID(PBMoves, :DOUBLEKICK), getID(PBMoves, :EXTRASENSORY),
     getID(PBMoves, :SKYUPPERCUT), getID(PBMoves, :TWINEEDLE),
     getID(PBMoves, :XSCISSOR),
     getID(PBMoves, :SACREDSWORD), getID(PBMoves, :STORMTHROW),
     getID(PBMoves, :STEALTHROCK),
     getID(PBMoves, :HYPERVOICE),
     getID(PBMoves, :DRAGONBREATH),
     getID(PBMoves, :AERIALACE), getID(PBMoves, :DEFOG),
     getID(PBMoves, :MAGNETBOMB), getID(PBMoves, :QUICKGUARD),
     getID(PBMoves, :SHOCKWAVE), getID(PBMoves, :SWIFT),
     getID(PBMoves, :HOWL), getID(PBMoves, :METALBURST),
     getID(PBMoves, :VITALTHROW),
     getID(PBMoves, :MATBLOCK), getID(PBMoves, :THUNDERWAVE),
     getID(PBMoves, :AIRSLASH), getID(PBMoves, :CRUSHCLAW),
     getID(PBMoves, :BULLETSEED), getID(PBMoves, :FURYATTACK),
     getID(PBMoves, :PINMISSILE), getID(PBMoves, :SPIKECANNON),
     getID(PBMoves, :BULKUP), getID(PBMoves, :DOUBLETEAM),
     getID(PBMoves, :DRAGONDANCE), getID(PBMoves, :FOCUSENERGY),
     getID(PBMoves, :BARRIER), getID(PBMoves, :DETECT),
     getID(PBMoves, :KINGSSHIELD), getID(PBMoves, :PHANTOMFORCE),
     getID(PBMoves, :SHADOWFORCE), getID(PBMoves, :TELEPORT),
     getID(PBMoves, :OBLIVIONWING),
     getID(PBMoves, :FUSIONBOLT), getID(PBMoves, :GYROBALL),
     getID(PBMoves, :REVERSAL), getID(PBMoves, :TRUMPCARD),
     getID(PBMoves, :FELLSTINGER), getID(PBMoves, :MEGAKICK),
     getID(PBMoves, :RAPIDSPIN), getID(PBMoves, :THUNDER),
     getID(PBMoves, :ACROBATICS), getID(PBMoves, :FLAMECHARGE),
     getID(PBMoves, :TECHNOBLAST)] => "Cool",
     
    [getID(PBMoves, :EXPLOSION), getID(PBMoves, :HEALINGWISH), 
     getID(PBMoves, :LUNARDANCE), getID(PBMoves, :SELFDESTRUCT),
     getID(PBMoves, :DRACOMETEOR), getID(PBMoves, :DRAGONASCENT),
     getID(PBMoves, :ERUPTION), getID(PBMoves, :LEAFSTORM),
     getID(PBMoves, :LIGHTOFRUIN), getID(PBMoves, :OVERHEAT),
     getID(PBMoves, :PETALDANCE), getID(PBMoves, :SEEDFLARE),
     getID(PBMoves, :SPACIALREND), getID(PBMoves, :WATERSPOUT),
     getID(PBMoves, :AVALANCHE), getID(PBMoves, :FLAMEWHEEL),
     getID(PBMoves, :FREEZESHOCK), getID(PBMoves, :ICEBURN),
     getID(PBMoves, :BLUEFLARE), getID(PBMoves, :BOLTSTRIKE),
     getID(PBMoves, :ECHOEDVOICE), getID(PBMoves, :FREEZEDRY),
     getID(PBMoves, :JUDGMENT), getID(PBMoves, :MYSTICALFIRE),
     getID(PBMoves, :SECRETSWORD), getID(PBMoves, :WEATHERBALL),
     getID(PBMoves, :BLIZZARD), getID(PBMoves, :SPORE),
     getID(PBMoves, :HAIL), getID(PBMoves, :SHEERCOLD),
     getID(PBMoves, :COTTONSPORE), getID(PBMoves, :ELECTROWEB),
     getID(PBMoves, :ACIDSPRAY), getID(PBMoves, :THOUSANDARROWS),
     getID(PBMoves, :BUGBUZZ), getID(PBMoves, :ICEBEAM),
     getID(PBMoves, :INFERNO), getID(PBMoves, :MOONBLAST),
     getID(PBMoves, :PSYSHOCK),
     getID(PBMoves, :HAZE),
     getID(PBMoves, :ICESHARD),
     getID(PBMoves, :ICICLESPEAR), getID(PBMoves, :MOONLIGHT),
     getID(PBMoves, :MORNINGSUN), getID(PBMoves, :TRIATTACK),
     getID(PBMoves, :GRASSYTERRAIN), getID(PBMoves, :MISTYTERRAIN),
     getID(PBMoves, :ORIGINPULSE),
     getID(PBMoves, :DIAMONDSTORM), getID(PBMoves, :DOOMDESIRE),
     getID(PBMoves, :ICICLECRASH), getID(PBMoves, :SACREDFIRE),
     getID(PBMoves, :STEAMERUPTION),
     getID(PBMoves, :FIREPLEDGE), getID(PBMoves, :GRASSPLEDGE),
     getID(PBMoves, :HEALPULSE), getID(PBMoves, :WATERPLEDGE),
     getID(PBMoves, :AQUARING), getID(PBMoves, :AROMATICMIST),
     getID(PBMoves, :AUTOTOMIZE), getID(PBMoves, :COSMICPOWER),
     getID(PBMoves, :GEOMANCY), getID(PBMoves, :GROWTH),
     getID(PBMoves, :MEDITATE), getID(PBMoves, :OMINOUSWIND),
     getID(PBMoves, :QUIVERDANCE), getID(PBMoves, :SILVERWIND),
     getID(PBMoves, :SWORDSDANCE), getID(PBMoves, :TAILGLOW),
     getID(PBMoves, :FLAMEBURST), getID(PBMoves, :FLASH),
     getID(PBMoves, :PSYBEAM), getID(PBMoves, :SIGNALBEAM),
     getID(PBMoves, :WATERPULSE), getID(PBMoves, :WILLOWISP),
     getID(PBMoves, :FROSTBREATH), getID(PBMoves, :ICYWIND),
     getID(PBMoves, :LOVELYKISS), getID(PBMoves, :PERISHSONG),
     getID(PBMoves, :MEANLOOK), getID(PBMoves, :RELICSONG),
     getID(PBMoves, :DIVE), getID(PBMoves, :LIGHTSCREEN),
     getID(PBMoves, :SAFEGUARD),
     getID(PBMoves, :FLOWERSHIELD), getID(PBMoves, :HEALBELL),
     getID(PBMoves, :MIST),
     getID(PBMoves, :AQUATAIL), getID(PBMoves, :DAZZLINGGLEAM),
     getID(PBMoves, :DRAGONPULSE), getID(PBMoves, :EARTHPOWER),
     getID(PBMoves, :ENERGYBALL), getID(PBMoves, :FAIRYWIND),
     getID(PBMoves, :FLAMETHROWER), getID(PBMoves, :FLASHCANNON),
     getID(PBMoves, :ICEPUNCH), getID(PBMoves, :POWDERSNOW),
     getID(PBMoves, :POWERGEM),
     getID(PBMoves, :DISCHARGE), getID(PBMoves, :HEATWAVE),
     getID(PBMoves, :LANDSWRATH), getID(PBMoves, :PETALBLIZZARD),
     getID(PBMoves, :SURF),
     getID(PBMoves, :BLASTBURN), getID(PBMoves, :HYDROCANNON),
     getID(PBMoves, :ROAROFTIME),
     getID(PBMoves, :AURORABEAM), getID(PBMoves, :BUBBLEBEAM),
     getID(PBMoves, :MIRRORSHOT),
     getID(PBMoves, :FIRESPIN), getID(PBMoves, :GLACIATE),
     getID(PBMoves, :ICEBALL), getID(PBMoves, :IONDELUGE),
     getID(PBMoves, :WHIRLPOOL),
     getID(PBMoves, :FUSIONFLARE),
     getID(PBMoves, :FIREBLAST), getID(PBMoves, :HYDROPUMP),
     getID(PBMoves, :NATUREPOWER), getID(PBMoves, :RAINDANCE),
     getID(PBMoves, :SUNNYDAY),
     getID(PBMoves, :AURASPHERE), getID(PBMoves, :CLEARSMOG),
     getID(PBMoves, :MAGICALLEAF),
     getID(PBMoves, :FEATHERDANCE), getID(PBMoves, :MAGICCOAT),
     getID(PBMoves, :MIRRORCOAT),
     getID(PBMoves, :CONVERSION), getID(PBMoves, :CONVERSION2),
     getID(PBMoves, :ROUND), getID(PBMoves, :VENOSHOCK),
     getID(PBMoves, :CHARGEBEAM), getID(PBMoves, :FIERYDANCE)] => "Beauty",
     
    [getID(PBMoves, :BELLYDRUM),
     getID(PBMoves, :HEARTSTAMP), getID(PBMoves, :PRESENT), 
     getID(PBMoves, :ROLLOUT),
     getID(PBMoves, :CHARM), getID(PBMoves, :SOAK), 
     getID(PBMoves, :UPROAR),
     getID(PBMoves, :ENTRAINMENT), getID(PBMoves, :NUZZLE), 
     getID(PBMoves, :TRICKORTREAT),
     getID(PBMoves, :BUGBITE), getID(PBMoves, :CHATTER), 
     getID(PBMoves, :CONFIDE), getID(PBMoves, :FLING), 
     getID(PBMoves, :MUDSLAP), getID(PBMoves, :PLAYROUGH), 
     getID(PBMoves, :PLUCK), getID(PBMoves, :SIMPLEBEAM), 
     getID(PBMoves, :SWAGGER), getID(PBMoves, :TICKLE),
     getID(PBMoves, :BABYDOLLEYES),
     getID(PBMoves, :AFTERYOU),
     getID(PBMoves, :ASSIST), getID(PBMoves, :BARRAGE), 
     getID(PBMoves, :DOUBLESLAP), getID(PBMoves, :METRONOME), 
     getID(PBMoves, :SLEEPTALK), getID(PBMoves, :TAILSLAP),
     getID(PBMoves, :WISH),
     getID(PBMoves, :CELEBRATE), getID(PBMoves, :HAPPYHOUR), 
     getID(PBMoves, :MUDSPORT), getID(PBMoves, :WATERSPORT),
     getID(PBMoves, :HONECLAWS), getID(PBMoves, :LUCKYCHANT), 
     getID(PBMoves, :SHARPEN),
     getID(PBMoves, :DIZZYPUNCH), getID(PBMoves, :SANDATTACK),
     getID(PBMoves, :CAPTIVATE), getID(PBMoves, :FAKETEARS), 
     getID(PBMoves, :SLACKOFF), getID(PBMoves, :SNORE), 
     getID(PBMoves, :SPLASH), getID(PBMoves, :UTURN),
     getID(PBMoves, :ATTRACT), getID(PBMoves, :BLOCK), 
     getID(PBMoves, :ENCORE), getID(PBMoves, :SING), 
     getID(PBMoves, :SWEETKISS), getID(PBMoves, :YAWN),
     getID(PBMoves, :DEFENSECURL), getID(PBMoves, :PROTECT), 
     getID(PBMoves, :REFRESH), getID(PBMoves, :SUBSTITUTE), 
     getID(PBMoves, :SWEETSCENT), getID(PBMoves, :WITHDRAW),
     getID(PBMoves, :AMNESIA), getID(PBMoves, :BOUNCE), 
     getID(PBMoves, :COTTONGUARD), getID(PBMoves, :HOLDHANDS), 
     getID(PBMoves, :MINIMIZE), getID(PBMoves, :REST),
     getID(PBMoves, :BUBBLE), getID(PBMoves, :EGGBOMB), 
     getID(PBMoves, :EMBER), getID(PBMoves, :RETURN), 
     getID(PBMoves, :WATERGUN),
     getID(PBMoves, :DRAININGKISS),
     getID(PBMoves, :COPYCAT), getID(PBMoves, :COVET), 
     getID(PBMoves, :MIMIC), getID(PBMoves, :ROLEPLAY),
     getID(PBMoves, :TEETERDANCE),
     getID(PBMoves, :ASTONISH), getID(PBMoves, :FAKEOUT), 
     getID(PBMoves, :FRUSTRATION), getID(PBMoves, :LICK), 
     getID(PBMoves, :MUDBOMB),
     getID(PBMoves, :FOLLOWME), getID(PBMoves, :INFESTATION),
     getID(PBMoves, :FLAIL), getID(PBMoves, :GRASSKNOT),
     getID(PBMoves, :BESTOW), getID(PBMoves, :PLAYNICE),
     getID(PBMoves, :DISARMINGVOICE), getID(PBMoves, :MILKDRINK), 
     getID(PBMoves, :SOFTBOILED),
     getID(PBMoves, :FACADE), getID(PBMoves, :GROWL), 
     getID(PBMoves, :STRUGGLEBUG), getID(PBMoves, :TAILWHIP),
     getID(PBMoves, :BATONPASS), getID(PBMoves, :LASTRESORT)] => "Cute",
     
    [getID(PBMoves, :DESTINYBOND),
     getID(PBMoves, :PSYCHOBOOST),
     getID(PBMoves, :ATTACKORDER), getID(PBMoves, :HIDDENPOWER), 
     getID(PBMoves, :KINESIS), getID(PBMoves, :NIGHTSHADE), 
     getID(PBMoves, :TRANSFORM),
     getID(PBMoves, :EERIEIMPULSE), getID(PBMoves, :HYPNOSIS), 
     getID(PBMoves, :METALSOUND), getID(PBMoves, :NIGHTMARE), 
     getID(PBMoves, :SLEEPPOWDER),
     getID(PBMoves, :FORESTSCURSE), getID(PBMoves, :MISTBALL), 
     getID(PBMoves, :STUNSPORE),
     getID(PBMoves, :CONFUSERAY), getID(PBMoves, :TAUNT),
     getID(PBMoves, :ELECTRIFY), getID(PBMoves, :FORESIGHT), 
     getID(PBMoves, :HEALORDER), getID(PBMoves, :HEX), 
     getID(PBMoves, :LUSTERPURGE), getID(PBMoves, :PURSUIT), 
     getID(PBMoves, :SWITCHEROO), getID(PBMoves, :TRICK),
     getID(PBMoves, :GIGADRAIN),
     getID(PBMoves, :ACID), getID(PBMoves, :EMBARGO), 
     getID(PBMoves, :POISONPOWDER), getID(PBMoves, :POISONTAIL), 
     getID(PBMoves, :TOXIC), getID(PBMoves, :VENOMDRENCH),
     getID(PBMoves, :FEINT), getID(PBMoves, :LOCKON), 
     getID(PBMoves, :MEFIRST), getID(PBMoves, :MINDREADER), 
     getID(PBMoves, :QUASH), getID(PBMoves, :SHADOWSNEAK),
     getID(PBMoves, :WHIRLWIND),
     getID(PBMoves, :PSYWAVE), getID(PBMoves, :SYNTHESIS),
     getID(PBMoves, :CRAFTYSHIELD), getID(PBMoves, :ELECTRICTERRAIN), 
     getID(PBMoves, :HYPERSPACEHOLE), getID(PBMoves, :SUCKERPUNCH),
     getID(PBMoves, :PAYDAY),
     getID(PBMoves, :CALMMIND), getID(PBMoves, :CHARGE), 
     getID(PBMoves, :INGRAIN), getID(PBMoves, :LEECHSEED), 
     getID(PBMoves, :MAGNETICFLUX), getID(PBMoves, :NASTYPLOT), 
     getID(PBMoves, :SHIFTGEAR),
     getID(PBMoves, :POISONGAS), getID(PBMoves, :ROCKTOMB), 
     getID(PBMoves, :SCREECH), getID(PBMoves, :SUPERSONIC),
     getID(PBMoves, :POWDER), getID(PBMoves, :ROOST),
     getID(PBMoves, :DARKVOID), getID(PBMoves, :DISABLE), 
     getID(PBMoves, :FLATTER), getID(PBMoves, :GRAVITY), 
     getID(PBMoves, :MAGNETRISE), getID(PBMoves, :SPIDERWEB),
     getID(PBMoves, :SPIKES), getID(PBMoves, :TELEKINESIS), 
     getID(PBMoves, :TOXICSPIKES), getID(PBMoves, :WORRYSEED),
     getID(PBMoves, :DEFENDORDER), getID(PBMoves, :FLY), 
     getID(PBMoves, :GRASSWHISTLE), getID(PBMoves, :ODORSLEUTH), 
     getID(PBMoves, :REFLECT),
     getID(PBMoves, :AROMATHERAPY),
     getID(PBMoves, :ABSORB), getID(PBMoves, :CONFUSION), 
     getID(PBMoves, :GEARGRIND), getID(PBMoves, :HELPINGHAND),
     getID(PBMoves, :NEEDLEARM), getID(PBMoves, :POISONFANG), 
     getID(PBMoves, :PSYCHIC), getID(PBMoves, :SHADOWBALL), 
     getID(PBMoves, :ZENHEADBUTT),
     getID(PBMoves, :ALLYSWITCH), getID(PBMoves, :TOPSYTURVY), 
     getID(PBMoves, :TRICKROOM), getID(PBMoves, :WONDERROOM),
     getID(PBMoves, :CAMOUFLAGE), getID(PBMoves, :GUARDSPLIT), 
     getID(PBMoves, :GUARDSWAP), getID(PBMoves, :HEARTSWAP),
     getID(PBMoves, :PAINSPLIT), getID(PBMoves, :PARABOLICCHARGE), 
     getID(PBMoves, :POWERSPLIT), getID(PBMoves, :POWERSWAP),
     getID(PBMoves, :FOULPLAY), getID(PBMoves, :LEECHLIFE), 
     getID(PBMoves, :MIRRORMOVE), getID(PBMoves, :RECYCLE), 
     getID(PBMoves, :SKETCH), getID(PBMoves, :SKILLSWAP), 
     getID(PBMoves, :SNATCH),
     getID(PBMoves, :GUST), getID(PBMoves, :KNOCKOFF), 
     getID(PBMoves, :LOWSWEEP), getID(PBMoves, :MEGADRAIN), 
     getID(PBMoves, :POISONSTING), getID(PBMoves, :SMOKESCREEN), 
     getID(PBMoves, :STRINGSHOT),
     getID(PBMoves, :FAIRYLOCK), getID(PBMoves, :HEALBLOCK), 
     getID(PBMoves, :IMPRISON), getID(PBMoves, :MAGICROOM), 
     getID(PBMoves, :RAGEPOWDER), getID(PBMoves, :SANDTOMB),
     getID(PBMoves, :ASSURANCE),
     getID(PBMoves, :NATURALGIFT),
     getID(PBMoves, :FEINTATTACK), getID(PBMoves, :MIRACLEEYE), 
     getID(PBMoves, :SHADOWPUNCH),
     getID(PBMoves, :PSYCHOSHIFT),
     getID(PBMoves, :DREAMEATER), getID(PBMoves, :FUTURESIGHT), 
     getID(PBMoves, :POWERTRICK), getID(PBMoves, :PSYCHUP), 
     getID(PBMoves, :RECOVER), getID(PBMoves, :REFLECTTYPE), 
     getID(PBMoves, :SYNCHRONOISE),
     getID(PBMoves, :BEATUP), getID(PBMoves, :SECRETPOWER), 
     getID(PBMoves, :STOREDPOWER)] => "Smart",
     
     [getID(PBMoves, :FINALGAMBIT),
     getID(PBMoves, :CLOSECOMBAT), getID(PBMoves, :DOUBLEEDGE), 
     getID(PBMoves, :HAMMERARM), getID(PBMoves, :HEADCHARGE), 
     getID(PBMoves, :HEADSMASH), getID(PBMoves, :SUPERPOWER), 
     getID(PBMoves, :TAKEDOWN), getID(PBMoves, :THRASH), 
     getID(PBMoves, :WILDCHARGE), getID(PBMoves, :WOODHAMMER),
     getID(PBMoves, :BRINE), getID(PBMoves, :DRAGONRUSH), 
     getID(PBMoves, :DRILLRUN), getID(PBMoves, :SKULLBASH),
     getID(PBMoves, :SMELLINGSALTS), getID(PBMoves, :STONEEDGE), 
     getID(PBMoves, :WAKEUPSLAP),
     getID(PBMoves, :BONECLUB), getID(PBMoves, :CRABHAMMER), 
     getID(PBMoves, :CRUSHGRIP), getID(PBMoves, :MEGAPUNCH),
     getID(PBMoves, :OCTAZOOKA), getID(PBMoves, :SEISMICTOSS), 
     getID(PBMoves, :STEAMROLLER),
     getID(PBMoves, :GLARE), getID(PBMoves, :RAGE),
     getID(PBMoves, :EARTHQUAKE), getID(PBMoves, :FISSURE), 
     getID(PBMoves, :GUNKSHOT), getID(PBMoves, :HURRICANE), 
     getID(PBMoves, :SANDSTORM), getID(PBMoves, :SPITE), 
     getID(PBMoves, :SUPERFANG),
     getID(PBMoves, :SLUDGEBOMB), getID(PBMoves, :SMACKDOWN), 
     getID(PBMoves, :STICKYWEB), getID(PBMoves, :WRINGOUT),
     getID(PBMoves, :BONEMERANG), getID(PBMoves, :DUALCHOP),
     getID(PBMoves, :BODYSLAM), getID(PBMoves, :CRUNCH),
     getID(PBMoves, :CONSTRICT), getID(PBMoves, :GASTROACID), 
     getID(PBMoves, :SCARYFACE), getID(PBMoves, :SLUDGEWAVE), 
     getID(PBMoves, :THOUSANDWAVES),
     getID(PBMoves, :BULLETPUNCH), getID(PBMoves, :ROCKPOLISH),
     getID(PBMoves, :BIDE), getID(PBMoves, :CURSE), 
     getID(PBMoves, :DRAGONTAIL), getID(PBMoves, :ENDURE),
     getID(PBMoves, :ACUPRESSURE), getID(PBMoves, :ARMTHRUST), 
     getID(PBMoves, :BONERUSH), getID(PBMoves, :COMETPUNCH), 
     getID(PBMoves, :FURYSWIPES), getID(PBMoves, :ROCKBLAST),
     getID(PBMoves, :HYPERSPACEFURY), getID(PBMoves, :WORKUP),
     getID(PBMoves, :HEATCRASH), getID(PBMoves, :HEAVYSLAM), 
     getID(PBMoves, :SHELLSMASH),
     getID(PBMoves, :CHIPAWAY), getID(PBMoves, :FLYINGPRESS),
     getID(PBMoves, :ANCIENTPOWER), getID(PBMoves, :COIL), 
     getID(PBMoves, :ROTOTILLER), getID(PBMoves, :STOCKPILE),
     getID(PBMoves, :INCINERATE), getID(PBMoves, :ROCKCLIMB),
     getID(PBMoves, :SNARL),
     getID(PBMoves, :SCALD), getID(PBMoves, :TORMENT),
     getID(PBMoves, :DIG), getID(PBMoves, :HARDEN), 
     getID(PBMoves, :SWALLOW),
     getID(PBMoves, :ACIDARMOR), getID(PBMoves, :IRONDEFENSE), 
     getID(PBMoves, :SPIKYSHIELD), getID(PBMoves, :WIDEGUARD),
     getID(PBMoves, :FIREPUNCH), getID(PBMoves, :HEADBUTT), 
     getID(PBMoves, :IRONHEAD), getID(PBMoves, :KARATECHOP), 
     getID(PBMoves, :MUDSHOT), getID(PBMoves, :POISONJAB),
     getID(PBMoves, :POUND), getID(PBMoves, :ROCKSMASH), 
     getID(PBMoves, :ROCKTHROW), getID(PBMoves, :SCRATCH), 
     getID(PBMoves, :SEEDBOMB), getID(PBMoves, :SLAM),
     getID(PBMoves, :SMOG), getID(PBMoves, :STOMP), 
     getID(PBMoves, :STRENGTH), getID(PBMoves, :STRUGGLE), 
     getID(PBMoves, :TACKLE), getID(PBMoves, :VICEGRIP), 
     getID(PBMoves, :WATERFALL),
     getID(PBMoves, :DRAINPUNCH), getID(PBMoves, :HORNLEECH), 
     getID(PBMoves, :THIEF),
     getID(PBMoves, :BULLDOZE), getID(PBMoves, :LAVAPLUME), 
     getID(PBMoves, :MUDDYWATER), getID(PBMoves, :ROCKSLIDE),
     getID(PBMoves, :BOOMBURST), getID(PBMoves, :GIGAIMPACT), 
     getID(PBMoves, :GRUDGE), getID(PBMoves, :ROCKWRECKER),
     getID(PBMoves, :BITE), getID(PBMoves, :SLUDGE),
     getID(PBMoves, :BIND), getID(PBMoves, :CLAMP), 
     getID(PBMoves, :MAGMASTORM), getID(PBMoves, :SKYDROP), 
     getID(PBMoves, :WRAP),
     getID(PBMoves, :LOWKICK),
     getID(PBMoves, :MAGNITUDE), getID(PBMoves, :POWERWHIP),
     getID(PBMoves, :NOBLEROAR),
     getID(PBMoves, :COUNTER), getID(PBMoves, :ENDEAVOR), 
     getID(PBMoves, :FOCUSPUNCH), getID(PBMoves, :PAYBACK), 
     getID(PBMoves, :REVENGE),
     getID(PBMoves, :BELCH), getID(PBMoves, :POWERUPPUNCH), 
     getID(PBMoves, :SPITUP)] => "Tough",
     
  }
  
  #-----------------------------------------------------------------------------
  # Descripciones de efectos de concurso
  # Formato: código_efecto => descripción
  #-----------------------------------------------------------------------------
  EFFECT_DESCRIPTIONS = {
    0   => _INTL("Permite realizar una exhibición muy llamativa."),
    1   => _INTL("Evita que el Pokémon sea intimidado en una ocasión."),
    2   => _INTL("Altera el orden en la siguiente ronda."),
    3   => _INTL("Templa momentáneamente el fervor del público."),
    4   => _INTL("Intimida a los que han usado movimientos del mismo tipo."),
    5   => _INTL("Inquieta a los Pokémon que se exhiban a continuación."),
    6   => _INTL("Intimida un poco a los que han usado movimientos del mismo tipo."),
    7   => _INTL("Intimida un poco al Pokémon que se ha exhibido antes."),
    8   => _INTL("Intimida al Pokémon que se ha exhibido antes."),
    9   => _INTL("Intimida a los Pokémon que ya han realizado su exhibición."),
    10  => _INTL("Hace que los Pokémon que ya se han exhibido se acobarden."),
    11  => _INTL("Intimida a los Pokémon que acaparan la atención del público."),
    12  => _INTL("Intimida mucho a los Pokémon que acaparan la atención del público."),
    13  => _INTL("Pone nerviosos a los Pokémon que aún no se han exhibido."),
    14  => _INTL("La exhibición es un éxito si se usa cuando uno es el primero del turno."),
    15  => _INTL("La exhibición es un éxito si se usa cuando uno es el último del turno."),
    16  => _INTL("Hace que el usuario se mueva antes en el siguiente turno."),
    17  => _INTL("Si el Pokémon se exhibe en primer lugar, se meterá al público en el bolsillo."),
    18  => _INTL("Hace que el Pokémon se exhiba mucho, pero será fácil que lo intimiden después."),
    19  => _INTL("Entusiasma al público en cualquier concurso."),
    20  => _INTL("Hace que todos los Pokémon que se han exhibido bien se acobarden."),
    21  => _INTL("Su impacto varía según cuándo se utilice."),
    22  => _INTL("Hace que el Pokémon se exhiba mucho, pero será fácil que lo intimiden después."),
    23  => _INTL("Causa mayor impacto cuanto más tarde se usa."),
    24  => _INTL("Hace que el usuario se mueva después en el siguiente turno."),
    25  => _INTL("Entusiasma mucho al público si se exhibe en primer lugar."),
    26  => _INTL("Funciona mejor cuanto más excitado está el público."),
    27  => _INTL("Funciona bien si es del mismo tipo que el último movimiento usado."),
    28  => _INTL("Hace que el público espere poco de otros participantes."),
    29  => _INTL("Entusiasma mucho al público si se usa en último lugar."),
    30  => _INTL("Puede evitar que intimiden al Pokémon."),
    31  => _INTL("Aumenta la confianza y ayuda a mantener la calma."),
    32  => _INTL("Aumenta la confianza y ayuda a mantener la calma."),
    33  => _INTL("Obtiene +3 si el Pokémon consigue la puntuación más baja."),
    34  => _INTL("Muestra una exhibición tan buena como los movimientos anteriores."),
    35  => _INTL("Se ve afectado por cómo fue la exhibición del Pokémon anterior."),
    36  => _INTL("Aumenta su impacto conforme aumenta el entusiasmo del público."),
    37  => _INTL("Mejora la condición del usuario. Ayuda a evitar que se ponga nervioso."),
    38  => _INTL("Funciona bien si el usuario está motivado."),
    39  => _INTL("Aumenta el impacto del usuario en la mitad de los corazones obtenidos."),
    40  => _INTL("Obtiene +3 si la última exhibición también inició un combo."),
    41  => _INTL("El Pokémon da todo de sí, pero no podrá exhibirse en los turnos restantes."),
    42  => _INTL("Intimida a todos los demás Pokémon, pero el usuario no puede actuar en el siguiente turno."),
  }

  #-----------------------------------------------------------------------------
  # Valores por defecto
  #-----------------------------------------------------------------------------
  DEFAULT_HEARTS = 4
  DEFAULT_JAM = 0
  DEFAULT_EFFECT = 0
  DEFAULT_CATEGORY = "Cool"
  
  #-----------------------------------------------------------------------------
  # Métodos auxiliares para buscar en hashs con arrays como claves
  #-----------------------------------------------------------------------------
  
  def self.get_from_array_hash(hash, moveid)
    hash.each do |key, value|
      if key.is_a?(Array)
        return value if key.include?(moveid)
      elsif key == moveid
        return value
      end
    end
    return nil
  end
  
end

################################################################################
# Clase para obtener datos de movimientos de concurso
################################################################################

class PBContestMoveData
  attr_reader :contestType, :hearts, :jam, :contestfunction
  
  def initialize(moveid)
    # Obtener categoría
    category = ContestMoveConfig.get_from_array_hash(ContestMoveConfig::CATEGORIES, moveid)
    if category
      @contestType = category
    else
      # Obtener tipo del movimiento desde PBMoveData
      begin
        movedata = PBMoveData.new(moveid)
        movetype = movedata.type
        
        # Mapeo directo de IDs de tipo a categorías
        type_to_category_map = {
          0 => "Cute",    # NORMAL
          1 => "Cool",    # FIGHTING
          2 => "Cool",    # FLYING
          3 => "Smart",   # POISON
          4 => "Tough",   # GROUND
          5 => "Tough",   # ROCK
          6 => "Cute",    # BUG
          7 => "Smart",   # GHOST
          8 => "Tough",   # STEEL
          9 => "Beauty",  # QMRKS
          10 => "Beauty", # FIRE
          11 => "Beauty", # WATER
          12 => "Smart",  # GRASS
          13 => "Cool",   # ELECTRIC
          14 => "Smart",  # PSYCHIC
          15 => "Beauty", # ICE
          16 => "Cool",   # DRAGON
          17 => "Cool",   # DARK
          18 => "Cute",   # FAIRY
          19 => "Cool",   # SHADOW
          20 => "Cute",   # STELLAR
        }
        
        @contestType = type_to_category_map[movetype] || ContestMoveConfig::DEFAULT_CATEGORY
      rescue
        @contestType = ContestMoveConfig::DEFAULT_CATEGORY
      end
    end
    
    # Obtener corazones
    hearts = ContestMoveConfig.get_from_array_hash(ContestMoveConfig::HEARTS, moveid)
    @hearts = hearts || ContestMoveConfig::DEFAULT_HEARTS
    
    # Obtener JAM
    jam = ContestMoveConfig.get_from_array_hash(ContestMoveConfig::JAM, moveid)
    @jam = jam || ContestMoveConfig::DEFAULT_JAM
    
    # Obtener efecto
    effect = ContestMoveConfig.get_from_array_hash(ContestMoveConfig::EFFECTS, moveid)
    @contestfunction = effect || ContestMoveConfig::DEFAULT_EFFECT
  end

end

################################################################################
# Métodos auxiliares para obtener descripciones de efectos
################################################################################

def pbGetContestEffectDescription(effectcode)
  return ContestMoveConfig::EFFECT_DESCRIPTIONS[effectcode] || "A highly appealing move."
end

def pbGetContestMoveDescription(moveid)
  movedata = PBContestMoveData.new(moveid)
  return pbGetContestEffectDescription(movedata.contestfunction)
end

################################################################################
# Clase PBContestMove actualizada
################################################################################

class PBContestMove
  attr_reader :hearts, :jam, :contestfunction, :id
  
  # Gets this move's type.
  def type
    contestmovedata = PBContestMoveData.new(@id)
    return contestmovedata.contestType
  end
  
  # Gets the number of hearts.
  def hearts
    contestmovedata = PBContestMoveData.new(@id)
    return contestmovedata.hearts
  end
  
  # Gets the JAM value
  def jam
    contestmovedata = PBContestMoveData.new(@id)
    return contestmovedata.jam
  end
  
  # Gets the effect description
  def description
    return pbGetContestMoveDescription(@id)
  end
  
  # Initializes this object to the specified move ID.
  def initialize(moveid)
    @id = moveid
    contestmovedata = PBContestMoveData.new(moveid)
    @contestfunction = contestmovedata.contestfunction
    @hearts = contestmovedata.hearts
    @jam = contestmovedata.jam
  end
end

################################################################################
# Clase temporal para compatibilidad
################################################################################

class PokemonContestTemp
  attr_accessor :pokemonContestMoveData
  
  # Ya no necesitamos abrir archivos, pero mantenemos compatibilidad
  def pbOpenContestMoveData
    # No hace nada, los datos se obtienen directamente desde ContestMoveConfig
    return nil
  end
end

################################################################################
# Método de compilación (ya no hace nada pero se mantiene por compatibilidad)
################################################################################

def pbCompileContestMoves
  # Ya no necesitamos compilar nada, pero mantenemos el método
  # para que scripts antiguos no den error
  puts "Contest moves are now configured directly in script."
  puts "No compilation needed."
end

################################################################################
# MÓDULO DE COMPATIBILIDAD - PBContestMoves
# Simula la clase PBContestMoves para compatibilidad con código antiguo
################################################################################

module PBContestMoves
  
  # Devuelve el nombre de un movimiento
  def self.getName(id)
    return PBMoves.getName(id)
  end
  
  # Devuelve la cantidad total de movimientos
  def self.getCount
    return PBMoves.getCount
  end
  
  # Devuelve el valor máximo de ID de movimiento
  def self.maxValue
    return PBMoves.maxValue
  end
  
  # Para compatibilidad con getID y constantes
  def self.const_missing(name)
    # Intentar obtener la constante de PBMoves
    return PBMoves.const_get(name) if PBMoves.const_defined?(name)
    raise NameError.new("uninitialized constant PBContestMoves::#{name}")
  end
  
end

# Copiar constantes de PBMoves a PBContestMoves para compatibilidad total
if defined?(PBMoves)
  PBMoves.constants.each do |const|
    const_name = const.to_s
    next if const_name[0,1] == "_"
    begin
      value = PBMoves.const_get(const)
      PBContestMoves.const_set(const, value) unless PBContestMoves.const_defined?(const)
    rescue
      # Ignorar errores silenciosamente
    end
  end
end

=begin
Efectos sin uso (mantenidos por compatibilidad):
  5: Inquieta a los Pokémon que se exhiban a continuación.
  6: Intimida un poco a los que han usado movimientos del mismo tipo.
  7: Intimida un poco al Pokémon que se ha exhibido antes.
  17: Si el Pokémon se exhibe en primer lugar, se meterá al público en el bolsillo.
  22: Hace que el Pokémon se exhiba mucho, pero será fácil que lo intimiden después.
  30: Puede evitar que intimiden al Pokémon.
  32: Aumenta la confianza y ayuda a mantener la calma.
  33: Obtiene +3 si el Pokémon consigue la puntuación más baja.
  36: Aumenta su impacto conforme aumenta el entusiasmo del público.
  37: Mejora la condición del usuario. Ayuda a evitar que se ponga nervioso.
  39: Aumenta el impacto del usuario en la mitad de los corazones obtenidos.
  40: Obtiene +3 si la última exhibición también inició un combo.
=end