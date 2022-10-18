local utils = require("lua.utils")

local instances = {}

local object = {}
object.__index = object

function object:new (x, y, properties)
    local self = {
        x = x,
        y = y,

        xv = 0,
        yv = 0,

        xa = 0,
        ya = 0,

        properties = properties, -- {radius = radius, mass = mass, anchored = anchored}

        gui = utils.two:makeCircle(x, y, properties.radius)
    }

    table.insert(instances, self)
    setmetatable(self, object)

    return self
end

function object:update()
    -- universal gravitational equation: F = (G * m1 * m2) / R^2
    -- universal gravitational constant (G): 6.6743 × 10-11 m^3 / kg * s^2

    for i, v in ipairs(instances) do
        local xr = math.abs(self.x-v.x)
        local yr = math.abs(self.y-v.y)
        local xf = (6.6743*(10^-11) * self.properties.mass * v.properties.mass) / (xr^2)
        local yf = (6.6743*(10^-11) * self.properties.mass * v.properties.mass) / (yr^2)
        self.xa = self.xa + xf / self.properties.mass
        self.ya = self.ya + yf / self.properties.mass
    end

    self.xv = self.xv + self.xa
    self.yv = self.yv + self.ya
    self.x = self.x + self.xv
    self.y = self.y + self.yv


end

return object