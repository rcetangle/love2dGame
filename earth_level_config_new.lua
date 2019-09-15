local level_config = {}

-- global texture params
eh_ActorTexture = {
    detective = {
        {
            love.graphics.newImage("assets/earth/detective_f.png"),
            love.graphics.newImage("assets/earth/detective_f2.png"),
            love.graphics.newImage("assets/earth/detective_f3.png"),
            love.graphics.newImage("assets/earth/detective_f4.png"),
        },
        {
            love.graphics.newImage("assets/earth/detective_r.png"),
            love.graphics.newImage("assets/earth/detective_r2.png"),
            love.graphics.newImage("assets/earth/detective_r3.png"),
            love.graphics.newImage("assets/earth/detective_r4.png"),
        },
        {
            love.graphics.newImage("assets/earth/detective_b.png"),
            love.graphics.newImage("assets/earth/detective_b2.png"),
            love.graphics.newImage("assets/earth/detective_b3.png"),
            love.graphics.newImage("assets/earth/detective_b4.png"),

        },
        {
            love.graphics.newImage("assets/earth/detective_l.png"),
            love.graphics.newImage("assets/earth/detective_l2.png"),
            love.graphics.newImage("assets/earth/detective_l3.png"),
            love.graphics.newImage("assets/earth/detective_l4.png"),
        }
    },
    thief = {
        {
            love.graphics.newImage("assets/earth/thief_f.png"),
            love.graphics.newImage("assets/earth/thief_f2.png"),
            love.graphics.newImage("assets/earth/thief_f3.png"),
            love.graphics.newImage("assets/earth/thief_f4.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_r.png"),
            love.graphics.newImage("assets/earth/thief_r2.png"),
            love.graphics.newImage("assets/earth/thief_r3.png"),
            love.graphics.newImage("assets/earth/thief_r4.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_b.png"),
            love.graphics.newImage("assets/earth/thief_b2.png"),
            love.graphics.newImage("assets/earth/thief_b3.png"),
            love.graphics.newImage("assets/earth/thief_b4.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_l.png"),
            love.graphics.newImage("assets/earth/thief_l2.png"),
            love.graphics.newImage("assets/earth/thief_l3.png"),
            love.graphics.newImage("assets/earth/thief_l4.png"),
        }
    }
}
eh_PropTexture = {
    detective = {
        love.graphics.newImage("assets/earth/prop_detective.png"),
        love.graphics.newImage("assets/earth/prop_detective2.png"),
    },
    thief = {
        love.graphics.newImage("assets/earth/prop_thief.png"),
        love.graphics.newImage("assets/earth/prop_thief2.png"),
    },
    key = {
        love.graphics.newImage("assets/earth/prop_key.png"),
    },
    smoke = {
        love.graphics.newImage("assets/earth/prop_smoke.png"),
        love.graphics.newImage("assets/earth/prop_smoke2.png"),
    }
}
eh_UITexture = {
	top = love.graphics.newImage("assets/earth/ui_top.png"),
	num_0 = love.graphics.newImage("assets/earth/0.png"),
	num_1 = love.graphics.newImage("assets/earth/1.png"),
	num_2 = love.graphics.newImage("assets/earth/2.png"),
	num_3 = love.graphics.newImage("assets/earth/3.png"),
	detective = love.graphics.newImage("assets/earth/detective_icon1.png"),
	detective_big = love.graphics.newImage("assets/earth/detective_big.png"),
	detective_win = love.graphics.newImage("assets/earth/detective_win.png"),
	ret_detective = love.graphics.newImage("assets/earth/ret_detective.png"),
	ret_light = love.graphics.newImage("assets/earth/ret_light.png"),
	ret_thief = love.graphics.newImage("assets/earth/ret_thief.png"),
	thief_win = love.graphics.newImage("assets/earth/thief_win.png"),
	thief = love.graphics.newImage("assets/earth/thief_icon1.png"),
    thief_big = love.graphics.newImage("assets/earth/thief_big.png"),
    start_logo = love.graphics.newImage("assets/earth/title.png"),
}

