local L = LibStub("AceLocale-3.0"):NewLocale("LayerHopper", "koKR")
L = L or {}
L["Auto Invite"] = "Auto Invite"
L["autoInviteDesc"] = "Enable auto invites for layer switch requests in the guild (if you turn this off you cannot be used by other guildies to switch layers)."
L["layer %s"] = "레이어 %s"
L["Layer Hopper"] = "Layer Hopper"
L["layer unknown"] = "layer unknown"
L["LayerHopper"] = "LayerHopper"
L["Minimap Button"] = "미니맵 버튼"
L["minimapDesc"] = [=[Enable minimap button (allows for quick layer hop requests and shows current layer).
Will require a /reload if hiding the button.]=]
L["optionsDesc"] = [=[Layer Hopper Config (You can type /lh config to open this).
Auto inviting will be disabled automatically if inside an instance or battleground and when in a battleground queue.
]=]

-- Chat Messages
L["inGroupErr"] = "Can't request layer hop while in a group."
L["inInstanceErr"] = "Can't request layer hop while in an instance or battleground."
L["minimapHidden"] = "Minimap button hidden. (you will need to type /reload to show changes)"
L["minimapShown"] = "Minimap button shown."
L["noGuildErr"] = "Layer Hopper only works when you have joined a guild."
L["oldVersionErr"] = "You are running an old version of Layer Hopper, please update from curseforge!"
L["playerRequestedLayerReset"] = "%s requested a reset of layer data for the guild."
L["printPlayerLayer"] = "%s: %s - %s - layer id: %s"
L["rankTooLow"] = "Can't request layer data reset unless you are class lead or higher rank."
L["requestingHop"] = "Requesting layer hop from layer %s to another layer."
L["resettingLayerData"] = "Resetting layer data in the guild..."
L["unknownLayerErr"] = "Can't request layer hop until your layer is known. Target any NPC or mob to get current layer."

-- Console
L["configConsole"] = "Open/close configuration window"
L["layerHopConsole"] = "Request a layer hop"
L["listLayersConsole"] = "List layers and versions for all guildies"
L["resetLayersConsole"] = "Reset layer data for all guildies. (can only be done by class lead rank or above)"
L["toggleMinimapConsole"] = "Toggle minimap button."

-- Minimap Icon Text
L["currentLayer"] = [=[Current Layer: %s
(layer id: %s, min: %s, max: %s)]=]
L["minimapLeftClickAction"] = "Left click to request a layer hop."
L["minimapOtherOptions"] = "/lh to see other options"
L["minimapRightClickAction"] = "Right click to access Layer Hopper settings."
L["minMaxUnknown"] = "Min/max layer IDs are unknown."
L["needMoreData"] = [=[Need more data from guild to determine current layer.
(layer id: %s, min: %s, max: %s)]=]
L["paused"] = "Resetting layer data for the guild. Should only take a few more seconds..."
L["rangeTooSmall"] = "Min/max layer ID range is not large enough."
L["unknownLayer"] = [=[Unknown Layer. Target any NPC or mob to get current layer.
(layer id: %s, min: %s, max: %s)]=]

-- Mob Error
L["mobErrGithub"] = "PLEASE SEND THIS INFORMATION TO KUTANO (OR REPORT ON GITHUB github.com/psynct/LayerHopper)!"
L["mobErrGUID"] = "MOB GUID: %s"
L["mobErrName"] = "MOB NAME: %s"
L["mobErrTitle"] = "YOU HAVE ENCOUNTERED A MOB THAT BREAKS LAYER HOPPER!"
L["mobErrZone"] = "ZONE: %s"
