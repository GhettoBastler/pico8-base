pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- my game
-- ghettobastler

VERSION = "0.0.1"
DEBUG = false

#include utils.p8
#include object.p8
#include particle.p8
#include scene.p8
#include game_scene.p8


function _init()
    -- disable keyboard retrigger
    poke(0x5f5c, 255)
     -- activate inverted shapes
    poke(0x5f34, 0x2)

    -- setup save data
    -- cartdata("ghettobastler_mygame_0_1")

    game_scene:enter(true)
end