eh_Sound = {
    love.audio.newSource("assets/earth/lighten.wav", "static"),
    love.audio.newSource("assets/earth/hurtByProp.wav", "static"),
    love.audio.newSource("assets/earth/putProp.wav", "static"),
    love.audio.newSource("assets/earth/moveFur.wav", "static"),
    love.audio.newSource("assets/earth/detective_win.ogg", "static"),
    love.audio.newSource("assets/earth/thief_win.wav", "static"),    
    love.audio.newSource("assets/earth/bg.wav", "stream"),    
}
--------------------------------
-------- map1 18*5
level_config.tileMap1 = {
--	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17
	{-3,-2,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-2,-3},
    {-3,-1,-1,-1,-1,-1,-1,-1,-4,-1,-1,-1,-1,-1,-1,-1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,-3},
}

level_config.tileTexture1 = {
    -- floors
    love.graphics.newImage("assets/earth1/1.png"),
    love.graphics.newImage("assets/earth/black.png"),
    love.graphics.newImage("assets/earth/light.png"),

    -- walls
    love.graphics.newImage("assets/earth1/wall_5.png"),
    love.graphics.newImage("assets/earth1/wall_4.png"),
    love.graphics.newImage("assets/earth1/wall_3.png"),
    love.graphics.newImage("assets/earth1/wall_2.png"),
    love.graphics.newImage("assets/earth1/wall_1.png"),
}

level_config.furnitureCfg1 = {
    -- furniture
    closet = {
        state = "TURN_N_MOVE",
        frames = {
            love.graphics.newImage("assets/earth1/closet_f.png"), 
            love.graphics.newImage("assets/earth1/closet_l.png"), 
            love.graphics.newImage("assets/earth1/closet_b.png")
        }
    },
    closet2 =  {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth1/2Closet_f.png"),  
        love.graphics.newImage("assets/earth1/2Closet_l.png"), 
        love.graphics.newImage("assets/earth1/2Closet_b.png"), 
        }
    },
    chair = {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth1/chair_f.png"),
        love.graphics.newImage("assets/earth1/chair_l.png"),
        love.graphics.newImage("assets/earth1/chair_b.png"),
        love.graphics.newImage("assets/earth1/chair_r.png"),
        }
    },
    bed = {  
        width = 2, height = 2, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth1/bed_f.png"),
        love.graphics.newImage("assets/earth1/bed_l.png"),
        love.graphics.newImage("assets/earth1/bed_b.png"),
        }
    },
    closet3 = {
        width = 2, height = 1, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth1/4Closet_f.png"),
        love.graphics.newImage("assets/earth1/4Closet_b.png"),
        }
    },
    closet4 = {
        width = 1, height = 2, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth1/4Closet_l.png"),
        }
    },
    wall = {
	    love.graphics.newImage("assets/earth1/wall_6.png")
	},
    -- decoration
    decoration = {
        love.graphics.newImage("assets/earth1/pic_b1.png"),
        love.graphics.newImage("assets/earth1/pic_b2.png"),
        love.graphics.newImage("assets/earth1/pic_s1.png"),
        love.graphics.newImage("assets/earth1/pic_s2.png"),
        love.graphics.newImage("assets/earth1/clock.png"),
        love.graphics.newImage("assets/earth1/door.png"),
        love.graphics.newImage("assets/earth1/door2.png"),
        love.graphics.newImage("assets/earth1/carpet.png"),
    }
}

level_config.propertyMap1 = {
	-- wall's
	{row=2, col=2, name="decoration", frame=6},
	{row=2, col=5, name="decoration"},
	{row=1, col=7, name="decoration", frame=3},
	{row=1, col=14, name="decoration"},
	{row=2, col=15, name="decoration", frame=4},

	-- floor's
	-- {row=7, col=6, name="decoration", frame=8},
	-- {row=7, col=13, name="decoration", frame=8},

	-- furniture
	{row=3, col=3, name="closet3"},
	{row=3, col=5, name="closet"},
	{row=4, col=6, name="bed"},
	{row=3, col=8, name="closet"},
	{row=4, col=8, name="chair", frame=4},
	{row=6, col=2, name="closet2", frame=2},
	{row=4, col=9, name="closet2"},
	{row=4, col=10, name="closet4"},
	{row=3, col=12, name="closet"},
	{row=4, col=13, name="bed"},
	{row=3, col=15, name="closet"},
	{row=4, col=16, name="closet4"},
}

level_config.detective1 = {
	moves = {8}, 
    property = {4, 10},
    propertyHurt = {4, 0},
 
    row = 3,
    col = 2,	
}

level_config.thief1 = {
	moves = {10}, 
    property = {5, 15},
    propertyHurt = {4, 0},
 
    row = 6,
    col = 16,
}



