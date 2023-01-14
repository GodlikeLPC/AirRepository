local L = LibStub("AceLocale-3.0"):NewLocale("LayerHopper", "enUS", true, true)
L = L or {}
L["Layer Hopper"] = true
L["LayerHopper"] = true
L["optionsDesc"] = [=[Layer Hopper Config (You can type /lh config to open this).
Auto inviting will be disabled automatically if inside an instance or battleground and when in a battleground queue.
]=]
L["Auto Invite"] = true
L["autoInviteDesc"] = "Enable auto invites for layer switch requests in the guild (if you turn this off you cannot be used by other guildies to switch layers)."
L["Minimap Button"] = true
L["minimapDesc"] = [=[Enable minimap button (allows for quick layer hop requests and shows current layer).
Will require a /reload if hiding the button.]=]
L["layer unknown"] = true
L["layer %s"] = true

-- Chat Messages
L["noGuildErr"] = "Layer Hopper only works when you have joined a guild."
L["inGroupErr"] = "Can't request layer hop while in a group."
L["unknownLayerErr"] = "Can't request layer hop until your layer is known. Target any NPC or mob to get current layer."
L["inInstanceErr"] = "Can't request layer hop while in an instance or battleground."
L["oldVersionErr"] = "You are running an old version of Layer Hopper, please update from curseforge!"
L["rankTooLow"] = "Can't request layer data reset unless you are class lead or higher rank."
L["requestingHop"] = "Requesting layer hop from layer %s to another layer."
L["minimapShown"] = "Minimap button shown."
L["minimapHidden"] = "Minimap button hidden. (you will need to type /reload to show changes)"
L["playerRequestedLayerReset"] = "%s requested a reset of layer data for the guild."
L["resettingLayerData"] = "Resetting layer data in the guild..."
L["printPlayerLayer"] = "%s: %s - %s - layer id: %s" -- PlayerName: layer 1 - v1.5.2 - layer id: 14

-- Console
L["configConsole"] = "Open/close configuration window"
L["layerHopConsole"] = "Request a layer hop"
L["listLayersConsole"] = "List layers and versions for all guildies"
L["resetLayersConsole"] = "Reset layer data for all guildies. (can only be done by class lead rank or above)"
L["toggleMinimapConsole"] = "Toggle minimap button."

-- Minimap Icon Text
L["paused"] = "Resetting layer data for the guild. Should only take a few more seconds..."
L["unknownLayer"] = [=[Unknown Layer. Target any NPC or mob to get current layer.
(layer id: %s, min: %s, max: %s)]=]
L["minMaxUnknown"] = "Min/max layer IDs are unknown."
L["rangeTooSmall"] = "Min/max layer ID range is not large enough."
L["needMoreData"] = [=[Need more data from guild to determine current layer.
(layer id: %s, min: %s, max: %s)]=]
L["currentLayer"] = [=[Current Layer: %s
(layer id: %s, min: %s, max: %s)]=]
L["minimapLeftClickAction"] = "Left click to request a layer hop."
L["minimapRightClickAction"] = "Right click to access Layer Hopper settings."
L["minimapOtherOptions"] = "/lh to see other options"

-- Mob Error
L["mobErrTitle"] = "YOU HAVE ENCOUNTERED A MOB THAT BREAKS LAYER HOPPER!"
L["mobErrName"] = "MOB NAME: %s"
L["mobErrGUID"] = "MOB GUID: %s"
L["mobErrZone"] = "ZONE: %s"
L["mobErrGithub"] = "PLEASE SEND THIS INFORMATION TO KUTANO (OR REPORT ON GITHUB github.com/psynct/LayerHopper)!"
