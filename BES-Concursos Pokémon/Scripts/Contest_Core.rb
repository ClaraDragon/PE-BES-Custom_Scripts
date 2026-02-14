################################################################################
#  Pokemon Contest by mej71
#  edit for v18.dev by Tastyredtomato
#---------------------------------------
# based on the original Contest script by mej71
# see the original thread for installation and use instructions
# please credit when used
################################################################################
class PokeContestScene
  attr_reader   :name
  attr_accessor :selected
  attr_reader   :hearts
  
  # Helper function para convertir categoría de concurso a número
  def pbContestTypeToNumber(typename)
    case typename
    when "Cool"   then return 0
    when "Beauty" then return 1
    when "Cute"   then return 2
    when "Smart"  then return 3
    when "Tough"  then return 4
    else;              return 0
    end
  end

  def initialize
    pbInitContestCombos
    @sprites={}
    
    # Viewport para el fondo (z más bajo)
    @viewport_bg=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport_bg.z = 99998
    
    # Viewport para los Pokémon (z medio)
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    
    # Viewport para UI y overlays (z alto)
    @viewport2=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport2.z = 100000
    
    # Viewport para corazones (z más alto de todos)
    @viewport_hearts=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport_hearts.z = 100001  # Aumentado para asegurar que está encima
    
    @sprites["overlay"] = IconSprite.new(0, 0, @viewport2)
    @sprites["overlay"].setBitmap("Graphics/Pictures/Contest/main_overlay")
    
    if !@sprites["transition"] || @sprites["transition"].disposed?
      @sprites["transition"] = IconSprite.new(0, 0, @viewport_hearts)
      @sprites["transition"].setBitmap("Graphics/Pictures/Contest/main_overlay2")
    end
    
    @sprites["background"] = IconSprite.new(0, 0, @viewport_bg)
    @sprites["background"].setBitmap("Graphics/Pictures/Contest/Background/contestbg")
  end
  
  def update
    pbUpdateSpriteHash(@sprites)
  end
  
  def pbCheckforCombos
    oldmoveid = case @currentpoke
    when @pkmn1 then @pkmn1lastmoveid
    when @pkmn2 then @pkmn2lastmoveid
    when @pkmn3 then @pkmn3lastmoveid
    when @pkmn4 then @pkmn4lastmoveid
    else return false
    end
    return false if !oldmoveid || oldmoveid == 0
    return false unless CONTEST_COMBO_HASH[oldmoveid]
    CONTEST_COMBO_HASH[oldmoveid].include?(@currentmove)
  end
  
  def clear_last_move(pokemon)
    case pokemon
    when @pkmn1
      @pkmn1lastmoveid = nil
      @pkmn1lastmove = nil
    when @pkmn2
      @pkmn2lastmoveid = nil
      @pkmn2lastmove = nil
    when @pkmn3
      @pkmn3lastmoveid = nil
      @pkmn3lastmove = nil
    when @pkmn4
      @pkmn4lastmoveid = nil
      @pkmn4lastmove = nil
    end
  end
  
  #-----------------------------------------------------------------------------
  # Mensaje personalizado para concursos
  #-----------------------------------------------------------------------------
  def pbContestPokemon(opponent1, opponent2, opponent3)
    # Obtener Pokémon del jugador
    @pkmn1 = $Trainer.party[$PokemonGlobal.contestPlayerPokemon]
    # Asignar oponentes
    @pkmn2 = opponent1
    @pkmn3 = opponent2
    @pkmn4 = opponent3
    # Sistema antiguo: enseñar movimientos desde variables globales
    # Solo si el Pokémon no tiene movimientos configurados
    for i in 0...CONTESTMOVE2.length
      @pkmn2.pbLearnMove(CONTESTMOVE2[i]) if CONTESTMOVE2[i] != 0
    end
    for i in 0...CONTESTMOVE3.length
      @pkmn3.pbLearnMove(CONTESTMOVE3[i]) if CONTESTMOVE3[i] != 0
    end
    for i in 0...CONTESTMOVE4.length
      @pkmn4.pbLearnMove(CONTESTMOVE4[i]) if CONTESTMOVE4[i] != 0
    end
    # Nicknames - prioridad: nombre existente > variable global
    @pkmn2.name = $CONTESTNAME2 if $CONTESTNAME2 != "" && 
                                   (!@pkmn2.name || @pkmn2.name.empty?)
    @pkmn3.name = $CONTESTNAME3 if $CONTESTNAME3 != "" && 
                                   (!@pkmn3.name || @pkmn3.name.empty?)
    @pkmn4.name = $CONTESTNAME4 if $CONTESTNAME4 != "" && 
                                   (!@pkmn4.name || @pkmn4.name.empty?)
    return @pkmn1, @pkmn2, @pkmn3, @pkmn4
  end
  
  def pbStartContest(difficulty,opponent1,opponent2,opponent3,ribbonnum)
    pbAllowSpeedup rescue nil
    pbBGMPlay("ORAS 083 Pokemon Contest!") #Change this for different music
    @contestover=false #ends when set to true
    @difficulty=difficulty
    @ribbonnum=ribbonnum #ribbon number given if won
    # Obtener tipo de concurso desde PokemonGlobalMetadata
    case $PokemonGlobal.contestType
    when 0 then @contestType="Cool"
    when 1 then @contestType="Beauty"
    when 2 then @contestType="Cute"
    when 3 then @contestType="Smart"
    when 4 then @contestType="Tough"
    else;       @contestType="Cool"
    end
    case $PokemonGlobal.contestType
    when 0 then @contestName=_INTL("Carisma")
    when 1 then @contestName=_INTL("Belleza")
    when 2 then @contestName=_INTL("Dulzura")
    when 3 then @contestName=_INTL("Ingenio")
    when 4 then @contestName=_INTL("Dureza")
    else;       @contestName=_INTL("Carisma")
    end
    
    @pkmn1, @pkmn2, @pkmn3, @pkmn4 = pbContestPokemon(opponent1,opponent2,opponent3)
    
    @pkmn1total=0
    @pkmn2total=0
    @pkmn3total=0
    @pkmn4total=0
    @pkmn1DoubleNext=false
    @pkmn2DoubleNext=false
    @pkmn3DoubleNext=false
    @pkmn4DoubleNext=false
    @pkmn1MissTurn=false
    @pkmn2MissTurn=false
    @pkmn3MissTurn=false
    @pkmn4MissTurn=false
    @pkmn1nomoremoves=false
    @pkmn2nomoremoves=false
    @pkmn3nomoremoves=false
    @pkmn4nomoremoves=false  
    @applause=0
    @pkmn1stars=0
    @pkmn2stars=0
    @pkmn3stars=0
    @pkmn4stars=0
    @pkmn1hearts=0
    @pkmn2hearts=0
    @pkmn3hearts=0
    @pkmn4hearts=0
    @last_round_hearts = [0, 0, 0, 0]
    @stars=[@pkmn1stars,@pkmn2stars,@pkmn3stars,@pkmn4stars]
    pbPreliminaryScene #extra points for scarves, points gained by pokeblocks and such done here
    #the "preliminary judging" seen before this starts is just for show, it doesn't do anything then
    pbResetContestMoveEffects
    pbResetHearts
    pbInitializeStarSprites
    pbNoMoreMovesGraphic
    @round=0
    if !($DEBUG && Input.press?(Input::CTRL)) #Skip all rounds if pressing Control in Debug mode
      @round=1
      pbTurn(@round)
      if !($DEBUG && Input.press?(Input::CTRL))
        @round=2
        pbTurn(@round)
        @round=3
        pbTurn(@round)
        @round=4
        pbTurn(@round)
        @round=5
        pbTurn(@round)
      else
        pbResetHearts
        pbDebugTotals(1)
      end
    else
      @prelim1+=90
      pbResetHearts
      pbDebugTotals(6)
    end
    pbDisposeSprite(@sprites,"overlay2") #clear overlay to prep for end scene
    if (!$DEBUG || TURBO_DEBUG)
      pbDisallowSpeedup rescue nil
    end
    pbShowTransitionIn
    ret = pbResultsScene
    # Reset contest data
    $PokemonGlobal.contestType = 0
    $PokemonGlobal.contestPlayerPokemon = 0
    for i in $Trainer.party
      (i.makeUnmega rescue nil); (i.makeUnprimal rescue nil)
      (i.makeUntera rescue nil); (i.makeUndynamax rescue nil)
      (i.revertOtherForms rescue nil)
    end
    @contestover=true #allows scene to exit loop and end
    return ret
  end
  
  ###############################################################################
  # Main round processing function
  ###############################################################################  
  def pbTurn(turnnumber)
    Graphics.update
    @atself = false
    @priorhearts = 0
    # ------------------------------------------------------------------
    # TRANSICIÓN DE ENTRADA AL TURNO
    # ------------------------------------------------------------------
    if @round == 1 && turnnumber == 1
      # Introducción del juez
      # show_judge_intro #LEGACY, No se usa en los juegos oficiales, ya que la intro esta en el mapa.
      pbShowTransitionOut  # Quitar transición antes de empezar
    end
    
    # Determinar orden
    @round == 1 ? pbFindFastestOrderRanking : pbOrder
    
    pbResetContestMoveEffects
    pbDrawText
    
    #if @round > 1  # Solo mostrar después de la primera ronda
    #  pbShowHeartMeterForAll  # Mostrar medidor con puntuación acumulada
    #end
    
    pbShowMessage(_INTL("¡Exibición n.º {1}<br>¿Qué movimiento vas a usar?",turnnumber))
    #show_round_banner(turnnumber)
    pbMoveButtons
    
    pbClearHeartMeters  # Limpiar los medidores
    
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport2)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    
    # Crear sprite invisible para animaciones
    if !@sprites["opponent"]
      @sprites["opponent"] = IconSprite.new(50, 30, @viewport2)
      @sprites["opponent"].setBitmap("Graphics/Battler/000")
      @sprites["opponent"].visible = false
    end
    # Procesar turnos de los 4 Pokémon
    4.times do |pokemon_idx|
      process_pokemon_turn(pokemon_idx, turnnumber)
      cleanup_after_turn(pokemon_idx) if pokemon_idx < 3
    end
    
    # Limpieza final
    pbDisposeSprite(@sprites, "pokemon4")
    #pbDisposeSprite(@sprites, "opponent")
    
    pbResetHearts
    
    pbWait(10)  # Breve pausa
    
    Graphics.update
  end
  
  def pbEndScene #Ends everything
    for i in 0..3
      CONTESTMOVE2[i]=0 #reset these global variables for next use
      CONTESTMOVE3[i]=0
      CONTESTMOVE4[i]=0
    end
    $CONTESTNAME2="" #reset these global variables for next use
    $CONTESTNAME3=""
    $CONTESTNAME4=""
    $game_map.autoplay 
    # NUEVO: Limpiar sprites de estrellas
    ["firstpokestars", "secondpokestars", "thirdpokestars", "fourthpokestars"].each do |sprite_name|
      pbDisposeSprite(@sprites, sprite_name) if @sprites[sprite_name]
    end
    pbDisposeHeartBitmap if respond_to?(:pbDisposeHeartBitmap)
    pbFadeOutAndHide(@sprites) { update } 
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
    @viewport2.dispose if @viewport2
    @viewport_bg.dispose if @viewport_bg
    #$scene = Scene_Map.new #bug here
  end
  
  def middleScene #processes scene after startScene
    loop do
      return if @contestover
      Graphics.update
      Input.update
      self.update
    end
  end

  def process_pokemon_turn(pokemon_idx, turnnumber)
    pokemon = @pokeorder[pokemon_idx]
    @currentpos = pokemon_idx + 1
    @currentpoke = pokemon
    pbSEPlay("Contest_turn")
    # Mensaje del juez
    if pokemon_idx == 0
      pbShowJudgeMessage(_INTL("Muy bien {1}, ¡veamos qué puedes hacer!", pokemon.name))
    else
      pbShowJudgeMessage(_INTL("¡A continuación tenemos a {1}!", pokemon.name))
      pbWait(4)
    end
    pbDisplayPokemonWithAnimation(pokemon_idx)
    Graphics.update
    pbWait(4) if pokemon_idx > 0
    
    # Seleccionar movimiento
    move_idx = (@currentpoke == @pkmn1) ? @moveselection : pbAI(pokemon, @difficulty)
    setup_move_data(pokemon, move_idx)
    
    move_executed = execute_move(pokemon)
    # Solo procesar efectos si el movimiento se ejecutó
    if move_executed
      pbFunctionsAdjustHearts
      pbDisplayAddingPositiveHearts
      
      # Efectos adicionales (retorna true si hubo combo)
      combo_completed = process_additional_effects(pokemon, turnnumber)
      
      # Solo asignar último movimiento si NO hubo combo
      if !combo_completed
        pbAssignLastMove
      end
      
      @lastmoveType = @moveType
      pbCrowd
    end
    #pbNoMoreMovesGraphic
    Graphics.update
    
    # Mostrar heartmeter para este Pokémon
    if pokemon_idx == 3  # Solo al final del último Pokémon
      pbShowHeartMeterForAll
    end
    
  end
  
  def cleanup_after_turn(pokemon_idx)
    if pokemon_idx == 0
      pbShowJudgeMessage(_INTL("¡Buen trabajo {1}, ahora vamos con el siguiente Pokémon!",@pokeorder[pokemon_idx].name))
    end
    sprite_name = "pokemon#{pokemon_idx + 1}"
    #pbDisposeSprite(@sprites, sprite_name)
    pbDisposePokemonSpriteWithAnimation(pokemon_idx)
    Graphics.update
  end
  
  def setup_move_data(pokemon, move_idx)
    move = pokemon.moves[move_idx]
    @currentmovename = PBMoves.getName(move.id)
    
    # Buscar ID de movimiento de concurso
    @currentmove = move.id
    (1..PBContestMoves.maxValue).each do |contest_id|
      if PBMoves.getName(contest_id) == @currentmovename
        @currentmove = getID(PBContestMoves, contest_id)
        break
      end
    end
    
    @currentmove1 = move.id
    
    movedata = PBMoveData.new(move.id)
    @atself = (movedata.target == PBTargets::User)
    
    contestdata = PBContestMoveData.new(@currentmove)
    @currenthearts = contestdata.hearts
    @moveType = contestdata.contestType
    @moveName = contestdata.contestType
    
    pbmoveType(pbContestTypeToNumber(@moveType))
  end
  
  def execute_move(pokemon)
    # Verificar si puede usar movimientos (función 41)
    if pbNoMore
      pbShowMessage(_INTL("{1} ya no puede exhibirse más.", pokemon.name), true)
      pbNoMoreMovesGraphic  # Asegurar que el gráfico se muestra
      return false
    end
    # Verificar si pierde el turno (función 42 u otros)
    if pbMissTurn
      pbShowMessage(_INTL("{1} está descansando y no puede actuar este turno.", pokemon.name), true)
      pbNoMoreMovesGraphic  # Mostrar gráfico
      pbReverseMissTurn
      return false
    end
    
    # Pokémon nervioso
    if @nervous[@currentpos - 1]
      #pbShowMessage(_INTL("{1} se ha puesto nervioso.", pokemon.name), true)
      #if rand(100) < 30
        pbShowMessage(_INTL("{1} no se ha podido mover de puros nervios!", pokemon.name), true)
        return false
      #end
    end
    
    # Doble corazones
    if pbDoubleNext
      @currenthearts *= 2
      pbReverseDoubleNext
    end
    # Usar movimiento
    pbShowMessage(_INTL("¡{1} se exhibe con {2}!", pokemon.name, @currentmovename), true)
    pbAnimation(@currentmove1, 0, 1, 0)
    

    @turn_hearts ||= [0, 0, 0, 0]
    @turn_hearts[@currentpos - 1] = @currenthearts

    return true
  end

  def process_additional_effects(pokemon, turnnumber)
    combo_completed = false
    # 1. Juez expectante por usar movimiento repetido (excepto función 15)
    if pbCheckLast and @currentfunction != 15
      # Penalización por repetir movimiento
      penalty = calculate_repetition_penalty(pokemon)
      @currenthearts -= penalty
      pbShowMessage(_INTL("{1} ha decepcionado al repetir su exhibición.", pokemon.name), true)
      pbJam(1, pokemon, @currentpos - 1)
      pbDecreaseHearts(@currentpoke, @currentpos, "notnil")
      # Además, reducir entusiasmo si se repite movimiento
      if @applause > 0
         @applause -= 1
      end
    end
    # 2. Combos
    if @round != 1 && pbCheckforCombos
      @currenthearts = 3 #Tres corazones extra como en ORAS
      pbShowMessage(_INTL("¡La exhibición de {1} ha combinado bien con la anterior y eso ha gustado al público.", pokemon.name), true)
      pbDisplayAddingPositiveHearts
      #pbDecreaseStarGraphics(@currentpos - 1, 1, false)
      clear_last_move(pokemon)
      combo_completed = true
    end
    # 3. Verificar si movimiento está en tipo que baja entusiasmo
    check_excitement_effect(pokemon)
    return combo_completed
  end
  
  # ---------------------------------------------------------------------------
  # Funciones helper adicionales
  # ---------------------------------------------------------------------------
  def calculate_repetition_penalty(pokemon)
    # Penalización mayor si se repite muchas veces
    repetition_count = get_repetition_count(pokemon)
    
    case repetition_count
    when 1
      return 1  # Primera repetición: penalización leve
    when 2
      return 2  # Segunda repetición: penalización media
    else
      return 3  # Tercera+ repetición: penalización fuerte
    end
  end
  
  def get_repetition_count(pokemon)
    # Contar cuántas veces seguidas ha usado este movimiento
    count = 0
    case pokemon
    when @pkmn1
      move_id = @currentmove
      # Simular contador (necesitarías variable adicional)
      count = @pkmn1_repetition_count || 0
    when @pkmn2
      count = @pkmn2_repetition_count || 0
    when @pkmn3
      count = @pkmn3_repetition_count || 0
    when @pkmn4
      count = @pkmn4_repetition_count || 0
    end
    return count
  end
  
  def check_excitement_effect(pokemon)
    relations = get_contest_type_relations(@contestType)
    if relations[:lowers].include?(@moveType)
      # Movimiento de tipo que baja entusiasmo
      if @applause > 0# && rand(100) < 50  # 50% de probabilidad
        @applause -= 1
        #pbShowMessage(_INTL("El público no disfrutó del tipo de movimiento.", pokemon.name), true)
      end
    end
  end
  
