=begin
Script alternativo para regalos misteriosos, hecho por Clara

* Para usar el script: openMysteryGift
Cambia los links de github que hay como ejemplo y pon el tuyo.
Mira como se hacen tus propios regalos tomando de base en estos ultimos.

SOLO TESTEADO EN ESSENTIALS BES, GRACIAS AL SCRIPT DE WININET, si tienes una versión sin el script puedes encontrarlo en el siguiente link:
https://raw.githubusercontent.com/PokeLiberty/Essentials-BES/main/Data/Scripts/020_BES-T%20Scripts/005_BEST-T_Wininet.rb
=end

CODEGIFT   = "https://raw.githubusercontent.com/ClaraDragon/BES-Regalos-Misteriosos-Alternativos/main/Ejemplos/CodeMysteryGift.txt"
ONLINEGIFT = "https://raw.githubusercontent.com/ClaraDragon/BES-Regalos-Misteriosos-Alternativos/main/Ejemplos/OnlineMysteryGift.txt"

# GRAFICO DE LOS BOTONES, USA LOS DE LA TIENDA COMO PLACEHOLDER
SELECTIONGRAPHIC = "Graphics/Pictures/martSel"

class MysteryGiftScene
  
  Y_TOP= Graphics.height/3
  X_TEXT= 40
  CHECK_DIST = 48
  GIFTMUSIC="Mystery Gift"
  
  @graphicsWidth=Graphics.width
  @graphicsHeight=Graphics.height
  
  def update
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    @selected=0
    @previousBGM = $game_system.getPlayingBGM
    @useMusic=(GIFTMUSIC && GIFTMUSIC!="")
    pbMEStop()
    pbBGSStop()
    pbSEStop()
    if @useMusic
      pbBGMFade(2.0)
      pbBGMPlay(GIFTMUSIC)
    end
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    addBackgroundPlane(@sprites,"bg","mysteryGiftbg",@viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay = @sprites["overlay"].bitmap
    @sprites["overlay"].z=99999+1
    @overlay.clear
    pbSetSystemFont(@overlay)
    @text=[]
    @base   = Color.new(255,255,255)
    @shadow = Color.new(160,160,160)
    pbDrawTexts
    pbFadeInAndShow(@sprites) { update }
    @sprites["pokemon"]=PokemonSprite.new(@viewport)
    @sprites["pokemon"].opacity = 0
    @sprites["pokemon"].x = Graphics.width/3
    @sprites["pokemon"].y = Graphics.height/3
    
    #Cursor
    @sprites["rightarrow"]=AnimatedSprite.new("Graphics/Pictures/rightarrow",8,40,28,4,@viewport)
    @sprites["rightarrow"].x=Graphics.width/4 - 16
    @sprites["rightarrow"].y=Y_TOP+2
    @sprites["rightarrow"].play
    
  end
  
  def pbDrawTexts
    textpos=[["Regalo misterioso",Graphics.width/2,Y_TOP-CHECK_DIST,2,@base,@shadow]]
    imagepos=[]
      
    @text=[_INTL("Recibir vía Internet"),
           _INTL("Recibir vía Código"),
           _INTL("Salir")]
    #Crea opciones
    for i in 0...@text.length
      
      @sprites["button#{i}"] = Sprite.new(@viewport)
      @sprites["button#{i}"].bitmap = Bitmap.new("#{SELECTIONGRAPHIC}")
      @sprites["button#{i}"].x = Graphics.width/4 - 32
      @sprites["button#{i}"].y = Y_TOP+(i*CHECK_DIST)
      
      #imagepos.push(["Graphics/Pictures/selectionButton2",X_TEXT/2,Y_TOP+(i*CHECK_DIST),0,0,-1,-1])
      textpos.push([@text[i],Graphics.width/2,Y_TOP+(i*CHECK_DIST),2,@base,@shadow])
    end
        
    pbDrawImagePositions(@overlay,imagepos)
    pbDrawTextPositions(@overlay,textpos) 
  end

  #GENERA Y BORRA LA IMAGEN DEL POKEMON ENTREGADO
  def showHidePokemon(show=true)
    return false if !@pokemon
    if show
      @sprites["pokemon"].y = Graphics.height/3
      @sprites["pokemon"].y -= 255
      @sprites["pokemon"].setPokemonBitmap(@pokemon)
      32.times do
        @sprites["pokemon"].y += 7
        @sprites["pokemon"].opacity += 32
        pbWait(1)
      end
      @sprites["pokemon"].opacity = 255
    else
      @sprites["pokemon"].setPokemonBitmap(@pokemon)
      32.times do
        @sprites["pokemon"].y -= 7
        @sprites["pokemon"].opacity -= 32
        pbWait(1)
      end
      @sprites["pokemon"].opacity = 0
      @sprites["pokemon"].y = Graphics.height/3
    end
  end
  
  
  def showHideItems(show=true)
    if !show
      32.times do
        for i in 0...@text.length
          @sprites["button#{i}"].opacity += 32
        end
        @sprites["overlay"].opacity += 32
        @sprites["rightarrow"].opacity += 32
        pbWait(1)
      end
      @sprites["overlay"].opacity = 255
      @sprites["rightarrow"].opacity = 255
      for i in 0...@text.length
        @sprites["button#{i}"].opacity = 255
      end
    else
      32.times do
        for i in 0...@text.length
          @sprites["button#{i}"].opacity -= 32
        end
        @sprites["overlay"].opacity -= 32
        @sprites["rightarrow"].opacity -= 32
        pbWait(1)
      end
      @sprites["overlay"].opacity = 0
      @sprites["rightarrow"].opacity = 0
      for i in 0...@text.length
        @sprites["button#{i}"].opacity = 0
      end
    end
    Graphics.update
    Input.update
  end
    
  def pbMGCommands
    loop do
      Graphics.update
      Input.update
      self.update
      if Input.trigger?(Input::B)
        break
      elsif Input.trigger?(Input::C)
        pbSEPlay("Choose")
        if @selected == 0
          showHideItems
          begin
            response = Kernel.pbMessage(_INTL("Buscando regalos.\nEspere un momento...\\wtnp[0]"))
            eval(pbDownloadToString(ONLINEGIFT))
          rescue Exception
            Kernel.pbMessage("Parece que hubo algun error en la conexión.")
            Kernel.pbMessage("Comprueba que tengas internet y vuelve a intentarlo.")
          end
          showHideItems(false)
        elsif @selected == 1
          showHideItems
          begin
            response = Kernel.pbMessage(_INTL("Inserte el codigo..."))
            eval(pbDownloadToString(CODEGIFT))
          rescue Exception
            Kernel.pbMessage("Parece que hubo algun error en la conexión.")
            Kernel.pbMessage("Comprueba que tengas internet y vuelve a intentarlo.")
          end
          showHideItems(false)
        else #Si no se selecciona una de las anteriores
          break
        end
      elsif Input.trigger?(Input::UP)
        if @selected > 0
          @sprites["rightarrow"].y -= CHECK_DIST
          @selected-=1
        end
      elsif Input.trigger?(Input::DOWN)
        if @selected < @text.length-1
          @sprites["rightarrow"].y += CHECK_DIST
          @selected+=1
        end
      end
    end 
  end

  def pbEndScene
    pbMEStop()
    pbBGSStop()
    pbSEStop()
    if @useMusic
      pbBGMFade(2.0)
      pbBGMPlay(@previousBGM)
    end
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  
end

def openMysteryGift
  scene=MysteryGiftScene.new
  screen=MysteryGiftScreen.new(scene)
  pbFadeOutIn(99999) { 
    screen.pbStartScreen
  }
end

class MysteryGiftScreen
  def initialize(scene)
    @scene=scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbMGCommands
    @scene.pbEndScene
  end
end

#Esto comprueba que el jugador no tenga el pokémon en el equipo o en la caja, 
#para evitar usar interruptores. En su lugar, comprueba el OT y la Cinta del Pokémon.
def hasEventMon?(species,ribbon=nil,ot=nil)  
  ribbon = :EVENT if ribbon == nil
  hasmon = false
  for poke in $Trainer.party
    if ot
      if poke.species == species && poke.ot==ot && poke.hasRibbon?(ribbon)
        hasmon = true
      end
    else
      if poke.species == species && poke.hasRibbon?(ribbon)
        hasmon = true
      end
    end
  end
  pbEachPokemon{|poke,box|
  if ot
    if poke.species == species && poke.ot==ot && poke.hasRibbon?(ribbon)
      hasmon = true
    end
  else
    if poke.species == species && poke.hasRibbon?(ribbon)
      hasmon = true
    end
  end
  }
  
  return true if hasmon
  return false
end
