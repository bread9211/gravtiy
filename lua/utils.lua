local window = js.global
local document = window.document
local screen = document:getElementById("screen")
local two = window.Two

local dat = window.dat

local function new(object, ...)
    return js.new(object, table.unpack(...))
end

local function bind(event, f)
    document:addEventListener(event, f, false)
    print("binded to " .. event)
end

local function object(t)
    local o = new(window.Object)

    for i, v in ipairs(t) do
        o[i] = v
    end

    return o
end

local function controls(t)
    local self = {}

    self.dat = new(dat.GUI, t)
    self.dat:show()

    for i, _ in ipairs(t) do
        self.dat:add(t, i)
    end

    return self
end

return {
    window = window,
    document = document,
    screen = screen,
    two = new(two, object({
        fullscreen = true,
        domElement = screen,
        autoStart = true,
    })),

    bind = bind,
    new = new,
    object = object,
    controls = controls,
}