###############################################################################
# Heart Graphic Functions
###############################################################################
def pbAdjustHearts(amount, target = @currentpoke, position = @currentpos)
    # Determinar qué Pokémon y sprite usar
    case target
    when @pkmn1
      hearts_var = :pkmn1hearts
      sprite_name = "firstpokehearts"
      current_hearts = @pkmn1hearts || 0
    when @pkmn2
      hearts_var = :pkmn2hearts
      sprite_name = "secondpokehearts"
      current_hearts = @pkmn2hearts || 0
    when @pkmn3
      hearts_var = :pkmn3hearts
      sprite_name = "thirdpokehearts"
      current_hearts = @pkmn3hearts || 0
    when @pkmn4
      hearts_var = :pkmn4hearts
      sprite_name = "fourthpokehearts"
      current_hearts = @pkmn4hearts || 0
    else
      return
    end
    y_pos = 32 + ((position - 1) * 96)
    step = amount > 0 ? 1 : -1
    amount.abs.times do |i|
      current_hearts += step
      instance_variable_set("@#{hearts_var}", current_hearts)
      # Determinar qué mostrar
      if current_hearts >= 0
        heart_count = current_hearts
        heart_type = 0  # normal
      else
        heart_count = current_hearts.abs
        heart_type = 1  # jam (gris)
      end
      pbSEPlay("Contest_heart")
      # Actualizar sprite
      if @sprites[sprite_name]
        pbUpdateSimpleHeartSprite(@sprites[sprite_name], heart_count, heart_type)
      else
        @sprites[sprite_name] = pbCreateSimpleHeartSprite(400-16-4, y_pos, heart_count, heart_type, @viewport2)
      end
      Graphics.update
      pbWait(4)
    end
    return current_hearts
  end
  
  def pbAddHearts(amount, target = @currentpoke, position = @currentpos)
    pbAdjustHearts(amount.abs, target, position)
  end
  
  def pbRemoveHearts(amount, target = @currentpoke, position = @currentpos, show_message = true)
    if show_message
      message = amount == 1 ? 
        _INTL("{1} ha mirado hacia abajo distraído.", target.name) :
        _INTL("{1} no ha podido evitar dar un salto.", target.name)
      pbShowMessage(message, true)
    end
    pbAdjustHearts(-amount.abs, target, position)
  end

  def pbRemoveHearts(amount, target = @currentpoke, position = @currentpos, show_message = true)
    # Obtener jam_amount de la variable correcta
    case target
    when @pkmn1
      jam_amount = @pkmn1jam || amount
    when @pkmn2
      jam_amount = @pkmn2jam || amount
    when @pkmn3
      jam_amount = @pkmn3jam || amount
    when @pkmn4
      jam_amount = @pkmn4jam || amount
    else
      return
    end
    
    # Aplicar modificadores
    jam_amount *= 2 if @easilystartled && @easilystartled[position - 1]
    jam_amount = 1 if jam_amount <= 0
    
    if show_message
      message = jam_amount == 1 ? 
        _INTL("{1} ha mirado hacia abajo distraído.", target.name) :
        _INTL("{1} no ha podido evitar dar un salto.", target.name)
      pbShowMessage(message, true)
    end
    pbAdjustHearts(-jam_amount.abs, target, position)
  end
  
  def pbDisplayAddingPositiveHearts
    pbAddHearts(@currenthearts, @currentpoke, @currentpos)
  end
  
  def pbDecreaseHearts(target, position, selfjam=nil)
    # Obtener jam amount
    case target
    when @pkmn1 then jam_amount = @pkmn1jam || 0
    when @pkmn2 then jam_amount = @pkmn2jam || 0
    when @pkmn3 then jam_amount = @pkmn3jam || 0
    when @pkmn4 then jam_amount = @pkmn4jam || 0
    else return
    end
    
    # Aplicar modificadores
    jam_amount *= 2 if @easilystartled && @easilystartled[position - 1]
    jam_amount = 1 if jam_amount <= 0
    
    pbRemoveHearts(jam_amount, target, position, selfjam.nil?)
  end
  
  def pbRemoveStars(func_type)
    if @currentpos == 0
      pbShowMessage(_INTL("¡Pero ha fallado!"),true)
      return
    end
    end_idx = func_type == 22 ? @currentpos - 2 : @currentpos - 1
    (0..end_idx).each do |j|
      pbDecreaseStarGraphics(j, 1) if @stars[j] > 0
    end
  end

