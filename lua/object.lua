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

        properties = properties, -- {radius = radius, mass = mass, anchored = anchored}

        gui = utils.two:makeCircle(x, y, properties.radius),

        dt = os.time(),
    }

    self = setmetatable(self, object)

    table.insert(instances, self)

    return self
end

function object:update(dt)
    -- universal gravitational equation: F = (G * m1 * m2) / R^2
    -- universal gravitational constant (G): 6.6743 × 10-11 m^3 / kg * s^2

    if (#instances > 1) then
        for i, v in ipairs(instances) do
            if (self == v) then goto a end

            local xr = math.abs(self.x-v.x)
            local yr = math.abs(self.y-v.y)

            local d = math.sqrt(xr^2 + yr^2);
            -- minimum translation distance to push balls apart after intersecting
            local mtdx = (self.x-v.x) * ((self.properties.radius + v.properties.radius)-d)/d
            local mtdy = (self.y-v.y) * ((self.properties.radius + v.properties.radius)-d)/d

            -- resolve intersection --
            -- inverse mass quantities
            local im1 = 1 / self.properties.mass
            local im2 = 1 / v.properties.mass

            -- push-pull them apart based off their mass
            self.x = self.x + (mtdx * (im1 / (im1 + im2)))
            self.y = self.y + (mtdy * (im1 / (im1 + im2)))
            v.x = v.x - (mtdx * (im2 / (im1 + im2)))
            v.y = v.y - (mtdy * (im2 / (im1 + im2)))

            local xf = (6.6743*(10^-11) * self.properties.mass * v.properties.mass) / (xr^2)
            local yf = (6.6743*(10^-11) * self.properties.mass * v.properties.mass) / (yr^2)
            print(xf, yf)

            self.xv = self.xv + xf / self.properties.mass
            self.yv = self.yv + yf / self.properties.mass
            ::a::
        end
    end

    print(self.xv, self.yv)

    self.x = self.x + self.xv
    self.y = self.y + self.yv

    self.dt = dt
    self.gui.translation:set(self.x, self.y)
    utils.two:update()
    -- self.gui.translation.y = self.y

    -- print(self.x, self.y, self.xv, self.yv, self.xa, self.ya)
end

return object