--------------------------------
-------- map2 25*6
level_config.tileMap2 = {
--	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
	{-3,-2,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-2,-3},
    {-3,-1,-1,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-1,-1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 0, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
}

level_config.tileTexture2 = {
    -- floors
    love.graphics.newImage("assets/earth2/1.png"),
    love.graphics.newImage("assets/earth/black.png"),
    love.graphics.newImage("assets/earth/light.png"),

    -- walls
    love.graphics.newImage("assets/earth2/wall_5.png"),
    love.graphics.newImage("assets/earth2/wall_4.png"),
    love.graphics.newImage("assets/earth2/wall_3.png"),
    love.graphics.newImage("assets/earth2/wall_2.png"),
    love.graphics.newImage("assets/earth2/wall_1.png"),
}

level_config.furnitureCfg2 = {
    -- furniture
    closet = {
        state = "TURN_N_MOVE",
        frames = {
            love.graphics.newImage("assets/earth1/closet_f.png"), 
            love.graphics.newImage("assets/earth1/closet_l.png"), 
            love.graphics.newImage("assets/earth1/closet_b.png")
        }
    },
    closet2 =  {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/2Closet_f.png"),  
        love.graphics.newImage("assets/earth2/2Closet_l.png"), 
        love.graphics.newImage("assets/earth2/2Closet_b.png"), 
        }
    },
    chair = {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/chair_f.png"),
        love.graphics.newImage("assets/earth2/chair_l.png"),
        love.graphics.newImage("assets/earth2/chair_b.png"),
        love.graphics.newImage("assets/earth2/chair_r.png"),
        }
    },
    sofa = {
        width = 2, height = 1, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/sofa_f.png"),
        love.graphics.newImage("assets/earth2/sofa_b.png"),
        }
    },
    sofa2 = {
        width = 1, height = 2, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/sofa_l.png"),
        }
    },
    desk = {  
        width = 2, height = 1, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/desk_f.png"),
        love.graphics.newImage("assets/earth2/desk_b.png"),
        love.graphics.newImage("assets/earth2/desk2_f.png"),
        love.graphics.newImage("assets/earth2/desk2_b.png"),
        }
    },
    desk2 = {  
        width = 1, height = 2, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/desk_l.png"),
        love.graphics.newImage("assets/earth2/desk2_l.png"),
        }
    },
    plant = {
    	state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/plant_1.png"),
        love.graphics.newImage("assets/earth2/plant_2.png"),
        }
    },
    closet3 = {
        width = 2, height = 1, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth2/4Closet_f.png"),
            love.graphics.newImage("assets/earth2/4Closet_b.png"),
        }
    },	
    closet4 = {
        width = 1, height = 2, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth2/4Closet_l.png"),
        }
    },
    wall = {
    	width = 0, height = 2,
	    love.graphics.newImage("assets/earth2/wall_6.png"),
        love.graphics.newImage("assets/earth2/door3.png"),
	},
    -- decoration
    decoration = {
        love.graphics.newImage("assets/earth1/pic_b2.png"),
        love.graphics.newImage("assets/earth1/pic_s2.png"),
        love.graphics.newImage("assets/earth2/pic_s3.png"),
        love.graphics.newImage("assets/earth2/clock.png"),
        love.graphics.newImage("assets/earth2/carpet.png"),
        love.graphics.newImage("assets/earth2/window.png"),
    }
}

