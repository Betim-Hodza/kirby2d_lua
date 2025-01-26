-- file: /maps/chez-peter.lua
local tileString = [[
#########################
#  __-__----      # --- #
#  221221111      # 111 #
#                 #     #
#  ________-_     ### ###
#  1111111121       # # #
#                   ^ ^ #
#                   B B #
#                       #
                        #
#                       #
# ^                     #
# B                     #
#             -         #
#             2         #
#                       #
#                       #
#########################
]]

local quadInfo = { 
  { ' ',  0,  0 }, -- floor 
  { '-', 32,  0 }, -- top of machine 1
  { '_', 64,  0 }, -- top of machine 2
  { '^', 96,  0 }, -- top of plant
  { '#', 0,  32 }, -- Brick
  { '1', 32,  32 }, -- Bottom of machine 1
  { '2', 64,  32 }, -- Bottom of machine 2
  { 'B', 64,  32 }, -- Bottom of plant
}

newMap(32,32,'/images/resto.png', tileString, quadInfo)