#===============================================================================
# Sistema de Oponentes para Concursos - Pokémon Essentials v16
#===============================================================================
def pbContestTrainerGraphic(event,trainer)
  if trainer.is_a?(String) || trainer.is_a?(Symbol)
    return 1 if !hasConst?(PBTrainers,trainer) #Si no encuentra el trainer usa el 1 de placeholder.
    trainer=PBTrainers.const_get(trainer)
  end
  filename= pbTrainerCharNameFile(trainer)
  begin
    bitmap=AnimatedBitmap.new("Graphics/Characters/"+filename)
    bitmap.dispose
    event.character_name=filename
  rescue
    event.character_name="Red"
  end
end

#===============================================================================
# Sistema de Oponentes para Concursos - Pokémon Essentials v16
#===============================================================================

module ContestOpp
  
  #-----------------------------------------------------------------------------
  # Helper para aprender múltiples movimientos
  #-----------------------------------------------------------------------------
  def self.learnMoves(pokemon, moves)
    return if !moves || moves.length == 0
    moves.each { |move| pokemon.pbLearnMove(move) }
  end
  
  #-----------------------------------------------------------------------------
  # Configuración de oponentes
  #-----------------------------------------------------------------------------
  def self.setup
    opponents = []
    
  # RANGO NORMAL
  opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:POOCHYENA,20)
        pokemon.ot = _I("Micah")
        pokemon.name = _I("Poochin")
        pokemon.makeMale
        pokemon.cool = 14
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 10
        ContestOpp.learnMoves(pokemon, [:BITE, :SCARYFACE, :TACKLE, :FIREFANG])
        return [pokemon, :YOUNGSTER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ZIGZAGOON,20)
        pokemon.ot = _I("Shannon")
        pokemon.name = _I("Gonzer")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 10
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:MUDSPORT, :TAILWHIP, :PINMISSILE, :ODORSLEUTH])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:DUSTOX,20)
        pokemon.ot = _I("Mateo")
        pokemon.name = _I("Nox")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 12
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:SILVERWIND, :MOONLIGHT, :STRUGGLEBUG, :PROTECT])
        return [pokemon, :BUGCATCHER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SEEDOT,20)
        pokemon.ot = _I("Jordyn")
        pokemon.name = _I("Seedottie")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 10
        pokemon.smart = 12
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:HARDEN, :BIDE, :SYNTHESIS, :LEECHSEED])
        return [pokemon, :PICNICKER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:TAILLOW,20)
        pokemon.ot = _I("Gianna")
        pokemon.name = _I("Tailster")
        pokemon.makeFemale
        pokemon.cool = 20
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WINGATTACK, :DOUBLETEAM, :AERIALACE, :ECHOEDVOICE])
        return [pokemon, :BEAUTY]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:NINCADA,20)
        pokemon.ot = _I("Declan")
        pokemon.name = _I("Ninny")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 17
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:LEECHLIFE, :MINDREADER, :FURYSWIPES, :MUDSLAP])
        return [pokemon, :BUGCATCHER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SHROOMISH,20)
        pokemon.ot = _I("Carlton")
        pokemon.name = _I("Shrewmish")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 20
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ABSORB, :STUNSPORE, :LEECHSEED, :HEADBUTT])
        return [pokemon, :YOUNGSTER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:WINGULL,20)
        pokemon.ot = _I("Adeline")
        pokemon.name = _I("Win")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 15
        pokemon.cute = 16
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WATERGUN, :GROWL, :WATERPULSE, :MIST])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SLAKOTH,20)
        pokemon.ot = _I("Asher")
        pokemon.name = _I("Visikoth")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 14
        pokemon.cute = 12
        pokemon.smart = 0
        pokemon.tough = 16
        ContestOpp.learnMoves(pokemon, [:STRENGTH, :COUNTER, :YAWN, :ENCORE])
        return [pokemon, :HIKER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:WHISMUR,20)
        pokemon.ot = _I("Lauren")
        pokemon.name = _I("Whizz")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 14
        pokemon.smart = 14
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ASTONISH, :SLEEPTALK, :SUBSTITUTE, :SCREECH])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MAKUHITA,20)
        pokemon.ot = _I("Jeremiah")
        pokemon.name = _I("Makuwaku")
        pokemon.makeMale
        pokemon.cool = 12
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 20
        ContestOpp.learnMoves(pokemon, [:ARMTHRUST, :SMELLINGSALTS, :FORCEPALM, :FOCUSENERGY])
        return [pokemon, :BLACKBELT]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ARON,20)
        pokemon.ot = _I("Molly")
        pokemon.name = _I("Ronnie")
        pokemon.makeFemale
        pokemon.cool = 20
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 14
        ContestOpp.learnMoves(pokemon, [:METALCLAW, :HEADBUTT, :HARDEN, :TAKEDOWN])
        return [pokemon, :CAMPER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ZUBAT,20)
        pokemon.ot = _I("Martinus")
        pokemon.name = _I("Zoonby")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 10
        pokemon.cute = 0
        pokemon.smart = 12
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:HAZE, :MEANLOOK, :CONFUSERAY, :LEECHLIFE])
        return [pokemon, :PICNICKER]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:GULPIN,20)
        pokemon.ot = _I("Liliana")
        pokemon.name = _I("Guligan")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 22
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:POISONGAS, :TOXIC, :AMNESIA, :YAWN])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :NORMAL,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ELECTRIKE,20)
        pokemon.ot = _I("Camden")
        pokemon.name = _I("Bolt")
        pokemon.makeMale
        pokemon.cool = 23
        pokemon.beauty = 21
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:SPARK, :HOWL, :BITE, :LIGHTSCREEN])
        return [pokemon, :YOUNGSTER]
      }
    })
    
    # RANGO SUPER
 opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ROSELIA,40)
        pokemon.ot = _I("Keira")
        pokemon.name = _I("Rosalie")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 38
        pokemon.cute = 38
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:MAGICALLEAF, :GROWTH, :SWEETSCENT, :GRASSKNOT])
        return [pokemon, :BEAUTY]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:DODUO,40)
        pokemon.ot = _I("Bentley")
        pokemon.name = _I("Dodon't")
        pokemon.makeMale
        pokemon.cool = 38
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 38
        ContestOpp.learnMoves(pokemon, [:PECK, :FURYATTACK, :RAGE, :ACUPRESSURE])
        return [pokemon, :YOUNGSTER]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:TRAPINCH,40)
        pokemon.ot = _I("Plum")
        pokemon.name = _I("Tracy")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 43
        ContestOpp.learnMoves(pokemon, [:BITE, :DIG, :BULLDOZE, :FEINTATTACK])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:CACNEA,40)
        pokemon.ot = _I("Zachary")
        pokemon.name = _I("Succulus")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 42
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:NEEDLEARM, :POISONSTING, :LEECHSEED, :SANDATTACK])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SANDSHREW,40)
        pokemon.ot = _I("Alyssa")
        pokemon.name = _I("Sandyclaws")
        pokemon.makeFemale
        pokemon.cool = 50
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:FURYCUTTER, :RAPIDSPIN, :FURYSWIPES, :DIG])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:BALTOY,40)
        pokemon.ot = _I("Brody")
        pokemon.name = _I("Baltop")
        pokemon.makeGenderless
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 60
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:CONFUSION, :ROCKTOMB, :MUDSLAP, :HARDEN])
        return [pokemon, :PSYCHIC_M]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:NUMEL,40)
        pokemon.ot = _I("Mila")
        pokemon.name = _I("Mel")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 60
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:FLAMEBURST, :EARTHPOWER, :EMBER, :AMNESIA])
        return [pokemon, :BEAUTY]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SPINDA,40)
        pokemon.ot = _I("Rohan")
        pokemon.name = _I("Spinmaster")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 35
        pokemon.smart = 48
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:DIZZYPUNCH, :TEETERDANCE, :HYPNOSIS, :DREAMEATER])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SWABLU,40)
        pokemon.ot = _I("Alaina")
        pokemon.name = _I("Swellbell")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 35
        pokemon.cute = 46
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ASTONISH, :SING, :ROUND, :MIST])
        return [pokemon, :BEAUTY]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LINOONE,40)
        pokemon.ot = _I("Levi")
        pokemon.name = _I("Noone")
        pokemon.makeMale
        pokemon.cool = 60
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 28
        ContestOpp.learnMoves(pokemon, [:CUT, :SURF, :ROCKSMASH, :STRENGTH])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:KECLEON,40)
        pokemon.ot = _I("Gabriella")
        pokemon.name = _I("Leon")
        pokemon.makeFemale
        pokemon.cool = 47
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 47
        ContestOpp.learnMoves(pokemon, [:SLASH, :SHADOWCLAW, :FURYSWIPES, :THIEF])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:CORPHISH,40)
        pokemon.ot = _I("Dominic")
        pokemon.name = _I("Snip")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 67
        ContestOpp.learnMoves(pokemon, [:CUT, :HARDEN, :KNOCKOFF, :DOUBLEHIT])
        return [pokemon, :FISHERMAN]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:BARBOACH,40)
        pokemon.ot = _I("Kaitlyn")
        pokemon.name = _I("Barbra")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 45
        pokemon.cute = 40
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WATERGUN, :WATERSPORT, :WATERPULSE, :ROUND])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SPOINK,40)
        pokemon.ot = _I("Tyler")
        pokemon.name = _I("Spearl")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 32
        pokemon.cute = 50
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:PSYBEAM, :MAGICCOAT, :ATTRACT, :REST])
        return [pokemon, :PSYCHIC_M]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LOTAD,40)
        pokemon.ot = _I("Adalyn")
        pokemon.name = _I("Tad")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 56
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:MEGADRAIN, :ZENHEADBUTT, :GROWL, :BUBBLE])
        return [pokemon, :LASS]
      }
    })
    
    opponents.push({
      :rank => :SUPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MACHOKE,40)
        pokemon.ot = _I("Chaz")
        pokemon.name = _I("Macherie")
        pokemon.makeFemale
        pokemon.cool = 80
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 79
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ATTRACT, :BULKUP, :BRICKBREAK, :LOWSWEEP])
        return [pokemon, :BLACKBELT]
      }
    })
    
    # Rango Hyper
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:WAILORD,40)
        pokemon.ot = _I("Landon")
        pokemon.name = _I("Wonwon")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 99
        pokemon.tough = 106
        ContestOpp.learnMoves(pokemon, [:ROCKTOMB, :METALSOUND, :IRONDEFENSE, :TAKEDOWN])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:NUZLEAF,40)
        pokemon.ot = _I("Mckenzie")
        pokemon.name = _I("Nuzlad")
        pokemon.makeFemale
        pokemon.cool = 125
        pokemon.beauty = 110
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:RAZORLEAF, :EXTRASENSORY, :EXPLOSION, :NATUREPOWER])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:NINJASK,40)
        pokemon.ot = _I("Nelson")
        pokemon.name = _I("Ninjackie")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 78
        ContestOpp.learnMoves(pokemon, [:FURYSWIPES, :HARDEN, :XSCISSOR, :DOUBLETEAM])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SWELLOW,40)
        pokemon.ot = _I("Riley")
        pokemon.name = _I("Wollew")
        pokemon.makeFemale
        pokemon.cool = 74
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WINGATTACK, :AIRSLASH, :FOCUSENERGY, :QUICKATTACK])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MIGHTYENA,40)
        pokemon.ot = _I("Nathan")
        pokemon.name = _I("Mighty")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 84
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ODORSLEUTH, :EMBARGO, :ASSURANCE, :CRUNCH])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:BEAUTIFLY,40)
        pokemon.ot = _I("Twyla")
        pokemon.name = _I("Papi")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 128
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:SILVERWIND, :MORNINGSUN, :CONFIDE, :AIRCUTTER])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SEAKING,40)
        pokemon.ot = _I("Gavin")
        pokemon.name = _I("Rey")
        pokemon.makeMale
        pokemon.cool = 95
        pokemon.beauty = 95
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WATERPULSE, :WATERFALL, :HORNATTACK, :FURYATTACK])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:CAMERUPT,40)
        pokemon.ot = _I("Lily")
        pokemon.name = _I("Camelot")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 115
        pokemon.cute = 115
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:EARTHPOWER, :FLAMEBURST, :AMNESIA, :GROWL])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MACHOP,40)
        pokemon.ot = _I("Primo")
        pokemon.name = _I("Chopchop")
        pokemon.makeMale
        pokemon.cool = 85
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 85
        ContestOpp.learnMoves(pokemon, [:BRICKBREAK, :BULKUP, :KARATECHOP, :DUALCHOP])
        return [pokemon, :BLACKBELT]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LOMBRE,40)
        pokemon.ot = _I("Alejandra")
        pokemon.name = _I("Nombre")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 95
        pokemon.smart = 105
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:FAKEOUT, :WATERSPORT, :NATURALGIFT, :KNOCKOFF])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SEVIPER,40)
        pokemon.ot = _I("Yoshinari")
        pokemon.name = _I("Crawly")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 96
        pokemon.tough = 117
        ContestOpp.learnMoves(pokemon, [:VENOSHOCK, :VENOMDRENCH, :GLARE, :THIEF])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:WAILMER,40)
        pokemon.ot = _I("Lacy")
        pokemon.name = _I("Bobble")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 84
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:ASTONISH, :ROLLOUT, :REST, :WATERSPOUT])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MAGIKARP,40)
        pokemon.ot = _I("Owen")
        pokemon.name = _I("Magi")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 130
        pokemon.smart = 0
        pokemon.tough = 140
        ContestOpp.learnMoves(pokemon, [:SPLASH, :FLAIL, :TACKLE, :BOUNCE])
        return [pokemon, :FISHERMAN]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LUNATONE,40)
        pokemon.ot = _I("Addison")
        pokemon.name = _I("Moony")
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 128
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:PSYCHIC, :FUTURESIGHT, :HYPNOSIS, :ROCKPOLISH])
        return [pokemon, :PSYCHIC_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:PELIPPER,40)
        pokemon.ot = _I("Jayce")
        pokemon.name = _I("Piper")
        pokemon.makeMale
        pokemon.cool = 104
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WINGATTACK, :STOCKPILE, :SWALLOW, :SPITUP])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :HYPER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MACHOKE,40)
        pokemon.ot = _I("Chaz")
        pokemon.name = _I("Macherie")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 175
        pokemon.cute = 180
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:RETURN, :ATTRACT, :ROUND, :SUNNYDAY])
        return [pokemon, :CRUSHGIRL]
      }
    })
    
    # RANGO MASTER
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:GYARADOS,50)
        pokemon.ot = _I("Yoko")
        pokemon.name = _I("Gyalaxy")
        pokemon.makeFemale
        pokemon.cool = 200
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 182
        ContestOpp.learnMoves(pokemon, [:DRAGONDANCE, :HYPERBEAM, :CRUNCH, :THRASH])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LOUDRED,50)
        pokemon.ot = _I("Jeff")
        pokemon.name = _I("Louduff")
        pokemon.makeMale
        pokemon.cool = 174
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:HYPERVOICE, :RETALIATE, :HOWL, :ECHOEDVOICE])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:DELCATTY,50)
        pokemon.ot = _I("Elsie")
        pokemon.name = _I("Mione")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 166
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:FAKEOUT, :DOUBLESLAP, :DISARMINGVOICE, :SAFEGUARD])
        return [pokemon, :LADY]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SLAKING,50)
        pokemon.ot = _I("Jaylon")
        pokemon.name = _I("Slacker")
        pokemon.makeMale
        pokemon.cool = 190
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 213
        ContestOpp.learnMoves(pokemon, [:BULKUP, :SLACKOFF, :CHIPAWAY, :COUNTER])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:GOREBYSS,50)
        pokemon.ot = _I("Layla")
        pokemon.name = _I("Gorflir")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 194
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WHIRLPOOL, :AQUATAIL, :SURF, :AGILITY])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:KIRLIA,50)
        pokemon.ot = _I("Ruslan")
        pokemon.name = _I("Lia")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 186
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:STOREDPOWER, :CALMMIND, :PSYCHUP, :TRICKROOM])
        return [pokemon, :PSYCHIC_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:BELLOSSOM,50)
        pokemon.ot = _I("Lilias")
        pokemon.name = _I("Plumette")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 170
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:PETALBLIZZARD, :PETALDANCE, :GRASSYTERRAIN, :SOLARBEAM])
        return [pokemon, :BEAUTY]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:DUSCLOPS,50)
        pokemon.ot = _I("Aiden")
        pokemon.name = _I("Topclops")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 144
        pokemon.tough = 145
        ContestOpp.learnMoves(pokemon, [:TOXIC, :HEX, :SPITE, :CURSE])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ILLUMISE,50)
        pokemon.ot = _I("Madelyn")
        pokemon.name = _I("Princess")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 186
        pokemon.smart = 160
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:WISH, :PLAYNICE, :ZENHEADBUTT, :CONFUSERAY])
        return [pokemon, :LADY]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:SHARPEDO,50)
        pokemon.ot = _I("Elijah")
        pokemon.name = _I("Shargob")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 190
        pokemon.tough = 190
        ContestOpp.learnMoves(pokemon, [:POISONFANG, :ASSURANCE, :RAGE, :SCALD])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:LUVDISC,50) 
        pokemon.ot = _I("Hailey")
        pokemon.name = _I("Lovelynn")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 174
        pokemon.smart = 210
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:DRAININGKISS, :SWEETKISS, :PSYCHUP, :SUBSTITUTE])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:HERACROSS,50)
        pokemon.ot = _I("Clayton")
        pokemon.name = _I("Heracles")
        pokemon.makeMale
        pokemon.cool = 137
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 137
        ContestOpp.learnMoves(pokemon, [:FURYATTACK, :REVERSAL, :ENDURE, :GIGAIMPACT])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ELECTRODE,50)
        pokemon.ot = _I("Audrey")
        pokemon.name = _I("Trode")
        # Sin género
        pokemon.cool = 180
        pokemon.beauty = 178
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:SONICBOOM, :ELECTROBALL, :DISCHARGE, :EXPLOSION])
        return [pokemon, :SCIENTIST]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:PICHU,50)
        pokemon.ot = _I("Evan")
        pokemon.name = _I("Pinchurlink")
        pokemon.makeMale
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 208
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:SWEETKISS, :TAILWHIP, :CHARM, :CONFIDE])
        return [pokemon, :COOLTRAINER_M]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:WOBBUFFET,50)
        pokemon.ot = _I("Julia")
        pokemon.name = _I("Elizabeth")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 255
        pokemon.sheen = 1
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:COUNTER, :MIRRORCOAT, :SAFEGUARD, :DESTINYBOND])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    opponents.push({
      :rank => :MASTER,
      :requirement => nil,
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MACHOKE,50)
        pokemon.ot = _I("Chaz")
        pokemon.name = _I("Macherie")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 175
        pokemon.cute = 180
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:RETURN, :ATTRACT, :ROUND, :SUNNYDAY])
        return [pokemon, :CRUSHGIRL]
      }
    })
    
    # 0334 - Ali♂ - Lisia (MASTER ESPECIAL - MEGA ALTARIA)
    # Ronda 1 - Cool
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ALTARIA,55)
        pokemon.ot = _I("Lisia")
        pokemon.name = _I("Ali")
        pokemon.makeMale
        pokemon.setItem(:ALTARIANITE)
        pokemon.cool = 255
        pokemon.sheen = 123
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:OUTRAGE, :AERIALACE, :DRAGONDANCE, :TAILWIND])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    # 0334 - Ali♂ - Lisia - Ronda 2 - Beauty
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ALTARIA,55)
        pokemon.ot = _I("Lisia")
        pokemon.name = _I("Ali")
        pokemon.makeMale
        pokemon.setItem(:ALTARIANITE)
        pokemon.cool = 0
        pokemon.beauty = 255
        pokemon.sheen = 133
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:DAZZLINGGLEAM, :ROUND, :MIST, :DRACOMETEOR])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    # 0334 - Ali♂ - Lisia - Ronda 3 - Cute
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ALTARIA,55)
        pokemon.ot = _I("Lisia")
        pokemon.name = _I("Ali")
        pokemon.makeMale
        pokemon.setItem(:ALTARIANITE)
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 255
        pokemon.sheen = 133
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:DISARMINGVOICE, :GROWL, :HONECLAWS, :ATTRACT])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    # 0334 - Ali♂ - Lisia - Ronda 4 - Smart
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ALTARIA,55)
        pokemon.ot = _I("Lisia")
        pokemon.name = _I("Ali")
        pokemon.makeMale
        pokemon.setItem(:ALTARIANITE)
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 255
        pokemon.tough = 0
        pokemon.sheen = 123
        ContestOpp.learnMoves(pokemon, [:NATURALGIFT, :POWERSWAP, :SING, :DREAMEATER])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    # 0334 - Ali♂ - Lisia - Ronda 5 - Tough
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:ALTARIA,55)
        pokemon.ot = _I("Lisia")
        pokemon.name = _I("Ali")
        pokemon.makeMale
        pokemon.setItem(:ALTARIANITE)
        pokemon.cool = 0
        pokemon.beauty = 0
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 255
        pokemon.sheen = 113
        ContestOpp.learnMoves(pokemon, [:EARTHQUAKE, :TAKEDOWN, :GIGAIMPACT, :AERIALACE])
        return [pokemon, :COOLTRAINER_F]
      }
    })
    
    # 0350 - Milotic♀ - Wallace (MASTER ESPECIAL)
    opponents.push({
      :rank => :MASTER,
      :requirement => proc { $game_switches[50] },
      :pokemon_proc => proc {
        pokemon = PokeBattle_Pokemon.new(:MILOTIC,60)
        pokemon.ot = _I("Wallace")
        pokemon.name = _I("Milotic")
        pokemon.makeFemale
        pokemon.cool = 0
        pokemon.beauty = 255
        pokemon.sheen = 65
        pokemon.cute = 0
        pokemon.smart = 0
        pokemon.tough = 0
        ContestOpp.learnMoves(pokemon, [:AQUATAIL, :BLIZZARD, :ROUND, :AQUARING])
        return [pokemon, :LEADER_Wallace]  # Asumiendo que existe :LEADER_Wallace
      }
    })
    
    
    return opponents
  end
  
  #-----------------------------------------------------------------------------
  # Convertir tipo de concurso a número
  #-----------------------------------------------------------------------------
  def self.typeToNum(typename)
    case typename
    when "Cool"   then return 0
    when "Beauty" then return 1
    when "Cute"   then return 2
    when "Smart"  then return 3
    when "Tough"  then return 4
    else;              return 0
    end
  end
  
  #-----------------------------------------------------------------------------
  # Obtener puntuación de un Pokémon para un tipo de concurso específico
  #-----------------------------------------------------------------------------
  def self.getScore(pokemon_data, contest_type)
    pokemon, trainer = pokemon_data
    # Convertir número a string si es necesario
    if contest_type.is_a?(Numeric)
      contest_type = ["Cool", "Beauty", "Cute", "Smart", "Tough"][contest_type]
    end
    case contest_type
    when "Cool"
      return pokemon.cool || 0
    when "Beauty"
      return pokemon.beauty || 0
    when "Cute"
      return pokemon.cute || 0
    when "Smart"
      return pokemon.smart || 0
    when "Tough"
      return pokemon.tough || 0
    else
      # Si no se especifica tipo, devolver promedio
      return ((pokemon.cool || 0) + (pokemon.beauty || 0) + (pokemon.cute || 0) + 
              (pokemon.smart || 0) + (pokemon.tough || 0)) / 5
    end
  end
  
  #-----------------------------------------------------------------------------
  # Seleccionar 3 oponentes para un concurso (con protección contra duplicados)
  # rank: :NORMAL, :SUPER, :HYPER, :MASTER
  # contest_type: "Cool", "Beauty", "Cute", "Smart", "Tough" (o 0-4), o nil para cualquiera
  # prioritize: true para priorizar Pokémon con buenas stats del tipo de concurso
  #-----------------------------------------------------------------------------
  def self.select(rank, contest_type = nil, prioritize = true)
    all_opponents = setup
    
    # Filtrar por rango
    filtered = all_opponents.select { |opp| opp[:rank] == rank }
    
    # Filtrar por requisitos cumplidos
    available = filtered.select { |opp|
      opp[:requirement].nil? || opp[:requirement].call
    }
    
    # Si no hay suficientes oponentes disponibles
    if available.length < 3
      Kernel.pbMessage(_I("No hay suficientes oponentes disponibles para este rango."))
      return []
    end
    
    # Agrupar oponentes con el mismo entrenador/pokémon
    grouped_opponents = {}
    
    available.each do |opp|
      pokemon_data = opp[:pokemon_proc].call
      pokemon, trainer = pokemon_data
      
      trainer_name = pokemon.ot.to_s
      species_name = PBSpecies.getName(pokemon.species)
      unique_key = "#{trainer_name}|#{species_name}"
      
      if !grouped_opponents[unique_key]
        grouped_opponents[unique_key] = {
          :trainer_name => trainer_name,
          :trainer_type => trainer,
          :species => pokemon.species,
          :variants => [],
          :best_score => 0,
          :original_opp => opp
        }
      end
      
      score = contest_type ? getScore(pokemon_data, contest_type) : 50
      min_score_requirement = getMinScoreForRank(rank) || 0
      
      grouped_opponents[unique_key][:variants].push({
        :data => pokemon_data,
        :score => score,
        :original => opp
      })
      
      if score > grouped_opponents[unique_key][:best_score]
        grouped_opponents[unique_key][:best_score] = score
        grouped_opponents[unique_key][:best_variant] = pokemon_data
      end
    end
    
    # Crear lista de candidatos con TODOS los que cumplen el mínimo
    candidates = []
    grouped_opponents.each do |key, group|
      if group[:best_variant]
        score = contest_type ? group[:best_score] : 50
        
        # SOLO FILTRAR: Si hay tipo de concurso, mínimo 30% del máximo posible
        if contest_type
          max_possible = getMaxPossibleScore(rank)
          next if score < max_possible * 0.3  # Ignorar si tiene menos de 30%
        end
        
        candidates.push({
          :data => group[:best_variant],
          :score => score,
          :trainer_key => key,
          :original_group => group
        })
      end
    end
    
    # Si aún así hay muy pocos, incluir todos
    if candidates.length < 3
      candidates = []
      grouped_opponents.each do |key, group|
        candidates.push({
          :data => group[:best_variant],
          :score => group[:best_score],
          :trainer_key => key,
          :original_group => group
        }) if group[:best_variant]
      end
    end
    
    # Mezclar para evitar sesgos iniciales
    candidates = candidates.shuffle
    
    selected = []
    
    if prioritize && contest_type
      # --- SISTEMA DE PONDERACIÓN PROBABILÍSTICA ---
      # Los que tienen mejor puntuación tienen MÁS probabilidad, 
      # pero TODOS pueden salir
      
      # Calcular pesos basados en puntuación
      weights = []
      candidates.each do |candidate|
        # Escalar la puntuación a un peso razonable (mínimo 1, máximo 10)
        weight = 1 + (candidate[:score] / 50.0).clamp(0, 9)
        weights.push(weight)
      end
      
      # Seleccionar 3 sin repetir
      available_candidates = candidates.dup
      available_weights = weights.dup
      
      3.times do
        break if available_candidates.empty?
        
        # Selección ponderada
        total_weight = available_weights.inject(0) { |sum, w| sum + w }
        random = rand * total_weight
        
        cumulative = 0
        selected_index = 0
        available_weights.each_with_index do |weight, i|
          cumulative += weight
          if random <= cumulative
            selected_index = i
            break
          end
        end
        
        # Agregar el seleccionado
        selected.push(available_candidates[selected_index][:data])
        
        # Remover de candidatos y pesos
        available_candidates.delete_at(selected_index)
        available_weights.delete_at(selected_index)
      end
    else
      # Selección completamente aleatoria
      shuffled = candidates.shuffle
      selected = shuffled[0...3].map { |c| c[:data] }
    end
    
    return selected
  end
  
  #-----------------------------------------------------------------------------
  # Obtener puntuación mínima esperada para cada rango
  #-----------------------------------------------------------------------------
  def self.getMinScoreForRank(rank)
    case rank
    when :NORMAL then 10
    when :SUPER  then 30
    when :HYPER  then 60
    when :MASTER then 100
    else;             0
    end
  end
  
  #-----------------------------------------------------------------------------
  # Obtener puntuación máxima posible para el rango (aproximado)
  #-----------------------------------------------------------------------------
  def self.getMaxPossibleScore(rank)
    case rank
    when :NORMAL then 50
    when :SUPER  then 100
    when :HYPER  then 180
    when :MASTER then 400
    else;             100
    end
  end

  #-----------------------------------------------------------------------------
  # Almacenar oponentes seleccionados en una variable del juego
  # La variable almacenará un array de [pokemon, trainertype]
  #-----------------------------------------------------------------------------
  def self.store(variable_id, rank, contest_type = nil, prioritize = true)
    opponents = select(rank, contest_type, prioritize)
    
    if opponents.empty?
      return false
    end
    
    $game_variables[variable_id] = opponents
    return true
  end
  
  #-----------------------------------------------------------------------------
  # Recuperar oponentes de una variable
  #-----------------------------------------------------------------------------
  def self.get(variable_id)
    return $game_variables[variable_id] || []
  end
  
  #-----------------------------------------------------------------------------
  # Mostrar información de los oponentes seleccionados (para debug)
  #-----------------------------------------------------------------------------
  def self.show(variable_id)
    opponents = get(variable_id)
    
    if opponents.empty?
      Kernel.pbMessage(_I("No hay oponentes almacenados."))
      return
    end
    
    opponents.each_with_index do |opp, i|
      pokemon, trainer = opp
      msg = _I("Oponente #{i+1}:\n")
      msg += _I("Entrenador: #{GameData::TrainerType.get(trainer).real_name}\n") rescue _I("Entrenador: #{trainer}\n")
      msg += _I("Pokémon: #{pokemon.name} (#{PBSpecies.getName(pokemon.species)})\n")
      msg += _I("Cool: #{pokemon.cool} | Beauty: #{pokemon.beauty} | Cute: #{pokemon.cute}\n")
      msg += _I("Smart: #{pokemon.smart} | Tough: #{pokemon.tough}")
      Kernel.pbMessage(msg)
    end
  end
  
