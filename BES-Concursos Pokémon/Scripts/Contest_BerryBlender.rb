#===============================================================================
# BERRY BLENDER (Estilo ORAS) - UI con 3 botones en pantalla principal
# Para Pokémon Essentials v16 - Ruby 1.8
#
# USO desde evento: pbBerryBlender
#
# GRÁFICOS en Graphics/Pictures/Contest/BerryBlender/:
#   background.png        <- fondo pantalla principal
#   bg_select.png         <- fondo selector de bayas
#   blender_open.png      <- licuadora abierta
#   Berry_Circle.png      <- círculo vacío para slots (64x64)
#
#  BOTONES PRINCIPALES - 3 botones × 3 estados = 9 imágenes (cada una: BTN_W × BTN_H)
#   btn_add.png           btn_add_sel.png       btn_add_off.png
#   btn_remove.png        btn_remove_sel.png    btn_remove_off.png
#   btn_blend.png         btn_blend_sel.png     btn_blend_off.png
#
#  BOTONES DEL SELECTOR - 2 imágenes
#   sel_btn_ok.png        <- botón "A: Seleccionar"  (SEL_BTN_W × SEL_BTN_H)
#   sel_btn_cancel.png    <- botón "B: Cancelar"     (SEL_BTN_W × SEL_BTN_H)
#===============================================================================

module BlenderConfig
  SCREEN_W           = 512
  SCREEN_H           = 384

  #--- Licuadora ---
  BLENDER_X          = 160
  BLENDER_Y          = 0
  BLENDER_ANIM_FRAMES = 16

  #--- Slots de baya (pantalla principal) ---
  SLOT_COUNT         = 4
  SLOT_SIZE          = 80
  SLOT_START_X       = (SCREEN_W - SLOT_COUNT * SLOT_SIZE) / 2 + SLOT_SIZE / 2
  SLOT_START_Y       = 220
  SLOT_RADIUS        = 32

  #--- Grid del selector ---
  GRID_COLS          = 8
  GRID_CELL_W        = 60
  GRID_CELL_H        = 60
  GRID_START_X       = (SCREEN_W - GRID_COLS * GRID_CELL_W) / 2
  GRID_START_Y       = 56
  GRID_ICON_OFF      = (GRID_CELL_W - 32) / 2
  GRID_QTY_OFF_Y     = 40
  GRID_VISIBLE_ROWS  = 4
  GRID_VIEWPORT_H    = GRID_VISIBLE_ROWS * GRID_CELL_H

  #--- Scrollbar ---
  SCROLLBAR_W        = 8
  SCROLLBAR_X        = SCREEN_W - SCROLLBAR_W - 2
  SCROLLBAR_COLOR    = Color.new(248,  96, 144)
  SCROLLBAR_BG       = Color.new(0,  0, 0, 100)

  #--- Cursor ---
  CURSOR_W           = GRID_CELL_W
  CURSOR_H           = GRID_CELL_H

  # ── Botones principales ───────────────────────────────────────────────
  # Dimensiones de cada imagen de botón
  BTN_W              = 160
  BTN_H              = 44
  BTN_GAP            = 6
  BTNS_Y             = SCREEN_H - BTN_H - 4   # 336

  # Nombres de imagen por [botón][estado: 0=normal, 1=seleccionado]
  # El estado desactivado (off) se genera automáticamente en gris por código.
  BTN_IMAGES = [
    ["btn_add"   ],
    ["btn_remove"],
    ["btn_blend" ]
  ]
  BTN_LABELS = ["+ Añadir", "- Quitar", "¡Licuar!"]

  # Tono gris aplicado al sprite cuando el botón está desactivado
  # tone = Tone.new(r, g, b, gris) gris alto desatura el color
  BTN_DISABLED_TONE = Tone.new(-80, -80, -80, 200)
  BTN_NORMAL_TONE   = Tone.new(0, 0, 0, 0)

  # Color del texto según estado
  BTN_TXT_NORMAL   = Color.new(248, 248, 248)
  BTN_TXT_SELECTED = Color.new(248, 248, 160)
  BTN_TXT_DISABLED = Color.new(180, 180, 180)
  BTN_TXT_SHADOW   = Color.new(  0,   0,   0)

  # ── Botones del selector ──────────────────────────────────────────────
  # Una sola imagen genérica reutilizada para ambos botones
  SEL_BTN_IMG        = "sel_btn"   # sel_btn.png imagen genérica de botón
  SEL_BTN_W          = 254
  SEL_BTN_H          = 38

  #--- Panel superior ---
  TITLE_H            = 44
  TITLE_BG           = Color.new(0,  0, 0, 100)
  TITLE_TEXT         = Color.new(255, 255, 255)

  #--- Selector ---
  SEL_TITLE_BG       = Color.new(0,  0, 0, 100)
  QTY_COLOR          = Color.new(248, 248, 248)

  #--- Sonidos ---
  SE_BLEND           = "Pokeblock"
end