###############################################################################
# Get rid of hearts graphics at end round, and add up heart totals
###############################################################################  
  def pbResetHearts
    # Guardar corazones de ESTA RONDA (incluyendo negativos)
    @last_round_hearts = [
      @pkmn1hearts || 0,
      @pkmn2hearts || 0,
      @pkmn3hearts || 0,
      @pkmn4hearts || 0
    ]
    
    # Eliminar sprites
    ["firstpokehearts", "secondpokehearts", "thirdpokehearts", "fourthpokehearts"].each do |sprite_name|
      pbDisposeSprite(@sprites, sprite_name) if @sprites[sprite_name]
    end
    
    # Sumar a totales (valores negativos restan)
    @pkmn1total += @pkmn1hearts.to_i
    @pkmn2total += @pkmn2hearts.to_i
    @pkmn3total += @pkmn3hearts.to_i
    @pkmn4total += @pkmn4hearts.to_i
    
    # Guardar totales por ronda
    case @round
    when 1 then @roundonetotals = [@pkmn1total, @pkmn2total, @pkmn3total, @pkmn4total]
    when 2 then @roundtwototals = [@pkmn1total, @pkmn2total, @pkmn3total, @pkmn4total]
    when 3 then @roundthreetotals = [@pkmn1total, @pkmn2total, @pkmn3total, @pkmn4total]
    when 4 then @roundfourtotals = [@pkmn1total, @pkmn2total, @pkmn3total, @pkmn4total]
    when 5 then @roundfivetotals = [@pkmn1total, @pkmn2total, @pkmn3total, @pkmn4total]
    end
    
    # Resetear a 0 para la siguiente ronda
    @pkmn1hearts = 0
    @pkmn2hearts = 0
    @pkmn3hearts = 0
    @pkmn4hearts = 0
    @turn_hearts = [0, 0, 0, 0]
    pbUpdateAllStars
    Graphics.update
  end
  
  def pbDebugTotals(round) #random assortment of numbers, ensuring your pokemon wins. Intended to be used in debugging the end scene
    @roundonetotals  =[20,rand(10),rand(10),rand(10)] if round>0
    @roundtwototals  =[20,rand(10),rand(10),rand(10)]
    @roundthreetotals=[20,rand(10),rand(10),rand(10)]
    @roundfourtotals =[20,rand(10),rand(10),rand(10)]
    @roundfivetotals =[20,rand(10),rand(10),rand(10)]
    @pkmn1total=(@roundonetotals[0]+@roundtwototals[0]+@roundthreetotals[0]+@roundfourtotals[0]+@roundfivetotals[0])
    @pkmn2total=(@roundonetotals[1]+@roundtwototals[1]+@roundthreetotals[1]+@roundfourtotals[1]+@roundfivetotals[1])
    @pkmn3total=(@roundonetotals[2]+@roundtwototals[2]+@roundthreetotals[2]+@roundfourtotals[2]+@roundfivetotals[2])
    @pkmn4total=(@roundonetotals[3]+@roundtwototals[3]+@roundthreetotals[3]+@roundfourtotals[3]+@roundfivetotals[3])
  end
  
###############################################################################
# Determines order for first round, goes by base speed
###############################################################################
  def pbFindFastestOrderRanking
    # Crear array de [puntuación preliminar, pokémon]
    prelim_scores = [
      [@prelim1, @pkmn1],
      [@prelim2, @pkmn2],
      [@prelim3, @pkmn3],
      [@prelim4, @pkmn4]
    ]
    # Ordenar de mayor a menor puntuación
    prelim_scores = prelim_scores.sort { |a, b| b[0] <=> a[0] }
    # Crear nuevo orden basado en puntuación preliminar
    neworder = []
    for i in 0...4
      neworder.push(prelim_scores[i][1])
    end
    @pokeorder = neworder
  end
  
