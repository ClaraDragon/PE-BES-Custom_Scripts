################################################################################
# EXTENSIÓN DE POKEMONGLOBALMETADATA PARA CONCURSOS
# Añade este código ANTES de los scripts de concurso
################################################################################

class PokemonGlobalMetadata
  attr_accessor :contestType          # Tipo de concurso: 0=Cool, 1=Beauty, 2=Cute, 3=Smart, 4=Tough
  attr_accessor :contestPlayerPokemon # Índice del Pokémon del jugador en el party
  
  alias contest_initialize initialize
  def initialize
    contest_initialize
    @contestType = 0
    @contestPlayerPokemon = 0
  end
end
################################################################################
# FUNCIONES HELPER PARA CONFIGURAR CONCURSOS
################################################################################

# Configurar el tipo de concurso
# Tipos: 0 (Cool), 1 (Beauty), 2 (Cute), 3 (Smart), 4 (Tough)
def pbSetContestType(type)
  $PokemonGlobal.contestType = type
end

# Configurar qué Pokémon del jugador participará
# index: Posición en el party (0 = primero, 1 = segundo, etc)
def pbSetContestPokemon(index)
  $PokemonGlobal.contestPlayerPokemon = index
end

# Funciones de conveniencia para configurar por nombre
def pbSetContestTypeCool
  pbSetContestType(0)
end

def pbSetContestTypeBeauty
  pbSetContestType(1)
end

def pbSetContestTypeCute
  pbSetContestType(2)
end

def pbSetContestTypeSmart
  pbSetContestType(3)
end

def pbSetContestTypeTough
  pbSetContestType(4)
end

################################################################################
# EJEMPLO DE USO EN EVENTOS:
################################################################################
#
# Script en un evento:
#
# pbSetContestTypeBeauty      # Configurar concurso de Belleza
# pbSetContestPokemon(0)       # Usar el primer Pokémon del party
# pbContest(50, :CHARIZARD, 20, :SQUIRTLE, 20, :HITMONTOP, 20, 1)
#
# O con números directos:
#
# pbSetContestType(1)          # 1 = Beauty
# pbSetContestPokemon(0)       # Primer Pokémon
# pbContest(50, :CHARIZARD, 20, :SQUIRTLE, 20, :HITMONTOP, 20, 1)
#
################################################################################


################################################################################
# blank array to store moves to teach contest pokemon
################################################################################
CONTESTMOVE2=[0,0,0,0]
CONTESTMOVE3=[0,0,0,0]
CONTESTMOVE4=[0,0,0,0]

def pbAddContestMove(poke, *moves)
  # Convertir todos los argumentos a un array plano
  move_array = []
  moves.each do |move|
    if move.is_a?(Array)
      # Si es un array, añadir todos sus elementos
      move_array.concat(move)
    elsif move != 0 && move != nil
      # Si es un movimiento individual
      move_array << move
    end
  end
  # Limitar a máximo 4 movimientos
  move_array = move_array[0..3]
  # Convertir símbolos/strings a IDs
  converted_moves = []
  move_array.each_with_index do |move, i|
    if move.is_a?(String) || move.is_a?(Symbol)
      move_str = move.is_a?(Symbol) ? move.to_s : move
      if hasConst?(PBMoves, move_str.upcase)
        converted_moves[i] = getID(PBMoves, move_str.upcase)
      else
        raise _INTL("El movimiento {1} no existe", move_str)
      end
    elsif move.is_a?(Numeric)
      converted_moves[i] = move > 0 ? move : 0
    else
      converted_moves[i] = 0
    end
  end
  # Rellenar con 0s si hay menos de 4 movimientos
  while converted_moves.length < 4
    converted_moves << 0
  end
  # Asignar a la variable correcta
  case poke
  when 2
    converted_moves.each_with_index do |move, i|
      CONTESTMOVE2[i] = move
    end
  when 3
    converted_moves.each_with_index do |move, i|
      CONTESTMOVE3[i] = move
    end
  when 4
    converted_moves.each_with_index do |move, i|
      CONTESTMOVE4[i] = move
    end
  else
    raise _INTL("Índice de Pokémon inválido: {1} (debe ser 2, 3 o 4)", poke)
  end
  
  return converted_moves