#===============================================================================
# DATOS DE BAYAS  [color, rareza]
#===============================================================================
BERRY_BLENDER_DATA = {
  :CHERIBERRY=>[0,0],:FIGYBERRY=>[0,0],:LEPPABERRY=>[0,0],:RAZZBERRY=>[0,0],
  :POMEGBERRY=>[0,1],:TAMATOBERRY=>[0,1],:CHOPLEBERRY=>[0,2],:HABANBERRY=>[0,2],
  :OCCABERRY=>[0,2],:PAYAPABERRY=>[0,2],:ROSELIBERRY=>[0,2],:CUSTAPBERRY=>[0,4],
  :BLUKBERRY=>[1,0],:CHESTOBERRY=>[1,0],:ORANBERRY=>[1,0],:WIKIBERRY=>[1,0],
  :BELUEBERRY=>[1,1],:CORNBERRY=>[1,1],:KELPSYNBERRY=>[1,1],:PAMTREBERRY=>[1,1],
  :COBABERRY=>[1,2],:PASSHOBERRY=>[1,2],:YACHEBERRY=>[1,2],
  :APICOTBERRY=>[1,3],:GANLOBERRY=>[1,3],:ROWAPBERRY=>[1,4],
  :MAGOBERRY=>[2,0],:NANABBERRY=>[2,0],:PECHABERRY=>[2,0],:PERSIMBERRY=>[2,0],
  :MAGOSTBERRY=>[2,1],:QUALOTBERRY=>[2,1],:SPELONBERRY=>[2,1],
  :COLBURBERRY=>[2,2],:KASIBBERRY=>[2,2],:KEEBERRY=>[2,3],
  :PETAYABERRY=>[2,3],:LANSATBERRY=>[2,5],
  :AGUAVBERRY=>[3,0],:RAWSTBERRY=>[3,0],:WEPEARBERRY=>[3,0],
  :DURINBERRY=>[3,1],:HONDEWBERRY=>[3,1],:LUMBERRY=>[3,1],
  :RABUTABERRY=>[3,1],:WATMELBERRY=>[3,1],:BABIBERRY=>[3,2],
  :KEBIABERRY=>[3,2],:RINDOBERRY=>[3,2],:TANGABERRY=>[3,2],
  :SALACBERRY=>[3,3],:MICLEBERRY=>[3,4],:STARFBERRY=>[3,5],
  :ASPEARBERRY=>[4,0],:IAPAPABERRY=>[4,0],:PINAPBERRY=>[4,0],
  :GREPABERRY=>[4,1],:NOMELBERRY=>[4,1],:SITRUSBERRY=>[4,1],
  :CHARTIBERRY=>[4,2],:CHILANBERRY=>[4,2],:SHUCABERRY=>[4,2],:WACANBERRY=>[4,2],
  :LIECHIBERRY=>[4,3],:MARANGABERRY=>[4,3],:ENIGMABERRY=>[4,4],:JABOCABERRY=>[4,4]
}

BERRY_BLENDER_COLOR_NAMES = ["Rojo","Azul","Rosa","Verde","Amarillo","Arcoíris"]
BERRY_BLENDER_PLUS_CHANCE = [0.10, 0.25, 0.50, 0.70, 0.90, 1.00]

POKEBLOCK_IDS = {
  :regular => [:REDPOKEBLOCK,:BLUEPOKEBLOCK,:PINKPOKEBLOCK,
               :GREENPOKEBLOCK,:YELLOWPOKEBLOCK,:RAINBOWPOKEBLOCK],
  :plus    => [:REDPOKEBLOCKPLUS,:BLUEPOKEBLOCKPLUS,:PINKPOKEBLOCKPLUS,
               :GREENPOKEBLOCKPLUS,:YELLOWPOKEBLOCKPLUS,:RAINBOWPOKEBLOCKPLUS]
}

#===============================================================================
def pbBerryBlender
  pbFadeOutIn(99999){
    scene  = BerryBlenderScene.new
    screen = BerryBlenderScreen.new(scene)
    screen.pbStart
  }
end