###############################################################################
# Rondas 2-5: orden por corazones ganados en la RONDA ANTERIOR
###############################################################################
  def pbOrder
    order = []
    @stars = []
    # Obtener corazones de la ronda ANTERIOR (no totales acumulados)
    previous_round_hearts = get_previous_round_hearts
    # Crear array de [corazones, índice] para ordenar
    hearts_with_index = []
    for i in 0...4
      hearts_with_index.push([previous_round_hearts[i], i])
    end
    # Ordenar de mayor a menor corazones
    hearts_with_index = hearts_with_index.sort { |a, b| b[0] <=> a[0] }
    if @MoveUp.include?(true)# Añadir Pokémon con MoveUp (van primero)
      for i in 0...@MoveUp.length
        if @MoveUp[i] == true && @MoveDown[i] == false
          newpoke = @pokeorder[i]
          order.push(newpoke)
          newstars = get_pokemon_stars(newpoke)
          @stars.push(newstars)
        end
      end
    end
    if order.length < 4 # Añadir resto de Pokémon en orden normal (excluyendo MoveUp y MoveDown)
      for i in 0...hearts_with_index.length
        pokemon_index = hearts_with_index[i][1]
        newpoke = @pokeorder[pokemon_index]
        
        # Saltar si ya está en orden (MoveUp) o tiene MoveDown
        next if order.include?(newpoke)
        next if @MoveDown[pokemon_index] == true
        
        order.push(newpoke)
        newstars = get_pokemon_stars(newpoke)
        @stars.push(newstars)
      end
    end
    if @MoveDown.include?(true) #Añadir Pokémon con MoveDown (van al final)
      for i in 0...@pokeorder.length
        if @MoveDown[i] == true && @MoveUp[i] == false
          newpoke = @pokeorder[i]
          order.push(newpoke)
          newstars = get_pokemon_stars(newpoke)
          @stars.push(newstars)
        end
      end
    end
    if @Scramble == true #Si hay Scramble, aleatorizar el orden
      Kernel.srand
      order.shuffle!
      @stars.shuffle!
      Kernel.srand
    end
    @pokeorder.clear
    @pokeorder = order
    pbUpdateAllStars if !@pokeorder.empty?
  end
  
  def pbResetContestMoveEffects #End round reset
    @Oblivious=[false,false,false,false]
    @AvoidOnce=[0,0,0,0]
    @Scramble=false
    @MoveUp=[false,false,false,false]
    @MoveDown=[false,false,false,false]
    @UpCondition=[false,false,false,false]
    @previoushearts=0
    @crowdexcitment=true
    @goodappeal=[false,false,false,false]
    @easilystartled=[false,false,false,false]
    @nervous=[false,false,false,false]
    @jamaffected=[false,false,false,false]
    @hasattention=[false,false,false,false]
    
  
    @pkmn1_repetition_count = 0
    @pkmn2_repetition_count = 0
    @pkmn3_repetition_count = 0
    @pkmn4_repetition_count = 0
    
    pbNervousGraphic
    pbObliviousGraphic
    pbClearStartleGraphics
    if @pokeorder && !@pokeorder.empty?
      pbNoMoreMovesGraphic
    end
  end
  
  def pbPreliminaryScene
    # Inicializar puntuaciones base
    @prelim1 = 0  # Jugador
    @prelim2 = 0  # Rival 1
    @prelim3 = 0  # Rival 2
    @prelim4 = 0  # Rival 3
  
    # -------------------------------------------------------------
    # PUNTUACIÓN DEL JUGADOR (POKÉMON 1)
    # -------------------------------------------------------------
    player_pokemon = $Trainer.party[$PokemonGlobal.contestPlayerPokemon]
    
    # 1. 100% del valor de la condición principal del concurso
    case @contestType
    when "Cool"
      @prelim1 += player_pokemon.cool
      primary_stat = player_pokemon.cool
    when "Beauty"
      @prelim1 += player_pokemon.beauty
      primary_stat = player_pokemon.beauty
    when "Cute"
      @prelim1 += player_pokemon.cute
      primary_stat = player_pokemon.cute
    when "Smart"
      @prelim1 += player_pokemon.smart
      primary_stat = player_pokemon.smart
    when "Tough"
      @prelim1 += player_pokemon.tough
      primary_stat = player_pokemon.tough
    end
    
    # 2. 50% de las condiciones secundarias
    # El sistema oficial usa TODAS las demás estadísticas al 50%
    case @contestType
    when "Cool"
      @prelim1 += (player_pokemon.beauty / 2).floor
      @prelim1 += (player_pokemon.cute / 2).floor
      @prelim1 += (player_pokemon.smart / 2).floor
      @prelim1 += (player_pokemon.tough / 2).floor
    when "Beauty"
      @prelim1 += (player_pokemon.cool / 2).floor
      @prelim1 += (player_pokemon.cute / 2).floor
      @prelim1 += (player_pokemon.smart / 2).floor
      @prelim1 += (player_pokemon.tough / 2).floor
    when "Cute"
      @prelim1 += (player_pokemon.cool / 2).floor
      @prelim1 += (player_pokemon.beauty / 2).floor
      @prelim1 += (player_pokemon.smart / 2).floor
      @prelim1 += (player_pokemon.tough / 2).floor
    when "Smart"
      @prelim1 += (player_pokemon.cool / 2).floor
      @prelim1 += (player_pokemon.beauty / 2).floor
      @prelim1 += (player_pokemon.cute / 2).floor
      @prelim1 += (player_pokemon.tough / 2).floor
    when "Tough"
      @prelim1 += (player_pokemon.cool / 2).floor
      @prelim1 += (player_pokemon.beauty / 2).floor
      @prelim1 += (player_pokemon.cute / 2).floor
      @prelim1 += (player_pokemon.smart / 2).floor
    end
    # 3. 50% del brillo total (sheen) - asumiendo que brillo está en 0-255
    # En los juegos oficiales, el brillo afecta todas las estadísticas
    @prelim1 += (player_pokemon.sheen / 2).floor
    # 4. Bonus por bufanda (scarf) - +20
    case @contestType
    when "Cool"
      @prelim1 += 20 if isConst?(player_pokemon.item, PBItems, :REDSCARF)
    when "Beauty"
      @prelim1 += 20 if isConst?(player_pokemon.item, PBItems, :BLUESCARF)
    when "Cute"
      @prelim1 += 20 if isConst?(player_pokemon.item, PBItems, :PINKSCARF)
    when "Smart"
      @prelim1 += 20 if isConst?(player_pokemon.item, PBItems, :GREENSCARF)
    when "Tough"
      @prelim1 += 20 if isConst?(player_pokemon.item, PBItems, :YELLOWSCARF)
    end
    # 5. Bonus por shiny - +25
    @prelim1 += 25 if player_pokemon.isShiny?
    # -------------------------------------------------------------
    # PUNTUACIÓN DE RIVALES (POKÉMON 2, 3, 4)
    # -------------------------------------------------------------
    rival_pokemon = [@pkmn2, @pkmn3, @pkmn4]
    rival_scores = [@prelim2, @prelim3, @prelim4]
    rival_pokemon.each_with_index do |rival, idx|
      score = 0
      # 1. 100% de la condición principal
      case @contestType
      when "Cool"
        score += rival.cool
        primary_stat = rival.cool
      when "Beauty"
        score += rival.beauty
        primary_stat = rival.beauty
      when "Cute"
        score += rival.cute
        primary_stat = rival.cute
      when "Smart"
        score += rival.smart
        primary_stat = rival.smart
      when "Tough"
        score += rival.tough
        primary_stat = rival.tough
      end
      # 2. 50% de las condiciones secundarias
      case @contestType
      when "Cool"
        score += (rival.beauty / 2).floor
        score += (rival.cute / 2).floor
        score += (rival.smart / 2).floor
        score += (rival.tough / 2).floor
      when "Beauty"
        score += (rival.cool / 2).floor
        score += (rival.cute / 2).floor
        score += (rival.smart / 2).floor
        score += (rival.tough / 2).floor
      when "Cute"
        score += (rival.cool / 2).floor
        score += (rival.beauty / 2).floor
        score += (rival.smart / 2).floor
        score += (rival.tough / 2).floor
      when "Smart"
        score += (rival.cool / 2).floor
        score += (rival.beauty / 2).floor
        score += (rival.cute / 2).floor
        score += (rival.tough / 2).floor
      when "Tough"
        score += (rival.cool / 2).floor
        score += (rival.beauty / 2).floor
        score += (rival.cute / 2).floor
        score += (rival.smart / 2).floor
      end
      # 3. 50% del brillo (sheen)
      score += (rival.sheen / 2).floor
      # 4. Bonus por bufanda (menos probable para rivales)
      case @contestType
      when "Cool"
        score += 20 if isConst?(rival.item, PBItems, :REDSCARF)
      when "Beauty"
        score += 20 if isConst?(rival.item, PBItems, :BLUESCARF)
      when "Cute"
        score += 20 if isConst?(rival.item, PBItems, :PINKSCARF)
      when "Smart"
        score += 20 if isConst?(rival.item, PBItems, :GREENSCARF)
      when "Tough"
        score += 20 if isConst?(rival.item, PBItems, :YELLOWSCARF)
      end
      # 6. VARIABILIDAD para rivales
      variability = rand(5) - 5  # Rango: -5 a +5
      # Ajuste basado en dificultad (opcional)
      case @difficulty
      when 75..100  # Difícil: menos variabilidad negativa
        variability = [variability, -2].max
      when 50..74   # Medio: variabilidad normal
        # No se cambia
      else          # Fácil: más variabilidad negativa
        variability = [variability, -5].min if variability < 0
      end
      score += variability
      case idx # Asignar puntuación final
      when 0 then @prelim2 = score
      when 1 then @prelim3 = score
      when 2 then @prelim4 = score
      end
    end
    # Depuración (opcional)
    if $DEBUG
      puts "Puntuaciones preliminares:"
      puts "Jugador: #{@prelim1}"
      puts "Rival 1: #{@prelim2}"
      puts "Rival 2: #{@prelim3}"
      puts "Rival 3: #{@prelim4}"
    end
  end
###############################################################################
# Controls Applause meter
###############################################################################
  def pbCrowd(move=nil)
      xPos = -172
      @sprites["Applause_Bar"] = IconSprite.new(xPos, 0, @viewport2)
      @sprites["Applause_Bar"].setBitmap("Graphics/Pictures/Contest/applause")
      applausefile = sprintf("Graphics/Pictures/Contest/applause%d", @applause)
      @sprites["applausemeter"] = IconSprite.new(xPos, 0, @viewport_hearts)
      @sprites["applausemeter"].setBitmap(applausefile)
      
      # Animación de entrada del medidor
      43.times do |i|
        xPos += 4
        @sprites["applausemeter"].x = xPos
        @sprites["Applause_Bar"].x = xPos
        Graphics.update
      end
      
      if move.nil?
        # Determinar efecto del movimiento según tipo
        relations = get_contest_type_relations(@contestType)
        
        if @moveType == @contestType && @crowdexcitment
          # Mismo tipo que concurso - excita al público
          @applause += 1 if @applause < 5
          applausefile = sprintf("Graphics/Pictures/Contest/applause%d", @applause)
          @sprites["applausemeter"].setBitmap(applausefile)
          Graphics.update
          pbSEPlay("Contest_heart")
          pbWait(4)
          if @moveType == "Smart"
            pbShowMessage(_INTL("¡{1} ha exhibido una {2} increíble!", 
                             @pokeorder[@currentpos-1].name, @moveName))
          else
            pbShowMessage(_INTL("¡{1} ha exhibido un {2} increíble!", 
                          @pokeorder[@currentpos-1].name, @moveName))
          end
          @currenthearts = 1
          pbDisplayAddingPositiveHearts
        elsif relations[:neutral].include?(@moveType)
          # Tipo neutral - no afecta el entusiasmo
        elsif relations[:lowers].include?(@moveType)
          # Tipo que baja entusiasmo
          pbShowMessage(_INTL("La exhibición de {2} de {1} no ha salido muy bien.",
                             @pokeorder[@currentpos-1].name, @moveName))
          if @applause > 0
            @applause -= 1
            applausefile = sprintf("Graphics/Pictures/Contest/applause%d", @applause)
            @sprites["applausemeter"].setBitmap(applausefile)
          end
          pbJam(1, @pokeorder[@currentpos-1], @currentpos)
          pbDecreaseHearts(@pokeorder[@currentpos-1], @currentpos, "notnil")
          Graphics.update
        end
        # ¡FUROR! - Si el público está al máximo
        if @applause >= 5
          current_pokemon = @pokeorder[@currentpos-1]
            pbShowMessage(_INTL("¡La exhibición de {2} de {1} ha hecho furor!", 
                                 current_pokemon.name, @moveName))
          if pbCanMegaEvolveInContest?(current_pokemon)
            pbMegaEvolveInContest(current_pokemon, @currentpos)
            pbShowMessage(_INTL("¡El público está totalmente cautivado!"),true)
            @currenthearts = 8
            pbDisplayAddingPositiveHearts
          else
            # Sin Mega Evolución, bonus normal
            @currenthearts = 5
            pbDisplayAddingPositiveHearts
          end
          @applause = 0  # Resetear después
        end
        pbWait(4)
        # Animación de salida del medidor
        if @sprites["Applause_Bar"]
          43.times do |i|
            xPos -= 4
            @sprites["Applause_Bar"].x = xPos
            if @sprites["applausemeter"]
              @sprites["applausemeter"].x = xPos
            end
            Graphics.update
          end
        end
        pbDisposeSprite(@sprites, "Applause_Bar") if @sprites["Applause_Bar"]
        pbDisposeSprite(@sprites, "applausemeter") if @sprites["applausemeter"]
        Graphics.update
      end
    end


