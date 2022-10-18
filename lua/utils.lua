local window = js.global
local document = window.document
local screen = document:getElementById("screen")
local two = window.Two
local dat = window.dat

local function new(object, ...)
    return js.new(object, table.unpack({...}))
end

local function bind(event, f)
    document:addEventListener(event, f, false)
    print("binded to " .. event)
end

local function object(table)
	local o = js.new(window.Object)

    for key, value in pairs(table) do
        if(type(value) == "table") then
            o[key] = object(value)
        else
			assert(type(key) == "string" or js.typeof(key) == "symbol", "JavaScript only has string and symbol keys")
            o[key] = value
        end
    end

	return o
end

local function controls(t)
    local self = {}
    self.table = t
    self.dat = new(dat.GUI, {width = 300})

    for i, _ in pairs(t) do
        self.dat:add(self.table, i, 1)
    end

    return self
end

return {
    window = window,print("utils"),
    document = document,print("utils"),
    screen = screen,print("utils"),
    two = new(two, object({
        fullscreen = true,
        domElement = screen,
        -- autoStart = true,
    })),

    bind = bind,
    new = new,
    object = object,
    controls = controls,
}