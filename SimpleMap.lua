local SimpleMap = {}

-------- map1 16*7
local tileMap1 = {
--	 1	2	3 4	 5	6 	7 8  9  10 11 12 13 14 15 16 17
	{-3,-2,-2,-3,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2,-2,-3},
    {-3,-1,-1,-3,-1,-1,-1,-1,-1,-1,-4,-1,-1,-1,-1,-1,-3},
    {-3, 1, 1,-3, 1, 1, 1, 1, 1, 0,-5, 0, 0, 1, 1, 1,-3},
    {-3, 1, 0,-4, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,-3},
    {-3, 1, 0,-5, 1, 1, 1, 1, 1, 1, -3,1, 1, 1, 1, 1,-3},
    {-3, 1, 1, 1, 1, 1, 1, 1, 1, 0, -4,1, 1, 1, 1, 1,-3},
    {-3, 0, 1, 1, 1, 1, 1, 1, 0, 1, -5,0, 1, 1, 1, 0,-3},
}


--1 love.graphics.newImage("res/earth/pic_b1.png"),
--2 love.graphics.newImage("res/earth/pic_b2.png"),
--3 love.graphics.newImage("res/earth/pic_s1.png"),
--4 love.graphics.newImage("res/earth/pic_s2.png"),
--5 love.graphics.newImage("res/earth/clock.png"),
--6 love.graphics.newImage("res/earth/door.png"),
--7 love.graphics.newImage("res/earth/door2.png"),
--8 love.graphics.newImage("res/earth/carpet.png"),
local propertyMap1 = {
	-- wall's
	{row=2, col=2, name="decoration", frame=6},
	{row=1, col=3, name="decoration", frame=3},
	{row=1, col=7, name="decoration", frame=5},
	{row=2, col=9, name="decoration", frame=2},
	{row=2, col=10, name="decoration", frame=4},
	{row=1, col=12, name="decoration", frame=3},
	{row=2, col=13, name="decoration", frame=2},

	-- floor's
	{row=7, col=6, name="decoration", frame=8},
	{row=7, col=13, name="decoration", frame=8},

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
	{row=7, col=13, name="closet",frame=3},
	{row=7, col=14, name="bed", frame=3},
}

SimpleMap.tileMap1 = tileMap1
SimpleMap.propertyMap1 = propertyMap1

return SimpleMap