end
################################################################################
# nicknaming contest pokemon
################################################################################
$CONTESTNAME2=""
$CONTESTNAME3=""
$CONTESTNAME4=""

def pbChangeContestName(poke,name="")
  if name !="" && name.length<16
    case poke
    when 2
      $CONTESTNAME2=name
    when 3
      $CONTESTNAME3=name
    when 4
      $CONTESTNAME4=name
    end
  end
end

################################################################################
# SISTEMA DE COMBOS DE CONCURSO
################################################################################
# NUEVO FORMATO: Usa arrays de símbolos para los movimientos
# Formato:
# {
#   :starter => [:MOVIMIENTO1, :MOVIMIENTO2],  # Movimientos que INICIAN combo
#   :followup => [:MOVIMIENTO3, :MOVIMIENTO4]  # Movimientos que SIGUEN combo
# }
################################################################################
# Definición de combos
################################################################################

COMBOS = {
  :combo1 => {
    :starter => [:BELLYDRUM],
    :followup => [:REST]
  },
  :combo2 => {
    :starter => [:CALMMIND],
    :followup => [
      :CONFUSION, :DREAMEATER, :FUTURESIGHT, :LIGHTSCREEN,
      :LUSTERPURGE, :MEDITATE, :MISTBALL, :PSYBEAM, :PSYCHIC,
      :PSYCHOBOOST, :PSYWAVE, :REFLECT
    ]
  },
  :combo3 => {
    :starter => [:CHARGE],
    :followup => [
      :BOLTSTRIKE, :CHARGEBEAM, :DISCHARGE, :ELECTROBALL,
      :FUSIONBOLT, :NUZZLE, :PARABOLICCHARGE, :SHOCKWAVE,
      :SPARK, :THUNDER, :THUNDERFANG, :THUNDERPUNCH,
      :THUNDERSHOCK, :THUNDERBOLT, :VOLTSWITCH, :VOLTTACKLE
    ]
  },
  :combo4 => {
    :starter => [:CHARM],
    :followup => [:FLATTER, :GROWL, :REST, :TAILWHIP]
  },
  :combo5 => {
    :starter => [:CONFUSION],
    :followup => [:FUTURESIGHT, :KINESIS, :PSYCHIC, :TELEPORT]
  },
  :combo6 => {
    :starter => [:CURSE],
    :followup => [:DESTINYBOND, :GRUDGE, :MEANLOOK, :SPITE]
  },
  :combo7 => {
    :starter => [:DEFENSECURL],
    :followup => [:ROLLOUT, :TACKLE, :ICEBALL]
  },
  :combo8 => {
    :starter => [:DIVE],
    :followup => [:SURF,:WHIRLPOOL]
  },
  :combo9 => {
    :starter => [:DOUBLETEAM],
    :followup => [:AGILITY, :QUICKATTACK, :TELEPORT]
  },

  :combo10 => {
    :starter => [:DRAGONBREATH],
    :followup => [:DRAGONCLAW, :DRAGONDANCE, :DRAGONRAGE]
  },

  :combo11 => {
    :starter => [:EARTHQUAKE],
    :followup => [:ERUPTION, :FISSURE]
  },

  :combo12 => {
    :starter => [:ENDURE],
    :followup => [:ENDEAVOR, :FLAIL, :REVERSAL, :PAINSPLIT]
  },

  :combo13 => {
    :starter => [:FAKEOUT],
    :followup => [:ARMTHRUST, :FAINTATTACK, :KNOCKOFF, :SEISMICTOSS, :VITALTHROW]
  },

  :combo14 => {
    :starter => [:FIREPUNCH],
    :followup => [:ICEPUNCH, :THUNDERPUNCH]
  },

  :combo15 => {
    :starter => [:FOCUSENERGY],
    :followup => [
      :ARMTHRUST, :BRICKBREAK, :CROSSCHOP, :DOUBLEEDGE,
      :DYNAMICPUNCH, :FOCUSPUNCH, :HEADBUTT, :KARATECHOP,
      :SKYUPPERCUT, :TAKEDOWN, :AEROBLAST, :ATTACKORDER,
      :BLAZEKICK, :CROSSPOISON, :DRILLRUN, :LEAFBLADE,
      :NIGHTSLASH, :POISONTAIL, :PSYCHOCUT, :SHADOWCLAW,
      :SPACIALREND, :STONEEDGE
    ]
  },

  :combo16 => {
    :starter => [:GROWTH],
    :followup => [
      :ABSORB, :BULLETSEED, :FRENZYPLANT, :GIGADRAIN,
      :LEECHSEED, :MAGICALLEAF, :MEGADRAIN, :PETALDANCE,
      :RAZORLEAF, :SOLARBEAM, :VINEWHIP
    ]
  },

  :combo17 => {
    :starter => [:HAIL, :SNOWSCAPE],
    :followup => [
      :AURORABEAM, :BLIZZARD, :HAZE, :ICEBALL, :ICEBEAM,
      :ICICLESPEAR, :ICYWIND, :POWDERSNOW, :SHEERCOLD,
      :WEATHERBALL, :GLACIATE, :ICICILECRASH, :AURORAVEIL
    ]
  },

  :combo18 => {
    :starter => [:HARDEN],
    :followup => [:DOUBLEEDGE, :PROTECT, :ROLLOUT, :TACKLE, :TAKEDOWN]
  },

  :combo19 => {
    :starter => [:HORNATTACK],
    :followup => [:HORNDRILL, :FURYATTACK]
  },

  :combo20 => {
    :starter => [:HYPNOSIS],
    :followup => [:DREAMEATER]
  },

  :combo21 => {
    :starter => [:ICEPUNCH],
    :followup => [:FIREPUNCH, :THUNDERPUNCH]
  },

  :combo22 => {
    :starter => [:KINESIS],
    :followup => [:CONFUSION, :FUTURESIGHT, :PSYCHIC, :TELEPORT]
  },

  :combo23 => {
    :starter => [:LEER],
    :followup => [:BITE, :FAINTATTACK, :GLARE, :HORNATTACK, :SCARYFACE, :SCRATCH, :STOMP, :TACKLE]
  },

  :combo24 => {
    :starter => [:LOCKON],
    :followup => [:SUPERPOWER, :THUNDER, :TRIATTACK, :ZAPCANNON]
  },

  :combo25 => {
    :starter => [:MEANLOOK],
    :followup => [:DESTINYBOND, :PERISHSONG]
  },

  :combo26 => {
    :starter => [:METALSOUND],
    :followup => [:METALCLAW]
  },

  :combo27 => {
    :starter => [:MINDREADER],
    :followup => [:DYNAMICPUNCH, :HIJUMPKICK, :SHEERCOLD, :SUBMISSION, :SUPERPOWER]
  },

  :combo28 => {
    :starter => [:MUDSPORT],
    :followup => [:MUDSLAP, :WATERGUN, :WATERSPORT]
  },

  :combo29 => {
    :starter => [:PECK],
    :followup => [:DRILLPECK, :FURYATTACK]
  },

  :combo30 => {
    :starter => [:POUND],
    :followup => [:DOUBLESLAP, :FAINTATTACK, :SLAM]
  },

  :combo31 => {
    :starter => [:POWDERSNOW],
    :followup => [:BLIZZARD]
  },

  :combo32 => {
    :starter => [:PSYCHIC],
    :followup => [:CONFUSION, :TELEPORT, :FUTURESIGHT, :KINESIS]
  },

  :combo33 => {
    :starter => [:RAGE],
    :followup => [:LEER, :SCARYFACE, :THRASH]
  },

  :combo34 => {
    :starter => [:RAINDANCE],
    :followup => [
      :BUBBLE, :BUBBLEBEAM, :CLAMP, :CRABHAMMER, :DIVE,
      :HYDROCANNON, :HYDROPUMP, :MUDDYWATER, :OCTAZOOKA,
      :SURF, :THUNDER, :WATERGUN, :WATERPULSE, :WATERSPORT,
      :WATERFALL, :WEATHERBALL, :WHIRLPOOL, :HURRICANE, :SOAK
    ]
  },

  :combo35 => {
    :starter => [:REST],
    :followup => [:SLEEPTALK, :SNORE]
  },

  :combo36 => {
    :starter => [:ROCKTHROW],
    :followup => [:ROCKSLIDE, :ROCKTOMB]
  },

  :combo37 => {
    :starter => [:SANDATTACK],
    :followup => [:MUDSLAP]
  },

  :combo38 => {
    :starter => [:SANDSTORM],
    :followup => [:MUDSHOT, :MUDSLAP, :MUDSPORT, :SANDTOMB, :SANDATTACK, :WEATHERBALL, :SHOREUP]
  },

  :combo39 => {
    :starter => [:SCARYFACE],
    :followup => [:BITE, :CRUNCH, :LEER]
  },

  :combo40 => {
    :starter => [:SCRATCH],
    :followup => [:FURYSWIPES, :SLASH]
  },

  :combo41 => {
    :starter => [:SING],
    :followup => [:PERISHSONG, :REFRESH]
  },

  :combo42 => {
    :starter => [:SLUDGE],
    :followup => [:SLUDGEBOMB]
  },

  :combo43 => {
    :starter => [:SMOG],
    :followup => [:SMOKESCREEN]
  },

  :combo44 => {
    :starter => [:STOCKPILE],
    :followup => [:SPITUP, :SWALLOW]
  },

  :combo45 => {
    :starter => [:SUNNYDAY],
    :followup => [
      :BLASTBURN, :BLAZEKICK, :EMBER, :ERUPTION, :FIREBLAST,
      :FIREPUNCH, :FIRESPIN, :FLAMEWHEEL, :FLAMETHROWER,
      :HEATWAVE, :MOONLIGHT, :MORNINGSUN, :OVERHEAT,
      :SACREDFIRE, :SOLARBEAM, :SYNTHESIS, :WEATHERBALL,
      :WILLOWISP, :GROWTH
    ]
  },

  :combo46 => {
    :starter => [:SWEETSCENT],
    :followup => [:POISONPOWDER, :SLEEPPOWDER, :STUNSPORE]
  },

  :combo47 => {
    :starter => [:SWORDSDANCE],
    :followup => [:CRABHAMMER, :CRUSHCLAW, :CUT, :FALSESWIPE, :FURYCUTTER, :SLASH]
  },

  :combo48 => {
    :starter => [:TAUNT],
    :followup => [:COUNTER, :DETECT, :MIRRORCOAT]
  },

  :combo49 => {
    :starter => [:THUNDERPUNCH],
    :followup => [:FIREPUNCH, :ICEPUNCH]
  },

  :combo50 => {
    :starter => [:VICEGRIP],
    :followup => [:BIND, :GUILLOTINE]
  },

  :combo51 => {
    :starter => [:WATERSPORT],
    :followup => [:MUDSPORT, :REFRESH, :WATERGUN]
  },

  :combo52 => {
    :starter => [:YAWN],
    :followup => [:REST, :SLACKOFF]
  },

  :combo53 => {
    :starter => [:AGILITY, :AUTOTOMIZE, :ROCKPOLISH, :SHELLSMASH],
    :followup => [:BATONPASS, :ELECTROBALL]
  },

  :combo54 => {
    :starter => [:AMNESIA, :CALMMIND, :COTTONGUARD, :HONECLAWS, :NASTYPLOT],
    :followup => [:BATONPASS, :STOREDPOWER]
  },

  :combo55 => {
    :starter => [:BLOCK, :MEANLOOK, :SPIDERWEB],
    :followup => [:EXPLOSION, :MEMENTO, :SELFDESTRUCT, :PERISHSONG]
  },

  :combo56 => {
    :starter => [:CELEBRATE, :COVET, :HAPPYHOUR, :WISH],
    :followup => [:BESTOW, :FLING, :PRESENT]
  },

  :combo57 => {
    :starter => [:DARKVOID, :GRASSWHISTLE, :HYPNOSIS, :LOVELYKISS, :SING, :SLEEPPOWDER, :SPORE, :YAWN],
    :followup => [:DREAMEATER, :HEX, :NIGHTMARE, :WAKEUPSLAP]
  },

  :combo58 => {
    :starter => [:ENCORE, :TAUNT, :TORMENT],
    :followup => [:COUNTER, :DESTINYBOND, :GRUDGE, :KINGSSHIELD, :METALBURST, :MIRRORCOAT, :SPITE]
  },

  :combo59 => {
    :starter => [:ENTRAINMENT, :HOLDHANDS, :PLAYNICE],
    :followup => [:CIRCLETHROW, :SEISMICTOSS, :SKYDROP, :SMACKDOWN, :STORMTHROW, :VITALTHROW, :WAKEUPSLAP]
  },

  :combo60 => {
    :starter => [:FORCEPALM, :GLARE, :NUZZLE, :STUNSPORE, :THUNDERWAVE, :ZAPCANNON],
    :followup => [:HEX, :SMELLINGSALTS]
  },

  :combo61 => {
    :starter => [:INFERNO, :WILLOWISP],
    :followup => [:HEX]
  },

  :combo62 => {
    :starter => [:LOCKON, :MINDREADER, :MIRACLEEYE],
    :followup => [:FISSURE, :GUILLOTINE, :HORNDRILL, :SHEERCOLD]
  },

  :combo63 => {
    :starter => [:PARABOLICCHARGE],
    :followup => [:ELECTRIFY]
  },

  :combo64 => {
    :starter => [:POISONGAS, :POISONPOWDER, :TOXIC, :TOXICSPIKES],
    :followup => [:HEX, :VENOMDRENCH, :VENOSHOCK]
  },

  :combo65 => {
    :starter => [:REFLECTTYPE],
    :followup => [:SYNCHRONOISE]
  },

  :combo66 => {
    :starter => [:ROTOTILLER],
    :followup => [:BULLETSEED, :LEECHSEED, :SEEDBOMB, :WORRYSEED]
  },

  :combo67 => {
    :starter => [:SHIFTGEAR],
    :followup => [:GEARGRIND]
  },

  :combo68 => {
    :starter => [:SOFTBOILED],
    :followup => [:EGGBOMB]
  },

  :combo69 => {
    :starter => [:SPIKES, :STEALTHROCK, :TOXICSPIKES],
    :followup => [:CIRCLETHROW, :DRAGONTAIL, :ROAR, :WHIRLWIND]
  },
  
  #COMBOS CUSTOM
  :combo70 => {
    :starter => [:DIG],
    :followup => [:EARTHQUAKE,:MAGNITUDE,:BULLDOZE,:FISSURE]
  },
  :combo71 => {
    :starter => [:DIG],
    :followup => [:EARTHQUAKE,:MAGNITUDE,:BULLDOZE,:FISSURE]
  },
  :combo72 => {
    :starter => [:FLY,:BOUNCE,:SKYDROP],
    :followup => [:TWISTER,:SKYUPPERCUT,:GUST,:HURRICANE,:THUNDER,]
  },
  :combo73 => {
    :starter => [:MINIMIZE],
    :followup => [:BODYSLAM,:STOMP,:ASTONISH,:EXTRASENSORY,:NEEDLEARM,:DRAGONRUSH,:SHADOWFORCE,
                  :STEAMROLLER,:HEATCRASH,:HEAVYSLAM,:PHANTOMFORCE,:FLYINGPRESS,
                  :MALICIOUSMOONSAULT,:DOUBLEIRONBASH,:SUPERCELLSLAM]
  },
  :combo73 => {
    :starter => [:GRASSYTERRAIN],
    :followup => [:BODYSLAM,:STOMP,:ASTONISH,:EXTRASENSORY,:NEEDLEARM,:DRAGONRUSH,:SHADOWFORCE,
                  :STEAMROLLER,:HEATCRASH,:HEAVYSLAM,:PHANTOMFORCE,:FLYINGPRESS,
                  :MALICIOUSMOONSAULT,:DOUBLEIRONBASH,:SUPERCELLSLAM]
  },
  
}

