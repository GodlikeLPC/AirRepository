local DGV = DugisGuideViewer

local UIE = DGV:RegisterModule("UIEventHandlers")
UIE.essential = true

DGVUIFrameMixin = {}

local function GetHandler(widget)
    local handlerKey = widget.DGVEventKey or select(3,strfind(widget:GetDebugName(), "%.?([^%.]+)$"))
    return handlerKey and UIE[handlerKey]
end

local function InitInternal(widget)
    if widget.UIEInitialized then return end
    local handler = GetHandler(widget)
    if handler then
        for scriptName, script in next, handler do
            if type(script) == "function" then
                if scriptName == "Once" then
                    script(widget)
                else
                    widget:HookScript(scriptName, script)
                end
            end
        end
    end
    widget.UIEInitialized = true
end

function DGVUIFrameMixin:OnUpdate()
    InitInternal(self)
end

function DGVUIFrameMixin:OnShow()
    InitInternal(self)
end

function DGVUIFrameMixin:OnLoad()
    InitInternal(self)
end

function UIE:Initialize()
end