level_config.propertyMap2 = {
	-- wall's
	{row=1, col=4, name="decoration"},
	{row=1, col=5, name="decoration", frame=2},
	{row=1, col=6, name="decoration", frame=6},
	{row=1, col=7, name="decoration", frame=3},
	{row=1, col=11, name="decoration", frame=6},
	{row=1, col=12, name="decoration", frame=2},
	{row=1, col=13, name="decoration", frame=4},
	{row=1, col=14, name="decoration", frame=3},
	{row=1, col=15, name="decoration", frame=6},
	{row=1, col=18, name="decoration", frame=2},

	-- floor's
	-- {row=8, col=4, name="decoration", frame=5},
	-- {row=5, col=13, name="decoration", frame=5},
	-- {row=6, col=19, name="decoration", frame=5},

	-- furniture
	{row=3, col=2, name="closet3"},
	{row=3, col=4, name="closet2"},
	{row=3, col=5, name="closet2"},
	{row=3, col=6, name="plant", frame=2},
	{row=3, col=8, name="closet2", frame=2},
	-- {row=4, col=8, name="closet2", frame=2},
	{row=5, col=2, name="sofa2"},
	{row=5, col=3, name="desk2", frame=2},
	{row=6, col=2, name="plant"},
	{row=5, col=9, name="plant", frame=2},
	{row=6, col=7, name="desk2", frame=2},
    {row=6, col=6, name="sofa2"},
    
    {row=6, col=9, name="wall", frame=2},
    
	{row=3, col=10, name="closet2"},
	{row=3, col=11, name="closet2"},
	{row=3, col=15, name="closet2"},
	{row=3, col=16, name="closet2"},

	{row=3, col=13, name="chair"},
	{row=4, col=11, name="chair", frame=4},
	{row=4, col=14, name="chair", frame=2},
    {row=5, col=13, name="chair", frame=3},
    {row=4, col=12, name="desk", frame=2},

	{row=5, col=17, name="plant", frame=2},
	{row=3, col=18, name="plant"},
	{row=3, col=19, name="closet3"},
	{row=3, col=21, name="closet3"},
	{row=3, col=23, name="closet3"},
	{row=4, col=22, name="chair", frame=4},
	{row=4, col=23, name="desk", frame=2},
	-- {row=5, col=23, name="chair", frame=3},
	-- {row=5, col=24, name="chair", frame=3},

	{row=6, col=20, name="closet2", frame=3},
	{row=6, col=22, name="closet", frame=3},
	{row=6, col=23, name="closet2", frame=3},
	{row=6, col=24, name="closet2", frame=3},
}

level_config.detective2 = {
	moves = {11}, 
    property = {5, 18},
    propertyHurt = {4, 0},
 
    row = 5,
    col = 4,	
}

level_config.thief2 = {
	moves = {14}, 
    property = {6, 25},
    propertyHurt = {4, 0},
 
    row = 4,
    col = 21,
}




--------------------------------
-------- map3 24*9
level_config.tileTexture3 = {
    -- floors
    love.graphics.newImage("assets/earth3/1.png"),
    love.graphics.newImage("assets/earth/black2.png"),
    love.graphics.newImage("assets/earth/light.png"),

    -- walls
    love.graphics.newImage("assets/earth3/wall_5.png"),
    love.graphics.newImage("assets/earth3/wall_4.png"),
    love.graphics.newImage("assets/earth3/wall_3.png"),
    love.graphics.newImage("assets/earth3/wall_2.png"),
    love.graphics.newImage("assets/earth3/wall_1.png"),
}

level_config.tileMap3 = {
    --	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
        {-3,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-3},
        {-3,-1,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-1,-3},
        {-3, 1, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1, 1,-3},
        {-3, 1, 1, 1, 1, 0, 1,-5, 1, 1, 1, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1, 1,-3},
        {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
        {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
        {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
        {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,-3},
}

level_config.furnitureCfg3 = {
    -- furniture
    closet = {
        state = "TURN_N_MOVE",
        frames = {
            love.graphics.newImage("assets/earth1/closet_f.png"), 
            love.graphics.newImage("assets/earth1/closet_l.png"), 
            love.graphics.newImage("assets/earth1/closet_b.png")
        }
    },
    closet2 =  {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth2/2Closet_f.png"),  
        love.graphics.newImage("assets/earth2/2Closet_l.png"), 
        love.graphics.newImage("assets/earth2/2Closet_b.png"), 
        }
    },
    chair = {
        state = "TURN_N_MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/chair_f.png"),
        love.graphics.newImage("assets/earth3/chair_l.png"),
        love.graphics.newImage("assets/earth3/chair_b.png"),
        love.graphics.newImage("assets/earth3/chair_r.png"),
        }
    },
    sofa = {
        width = 2, height = 1, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/sofa_f.png"),
        love.graphics.newImage("assets/earth3/sofa_b.png"),
        }
    },
    sofa2 = {
        width = 1, height = 2, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/sofa_l.png"),
        }
    },
    desk = {  
        width = 2, height = 1, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/desk_f.png"),
        love.graphics.newImage("assets/earth3/desk_b.png"),
        }
    },
    desk2 = {  
        width = 1, height = 2, state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/desk_l.png"),
        }
    },
    device = {
    	state = "MOVE",
        frames = {
        love.graphics.newImage("assets/earth3/device_f.png"),
        love.graphics.newImage("assets/earth3/device_l.png"),
        love.graphics.newImage("assets/earth3/device_b.png"),
        }
    },
    closet3 = {
        width = 2, height = 1, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth3/4Closet_f.png"),
            love.graphics.newImage("assets/earth3/4Closet_b.png"),
        }
    },	
    closet4 = {
        width = 1, height = 2, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth3/4Closet_l.png"),
        }
    },
    piano = {
        width = 2, height = 2, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth3/piano_f.png"),
            love.graphics.newImage("assets/earth3/piano_l.png"),
            love.graphics.newImage("assets/earth3/piano_b.png"),
        }
    },
    plant = {
        state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth3/flower.png"),
            love.graphics.newImage("assets/earth3/light.png"),
        }
    },
    ball = {
        width = 2, height = 1, state = "MOVE",
        frames = {
            love.graphics.newImage("assets/earth3/ball.png"),
        }
    },
    wall = {
    	width = 0, height = 2,
	    love.graphics.newImage("assets/earth3/wall_6.png"),
    },
    -- decoration
    decoration = {
        love.graphics.newImage("assets/earth3/deer_f.png"),
        love.graphics.newImage("assets/earth3/deer_l.png"),
        love.graphics.newImage("assets/earth3/fire.png"),
        love.graphics.newImage("assets/earth3/pic_b1.png"),
        love.graphics.newImage("assets/earth3/pic_b2.png"),
        love.graphics.newImage("assets/earth3/clock.png"),
        love.graphics.newImage("assets/earth3/carpet.png"),
        love.graphics.newImage("assets/earth3/window.png"),
        love.graphics.newImage("assets/earth3/window2.png"),
    }
}

