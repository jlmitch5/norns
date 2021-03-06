--- Number class
-- @module number

local Number = {}
Number.__index = Number

local tNUMBER = 1

function Number.new(id, name, min, max, default)
  local o = setmetatable({}, Number)
  o.t = tNUMBER
  o.id = id
  o.name = name
  o.default = default or 0
  o.value = o.default
  o.min = min or -2147483648
  o.max = max or 2147483647 -- 32 bit signed
  o.action = function() end
  return o
end

function Number:get()
  return self.value
end

function Number:set(v)
  local c = util.clamp(v,self.min,self.max)
  if self.value ~= c then
    self.value = c
    self:bang()
  end
end

function Number:delta(d)
  self:set(self:get() + d)
end

function Number:set_default()
  self:set(self.default)
end

function Number:bang()
  self.action(self.value)
end

function Number:string()
  return self.value
end


return Number