#===============================================================================
# BerryBlenderScreen - lógica
#===============================================================================
class BerryBlenderScreen
  def initialize(scene)
    @scene   = scene
    @berries = []
  end

  def pbStart
    @scene.pbStartScene(@berries)
    loop do
      cmd = @scene.pbWaitButton
      case cmd
      when :add    then pbAddBerry
      when :remove then pbRemoveBerry
      when :blend  then pbBlend #break if pbBlend
      when :quit   then break
      end
    end
    @scene.pbEndScene
  end

  def pbAddBerry
    if @berries.length >= 4
      pbPlayBuzzerSE
      Kernel.pbMessage(_INTL("Ya has añadido el máximo de 4 bayas."))
      return
    end
    available = []
    BERRY_BLENDER_DATA.each do |sym, _|
      id  = getID(PBItems, sym)
      qty = id > 0 ? $PokemonBag.pbQuantity(id) : 0
      available.push([sym, id, qty]) if qty > 0
    end
    if available.empty?
      Kernel.pbMessage(_INTL("No tienes bayas en la mochila."))
      return
    end
    chosen = @scene.pbGridSelect(available)
    if chosen
      @berries.push(chosen)
      @scene.pbRefreshSlots(@berries)
    end
  end

  def pbRemoveBerry
    if @berries.empty?
      pbPlayBuzzerSE
      Kernel.pbMessage(_INTL("No hay bayas que quitar."))
      return
    end
    idx = @scene.pbChooseRemove(@berries)
    if idx >= 0
      @berries.delete_at(idx)
      @scene.pbRefreshSlots(@berries)
    end
  end

  def pbBlend
    if @berries.length < 2
      pbPlayBuzzerSE
      Kernel.pbMessage(_INTL("Necesitas al menos 2 bayas para licuar."))
      return false
    end
    for sym in @berries
      id = getID(PBItems, sym)
      $PokemonBag.pbDeleteItem(id, 1) if id > 0
    end
    color_idx, is_plus, count = pbCalcResult(@berries)
    @scene.pbAnimBlend
    @berries = []
    @scene.pbRefreshSlots(@berries)
    block_sym = is_plus ? POKEBLOCK_IDS[:plus][color_idx] : POKEBLOCK_IDS[:regular][color_idx]
    block_id  = getID(PBItems, block_sym)
    if block_id > 0
      Kernel.pbReceiveItem(block_id, count)
    else
      Kernel.pbMessage(_INTL("Error: Pokéblock no encontrado. Revisa POKEBLOCK_IDS."))
    end
    return true
  end

  def pbCalcResult(berries)
    count  = berries.length
    colors = berries.collect { |s| BERRY_BLENDER_DATA[s] ? BERRY_BLENDER_DATA[s][0] : 0 }
    unique = colors.uniq
    if unique.length == 4
      result_color = 5
    else
      freq = {}
      for c in colors; freq[c] = (freq[c] || 0) + 1; end
      max_f = freq.values.max
      cands = []; freq.each { |c, f| cands.push(c) if f == max_f }
      result_color = cands[rand(cands.length)]
    end
    rsum = 0
    for s in berries; rsum += BERRY_BLENDER_DATA[s] ? BERRY_BLENDER_DATA[s][1] : 0; end
    avg = (rsum.to_f / count).round
    avg = 0 if avg < 0; avg = 5 if avg > 5
    return result_color, (rand < BERRY_BLENDER_PLUS_CHANCE[avg]), count
  end
end

