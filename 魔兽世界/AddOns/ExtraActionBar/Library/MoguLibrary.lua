
--  BLibrary_226f708186be917ad2bc613c0e64ca55

local Super = {};
function Super:new()
    local BLib = {};
    setmetatable(BLib, self);
    if (self.__index ~= self) then
        self.__index = self;
    end
    BLib:constructor();
    return BLib;
end

function Super:constructor()
    self.db = {};
end

function Super:Register(meta, lib, major, minor)
    assert(meta and type(meta) == "table", "The class must be specified.");
    assert(meta.constructor, "The method <constructor> must be defined.");
    assert(lib and type(lib) == "string", "The type of parameter metarary must be string.");
    if (self.db[lib]) then
        error(string.format("The metarary <%s> has been registered.", lib));
        return false;
    end
    if (meta.__index ~= meta) then
        meta.__index = meta;
    end
    self.db[lib] = {};
    self.db[lib].meta = meta;
    self.db[lib].major = major;
    self.db[lib].minor = minor;
    return true;
end

local function CreateInstance(self, lib, ...)
    assert(lib and type(lib) == "string", "The type of parameter metarary must be string.");
    assert(self.db[lib], string.format("The metarary <%s> does not exist.", lib));
    local instance = setmetatable({}, self.db[lib].meta);
    instance:constructor(...);
    return instance;
end

Super.CreateInstance = CreateInstance;
function Super:GetClass(lib)
    assert(lib and type(lib) == "string", "The type of parameter metarary must be string.");
    if (self.db[lib] and self.db[lib].meta) then
        return self.db[lib].meta;
    else
        return false;
    end
end

BLibrary = Super:new();
getmetatable(BLibrary).__call = CreateInstance;
