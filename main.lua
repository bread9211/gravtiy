local utils = require("lua.utils")
local two = utils.two

local object = require("lua.object")
local objects = {}

local properties = utils.object({
    radius = 10,
    mass = 10,
    anchored = false,
})
local gui = utils.controls(properties)

local function new(_, event)
    local json = utils.window.JSON:stringify(properties)
    print(json)
    table.insert(objects, object:new(event.clientX, event.clientY, utils.window.JSON:parse(json)))
end

local function update(c)
    for _, v in ipairs(objects) do
        v:update(os.time())
    end

    utils.window:requestAnimationFrame(update)
end

utils.bind("mouseup", new)
update()