################################################################################
# Funciones de utilidad para manejar combos
################################################################################

# Inicializar hash para búsquedas rápidas
CONTEST_COMBO_HASH = {}

def pbInitContestCombos
  CONTEST_COMBO_HASH.clear
  
  COMBOS.each_value do |combo_data|
    # Convertir símbolos a IDs de movimiento
    combo_data[:starter].each do |move_sym|
      starter_id = getID(PBMoves, move_sym)
      next if starter_id == 0
      
      # Inicializar array si no existe
      CONTEST_COMBO_HASH[starter_id] ||= []
      
      # Añadir todos los movimientos de followup (convertidos a IDs)
      combo_data[:followup].each do |followup_sym|
        followup_id = getID(PBMoves, followup_sym)
        next if followup_id == 0
        CONTEST_COMBO_HASH[starter_id] << followup_id
      end
    end
  end
end

# Función para verificar combos (compatible con el sistema actual)
def pbCheckforCombos
  oldmoveid = case @currentpoke
  when @pkmn1 then @pkmn1lastmoveid
  when @pkmn2 then @pkmn2lastmoveid
  when @pkmn3 then @pkmn3lastmoveid
  when @pkmn4 then @pkmn4lastmoveid
  else 0
  end
  
  return false unless oldmoveid > 0
  return false unless CONTEST_COMBO_HASH[oldmoveid]
  
  CONTEST_COMBO_HASH[oldmoveid].include?(@currentmove)