#===============================================================================
# BerryBlenderScene - gráficos
#===============================================================================
class BerryBlenderScene
  GFX = "Graphics/Pictures/Contest/BerryBlender/"

  BTN_ADD    = 0
  BTN_REMOVE = 1
  BTN_BLEND  = 2

  #-----------------------------------------------------------------------------
  def pbStartScene(berries)
    @viewport = Viewport.new(0, 0, BlenderConfig::SCREEN_W, BlenderConfig::SCREEN_H)
    @viewport.z = 99999
    @vp_sel   = Viewport.new(0, 0, BlenderConfig::SCREEN_W, BlenderConfig::SCREEN_H)
    @vp_sel.z = 100000
    @sprites  = {}
    @selected_btn = BTN_ADD
    @current_berry_count = 0
    pbBuildMain
    pbRefreshSlots(berries)
    pbRefreshButtons(0)
    Graphics.update
    
    @lastBerryIdx = 0
  end

  #-----------------------------------------------------------------------------
  def pbWaitButton
    loop do
      Graphics.update
      Input.update
      if Input.trigger?(Input::LEFT) || Input.trigger?(Input::UP)
        @selected_btn = (@selected_btn - 1) % 3
        pbRefreshButtons(@current_berry_count)
        pbPlayCursorSE
      elsif Input.trigger?(Input::RIGHT) || Input.trigger?(Input::DOWN)
        @selected_btn = (@selected_btn + 1) % 3
        pbRefreshButtons(@current_berry_count)
        pbPlayCursorSE
      elsif Input.trigger?(Input::C)
        pbPlayDecisionSE
        case @selected_btn
        when BTN_ADD    then return :add
        when BTN_REMOVE then return :remove
        when BTN_BLEND  then return :blend
        end
      elsif Input.trigger?(Input::B)
        return :quit
      end
    end
  end

  #-----------------------------------------------------------------------------
  def pbRefreshSlots(berries)
    @current_berry_count = berries.length
    for i in 0...4
      sym = berries[i]
      if sym
        id = getID(PBItems, sym)
        if id > 0
          @sprites["berry#{i}"].setBitmap(pbItemIconFile(id))
          bmp    = @sprites["berry#{i}"].bitmap
          icon_w = bmp ? bmp.width  : 32
          icon_h = bmp ? bmp.height : 32
          cx = BlenderConfig::SLOT_START_X + i * BlenderConfig::SLOT_SIZE
          cy = BlenderConfig::SLOT_START_Y
          @sprites["berry#{i}"].x = cx - icon_w / 2
          @sprites["berry#{i}"].y = cy - icon_h / 2
          @sprites["berry#{i}"].visible = true
        end
      else
        @sprites["berry#{i}"].visible = false
      end
    end
    pbRefreshButtons(berries.length)
    Graphics.update
  end

  #-----------------------------------------------------------------------------
  # Botones: imagen de fondo + tone para desactivado + texto encima
  def pbRefreshButtons(count)
    enabled = [count < 4, count > 0, count >= 2]

    sw      = BlenderConfig::SCREEN_W
    bw      = BlenderConfig::BTN_W
    bh      = BlenderConfig::BTN_H
    gap     = BlenderConfig::BTN_GAP
    total_w = bw * 3 + gap * 2
    start_x = (sw - total_w) / 2
    by      = BlenderConfig::BTNS_Y

    for i in 0...3
      # Estado: 0=normal, 1=seleccionado (off se aplica como tone)
      img_name = BlenderConfig::BTN_IMAGES[i][0]
      bx       = start_x + i * (bw + gap)

      @sprites["btn_img#{i}"].setBitmap(GFX + img_name)
      @sprites["btn_img#{i}"].x = bx
      @sprites["btn_img#{i}"].y = by

      # Gris automático si el botón está desactivado
      if enabled[i]
        @sprites["btn_img#{i}"].tone = BlenderConfig::BTN_NORMAL_TONE
      else
        @sprites["btn_img#{i}"].tone = BlenderConfig::BTN_DISABLED_TONE
      end

      # Texto
      txt_color = if i == @selected_btn then BlenderConfig::BTN_TXT_SELECTED
                  elsif !enabled[i]     then BlenderConfig::BTN_TXT_DISABLED
                  else                       BlenderConfig::BTN_TXT_NORMAL
                  end
      b = @sprites["btn_txt#{i}"].bitmap
      b.clear
      ty = (bh - 18) / 2
      pbSetSystemFont(b)
      pbDrawTextPositions(b, [
        [BlenderConfig::BTN_LABELS[i], bw / 2, ty, 2,
         txt_color, BlenderConfig::BTN_TXT_SHADOW, true]
      ])
    end
    gap     = BlenderConfig::BTN_GAP
    total_w = BlenderConfig::BTN_W * 3 + gap * 2
    start_x = (BlenderConfig::SCREEN_W - total_w) / 2
    @sprites["btn_sel"].x = start_x + @selected_btn * (BlenderConfig::BTN_W + gap)
    @sprites["btn_sel"].y = BlenderConfig::BTNS_Y
  end

  #-----------------------------------------------------------------------------
  def pbGridSelect(available)
    pbShowSelector(available)
    cursor = @lastBerryIdx rescue 0
    pbUpdateCursor(cursor)
    result = nil
    cols   = BlenderConfig::GRID_COLS
    loop do
      Graphics.update
      Input.update
      moved = false
      if Input.repeat?(Input::LEFT)
        cursor -= 1; cursor = available.length - 1 if cursor < 0; moved = true
      elsif Input.repeat?(Input::RIGHT)
        cursor += 1; cursor = 0 if cursor >= available.length; moved = true
      elsif Input.repeat?(Input::UP)
        cursor -= cols; cursor += available.length if cursor < 0; moved = true
      elsif Input.repeat?(Input::DOWN)
        cursor += cols; cursor -= available.length if cursor >= available.length; moved = true
      end
      if moved
        pbUpdateCursor(cursor)
        pbPlayCursorSE
      end
      if Input.trigger?(Input::C)
        pbPlayDecisionSE
        result = available[cursor][0]
        @lastBerryIdx = cursor rescue 0
        break
      end
      if Input.trigger?(Input::B)
        result = nil
        break
      end
    end
    pbHideSelector
    return result
  end

  #-----------------------------------------------------------------------------
  def pbChooseRemove(berries)
    temp = berries.collect { |sym| [sym, getID(PBItems, sym), 1] }
    chosen_sym = pbGridSelect(temp)
    return -1 unless chosen_sym
    idx = -1
    berries.each_with_index { |s, i| idx = i if s == chosen_sym }
    return idx
  end

  #-----------------------------------------------------------------------------
  def pbAnimBlend
    pbSEPlay(BlenderConfig::SE_BLEND)
    BlenderConfig::BLENDER_ANIM_FRAMES.times do |i|
      @sprites["blender"].opacity = (i % 2 == 0) ? 80 : 255
      Graphics.update
      pbWait(4)
    end
    @sprites["blender"].opacity = 255
    for i in 0...4; @sprites["berry#{i}"].visible = false; end
    Graphics.update
    pbWait(2)
  end

  #-----------------------------------------------------------------------------
  def pbEndScene
    if @vp_grid
      @vp_grid.dispose rescue nil
      @vp_grid = nil
    end
    @sprites.each_value { |s| s.dispose if s && !s.disposed? }
    @sprites.clear
    @viewport.dispose
    @vp_sel.dispose
  end

  def pbBuildMain
    sw = BlenderConfig::SCREEN_W
    bw = BlenderConfig::BTN_W
    bh = BlenderConfig::BTN_H

    # Fondo
    @sprites["bg"] = IconSprite.new(0, 0, @viewport)
    @sprites["bg"].setBitmap(GFX + "background")

    # Licuadora
    @sprites["blender"] = IconSprite.new(BlenderConfig::BLENDER_X,
                                         BlenderConfig::BLENDER_Y, @viewport)
    @sprites["blender"].setBitmap(GFX + "blender_base")

    # Slots vacíos + iconos de baya
    for i in 0...4
      cx = BlenderConfig::SLOT_START_X + i * BlenderConfig::SLOT_SIZE
      cy = BlenderConfig::SLOT_START_Y
      @sprites["slot#{i}"] = IconSprite.new(cx - BlenderConfig::SLOT_RADIUS,
                                            cy - BlenderConfig::SLOT_RADIUS, @viewport)
      @sprites["slot#{i}"].setBitmap(GFX + "Berry_Circle")
      @sprites["berry#{i}"] = IconSprite.new(0, 0, @viewport)
      @sprites["berry#{i}"].visible = false
    end

    # Panel de título
    @sprites["title_panel"] = BitmapSprite.new(sw, BlenderConfig::TITLE_H, @viewport)
    @sprites["title_panel"].y = 0
    tp = @sprites["title_panel"].bitmap
    tp.fill_rect(0, 0, sw, BlenderConfig::TITLE_H, BlenderConfig::TITLE_BG)
    pbSetSystemFont(tp)
    pbDrawTextPositions(tp, [
      [_INTL("Licuabayas"), 8, (BlenderConfig::TITLE_H - 22) / 2, 0,
       BlenderConfig::TITLE_TEXT, Color.new(0, 0, 0)]
    ])


    # ── Tres botones: IconSprite (imagen) + BitmapSprite (texto) ─────────
    # Se crean en z separados para que el texto quede siempre encima
    gap     = BlenderConfig::BTN_GAP
    total_w = bw * 3 + gap * 2
    start_x = (sw - total_w) / 2

    for i in 0...3
      bx = start_x + i * (bw + gap)

      # Imagen de fondo del botón (se actualiza en pbRefreshButtons)
      img_sp = IconSprite.new(bx, BlenderConfig::BTNS_Y, @viewport)
      img_sp.setBitmap(GFX + BlenderConfig::BTN_IMAGES[i][0])
      @sprites["btn_img#{i}"] = img_sp

      # Bitmap para el texto, mismo tamaño que el botón, posicionado encima
      txt_sp = BitmapSprite.new(bw, bh, @viewport)
      txt_sp.x = bx
      txt_sp.y = BlenderConfig::BTNS_Y
      @sprites["btn_txt#{i}"] = txt_sp
    end
    sel_sp = IconSprite.new(0, BlenderConfig::BTNS_Y, @viewport)
    sel_sp.setBitmap(GFX + "btn_sel")
    sel_sp.z = 10          # por encima de btn_img (z=0) y btn_txt (z=0)
    @sprites["btn_sel"] = sel_sp
  end

  #-----------------------------------------------------------------------------
  # Selector de bayas con scroll
  #-----------------------------------------------------------------------------
  def pbShowSelector(available)
    @sel_available = available
    @sel_cells     = []
    @sel_scroll    = 0

    cols  = BlenderConfig::GRID_COLS
    cw    = BlenderConfig::GRID_CELL_W
    ch    = BlenderConfig::GRID_CELL_H
    gx    = BlenderConfig::GRID_START_X
    gy    = BlenderConfig::GRID_START_Y
    vis_h = BlenderConfig::GRID_VIEWPORT_H
    sw    = BlenderConfig::SCREEN_W
    sh    = BlenderConfig::SCREEN_H

    # Fondo
    @sprites["sel_bg"] = IconSprite.new(0, 0, @vp_sel)
    @sprites["sel_bg"].setBitmap(GFX + "bg_select")

    # Panel superior
    @sprites["sel_panel"] = BitmapSprite.new(sw, BlenderConfig::TITLE_H, @vp_sel)
    @sprites["sel_panel"].y = 0
    sp = @sprites["sel_panel"].bitmap
    sp.fill_rect(0, 0, sw, BlenderConfig::TITLE_H, BlenderConfig::SEL_TITLE_BG)
    pbSetSystemFont(sp)
    pbDrawTextPositions(sp, [
      ["¿Qué baya añadir?", 4, 10, 0, Color.new(255, 255, 255), Color.new(0, 0, 0)]
    ])

    # ── Botones inferiores: misma imagen genérica + texto encima ─────────
    sbw = BlenderConfig::SEL_BTN_W
    sbh = BlenderConfig::SEL_BTN_H
    by2 = sh - sbh - 2

    # Imagen botón OK
    @sprites["sel_btn_ok_img"] = IconSprite.new(2, by2, @vp_sel)
    @sprites["sel_btn_ok_img"].setBitmap(GFX + "sel_btn_ok")
    @sprites["sel_btn_ok_img"].z = 5

    # Texto encima del botón OK
    @sprites["sel_btn_ok_txt"] = BitmapSprite.new(sbw, sbh, @vp_sel)
    @sprites["sel_btn_ok_txt"].x = 2
    @sprites["sel_btn_ok_txt"].y = by2
    @sprites["sel_btn_ok_txt"].z = 6
    b_ok = @sprites["sel_btn_ok_txt"].bitmap
    pbSetSystemFont(b_ok)
    pbDrawTextPositions(b_ok, [
      [_INTL("C: Seleccionar"), sbw / 2, (sbh - 16) / 2, 2,
       Color.new(255, 255, 255), Color.new(0, 0, 0), true]
    ])

    # Imagen botón Cancel
    @sprites["sel_btn_cancel_img"] = IconSprite.new(sbw + 6, by2, @vp_sel)
    @sprites["sel_btn_cancel_img"].setBitmap(GFX + "sel_btn_cancel")
    @sprites["sel_btn_cancel_img"].z = 5

    # Texto encima del botón Cancel
    @sprites["sel_btn_cancel_txt"] = BitmapSprite.new(sbw, sbh, @vp_sel)
    @sprites["sel_btn_cancel_txt"].x = sbw + 6
    @sprites["sel_btn_cancel_txt"].y = by2
    @sprites["sel_btn_cancel_txt"].z = 6
    b_cancel = @sprites["sel_btn_cancel_txt"].bitmap
    pbSetSystemFont(b_cancel)
    pbDrawTextPositions(b_cancel, [
      [_INTL("X: Cancelar"), sbw / 2, (sbh - 16) / 2, 2,
       Color.new(255, 255, 255), Color.new(0, 0, 0), true]
    ])

    # Viewport de recorte para la grid
    @vp_grid = Viewport.new(gx, gy, sw - gx, vis_h)
    @vp_grid.z = @vp_sel.z + 1

    # Celdas e iconos
    available.each_with_index do |entry, idx|
      sym = entry[0]; id = entry[1]; qty = entry[2]
      col = idx % cols; row = idx / cols
      cx  = col * cw
      cy  = row * ch

      ic = IconSprite.new(cx + 4, cy + 2, @vp_grid)
      ic.setBitmap(pbItemIconFile(id))
      @sprites["sel_ic#{idx}"] = ic

      qt = BitmapSprite.new(cw + 8, 40, @vp_grid)
      qt.x = cx
      qt.y = cy + BlenderConfig::GRID_QTY_OFF_Y
      qtb = qt.bitmap
      pbSetSmallFont(qtb)
      pbDrawTextPositions(qtb, [
        [qty.to_s, 8, -2, 0, BlenderConfig::QTY_COLOR, Color.new(0, 0, 0), true]
      ])
      @sprites["sel_qt#{idx}"] = qt

      @sel_cells.push([cx, cy])
    end

    # Cursor - en @vp_sel con coords absolutas para no ser recortado
    cw2 = BlenderConfig::CURSOR_W + 4
    ch2 = BlenderConfig::CURSOR_H + 4
    cur_sp = BitmapSprite.new(cw2, ch2, @vp_sel)
    cur_sp.z = @vp_sel.z + 10   # por encima de todo lo del selector

    # Dibujar directamente sobre el bitmap interno del sprite
    cur_sp = IconSprite.new(0, 0, @vp_sel)
    cur_sp.setBitmap(GFX + "sel_cursor")
    cur_sp.z = @vp_sel.z + 10
    @sprites["sel_cur"] = cur_sp

    # Posicionar ya sobre la celda 0 para que sea visible desde el inicio
    pbUpdateCursor(0)

    # Scrollbar - también en @vp_sel
    total_rows = (available.length.to_f / cols).ceil
    if total_rows > BlenderConfig::GRID_VISIBLE_ROWS
      sbx = gx + (cols * cw) + 2
      sbar_bg = BitmapSprite.new(BlenderConfig::SCROLLBAR_W, vis_h, @vp_sel)
      sbar_bg.x = sbx
      sbar_bg.y = gy
      sbar_bg.z = 155
      sbar_bg.bitmap.fill_rect(0, 0, BlenderConfig::SCROLLBAR_W, vis_h,
                               BlenderConfig::SCROLLBAR_BG)
      @sprites["sel_sbar_bg"] = sbar_bg

      sbar = BitmapSprite.new(BlenderConfig::SCROLLBAR_W, vis_h, @vp_sel)
      sbar.x = sbx
      sbar.y = gy
      sbar.z = 156
      @sprites["sel_sbar"] = sbar
    end
    Graphics.update
  end

  #-----------------------------------------------------------------------------
  def pbHideSelector
    if @vp_grid
      @vp_grid.dispose rescue nil
      @vp_grid = nil
    end
    del = []
    @sprites.each_key { |k| del.push(k) if k.to_s[0, 4] == "sel_" }
    for k in del
      @sprites[k].dispose if @sprites[k] && !@sprites[k].disposed?
      @sprites.delete(k)
    end
    @sel_cells = nil; @sel_available = nil; @sel_scroll = 0
    Graphics.update
  end

  #-----------------------------------------------------------------------------
  def pbScrollGrid(scroll_row)
    @sel_scroll = scroll_row
    offset_y    = scroll_row * BlenderConfig::GRID_CELL_H
    n  = @sel_available ? @sel_available.length : 0
    cw = BlenderConfig::GRID_CELL_W
    ch = BlenderConfig::GRID_CELL_H
    for idx in 0...n
      cx = @sel_cells[idx][0]
      cy = @sel_cells[idx][1]
      if @sprites["sel_ic#{idx}"]
        bmp    = @sprites["sel_ic#{idx}"].bitmap
        icon_w = bmp ? bmp.width  : 32
        icon_h = bmp ? bmp.height : 32
        @sprites["sel_ic#{idx}"].x = cx + (cw - icon_w) / 2
        @sprites["sel_ic#{idx}"].y = cy - offset_y + (ch - icon_h) / 2 - 4
      end
      if @sprites["sel_qt#{idx}"]
        @sprites["sel_qt#{idx}"].y = cy - offset_y + BlenderConfig::GRID_QTY_OFF_Y
      end
    end
    pbUpdateScrollbar(scroll_row)
  end

  #-----------------------------------------------------------------------------
  def pbUpdateScrollbar(scroll_row)
    return unless @sprites["sel_sbar"]
    cols       = BlenderConfig::GRID_COLS
    total_rows = (@sel_available.length.to_f / cols).ceil
    vis_rows   = BlenderConfig::GRID_VISIBLE_ROWS
    vis_h      = BlenderConfig::GRID_VIEWPORT_H
    thumb_h    = [(vis_h * vis_rows / total_rows).to_i, 10].max
    max_scroll = total_rows - vis_rows
    thumb_y    = max_scroll > 0 ?
                 ((vis_h - thumb_h) * scroll_row / max_scroll).to_i : 0
    b = @sprites["sel_sbar"].bitmap
    b.clear
    b.fill_rect(0, thumb_y, BlenderConfig::SCROLLBAR_W, thumb_h,
                BlenderConfig::SCROLLBAR_COLOR)
  end

  #-----------------------------------------------------------------------------
  def pbUpdateCursor(pos)
    return unless @sel_cells && @sel_cells[pos]
    cols     = BlenderConfig::GRID_COLS
    vis_rows = BlenderConfig::GRID_VISIBLE_ROWS
    cur_row  = pos / cols
    if cur_row < @sel_scroll
      pbScrollGrid(cur_row)
    elsif cur_row >= @sel_scroll + vis_rows
      pbScrollGrid(cur_row - vis_rows + 1)
    end
    # El cursor está en @vp_sel → coords absolutas de pantalla
    offset_y = @sel_scroll * BlenderConfig::GRID_CELL_H
    cx = @sel_cells[pos][0]
    cy = @sel_cells[pos][1]
    @sprites["sel_cur"].x = BlenderConfig::GRID_START_X + cx - 2
    @sprites["sel_cur"].y = BlenderConfig::GRID_START_Y + cy - offset_y - 2
  end