# ---------------------------------------------------------------------------
# Mega Evolucionar al Pokémon del jugador en el concurso
# ---------------------------------------------------------------------------
  def pbCanMegaEvolveInContest?(pokemon)
    return false if !pokemon
    return false if (pokemon.isMega? rescue false)
    return true  if pokemon.hasMegaForm?
    return false
  end
  
  def pbMegaEvolveInContest(pokemon, position)
    return if !pokemon
    
    # Mensaje según el tipo de Mega Evolución
    case (pokemon.megaMessage rescue 0)
    when 1  # Rayquaza
      pbShowMessage(_INTL("¡El ruego vehemente alcanza a {1}!", pokemon.name),true)
    else
      item_name = PBItems.getName(pokemon.item)
      pbShowMessage(_INTL("¡La {1} de {2} está reaccionando!", item_name, pokemon.name),true)
    end
    # Animación de Mega Evolución (usando wrapper)
    wrapped_pokemon = ContestPokemonWrapper.new(pokemon)
    pbCommonAnimation("MegaEvolution", wrapped_pokemon, wrapped_pokemon)
    # Realizar la Mega Evolución
    pokemon.makeMega
    # Actualizar sprite del Pokémon
    sprite_name = get_pokemon_sprite_name(position)
    if @sprites[sprite_name]
      @sprites[sprite_name].setPokemonBitmap(pokemon, true)
    end
    # Segunda parte de la animación (con wrapper actualizado)
    wrapped_pokemon = ContestPokemonWrapper.new(pokemon)
    pbCommonAnimation("MegaEvolution2", wrapped_pokemon, wrapped_pokemon)
    pbWait(10)
    pbPlayCry(pokemon)
    # Mensaje de confirmación
    mega_name = (pokemon.megaName rescue nil)
    if !mega_name || mega_name == ""
      mega_name = _INTL("Mega {1}", PBSpecies.getName(pokemon.species))
    end
    pbShowMessage(_INTL("¡{1} ha Mega Evolucionado en {2}!", pokemon.name, mega_name),true)
  end
  
  def get_contest_type_relations(contest_type)
    case contest_type
    when "Cool"
      {
        :excites=> ["Cool"],
        :neutral=> ["Beauty", "Tough"],
        :lowers=> ["Smart", "Cute"]
      }
    when "Beauty"
      {
        :excites=> ["Beauty"],
        :neutral=> ["Cool", "Cute"],
        :lowers=> ["Smart", "Tough"]
      }
    when "Cute"
      {
        :excites=> ["Cute"],
        :neutral=> ["Beauty", "Smart"],
        :lowers=> ["Cool", "Tough"]
      }
    when "Smart"
      {
       :excites=> ["Smart"],
       :neutral=> ["Cute", "Tough"],
       :lowers=> ["Beauty", "Cool"]
      }
    when "Tough"
      {
        :excites => ["Tough"],
        :neutral=> ["Cool", "Smart"],
        :lowers=> ["Beauty", "Cute"]
      }
    end
  end

  def pbJam(jam,target,position)
    case target
    when @pkmn1 then @pkmn1jam=jam
    when @pkmn2 then @pkmn2jam=jam
    when @pkmn3 then @pkmn3jam=jam
    when @pkmn4 then @pkmn4jam=jam
    end
  end
  