level_config.propertyMap3 = {
	-- wall's
	{row=1, col=5, name="decoration", frame=9},
	{row=1, col=7, name="decoration", frame=6},
	{row=1, col=10, name="decoration", frame=9},
	{row=2, col=12, name="decoration", frame=3},
	{row=1, col=15, name="decoration", frame=4},
	{row=1, col=16, name="decoration", frame=5},
	{row=1, col=21, name="decoration", frame=7},
	{row=3, col=17, name="decoration"},
	{row=3, col=8, name="decoration"},

	-- furniture
	{row=3, col=2, name="closet3"},
	{row=3, col=4, name="closet3"},
    {row=3, col=7, name="device"},
	{row=5, col=2, name="closet4"},
	{row=7, col=2, name="closet2", frame=2},
	{row=8, col=2, name="piano", frame=2},
	{row=5, col=4, name="sofa"},
	{row=6, col=3, name="chair", frame=4},
	{row=6, col=6, name="chair", frame=2},
	{row=6, col=4, name="desk", frame=2},
	{row=8, col=4, name="chair", frame=2},
	{row=8, col=7, name="ball"},
	{row=5, col=8, name="plant"},
    
	{row=4, col=9, name="closet4"},
	{row=4, col=10, name="ball"},
	{row=3, col=14, name="plant"},
	{row=3, col=15, name="closet2"},
	{row=3, col=16, name="closet2"},
	{row=5, col=9, name="device", frame=2},
	{row=4, col=12, name="piano"},
	{row=5, col=15, name="chair", frame=4},
    {row=5, col=16, name="desk2"},
    
	{row=7, col=10, name="chair", frame=4},
	{row=7, col=12, name="desk", frame=2},
	{row=7, col=15, name="chair", frame=2},
	{row=8, col=12, name="sofa", frame=2},
    {row=8, col=11, name="plant", frame=2},
	{row=8, col=14, name="device", frame=3},
    
	{row=3, col=18, name="device"},
	{row=3, col=19, name="closet3"},
	{row=3, col=21, name="plant", frame=2},
	{row=3, col=22, name="ball"},
	{row=6, col=18, name="chair", frame=4},
	{row=5, col=19, name="plant"},
	{row=5, col=21, name="chair"},
	{row=5, col=23, name="chair", frame=2},
	{row=6, col=20, name="desk"},
	{row=8, col=23, name="closet4"},
	{row=8, col=19, name="closet", frame=3},
	{row=8, col=21, name="closet2", frame=3},
	{row=8, col=22, name="closet2", frame=3},
}

level_config.detective3 = {
	moves = {14}, 
    property = {6, 25},
    propertyHurt = {4, 0},
 
    row = 5,
    col = 6,	
}

level_config.thief3 = {
	moves = {18}, 
    property = {7, 35},
    propertyHurt = {4, 0},
 
    row = 8,
    col = 18,
}

return level_config