end


def showSpeciesIntro(pokemon, contestPos=1, nickname="", trainername="")
  
  # Si no se proporciona Pokémon, crear uno por defecto
  if !pokemon.is_a?(PokeBattle_Pokemon)
    species = pokemon || PBSpecies::UNOWN
    species = PBSpecies::UNOWN if species == 0 || species.nil?
    pokemon = PokeBattle_Pokemon.new(species, 20)
    pokemon.calcStats
  end
  
  # Usar nombre y entrenador del Pokémon si no se especifican
  display_name = (nickname != "") ? nickname : pokemon.name
  display_trainer = (trainername != "") ? trainername : pokemon.ot
  
  # Reproducir el grito
  pbPlayCry(pokemon)
  
  # Crear viewport para el sprite
  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
  viewport.z = 99999
  
  # Crear sprite del Pokémon con estilo concurso
  sprite = PokemonSprite.new(viewport)
  sprite.setPokemonBitmap(pokemon)
  sprite.ox = 0
  sprite.oy = 0
  sprite.x = Graphics.width/2 - (sprite.bitmap.width/2)
  sprite.y = Graphics.height/2 - (sprite.bitmap.height/2)
  sprite.z = 100000
  
  
  
  # Efecto de entrada
  sprite.opacity = 0
  16.times do
    sprite.opacity += 16
    Graphics.update
  end
  if contestPos > 0
    Kernel.pbMessage(_INTL("¡Entrada n.º {1}! ¡{2}, de {3}!", 
                           contestPos, 
                           display_name, 
                           display_trainer))
  else
    Kernel.pbMessage(_INTL("¡{1}, de {2}!", display_name, display_trainer))
  end
  # Efecto de salida
  16.times do
    sprite.opacity -= 16
    Graphics.update
  end
  sprite.dispose
  viewport.dispose
