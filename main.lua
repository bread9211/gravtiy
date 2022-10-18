local utils = require("lua.utils")
local two = utils.two

local object = require("lua.object")
local objects = {}

local properties = {
    radius = 10,
    mass = 10,
    anchored = false,
}
local gui = utils.controls(properties)

local function new(_, event)
    object:new(event.clientX, event.clientY, properties)
end

local function update(c)
    for i, v in ipairs(objects) do
        v:update()
        
    end
end

utils.bind("mouseup", new)