###############################################################################
# Misc. Functions
# Funciones helper
###############################################################################
  def pbAssignLastMove
    case @currentpoke
    when @pkmn1
      # Verificar si repite movimiento
      if @pkmn1lastmoveid == @currentmove
        @pkmn1_repetition_count = (@pkmn1_repetition_count || 0) + 1
      else
        @pkmn1_repetition_count = 0
      end
      @pkmn1lastmove = @currentmovename
      @pkmn1lastmoveid = @currentmove
      
    when @pkmn2
      if @pkmn2lastmoveid == @currentmove
        @pkmn2_repetition_count = (@pkmn2_repetition_count || 0) + 1
      else
        @pkmn2_repetition_count = 0
      end
      @pkmn2lastmove = @currentmovename
      @pkmn2lastmoveid = @currentmove
      
    when @pkmn3
      if @pkmn3lastmoveid == @currentmove
        @pkmn3_repetition_count = (@pkmn3_repetition_count || 0) + 1
      else
        @pkmn3_repetition_count = 0
      end
      @pkmn3lastmove = @currentmovename
      @pkmn3lastmoveid = @currentmove
      
    else  # @pkmn4
      if @pkmn4lastmoveid == @currentmove
        @pkmn4_repetition_count = (@pkmn4_repetition_count || 0) + 1
      else
        @pkmn4_repetition_count = 0
      end
      @pkmn4lastmove = @currentmovename
      @pkmn4lastmoveid = @currentmove
    end
  end
  
  
  def pbCheckLast
    case @currentpoke
    when @pkmn1
      if @pkmn1lastmove
        if @currentmovename==@pkmn1lastmove
          return true
        else
          return false
        end
      end
    when @pkmn2
      if @pkmn2lastmove
        if @currentmovename==@pkmn2lastmove
          return true
        else
          return false
        end
      end
    when @pkmn3
      if @pkmn3lastmove
        if @currentmovename==@pkmn3lastmove
          return true
        else
          return false
        end
      end
    when @pkmn4
      if @pkmn4lastmove
        if @currentmovename==@pkmn4lastmove
          return true
        else
          return false
        end
      end
    end
  end
  
  def pbmoveType(moveType)
    case moveType
    when 0 then @moveType="Cool"
    when 1 then @moveType="Beauty"
    when 2 then @moveType="Cute"
    when 3 then @moveType="Smart"
    when 4 then @moveType="Tough"
    end
    

    case moveType
    when 0 then @moveName=_INTL("Carisma")
    when 1 then @moveName=_INTL("Belleza")
    when 2 then @moveName=_INTL("Dulzura")
    when 3 then @moveName=_INTL("Ingenio")
    when 4 then @moveName=_INTL("Dureza")
    end
    
  end
  
  def pbNoMore #checks if pokemon can use moves
    case @currentpoke
    when @pkmn1 then return @pkmn1nomoremoves
    when @pkmn2 then return @pkmn2nomoremoves
    when @pkmn3 then return @pkmn3nomoremoves
    when @pkmn4 then return @pkmn4nomoremoves
    else
      return false
    end
  end
  
  def pbMissTurn #Checks if pokemon misses this turn
    case @currentpoke
    when @pkmn1 then return @pkmn1MissTurn
    when @pkmn2 then return @pkmn2MissTurn
    when @pkmn3 then return @pkmn3MissTurn
    when @pkmn4 then return @pkmn4MissTurn
    else
      return false
    end
  end
  
  def pbDoubleNext #Check if it should double hearts
    case @currentpoke
    when @pkmn1 then return @pkmn1DoubleNext
    when @pkmn2 then return @pkmn2DoubleNext
    when @pkmn3 then return @pkmn3DoubleNext
    when @pkmn4 then return @pkmn4DoubleNext
    else
      return false
    end
  end
  
  def pbSetNoMoreMoves(pos_idx)
    case @pokeorder[pos_idx]
    when @pkmn1 then @pkmn1nomoremoves = true
    when @pkmn2 then @pkmn2nomoremoves = true
    when @pkmn3 then @pkmn3nomoremoves = true
    when @pkmn4 then @pkmn4nomoremoves = true
    end
  end
    
  def pbSetMissTurn(pos_idx)
    case @pokeorder[pos_idx]
    when @pkmn1 then @pkmn1MissTurn = true
    when @pkmn2 then @pkmn2MissTurn = true
    when @pkmn3 then @pkmn3MissTurn = true
    when @pkmn4 then @pkmn4MissTurn = true
    end
  end
  
    
  def pbSetDoubleNext(pos_idx)
    case @pokeorder[pos_idx]
    when @pkmn1 then @pkmn1DoubleNext = true
    when @pkmn2 then @pkmn2DoubleNext = true
    when @pkmn3 then @pkmn3DoubleNext = true
    when @pkmn4 then @pkmn4DoubleNext = true
    end
  end
  
  def pbReverseMissTurn
    case @currentpoke
    when @pkmn1 then @pkmn1MissTurn=false
    when @pkmn2 then @pkmn2MissTurn=false
    when @pkmn3 then @pkmn3MissTurn=false
    when @pkmn4 then @pkmn4MissTurn=false
    end
  end
  
  def pbReverseDoubleNext
    case @currentpoke
    when @pkmn1 then @pkmn1DoubleNext=false
    when @pkmn2 then @pkmn2DoubleNext=false
    when @pkmn3 then @pkmn3DoubleNext=false
    when @pkmn4 then @pkmn4DoubleNext=false
    end
  end
  
  
  def pbCurrentPokeNum(poke) #find pokemon's number (i.e. 1 for @pkmn1)
    for i in 0..3
      return i if @pokeorder[i]==poke
    end
  end
  
    def get_star_sprite_name(position)
    if    position == 0 then return "firstpokestars"
    elsif position == 1 then return "secondpokestars"
    elsif position == 2 then return "thirdpokestars"
    elsif position == 3 then return "fourthpokestars"
    else;                    return "unknownstars"
    end
  end
  
  def get_pokemon_sprite_name(position)
    case position
    when 1 then return "pokemon1"
    when 2 then return "pokemon2"
    when 3 then return "pokemon3"
    when 4 then return "pokemon4"
    else;       return "pokemon1"
    end
  end
  ###############################################################################
  # Obtener corazones de la ronda anterior
  ###############################################################################
  def get_previous_round_hearts
    case @round
    when 1
      # En ronda 1, no hay ronda anterior, usar preliminares
      return [@prelim1, @prelim2, @prelim3, @prelim4]
    when 2
      # En ronda 2, usar corazones de ronda 1
      return @last_round_hearts || [@pkmn1hearts, @pkmn2hearts, @pkmn3hearts, @pkmn4hearts]
    when 3, 4, 5
      # En rondas 3-5, usar corazones guardados de la ronda anterior
      return @last_round_hearts || [0, 0, 0, 0]
    else
      return [0, 0, 0, 0]
    end
  end
  
  def get_pokemon_stars(pokemon)
    case pokemon
    when @pkmn1 then return @pkmn1stars
    when @pkmn2 then return @pkmn2stars
    when @pkmn3 then return @pkmn3stars
    when @pkmn4 then return @pkmn4stars
    else return 0
    end
  end

  ###############################################################################
  # Adjusts hearts via movefunctions. New move functions go in case statement
  ###############################################################################
  def pbFunctionsAdjustHearts
    contestdata = PBContestMoveData.new(@currentmove)
    @currentfunction = contestdata.contestfunction
    @currentjam = contestdata.jam
    pos_idx = @currentpos - 1
    
    # CORRECCIÓN: Declarar variable si no existe
    @priorhearts = 0 if !@priorhearts
    
    current_stars = @stars[pos_idx] || 0
    if current_stars > 0
      @currenthearts += current_stars
      pbShowMessage(_INTL("¡Las {1} estrellas de {2} potencian su exhibición!", 
                         current_stars, @pokeorder[pos_idx].name), true)
    end
    
    case @currentfunction
    when 0   # Exhibición llamativa (sin efecto especial)
      # No hace nada especial, solo usa corazones base
      
    when 1, 30  # Evita intimidación una vez (unificar funciones)
      @AvoidOnce[pos_idx] = 1
      pbObliviousGraphic
      pbShowMessage(_INTL("{1} se ha preparado para evitar distracciones.", @pokeorder[pos_idx].name), true) if @currentfunction == 30
      
    when 2   # Altera orden (Mover arriba)
      @MoveUp[pos_idx] = true
      pbShowMessage(_INTL("{1} conseguirá actuar antes en la próxima ronda.", @pokeorder[pos_idx].name), true)
      
    when 3   # Templa fervor del público
      pbShowMessage(_INTL("El público se ha calmado."), true)
      @crowdexcitment = false
      
    when 4   # Intimida mismo tipo
      pbStartleSameType(false, pos_idx)
      
    when 5   # Inquieta a los Pokémon que se exhiban a continuación
      pbShowMessage(_INTL("{1} ha inquietado a los siguientes concursantes.", @pokeorder[pos_idx].name), true)
      # Implementación específica - afecta a los que van después
      ((pos_idx + 1)...4).each do |idx|
        @nervous[idx] = true
      end
      pbNervousGraphic
      
    when 6   # Intimida un poco a los que han usado movimientos del mismo tipo
      pbStartleSameType(pos_idx, true)
      
    when 7   # Intimida un poco al Pokémon que se ha exhibido antes
      pbStartlePrevious(pos_idx, true)
      
    when 8   # Intimida al Pokémon que se ha exhibido antes
      pbStartlePrevious(pos_idx, false)
      
    when 9   # Intimida a los Pokémon que ya han realizado su exhibición
      pbStartleAllPrevious(pos_idx)
      
    when 10  # Hace que los Pokémon que ya se han exhibido se acobarden
      @easilystartled[pos_idx] = true
      pbShowMessage(_INTL("{1} ha hecho que los anteriores se sientan vulnerables.", @pokeorder[pos_idx].name), true)
      
    when 11  # Intimida a los Pokémon que acaparan la atención del público
      pbStartleAttention(pos_idx, false)
      
    when 12  # Intimida mucho a los Pokémon que acaparan la atención del público
      pbStartleAttention(pos_idx, true)
      
    when 13  # Pone nerviosos a los Pokémon que aún no se han exhibido
      pbMakeNervous(pos_idx)
      
    when 14  # La exhibición es un éxito si se usa cuando uno es el primero del turno
      if @currentpos == 1
        pbShowMessage(_INTL("¡{1} ha aprovechado su posición para brillar aún más!", @pokeorder[pos_idx].name), true)
        @currenthearts *= 2
      end
      
    when 15  # La exhibición es un éxito si se usa cuando uno es el último del turno
      if @currentpos == 4
        pbShowMessage(_INTL("¡{1} ha cerrado la ronda con una exhibición espectacular!", @pokeorder[pos_idx].name), true)
        @currenthearts *= 2
      end
      
    when 16  # Hace que el usuario se mueva antes en el siguiente turno
      @MoveUp[pos_idx] = true
      pbShowMessage(_INTL("{1} actuará antes en la próxima ronda.", @pokeorder[pos_idx].name), true)
      
    when 17  # Si el Pokémon se exhibe en primer lugar, se meterá al público en el bolsillo
      if @currentpos == 1
        @applause = [@applause + 2, 5].min
        pbShowMessage(_INTL("¡El público está encantado con {1}!", @pokeorder[pos_idx].name), true)
        pbCrowd("notnil")
      end
      
    when 18, 22  # Mucha exhibición pero vulnerable (unificar)
      pbSetDoubleNext(pos_idx)
      @easilystartled[pos_idx] = true
      pbShowMessage(_INTL("¡{1} ha hecho una exhibición impresionante pero ahora está vulnerable!", @pokeorder[pos_idx].name), true)
      
    when 19  # Entusiasma al público en cualquier concurso
      @currenthearts += 1
      pbShowMessage(_INTL("¡El público aplaude la exhibición de {1}!", @pokeorder[pos_idx].name), true)
    when 20  # Hace que todos los Pokémon que se han exhibido bien se acobarden
      pbStartleGoodAppeals(pos_idx)

    when 21  # Su impacto varía según cuándo se utilice
      # Más tarde = más corazones
      @currenthearts = @currentpos + 1
      pbShowMessage(_INTL("¡{1} ha sabido esperar su momento!", @pokeorder[pos_idx].name), true)
    when 23  # Causa mayor impacto cuanto más tarde se usa
      @currenthearts = @currentpos + 2
      pbShowMessage(_INTL("¡Cuanto más tarde, mejor para {1}!", @pokeorder[pos_idx].name), true)
      
    when 24  # Hace que el usuario se mueva después en el siguiente turno
      @MoveDown[pos_idx] = true
      pbShowMessage(_INTL("{1} actuará después en la próxima ronda.", @pokeorder[pos_idx].name), true)
      
    when 25  # Entusiasma mucho al público si se usa en primer lugar
      if @currentpos == 1
        @currenthearts += 3
        pbShowMessage(_INTL("¡{1} ha empezado con fuerza y emocionado al público!", @pokeorder[pos_idx].name), true)
      end
      
    when 26  # Funciona mejor cuanto más excitado está el público
      @currenthearts += @applause
      pbShowMessage(_INTL("¡El entusiasmo del público beneficia a {1}!", @pokeorder[pos_idx].name), true)
      
    when 27  # Funciona bien si es del mismo tipo que el último movimiento usado
      if @lastmoveType && @moveType == @lastmoveType
        @currenthearts += 3
        pbShowMessage(_INTL("¡La combinación de movimientos ha sido perfecta!", @pokeorder[pos_idx].name), true)
      end
    when 28  # Hace que el público espere poco de otros participantes (NO es aleatorio)
      pbShowMessage(_INTL("El público ahora espera menos de los demás concursantes."), true)
      @audience_expectations_low = true
      # Esto afectará a la puntuación de los siguientes Pokémon

    when 29  # Entusiasma mucho al público si se usa en último lugar
      if @currentpos == 4
        @currenthearts += 3
        pbShowMessage(_INTL("¡{1} ha cerrado la ronda por todo lo alto!", @pokeorder[pos_idx].name), true)
      end
      
    when 31, 32  # Aumenta la confianza y ayuda a mantener la calma
      @nervous[pos_idx] = false
      @UpCondition[pos_idx] = true
      pbDecreaseStarGraphics(@currentpos - 1, 1, false)
      pbShowMessage(_INTL("{1} ha aumentado su confianza.", @pokeorder[pos_idx].name), true)
      
    when 33  # Obtiene +3 si el Pokémon consigue la puntuación más baja
      # Necesita saber la puntuación de todos en la ronda anterior
      if @priorhearts && @priorhearts.is_a?(Array)
        min_hearts = @priorhearts.min
        if @priorhearts[pos_idx] == min_hearts && min_hearts < @priorhearts.max
          @currenthearts += 3
          pbShowMessage(_INTL("¡{1} ha sorprendido a todos a pesar de ir último!", @pokeorder[pos_idx].name), true)
        end
      end
      
    when 34  # Muestra una exhibición tan buena como los movimientos anteriores
      if @priorhearts && @priorhearts.is_a?(Array) && @currentpos > 1
        @currenthearts = @priorhearts[pos_idx - 1]
        pbShowMessage(_INTL("{1} iguala la exhibición anterior.", @pokeorder[pos_idx].name), true)
      end
      
    when 35  # Se ve afectado por cómo fue la exhibición del Pokémon anterior
      if @currentpos > 1 && @priorhearts && @priorhearts.is_a?(Array)
        if @priorhearts[pos_idx - 1] < 3
          @currenthearts *= 2
          pbShowMessage(_INTL("¡{1} aprovecha el tropiezo del rival!", @pokeorder[pos_idx].name), true)
        end
      end
      
    when 36  # Aumenta su impacto conforme aumenta el entusiasmo del público
      @currenthearts += (@applause / 2).floor
      pbShowMessage(_INTL("{1} se alimenta de la energía del público.", @pokeorder[pos_idx].name), true)
      
    when 37  # Mejora la condición del usuario
      if @priorhearts && @priorhearts.is_a?(Array)
        @currenthearts += (@priorhearts[pos_idx] / 2).floor
        pbShowMessage(_INTL("{1} mejora su condición física.", @pokeorder[pos_idx].name), true)
      end
      
    when 38  # Funciona bien si el usuario está motivado
      if @UpCondition[pos_idx]
        @currenthearts += 3
        pbShowMessage(_INTL("¡{1} está motivado y lo demuestra!", @pokeorder[pos_idx].name), true)
      end
      
    when 39  # Aumenta el impacto del usuario en la mitad de los corazones obtenidos
      if @priorhearts && @priorhearts.is_a?(Array)
        @currenthearts = (@priorhearts[pos_idx] / 2).floor
        @currenthearts = 1 if @currenthearts < 1
        pbShowMessage(_INTL("{1} mantiene la mitad de su impulso.", @pokeorder[pos_idx].name), true)
      end
      
    when 40  # Obtiene +3 si la última exhibición también inició un combo
      if @last_was_combo_starter
        @currenthearts += 3
        pbShowMessage(_INTL("¡Combo continuado! El público está impresionado.", @pokeorder[pos_idx].name), true)
      end
      
    when 41  # No puede usar más movimientos el resto del concurso
      pbSetNoMoreMoves(pos_idx)
      pbShowMessage(_INTL("{1} dio todo de sí, pero ya no puede continuar exhibiéndose.", @pokeorder[pos_idx].name), true)
      pbNoMoreMovesGraphic
      
    when 42  # Intimida a todos, pero pierde el siguiente turno
      pbStartleAllOthers(pos_idx, @currentjam)
      pbSetMissTurn(pos_idx)
      pbShowMessage(_INTL("{1} se ha esforzado tanto que necesitará descansar el siguiente turno.", @pokeorder[pos_idx].name), true)
      pbNoMoreMovesGraphic
      
    else
      # Efecto no implementado - usar valor por defecto
      #pbShowMessage(_INTL("{1} hace una exhibición.", @pokeorder[pos_idx].name), true)
    end
    
    
    
  end

  # ------------------------------------------------------------------
  # NUEVAS FUNCIONES AUXILIARES PARA EFECTOS FALTANTES
  # ------------------------------------------------------------------
  def pbStartleSameType(pos_idx, weak=false)
    pbShowMessage(_INTL("¡Ha intimidado a los Pokémon que usaron el mismo tipo de movimiento!"), true)
    jam_amount = weak ? 1 : 2
    
    4.times do |idx|
      next if idx == pos_idx  # Saltar al usuario
      next unless @pokeorder && @pokeorder[idx]
      
      # Verificar si usó el mismo tipo de movimiento
      # Esto requiere tracking por Pokémon individual
      if @lastmoveType && @moveType == @lastmoveType
        pbJam(jam_amount, @pokeorder[idx], idx + 1)
        pbDecreaseHearts(@pokeorder[idx], idx + 1)
      end
    end
  end
  
  def pbStartlePrevious(pos_idx, weak=false)
    return if @currentpos <= 1
    
    pbShowMessage(_INTL("¡Ha intimidado al Pokémon anterior!"), true)
    target_idx = @currentpos - 2
    pokemon = @pokeorder[target_idx]
    jam_amount = weak ? 1 : 2
    
    if @Oblivious && @Oblivious[target_idx]
      pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
    elsif @AvoidOnce && @AvoidOnce[target_idx] > 0
      pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
      @AvoidOnce[target_idx] = 0
      pbObliviousGraphic
    else
      pbStartleGraphic(target_idx)
      pbJam(jam_amount, pokemon, target_idx + 1)
      pbDecreaseHearts(pokemon, target_idx + 1)
    end
  end
  
  def pbStartleAllPrevious(pos_idx)
    return if @currentpos <= 1
    
    pbShowMessage(_INTL("Ha intentado poner nerviosos a los que venían antes."), true)
    
    (0...@currentpos - 1).each do |idx|
      pokemon = @pokeorder[idx]
      
      if @Oblivious && @Oblivious[idx]
        pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
      elsif @AvoidOnce && @AvoidOnce[idx] > 0
        pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
        @AvoidOnce[idx] = 0
        pbObliviousGraphic
      else
        pbStartleGraphic(idx)
        pbJam(1, pokemon, idx + 1)
        pbDecreaseHearts(pokemon, idx + 1)
      end
    end
  end
  
  def pbStartleAllOthers(pos_idx, jam_amount=2)
    pbShowMessage(_INTL("¡Ha intimidado a todos los demás Pokémon!"), true)
    
    4.times do |idx|
      next if idx == pos_idx
      next unless @pokeorder && @pokeorder[idx]
      
      pokemon = @pokeorder[idx]
      
      if @Oblivious && @Oblivious[idx]
        pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
      elsif @AvoidOnce && @AvoidOnce[idx] > 0
        pbShowMessage(_INTL("{1} se las ha arreglado para no verlo.", pokemon.name), true)
        @AvoidOnce[idx] = 0
        pbObliviousGraphic
      else
        pbStartleGraphic(idx)
        pbJam(jam_amount, pokemon, idx + 1)
        pbDecreaseHearts(pokemon, idx + 1)
      end
    end
  end

  def pbStartleEffect(func_type)
    messages = {
      5 =>  _INTL("Ha intentado intimidar a otros Pokémon."),
      8 =>  _INTL("Ha intentado intimidar al Pokémon anterior."),
      16 => _INTL("Ha intentado intimidar a otros Pokémon.")
    }
    pbShowMessage(_INTL(messages[func_type]), true)
    pbSetMissTurn if func_type == 16
    
    if @currentpos == 1
      pbShowMessage(_INTL("¡Pero ha fallado!"), true) if func_type != 16
      return
    end
  
    case func_type
    when 5, 16 # Asustar a todos los anteriores
      (@currentpos - 2).downto(0) do |idx|
        pbProcessStartle(idx, @currentjam, @currentpos - 1)
      end
    when 8 # Asustar solo al anterior
      pbProcessStartle(@currentpos - 2, @currentjam, @currentpos - 1)
    end
    pbRemoveStartleAfterDelay
  end

  def pbProcessStartle(target_idx, jam_amount, pos_idx)
    return if target_idx < 0
    return unless @pokeorder && @pokeorder[target_idx]
    return if target_idx >= 4
    
    pokemon = @pokeorder[target_idx]
    display_pos = target_idx + 1  # Posición 1-based para mensajes
    
    # Verificar protecciones
    if @Oblivious && @Oblivious[target_idx]
      pbShowMessage(_INTL("¡{1} se las ha arreglado para no verlo!", pokemon.name), true)
      return
    end
    
    if @AvoidOnce && @AvoidOnce[target_idx] > 0
      pbShowMessage(_INTL("¡{1} evitó la distracción!", pokemon.name), true)
      @AvoidOnce[target_idx] = 0
      pbObliviousGraphic
      return
    end
    pbJam(jam_amount, pokemon, display_pos)
    pbRemoveHearts(jam_amount, pokemon, display_pos, false)
    # Mostrar gráfico de startle
    pbStartleGraphic(target_idx)
    pbShowMessage(_INTL("¡{1} ha sido intimidado!", pokemon.name), true)
  end
  
  
  def pbStartleAttention(pos_idx, strong=false)
    pbShowMessage(_INTL("¡Intimida a los Pokémon que acaparan la atención!"), true)
    
    4.times do |j|
      next if j == pos_idx
      if @hasattention && @hasattention[j]
        jam_amount = strong ? @currentjam + 1 : @currentjam
        pbProcessStartle(j, jam_amount, pos_idx)
      end
    end
  end
  
  def pbStartleGoodAppeals(pos_idx)
    pbShowMessage(_INTL("¡Hace que los Pokémon que se han exhibido bien se acobarden!"), true)
    # Afecta SOLO a los que YA ACTUARON antes que el usuario en ESTE turno
    (0...@currentpos - 1).each do |j|
      next if j == pos_idx
      next unless @pokeorder && @pokeorder[j]
      
      # Verificar si el Pokémon tuvo una buena exhibición (más de 3 corazones)
      # Necesitas guardar los corazones GANADOS en este turno por cada Pokémon
      hearts_this_turn = get_hearts_this_turn(j)
      
      if hearts_this_turn > 3
        pbProcessStartle(j, 2, pos_idx)  # JAM 2 por acobardar
        pbShowMessage(_INTL("{1} se ha acobardado!", @pokeorder[j].name), true)
      end
    end
  end
  
  # Función auxiliar para obtener corazones ganados en este turno
  def get_hearts_this_turn(position)
    # Necesitas guardar esto durante el turno
    # Por ahora, usamos @priorhearts como fallback
    if @turn_hearts && @turn_hearts[position]
      return @turn_hearts[position]
    else
      return @priorhearts[position] || 0
    end
  end

  def pbAdjustByPrior(func_type, pos_idx)
    if func_type == 9
      @currenthearts = @priorhearts[pos_idx] >= 3 ? @currenthearts * 2 : 1
    elsif func_type == 40
      @currenthearts = (@currentpos > 1 && @priorhearts[pos_idx] > 3) ? @currenthearts * 2 : 1
    end
  end
  
  def pbPositionBonus(func_type, pos_idx)
    if func_type == 14 && @currentpos == 1
      pbShowMessage(_INTL("{1} , ya en cabeza, destacó aún más.", @pokeorder[pos_idx].name),true)
      @currenthearts *= 2
    elsif func_type == 21 && @currentpos == 4
      pbShowMessage(_INTL("{1} , ya en cabeza, destacó aún más.", @pokeorder[pos_idx].name),true)
      @currenthearts = 5
    end
  end
  
  def pbMakeNervous(pos_idx)
    pbShowMessage(_INTL("{1} ha puesto nerviosos a los siguientes concursantes.", @pokeorder[pos_idx].name), true)
    
    case @currentpos
    when 1
      (1..3).each { |j| set_nervous(j) if @pokeorder[j] }
    when 2
      (2..3).each { |j| set_nervous(j) if @pokeorder[j] }
    when 3
      set_nervous(3) if @pokeorder[3]
    end
    
    pbNervousGraphic
  end

  def set_nervous(idx)
    return unless @pokeorder && @pokeorder[idx]
    @nervous ||= [false, false, false, false]
    @nervous[idx] = true
    pbShowMessage(_INTL("{1} se ha puesto nervioso.", @pokeorder[idx].name), true)
  end

