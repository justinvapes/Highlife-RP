local enableThis = true

local MapZoomData = {
	[0] = {
		zoomScale = 0.96,
		zoomSpeed = 0.9,
		scrollSpeed = 0.08,
		tiles = {x = 0.0, y = 0.0}
	},
	[1] = {
		zoomScale = 1.6,
		zoomSpeed = 0.9,
		scrollSpeed = 0.08,
		tiles = {x = 0.0, y = 0.0}
	},
	[2] = {
		zoomScale = 8.6,
		zoomSpeed = 0.9,
		scrollSpeed = 0.08,
		tiles = {x = 0.0, y = 0.0}
	},
	[3] = {
		zoomScale = 12.3,
		zoomSpeed = 0.9,
		scrollSpeed = 0.08,
		tiles = {x = 0.0, y = 0.0}
	},
	[4] = {
		zoomScale = 24.3,
		zoomSpeed = 0.9,
		scrollSpeed = 0.08,
		tiles = {x = 0.0, y = 0.0}
	},
	[5] = { -- ZOOM_LEVEL_GOLF_COURSE
		zoomScale = 55.0,
		zoomSpeed = 0.0,
		scrollSpeed = 0.1,
		tiles = {x = 2.0, y = 1.0}
	},
	[6] = { -- ZOOM_LEVEL_INTERIOR
		zoomScale = 450.0,
		zoomSpeed = 0.0,
		scrollSpeed = 0.1,
		tiles = {x = 1.0, y = 1.0}
	},
	[7] = { -- ZOOM_LEVEL_GALLERY
		zoomScale = 4.5,
		zoomSpeed = 0.0,
		scrollSpeed = 0.0,
		tiles = {x = 0.0, y = 0.0}
	},
	[8] = { -- ZOOM_LEVEL_GALLERY_MAXIMIZE
		zoomScale = 11.0,
		zoomSpeed = 0.0,
		scrollSpeed = 0.0,
		tiles = {x = 2.0, y = 3.0}
	},
}

if enableThis then
	-- print('attempting custom map data')

	for k,v in pairs(MapZoomData) do
		-- print('setting ' .. k .. ' with vars: ', v.zoomScale, v.zoomSpeed, v.scrollSpeed, v.tiles.x, v.tiles.y)
		SetMapZoomDataLevel(k, v.zoomScale, v.zoomSpeed, v.scrollSpeed, v.tiles.x, v.tiles.y)
	end

	-- debug? 10 max idk
	-- for i=1, 10 do
	-- 	local available, zoomScale, zoomSpeed, scrollSpeed, tilesX, tilesY = GetMapZoomDataLevel(i)

	-- 	if available then
	-- 		print('getting ' .. i .. ' with vars: ', zoomScale, zoomSpeed, scrollSpeed, tilesX, tilesY)
	-- 	end
	-- end
end