end

class PokeContest
  def initialize(scene)
    @scene=scene
  end

  def pbStartContest(difficulty,opponent1,opponent2,opponent3,ribbonnum)
    pbFadeOutIn(99997) {
      @scene.pbStartContest(difficulty,opponent1,opponent2,opponent3,ribbonnum)
      @scene.middleScene
      @scene.pbEndScene
    }
  end
end

def pbContest(difficulty, opponent1, opponent2, opponent3, ribbonnum)
  if difficulty == :MASTER
    difficulty = 100
  elsif difficulty == :HYPER
    difficulty = 70
  elsif difficulty == :SUPER
    difficulty = 45
  elsif difficulty == :NORMAL
    difficulty = 29
  end
  # Función helper para crear Pokémon desde array
  def create_pokemon_from_array(data)
    return data unless data.is_a?(Array)
    
    species = data[0]
    level = data[1] || 30  # Nivel por defecto 30
    name =  data[2] if data.length > 2
    
    pokemon = PokeBattle_Pokemon.new(species, level, $Trainer)
    pokemon.ot = name ? name : ""
    pokemon.calcStats
    return pokemon
  end
  # Convertir cada oponente si es necesario
  opponent1 = create_pokemon_from_array(opponent1)
  opponent2 = create_pokemon_from_array(opponent2)
  opponent3 = create_pokemon_from_array(opponent3)
  
  scene = PokeContestScene.new
  screen = PokeContest.new(scene)
  return screen.pbStartContest(difficulty, opponent1, opponent2, opponent3, ribbonnum)
end