end


#===============================================================================
# Pokécubos - Sistema de Concursos (Remake) CON SHEEN
#===============================================================================
# ------------------------------------------------------------------------------
# Helper para calcular reducción por condición total
# ------------------------------------------------------------------------------
def pbGetPokeblockReduction(pokemon)
  total = pokemon.cool + pokemon.beauty + pokemon.cute + pokemon.smart + pokemon.tough
  case total
  when 0...256   then 8   # 0-255
  when 256...512 then 6   # 256-511
  when 512...768 then 4   # 512-767
  when 768...1024 then 3  # 768-1023
  else                2   # 1024+
  end
end
# ------------------------------------------------------------------------------
# Helper para calcular bono por cariño (affection)
# ------------------------------------------------------------------------------
def pbGetAffectionBonus(pokemon)
  affection = pokemon.happiness
  case affection
  when 0...100   then 0  # 0-1 corazones
  when 100...150 then 1  # 2-3 corazones
  when 150...200 then 2  # 4 corazones
  else                4  # 5 corazones
  end
end
# ------------------------------------------------------------------------------
# Helper para aplicar aumento a una estadística
# ------------------------------------------------------------------------------
def pbApplyPokeblockIncrease(pokemon, stat, base_increase, scene, stat_name)
  current = pokemon.method(stat).call
  return false if current >= 255
  
  increase = base_increase + pbGetAffectionBonus(pokemon)
  increase = [increase, 255 - current].min
  return false if increase <= 0
  
  pokemon.method(stat.to_s + "=").call(current + increase)
  scene.pbDisplay(_INTL("¡El {1} de {2} ha aumentado en {3}!", stat_name, pokemon.name, increase))
  return true
