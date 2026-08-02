=begin
Script de Regalos Misteriosos Alternativos, hecho por Clara
(interfaz gráfica adaptada del script de Essentials BW de kleinstudio: http://kleinstudio.deviantart.com)

* Para usar el script: openMysteryGift
Cambia los links de github que hay como ejemplo y pon el tuyo.
Mira como se hacen tus propios regalos tomando de base en estos ultimos.

SOLO TESTEADO EN ESSENTIALS BES, GRACIAS AL SCRIPT DE WININET, si tienes una
versión sin el script puedes encontrarlo en el siguiente link:
https://raw.githubusercontent.com/PokeLiberty/Essentials-BES/main/Data/Scripts/020_BES-T%20Scripts/005_BEST-T_Wininet.rb

GRÁFICOS NECESARIOS (en Graphics/Pictures/MysteryGift/)
=end
CODEGIFT   = "https://raw.githubusercontent.com/ClaraDragon/PE-BES-Custom_Scripts/refs/heads/main/BES-Regalos-Misteriosos-Alternativos/Ejemplos/CodeMysteryGift.txt"
ONLINEGIFT = "https://raw.githubusercontent.com/ClaraDragon/PE-BES-Custom_Scripts/refs/heads/main/BES-Regalos-Misteriosos-Alternativos/Ejemplos/OnlineMysteryGift.txt"

def openMysteryGift
  scene  = MysteryGiftScene.new
  screen = MysteryGiftScreen.new(scene)
  pbFadeOutIn(99999) {
    screen.pbStartScreen
  }
end

class MysteryGiftScene

  GIFTMUSIC = "Mystery Gift"

  # Filas visibles en la lista scrolleable cuando hay varios regalos.
  LIST_ROWS_VISIBLE = 5
  LIST_ROW_HEIGHT   = 56

  def getBitmap(bitmap)
    return BitmapCache.load_bitmap(sprintf("Graphics/Pictures/MysteryGift/#{bitmap}"))
  end

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
    @sprites["bg"].y += 1
    @sprites["bg"].y = -16 if @sprites["bg"].y == 0
  end

  def pbStartScene
    @previousBGM = $game_system.getPlayingBGM
    @useMusic = (GIFTMUSIC && GIFTMUSIC != "")
    pbMEStop
    pbBGSStop
    pbSEStop
    if @useMusic
      pbBGMFade(2.0)
      pbBGMPlay(GIFTMUSIC)
    end

    @sprites = {}
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999

    @sprites["bg"]=IconSprite.new(0,0,@viewport)
    @sprites["bg"].setBitmap("Graphics/Pictures/MysteryGift/bg")
    @sprites["bg"].y = -16

    @sprites["menu"]=IconSprite.new(0,0,@viewport)
    @sprites["menu"].setBitmap("Graphics/Pictures/MysteryGift/menu")

    @sprites["menuarrow"] = Sprite.new(@viewport)
    @sprites["menuarrow"].bitmap = getBitmap("menuarrow")
    @sprites["menuarrow"].src_rect.height = @sprites["menuarrow"].bitmap.height / 2
    
    @sprites["command"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @base   = Color.new(255,255,255)
    @shadow = Color.new(165,165,173)

    @text = [_INTL("RECIBIR VÍA INTERNET"), _INTL("RECIBIR VÍA CÓDIGO"), _INTL("VER TARJETAS"), _INTL("SALIR")]
    
    @text.length.times do |i|
      sprite = Sprite.new(@viewport)
      sprite.bitmap = getBitmap("menuarrow_nsel")
      sprite.src_rect.height = sprite.bitmap.height / 2
      sprite.x = 64
      sprite.y = 24 + i*56
      sprite.z = @sprites["menuarrow"].z-1
      # Si es la última opción, usar la parte pequeña del gráfico
      if i == @text.length - 1
        sprite.src_rect.y = sprite.src_rect.height
      else
        sprite.src_rect.y = 0
      end
      
      @sprites["menuarrow_nsel_#{i}"] = sprite
      
    end
    
    
    @sel = 0
    @oldsel = -1
    drawMenuTexts
    movearrow

    pbFadeInAndShow(@sprites) { pbUpdate }
    PBDebug.log("[MysteryGift] Menú principal abierto") rescue nil
  end

  def movearrow
    y = 24 + @sel*56
    
    # Posicionar la flecha del cursor (opción seleccionada)
    @sprites["menuarrow"].x = 64
    @sprites["menuarrow"].y = y
    if @sel == @text.length-1
      @sprites["menuarrow"].src_rect.y = @sprites["menuarrow"].src_rect.height
    else
      @sprites["menuarrow"].src_rect.y = 0
    end
    
    # Actualizar visibilidad de los fondos NO seleccionados
    #@text.length.times do |i|
    #  # Ocultar el fondo de la opción seleccionada, mostrar el resto
    #  @sprites["menuarrow_nsel_#{i}"].visible = (i != @sel)
    #end
  end

  def drawMenuTexts
    overlay = @sprites["command"].bitmap
    overlay.clear
    pbSetSystemFont(overlay)
    commands = []
    for i in 0...@text.length
      commands.push([@text[i], 80, 34+i*56, false, @base, @shadow])
    end
    pbDrawTextPositions(overlay, commands)
  end

  def pbEndScene
    pbMEStop
    pbBGSStop
    pbSEStop
    if @useMusic
      pbBGMFade(2.0)
      pbBGMPlay(@previousBGM)
    end
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def pbMGCommands
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::B)
        break
      elsif Input.trigger?(Input::C)
        pbSEPlay("Choose")
        case @sel
        when 0
          Input.update
          pbReceiveGift(:online)
          
        when 1
          Input.update
          pbReceiveGift(:code)
          
        when 2
          Input.update
          pbShowMenu(false)
          pbShowWonderCardAlbum
          pbShowMenu(true)
        else
          break
        end
      elsif Input.trigger?(Input::UP)
        @sel -= 1
        @sel = @text.length-1 if @sel < 0
      elsif Input.trigger?(Input::DOWN)
        @sel += 1
        @sel = 0 if @sel >= @text.length
      end
      if @oldsel != @sel
        pbPlayCursorSE rescue pbSEPlay("Choose")
        movearrow
        @oldsel = @sel
      end
    end
  end

  def pbShowMenu(value)
    @sprites["menu"].visible      = value
    @sprites["menuarrow"].visible = value
    @sprites["command"].visible   = value
    @text.length.times do |i|
      # Ocultar el fondo de la opción seleccionada, mostrar el resto
      @sprites["menuarrow_nsel_#{i}"].visible = value
    end
  end

  #=============================================================================
  # Descarga y procesa el archivo de regalos elegido (Internet o Código). El
  # .txt solo tiene que rellenar el array `gifts` con MysteryGiftCard; todo lo
  # demás (comprobar duplicados, mostrar lista si hay varios, entregar) lo
  # hace pbProcessGiftsList (ver 000_MysteryGift_Data.rb).
  #=============================================================================
  def pbReceiveGift(method)
    pbShowMenu(false)
    url = (method == :online) ? ONLINEGIFT : CODEGIFT
    PBDebug.log("[MysteryGift] Recibiendo regalo por #{method} desde #{url}") rescue nil
    begin
      if method == :online
        Kernel.pbMessage(_INTL("Buscando regalos.\nEspere un momento...\\wtnp[0]"))
      end
      gifts = []
      eval(pbDownloadToString(url), binding)
      pbProcessGiftsList(gifts)
    rescue Exception => e
      PBDebug.log("[MysteryGift] Error al recibir regalo (#{method}): #{e.message}") rescue nil
      Kernel.pbMessage(_INTL("Parece que hubo algún error en la conexión."))
      Kernel.pbMessage(_INTL("Comprueba que tengas internet y vuelve a intentarlo."))
    end
    pbShowMenu(true)
  end


  
  #GENERA Y BORRA LA IMAGEN DEL POKEMON ENTREGADO (usado desde los .txt de
  #regalos vía showHidePokemon rescue nil)
  def showHidePokemon(show=true)
    return false if !@pokemon
    if show
      @sprites["pokemon"] = PokemonSprite.new(@viewport) if !@sprites["pokemon"]
      @sprites["pokemon"].opacity = 0
      @sprites["pokemon"].x = Graphics.width/3
      @sprites["pokemon"].y = Graphics.height/3 - 255
      @sprites["pokemon"].setPokemonBitmap(@pokemon)
      32.times do
        @sprites["pokemon"].y += 7
        @sprites["pokemon"].opacity += 32
        pbWait(1)
      end
      @sprites["pokemon"].opacity = 255
    else
      return false if !@sprites["pokemon"]
      @sprites["pokemon"].setPokemonBitmap(@pokemon)
      32.times do
        @sprites["pokemon"].y -= 7
        @sprites["pokemon"].opacity -= 32
        pbWait(1)
      end
      @sprites["pokemon"].opacity = 0
      @sprites["pokemon"].dispose
      @sprites.delete("pokemon")
    end
  end

  # GENERA Y BORRA LA IMAGEN DEL OBJETO ENTREGADO (usado desde los .txt de
  # regalos vía showHideItem rescue nil)
  def showHideItem(show=true)
    return false if !@item
    
    if show
      # Obtener el ID numérico del objeto
      item_id = 0
      if @item.is_a?(String)
        # Es una ruta de imagen personalizada
        @sprites["item"] = IconSprite.new(Graphics.width/2, Graphics.height/3 - 255, @viewport)
        @sprites["item"].setBitmap(@item)
        @sprites["item"].opacity = 0
        32.times do
          @sprites["item"].y += 10
          @sprites["item"].opacity += 32
          pbWait(1)
        end
        @sprites["item"].opacity = 255
        return true
      elsif @item.is_a?(Symbol)
        item_id = getConst(PBItems, @item)
      elsif @item.is_a?(Integer)
        item_id = @item
      else
        return false
      end
      
      # Crear el sprite del objeto
      @sprites["item"] = ItemIconSprite.new(Graphics.width/2, Graphics.height/3 - 255, item_id, @viewport)
      @sprites["item"].opacity = 0
      
      # Animación de entrada
      32.times do
        @sprites["item"].y += 10
        @sprites["item"].opacity += 32
        pbWait(1)
      end
      @sprites["item"].opacity = 255
      
    else
      # Ocultar el objeto
      return false if !@sprites["item"]
      
      # Animación de salida
      32.times do
        @sprites["item"].y -= 10
        @sprites["item"].opacity -= 32
        pbWait(1)
      end
      @sprites["item"].opacity = 0
      @sprites["item"].dispose
      @sprites.delete("item")
    end
  end

  def pbChooseGiftFromList(gifts)
    listViewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    listViewport.z = 99999+10
    listSprites = {}
    
    listSprites["menu"]=IconSprite.new(0,0,@viewport)
    listSprites["menu"].setBitmap("Graphics/Pictures/MysteryGift/menu_2")
    
    # Flechas animadas para indicar desplazamiento
    listSprites["uparrow"] = AnimatedSprite.new("Graphics/Pictures/uparrow",8,28,40,2,listViewport)
    listSprites["uparrow"].x = Graphics.width/2 - 8
    listSprites["uparrow"].y = 48
    listSprites["uparrow"].play
    listSprites["uparrow"].visible = false
    
    listSprites["downarrow"] = AnimatedSprite.new("Graphics/Pictures/downarrow",8,28,40,2,listViewport)
    listSprites["downarrow"].x = Graphics.width/2 - 8
    listSprites["downarrow"].y = 300
    listSprites["downarrow"].play
    listSprites["downarrow"].visible = false
    
    # Menuarrow para selección (el que ya tenías)
    listSprites["menuarrow"] = Sprite.new(listViewport)
    listSprites["menuarrow"].bitmap = getBitmap("menuarrow")
    listSprites["menuarrow"].src_rect.height = listSprites["menuarrow"].bitmap.height/2
    
    listSprites["overlay"] = BitmapSprite.new(Graphics.width,Graphics.height,listViewport)
    listOverlay = listSprites["overlay"].bitmap
    pbSetSystemFont(listOverlay)
  
    top = 64
    left = 96
    selected = 0
    scroll = 0
  
    refreshList = Proc.new {
      listOverlay.clear
      for key in listSprites.keys.select { |k| k.to_s.start_with?("icon") }
        listSprites[key].dispose if !listSprites[key].disposed?
        listSprites.delete(key)
      end
    for key in listSprites.keys.select { |k| k.to_s.start_with?("arrow") }
      listSprites[key].dispose if !listSprites[key].disposed?
      listSprites.delete(key)
    end
      
      textpos = [
        #[_INTL("Elige un regalo"), Graphics.width/2, 20, 2, @base, @shadow]
      ]
      for i in 0...LIST_ROWS_VISIBLE
        idx = scroll+i
        break if idx>=gifts.length
        y = top + i*LIST_ROW_HEIGHT
        textpos.push([gifts[idx].title, left+40, y, 0, @base, @shadow])
        
        # Crear el icono del regalo
        icon = Sprite.new(listViewport)
        icon.bitmap = pbGetGiftIconBitmap(gifts[idx].icon, gifts[idx].icon_type)
        # Ajustar posición Y según el tipo de icono
        if gifts[idx].icon_type == :item || gifts[idx].icon_type == :string
          # Objetos e imágenes personalizadas: posición normal
          icon.y = y - 8
          icon.x = left - 16
        else
          # Pokémon: mover más arriba
          icon.y = y - 24
          icon.x = left - 24
        end
        
        listSprites["icon#{i}"] = icon
      # Crear flecha para CADA opción visible
      arrow = Sprite.new(listViewport)
      arrow.bitmap = getBitmap("menuarrow_nsel")
      arrow.src_rect.height = arrow.bitmap.height/2
      arrow.x = left - 32
      arrow.y = y - 8
      arrow.z = listSprites["menuarrow"].z-1
      # Las flechas no seleccionadas se ven más tenues
      listSprites["arrow#{i}"] = arrow
      end
      
      if gifts.length > LIST_ROWS_VISIBLE
        # Mostrar flechas animadas si hay más regalos de los que caben
        listSprites["uparrow"].visible = (scroll > 0)
        listSprites["downarrow"].visible = (scroll < gifts.length - LIST_ROWS_VISIBLE)
      else
        listSprites["uparrow"].visible = false
        listSprites["downarrow"].visible = false
      end
      
      pbDrawTextPositions(listOverlay, textpos)
      
    # Actualizar la flecha seleccionada para que sea más brillante
      row = selected-scroll
      if listSprites["arrow#{row}"]
        listSprites["arrow#{row}"].opacity = 255  # Flecha seleccionada con opacidad completa
      end
    
    # Mantener el menuarrow por compatibilidad (opcional)
      listSprites["menuarrow"].x = left - 32
      listSprites["menuarrow"].y = top + row*LIST_ROW_HEIGHT - 8
      listSprites["menuarrow"].src_rect.y = 0
    }
    refreshList.call
  
    result = -1
    loop do
      Graphics.update
      Input.update
      pbUpdate
      pbUpdateSpriteHash(listSprites)
      
      # Actualizar las animaciones de las flechas
      listSprites["uparrow"].update if listSprites["uparrow"] && !listSprites["uparrow"].disposed?
      listSprites["downarrow"].update if listSprites["downarrow"] && !listSprites["downarrow"].disposed?
      
      if Input.trigger?(Input::B)
        result = -1
        Input.update
        break
      elsif Input.trigger?(Input::C)
        pbSEPlay("Choose")
        result = selected
        Input.update
        break
      elsif Input.trigger?(Input::UP)
        if selected>0
          selected -= 1
          scroll -= 1 if selected<scroll
          refreshList.call
        end
      elsif Input.trigger?(Input::DOWN)
        if selected < gifts.length-1
          selected += 1
          scroll += 1 if selected >= scroll+LIST_ROWS_VISIBLE
          refreshList.call
        end
      end
    end
    pbDisposeSpriteHash(listSprites)
    listViewport.dispose
    return result
  end

end

class MysteryGiftScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbMGCommands
    @scene.pbEndScene
  end
end


class CardAlbumScene
  CARDS_PER_PAGE = 4   # cuadrícula 2x2

  def initialize(cards)
    # cards: array de [id, datos] (datos = {:title,:icon,:description,:date})
    # ya viene ordenado por fecha desde pbShowWonderCardAlbum.
    @cards = cards
    @maxPages = (@cards.length.to_f / CARDS_PER_PAGE).ceil
    @maxPages = 1 if @maxPages < 1
  end

  # SIEMPRE devuelve una copia independiente (.clone) del bitmap cacheado,
  # para poder dibujar encima (iconos, texto) sin afectar a otros sprites
  # que también usen el mismo gráfico base.
  def getBitmap(bitmap)
    return BitmapCache.load_bitmap(sprintf("Graphics/Pictures/MysteryGift/#{bitmap}")).clone
  end

  def update
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    PBDebug.log("[MysteryGift] Álbum de tarjetas abierto (#{@cards.length} tarjeta(s), #{@maxPages} página(s))") rescue nil
    @sprites = {}
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999

    @sel  = 0   # 0..3 = tarjetas de la página actual, 4 = botón "volver"
    @page = 0   # basado en 0 internamente (se muestra +1)

    # Un único fondo de álbum, estático (sin animación de scroll entre páginas)
    @sprites["albumbg"]=IconSprite.new(0,0,@viewport)
    @sprites["albumbg"].setBitmap("Graphics/Pictures/MysteryGift/album_bg")

    @sprites["arrows"]=IconSprite.new(0,0,@viewport)
    @sprites["arrows"].setBitmap("Graphics/Pictures/MysteryGift/album_arrows")

    # Ajusta esta posición según el tamaño real de tu gráfico album_arrows.
    @sprites["arrows"].x = 0
    @sprites["arrows"].y = 0

    @sprites["cancel"]=IconSprite.new(0,0,@viewport)
    @sprites["cancel"].setBitmap("Graphics/Pictures/MysteryGift/album_cancel")
    @sprites["cancel"].src_rect.height = @sprites["cancel"].bitmap.height/2
    @sprites["cancel"].x = Graphics.width-156
    @sprites["cancel"].y = Graphics.height-70

    @sprites["pageinfo"]=IconSprite.new(0,0,@viewport)
    @sprites["pageinfo"].setBitmap("Graphics/Pictures/MysteryGift/album_info")
    @sprites["pageinfo"].y = Graphics.height - @sprites["pageinfo"].bitmap.height
    @sprites["pageinfo"].z=@sprites["albumbg"].z+1
    
    @sprites["cursor"]=IconSprite.new(0,0,@viewport)
    @sprites["cursor"].setBitmap("Graphics/Pictures/MysteryGift/album_cursor")

    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @base   = Color.new(255,255,255)
    @shadow = Color.new(165,165,173)

    @sprites["helpwindow"] = Window_UnformattedTextPokemon.new("")
    @sprites["helpwindow"].visible = false
    @sprites["helpwindow"].viewport = @viewport
    pbBottomLeftLines(@sprites["helpwindow"],1)

    pbRefreshPage
    pbFadeInAndShow(@sprites) { update }
  end

  def pbEndScene
    PBDebug.log("[MysteryGift] Álbum de tarjetas cerrado") rescue nil
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def pbCardIndexAt(slot)
    return @page*CARDS_PER_PAGE + slot
  end

  def cardSlotX(slot)
    return (slot%2==0) ? 12 : 252
  end

  def cardSlotY(slot)
    return (slot<2) ? 58 : 186
  end

  def pbRefreshPage
    for key in @sprites.keys.select { |k| k.to_s.start_with?("card") }
      @sprites[key].dispose if !@sprites[key].disposed?
      @sprites.delete(key)
    end
    for slot in 0...CARDS_PER_PAGE
      idx = pbCardIndexAt(slot)
      next if idx >= @cards.length
      data = @cards[idx][1]
      spr = Sprite.new(@viewport)
      spr.bitmap = getBitmap("album_cards")
      spr.x = cardSlotX(slot)
      spr.y = cardSlotY(slot)
      cb = spr.bitmap
      pbSetSystemFont(cb)
      # Icono del regalo
      icon = pbGetGiftIconBitmap(data[:icon], data[:icon_type])
      if data[:icon_type] == :item || data[:icon_type] == :string
        # Objetos e imágenes personalizadas: posición normal
        pbCopyBitmap(cb, icon, cb.width-icon.width-32, 16)
      else
        # Pokémon: mover más arriba
        pbCopyBitmap(cb, icon, cb.width-icon.width-32, 0)
      end
      
      # Número de la tarjeta, dibujado por script (no viene en el gráfico)
      pbDrawTextPositions(cb, [
        [(idx+1).to_s, 20, 8, 2, Color.new(57,189,198), Color.new(8,140,148)]
      ])
      # Fecha recibida
      time = data[:date]
      dateStr = (time.respond_to?(:strftime)) ? _INTL("{1}/{2}/{3}",time.day,time.month,time.year) : time.to_s
      pbDrawTextPositions(cb, [
        [dateStr, 132, cb.height - 52, 2, Color.new(88,88,80), Color.new(168,184,184)]
      ])
      @sprites["card#{slot}"] = spr
    end
    writePageInfo
    writeOverlayInfo
    cursorPosition
  end

  def writePageInfo
    pbSetSystemFont(@sprites["pageinfo"].bitmap)
    pbDrawTextPositions(@sprites["pageinfo"].bitmap, [
      [_INTL("{1}/{2}", @page+1, @maxPages), 96, 12, false, @base, @shadow]
    ])
  end

  def writeOverlayInfo
    @sprites["overlay"].bitmap.clear
    pbDrawTextPositions(@sprites["overlay"].bitmap, [
      [_INTL("ÁLBUM DE TARJETAS"), Graphics.width/2, 18, 2, @base, @shadow],
      [_INTL("SALIR"), 424, 320, 2, @base, @shadow]
    ])
  end

  def cursorPosition
    if @sel == CARDS_PER_PAGE
      @sprites["cursor"].visible = false
      @sprites["cancel"].src_rect.y = @sprites["cancel"].bitmap.height/2
    else
      @sprites["cursor"].visible = true
      @sprites["cursor"].x = cardSlotX(@sel)
      @sprites["cursor"].y = cardSlotY(@sel)
      @sprites["cancel"].src_rect.y = 0
    end
  end

  def pbMainLoop
    loop do
      Graphics.update
      Input.update
      update
      oldsel = @sel

      if Input.trigger?(Input::LEFT)
        pbPlayCursorSE rescue pbSEPlay("Choose")
        if @sel==1 || @sel==3
          @sel -= 1
        elsif @sel==0 || @sel==2
          pbChangePage(-1)
        end
      elsif Input.trigger?(Input::RIGHT)
        pbPlayCursorSE rescue pbSEPlay("Choose")
        if @sel==0 || @sel==2
          @sel += 1
        elsif @sel==1 || @sel==3
          pbChangePage(1)
        end
      elsif Input.trigger?(Input::UP)
        pbPlayCursorSE rescue pbSEPlay("Choose")
        if @sel==2 || @sel==3
          @sel -= 2
        elsif @sel==CARDS_PER_PAGE
          @sel = 2
        end
      elsif Input.trigger?(Input::DOWN)
        pbPlayCursorSE rescue pbSEPlay("Choose")
        if @sel==0 || @sel==1
          @sel += 2
        else
          @sel = CARDS_PER_PAGE
        end
      elsif Input.trigger?(Input::C)
        if @sel==CARDS_PER_PAGE
          break
        else
          pbCardCommand
        end
      elsif Input.trigger?(Input::B)
        break
      end

      if oldsel != @sel
        cursorPosition
      end
    end
  end

  def pbChangePage(direction)
    idx = pbCardIndexAt(@sel)
    @page = (@page + direction) % @maxPages
    PBDebug.log("[MysteryGift] Álbum: cambiando a página #{@page+1}/#{@maxPages}") rescue nil
    pbRefreshPage
  end

  # Al pulsar C sobre una tarjeta: ofrece Ver datos / Eliminar / Volver.
  def pbCardCommand
    idx = pbCardIndexAt(@sel)
    return if idx >= @cards.length
    data = @cards[idx][1]
    command = pbShowCommandsAlbum(_INTL("¿Qué quieres hacer con esta tarjeta?"),
      [_INTL("Ver datos"),_INTL("Eliminar"), _INTL("Volver")])
    if command == 0
      detailScene  = WonderCardDetailScene.new(data)
      detailScreen = WonderCardDetailScreen.new(detailScene)
      detailScreen.pbStartScreen
    elsif command == 1 # Eliminar
      if Kernel.pbConfirmMessageSystem(1,false,_INTL("¿Seguro que quieres eliminar esta tarjeta?")) { update }
        id = @cards[idx][0]
        PBDebug.log("[MysteryGift] Álbum: eliminando tarjeta #{id}") rescue nil
        $PokemonGlobal.mysteryGiftsReceived.delete(id)
        @cards.delete_at(idx)
        @maxPages = (@cards.length.to_f / CARDS_PER_PAGE).ceil
        @maxPages = 1 if @maxPages < 1
        @page = 0 if @page >= @maxPages
        @sel = 0 if pbCardIndexAt(@sel) >= @cards.length && @sel > 0
        pbRefreshPage
      end
    end
  end

  def pbShowCommandsAlbum(helptext, commands)
    ret = -1
    oldvisible = @sprites["helpwindow"].visible
    @sprites["helpwindow"].visible = helptext ? true : false
    @sprites["helpwindow"].letterbyletter = false
    @sprites["helpwindow"].text = helptext ? helptext : ""
    cmdwindow = Window_CommandPokemon.new(commands)
    cmdwindow.viewport = @viewport
    @sprites["helpwindow"].x = 4
    @sprites["helpwindow"].width = Graphics.width-12
    @sprites["helpwindow"].height = 64
    @sprites["helpwindow"].y = Graphics.height - @sprites["helpwindow"].height
    cmdwindow.y = @sprites["helpwindow"].y - cmdwindow.height
    cmdwindow.x = Graphics.width - cmdwindow.width - 8
    loop do
      Graphics.update
      Input.update
      cmdwindow.update
      if Input.trigger?(Input::C)
        ret = cmdwindow.index
        Input.update
        break
      elsif Input.trigger?(Input::B)
        Input.update
        break
      end
    end
    @sprites["helpwindow"].visible = oldvisible
    cmdwindow.dispose
    return ret
  end
end

class WonderCardDetailScene
  WC_HEADER_X    = 95    # "Wonder Card" (cabecera)
  WC_HEADER_Y    = 42
  WC_TITLE_X     = 36    # título del regalo (caja verde superior)
  WC_TITLE_Y     = 96
  WC_DESC_X      = 36    # descripción (caja verde grande central)
  WC_DESC_Y      = 144
  WC_DESC_W      = 400   # ancho máximo del texto de descripción
  WC_DATELABEL_X = 68    # "Fecha recibida"
  WC_DATELABEL_Y = 320
  WC_DATEVALUE_X = 280   # valor de la fecha
  WC_DATEVALUE_Y = 320
  WC_ICON_X      = 430   # icono del regalo (círculo superior derecho)
  WC_ICON_Y      = 76

  # data: hash con :title, :icon, :description, :date de la tarjeta elegida
  def initialize(data)
    @data = data
  end

  def update
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    @sprites = {}
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999+50   # por encima del álbum, que usa z=99999

    @base   = Color.new(255,255,255)
    @shadow = Color.new(165,165,173)

    @sprites["wc"]=IconSprite.new(0,0,@viewport)
    @sprites["wc"].setBitmap("Graphics/Pictures/MysteryGift/wondercard")
    @sprites["wc"].x = (Graphics.width  - @sprites["wc"].bitmap.width)  / 2
    @sprites["wc"].y = (Graphics.height - @sprites["wc"].bitmap.height) / 2
    pbSetWonderCardText(@sprites["wc"].bitmap, @data)

    pbFadeInAndShow(@sprites) { update }
  end

  def pbSetWonderCardText(bitmap, data)
    pbSetSystemFont(bitmap)
    time = data[:date]
    dateStr = (time.respond_to?(:strftime)) ? _INTL("{1}/{2}/{3}",time.day,time.month,time.year) : time.to_s

    texts = [
      [_INTL("Tarjeta Misteriosa"), WC_HEADER_X, WC_HEADER_Y, false, @base, @shadow],
      [data[:title], WC_TITLE_X, WC_TITLE_Y, false, Color.new(88,88,80), Color.new(168,184,184)],
      [_INTL("Fecha recibida"), WC_DATELABEL_X, WC_DATELABEL_Y, false, @base, @shadow],
      [dateStr, WC_DATEVALUE_X, WC_DATEVALUE_Y, false, @base, @shadow]
    ]
    pbDrawTextPositions(bitmap, texts)

    drawTextEx(bitmap, WC_DESC_X, WC_DESC_Y, WC_DESC_W, 6, data[:description], Color.new(88,88,80), Color.new(168,184,184))

    icon = pbGetGiftIconBitmap(data[:icon], data[:icon_type])
    pbCopyBitmap(bitmap, icon, WC_ICON_X - icon.width/2, WC_ICON_Y - icon.height)
  end

  def pbMainLoop
    loop do
      Graphics.update
      Input.update
      update
      if Input.trigger?(Input::B) || Input.trigger?(Input::C)
        pbSEPlay("Choose") rescue nil
        Input.update
        break
      end
    end
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end


class WonderCardReceivedDetails
  WC_TITLE_X     = 64    # título del regalo (caja verde superior)
  WC_TITLE_Y     = 40
  WC_DESC_X      = 64    # descripción (caja verde grande central)
  WC_DESC_Y      = 112
  WC_DESC_W      = 384   # ancho máximo del texto de descripción

  # data: hash con :title, :icon, :description, :date de la tarjeta elegida
  def initialize(data)
    @data = data
  end

  def update
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    @sprites = {}
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999+50   # por encima del álbum, que usa z=99999

    @base   = Color.new(255,255,255)
    @shadow = Color.new(165,165,173)
    @sprites["wc"]=IconSprite.new(0,0,@viewport)
    @sprites["wc"].setBitmap("Graphics/Pictures/MysteryGift/receiveInfo")
    @sprites["wc"].x = (Graphics.width  - @sprites["wc"].bitmap.width)  / 2
    @sprites["wc"].y = (Graphics.height - @sprites["wc"].bitmap.height) / 2
    pbSetWonderCardText(@sprites["wc"].bitmap, @data)

    pbFadeInAndShow(@sprites) { update }
  end

  def pbSetWonderCardText(bitmap, data)
    pbSetSystemFont(bitmap)
    time = data[:date]
    texts = [
      [data[:title], WC_TITLE_X, WC_TITLE_Y, false, @base, @shadow],
    ]
    pbDrawTextPositions(bitmap, texts)
    drawTextEx(bitmap, WC_DESC_X, WC_DESC_Y, WC_DESC_W, 6, data[:description], @base, @shadow)
  end

  def pbMainLoop
    loop do
      Graphics.update
      Input.update
      update
      if Input.trigger?(Input::B) || Input.trigger?(Input::C)
        pbSEPlay("Choose") rescue nil
        Input.update
        break
      end
    end
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

class WonderCardDetailScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbMainLoop
    @scene.pbEndScene
  end
end

class CardAlbumScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbMainLoop
    @scene.pbEndScene
  end
end

def pbShowWonderCardAlbum
  cards = $PokemonGlobal.mysteryGiftsReceived.sort_by { |id,data| data[:date] || Time.now }
  if cards.empty?
    Kernel.pbMessage(_INTL("Todavía no has recibido ningún Regalo Misterioso."))
    return
  end
  scene = CardAlbumScene.new(cards)
  screen = CardAlbumScreen.new(scene)
  pbFadeOutIn(99999) {
    screen.pbStartScreen
  }
end


#===============================================================================
# Guardamos los regalos en la partida en lugar de checks raros
#===============================================================================
class PokemonGlobalMetadata
  # Hash de regalos recibidos:
  #   { :id_regalo => { :title=>.., :icon=>.., :description=>.., :date=>.. } }
  def mysteryGiftsReceived
    @mysteryGiftsReceived = {} if !@mysteryGiftsReceived
    return @mysteryGiftsReceived
  end

  def mysteryGiftsReceived=(value)
    @mysteryGiftsReceived = value
  end
end

#===============================================================================
def pbProcessGiftsList(gifts)
  PBDebug.log("[MysteryGift] pbProcessGiftsList: #{gifts ? gifts.length : 0} regalo(s) definidos en el archivo descargado") rescue nil
  if !gifts || gifts.empty?
    Kernel.pbMessage(_INTL("No se ha encontrado ningún Regalo Misterioso.\\wtnp[20]"))
    return
  end
  available = gifts.reject { |g| g.alreadyReceived? }
  PBDebug.log("[MysteryGift] #{available.length} de #{gifts.length} regalo(s) todavía no recibidos") rescue nil
  if available.empty?
    Kernel.pbMessage(_INTL("Ya has recibido todos los Regalos Misteriosos disponibles.\\wtnp[20]"))
    return
  end
  if available.length == 1
    pbDeliverGift(available[0])
    return
  end
  loop do
    available = available.reject { |g| g.alreadyReceived? }
    break if available.empty?
    idx = pbChooseGiftFromList(available)
    break if idx.nil? || idx < 0
    pbDeliverGift(available[idx])
  end
end

def pbDeliverGift(card)
  card.give
  PBDebug.log("[MysteryGift] ¡Has recibido #{card.title}!") rescue nil
  cardData = $PokemonGlobal.mysteryGiftsReceived[card.id]
  # Actualizar gráficos después de la entrega
  begin
  if sprites
    for key in sprites.keys
      sprites[key].update if sprites[key].respond_to?(:update)
    end
  end
  Graphics.update
  rescue Exception => e
    PBDebug.log("[MysteryGift] Backtrace: #{e.backtrace.join("\n")}") rescue nil
  end
  detailScene  = WonderCardReceivedDetails.new(cardData)
  detailScreen = WonderCardDetailScreen.new(detailScene)
  detailScreen.pbStartScreen
end

#===============================================================================
class MysteryGiftCard
  attr_reader :id, :title, :icon, :icon_type, :description

  def initialize(id, title, icon, description, &block)
    @id          = id
    @title       = title
    @description = description
    @giveBlock   = block
    
    # Si icon es un array [icono, tipo], extraer ambos
    if icon.is_a?(Array) && icon.length == 2
      @icon      = icon[0]
      @icon_type = icon[1]
    else
      @icon      = icon
      @icon_type = nil  # Auto-detección
    end
    # Debug
    PBDebug.log("[MysteryGift] Creando regalo: #{@id}, icon: #{@icon.inspect}, icon_type: #{@icon_type.inspect}") rescue nil
  end

  # ¿Ya se ha recibido este regalo en esta partida?
  def alreadyReceived?
    return $PokemonGlobal.mysteryGiftsReceived.key?(@id)
  end

  # Ejecuta el bloque de entrega (crea el Pokémon/objeto) y marca el regalo
  # como recibido para que no se pueda volver a recoger en esta partida.
  def give
    PBDebug.log("[MysteryGift] Entregando regalo #{@id} (#{@title})") rescue nil
    @giveBlock.call if @giveBlock
    $PokemonGlobal.mysteryGiftsReceived[@id] = {
      :title       => @title,
      :icon        => @icon,
      :icon_type   => @icon_type,
      :description => @description,
      :date        => Time.now
    }
    PBDebug.log("[MysteryGift] #{@id} guardado como recibido (total guardados: #{$PokemonGlobal.mysteryGiftsReceived.length})") rescue nil
  end
end

#===============================================================================
def pbGetGiftIconBitmap(icon, icon_type = nil)
  bitmap = nil
  tempViewport = nil
  spr = nil
  
  begin
    # Si icon es un array [valor, tipo]
    if icon.is_a?(Array) && icon.length == 2
      icon_value = icon[0]
      icon_type = icon[1] if icon_type.nil?
    else
      icon_value = icon
    end
    
    # Si icon_type es nil, intentar auto-detección
    if icon_type.nil?
      # Auto-detección (comportamiento original)
      if icon_value.is_a?(String)
        bitmap = AnimatedBitmap.new(icon_value).bitmap
        
      elsif icon_value.is_a?(PokeBattle_Pokemon)
        tempViewport = Viewport.new(0, 0, 64, 64)
        spr = PokemonIconSprite.new(icon_value, tempViewport)
        rect = spr.src_rect
        bitmap = Bitmap.new(rect.width, rect.height)
        bitmap.blt(0, 0, spr.bitmap, rect)
        
      elsif icon_value.is_a?(Symbol)
        # Intentar como Pokémon primero
        if isConst?(icon_value, PBSpecies, icon_value)
          species = getConst(PBSpecies, icon_value)
          if species
            pkmn = PokeBattle_Pokemon.new(species, 1)
            tempViewport = Viewport.new(0, 0, 64, 64)
            spr = PokemonIconSprite.new(pkmn, tempViewport)
            rect = spr.src_rect
            bitmap = Bitmap.new(rect.width, rect.height)
            bitmap.blt(0, 0, spr.bitmap, rect)
          end
        # Si no es Pokémon, intentar como objeto
        elsif isConst?(icon_value, PBItems, icon_value)
          item = getConst(PBItems, icon_value)
          if item
            tempViewport = Viewport.new(0, 0, 64, 64)
            spr = ItemIconSprite.new(0, 0, item, tempViewport)
            rect = spr.src_rect
            bitmap = Bitmap.new(rect.width, rect.height)
            bitmap.blt(0, 0, spr.bitmap, rect)
          end
        end
        
      elsif icon_value.is_a?(Integer)
        # Por defecto, interpretar como especie de Pokémon
        pkmn = PokeBattle_Pokemon.new(icon_value, 1)
        tempViewport = Viewport.new(0, 0, 64, 64)
        spr = PokemonIconSprite.new(pkmn, tempViewport)
        rect = spr.src_rect
        bitmap = Bitmap.new(rect.width, rect.height)
        bitmap.blt(0, 0, spr.bitmap, rect)
      end
      
    else
      # Usar el tipo especificado
      case icon_type.to_sym
      when :pokemon
        # Interpretar como especie de Pokémon
        if icon_value.is_a?(Symbol)
          species = getConst(PBSpecies, icon_value)
        elsif icon_value.is_a?(Integer)
          species = icon_value
        elsif icon_value.is_a?(String)
          species = getConst(PBSpecies, icon_value.to_sym) rescue nil
        else
          species = nil
        end
        
        if species
          pkmn = PokeBattle_Pokemon.new(species, 1)
          tempViewport = Viewport.new(0, 0, 64, 64)
          spr = PokemonIconSprite.new(pkmn, tempViewport)
          rect = spr.src_rect
          bitmap = Bitmap.new(rect.width, rect.height)
          bitmap.blt(0, 0, spr.bitmap, rect)
        end
        
      when :item
        # Interpretar como objeto
        item = nil
        # Si es un número, usarlo directamente como ID de objeto
        if icon_value.is_a?(Integer)
          item = icon_value
        # Si es un símbolo, buscar la constante
        elsif icon_value.is_a?(Symbol)
          item = getConst(PBItems, icon_value)
        # Si es un string, convertirlo a símbolo y buscar
        elsif icon_value.is_a?(String)
          item = getConst(PBItems, icon_value.to_sym) rescue nil
        end
        if item
          tempViewport = Viewport.new(0, 0, 64, 64)
          spr = ItemIconSprite.new(0, 0, item, tempViewport)
          rect = spr.src_rect
          bitmap = Bitmap.new(rect.width, rect.height)
          bitmap.blt(0, 0, spr.bitmap, rect)
        else
          PBDebug.log("[MysteryGift] No se pudo encontrar el objeto para icon: #{icon_value.inspect}") rescue nil
        end
      when :string
        # Interpretar como ruta de archivo
        if icon_value.is_a?(String)
          bitmap = AnimatedBitmap.new(icon_value).bitmap
        end
      end
    end
  rescue Exception => e
    PBDebug.log("[MysteryGift] Error cargando icono para #{icon.inspect} (tipo: #{icon_type}): #{e.message}") rescue nil
    PBDebug.log("[MysteryGift] Backtrace: #{e.backtrace.join("\n")}") rescue nil
    bitmap = nil
  ensure
    spr.dispose if spr && !spr.disposed?
    tempViewport.dispose if tempViewport && !tempViewport.disposed?
  end
  bitmap = Bitmap.new(64, 64) if !bitmap
  return bitmap
end

#Esto comprueba que el jugador no tenga el pokémon en el equipo o en la caja, 
#para evitar usar interruptores. En su lugar, comprueba el OT y la Cinta del Pokémon.
# NOTA: se mantiene por compatibilidad, pero ya NO hace falta usarlo para comprobar 
# si un regalo ha sido recibido.
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