###############################################################################
# AI
###############################################################################  

  def pbAI(pokemon, difficulty)
    movescores = []
    pos_idx = @currentpos - 1
    
    # Obtener último movimiento usado por este Pokémon
    last_move_id = case pokemon
    when @pkmn1 then @pkmn1lastmoveid
    when @pkmn2 then @pkmn2lastmoveid
    when @pkmn3 then @pkmn3lastmoveid
    when @pkmn4 then @pkmn4lastmoveid
    end
    
    pokemon.moves.each_with_index do |move_obj, i|
      next if move_obj.id <= 0
      move_id = move_obj.id
      score = 100  # Puntuación base
      # Obtener datos del movimiento
      contest_data = PBContestMoveData.new(move_id)
      hearts = contest_data.hearts || 4
      jam = contest_data.jam || 0
      function = contest_data.contestfunction || 0
      type = contest_data.contestType
      # BONUS POR COMBO (¡Muy importante!)
      if @round > 1 && last_move_id && last_move_id > 0
        # Verificar si este movimiento sigue el último movimiento
        combo_bonus = pbGetComboBonus(last_move_id, move_id, difficulty)
        score += combo_bonus
      end
      # BONUS POR SER INICIADOR DE COMBO (si no hay movimiento previo)
      if !last_move_id || last_move_id == 0
        starter_bonus = pbGetStarterComboBonus(move_id, difficulty)
        score += starter_bonus
      end
      # Evaluar función del movimiento
      score += evaluate_move_function(function, hearts, type, pos_idx)
      # Bonus adicionales
      score += 80 if type == @contestType  # Mismo tipo que concurso (bonus alto)
      # Penalizar repetición (excepto función 15)
      if function != 15 && last_move_id && move_id == last_move_id
        score -= 60  # Penalización alta por repetir
      end
      # Considerar posición actual
      score += evaluate_position_bonus(function, pos_idx)
      # Considerar ronda actual
      score += evaluate_round_bonus(function, @round)
      movescores[i] = score # Guardar puntuación
    end
    # Seleccionar movimiento
    return select_smart_move(movescores, difficulty, pokemon)
  end
  
  # ------------------------------------------------------------------
  # FUNCIONES HELPER PARA EVALUACIÓN DE COMBOS
  # ------------------------------------------------------------------
  def pbGetComboBonus(last_move_id, current_move_id, difficulty)
    bonus = 0
    # Usar el nuevo sistema hash
    if CONTEST_COMBO_HASH[last_move_id] && CONTEST_COMBO_HASH[last_move_id].include?(current_move_id)
      bonus += 120  # Bonus muy alto por continuar combo
      # Bonus adicional por dificultad
      case difficulty
      when 75..100  # Difícil
        bonus += 80
      when 50..74   # Medio
        bonus += 40
      when 25..49   # Fácil
        bonus += 20
      else          # Muy fácil
        bonus += 10
      end
      bonus += (@round * 15) # Bonus por ronda (mejor en rondas finales)
    end
    return bonus
  end
  
  def pbGetStarterComboBonus(move_id, difficulty)
    bonus = 0
    # Verificar si este movimiento inicia algún combo
    # Necesitamos invertir la búsqueda en CONTEST_COMBO_HASH
    # Para esto, mejor buscar directamente en COMBOS
    COMBOS.each_value do |combo_data|
      combo_data[:starter].each do |starter_sym|
        starter_id = getID(PBMoves, starter_sym)
        if move_id == starter_id
          bonus += 60  # Bonus por iniciar combo
          # Bonus por dificultad
          case difficulty
          when 75..100
            bonus += 40
          when 50..74
            bonus += 20
          when 25..49
            bonus += 10
          end
          # Bonus adicional si el combo tiene muchas opciones
          if combo_data[:followup].length > 3
            bonus += 30  # Combo versátil
          end
          break
        end
      end
    end
    return bonus
  end

  def evaluate_move_function(function, hearts, type, pos_idx)
    score = 0
    case function
    when 0  # Sin función especial
      score += hearts > 3 ? 70 : 30
    when 1, 2, 30  # Protección
      case @currentpos
      when 1 then score += 70
      when 2 then score += 50
      when 3 then score += 30
      when 4 then score += 10
      end
    when 3  # Mover arriba
      score += @currentpos == 4 ? 40 : 20
    when 4  # Mejora condición
      score += 40
    when 5, 8, 16  # Asustar otros Pokémon
      case @currentpos
      when 4 then score += 80
      when 3 then score += 50
      when 2 then score += 20
      when 1 then score -= 30
      end
    when 6, 23  # Mejor más tarde
      case @currentpos
      when 4 then score += 80
      when 3 then score += 50
      when 2 then score += 20
      when 1 then score -= 20
      end
    when 7  # Asustar los que tienen atención
      4.times do |k|
        score += 40 if @hasattention[k] && k != pos_idx
      end
    when 9, 40  # Basado en corazones previos
      if @priorhearts && @priorhearts >= 3
        score += 70
      else
        score -= 10
      end
    when 10  # Fácil de asustar
      case @currentpos
      when 4 then score += 70
      when 3 then score += 50
      when 2 then score += 30
      when 1 then score -= 20
      end
    when 11, 26  # Mover abajo
      score += @currentpos == 4 ? -30 : 30
    when 12  # Asustar buenas exhibiciones
      4.times do |j|
        score += 30 if @priorhearts[j] && @priorhearts[j] > 3 && j != pos_idx
      end
    when 13  # Calmar público
      if @applause > 3
        score += 60  # Útil si hay mucho entusiasmo
      else
        score -= 20
      end
    when 14, 21  # Bonus por posición
      if function == 14 && @currentpos == 1
        score += 80
      elsif function == 21 && @currentpos == 4
        score += 80
      end
    when 15  # Puede usarse múltiples veces
      score += 50  # Bonus alto por flexibilidad
    when 17  # Poner nerviosos
      case @currentpos
      when 1 then score += 80
      when 2 then score += 60
      when 3 then score += 40
      when 4 then score += 20
      end
    when 18  # Sin más movimientos
      if @round == 5
        score += 100  # Excelente en última ronda
      else
        score -= 80  # Muy malo en otras rondas
      end
    when 19, 33, 41  # Basado en aplausos
      score += (@applause * 15)

    when 22, 32  # Quitar estrellas
      if @currentpos == 4 && @stars.max > 1
        max_star_idx = @stars.index(@stars.max)
        score += 60 if max_star_idx != pos_idx
      end
    when 24  # Revolver orden
      if @round < 5
        score += 50  # Útil en rondas tempranas
      else
        score -= 20  # Menos útil en ronda final
      end
    when 25  # Mismo tipo que último movimiento
      if @lastmoveType && type == @lastmoveType
        score += 60
      else
        score -= 10
      end
    when 27  # Doble siguiente turno
      if @round < 5
        score += 60  # Excelente para preparar
      else
        score -= 40  # Inútil en última ronda
      end
    when 29  # Mejor si anterior no fue bueno
      if @priorhearts && @priorhearts < 3
        score += 70
      else
        score -= 10
      end
    when 31  # Entusiasmar público
      score += 50
    when 34, 37  # Igual a exhibición anterior
      if @priorhearts
        score += (@priorhearts * 15)
      end
    when 35  # Igual a estrellas
      if @stars[pos_idx] > 0
        score += (@stars[pos_idx] * 20)
      else
        score -= 20
      end
    when 36  # Mismo tipo que concurso
      # Ya manejado fuera, pero bonus adicional
      score += 20 if type == @contestType
    when 38  # Mejor con menos aplausos
      case @applause
      when 0..1 then score += 70
      when 2 then score += 40
      when 3 then score += 10
      when 4..5 then score -= 30
      end
    when 39  # Mejor en rondas tardías
      score += (@round * 20)
    when 41  # No puede usar más movimientos
      if @round == 5
        score += 120  # EXCELENTE en última ronda (todo o nada)
      else
        score -= 1000  # TERRIBLE en cualquier otra ronda
      end
    when 42  # Intimida a todos pero pierde siguiente turno
      case @round
      when 5
        # Última ronda: intimidar a todos es EXCELENTE (no hay siguiente turno)
        score += 150
      when 4
        # Penúltima ronda: útil si está perdiendo
        if @currentpos == 1  # Si va primero, mejor
          score += 80
        else
          score += 40
        end
      else
        # Rondas tempranas: menos útil pero puede valer la pena
        if @currentpos == 1
          score += 30
        else
          score -= 20
        end
      end
    end
    return score
  end
  
  def evaluate_position_bonus(function, pos_idx)
    bonus = 0
    
    # Bonus general por posición (último es mejor)
    case pos_idx
    when 3 then bonus += 40  # Último
    when 2 then bonus += 20  # Tercero
    when 1 then bonus += 10  # Segundo
    when 0 then bonus += 0   # Primero
    end
    
    # Bonus específico para funciones de combo
    if [6, 21, 23, 29].include?(function)
      bonus += (pos_idx * 15)  # Mejor cuanto más tarde
    end
    
    return bonus
  end
  
  def evaluate_round_bonus(function, round)
    bonus = 0
    
    # Funciones que mejoran con el tiempo
    if [27, 39].include?(function)
      bonus += (round * 25)
    end
    
    # Funciones que son mejores al final
    if [18, 29].include?(function) && round == 5
      bonus += 100
    end
    
    return bonus
  end
  
  def select_smart_move(movescores, difficulty, pokemon)
    # Filtrar movimientos válidos
    valid_scores = movescores.compact
    return rand(movescores.length) if valid_scores.empty?
    
    max_score = valid_scores.max
    min_score = valid_scores.min
    
    best_idx = movescores.index(max_score)
    worst_idx = movescores.index(min_score)
    
    # Estadísticas para decisión inteligente
    stdev = pbStdDev(movescores)
    score_range = max_score - min_score
    
    # Si hay una opción claramente mejor, usarla
    if stdev >= 150 || (score_range >= 100 && rand(10) > 2)
      return best_idx
    end
    
    # Estrategia basada en dificultad
    case difficulty
    when 75..100  # Difícil - muy estratégico
      # En alta dificultad, prioriza combos y estrategia
      if stdev >= 80
        # Si hay una buena opción, 80% de usarla
        return best_idx if rand(10) > 2
      end
      
      # Eliminar opciones muy malas
      movescores.each_with_index do |score, idx|
        movescores[idx] = nil if score && score < (max_score * 0.6)
      end
      
    when 50..74  # Medio - balanceado
      # En dificultad media, balance entre estrategia y aleatoriedad
      if stdev >= 100
        # 70% de usar la mejor opción
        return best_idx if rand(10) > 3
      end
      
      # Eliminar la peor opción
      movescores[worst_idx] = nil if worst_idx
      
    when 25..49  # Fácil - más aleatorio
      # En dificultad baja, más aleatorio
      if stdev >= 120
        # 60% de usar la mejor opción
        return best_idx if rand(10) > 4
      end
      
    else  # Muy fácil - muy aleatorio
      # Solo 50% de usar la mejor opción incluso si es claramente mejor
      if stdev >= 150 && rand(10) > 5
        return best_idx
      end
    end
    
    # Seleccionar de las opciones disponibles
    available_indices = []
    movescores.each_with_index do |score, idx|
      available_indices << idx if score
    end
    
    return available_indices[rand(available_indices.length)] if available_indices.any?
    
    # Fallback
    rand(movescores.length)
  end
  
  def pbStdDev(scores) #from PokeBattle_AI
    n=0
    sum=0
    scores.each{|s| sum+=s; n+=1 }
    return 0 if n==0
    mean=sum.to_f/n.to_f
    varianceTimesN=0
    for i in 0...scores.length
      if scores[i]>0
        deviation=scores[i].to_f-mean
        varianceTimesN+=deviation*deviation
      end
    end
    # Using population standard deviation
    # [(n-1) makes it a sample std dev, would be 0 with only 1 sample]
    return Math.sqrt(varianceTimesN/n)
  end
  
# End of AI
###############################################################################
end