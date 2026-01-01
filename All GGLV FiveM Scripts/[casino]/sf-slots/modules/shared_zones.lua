-- Thanks to https://github.com/overextended/ox_lib/blob/master/imports/zones/server.lua
local glm = require 'glm'
local Zones = {}
local glm_polygon_contains = glm.polygon.contains

local function removeZone(self)
    Zones[self.id] = nil
end

local function zoneContains(self, coords)
    return glm_polygon_contains(self.polygon, coords, self.thickness / 4)
end

function CreatePolyZone(points, thickness)
    local self = {}

    self.id = #Zones + 1
    self.polygon = glm.polygon.new(points)
    self.contains = zoneContains
    self.remove = removeZone
    self.thickness = thickness or 4

    Zones[self.id] = self
    return self
end

function CreateBoxZone(coords, width, length, minZ, maxZ, thickness)
    local self = {}

    local size = vec3(width, length, (math.abs(maxZ - minZ)))/2
    self.id = #Zones + 1
    self.polygon = (quat(coords.w or 0, vec3(0, 0, 1)) * glm.polygon.new({
        vec3(size.x, size.y, 0),
        vec3(-size.x, size.y, 0),
        vec3(-size.x, -size.y, 0),
        vec3(size.x, -size.y, 0),
    }) + coords.xyz)
    self.contains = zoneContains
    self.remove = removeZone
    self.thickness = thickness or 4

    Zones[self.id] = self
    return self
end