end

#===============================================================================
# EJEMPLOS DE USO
#===============================================================================

# En un evento, puedes usar estos comandos con Script:

# 1. Seleccionar oponentes para un concurso NORMAL de tipo Cute (usando string)
# ContestOpp.store(5, :NORMAL, "Cute", true)

# 2. Seleccionar oponentes para un concurso SUPER de tipo Cool (usando número)
# ContestOpp.store(5, :SUPER, 0, true)

# 3. Seleccionar oponentes para un concurso HYPER de tipo Smart
# ContestOpp.store(5, :HYPER, "Smart", true)

# 4. Seleccionar oponentes para un concurso MASTER de tipo Beauty
# ContestOpp.store(5, :MASTER, "Beauty", true)

# 5. Seleccionar oponentes sin priorizar tipo específico
# ContestOpp.store(5, :SUPER, nil, false)

# 6. Mostrar los oponentes seleccionados (para debug)
# ContestOpp.show(5)

# 7. Acceder a los datos almacenados
# opponents = ContestOpp.get(5)
# if opponents.length > 0
#   pokemon1, trainer1 = opponents[0]
#   pokemon2, trainer2 = opponents[1]
#   pokemon3, trainer3 = opponents[2]
# end

#===============================================================================
# EJEMPLO DE CÓMO AÑADIR UN NUEVO OPONENTE
#===============================================================================
# 
# opponents.push({
#   :rank => :NORMAL,  # :NORMAL, :SUPER, :HYPER, :MASTER
#   :requirement => nil,  # o proc { condición }
#   :pokemon_proc => proc {
#     pokemon = PokeBattle_Pokemon.new(:PIKACHU,25)
#     pokemon.ot = _I("Ash")
#     pokemon.name = _I("Pika")
#     pokemon.makeMale
#     pokemon.cool = 20
#     pokemon.tough = 15
#     pokemon.beauty = 18
#     pokemon.cute = 25
#     pokemon.smart = 22
#     # Añadir movimientos fácilmente con un array
#     ContestOpp.learnMoves(pokemon, [:THUNDERBOLT, :QUICKATTACK, :IRONTAIL, :AGILITY])
#     return [pokemon, :POKEMONTRAINER_Red]
#   }
# })

