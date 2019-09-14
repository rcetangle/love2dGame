local level_config = {}

-- global texture params
eh_ActorTexture = {
    detective = {
        {
            love.graphics.newImage("assets/earth/detective.png"),
            love.graphics.newImage("assets/earth/detective2.png"),
            love.graphics.newImage("assets/earth/detective3.png"),
        },
        {
            love.graphics.newImage("assets/earth/detective_r.png"),
            love.graphics.newImage("assets/earth/detective_r2.png"),
            love.graphics.newImage("assets/earth/detective_r3.png"),
        },
        {
            love.graphics.newImage("assets/earth/detective_b.png"),
            love.graphics.newImage("assets/earth/detective_b2.png"),
            love.graphics.newImage("assets/earth/detective_b3.png"),

        },
        {
            love.graphics.newImage("assets/earth/detective_l.png"),
            love.graphics.newImage("assets/earth/detective_l2.png"),
            love.graphics.newImage("assets/earth/detective_l3.png"),
        }
    },
    thief = {
        {
            love.graphics.newImage("assets/earth/thife.png"),
            love.graphics.newImage("assets/earth/thife2.png"),
            love.graphics.newImage("assets/earth/thife3.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_r.png"),
            love.graphics.newImage("assets/earth/thief_r2.png"),
            love.graphics.newImage("assets/earth/thief_r3.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_b.png"),
            love.graphics.newImage("assets/earth/thief_b2.png"),
            love.graphics.newImage("assets/earth/thief_b3.png"),
        },
        {
            love.graphics.newImage("assets/earth/thief_l.png"),
            love.graphics.newImage("assets/earth/thief_l2.png"),
            love.graphics.newImage("assets/earth/thief_l3.png"),
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
	ret_detective = love.graphics.newImage("assets/earth/ret_detective.png"),
	ret_light = love.graphics.newImage("assets/earth/ret_light.png"),
	ret_thief = love.graphics.newImage("assets/earth/ret_thief.png"),
	thief = love.graphics.newImage("assets/earth/thief_icon1.png"),
	thief_big = love.graphics.newImage("assets/earth/thief_big.png"),
}

--------------------------------
-------- map1 16*7
level_config.tileMap1 = {
--	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17
	{-3,-2,-2,-3,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-3},
    {-3,-1,-1,-3,-1,-1,-1,-1,-1,-1,-4,-1,-1,-1,-1,-1,-3},
    {-3, 1, 1,-3, 1, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1,-3},
    {-3, 0, 1,-4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 0, 1,-5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 0, 1, 1, 1, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1,-3},
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
	{row=1, col=3, name="decoration", frame=3},
	{row=1, col=7, name="decoration", frame=5},
	{row=2, col=9, name="decoration", frame=2},
	{row=2, col=10, name="decoration", frame=4},
	{row=1, col=12, name="decoration", frame=3},
	{row=2, col=13, name="decoration", frame=2},

	-- floor's
	-- {row=7, col=6, name="decoration", frame=8},
	-- {row=7, col=13, name="decoration", frame=8},

	-- furniture
	{row=3, col=3, name="closet2", frame=2},
	{row=3, col=5, name="closet3"},
	{row=3, col=7, name="closet"},
	-- {row=3, col=10, name="closet"},
	{row=3, col=14, name="closet2"},
	{row=3, col=15, name="closet3"},
	{row=4, col=8, name="bed"},
	{row=4, col=12, name="chair", frame=4},
	{row=4, col=14, name="chair", frame=2},
	{row=5, col=5, name="closet4"},
	{row=6, col=7, name="chair"},
	{row=7, col=6, name="chair", frame=4},
	{row=7, col=7, name="closet",frame=3},
	{row=7, col=8, name="chair", frame=2},
	{row=7, col=10, name="closet2", frame=3},
	{row=7, col=11, name="wall"},
	{row=7, col=13, name="closet",frame=3},
	{row=7, col=14, name="bed", frame=3},
}

level_config.detective1 = {
	moves = {1, 3, 5}, 
    property = {2, 15},
    propertyHurt = {1, 0},
 
    row = 3,
    col = 2,	
}

level_config.thief1 = {
	moves = {1, 3, 5}, 
    property = {2, 15},
    propertyHurt = {2, 0},
 
    row = 6,
    col = 13,
}



--------------------------------
-------- map2 23*8
level_config.tileMap2 = {
--	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23
	{-3,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-3},
    {-3,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-3,-1,-1,-1,-1,-1,-3},
    {-3, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1, 1, 1, 1, 1,-4, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1, 1, 1, 1, 1,-5, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1, 1, 1, 1, 1,-3, 1, 1, 1, 1, 1,-3},
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
	{row=1, col=5, name="decoration", frame=3},
	{row=1, col=6, name="decoration", frame=6},
	{row=1, col=10, name="decoration", frame=6},
	{row=1, col=11, name="decoration", frame=4},
	{row=1, col=12, name="decoration", frame=2},
	{row=1, col=18, name="decoration", frame=2},
	{row=1, col=19, name="decoration", frame=6},
	{row=1, col=21, name="decoration", frame=1},
	{row=1, col=23, name="decoration", frame=3},

	-- floor's
	{row=8, col=4, name="decoration", frame=5},
	{row=5, col=13, name="decoration", frame=5},
	{row=6, col=19, name="decoration", frame=5},

	-- furniture
	{row=3, col=3, name="closet3"},
	-- {row=3, col=5, name="closet"},
	{row=3, col=6, name="plant", frame=2},
	{row=3, col=8, name="closet3"},
	{row=3, col=10, name="closet2"},
	{row=3, col=11, name="closet"},
	{row=3, col=13, name="closet3"},
	{row=3, col=15, name="closet3"},
	{row=3, col=18, name="closet2"},
	{row=3, col=19, name="closet2"},
	{row=3, col=20, name="closet2"},
	{row=3, col=21, name="closet2"},
	{row=3, col=22, name="closet2"},

	{row=4, col=2, name="closet4"},
	{row=4, col=6, name="chair", frame=4},
	-- {row=4, col=8, name="closet", frame=3},
	{row=4, col=14, name="sofa"},
	{row=4, col=18, name="closet2", frame=2},
	{row=4, col=22, name="closet2", frame=2},


	{row=5, col=6, name="chair", frame=4},
	{row=5, col=8, name="closet2", frame=2},
	-- {row=5, col=13, name="chair", frame=2},
	{row=5, col=14, name="desk", frame=3},
	{row=5, col=16, name="chair", frame=4},
	{row=5, col=20, name="chair"},

	{row=6, col=2, name="closet4"},
	{row=6, col=15, name="chair", frame=3},
	{row=6, col=20, name="desk", frame=2},

	{row=7, col=5, name="desk"},
	{row=7, col=9, name="chair", frame=2},
	{row=7, col=11, name="chair", frame=4},
	{row=7, col=20, name="chair", frame=3},

	{row=8, col=2, name="closet4"},
	{row=8, col=5, name="chair", frame=3},
	{row=8, col=8, name="plant"},
	{row=8, col=7, name="wall"},
	-- {row=8, col=9, name="closet", frame=2},
	{row=8, col=10, name="desk2", frame=2},
	{row=8, col=12, name="wall", frame=2},
	{row=8, col=15, name="closet", frame=2},
	{row=8, col=16, name="plant"},
	{row=8, col=17, name="wall"},
}


level_config.detective2 = {
	moves = 4, 
    property = 2,
    propertyHurt = 1,
 
    row = 4,
    col = 3,	
}

level_config.thief2 = {
	moves = 5, 
    property = 2,
    propertyHurt = 2,
 
    row = 8,
    col = 12,
}




--------------------------------
-------- map3 16*7

level_config.tileTexture3 = {
    -- floors
    love.graphics.newImage("assets/earth3/0.png"),
    love.graphics.newImage("assets/earth3/1.png"),
    love.graphics.newImage("assets/earth3/2.png"),

    -- walls
    love.graphics.newImage("assets/earth3/wall_5.png"),
    love.graphics.newImage("assets/earth3/wall_4.png"),
    love.graphics.newImage("assets/earth3/wall_3.png"),
    love.graphics.newImage("assets/earth3/wall_2.png"),
    love.graphics.newImage("assets/earth3/wall_1.png"),
}

level_config.detective3 = {
	moves = 4, 
    property = 3,
    propertyHurt = 1,
 
    row = 3,
    col = 2,	
}

level_config.thief3 = {
	moves = 5, 
    property = 3,
    propertyHurt = 2,
 
    row = 6,
    col = 13,
}

return level_config