end
#===============================================================================
# Pokécubos de Color (Standard) - 8pts con reducción
#===============================================================================

ItemHandlers::UseOnPokemon.add(:REDPOKEBLOCK, proc { |item, pokemon, scene|
  if pokemon.cool >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  base = pbGetPokeblockReduction(pokemon)
  success = pbApplyPokeblockIncrease(pokemon, :cool, base, scene, "Carisma")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:BLUEPOKEBLOCK, proc { |item, pokemon, scene|
  if pokemon.beauty >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  base = pbGetPokeblockReduction(pokemon)
  success = pbApplyPokeblockIncrease(pokemon, :beauty, base, scene, "Belleza")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:PINKPOKEBLOCK, proc { |item, pokemon, scene|
  if pokemon.cute >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  base = pbGetPokeblockReduction(pokemon)
  success = pbApplyPokeblockIncrease(pokemon, :cute, base, scene, "Dulzura")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:GREENPOKEBLOCK, proc { |item, pokemon, scene|
  if pokemon.smart >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  base = pbGetPokeblockReduction(pokemon)
  success = pbApplyPokeblockIncrease(pokemon, :smart, base, scene, "Ingenio")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:YELLOWPOKEBLOCK, proc { |item, pokemon, scene|
  if pokemon.tough >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  base = pbGetPokeblockReduction(pokemon)
  success = pbApplyPokeblockIncrease(pokemon, :tough, base, scene, "Dureza")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

#===============================================================================
# Pokécubos Arcoíris (Standard) - 8pts a TODAS, con reducción
#===============================================================================

ItemHandlers::UseOnPokemon.add(:RAINBOWPOKEBLOCK, proc { |item, pokemon, scene|
  base = pbGetPokeblockReduction(pokemon)
  bonus = pbGetAffectionBonus(pokemon)
  any_success = false
  
  stats = [
    [:cool, "Carisma"],
    [:beauty, "Belleza"],
    [:cute, "Dulzura"],
    [:smart, "Ingenio"],
    [:tough, "Dureza"]
  ]
  
  stats.each do |stat, name|
    current = pokemon.method(stat).call
    if current < 255
      increase = base + bonus
      increase = [increase, 255 - current].min
      
      if increase > 0
        pokemon.method(stat.to_s + "=").call(current + increase)
        any_success = true
      end
    end
  end
  
  if any_success
    pokemon.sheen += 1
    scene.pbDisplay(_INTL("¡Todas las características de {1} han aumentado!", pokemon.name))
  else
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  scene.pbHardRefresh
  next true
})

#===============================================================================
# Pokécubos + (Plus) - SIEMPRE 16pts, SIN reducción
#===============================================================================

ItemHandlers::UseOnPokemon.add(:REDPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  if pokemon.cool >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  success = pbApplyPokeblockIncrease(pokemon, :cool, 16, scene, "Carisma")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:BLUEPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  if pokemon.beauty >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  success = pbApplyPokeblockIncrease(pokemon, :beauty, 16, scene, "Belleza")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:PINKPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  if pokemon.cute >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  success = pbApplyPokeblockIncrease(pokemon, :cute, 16, scene, "Dulzura")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:GREENPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  if pokemon.smart >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  success = pbApplyPokeblockIncrease(pokemon, :smart, 16, scene, "Ingenio")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

ItemHandlers::UseOnPokemon.add(:YELLOWPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  if pokemon.tough >= 255
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  success = pbApplyPokeblockIncrease(pokemon, :tough, 16, scene, "Dureza")
  
  if success
    pokemon.sheen += 1
    scene.pbHardRefresh
  end
  next success
})

#===============================================================================
# Pokécubo Arcoíris + (Plus) - SIEMPRE 16pts a TODAS, SIN reducción
#===============================================================================

ItemHandlers::UseOnPokemon.add(:RAINBOWPOKEBLOCKPLUS, proc { |item, pokemon, scene|
  bonus = pbGetAffectionBonus(pokemon)
  any_success = false
  
  stats = [
    [:cool, "Carisma"],
    [:beauty, "Belleza"],
    [:cute, "Dulzura"],
    [:smart, "Ingenio"],
    [:tough, "Dureza"]
  ]
  
  stats.each do |stat, name|
    current = pokemon.method(stat).call
    if current < 255
      increase = 16 + bonus
      increase = [increase, 255 - current].min
      
      if increase > 0
        pokemon.method(stat.to_s + "=").call(current + increase)
        any_success = true
      end
    end
  end
  
  if any_success
    pokemon.sheen += 1
    scene.pbDisplay(_INTL("¡Todas las características de {1} han aumentado significativamente!", pokemon.name))
  else
    scene.pbDisplay(_INTL("No tendrá efecto."))
    next false
  end
  
  scene.pbHardRefresh
  next true
})