local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local RAW_LUA_CODE = [==[
-- ===== ACID PACK START =====
local UserInputService = game:GetService("UserInputService")
local acidCloneref
do
    local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    if isMobile then acidCloneref = function(x) return x end
    elseif type(cloneref) == 'function' then acidCloneref = function(x) local ok, c = pcall(cloneref, x); return ok and c or x end
    elseif type(clonereference) == 'function' then acidCloneref = function(x) local ok, c = pcall(clonereference, x); return ok and c or x end
    else acidCloneref = function(x) return x end end
end
if type(setthreadidentity) == 'function' and not UserInputService.TouchEnabled then pcall(setthreadidentity, 8) end

local Players = acidCloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local _waitCount = 0
while not LocalPlayer and _waitCount < 30 do task.wait(0.1); _waitCount = _waitCount + 1; LocalPlayer = Players.LocalPlayer end
if not LocalPlayer then return end

local TweenService = acidCloneref(game:GetService("TweenService"))
local RunService = acidCloneref(game:GetService("RunService"))
local HttpService = acidCloneref(game:GetService("HttpService"))
local Lighting = acidCloneref(game:GetService("Lighting"))
local ReplicatedStorage = acidCloneref(game:GetService("ReplicatedStorage"))
local Workspace = acidCloneref(game:GetService("Workspace"))
local VirtualUser = acidCloneref(game:GetService("VirtualUser"))

pcall(function()
    if getgenv().AcidFlyConn then getgenv().AcidFlyConn:Disconnect() end
    if getgenv().AcidNoclipConn then getgenv().AcidNoclipConn:Disconnect() end
    RunService:UnbindFromRenderStep("AcidFakePosCam")
    RunService:UnbindFromRenderStep("AcidFakePosRestore")
    RunService:UnbindFromRenderStep("AcidAntiAim")
    RunService:UnbindFromRenderStep("AcidWallbang")
    RunService:UnbindFromRenderStep("AcidRagebotSnap")
end)
getgenv().AcidFlyConn = nil
getgenv().AcidNoclipConn = nil

local Config = {
    AuraEnabled = true, AuraIntensity = 25, AuraSize = 6,
    AuraTransparency = 0.45, AuraSpeed = 1.8, AuraLifetime = 3.0, AuraGlowIntensity = 2,
    ESPEnabled = true, ESPShowName = true, ESPShowHealth = true,
    ESPShowDistance = true, ESPShowHealthBar = true, ESPBoxThickness = 1.5,
    ESPColorHex = "FFFFFF", ESPTeamCheck = true,
    OrbitEnabled = false, OrbitSpeed = 90, OrbitDist = 8, OrbitHeight = 0, OrbitLerp = 0.3, OrbitMode = "Circle", OrbitPredict = false, OrbitPredStrength = 0.2, OrbitFaceTarget = true, OrbitAutoLockDist = 50,
    OverlayEnabled = true, OverlayTransparency = 0.55, OverlayColorHex = "140A2D",
    FlyEnabled = false, FlySpeed = 50,
    NoclipEnabled = false,
    WalkSpeedEnabled = false, WalkSpeedMultiplier = 2,
    SlidingEnabled = false, SlidingMultiplier = 10,
    JumpPowerEnabled = false, JumpPowerMultiplier = 2,
    InfDoubleJumpEnabled = false, InfDoubleJumpValue = 676767,
    AntiAimEnabled = false, AntiAimMode = "Spin", AntiAimSpeed = 5000, AntiAimAngle = 90, AntiAimRandomSpeed = true,
    WallbangEnabled = false,
    SinkEnabled = false, SinkDepth = 5.8,
    FakePosEnabled = false,
    FakePosPattern = "Walk", FakePosDistribution = "Random", FakePosAxisLock = "None",
    FakePosRadius = 500, FakePosHeight = 0, FakePosSpeed = 50, FakePosCount = 5,
    FakePosReverse = false, FakePosRandomRadius = false, FakePosHideClientPos = false,
    PredictionEnabled = false, PredictionRadius = 20, PredictionDodgeDist = 30, PredictionCooldown = 0.3, PredictionThreshold = 800, PredictionMult = 1,
    EvasionEnabled = false, EvasionIntensity = 3.0,
    TPEnabled = false, TPMode = "Follow", TPDistance = 3, TPHeight = 3.5,
    VoidEnabled = false, VoidX = 1e8, VoidY = 1e8, VoidZ = 1e8,
    RiotEnabled = false, RiotSpeed = 0.03, RiotRange = 50, RiotEvadeRange = 30, RiotSpinSpeed = 180,
    RiotAbuseEnabled = false, RiotAbuseMode = "Stick", RiotAbuseHeight = 3, RiotAbuseForward = 0, RiotAbuseRight = 0, RiotAbuseDown = 0,
    MainRagebotEnabled = false, RagebotMode = "Backstab",
    RagebotYaw = 180, RagebotDistance = 0, RagebotHeight = 1.5, RagebotAvoidMelee = true,
    RagebotJitterStrength = 4.5, RagebotOnlyOnAttack = false, RagebotWaitGodEnd = false,
    RagebotPauseOnReload = true, RagebotAntiBait = true, RagebotSafeMargin = 100,
    RagebotVoidHunter = false,
    WingsEnabled = true, WingsColorHex = "8C64FF", WingsSize = 5.0,
    WingsSpread = 3.5, WingsHeight = 3.0, WingsFlapSpeed = 2.0,
    WingsShowFeathers = true, WingsShowGlow = true,
    WorldTintEnabled = false, WorldTintColorHex = "9C7CFF",
    WorldBrightness = 0, WorldContrast = 0, WorldSaturation = 0,
    AutoHealEnabled = false, AutoAmmoPickupEnabled = false,
    AutoHealMinMissing = 25, AutoAmmoMinAmmo = 0,
    AutoRespawnEnabled = false, AutoRespawnInterval = 1, AutoRespawnBurst = 5,
    FakePosDepth = 5.8, FakePosWalkMode = true, FakePosSurfaceCamera = true,
    FakePosAutoNoclip = true, FakePosAutoHandoff = true, FakePosVisualizer = true,
    FakePosPanic = true, FakePosPanicMinX = -5, FakePosPanicMaxX = 5, FakePosPanicZ = true,
    FakePosHideMeshes = true, FakePosAnimDesync = true, FakePosZeroVelocity = true,
    FakePosCustomPitch = 0, FakePosCustomYaw = 0, FakePosInvertPitch = true,
    RagebotTrackBoost = 3, RagebotSnapReps = 6, RagebotAimLead = false,
    LuaAutoLoadScripts = {},
}

local function colorToHex(c) return string.format("%02X%02X%02X", math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5)) end
local function hexToColor(h, fb) fb = fb or Color3.fromRGB(255,255,255); if type(h)~="string" or #h~=6 then return fb end; return Color3.fromRGB(tonumber(h:sub(1,2),16) or 255, tonumber(h:sub(3,4),16) or 255, tonumber(h:sub(5,6),16) or 255) end
local function sanitizeConfigForJSON(cfg) local out={}; for k,v in pairs(cfg) do local vt=type(v); if vt=="string" or vt=="number" or vt=="boolean" or vt=="table" then out[k]=v end end return out end

local ROOT_FOLDER = "acid the best femboy"
local PROFILES_FOLDER = ROOT_FOLDER .. "/profiles"
local GLOBAL_CFG_FILE = ROOT_FOLDER .. "/global_config.json"
local ACTIVE_PROFILE_FILE = ROOT_FOLDER .. "/active_profile.txt"
local LEGACY_CFG_FILE = "acid_pack_config.json"

local function acidEnsureFolders()
    local function mf(p) if type(isfolder)=="function" and type(makefolder)=="function" and not isfolder(p) then pcall(makefolder,p) end end
    pcall(mf, ROOT_FOLDER); pcall(mf, PROFILES_FOLDER)
end
acidEnsureFolders()

local function acidSafeWrite(p,c) return pcall(writefile,p,c) end
local function acidSafeRead(p) local ok,d=pcall(readfile,p); return ok and d or nil end
local function acidSafeDelete(p) pcall(delfile,p) end
local function acidSafeExists(p) if type(isfile)~="function" then return false end; local ok,e=pcall(isfile,p); return ok and e end
local function acidJSONEncode(t) local ok,s=pcall(function() return HttpService:JSONEncode(t) end) return ok and s or nil end
local function acidJSONDecode(s) local ok,t=pcall(function() return HttpService:JSONDecode(s) end) return ok and t or nil end

local function acidSyncColorsToHex()
    if Config.ESPColor then Config.ESPColorHex = colorToHex(Config.ESPColor) end
    if Config.WingsColor then Config.WingsColorHex = colorToHex(Config.WingsColor) end
    if Config.WorldTintColor then Config.WorldTintColorHex = colorToHex(Config.WorldTintColor) end
    if Config.OverlayColor then Config.OverlayColorHex = colorToHex(Config.OverlayColor) end
end
local function acidSnapshot() acidSyncColorsToHex(); return sanitizeConfigForJSON(Config) end
local function acidMerge(data) if type(data)~="table" then return end; for k,v in pairs(data) do if Config[k]~=nil and type(v)==type(Config[k]) then Config[k]=v end end end

local function acidGetActive() local s=acidSafeRead(ACTIVE_PROFILE_FILE); if type(s)=="string" then s=s:gsub("[\r\n]+$",""); if s~="" then return s end end return nil end
local function acidSetActive(name)
    if type(name)=="string" and name~="" then acidSafeWrite(ACTIVE_PROFILE_FILE,name) else acidSafeDelete(ACTIVE_PROFILE_FILE) end
end
local function acidProfilePath(name)
    local safe = tostring(name):gsub("[^%w%-%_ ]",""):sub(1,48)
    return PROFILES_FOLDER .. "/" .. safe .. ".json"
end
local function acidListProfiles()
    local names={}
    if type(listfiles)~="function" then return names end
    acidEnsureFolders()
    local ok,files = pcall(listfiles, PROFILES_FOLDER)
    if not ok or type(files)~="table" then return names end
    for _,path in ipairs(files) do local n=path:match("([^/\\]+)%.json$"); if n then table.insert(names,n) end end
    table.sort(names); return names
end
local function acidProfileExists(name) return type(name)=="string" and name~="" and acidSafeExists(acidProfilePath(name)) end

local function acidSaveProfile(name)
    name = tostring(name or ""):match("^%s*(.-)%s*$")
    if name=="" then return false,"Enter a profile name" end
    if type(writefile)~="function" then return false,"writefile unavailable" end
    acidEnsureFolders()
    local s = acidJSONEncode(acidSnapshot())
    if not s then return false,"Encode failed" end
    local ok,err = acidSafeWrite(acidProfilePath(name), s)
    if not ok then return false, tostring(err) end
    -- acidSetActive(name) REMOVED
    return true, "Saved: "..name
end
local function acidLoadProfile(name)
    if type(name)~="string" or name=="" then return false,"Enter a profile name" end
    local raw = acidSafeRead(acidProfilePath(name))
    if not raw or #raw==0 then return false,"Profile not found" end
    local data = acidJSONDecode(raw)
    if type(data)~="table" then return false,"Corrupted profile" end
    acidMerge(data); acidSetActive(name); return true, "Loaded: "..name
end
local function acidDeleteProfile(name)
    if type(name)~="string" or name=="" then return false,"Enter a profile name" end
    if not acidProfileExists(name) then return false,"Not found" end
    acidSafeDelete(acidProfilePath(name))
    if acidGetActive()==name then acidSetActive(nil) end
    return true, "Deleted: "..name
end
local function acidSaveGlobal()
    acidEnsureFolders()
    local s = acidJSONEncode(acidSnapshot())
    if s then acidSafeWrite(GLOBAL_CFG_FILE, s); acidSafeWrite(LEGACY_CFG_FILE, s) end
end
local function acidLoadGlobal()
    local raw = acidSafeRead(GLOBAL_CFG_FILE)
    if not raw or #raw==0 then raw = acidSafeRead(LEGACY_CFG_FILE) end
    if not raw or #raw==0 then return end
    local data = acidJSONDecode(raw)
    if type(data)~="table" then return end
    acidMerge(data)
    if type(data.LuaAutoLoadScript)=="string" and data.LuaAutoLoadScript~="" then
        Config.LuaAutoLoadScripts = Config.LuaAutoLoadScripts or {}
        Config.LuaAutoLoadScripts[data.LuaAutoLoadScript] = true
    end
end
local function SaveConfig() acidSaveGlobal() end
local function LoadConfig() acidLoadGlobal() end

LoadConfig()
acidEnsureFolders()
Config.ESPColor = hexToColor(Config.ESPColorHex, Color3.fromRGB(255,255,255))
Config.WingsColor = hexToColor(Config.WingsColorHex, Color3.fromRGB(140,100,255))
Config.WorldTintColor = hexToColor(Config.WorldTintColorHex, Color3.fromRGB(156,124,255))
Config.OverlayColor = hexToColor(Config.OverlayColorHex, Color3.fromRGB(20,10,45))

local LUA_SCRIPTS_FILE = "acid_lua_scripts.json"
local LuaScriptStorage = { Scripts = {} }
local function LuaScriptStorageLoad() pcall(function() if type(isfile)=="function" and type(readfile)=="function" and isfile(LUA_SCRIPTS_FILE) then local raw=readfile(LUA_SCRIPTS_FILE); if type(raw)=="string" and #raw>0 then local decoded=HttpService:JSONDecode(raw); if type(decoded)=="table" then LuaScriptStorage.Scripts=decoded end end end end) end
local function LuaScriptStorageSave() pcall(function() if type(writefile)=="function" then writefile(LUA_SCRIPTS_FILE, HttpService:JSONEncode(LuaScriptStorage.Scripts)) end end) end
LuaScriptStorageLoad()

local TargetParent
do
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then pg = LocalPlayer:WaitForChild("PlayerGui", 5) end
    if pg then TargetParent = pg else local ok,hui=pcall(function() return gethui() end); TargetParent=(ok and hui) or game:GetService("CoreGui") end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name="AcidPackUI"; ScreenGui.ResetOnSpawn=false; ScreenGui.IgnoreGuiInset=true
ScreenGui.DisplayOrder=2147483647; ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.Parent=TargetParent

local StartBtn = Instance.new("TextButton")
StartBtn.Size=UDim2.new(0,220,0,64); StartBtn.Position=UDim2.new(0.5,-110,0.5,-32)
StartBtn.BackgroundColor3=Color3.fromRGB(20,20,30); StartBtn.BorderColor3=Color3.fromRGB(90,70,180)
StartBtn.BorderSizePixel=1; StartBtn.Font=Enum.Font.Code; StartBtn.Text="▶ START"
StartBtn.TextColor3=Color3.fromRGB(180,210,255); StartBtn.TextSize=22
StartBtn.Active=true; StartBtn.Modal=false; StartBtn.ZIndex=2147483000; StartBtn.Parent=ScreenGui

local sbD,sbS,sbSP
StartBtn.InputBegan:Connect(function(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then sbD=true; sbS=i.Position; sbSP=StartBtn.Position end end)
UserInputService.InputChanged:Connect(function(i) if not sbD then return end; local t=i.UserInputType; if t==Enum.UserInputType.MouseMovement or t==Enum.UserInputType.Touch then local d=i.Position-sbS; StartBtn.Position=UDim2.new(sbSP.X.Scale, sbSP.X.Offset+d.X, sbSP.Y.Scale, sbSP.Y.Offset+d.Y) end end)
UserInputService.InputEnded:Connect(function(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then sbD=false end end)

local built = false

local function BuildAll()
    if built then return end
    built = true

    local isUnloaded = false
    local Connections = {}
    local function TC(c) if c then table.insert(Connections,c) end return c end
    local UIRefreshers = {}
    local function registerRefresh(fn) if type(fn)=="function" then table.insert(UIRefreshers,fn) end end
    local function refreshAllUI() for _,fn in ipairs(UIRefreshers) do pcall(fn) end end
    local RefreshSinkToggle = nil
    local RefreshFakeToggle = nil
    local RebuildConfigInventory = function() end

    local function notify(t,b,d)
        if isUnloaded then return end
        d=d or 3
        local n=Instance.new("Frame"); n.Size=UDim2.new(0,260,0,52); n.Position=UDim2.new(0,-280,1,-70)
        n.BackgroundColor3=Color3.fromRGB(15,15,22); n.BorderColor3=Color3.fromRGB(90,70,180); n.BorderSizePixel=1; n.ZIndex=10001; n.Parent=ScreenGui
        local ab=Instance.new("Frame"); ab.Size=UDim2.new(0,3,1,0); ab.BackgroundColor3=Color3.fromRGB(140,180,255); ab.BorderSizePixel=0; ab.ZIndex=10002; ab.Parent=n
        local t1=Instance.new("TextLabel"); t1.Size=UDim2.new(1,-15,0,20); t1.Position=UDim2.new(0,12,0,6); t1.BackgroundTransparency=1; t1.Font=Enum.Font.Code; t1.Text=t; t1.TextColor3=Color3.fromRGB(160,200,255); t1.TextSize=12; t1.TextXAlignment=Enum.TextXAlignment.Left; t1.ZIndex=10002; t1.Parent=n
        local t2=Instance.new("TextLabel"); t2.Size=UDim2.new(1,-15,0,20); t2.Position=UDim2.new(0,12,0,26); t2.BackgroundTransparency=1; t2.Font=Enum.Font.Code; t2.Text=b; t2.TextColor3=Color3.fromRGB(200,200,210); t2.TextSize=11; t2.TextXAlignment=Enum.TextXAlignment.Left; t2.ZIndex=10002; t2.Parent=n
        TweenService:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,15,1,-70)}):Play()
        task.delay(d,function() if not isUnloaded and n and n.Parent then local tw=TweenService:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(0,-280,1,-70)}); tw:Play(); tw.Completed:Connect(function() n:Destroy() end) end end)
    end

    local function resolveLs()
        if type(loadstring)=="function" then return loadstring end
        if type(load)=="function" then return load end
        local env=getgenv and getgenv() or _G
        if env and type(env.loadstring)=="function" then return env.loadstring end
        if env and type(env.load)=="function" then return env.load end
        return nil
    end
    local function runAllLuaAutoloads(tag)
        tag = tag or "init"
        local ls = resolveLs()
        if not ls then pcall(function() notify("Lua AutoLoad","["..tag.."] No loadstring",4) end); return false end
        local ran = 0
        for name, enabled in pairs(Config.LuaAutoLoadScripts or {}) do
            if enabled == true and type(name)=="string" and name~="" then
                local data = LuaScriptStorage.Scripts[name]
                if data and type(data.Code)=="string" and #data.Code>0 then
                    local fn,err = ls(data.Code)
                    if not fn then pcall(function() notify("Lua AutoLoad","["..tag.."] "..name..": "..tostring(err),4) end)
                    else
                        local ok,runErr = pcall(fn)
                        if not ok then warn("[Lua AutoLoad]["..tag.."] "..name..": "..tostring(runErr)); pcall(function() notify("Lua AutoLoad","["..tag.."] "..name..": "..tostring(runErr),4) end)
                        else pcall(function() notify("Lua AutoLoad","["..tag.."] ran "..name,2) end); ran = ran + 1 end
                    end
                end
            end
        end
        return ran > 0
    end

    local MainFrame = Instance.new("Frame")
    MainFrame.Size=UDim2.new(0,520,0,440); MainFrame.Position=UDim2.new(0.5,-260,0.5,-220)
    MainFrame.BackgroundColor3=Color3.fromRGB(15,15,22); MainFrame.BorderColor3=Color3.fromRGB(90,70,180)
    MainFrame.BorderSizePixel=1; MainFrame.Active=false; MainFrame.Visible=true; MainFrame.ZIndex=9998; MainFrame.Parent=ScreenGui
    local MainCorner=Instance.new("UICorner"); MainCorner.CornerRadius=UDim.new(0,4); MainCorner.Parent=MainFrame

    local UIScale=Instance.new("UIScale"); UIScale.Parent=MainFrame
    local function updateScale() local cam=workspace.CurrentCamera; if cam then local vp=cam.ViewportSize; local scale=math.min(vp.X/600,vp.Y/500); UIScale.Scale=math.clamp(scale,0.4,1) end end
    updateScale(); pcall(function() workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale) end)

    do
        local bgURL="https://i.postimg.cc/MGYK3P51/IMG-0015.jpg"
        local bgPath="acid_background.jpg"
        local asset=nil
        pcall(function() if type(writefile)=="function" and type(isfile)=="function" then if not isfile(bgPath) then local body=game:HttpGet(bgURL,true); if type(body)=="string" and #body>0 then writefile(bgPath,body) end end end end)
        if type(getcustomasset)=="function" and type(isfile)=="function" and isfile(bgPath) then local ok,id=pcall(getcustomasset,bgPath); if ok and type(id)=="string" and id~="" then asset=id end
        elseif type(getsynasset)=="function" and type(isfile)=="function" and isfile(bgPath) then local ok,id=pcall(getsynasset,bgPath); if ok and type(id)=="string" and id~="" then asset=id end end
        if asset then
            local bg=Instance.new("ImageLabel"); bg.Name="AcidBackgroundImage"; bg.Size=UDim2.new(1,0,1,0); bg.BackgroundTransparency=1; bg.Image=asset; bg.ImageTransparency=0.1; bg.ScaleType=Enum.ScaleType.Crop; bg.ZIndex=-1; bg.Active=false; bg.Parent=MainFrame
            local bgCorner=Instance.new("UICorner"); bgCorner.CornerRadius=UDim.new(0,4); bgCorner.Parent=bg
        end
    end

    local Overlay=nil; local OverlayGradient=nil
    local function buildOverlay()
        if Overlay and Overlay.Parent then Overlay:Destroy(); Overlay=nil; OverlayGradient=nil end
        if not Config.OverlayEnabled then return end
        Overlay=Instance.new("Frame"); Overlay.Name="AcidOverlay"; Overlay.Size=UDim2.new(1,0,1,0); Overlay.BackgroundColor3=Config.OverlayColor; Overlay.BackgroundTransparency=math.clamp(Config.OverlayTransparency or 0.55,0,1); Overlay.BorderSizePixel=0; Overlay.ZIndex=0; Overlay.Active=false; Overlay.Parent=MainFrame
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,4); c.Parent=Overlay
        OverlayGradient=Instance.new("UIGradient"); OverlayGradient.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.00,Color3.fromRGB(80,40,160)),ColorSequenceKeypoint.new(0.50,Color3.fromRGB(20,10,45)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(40,20,90))}); OverlayGradient.Rotation=135; OverlayGradient.Parent=Overlay
    end
    buildOverlay()

    local dg,dS,dSP
    local function beginDrag(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then dg=true; dS=i.Position; dSP=MainFrame.Position end end
    TC(UserInputService.InputChanged:Connect(function(i) if not dg then return end; local t=i.UserInputType; if t==Enum.UserInputType.MouseMovement or t==Enum.UserInputType.Touch then local d=i.Position-dS; MainFrame.Position=UDim2.new(dSP.X.Scale, dSP.X.Offset+d.X, dSP.Y.Scale, dSP.Y.Offset+d.Y) end end))
    TC(UserInputService.InputEnded:Connect(function(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then dg=false end end))

    local MenuBtn=Instance.new("TextButton")
    MenuBtn.Size=UDim2.new(0,130,0,34); MenuBtn.Position=UDim2.new(0,10,0,50)
    MenuBtn.BackgroundColor3=Color3.fromRGB(20,20,30); MenuBtn.BorderColor3=Color3.fromRGB(90,70,180); MenuBtn.BorderSizePixel=1
    MenuBtn.Font=Enum.Font.Code; MenuBtn.Text="[ ✖ close ]"; MenuBtn.TextColor3=Color3.fromRGB(180,210,255); MenuBtn.TextSize=13
    MenuBtn.Active=true; MenuBtn.Modal=false; MenuBtn.ZIndex=2147483000; MenuBtn.Parent=ScreenGui

    local bD,bS,bSP
    TC(MenuBtn.InputBegan:Connect(function(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then bD=true; bS=i.Position; bSP=MenuBtn.Position end end))
    TC(UserInputService.InputChanged:Connect(function(i) if not bD then return end; local t=i.UserInputType; if t==Enum.UserInputType.MouseMovement or t==Enum.UserInputType.Touch then local d=i.Position-bS; MenuBtn.Position=UDim2.new(bSP.X.Scale, bSP.X.Offset+d.X, bSP.Y.Scale, bSP.Y.Offset+d.Y) end end))
    TC(UserInputService.InputEnded:Connect(function(i) local t=i.UserInputType; if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then bD=false end end))

    local function updMenuBtn() if isUnloaded then return end; MenuBtn.Text = MainFrame.Visible and "[ ✖ close ]" or "[ ✦ Acid femboy ]" end
    TC(MenuBtn.MouseButton1Click:Connect(function() MainFrame.Visible=not MainFrame.Visible; updMenuBtn() end))

    local Title=Instance.new("TextLabel"); Title.Size=UDim2.new(1,-20,0,22); Title.Position=UDim2.new(0,10,0,2); Title.BackgroundTransparency=1; Title.Font=Enum.Font.Code
    Title.Text="acid pack | ragebot (tp under) · aura · esp · phys · wings · world · lua"
    Title.TextColor3=Color3.fromRGB(220,210,245); Title.TextSize=11; Title.TextXAlignment=Enum.TextXAlignment.Left; Title.ZIndex=9999; Title.Parent=MainFrame
    TC(Title.InputBegan:Connect(beginDrag))
    TC(UserInputService.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.UserInputType==Enum.UserInputType.Keyboard and i.KeyCode==Enum.KeyCode.RightShift then MainFrame.Visible=not MainFrame.Visible; updMenuBtn() end end))

    local TabBar=Instance.new("ScrollingFrame")
    TabBar.Size=UDim2.new(1,-10,0,26); TabBar.Position=UDim2.new(0,5,0,26); TabBar.BackgroundColor3=Color3.fromRGB(20,20,28); TabBar.BorderColor3=Color3.fromRGB(70,55,140); TabBar.BorderSizePixel=1; TabBar.ZIndex=9999
    TabBar.ScrollingDirection=Enum.ScrollingDirection.X; TabBar.ScrollBarThickness=0; TabBar.ScrollBarImageColor3=Color3.fromRGB(90,70,180); TabBar.CanvasSize=UDim2.new(0,0,0,0); TabBar.ClipsDescendants=false; TabBar.ElasticBehavior=Enum.ElasticBehavior.Never; TabBar.Parent=MainFrame

    local TBL=Instance.new("UIListLayout"); TBL.FillDirection=Enum.FillDirection.Horizontal; TBL.SortOrder=Enum.SortOrder.LayoutOrder; TBL.Parent=TabBar

    local Content=Instance.new("Frame"); Content.Size=UDim2.new(1,-10,1,-58); Content.Position=UDim2.new(0,5,0,56); Content.BackgroundTransparency=1; Content.ZIndex=100; Content.ClipsDescendants=true; Content.Active=false; Content.Parent=MainFrame

    local Tabs={}
    local function createTab(name)
        local tb=Instance.new("TextButton"); tb.Size=UDim2.new(1/8,0,1,0); tb.LayoutOrder=#Tabs+1; tb.BackgroundColor3=Color3.fromRGB(20,20,24); tb.BorderColor3=Color3.fromRGB(55,55,60); tb.BorderSizePixel=1; tb.Font=Enum.Font.Code; tb.Text=name; tb.TextColor3=Color3.fromRGB(160,160,165); tb.TextSize=9; tb.ZIndex=9999; tb.Active=true; tb.Modal=false; tb.Parent=TabBar
        local page=Instance.new("Frame"); page.Size=UDim2.new(1,0,1,0); page.BackgroundTransparency=1; page.Visible=false; page.ZIndex=100; page.Parent=Content
        TC(tb.MouseButton1Click:Connect(function()
            for _,x in pairs(Tabs) do x.Page.Visible=false; x.Button.TextColor3=Color3.fromRGB(160,160,165); x.Button.BackgroundColor3=Color3.fromRGB(20,20,24) end
            page.Visible=true; tb.TextColor3=Color3.fromRGB(200,220,255); tb.BackgroundColor3=Color3.fromRGB(40,35,75)
        end))
        table.insert(Tabs,{Button=tb,Page=page})
        if #Tabs==1 then page.Visible=true; tb.TextColor3=Color3.fromRGB(200,220,255); tb.BackgroundColor3=Color3.fromRGB(40,35,75) end
        local LL=Instance.new("UIListLayout"); LL.SortOrder=Enum.SortOrder.LayoutOrder; LL.Padding=UDim.new(0,5)
        local Scroll=Instance.new("ScrollingFrame")
        Scroll.Size=UDim2.new(1,0,1,0)
        Scroll.BackgroundTransparency=1
        Scroll.BorderSizePixel=0
        Scroll.ScrollBarThickness=6
        Scroll.ScrollBarImageColor3=Color3.fromRGB(90,70,180)
        Scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
        Scroll.CanvasSize=UDim2.new(0,0,0,0)
        Scroll.ScrollingDirection=Enum.ScrollingDirection.Y
        Scroll.ElasticBehavior=Enum.ElasticBehavior.Never
        Scroll.ZIndex=101
        Scroll.Active=true
        Scroll.ClipsDescendants=true
        Scroll.ScrollingEnabled=true
        Scroll.Parent=page
        LL.Parent=Scroll
        return Scroll
    end

    local AuraTab=createTab("Aura")
    local ESPTab=createTab("ESP")
    local BodyTab=createTab("Body")
    local PhysTab=createTab("Phys")
    local WingsTab=createTab("Wings")
    local WorldTab=createTab("World")
    local LuaTab=createTab("Lua")
    local SettingsTab=createTab("Config")

-- [PART 2 CONTINUES HERE]
local function mkToggle(parent,label,getter,setter)
        local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,32); b.BackgroundColor3=Color3.fromRGB(25,25,35); b.BorderColor3=Color3.fromRGB(90,70,180); b.BorderSizePixel=1; b.Font=Enum.Font.Code; b.TextSize=12; b.TextXAlignment=Enum.TextXAlignment.Left; b.ZIndex=9999; b.Active=true; b.Modal=false; b.Parent=parent
        local function refresh() local on=getter(); b.BackgroundColor3=on and Color3.fromRGB(40,80,40) or Color3.fromRGB(25,25,35); b.TextColor3=on and Color3.fromRGB(100,255,100) or Color3.fromRGB(210,210,215); b.Text="  "..label..": "..(on and "ON" or "OFF") end
        registerRefresh(refresh)
        TC(b.MouseButton1Click:Connect(function() setter(not getter()); refresh(); SaveConfig(); pcall(refreshAllUI) end))
        refresh(); return b,refresh
    end

    local function mkSlider(parent,label,minV,maxV,initial,step,onChange)
        local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,0,0,16); lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.Code; lbl.TextColor3=Color3.fromRGB(200,190,230); lbl.TextSize=10; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=9999; lbl.Parent=parent
        local C=Instance.new("Frame"); C.Size=UDim2.new(1,0,0,30); C.BackgroundTransparency=1; C.ZIndex=9999; C.Parent=parent
        local mi=Instance.new("TextButton"); mi.Size=UDim2.new(0,50,1,0); mi.BackgroundColor3=Color3.fromRGB(25,25,35); mi.BorderColor3=Color3.fromRGB(90,70,180); mi.BorderSizePixel=1; mi.Font=Enum.Font.Code; mi.Text="-"; mi.TextColor3=Color3.fromRGB(220,210,245); mi.TextSize=16; mi.ZIndex=9999; mi.Active=true; mi.Modal=false; mi.Parent=C
        local pl=Instance.new("TextButton"); pl.Size=UDim2.new(0,50,1,0); pl.Position=UDim2.new(1,-50,0,0); pl.BackgroundColor3=Color3.fromRGB(25,25,35); pl.BorderColor3=Color3.fromRGB(90,70,180); pl.BorderSizePixel=1; pl.Font=Enum.Font.Code; pl.Text="+"; pl.TextColor3=Color3.fromRGB(220,210,245); pl.TextSize=16; pl.ZIndex=9999; pl.Active=true; pl.Modal=false; pl.Parent=C
        local v = type(initial)=="function" and initial() or initial
        local function cur() if type(initial)=="function" then return initial() end return v end
        local function upd() lbl.Text=label..": "..string.format("%.2f",cur()) end
        registerRefresh(upd)
        TC(mi.MouseButton1Click:Connect(function() local nv=math.max(minV,cur()-step); v=nv; upd(); if onChange then onChange(nv) end; SaveConfig(); pcall(refreshAllUI) end))
        TC(pl.MouseButton1Click:Connect(function() local nv=math.min(maxV,cur()+step); v=nv; upd(); if onChange then onChange(nv) end; SaveConfig(); pcall(refreshAllUI) end))
        upd(); return function() return cur() end
    end

    local function mkColorRow(parent,presets,setter,onAfterSet)
        local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,32); row.BackgroundTransparency=1; row.ZIndex=9999; row.Parent=parent
        local L=Instance.new("UIListLayout"); L.FillDirection=Enum.FillDirection.Horizontal; L.Padding=UDim.new(0,4); L.Parent=row
        for _,p in ipairs(presets) do
            local b=Instance.new("TextButton"); b.Size=UDim2.new(0,34,1,0); b.BackgroundColor3=p.c; b.BorderColor3=Color3.fromRGB(90,70,180); b.BorderSizePixel=1; b.Text=""; b.ZIndex=9999; b.Active=true; b.Modal=false; b.Parent=row
            TC(b.MouseButton1Click:Connect(function() setter(p.c); SaveConfig(); if onAfterSet then onAfterSet(p.c) end; pcall(refreshAllUI) end))
        end
        return row
    end

    local function mkSection(parent,text)
        local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,0,0,16); d.BackgroundTransparency=1; d.Font=Enum.Font.Code; d.Text="── "..text.." ──"; d.TextColor3=Color3.fromRGB(190,180,230); d.TextSize=10; d.TextXAlignment=Enum.TextXAlignment.Left; d.ZIndex=9999; d.Parent=parent
        return d
    end

    local function mkCycle(parent,label,getter,options,setter)
        local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,30); b.BackgroundColor3=Color3.fromRGB(25,25,35); b.BorderColor3=Color3.fromRGB(90,70,180); b.BorderSizePixel=1; b.Font=Enum.Font.Code; b.TextSize=11; b.TextColor3=Color3.fromRGB(220,210,245); b.TextXAlignment=Enum.TextXAlignment.Left; b.ZIndex=9999; b.Active=true; b.Modal=false; b.Parent=parent
        local function refresh() b.Text="  "..label..": "..tostring(getter()) end
        registerRefresh(refresh)
        TC(b.MouseButton1Click:Connect(function()
            local cv = getter(); local idx = 1
            for i,o in ipairs(options) do if o==cv then idx=i end end
            idx = idx+1; if idx>#options then idx=1 end
            setter(options[idx])
            refresh(); SaveConfig(); pcall(refreshAllUI)
        end))
        refresh(); return b
    end

    local function mkButton(parent,text,bg,border,tc)
        local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,30); b.BackgroundColor3=bg; b.BorderColor3=border; b.BorderSizePixel=1; b.Font=Enum.Font.Code; b.Text=text; b.TextColor3=tc; b.TextSize=12; b.ZIndex=9999; b.Active=true; b.Modal=false; b.Parent=parent
        return b
    end

    local PURPLE_CONFIRM=Color3.fromRGB(140,60,220)
    local function isEnemy(p)
        if p==LocalPlayer then return false end
        if p.Team and LocalPlayer.Team and p.Team==LocalPlayer.Team then return false end
        local mt=LocalPlayer:GetAttribute("TeamID"); local pt=p:GetAttribute("TeamID")
        if mt and pt then return mt~=pt end
        return true
    end
    local function closestEnemy(maxDist)
        maxDist=maxDist or 1000; local ch=LocalPlayer.Character; if not ch then return nil,nil end
        local myR=ch:FindFirstChild("HumanoidRootPart"); if not myR then return nil,nil end
        local best,bd=nil,maxDist
        for _,p in ipairs(Players:GetPlayers()) do
            if not isEnemy(p) then continue end
            local pc=p.Character; if not pc then continue end
            local pr=pc:FindFirstChild("HumanoidRootPart"); local ph=pc:FindFirstChildOfClass("Humanoid")
            if not (pr and ph and ph.Health>0) then continue end
            local d=(myR.Position-pr.Position).Magnitude
            if d<bd then bd=d; best=p end
        end
        return best,bd
    end

    local InfDoubleJump = { OriginalItemInfo = setmetatable({}, {__mode="k"}) }
    local function InfJumpStoreOriginal(item) if type(item)~="table" or InfDoubleJump.OriginalItemInfo[item]~=nil then return end; local info=item.Info; if type(info)~="table" then return end; InfDoubleJump.OriginalItemInfo[item]={Info=info,HasMaxDoubleJumps=rawget(info,"MaxDoubleJumps")~=nil,MaxDoubleJumps=rawget(info,"MaxDoubleJumps")} end
    local function InfJumpApplyToItem(item) InfJumpStoreOriginal(item); local original=InfDoubleJump.OriginalItemInfo[item]; local info=original and original.Info or nil; if type(info)~="table" then return end; if Config.InfDoubleJumpEnabled then rawset(info,"MaxDoubleJumps",Config.InfDoubleJumpValue or 676767) elseif original.HasMaxDoubleJumps then rawset(info,"MaxDoubleJumps",original.MaxDoubleJumps) else rawset(info,"MaxDoubleJumps",nil) end end
    local function InfJumpApplyAll() local fighter=nil; pcall(function() local ps=LocalPlayer:FindFirstChild("PlayerScripts"); local ctrl=ps and ps:FindFirstChild("Controllers"); local fc=ctrl and ctrl:FindFirstChild("FighterController"); if not fc then return end; local mod=require(fc); fighter=mod and mod.LocalFighter end); if not fighter or type(rawget(fighter,"Items"))~="table" then return false end; for _,item in pairs(rawget(fighter,"Items")) do InfJumpApplyToItem(item) end; return true end
    local function InfJumpSetEnabled(enabled) Config.InfDoubleJumpEnabled=enabled==true; if Config.InfDoubleJumpEnabled then InfJumpApplyAll() else for item,original in pairs(InfDoubleJump.OriginalItemInfo) do local info=original and original.Info or nil; if type(info)=="table" then if original.HasMaxDoubleJumps then rawset(info,"MaxDoubleJumps",original.MaxDoubleJumps) else rawset(info,"MaxDoubleJumps",nil) end end end; InfDoubleJump.OriginalItemInfo=setmetatable({},{__mode="k"}) end; SaveConfig() end

    local FlyState={Enabled=Config.FlyEnabled==true,Speed=Config.FlySpeed or 50,Conn=nil}
    local NoclipState={Enabled=Config.NoclipEnabled==true,Conn=nil}

    local function FlyStart()
        if getgenv().AcidFlyConn then pcall(function() getgenv().AcidFlyConn:Disconnect() end); getgenv().AcidFlyConn=nil end
        FlyState.Conn=RunService.Heartbeat:Connect(function(dt)
            if not FlyState.Enabled then return end
            local char=LocalPlayer.Character; if not char then return end
            local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            local hum=char:FindFirstChildOfClass("Humanoid"); if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) end
            local cam=Workspace.CurrentCamera; if not cam then return end
            local md=Vector3.zero
            if hum and hum.MoveDirection.Magnitude>0 then
                local fl=Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z)
                md=fl.Magnitude>0.001 and Vector3.new(hum.MoveDirection.X,cam.CFrame.LookVector.Y*hum.MoveDirection:Dot(fl.Unit),hum.MoveDirection.Z) or Vector3.new(hum.MoveDirection.X,cam.CFrame.LookVector.Y,hum.MoveDirection.Z)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then md=md+Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then md=md-Vector3.new(0,1,0) end
            hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero
            if md.Magnitude>0 then hrp.CFrame=hrp.CFrame+(md.Unit*(FlyState.Speed*dt)) end
        end)
        getgenv().AcidFlyConn=FlyState.Conn
    end
    local function FlyStop()
        FlyState.Enabled=false
        if FlyState.Conn then FlyState.Conn:Disconnect(); FlyState.Conn=nil end
        if getgenv().AcidFlyConn then pcall(function() getgenv().AcidFlyConn:Disconnect() end); getgenv().AcidFlyConn=nil end
        local char=LocalPlayer.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero end
        local hum=char and char:FindFirstChildOfClass("Humanoid"); if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
    local function NoclipStart()
        if getgenv().AcidNoclipConn then pcall(function() getgenv().AcidNoclipConn:Disconnect() end); getgenv().AcidNoclipConn=nil end
        NoclipState.Conn=RunService.Stepped:Connect(function()
            if not NoclipState.Enabled then return end
            local char=LocalPlayer.Character; if not char then return end
            for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
        end)
        getgenv().AcidNoclipConn=NoclipState.Conn
    end
    local function NoclipStop()
        NoclipState.Enabled=false
        if NoclipState.Conn then NoclipState.Conn:Disconnect(); NoclipState.Conn=nil end
        if getgenv().AcidNoclipConn then pcall(function() getgenv().AcidNoclipConn:Disconnect() end); getgenv().AcidNoclipConn=nil end
        local char=LocalPlayer.Character
        if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.CanCollide=true end) end end end
    end
    if FlyState.Enabled then FlyStart() end
    if NoclipState.Enabled then NoclipStart() end

    local MovementState = {Character=nil,Humanoid=nil,RootPart=nil,WalkSpeedHookLoaded=false,WalkSpeedHookGetter=nil,WalkSpeedHookUpvalueIndex=nil,WalkSpeedHookOldUpvalue=nil,WalkMultiplierEnabled=false,WalkMultiplier=1,SlidingMultiplierEnabled=false,SlidingMultiplier=1,JumpPowerHookLoaded=false,JumpPowerHookDestroyed=false,JumpPowerEnabled=false,JumpPowerMultiplier=1,NextWalkSpeedAttemptAt=0,NextJumpPowerAttemptAt=0}
    local function ResolveCharacter()
        local m=MovementState; local char=LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass('Humanoid') or nil
        local root=char and char:FindFirstChild('HumanoidRootPart') or nil
        if char~=m.Character or hum~=m.Humanoid or root~=m.RootPart then m.Character=char; m.Humanoid=hum; m.RootPart=root end
        return char,hum,root
    end
    local function ResolveMechanicsController()
        if MovementState.MechanicsController then return MovementState.MechanicsController end
        local ps=LocalPlayer:FindFirstChild('PlayerScripts'); local ctrl=ps and ps:FindFirstChild('Controllers')
        local mod=ctrl and ctrl:FindFirstChild('MechanicsController'); if not mod then return nil end
        local ok,controller=pcall(require,mod); if ok and type(controller)=='table' then MovementState.MechanicsController=controller end
        return MovementState.MechanicsController
    end
    local function AttemptLoadWalkSpeedHook()
        local m=MovementState; if m.WalkSpeedHookLoaded then return true end
        if os.clock()<(m.NextWalkSpeedAttemptAt or 0) then return false end
        if type(debug.getupvalues)~='function' or type(debug.setupvalue)~='function' then m.NextWalkSpeedAttemptAt=os.clock()+3; return false end
        local mechanics=ResolveMechanicsController(); if type(mechanics)~='table' then m.NextWalkSpeedAttemptAt=os.clock()+3; return false end
        local mt=getmetatable(mechanics); local idx=type(mt)=='table' and rawget(mt,'__index') or nil
        local getWalkSpeed=type(idx)=='table' and rawget(idx,'_GetWalkSpeed') or nil
        if type(getWalkSpeed)~='function' then m.NextWalkSpeedAttemptAt=os.clock()+3; return false end
        local upIdx,oldUp
        for i,v in pairs(debug.getupvalues(getWalkSpeed)) do if type(v)=='table' and rawget(v,'BASE_WALKSPEED')~=nil then upIdx=i; oldUp=v; break end end
        if upIdx==nil then m.NextWalkSpeedAttemptAt=os.clock()+3; return false end
        m.WalkSpeedHookGetter=getWalkSpeed; m.WalkSpeedHookUpvalueIndex=upIdx; m.WalkSpeedHookOldUpvalue=oldUp
        debug.setupvalue(getWalkSpeed,upIdx,setmetatable({},{__index=function(_,key) if key~='BASE_WALKSPEED' then return nil end; local base=rawget(oldUp,'BASE_WALKSPEED'); if m.SlidingMultiplierEnabled and debug.info(3,'n')=='Slide' then return base*m.SlidingMultiplier end; if m.WalkMultiplierEnabled then return base*m.WalkMultiplier end; return base end}))
        m.WalkSpeedHookLoaded=true; return true
    end
    local function UpdateWalkSpeed(active) local m=MovementState; m.WalkMultiplier=Config.WalkSpeedMultiplier or 2; m.WalkMultiplierEnabled=active==true; AttemptLoadWalkSpeedHook() end
    local function UpdateSliding(active) local m=MovementState; m.SlidingMultiplier=Config.SlidingMultiplier or 10; m.SlidingMultiplierEnabled=active==true; AttemptLoadWalkSpeedHook() end
    local function ReplaceJumpPowerConstants(target)
        local m=MovementState
        for i,v in pairs(debug.getupvalues(target)) do
            if type(v)=='table' then
                local mt=getmetatable(v); local mi=type(mt)=='table' and rawget(mt,'__index') or nil
                local original=nil
                if type(mi)=='function' then local ok,wrapped=pcall(function() return v['meow\0d67'] end); original=ok and wrapped or nil
                elseif rawget(v,'BASE_JUMPPOWER')~=nil then original=v end
                if original~=nil then
                    local upIdx=i
                    debug.setupvalue(target,upIdx,setmetatable({},{__index=function(_,key)
                        if key=='meow\0d67' then return original end
                        if m.JumpPowerHookDestroyed then debug.setupvalue(target,upIdx,original); return rawget(original,key) end
                        if key~='BASE_JUMPPOWER' then return rawget(original,key) end
                        return rawget(original,'BASE_JUMPPOWER')*(m.JumpPowerEnabled and m.JumpPowerMultiplier or 1)
                    end}))
                    break
                end
            end
        end
    end
    local function AttemptLoadJumpPowerHook()
        local m=MovementState; if m.JumpPowerHookLoaded then return true end
        if os.clock()<(m.NextJumpPowerAttemptAt or 0) then return false end
        if type(debug.getupvalues)~='function' or type(debug.setupvalue)~='function' or type(debug.getconstants)~='function' or type(debug.getprotos)~='function' or type(debug.getproto)~='function' then m.NextJumpPowerAttemptAt=os.clock()+3; return false end
        local mechanics=ResolveMechanicsController(); if type(mechanics)~='table' then m.NextJumpPowerAttemptAt=os.clock()+3; return false end
        local mt=getmetatable(mechanics); local idx=type(mt)=='table' and rawget(mt,'__index') or nil
        local hookFighter=type(idx)=='table' and rawget(idx,'_HookFighter') or nil
        if type(hookFighter)~='function' then m.NextJumpPowerAttemptAt=os.clock()+3; return false end
        local localFighter=rawget(mechanics,'LocalFighter'); if localFighter==nil then m.NextJumpPowerAttemptAt=os.clock()+3; return false end
        ReplaceJumpPowerConstants(hookFighter)
        local entityAdded=rawget(localFighter,'EntityAdded')
        local handler=type(entityAdded)=='table' and rawget(entityAdded,'_handlerListHead') or nil
        local entityCallback=nil
        while type(handler)=='table' and entityCallback==nil do
            local fn=rawget(handler,'_fn')
            if type(fn)=='function' then for _,c in pairs(debug.getconstants(fn)) do if c=='CustomGravity' then entityCallback=fn; break end end end
            handler=rawget(handler,'_next')
        end
        if entityCallback==nil then m.NextJumpPowerAttemptAt=os.clock()+3; return false end
        ReplaceJumpPowerConstants(entityCallback)
        for protoIndex in pairs(debug.getprotos(entityCallback)) do
            local activated=debug.getproto(entityCallback,protoIndex,true)
            local instance=type(activated)=='table' and activated[1] or nil
            if instance~=nil then ReplaceJumpPowerConstants(instance) end
        end
        m.JumpPowerHookDestroyed=false; m.JumpPowerHookLoaded=true; return true
    end
    local function UpdateJumpPower(active) local m=MovementState; m.JumpPowerMultiplier=Config.JumpPowerMultiplier or 2; m.JumpPowerEnabled=active==true; AttemptLoadJumpPowerHook() end
    local function UpdateMovement(dt) ResolveCharacter(); UpdateWalkSpeed(Config.WalkSpeedEnabled); UpdateSliding(Config.SlidingEnabled); UpdateJumpPower(Config.JumpPowerEnabled) end

    local lastWallbangShoot = 0
    local function HandleWallbang()
        if isUnloaded or not Config.WallbangEnabled then return end
        local char=LocalPlayer.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local target=closestEnemy(math.huge); if not target or not target.Character then return end
        local head=target.Character:FindFirstChild("Head"); if not head then return end
        local cam=Workspace.CurrentCamera; if not cam then return end
        cam.CFrame=CFrame.lookAt(cam.CFrame.Position,head.Position)
        local tool=char:FindFirstChildOfClass("Tool"); if tool then tool:Activate() end
        if tick()-lastWallbangShoot>0.05 then
            lastWallbangShoot=tick()
            pcall(function()
                if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then local center=cam.ViewportSize/2; if firetouchtap then firetouchtap(center) elseif touchtap then touchtap(center) end
                else if mouse1click then mouse1click() else VirtualUser:ClickButton1(Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)) end end
            end)
        end
    end
    local function WallbangStart() pcall(function() RunService:UnbindFromRenderStep("AcidWallbang") end); RunService:BindToRenderStep("AcidWallbang",Enum.RenderPriority.Camera.Value+1,HandleWallbang) end
    local function WallbangStop() pcall(function() RunService:UnbindFromRenderStep("AcidWallbang") end) end

    local lastDodgeTick = 0
    local function UpdatePrediction(dt)
        if not Config.PredictionEnabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        local myPos = hrp.Position
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer or not p.Character then continue end
            local ehrp = p.Character:FindFirstChild("HumanoidRootPart")
            local vel = ehrp and ehrp.AssemblyLinearVelocity
            if ehrp and vel and vel.Magnitude > (Config.PredictionThreshold or 800) then
                local predictedPos = ehrp.Position + vel * (dt * 3 * (Config.PredictionMult or 1))
                if (predictedPos - myPos).Magnitude < (Config.PredictionRadius or 20) and tick() - lastDodgeTick > (Config.PredictionCooldown or 0.3) then
                    lastDodgeTick = tick()
                    local perp = Vector3.new(-vel.Z, 0, vel.X).Unit
                    local dir = math.random(0,1) == 0 and perp or -perp
                    hrp.CFrame = CFrame.new(myPos + dir * (Config.PredictionDodgeDist or 30))
                    notify("Dodge", "Dodged "..p.Name, 1)
                    break
                end
            end
        end
    end

    local EvasionState = { BasePos = nil, T0 = nil, Seed = nil }
    local function evasionSafeTeleport(pos)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local x,y,z = pos.X,pos.Y,pos.Z
        y = math.clamp(y, 2, hrp.Position.Y + 800)
        local p = RaycastParams.new()
        p.FilterType = Enum.RaycastFilterType.Exclude
        p.FilterDescendantsInstances = { char }
        p.IgnoreWater = true
        local hit = workspace:Raycast(Vector3.new(x, y+60, z), Vector3.new(0,-220,0), p)
        if hit then y = math.max(hit.Position.Y + 3, 2) end
        hrp.CFrame = CFrame.new(x, y, z)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end
    local function UpdateEvasion(dt)
        if not Config.EvasionEnabled then EvasionState.BasePos=nil; EvasionState.T0=nil; return end
        if SinkState.Active or FakePosState.Enabled or Config.VoidEnabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health<=0 then return end
        if not EvasionState.BasePos then
            EvasionState.BasePos = hrp.Position
            EvasionState.T0 = tick()
            EvasionState.Seed = math.random(1,10000)
        end
        local elapsed = tick() - EvasionState.T0
        if elapsed > 3 then EvasionState.BasePos = hrp.Position; EvasionState.T0 = tick(); elapsed = 0 end
        local i = Config.EvasionIntensity or 3.0
        local t = elapsed
        local s1,s2,s3 = EvasionState.Seed, EvasionState.Seed*1.3, EvasionState.Seed*1.7
        local r1,r2,r3 = 500*0.18*i, 500*0.35*i, 500*0.55*i
        local oX = math.cos(t*18.7)*r1 + math.cos(t*7.3+s1)*r2 + math.cos(t*2.1+s2)*r3
        local oZ = math.sin(t*18.7)*r1 + math.sin(t*7.3+s1)*r2 + math.sin(t*2.1+s2)*r3
        local oY = math.sin(t*11.3+s3)*500*0.12*i + math.sin(t*5.7)*500*0.08*i
        evasionSafeTeleport(EvasionState.BasePos + Vector3.new(oX,oY,oZ))
    end

    local function UpdateTP(dt)
        if not Config.TPEnabled then return end
        if SinkState.Active or FakePosState.Enabled or Config.VoidEnabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target = closestEnemy()
        if not target or not target.Character then return end
        local thrp = target.Character:FindFirstChild("HumanoidRootPart")
        if not thrp then return end
        local height = Config.TPHeight or 3.5
        local dist = Config.TPDistance or 3
        local mode = Config.TPMode or "Follow"
        local dest
        if mode == "Follow" then dest = CFrame.lookAt(thrp.Position + Vector3.new(0,height,0), thrp.Position)
        elseif mode == "Front" then local front = thrp.CFrame.LookVector; dest = CFrame.lookAt(thrp.Position + front*dist + Vector3.new(0,height,0), thrp.Position)
        elseif mode == "Back" then local back = -thrp.CFrame.LookVector; dest = CFrame.lookAt(thrp.Position + back*dist + Vector3.new(0,height,0), thrp.Position)
        elseif mode == "Above" then dest = CFrame.lookAt(thrp.Position + Vector3.new(0,dist+height,0), thrp.Position)
        else dest = CFrame.new(thrp.Position + Vector3.new(0,height,0)) end
        hrp.CFrame = dest
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    local voidToggle = false
    local function UpdateVoid(dt)
        if not Config.VoidEnabled then return end
        if SinkState.Active or FakePosState.Enabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        voidToggle = not voidToggle
        local vx = Config.VoidX or 1e8
        local vy = Config.VoidY or 1e8
        local vz = Config.VoidZ or 1e8
        if voidToggle then hrp.CFrame = CFrame.new(math.random(-vx, vx), vy, math.random(-vz, vz))
        else hrp.CFrame = CFrame.new(math.random(vx, vx * 2), -vy, math.random(vz, vz * 2)) end
        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-1e5, 1e5), math.random(-1e5, 1e5), math.random(-1e5, 1e5))
    end

    local aaAngleAccum, aaJitterState, aaRandomTimer, aaRandomMultiplier = 0, 0, 0, 1
    local function UpdateAntiAim(dt)
        if not Config.AntiAimEnabled or Config.MainRagebotEnabled or Config.VoidEnabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local speed = Config.AntiAimSpeed or 5000
        if Config.AntiAimRandomSpeed then
            aaRandomTimer = aaRandomTimer + dt
            if aaRandomTimer > 0.1 then aaRandomTimer = 0; aaRandomMultiplier = 0.2 + math.random()*0.8 end
            speed = speed * aaRandomMultiplier
        end
        local vel = hrp.AssemblyLinearVelocity
        if Config.AntiAimMode == "Spin" then
            aaAngleAccum = aaAngleAccum + math.rad(speed) * dt
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, aaAngleAccum, 0)
        elseif Config.AntiAimMode == "Jitter" then
            local angle = math.rad(Config.AntiAimAngle or 90)
            local dir = (aaJitterState == 0) and 1 or -1
            aaJitterState = (aaJitterState + 1) % 2
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(angle * dir, angle * dir, 0)
        elseif Config.AntiAimMode == "Static" then
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(Config.AntiAimAngle or 90), 0)
        end
        hrp.AssemblyLinearVelocity = vel
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

-- [PART 3 CONTINUES HERE]
local riotTimer = 0
    local riotAngle = 0
    local function UpdateRiot(dt)
        if not Config.RiotEnabled then return end
        local char = LocalPlayer.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        riotTimer = riotTimer + dt; if riotTimer < (Config.RiotSpeed or 0.03) then return end; riotTimer = 0
        local currentPos = hrp.Position; local target = closestEnemy(); local newPos = currentPos
        if target and target.Character then
            local thrp = target.Character:FindFirstChild("HumanoidRootPart")
            if thrp and (currentPos - thrp.Position).Magnitude < (Config.RiotEvadeRange or 30) then
                local dir = (currentPos - thrp.Position).Unit; newPos = currentPos + dir * math.random((Config.RiotRange or 50)*0.5, (Config.RiotRange or 50)*1.5)
            else
                local angle = math.random() * 2 * math.pi
                newPos = currentPos + Vector3.new(math.cos(angle)*math.random((Config.RiotRange or 50)*0.2, (Config.RiotRange or 50)), math.random(-(Config.RiotRange or 50)*0.5, (Config.RiotRange or 50)*0.5), math.sin(angle)*math.random((Config.RiotRange or 50)*0.2, (Config.RiotRange or 50)))
            end
        else
            local angle = math.random() * 2 * math.pi
            newPos = currentPos + Vector3.new(math.cos(angle)*math.random((Config.RiotRange or 50)*0.2, (Config.RiotRange or 50)), math.random(-(Config.RiotRange or 50)*0.5, (Config.RiotRange or 50)*0.5), math.sin(angle)*math.random((Config.RiotRange or 50)*0.2, (Config.RiotRange or 50)))
        end
        riotAngle = riotAngle + ((Config.RiotSpinSpeed or 180) * dt); if riotAngle >= 360 then riotAngle = riotAngle - 360 end
        pcall(function() hrp.CFrame = CFrame.new(newPos) * CFrame.Angles(0, math.rad(riotAngle), 0); hrp.AssemblyLinearVelocity = Vector3.zero end)
    end

    local function UpdateRiotAbuse(dt)
        if not Config.RiotAbuseEnabled then return end
        local char = LocalPlayer.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local target = closestEnemy(); if not target or not target.Character then return end
        local thrp = target.Character:FindFirstChild("HumanoidRootPart"); if not thrp then return end
        local offset = Vector3.new(Config.RiotAbuseRight or 0, (Config.RiotAbuseHeight or 3) - (Config.RiotAbuseDown or 0), Config.RiotAbuseForward or 0)
        local targetPos = thrp.Position + offset
        if Config.RiotAbuseMode == "Stick" then hrp.CFrame = CFrame.new(targetPos)
        elseif Config.RiotAbuseMode == "Bounce" then local bounceOffset = math.abs(math.sin(tick() * 8)) * math.abs(Config.RiotAbuseHeight or 3); hrp.CFrame = CFrame.new(thrp.Position + Vector3.new(Config.RiotAbuseRight or 0, bounceOffset - (Config.RiotAbuseDown or 0), Config.RiotAbuseForward or 0)) end
        hrp.AssemblyLinearVelocity = Vector3.zero
    end

    local orbitAngle = 0; local orbitLocalElapsed = 0; local orbitCurrentRadius = Config.OrbitDist or 8
    local function UpdateOrbit(dt)
        if not Config.OrbitEnabled then return end
        local char = LocalPlayer.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if hum and hum:GetState() ~= Enum.HumanoidStateType.Physics then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end) end
        local target = closestEnemy(); if not target or not target.Character then return end
        local thrp = target.Character:FindFirstChild("HumanoidRootPart"); if not thrp then return end
        if (hrp.Position - thrp.Position).Magnitude > (Config.OrbitAutoLockDist or 50) then return end
        local targetPos = thrp.Position; if Config.OrbitPredict then targetPos = targetPos + thrp.AssemblyLinearVelocity * (Config.OrbitPredStrength or 0.2) end
        orbitAngle = orbitAngle + math.rad(Config.OrbitSpeed or 90) * dt; orbitLocalElapsed = orbitLocalElapsed + dt
        local r = Config.OrbitDist or 8; local h = Config.OrbitHeight or 0; local x, y, z = 0, 0, 0
        if Config.OrbitMode == "Circle" then x = math.cos(orbitAngle) * r; z = math.sin(orbitAngle) * r; y = h
        elseif Config.OrbitMode == "Figure 8" then x = math.sin(orbitAngle) * r; z = math.sin(orbitAngle) * math.cos(orbitAngle) * r * 0.7; y = h
        elseif Config.OrbitMode == "Spiral In" then orbitCurrentRadius = math.max(1, orbitCurrentRadius - (dt * 2)); x = math.cos(orbitAngle) * orbitCurrentRadius; z = math.sin(orbitAngle) * orbitCurrentRadius; y = h
        elseif Config.OrbitMode == "Spiral Out" then orbitCurrentRadius = math.min((Config.OrbitDist or 8) * 2, orbitCurrentRadius + (dt * 2)); x = math.cos(orbitAngle) * orbitCurrentRadius; z = math.sin(orbitAngle) * orbitCurrentRadius; y = h
        elseif Config.OrbitMode == "Bounce" then x = math.cos(orbitAngle) * r; z = math.sin(orbitAngle) * r; y = h + math.sin(orbitLocalElapsed * 3) * 5 end
        local dst = targetPos + Vector3.new(x, y, z); local smooth = hrp.Position:Lerp(dst, Config.OrbitLerp or 0.3)
        if Config.OrbitFaceTarget then hrp.CFrame = CFrame.new(smooth, Vector3.new(targetPos.X, smooth.Y, targetPos.Z)) else hrp.CFrame = CFrame.new(smooth) end
    end

    local SinkState = {Active=false,Character=nil,Humanoid=nil,RootPart=nil,VirtualCF=nil,Parts={},NextFailNotify=nil}
    local function SinkFindGroundY(char,originPos,castLength)
        local filter={char}; for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then table.insert(filter,p.Character) end end
        local params=RaycastParams.new(); params.FilterType=Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances=filter; params.IgnoreWater=true; pcall(function() params.RespectCanCollide=true end)
        local result=Workspace:Raycast(originPos,Vector3.new(0,-castLength,0),params); return result and result.Position.Y or nil
    end
    local function SinkDeactivate(liftToGround)
        local s=SinkState; if not s.Active then return end; local root,hum,char=s.RootPart,s.Humanoid,s.Character; s.Active=false
        if liftToGround and root and root.Parent and char and char.Parent then
            local targetY=s.VirtualCF and s.VirtualCF.Position.Y; if not targetY then targetY=SinkFindGroundY(char,root.Position+Vector3.new(0,50,0),100) end
            if targetY then local hip=hum and hum.HipHeight or 0; local stand=(hip>=1 and (hip+root.Size.Y/2)) or 3; root.CFrame=CFrame.new(root.Position.X,targetY+stand+0.5,root.Position.Z); root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero end
        end
        for part in pairs(s.Parts) do if part.Parent then part.CanCollide=true end end; table.clear(s.Parts); s.Character,s.Humanoid,s.RootPart,s.VirtualCF=nil,nil,nil,nil
    end
    local function SinkActivate(char,hum,root)
        local s=SinkState; local groundY=SinkFindGroundY(char,root.Position+Vector3.new(0,1,0),50); if not groundY then return false end
        local fallen=Workspace.FallenPartsDestroyHeight; if fallen==fallen and (groundY-(Config.SinkDepth or 5.8))<fallen+10 then return false end
        s.Character,s.Humanoid,s.RootPart=char,hum,root; s.VirtualCF=CFrame.new(root.Position.X,groundY,root.Position.Z); table.clear(s.Parts)
        for _,d in ipairs(char:GetDescendants()) do if d:IsA('BasePart') and d.CanCollide then s.Parts[d]=true end end; s.Active=true; return true
    end
    local function UpdateSink(dt)
        local s=SinkState; local wanted=Config.SinkEnabled; local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass('Humanoid') or nil; local root=char and char:FindFirstChild('HumanoidRootPart') or nil; local alive=hum~=nil and root~=nil and hum.Health>0
        if s.Active then if not alive or char~=s.Character or root~=s.RootPart then SinkDeactivate(false) elseif not wanted then SinkDeactivate(true); return end end
        if not wanted or not alive then return end
        if not s.Active then if not SinkActivate(char,hum,root) then if s.NextFailNotify==nil or os.clock()>s.NextFailNotify then s.NextFailNotify=os.clock()+3; notify("Sink","No safe ground below you.",3) end; return end end
        local cam=Workspace.CurrentCamera; local camLook=cam and cam.CFrame.LookVector or Vector3.new(0,0,-1); local camYaw=math.atan2(-camLook.X,-camLook.Z); local surfaceRot=CFrame.Angles(0,camYaw,0)
        local trackOrigin=Vector3.new(s.VirtualCF.Position.X,s.VirtualCF.Position.Y+4,s.VirtualCF.Position.Z); local newGround=SinkFindGroundY(char,trackOrigin,40)
        if newGround then local delta=math.abs(newGround-s.VirtualCF.Position.Y); if delta<12 then local smoothed = s.VirtualCF.Position.Y + (newGround - s.VirtualCF.Position.Y) * math.clamp((dt or 0)*18, 0, 1); s.VirtualCF = CFrame.new(s.VirtualCF.Position.X, smoothed, s.VirtualCF.Position.Z) * surfaceRot end end
        local moveDir=hum.MoveDirection
        if moveDir.Magnitude>0 then local speed=hum.WalkSpeed*(Config.WalkSpeedEnabled and Config.WalkSpeedMultiplier or 1)*1.15; local deltaPos=Vector3.new(moveDir.X,0,moveDir.Z)*(speed*(dt or 0)); s.VirtualCF=CFrame.new(s.VirtualCF.Position+deltaPos)*surfaceRot
        else s.VirtualCF=CFrame.new(s.VirtualCF.Position)*surfaceRot end
        local depth=Config.SinkDepth or 5.8; local targetY=s.VirtualCF.Position.Y-depth; local fallen=Workspace.FallenPartsDestroyHeight; if fallen==fallen and targetY<fallen+10 then SinkDeactivate(true); return end
        for part in pairs(s.Parts) do if part.Parent then part.CanCollide=false end end
        for _,d in ipairs(char:GetDescendants()) do if d:IsA('BasePart') and d.CanCollide then s.Parts[d]=true; d.CanCollide=false end end
        root.CFrame=CFrame.new(s.VirtualCF.Position.X,targetY,s.VirtualCF.Position.Z)*surfaceRot; root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero
    end

    local FakePosState = { Enabled=false, Depth=Config.FakePosDepth, Pattern=Config.FakePosPattern or "Walk", Distribution=Config.FakePosDistribution or "Random", AxisLock=Config.FakePosAxisLock or "None", Radius=Config.FakePosRadius or 500, Height=Config.FakePosHeight or 0, Speed=Config.FakePosSpeed or 50, Count=Config.FakePosCount or 5, Reverse=Config.FakePosReverse or false, RandomRadius=Config.FakePosRandomRadius or false, HideClientPos=Config.FakePosHideClientPos or false, WalkMode=Config.FakePosWalkMode, SurfaceCamera=Config.FakePosSurfaceCamera, AutoNoclip=Config.FakePosAutoNoclip, HideMeshes=Config.FakePosHideMeshes, AnimationDesync=Config.FakePosAnimDesync, ZeroVelocity=Config.FakePosZeroVelocity, Panic=Config.FakePosPanic, PanicMinX=Config.FakePosPanicMinX, PanicMaxX=Config.FakePosPanicMaxX, PanicZ=Config.FakePosPanicZ, VisualizerEnabled=Config.FakePosVisualizer, VisualizerColor=Color3.fromRGB(0,162,255), VirtualCF=nil, RealCF=nil, GhostBox=nil, OriginalParts=nil, AnimTrack=nil, HandoffTicks=0, SpiralAngle=0, LinearT=0, LastPacket=0, CameraStep=nil, RenderStep=nil }
    local function SetPositionDesync(source,clientCF,serverCF) local genv=getgenv(); if not genv then return end; genv.position_desync_source=source; genv.client_position=typeof(clientCF)=="CFrame" and clientCF.Position or clientCF; genv.server_position=typeof(serverCF)=="CFrame" and serverCF.Position or serverCF end
    local function ClearPositionDesync() local genv=getgenv(); if not genv then return end; local char=LocalPlayer.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); local pos=hrp and hrp.Position; genv.position_desync_source=nil; genv.client_position=pos; genv.server_position=pos end
    if getgenv then getgenv().set_position_desync=SetPositionDesync; getgenv().clear_position_desync=ClearPositionDesync end
    local function FakePosCaptureOriginal() local char=LocalPlayer.Character; if not char then return end; FakePosState.OriginalParts={}; for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") or part:IsA("Decal") then table.insert(FakePosState.OriginalParts,{part=part,transparency=part.Transparency}); if FakePosState.HideMeshes then pcall(function() part.Transparency=1 end) end end end end
    local function FakePosRestoreOriginal() if not FakePosState.OriginalParts then return end; for _,data in ipairs(FakePosState.OriginalParts) do if data.part and data.part.Parent then pcall(function() data.part.Transparency=data.transparency end) end end; FakePosState.OriginalParts=nil end
    local function FakePosPlayAnimDesync() local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); if not hum or FakePosState.AnimTrack then return end; pcall(function() local anim=Instance.new("Animation"); anim.AnimationId="rbxassetid://10714003221"; local track=hum:LoadAnimation(anim); track:Play(0,1,0); track.TimePosition=1.48; FakePosState.AnimTrack=track end) end
    local function FakePosStopAnimDesync() if FakePosState.AnimTrack then pcall(function() FakePosState.AnimTrack:Stop(); FakePosState.AnimTrack:Destroy() end); FakePosState.AnimTrack=nil end end
    local function FakePosUpdateGhost() local coreGui=(gethui and gethui()) or game:GetService("CoreGui"); if FakePosState.Enabled and FakePosState.VisualizerEnabled and FakePosState.VirtualCF then if not FakePosState.GhostBox or not FakePosState.GhostBox.Parent then local box=Instance.new("BoxHandleAdornment"); box.Name="AcidFakePosGhost"; box.Size=Vector3.new(2,5,1); box.Color3=FakePosState.VisualizerColor; box.Transparency=0.55; box.AlwaysOnTop=true; box.ZIndex=5; box.Adornee=workspace.Terrain; pcall(function() box.Parent=coreGui end); FakePosState.GhostBox=box end; FakePosState.GhostBox.CFrame=FakePosState.VirtualCF else if FakePosState.GhostBox then pcall(function() FakePosState.GhostBox:Destroy() end); FakePosState.GhostBox=nil end end end
    function FakePosState.SetEnabled(state)
        if FakePosState.Enabled==state then return end; FakePosState.Enabled=state; local char=LocalPlayer.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart")
        if state then
            if hrp then FakePosState.VirtualCF=hrp.CFrame; FakePosState.RealCF=hrp.CFrame end; if FakePosState.HideMeshes then FakePosCaptureOriginal() end; if FakePosState.AnimationDesync then FakePosPlayAnimDesync() end
            if FakePosState.CameraStep then pcall(function() RunService:UnbindFromRenderStep(FakePosState.CameraStep) end) end; FakePosState.CameraStep="AcidFakePosCam"
            RunService:BindToRenderStep("AcidFakePosCam",201,function() if FakePosState.Enabled and FakePosState.SurfaceCamera then local cam=workspace.CurrentCamera; local depth=FakePosState.Depth or 5.8; if cam and depth>0 then cam.CFrame=cam.CFrame+Vector3.new(0,depth,0) end end end)
            if FakePosState.RenderStep then pcall(function() RunService:UnbindFromRenderStep(FakePosState.RenderStep) end) end; FakePosState.RenderStep="AcidFakePosRestore"
            RunService:BindToRenderStep("AcidFakePosRestore",202,function() if FakePosState.Enabled and FakePosState.HideClientPos and FakePosState.RealCF then local c2=LocalPlayer.Character; local h2=c2 and c2:FindFirstChild("HumanoidRootPart"); if h2 then pcall(function() h2.CFrame=FakePosState.RealCF end) end end end)
        else
            if FakePosState.CameraStep then pcall(function() RunService:UnbindFromRenderStep(FakePosState.CameraStep) end); FakePosState.CameraStep=nil end; if FakePosState.RenderStep then pcall(function() RunService:UnbindFromRenderStep(FakePosState.RenderStep) end); FakePosState.RenderStep=nil end
            FakePosRestoreOriginal(); FakePosStopAnimDesync(); FakePosUpdateGhost(); if hrp and FakePosState.VirtualCF then pcall(function() if FakePosState.ZeroVelocity then hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero end; hrp.CFrame=FakePosState.VirtualCF end) end
            FakePosState.VirtualCF=nil; FakePosState.RealCF=nil; FakePosState.HandoffTicks=0; FakePosState.SpiralAngle=0; FakePosState.LinearT=0; FakePosState.LastPacket=0; ClearPositionDesync()
        end
    end
    function FakePosState.SetDepth(d) if type(d)=="number" then FakePosState.Depth=d end end
    function FakePosState.SetHideMeshes(h) FakePosState.HideMeshes=(h==true); if not FakePosState.HideMeshes then FakePosRestoreOriginal() elseif FakePosState.Enabled then FakePosCaptureOriginal() end end
    local function UpdateFakePos(dt)
        if not FakePosState.Enabled then FakePosUpdateGhost(); return end; local char=LocalPlayer.Character; if not char then return end; local hrp=char:FindFirstChild("HumanoidRootPart"); local hum=char:FindFirstChildOfClass("Humanoid"); if not hrp or not hum then return end
        if FakePosState.HandoffTicks>0 then FakePosState.HandoffTicks=FakePosState.HandoffTicks-1; if FakePosState.VirtualCF then hrp.CFrame=FakePosState.VirtualCF end; return end
        FakePosState.RealCF=hrp.CFrame; if not FakePosState.VirtualCF then FakePosState.VirtualCF=hrp.CFrame end
        local cam=workspace.CurrentCamera; local camLook=cam and cam.CFrame.LookVector or Vector3.new(0,0,-1); local camYaw=math.atan2(-camLook.X,-camLook.Z); local surfaceRot=CFrame.Angles(0,camYaw,0)
        if FakePosState.WalkMode and (FakePosState.Pattern=="Walk" or FakePosState.Pattern==nil) then local moveDir=hum.MoveDirection; if moveDir.Magnitude>0 then local speed=hum.WalkSpeed*(Config.WalkSpeedEnabled and Config.WalkSpeedMultiplier or 1); local deltaPos=moveDir*(speed*(dt or 0)); FakePosState.VirtualCF=CFrame.new(FakePosState.VirtualCF.Position+deltaPos)*surfaceRot else FakePosState.VirtualCF=CFrame.new(FakePosState.VirtualCF.Position)*surfaceRot end else FakePosState.VirtualCF=CFrame.new(FakePosState.VirtualCF.Position)*surfaceRot end
        local depth=FakePosState.Depth or 5.8; local basePos=FakePosState.VirtualCF.Position-Vector3.new(0,depth,0)
        if FakePosState.Panic then local minX=math.min(FakePosState.PanicMinX,FakePosState.PanicMaxX); local maxX=math.max(FakePosState.PanicMinX,FakePosState.PanicMaxX); local jx=minX+math.random()*(maxX-minX); local jz=FakePosState.PanicZ and ((math.random()-0.5)*(maxX-minX)) or 0; basePos=basePos+Vector3.new(jx,0,jz) end
        if FakePosState.AutoNoclip then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end end end
        if FakePosState.ZeroVelocity then pcall(function() hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero end) end
        local now=tick(); local packetRate=math.max(1, math.floor(FakePosState.Speed or 50)); local interval=1/packetRate; if now-FakePosState.LastPacket>=interval then FakePosState.LastPacket=now end
        local count=math.clamp(math.floor(FakePosState.Count or 5),1,20); local hrp_ni=nil; pcall(function() local mt=getrawmetatable(hrp); if mt then hrp_ni=rawget(mt,"__newindex") end end); local pattern=FakePosState.Pattern
        for _=1,count do
            local off = Vector3.zero
            if pattern~="Walk" and pattern~=nil then
                local dist=FakePosState.Radius or 500; local height=FakePosState.Height or 0; local effRadius=FakePosState.RandomRadius and (math.random()*dist) or dist; if FakePosState.Reverse then effRadius=-effRadius end; local ox,oy,oz = 0,0,0
                if pattern=="Scatter" then local sx=(math.random()<0.5) and 1 or -1; local sz=(math.random()<0.5) and 1 or -1; ox=sx*(math.random()*math.abs(effRadius)); oy=height+(math.random()-0.5)*math.max(math.abs(height),1)*0.5; oz=sz*(math.random()*math.abs(effRadius))
                elseif pattern=="Linear" then FakePosState.LinearT=(FakePosState.LinearT+0.05)%1; local t=FakePosState.LinearT; ox=(t-0.5)*2*math.abs(effRadius); oy=height; oz=(t-0.5)*2*math.abs(effRadius)
                elseif pattern=="Circle" then FakePosState.SpiralAngle=(FakePosState.SpiralAngle+math.rad((FakePosState.Speed or 50)*0.06))%(2*math.pi); ox=math.cos(FakePosState.SpiralAngle)*math.abs(effRadius); oy=height; oz=math.sin(FakePosState.SpiralAngle)*math.abs(effRadius)
                elseif pattern=="Random" then ox=(math.random()*2-1)*math.abs(effRadius); oy=height+(math.random()-0.5)*200; oz=(math.random()*2-1)*math.abs(effRadius)
                elseif pattern=="Spiral" then FakePosState.SpiralAngle=(FakePosState.SpiralAngle+math.rad((FakePosState.Speed or 50)*0.06))%(2*math.pi); local r=math.abs(effRadius)*(0.3+0.7*((FakePosState.SpiralAngle/(2*math.pi))%1)); ox=math.cos(FakePosState.SpiralAngle)*r; oy=height+FakePosState.SpiralAngle*10; oz=math.sin(FakePosState.SpiralAngle)*r end
                local distribution=FakePosState.Distribution; if distribution=="Uniform" then local mag=math.sqrt(ox*ox+oz*oz); if mag>0 then local s=math.abs(effRadius)/mag; ox=ox*s; oz=oz*s end elseif distribution=="Weighted" then ox=ox*0.6; oz=oz*0.6 elseif distribution=="Radial" then local theta=math.atan2(oz,ox); ox=math.cos(theta)*math.abs(effRadius); oz=math.sin(theta)*math.abs(effRadius) elseif distribution=="Clustered" then local ca=math.floor(math.random()*8)*(math.pi*0.25); ox=math.cos(ca)*math.abs(effRadius); oz=math.sin(ca)*math.abs(effRadius) end
                local axis=FakePosState.AxisLock; if axis=="X" then oz=0; oy=height elseif axis=="Y" then ox=0; oz=0 elseif axis=="Z" then ox=0; oy=height elseif axis=="XZ" then oy=height end; off=Vector3.new(ox,oy,oz)
            end
            local fakeCF=CFrame.new(basePos+off); if hrp_ni then pcall(function() hrp_ni(hrp,"AssemblyLinearVelocity",Vector3.zero) end); pcall(function() hrp_ni(hrp,"AssemblyAngularVelocity",Vector3.zero) end); pcall(function() hrp_ni(hrp,"CFrame",fakeCF) end) else pcall(function() hrp.AssemblyLinearVelocity=Vector3.zero; hrp.CFrame=fakeCF end) end; if sethiddenproperty then pcall(sethiddenproperty, hrp, "CFrame", fakeCF); pcall(sethiddenproperty, hrp, "AssemblyLinearVelocity", Vector3.zero) end
        end
        SetPositionDesync("fake", FakePosState.VirtualCF, CFrame.new(basePos)); FakePosUpdateGhost()
    end
    TC(RunService.Heartbeat:Connect(function() if not FakePosState.Enabled or not FakePosState.HideMeshes then return end; if not FakePosState.OriginalParts then return end; for _,data in ipairs(FakePosState.OriginalParts) do local part=data.part; if part and part.Parent and part.Transparency~=1 then pcall(function() part.Transparency=1 end) end end end))
    TC(UserInputService.InputBegan:Connect(function(input,gpe) if gpe then return end; if UserInputService:GetFocusedTextBox() then return end; if input.KeyCode==Enum.KeyCode.X then local newState=not FakePosState.Enabled; Config.FakePosEnabled=newState; FakePosState.SetEnabled(newState); if newState and Config.SinkEnabled then Config.SinkEnabled=false; if SinkState.Active then SinkDeactivate(false) end; if RefreshSinkToggle then RefreshSinkToggle() end end; if RefreshFakeToggle then RefreshFakeToggle() end; SaveConfig() end end))

    local MainRagebotState = { Loaded=false, Enabled=false, Alive=true, LoopStarted=false, RestoreBound=false, Saved=nil, CurrentCF=nil, FireRate=0.05, UnderDepth=1.5, RootToFeet=3, DesyncAngles={Yaw=180,Pitch=0,Roll=0}, DesyncJitter=4.5, VelocityMultiplier=-1500, Remote=nil, Util=nil, Enum=nil, Fighter=nil, AvoidPhase=0, AttackSide="Back", SideToggle=false, LastTargetDist=nil, EscapeBurst=0, WasAttacking=false }
    local GodEndCooldown={}; local GodLastState={}; local RBTrack={}; local RB_HIST_LEN=32; local RB_VOID_THRESH=-200
    local function rb_validate(x,y,z) if x~=x or y~=y or z~=z then return false end; if math.abs(x)==math.huge or math.abs(y)==math.huge or math.abs(z)==math.huge then return false end; return true end
    local function rb_validate_vec3(v) if not v then return false end return rb_validate(v.X,v.Y,v.Z) end
    local function rb_record(part,x,y,z,now)
        if not rb_validate(x,y,z) then return end; local t=RBTrack[part]
        if not t then t={x=x,y=y,z=z,t=now,lkg_x=x,lkg_y=y,lkg_z=z,lkg_t=now,vx=0,vy=0,vz=0,is_void=(y<RB_VOID_THRESH),hist={},hi=0,clones=0}; RBTrack[part]=t
        else local px,py,pz,pt=t.x,t.y,t.z,t.t; t.x,t.y,t.z,t.t=x,y,z,now; local dt=now-pt; if dt>0.0001 then local rvx=(x-px)/dt; local rvy=(y-py)/dt; local rvz=(z-pz)/dt; t.vx=t.vx*0.7+rvx*0.3; t.vy=t.vy*0.7+rvy*0.3; t.vz=t.vz*0.7+rvz*0.3; local mag=math.sqrt(rvx*rvx+rvy*rvy+rvz*rvz); if mag>500 then t.clones=(t.clones or 0)+1 else if (t.clones or 0)>0 then t.clones=t.clones-0.25 end end end; t.is_void=(y<RB_VOID_THRESH); if not t.is_void then t.lkg_x,t.lkg_y,t.lkg_z,t.lkg_t=x,y,z,now end end
        local hi=(t.hi%RB_HIST_LEN)+1; t.hi=hi; t.hist[hi]={x=x,y=y,z=z,t=now}
    end
    local function rb_read_part(part) if not part then return nil end; local cf; pcall(function() local mt=getrawmetatable(part); if mt then local ri=rawget(mt,"__index"); if ri then cf=ri(part,"CFrame") end end end); if cf then local x,y,z=cf.X,cf.Y,cf.Z; if rb_validate(x,y,z) then return Vector3.new(x,y,z) end end; pcall(function() if gethiddenproperty then local v=gethiddenproperty(part,"CFrame"); if v then cf=v end end end); if cf then local x,y,z=cf.X,cf.Y,cf.Z; if rb_validate(x,y,z) then return Vector3.new(x,y,z) end end; pcall(function() cf=part.CFrame end); if cf then local x,y,z=cf.X,cf.Y,cf.Z; if rb_validate(x,y,z) then return Vector3.new(x,y,z) end end; return nil end
    local function rb_get_target_center(part, head) local t=RBTrack[part]; if not t then local p=rb_read_part(part); if p then return p end; return nil end; if t.is_void and t.lkg_x then return Vector3.new(t.lkg_x,t.lkg_y,t.lkg_z) end; if t.x~=nil and rb_validate(t.x,t.y,t.z) then return Vector3.new(t.x,t.y,t.z) end; return nil end
    local function rb_get_velocity(part) local t=RBTrack[part]; if not t then return Vector3.zero end; return Vector3.new(t.vx,t.vy,t.vz) end
    local function rb_get_lead_pos(part, head, lead) local base=rb_get_target_center(part,head); if not base then return nil end; if not lead then return base end; local vel=rb_get_velocity(part); if vel.Magnitude<0.1 then return base end; local lt=math.clamp(vel.Magnitude/500*lead, 0, 0.35); local led=base+vel*lt; if rb_validate_vec3(led) then return led end; return base end
    local function rb_nuke_fallen() pcall(function() workspace.FallenPartsDestroyHeight=-math.huge end); pcall(function() workspace.FallenPartsDestroyHeight=0/0 end); pcall(function() local mt=getrawmetatable(workspace); if mt then local ni=rawget(mt,"__newindex"); if ni then ni(workspace,"FallenPartsDestroyHeight",-math.huge); pcall(function() ni(workspace,"FallenPartsDestroyHeight",0/0) end) end end end) end
    local function rb_write_cframe(hrp, target_cf) rb_nuke_fallen(); local V0=Vector3.zero; local written=false; pcall(function() local mt=getrawmetatable(hrp); if not mt then return end; local ni=rawget(mt,"__newindex"); if not ni then return end; ni(hrp,"AssemblyLinearVelocity",V0); ni(hrp,"AssemblyAngularVelocity",V0); ni(hrp,"CFrame",target_cf); ni(hrp,"AssemblyLinearVelocity",V0); ni(hrp,"AssemblyAngularVelocity",V0); written=true end); if not written then pcall(function() hrp.AssemblyLinearVelocity=V0; hrp.AssemblyAngularVelocity=V0; hrp.CFrame=target_cf; hrp.AssemblyLinearVelocity=V0 end) end; if sethiddenproperty then pcall(sethiddenproperty,hrp,"AssemblyLinearVelocity",V0); pcall(sethiddenproperty,hrp,"AssemblyAngularVelocity",V0); pcall(sethiddenproperty,hrp,"CFrame",target_cf) end; pcall(function() local was=hrp.Anchored; hrp.Anchored=true; hrp.CFrame=target_cf; hrp.AssemblyLinearVelocity=V0; hrp.AssemblyAngularVelocity=V0; hrp.Anchored=was end); rb_nuke_fallen() end
    local _manip_ray = RaycastParams.new(); local _manip_offsets = {Vector3.new(0,12,0),Vector3.new(0,16,0),Vector3.new(0,20,0),Vector3.new(0,24,0),Vector3.new(0,28,0),Vector3.new(0,32,0),Vector3.new(0,36,0),Vector3.new(0,40,0)}
    local function rb_fire_toward(target_part, target_char)
        pcall(function() local rs=ReplicatedStorage; local util_ok,util=pcall(require,rs.Modules.Utility); local enums_ok,enums=pcall(require,rs.Modules.EnumLibrary); local fighter_ok,fighter=pcall(require,LocalPlayer.PlayerScripts.Controllers.FighterController); if not util_ok or not enums_ok or not fighter_ok then return end; if not fighter.LocalFighter then return end; local item=fighter.LocalFighter.EquippedItem; if not item then return end; local cam=workspace.CurrentCamera.CFrame; local shootPos=cam.Position; _manip_ray.FilterDescendantsInstances={LocalPlayer.Character,target_char}; _manip_ray.FilterType=Enum.RaycastFilterType.Exclude; if workspace:Raycast(shootPos,target_part.Position-shootPos,_manip_ray) then for _,offset in ipairs(_manip_offsets) do local scan=shootPos+offset; if not workspace:Raycast(scan,target_part.Position-scan,_manip_ray) then shootPos=scan; break end end end; local targetPos=target_part.Position; local aimCF=CFrame.lookAt(shootPos,targetPos); local cameraData={}; cameraData[utf8.char(1)]={[utf8.char(0)]=util:EncodeCFrame(aimCF),[utf8.char(1)]=util:EncodeCFrame(target_part.CFrame),[utf8.char(2)]=target_part,[utf8.char(3)]=util:EncodeCFrame(target_part.CFrame:ToObjectSpace(CFrame.new(targetPos)))}; local objectId=item:Get("ObjectID"); if not objectId then return end; rs.Remotes.Replication.Fighter.UseItem:FireServer(objectId,enums:ToEnum("StartShooting"),cameraData,nil); task.delay(0.05, function() pcall(function() rs.Remotes.Replication.Fighter.UseItem:FireServer(objectId,enums:ToEnum("StopShooting"),nil,nil) end) end) end)
    end
    local function MainRagebotLoadModules() local r=MainRagebotState; if r.Loaded then return true end; local ok=pcall(function() local rep=ReplicatedStorage; local ps=LocalPlayer:FindFirstChild('PlayerScripts'); local ctrl=ps and ps:FindFirstChild('Controllers'); if not ctrl then error('no controllers') end; local remotes=rep:FindFirstChild('Remotes'); local replication=remotes and remotes:FindFirstChild('Replication'); local fighterRem=replication and replication:FindFirstChild('Fighter'); local useItem=fighterRem and fighterRem:FindFirstChild('UseItem'); if not useItem then error('no UseItem') end; local modules=rep:FindFirstChild('Modules'); if not modules then error('no modules') end; local utility=modules:FindFirstChild('Utility'); local enumLib=modules:FindFirstChild('EnumLibrary'); if not utility or not enumLib then error('no utility/enum') end; local fc=ctrl:FindFirstChild('FighterController'); if not fc then error('no fc') end; r.Remote=useItem; r.Util=require(utility); r.Enum=require(enumLib); r.Fighter=require(fc) end); r.Loaded=ok and r.Util~=nil and r.Fighter~=nil and r.Remote~=nil; return r.Loaded end
    local function MainRagebotRestore() local r=MainRagebotState; local saved=r.Saved; if not saved then return end; r.Saved=nil; if saved.Root and saved.Root.Parent then saved.Root.CFrame=saved.CFrame; saved.Root.AssemblyLinearVelocity=saved.Velocity; saved.Root.AssemblyAngularVelocity=saved.AngularVelocity end end
    local function RagebotSafeRestore() local r=MainRagebotState; if r.Saved and r.Saved.Root and r.Saved.Root.Parent then pcall(MainRagebotRestore) end; r.Saved=nil; r.CurrentCF=nil end
    local function IsLocalPlayerReady() local char=LocalPlayer.Character; if not char or not char.Parent then return false end; local hum=char:FindFirstChildOfClass("Humanoid"); local root=char:FindFirstChild("HumanoidRootPart"); if not hum or not root then return false end; if hum.Health<=0 then return false end; if root.Parent~=char then return false end; return true end
    local function GetFallenY() local f=Workspace.FallenPartsDestroyHeight; if type(f)~="number" or f~=f then f=-500 end; return f end
    local function IsTargetInvulnerable(player) local ch=player and player.Character; if not ch then return false end; local hum=ch:FindFirstChildOfClass("Humanoid"); if not hum then return false end; if hum.Health<=0 then return true end; local invuln=false; local attrs={"GodMode","godmode","IsGod","isGod","Invulnerable","invulnerable","ForceField","forcefield","NoDamage","nodamage","Invincible","invincible"}; for _,a in ipairs(attrs) do if hum:GetAttribute(a)==true then invuln=true break end end; if not invuln then for _,a in ipairs(attrs) do if ch:GetAttribute(a)==true then invuln=true break end end end; if not invuln and ch:FindFirstChildOfClass("ForceField") then invuln=true end; GodLastState[player]=invuln; return invuln end
    local function IsLocalPlayerAttacking() local r=MainRagebotState; local fighter=r.Fighter and r.Fighter.LocalFighter; if type(fighter)=="table" then local flags={"IsShooting","IsAttacking","Attacking","Shooting","IsMeleeing","Meleeing"}; for _,f in ipairs(flags) do if rawget(fighter,f)==true then return true end end end; if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then return true end; if UserInputService:IsKeyDown(Enum.KeyCode.ButtonR2) then return true end; return false end
    local function IsLocalPlayerReloading() local r=MainRagebotState; local fighter=r.Fighter and r.Fighter.LocalFighter; if type(fighter)=="table" then local flags={"IsReloading","Reloading","IsReload","Reload"}; for _,f in ipairs(flags) do if rawget(fighter,f)==true then return true end end; local item=rawget(fighter,"EquippedItem"); if type(item)=="table" then for _,f in ipairs(flags) do if rawget(item,f)==true then return true end end end end; if UserInputService:IsKeyDown(Enum.KeyCode.R) then return true end; return false end
    local function IsPositionInVoid(pos) local fallen=GetFallenY(); if pos.Y<=fallen+10 then return true end; local params=RaycastParams.new(); params.FilterType=Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances={LocalPlayer.Character}; params.IgnoreWater=true; local result=Workspace:Raycast(pos,Vector3.new(0,-3000,0),params); if not result then return true end; if result.Position.Y<=fallen+10 then return true end; return false end
    local TargetHistory = {}
    local function IsTargetSuspicious(player) if not Config.RagebotAntiBait then return false end; local ch=player and player.Character; if not ch then return false end; local root=ch:FindFirstChild("HumanoidRootPart"); local hum=ch:FindFirstChildOfClass("Humanoid"); if not root or not hum or hum.Health<=0 then return false end; if IsPositionInVoid(root.Position) then return true end; local fallen=GetFallenY(); if root.Position.Y<fallen+(Config.RagebotSafeMargin or 100)+50 then return true end; local prev=TargetHistory[player]; local now=os.clock(); if prev and prev.pos then local dt=now-prev.t; if dt>0 and dt<0.5 then if ((root.Position-prev.pos).Magnitude/dt)>500 then return true end end end; TargetHistory[player]={pos=root.Position,t=now}; return false end
    local function FindBestTarget(myRoot, maxDist) maxDist=maxDist or 500; local bestPlayer,bestRoot,bestHead,bestHum,bestDist=nil,nil,nil,nil,maxDist; for _,player in ipairs(Players:GetPlayers()) do if player~=LocalPlayer and isEnemy(player) then if Config.RagebotWaitGodEnd and IsTargetInvulnerable(player) then continue end; if Config.RagebotAntiBait and IsTargetSuspicious(player) then continue end; local c=player.Character; local rt=c and c:FindFirstChild('HumanoidRootPart'); local hd=c and c:FindFirstChild('Head'); local hm=c and c:FindFirstChildWhichIsA('Humanoid'); if rt and hd and hm and hm.Health>0 then local d=(myRoot.Position-rt.Position).Magnitude; if d<bestDist then bestDist=d; bestPlayer,bestRoot,bestHead,bestHum=player,rt,hd,hm end end end end; return bestPlayer,bestRoot,bestHead,bestHum,bestDist end
    local function MainRagebotFireLoop() local r=MainRagebotState; while r.Alive do task.wait(0.1); if r.Enabled and r.Loaded then pcall(function() local char=LocalPlayer.Character; local myRoot=char and char:FindFirstChild('HumanoidRootPart'); if not myRoot then return end; local _,_,bestHead,bestHum=FindBestTarget(myRoot,500); if not bestHead or not bestHum then return end; rb_fire_toward(bestHead,bestHum.Parent) end) end end end
    local function UpdateMainRagebot()
        local r=MainRagebotState; local wanted=Config.MainRagebotEnabled; r.Enabled=wanted; if not wanted then RagebotSafeRestore(); return end; if not IsLocalPlayerReady() then RagebotSafeRestore(); return end; local reloading=IsLocalPlayerReloading(); local attacking=IsLocalPlayerAttacking(); if Config.RagebotPauseOnReload and reloading then RagebotSafeRestore(); return end; if not r.Loaded and not MainRagebotLoadModules() then r.Enabled=false; Config.MainRagebotEnabled=false; notify("Ragebot","Could not load the game modules.",3); RagebotSafeRestore(); return end; if not r.RestoreBound then r.RestoreBound=true; RunService:BindToRenderStep('MainRagebotRestore',101,MainRagebotRestore) end; if not r.LoopStarted then r.LoopStarted=true; task.spawn(MainRagebotFireLoop) end
        if Config.RagebotOnlyOnAttack then if not attacking then RagebotSafeRestore(); r.WasAttacking=false; return end; r.WasAttacking=true end
        local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass('Humanoid'); local myRoot=char and char:FindFirstChild('HumanoidRootPart'); if not hum or not myRoot or hum.Health<=0 then RagebotSafeRestore(); return end; local _,targetRoot,targetHead,targetHum,bestDist=FindBestTarget(myRoot,500); if not targetRoot or not targetHead or not targetHum then RagebotSafeRestore(); return end
        local trackBoost=math.clamp(Config.RagebotTrackBoost or 3,1,8); local boost=math.min(trackBoost,6); for _=1,boost do local p=rb_read_part(targetRoot); if p then rb_record(targetRoot,p.X,p.Y,p.Z,tick()) end; local ph=rb_read_part(targetHead); if ph then rb_record(targetHead,ph.X,ph.Y,ph.Z,tick()) end end
        local avoid=Config.RagebotAvoidMelee~=false; local dist=tonumber(Config.RagebotDistance) or 0; local height=tonumber(Config.RagebotHeight) or r.UnderDepth; if avoid then if dist<3 then dist=3 end; if height<4 then height=4 end end; if r.LastTargetDist then if (r.LastTargetDist-bestDist)>2 then r.EscapeBurst=0.35 end end; r.LastTargetDist=bestDist
        local velMult=r.VelocityMultiplier; if (r.EscapeBurst or 0)>0 then velMult=velMult*1.6; r.EscapeBurst=math.max(0,r.EscapeBurst-0.05) end; local horiz=Vector3.zero; if dist>0 then r.AvoidPhase=(r.AvoidPhase or 0)+0.05; horiz=Vector3.new(math.cos(r.AvoidPhase)*dist,0,math.sin(r.AvoidPhase)*dist) end
        local targetCenter=rb_get_target_center(targetRoot,targetHead) or targetRoot.Position; local leadPos=targetCenter; if Config.RagebotAimLead then leadPos=rb_get_lead_pos(targetRoot,targetHead,1) or targetCenter end; local underPos=Vector3.new(leadPos.X,leadPos.Y,leadPos.Z)-Vector3.new(0,r.RootToFeet+height,0)+horiz; if not Config.RagebotVoidHunter then if underPos.Y<GetFallenY()+(Config.RagebotSafeMargin or 100) then RagebotSafeRestore(); return end end
        r.CurrentCF=CFrame.lookAt(underPos,targetHead.Position,Vector3.new(0,0,1)); r.Saved={Root=myRoot,CFrame=myRoot.CFrame,Velocity=myRoot.AssemblyLinearVelocity,AngularVelocity=myRoot.AssemblyAngularVelocity}
        local mode=Config.RagebotMode or "Backstab"; local yaw; if mode=="Front" then yaw=0; r.AttackSide="Front" elseif mode=="Backstab" then yaw=180; r.AttackSide="Back" elseif mode=="Random" then if math.random()<0.5 then yaw=0; r.AttackSide="Front" else yaw=180; r.AttackSide="Back" end elseif mode=="Alternate" then r.SideToggle=not r.SideToggle; if r.SideToggle then yaw=0; r.AttackSide="Front" else yaw=180; r.AttackSide="Back" end else yaw=tonumber(Config.RagebotYaw) or 180 end
        local jitterStrength=tonumber(Config.RagebotJitterStrength) or r.DesyncJitter; local jitter=Vector3.new((math.random()-0.5)*jitterStrength,0,(math.random()-0.5)*jitterStrength); local angleShift=CFrame.Angles(math.rad(r.DesyncAngles.Pitch),math.rad(yaw),math.rad(r.DesyncAngles.Roll)); local dir=r.Saved.Velocity.Magnitude>0.1 and r.Saved.Velocity.Unit or r.Saved.CFrame.LookVector; local targetCF=r.CurrentCF*angleShift+jitter; local reps=math.clamp(Config.RagebotSnapReps or 6,1,12); for _=1,reps do rb_write_cframe(myRoot,targetCF) end; pcall(function() myRoot.AssemblyLinearVelocity=dir*velMult; myRoot.AssemblyAngularVelocity=Vector3.new(0,500,0) end)
    end
    TC(RunService.Heartbeat:Connect(function() if isUnloaded then return end; pcall(UpdateMainRagebot) end))

    local CC=nil
    local function destroyWT() if CC and CC.Parent then CC:Destroy() end; CC=nil end
    local function ensureWT() if CC and CC.Parent then return CC end; for _,ch in ipairs(Lighting:GetChildren()) do if ch:IsA("ColorCorrectionEffect") and ch.Name=="AcidWorldTint" then ch:Destroy() end end; CC=Instance.new("ColorCorrectionEffect"); CC.Name="AcidWorldTint"; CC.Parent=Lighting; return CC end
    local function applyWT() if not Config.WorldTintEnabled then destroyWT(); return end; local c=ensureWT(); c.TintColor=Config.WorldTintColor; c.Brightness=Config.WorldBrightness; c.Contrast=Config.WorldContrast; c.Saturation=Config.WorldSaturation end
    applyWT()

-- [PART 4 CONTINUES HERE]
local auraFolder,auraMain,auraRing,auraGround,auraLight; local auraConns={}
    local function buildAuraColor() return ColorSequence.new({ColorSequenceKeypoint.new(0.00,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(0.20,Color3.fromRGB(150,220,255)),ColorSequenceKeypoint.new(0.55,Color3.fromRGB(130,110,255)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(70,40,160))}) end
    local function buildAuraSize(b) return NumberSequence.new({NumberSequenceKeypoint.new(0.00,b*0.25),NumberSequenceKeypoint.new(0.35,b*0.9),NumberSequenceKeypoint.new(1.00,b*1.6)}) end
    local function buildAuraTrans() return NumberSequence.new({NumberSequenceKeypoint.new(0.00,0.15),NumberSequenceKeypoint.new(0.30,Config.AuraTransparency),NumberSequenceKeypoint.new(1.00,1.00)}) end
    local function clearAura() for _,c in ipairs(auraConns) do pcall(function() c:Disconnect() end) end; table.clear(auraConns); if auraFolder and auraFolder.Parent then auraFolder:Destroy() end; auraFolder,auraMain,auraRing,auraGround,auraLight=nil,nil,nil,nil,nil end
    local function rebuildAura(char)
        clearAura(); if isUnloaded or not Config.AuraEnabled or char==nil then return end
        local hrp=char:WaitForChild("HumanoidRootPart",5); if not hrp then return end
        auraFolder=Instance.new("Folder"); auraFolder.Name="AuraFog"; auraFolder.Parent=char
        local a=Instance.new("Attachment"); a.Position=Vector3.new(0,-2,0); a.Parent=hrp
        auraMain=Instance.new("ParticleEmitter"); auraMain.Texture="rbxasset://textures/particles/smoke_main.dds"; auraMain.LightEmission=1; auraMain.LightInfluence=0; auraMain.Transparency=buildAuraTrans(); auraMain.Size=buildAuraSize(Config.AuraSize); auraMain.Color=buildAuraColor(); auraMain.Lifetime=NumberRange.new(Config.AuraLifetime*0.7,Config.AuraLifetime); auraMain.Rate=Config.AuraIntensity; auraMain.Speed=NumberRange.new(Config.AuraSpeed*0.5,Config.AuraSpeed*1.4); auraMain.Rotation=NumberRange.new(0,360); auraMain.RotSpeed=NumberRange.new(-45,45); auraMain.SpreadAngle=Vector2.new(180,180); auraMain.Shape=Enum.ParticleEmitterShape.Sphere; auraMain.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward; auraMain.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume; auraMain.EmissionDirection=Enum.NormalId.Top; auraMain.Acceleration=Vector3.new(0,8,0); auraMain.Drag=1.5; auraMain.Parent=a
        local r=Instance.new("Attachment"); r.Parent=hrp
        auraRing=Instance.new("ParticleEmitter"); auraRing.Texture="rbxasset://textures/particles/smoke_main.dds"; auraRing.LightEmission=1; auraRing.LightInfluence=0; auraRing.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.00,0.30),NumberSequenceKeypoint.new(0.50,Config.AuraTransparency),NumberSequenceKeypoint.new(1.00,1.00)}); auraRing.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.00,Config.AuraSize*0.7),NumberSequenceKeypoint.new(1.00,Config.AuraSize*1.2)}); auraRing.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.00,Color3.fromRGB(150,200,255)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(120,80,220))}); auraRing.Lifetime=NumberRange.new(Config.AuraLifetime*0.8,Config.AuraLifetime); auraRing.Rate=math.floor(Config.AuraIntensity*0.5); auraRing.Speed=NumberRange.new(0.6,1.6); auraRing.Rotation=NumberRange.new(0,360); auraRing.RotSpeed=NumberRange.new(-30,30); auraRing.SpreadAngle=Vector2.new(360,0); auraRing.Shape=Enum.ParticleEmitterShape.Cylinder; auraRing.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward; auraRing.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume; auraRing.EmissionDirection=Enum.NormalId.Top; auraRing.Acceleration=Vector3.new(0,3,0); auraRing.Drag=2; auraRing.Parent=r
        local g=Instance.new("Attachment"); g.Position=Vector3.new(0,-2.8,0); g.Parent=hrp
        auraGround=Instance.new("ParticleEmitter"); auraGround.Texture="rbxasset://textures/particles/sparkles_main.dds"; auraGround.LightEmission=1; auraGround.LightInfluence=0; auraGround.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.00,0.15),NumberSequenceKeypoint.new(0.40,0.55),NumberSequenceKeypoint.new(1.00,1.00)}); auraGround.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.00,Config.AuraSize*0.15),NumberSequenceKeypoint.new(0.50,Config.AuraSize*0.45),NumberSequenceKeypoint.new(1.00,Config.AuraSize*0.7)}); auraGround.Color=buildAuraColor(); auraGround.Lifetime=NumberRange.new(0.7,1.2); auraGround.Rate=math.floor(Config.AuraIntensity*0.7); auraGround.Speed=NumberRange.new(2,5); auraGround.Rotation=NumberRange.new(0,360); auraGround.RotSpeed=NumberRange.new(-60,60); auraGround.SpreadAngle=Vector2.new(180,180); auraGround.Shape=Enum.ParticleEmitterShape.Sphere; auraGround.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward; auraGround.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume; auraGround.EmissionDirection=Enum.NormalId.Top; auraGround.Acceleration=Vector3.new(0,4,0); auraGround.Drag=3; auraGround.Parent=g
        auraLight=Instance.new("PointLight"); auraLight.Color=Color3.fromRGB(140,120,255); auraLight.Brightness=Config.AuraGlowIntensity; auraLight.Range=16; auraLight.Shadows=false; auraLight.Parent=hrp
        table.insert(auraConns,char.Destroying:Connect(clearAura))
    end

    local ESPGui=Instance.new("ScreenGui"); ESPGui.Name="AcidESP"; ESPGui.ResetOnSpawn=false; ESPGui.IgnoreGuiInset=true; ESPGui.DisplayOrder=100; ESPGui.Parent=ScreenGui
    local Boxes={}; local Cam=workspace.CurrentCamera; local ESP_EVERY=2
    local function sameTeam(p) if not Config.ESPTeamCheck then return false end; local a=LocalPlayer:GetAttribute("TeamID"); local b=p:GetAttribute("TeamID"); if a==nil or b==nil then return false end; return a==b end
    local function createESP(p)
        local c=Instance.new("Frame"); c.BackgroundTransparency=1; c.BorderSizePixel=0; c.Visible=false; c.ZIndex=100; c.Parent=ESPGui
        local box=Instance.new("Frame"); box.BackgroundTransparency=1; box.BorderSizePixel=0; box.ZIndex=101; box.Parent=c
        local st=Instance.new("UIStroke"); st.Color=Config.ESPColor; st.Thickness=Config.ESPBoxThickness; st.Parent=box
        local co=Instance.new("UICorner"); co.CornerRadius=UDim.new(0,3); co.Parent=box
        local hbBg=Instance.new("Frame"); hbBg.BackgroundColor3=Color3.fromRGB(20,20,20); hbBg.BorderSizePixel=0; hbBg.ZIndex=102; hbBg.Parent=c
        local hb=Instance.new("Frame"); hb.BackgroundColor3=Color3.fromRGB(80,255,120); hb.BorderSizePixel=0; hb.Size=UDim2.new(1,0,1,0); hb.ZIndex=103; hb.Parent=hbBg
        local hbC=Instance.new("UICorner"); hbC.CornerRadius=UDim.new(0,1); hbC.Parent=hb
        local nl=Instance.new("TextLabel"); nl.BackgroundTransparency=1; nl.TextColor3=Config.ESPColor; nl.TextStrokeColor3=Color3.new(); nl.TextStrokeTransparency=0; nl.TextSize=14; nl.Font=Enum.Font.GothamBold; nl.TextXAlignment=Enum.TextXAlignment.Center; nl.ZIndex=104; nl.Parent=c
        local hl=Instance.new("TextLabel"); hl.BackgroundTransparency=1; hl.TextColor3=Color3.fromRGB(220,255,220); hl.TextStrokeColor3=Color3.new(); hl.TextStrokeTransparency=0; hl.TextSize=12; hl.Font=Enum.Font.GothamBold; hl.TextXAlignment=Enum.TextXAlignment.Center; hl.ZIndex=104; hl.Parent=c
        local dl=Instance.new("TextLabel"); dl.BackgroundTransparency=1; dl.TextColor3=Color3.fromRGB(220,220,240); dl.TextStrokeColor3=Color3.new(); dl.TextStrokeTransparency=0; dl.TextSize=12; dl.Font=Enum.Font.GothamBold; dl.TextXAlignment=Enum.TextXAlignment.Center; dl.ZIndex=104; dl.Parent=c
        Boxes[p]={C=c,Box=box,Stroke=st,HBBg=hbBg,HB=hb,Name=nl,HL=hl,D=dl}
    end
    local function removeESP(p) local e=Boxes[p]; if e then if e.C then e.C:Destroy() end Boxes[p]=nil end end
    local function updateESP(p,e)
        if not Config.ESPEnabled or p==LocalPlayer or sameTeam(p) then e.C.Visible=false; return end
        local ch=p.Character; if not ch then e.C.Visible=false; return end
        local hum=ch:FindFirstChildOfClass("Humanoid"); local root=ch:FindFirstChild("HumanoidRootPart")
        if not hum or hum.Health<=0 or not root then e.C.Visible=false; return end
        if not Cam then Cam=workspace.CurrentCamera end; if not Cam then e.C.Visible=false; return end
        local cf,size=ch:GetBoundingBox(); local ts=Cam:WorldToViewportPoint(cf.Position+cf.UpVector*(size.Y/2)); local bs=Cam:WorldToViewportPoint(cf.Position-cf.UpVector*(size.Y/2))
        if ts.Z<=0 or bs.Z<=0 then e.C.Visible=false; return end
        local rawH=math.abs(bs.Y-ts.Y)*0.96; if rawH<=0.05 then e.C.Visible=false; return end
        local h=math.max(rawH,8); local w=h*0.42; local cx=(ts.X+bs.X)/2; local cy=(ts.Y+bs.Y)/2; local pad=6
        e.C.Position=UDim2.fromOffset(cx-w/2-pad,cy-h/2-20); e.C.Size=UDim2.fromOffset(w+pad*2,h+20+34)
        e.Box.Position=UDim2.fromOffset(pad,20); e.Box.Size=UDim2.fromOffset(w,h)
        e.Name.Position=UDim2.fromOffset(pad,0); e.Name.Size=UDim2.fromOffset(w,12); e.Name.Text=p.DisplayName or p.Name; e.Name.Visible=Config.ESPShowName
        e.HL.Position=UDim2.fromOffset(pad,12); e.HL.Size=UDim2.fromOffset(w,12); e.HL.Text=math.floor(hum.Health).."/"..math.floor(hum.MaxHealth); e.HL.Visible=Config.ESPShowHealth
        if Config.ESPShowHealthBar then e.HBBg.Visible=true; e.HBBg.Position=UDim2.fromOffset(pad,20+h+2); e.HBBg.Size=UDim2.fromOffset(w,5); local rt=math.clamp(hum.Health/math.max(1,hum.MaxHealth),0,1); e.HB.Size=UDim2.new(rt,0,1,0); e.HB.BackgroundColor3=rt>0.5 and Color3.fromRGB(80,255,120) or rt>0.25 and Color3.fromRGB(255,220,80) or Color3.fromRGB(255,80,80) else e.HBBg.Visible=false end
        local dist=(Cam.CFrame.Position-root.Position).Magnitude; e.D.Position=UDim2.fromOffset(pad,20+h+10); e.D.Size=UDim2.fromOffset(w,12); e.D.Text=math.floor(dist).."m"; e.D.Visible=Config.ESPShowDistance; e.Stroke.Color=Config.ESPColor; e.Stroke.Thickness=Config.ESPBoxThickness; e.C.Visible=true
    end
    for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer then createESP(p) end end
    TC(Players.PlayerAdded:Connect(function(p) if p~=LocalPlayer then createESP(p) end end))
    TC(Players.PlayerRemoving:Connect(removeESP))
    local espFC=0; TC(RunService.RenderStepped:Connect(function() espFC=espFC+1; if espFC%ESP_EVERY~=0 then return end; Cam=workspace.CurrentCamera; if not Cam then return end; for p,e in pairs(Boxes) do updateESP(p,e) end end))

    local W={Folder=nil,LS=nil,RS=nil,LT={},RT={},LB={},RB={},LF={},RF={},LG=nil,RG=nil,Flap=0,Conns={}}
    local TO={{x=-2.0,y=2.0,z=-0.3},{x=-1.6,y=1.2,z=0.0},{x=-1.3,y=0.4,z=0.2},{x=-1.1,y=-0.4,z=0.3}}
    local function clearWings() for _,c in ipairs(W.Conns) do pcall(function() c:Disconnect() end) end; table.clear(W.Conns); if W.Folder and W.Folder.Parent then W.Folder:Destroy() end; W.Folder=nil; W.LS=nil; W.RS=nil; W.LT,W.RT,W.LB,W.RB,W.LF,W.RF={},{},{},{},{},{}; W.LG=nil; W.RG=nil; W.Flap=0 end
    local function buildBeam(a0,a1,c,w) local b=Instance.new("Beam"); b.Attachment0=a0; b.Attachment1=a1; b.Width0=w; b.Width1=w*0.3; b.LightEmission=1; b.LightInfluence=0; b.FaceCamera=true; b.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,c),ColorSequenceKeypoint.new(0.5,c:Lerp(Color3.new(1,1,1),0.4)),ColorSequenceKeypoint.new(1,c)}); b.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.15),NumberSequenceKeypoint.new(0.6,0.4),NumberSequenceKeypoint.new(1,0.9)}); b.Texture="rbxasset://textures/particles/sparkles_main.dds"; b.TextureLength=4; b.TextureSpeed=1.5; b.Segments=8; return b end
    local function buildFeathers(a,c) local e=Instance.new("ParticleEmitter"); e.Texture="rbxasset://textures/particles/sparkles_main.dds"; e.LightEmission=1; e.LightInfluence=0; e.Color=ColorSequence.new(c); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.4),NumberSequenceKeypoint.new(1,0)}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}); e.Lifetime=NumberRange.new(0.6,1.2); e.Rate=20; e.Speed=NumberRange.new(0.5,2); e.SpreadAngle=Vector2.new(60,60); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-60,60); e.Acceleration=Vector3.new(0,-3,0); e.Parent=a; return e end
    local function applyWingsAppearance() local c=Config.WingsColor; local seq=ColorSequence.new({ColorSequenceKeypoint.new(0,c),ColorSequenceKeypoint.new(0.5,c:Lerp(Color3.new(1,1,1),0.4)),ColorSequenceKeypoint.new(1,c)}); for _,b in pairs(W.LB) do b.Color=seq; b.Width0=Config.WingsSize; b.Width1=Config.WingsSize*0.3 end; for _,b in pairs(W.RB) do b.Color=seq; b.Width0=Config.WingsSize; b.Width1=Config.WingsSize*0.3 end; for _,p in pairs(W.LF) do p.Color=ColorSequence.new(c) end; for _,p in pairs(W.RF) do p.Color=ColorSequence.new(c) end; if W.LG then W.LG.Color=c end; if W.RG then W.RG.Color=c end end
    local function rebuildWings(char)
        clearWings(); if isUnloaded or not Config.WingsEnabled or char==nil then return end
        local hrp=char:WaitForChild("HumanoidRootPart",5); if not hrp then return end
        W.Folder=Instance.new("Folder"); W.Folder.Name="ParticleWings"; W.Folder.Parent=char; W.LS=Instance.new("Attachment"); W.LS.Position=Vector3.new(-0.7,0.3,0.4); W.LS.Parent=hrp; W.RS=Instance.new("Attachment"); W.RS.Position=Vector3.new(0.7,0.3,0.4); W.RS.Parent=hrp
        for i=1,4 do local o=TO[i]; local lt=Instance.new("Attachment"); lt.Position=Vector3.new(o.x*Config.WingsSpread,o.y*Config.WingsHeight,o.z); lt.Parent=hrp; W.LT[i]=lt; local rt=Instance.new("Attachment"); rt.Position=Vector3.new(-o.x*Config.WingsSpread,o.y*Config.WingsHeight,o.z); rt.Parent=hrp; W.RT[i]=rt end
        for i=1,4 do W.LB[i]=buildBeam(W.LS,W.LT[i],Config.WingsColor,Config.WingsSize); W.LB[i].Parent=W.Folder; W.RB[i]=buildBeam(W.RS,W.RT[i],Config.WingsColor,Config.WingsSize); W.RB[i].Parent=W.Folder end
        for i=1,3 do W.LB[i+4]=buildBeam(W.LT[i],W.LT[i+1],Config.WingsColor,Config.WingsSize*0.6); W.LB[i+4].Parent=W.Folder; W.RB[i+4]=buildBeam(W.RT[i],W.RT[i+1],Config.WingsColor,Config.WingsSize*0.6); W.RB[i+4].Parent=W.Folder end
        if Config.WingsShowFeathers then for i=1,4 do W.LF[i]=buildFeathers(W.LT[i],Config.WingsColor); W.RF[i]=buildFeathers(W.RT[i],Config.WingsColor) end end
        if Config.WingsShowGlow then W.LG=Instance.new("PointLight"); W.LG.Color=Config.WingsColor; W.LG.Brightness=4; W.LG.Range=12; W.LG.Shadows=false; W.LG.Parent=W.LS; W.RG=Instance.new("PointLight"); W.RG.Color=Config.WingsColor; W.RG.Brightness=4; W.RG.Range=12; W.RG.Shadows=false; W.RG.Parent=W.RS end
        table.insert(W.Conns,char.Destroying:Connect(clearWings))
    end
    TC(RunService.Heartbeat:Connect(function(dt) if isUnloaded or not Config.WingsEnabled then return end; if not W.LS or not W.LS.Parent then return end; W.Flap=W.Flap+dt*Config.WingsFlapSpeed; local fy=math.sin(W.Flap)*0.35; local fx=math.cos(W.Flap)*0.15; for i=1,4 do local o=TO[i]; local wv=math.sin(W.Flap+i*0.4)*0.4; W.LT[i].Position=Vector3.new(o.x*Config.WingsSpread,o.y*Config.WingsHeight+fy+wv,o.z+fx*0.5); W.RT[i].Position=Vector3.new(-o.x*Config.WingsSpread,o.y*Config.WingsHeight+fy+wv,o.z+fx*0.5) end end))

    TC(LocalPlayer.CharacterAdded:Connect(function(c)
        RagebotSafeRestore(); RBTrack={}; pcall(SinkDeactivate,false); pcall(function() FakePosState.SetEnabled(false) end); FakePosState.VirtualCF=nil; FakePosState.HandoffTicks=0
        if RefreshSinkToggle then RefreshSinkToggle() end; if RefreshFakeToggle then RefreshFakeToggle() end; task.wait(0.5); if isUnloaded then return end
        if Config.AuraEnabled then pcall(rebuildAura,c) end; if Config.WingsEnabled then pcall(rebuildWings,c) end; InfDoubleJump.OriginalItemInfo=setmetatable({},{__mode="k"}); if Config.InfDoubleJumpEnabled then InfJumpApplyAll() end
        if Config.FakePosEnabled then task.spawn(function() local hrp=c:WaitForChild("HumanoidRootPart",5); if hrp and not isUnloaded then task.wait(0.3); FakePosState.SetEnabled(true); if RefreshFakeToggle then RefreshFakeToggle() end end end) end
        -- SPAWN AUTOLOAD REMOVED. Lua scripts will only run on initial START.
    end))
    TC(LocalPlayer.CharacterRemoving:Connect(function() RagebotSafeRestore(); RBTrack={}; pcall(SinkDeactivate,false); pcall(function() FakePosState.SetEnabled(false) end) end))
    if LocalPlayer.Character then rebuildAura(LocalPlayer.Character); rebuildWings(LocalPlayer.Character) end

    local function reapplyRuntimeState()
        FlyState.Enabled=Config.FlyEnabled==true; FlyState.Speed=tonumber(Config.FlySpeed) or 50; if FlyState.Enabled then FlyStart() else FlyStop() end
        NoclipState.Enabled=Config.NoclipEnabled==true; if NoclipState.Enabled then NoclipStart() else NoclipStop() end
        if Config.AuraEnabled and LocalPlayer.Character then rebuildAura(LocalPlayer.Character) else clearAura() end; if Config.WingsEnabled and LocalPlayer.Character then rebuildWings(LocalPlayer.Character) else clearWings() end
        if Config.FakePosEnabled and not FakePosState.Enabled then FakePosState.SetEnabled(true) elseif not Config.FakePosEnabled and FakePosState.Enabled then FakePosState.SetEnabled(false) end
        if Config.WallbangEnabled then WallbangStart() else WallbangStop() end; applyWT(); buildOverlay()
        for _,e in pairs(Boxes) do e.Stroke.Color=Config.ESPColor; e.Stroke.Thickness=Config.ESPBoxThickness; e.Name.TextColor3=Config.ESPColor end; applyWingsAppearance()
    end

    -- UI TABS --
    do mkSection(BodyTab,"Flight"); mkToggle(BodyTab,"Fly",function() return FlyState.Enabled end,function(v) FlyState.Enabled=v; Config.FlyEnabled=v; if v then FlyStart() else FlyStop() end end); mkSlider(BodyTab,"Fly Speed",1,500,FlyState.Speed,5,function(v) FlyState.Speed=v; Config.FlySpeed=v end)
        mkSection(BodyTab,"Collision"); mkToggle(BodyTab,"Noclip",function() return NoclipState.Enabled end,function(v) NoclipState.Enabled=v; Config.NoclipEnabled=v; if v then NoclipStart() else NoclipStop() end end)
        mkSection(BodyTab,"Movement"); mkToggle(BodyTab,"WalkSpeed",function() return Config.WalkSpeedEnabled end,function(v) Config.WalkSpeedEnabled=v end); mkSlider(BodyTab,"WalkSpeed Multiplier",1,10,Config.WalkSpeedMultiplier,0.1,function(v) Config.WalkSpeedMultiplier=v end); mkToggle(BodyTab,"Sliding Speed",function() return Config.SlidingEnabled end,function(v) Config.SlidingEnabled=v end); mkSlider(BodyTab,"Sliding Multiplier",1,10,Config.SlidingMultiplier,0.1,function(v) Config.SlidingMultiplier=v end); mkToggle(BodyTab,"Jump Power",function() return Config.JumpPowerEnabled end,function(v) Config.JumpPowerEnabled=v end); mkSlider(BodyTab,"Jump Power Multiplier",0.1,10,Config.JumpPowerMultiplier,0.1,function(v) Config.JumpPowerMultiplier=v end); mkToggle(BodyTab,"Infinite Double Jump",function() return Config.InfDoubleJumpEnabled end,function(v) InfJumpSetEnabled(v) end); mkSlider(BodyTab,"Double Jump Value",2,999999,Config.InfDoubleJumpValue,100,function(v) Config.InfDoubleJumpValue=math.floor(v); if Config.InfDoubleJumpEnabled then InfJumpApplyAll() end end)
    end

    do mkSection(PhysTab,"Prediction"); mkToggle(PhysTab,"Enable Prediction",function() return Config.PredictionEnabled end,function(v) Config.PredictionEnabled=v end); mkSlider(PhysTab,"Danger Radius",5,100,Config.PredictionRadius,1,function(v) Config.PredictionRadius=v end); mkSlider(PhysTab,"Dodge Distance",5,150,Config.PredictionDodgeDist,1,function(v) Config.PredictionDodgeDist=v end); mkSlider(PhysTab,"Cooldown (s)",0.1,2,Config.PredictionCooldown,0.05,function(v) Config.PredictionCooldown=v end); mkSlider(PhysTab,"Speed Threshold",200,5000,Config.PredictionThreshold,50,function(v) Config.PredictionThreshold=v end); mkSlider(PhysTab,"Prediction Mult",0.5,10,Config.PredictionMult,0.5,function(v) Config.PredictionMult=v end)
        mkSection(PhysTab,"Evasion (Chaotic Dodge)"); mkToggle(PhysTab,"Enable Evasion",function() return Config.EvasionEnabled end,function(v) Config.EvasionEnabled=v end); mkSlider(PhysTab,"Evasion Intensity",1,10,Config.EvasionIntensity,0.5,function(v) Config.EvasionIntensity=v end)
        mkSection(PhysTab,"Teleport to Enemy"); mkToggle(PhysTab,"Enable TP",function() return Config.TPEnabled end,function(v) Config.TPEnabled=v end); mkCycle(PhysTab,"TP Mode",function() return Config.TPMode or "Follow" end,{"Follow","Front","Back","Above"},function(v) Config.TPMode=v end); mkSlider(PhysTab,"TP Distance",0,30,Config.TPDistance,0.5,function(v) Config.TPDistance=v end); mkSlider(PhysTab,"TP Height",0,20,Config.TPHeight,0.5,function(v) Config.TPHeight=v end)
        mkSection(PhysTab,"Void (Extreme)"); mkToggle(PhysTab,"Enable Void",function() return Config.VoidEnabled end,function(v) Config.VoidEnabled=v end); mkSlider(PhysTab,"Void X Bound",1000,1e9,Config.VoidX or 1e8,1000,function(v) Config.VoidX=v end); mkSlider(PhysTab,"Void Y Bound",1000,1e9,Config.VoidY or 1e8,1000,function(v) Config.VoidY=v end); mkSlider(PhysTab,"Void Z Bound",1000,1e9,Config.VoidZ or 1e8,1000,function(v) Config.VoidZ=v end)
        mkSection(PhysTab,"Anti-Aim"); mkToggle(PhysTab,"Enable Anti-Aim",function() return Config.AntiAimEnabled end,function(v) Config.AntiAimEnabled=v end); mkCycle(PhysTab,"Mode",function() return Config.AntiAimMode end,{"Spin","Jitter","Static"},function(v) Config.AntiAimMode=v end); mkSlider(PhysTab,"Speed",100,5000,Config.AntiAimSpeed,100,function(v) Config.AntiAimSpeed=v end); mkSlider(PhysTab,"Angle",10,180,Config.AntiAimAngle,5,function(v) Config.AntiAimAngle=v end); mkToggle(PhysTab,"Randomize Speed",function() return Config.AntiAimRandomSpeed end,function(v) Config.AntiAimRandomSpeed=v end)
        mkSection(PhysTab,"Riot"); mkToggle(PhysTab,"Enable Riot",function() return Config.RiotEnabled end,function(v) Config.RiotEnabled=v end); mkSlider(PhysTab,"Teleport Delay",0.01,0.5,Config.RiotSpeed,0.01,function(v) Config.RiotSpeed=v end); mkSlider(PhysTab,"Jump Range",10,200,Config.RiotRange,5,function(v) Config.RiotRange=v end); mkSlider(PhysTab,"Evade Range",0,100,Config.RiotEvadeRange,5,function(v) Config.RiotEvadeRange=v end); mkSlider(PhysTab,"Spin Speed",0,720,Config.RiotSpinSpeed,10,function(v) Config.RiotSpinSpeed=v end)
        mkSection(PhysTab,"Riot Abuse"); mkToggle(PhysTab,"Enable Riot Abuse",function() return Config.RiotAbuseEnabled end,function(v) Config.RiotAbuseEnabled=v end); mkCycle(PhysTab,"Abuse Mode",function() return Config.RiotAbuseMode end,{"Stick","Bounce"},function(v) Config.RiotAbuseMode=v end); mkSlider(PhysTab,"Height Offset",-50,50,Config.RiotAbuseHeight,1,function(v) Config.RiotAbuseHeight=v end); mkSlider(PhysTab,"Forward Offset",-50,50,Config.RiotAbuseForward,1,function(v) Config.RiotAbuseForward=v end); mkSlider(PhysTab,"Right Offset",-50,50,Config.RiotAbuseRight,1,function(v) Config.RiotAbuseRight=v end); mkSlider(PhysTab,"Down Offset",0,50,Config.RiotAbuseDown,1,function(v) Config.RiotAbuseDown=v end)
        mkSection(PhysTab,"Orbit"); mkToggle(PhysTab,"Enable Orbit",function() return Config.OrbitEnabled end,function(v) Config.OrbitEnabled=v end); mkCycle(PhysTab,"Orbit Mode",function() return Config.OrbitMode end,{"Circle","Figure 8","Spiral In","Spiral Out","Bounce"},function(v) Config.OrbitMode=v end); mkSlider(PhysTab,"Speed (deg/s)",5,720,Config.OrbitSpeed,5,function(v) Config.OrbitSpeed=v end); mkSlider(PhysTab,"Radius",1,200,Config.OrbitDist,1,function(v) Config.OrbitDist=v end); mkSlider(PhysTab,"Height",-200,200,Config.OrbitHeight,1,function(v) Config.OrbitHeight=v end); mkSlider(PhysTab,"Smoothing",1,100,Config.OrbitLerp,0.05,function(v) Config.OrbitLerp=v end); mkToggle(PhysTab,"Face Target",function() return Config.OrbitFaceTarget end,function(v) Config.OrbitFaceTarget=v end); mkToggle(PhysTab,"Enable Prediction",function() return Config.OrbitPredict end,function(v) Config.OrbitPredict=v end); mkSlider(PhysTab,"Prediction Strength",0,100,Config.OrbitPredStrength,1,function(v) Config.OrbitPredStrength=v/100 end); mkSlider(PhysTab,"Max Auto-Lock Dist",10,500,Config.OrbitAutoLockDist,10,function(v) Config.OrbitAutoLockDist=v end)
        mkSection(PhysTab,"Wallbang"); mkToggle(PhysTab,"Wallbang Aim",function() return Config.WallbangEnabled end,function(v) Config.WallbangEnabled=v; if v then WallbangStart() else WallbangStop() end end)
        mkSection(PhysTab,"Sink Into Ground"); local _,sinkRefresh=mkToggle(PhysTab,"Sink Into Ground",function() return Config.SinkEnabled end,function(v) Config.SinkEnabled=v; if v and FakePosState.Enabled then FakePosState.SetEnabled(false); Config.FakePosEnabled=false; if RefreshFakeToggle then RefreshFakeToggle() end end end); RefreshSinkToggle=sinkRefresh; mkSlider(PhysTab,"Sink Depth (studs)",0.5,30,Config.SinkDepth or 5.8,0.2,function(v) Config.SinkDepth=v end)
        mkSection(PhysTab,"Fake Position (Packet)"); local _,fakeRefresh=mkToggle(PhysTab,"Enable Fake Position",function() return FakePosState.Enabled end,function(v) Config.FakePosEnabled=v; FakePosState.SetEnabled(v); if v and Config.SinkEnabled then Config.SinkEnabled=false; if SinkState.Active then SinkDeactivate(false) end; if RefreshSinkToggle then RefreshSinkToggle() end end end); RefreshFakeToggle=fakeRefresh
        mkCycle(PhysTab,"FP Pattern",function() return Config.FakePosPattern or "Walk" end,{"Walk","Scatter","Linear","Circle","Random","Spiral"},function(v) Config.FakePosPattern=v; FakePosState.Pattern=v end); mkCycle(PhysTab,"FP Distribution",function() return Config.FakePosDistribution or "Random" end,{"Random","Uniform","Weighted","Radial","Clustered"},function(v) Config.FakePosDistribution=v; FakePosState.Distribution=v end); mkCycle(PhysTab,"FP Axis Lock",function() return Config.FakePosAxisLock or "None" end,{"None","X","Y","Z","XZ"},function(v) Config.FakePosAxisLock=v; FakePosState.AxisLock=v end); mkSlider(PhysTab,"FP Depth",0.5,30,FakePosState.Depth,0.2,function(v) FakePosState.Depth=v end); mkSlider(PhysTab,"FP Radius",1,5000,Config.FakePosRadius,10,function(v) Config.FakePosRadius=v; FakePosState.Radius=v end); mkSlider(PhysTab,"FP Height",-2000,2000,Config.FakePosHeight,10,function(v) Config.FakePosHeight=v; FakePosState.Height=v end); mkSlider(PhysTab,"FP Speed (pkt/s)",1,500,Config.FakePosSpeed,5,function(v) Config.FakePosSpeed=v; FakePosState.Speed=v end); mkSlider(PhysTab,"FP Count",1,20,Config.FakePosCount,1,function(v) Config.FakePosCount=math.floor(v); FakePosState.Count=math.floor(v) end); mkToggle(PhysTab,"FP Reverse",function() return Config.FakePosReverse end,function(v) Config.FakePosReverse=v; FakePosState.Reverse=v end); mkToggle(PhysTab,"FP Random Radius",function() return Config.FakePosRandomRadius end,function(v) Config.FakePosRandomRadius=v; FakePosState.RandomRadius=v end); mkToggle(PhysTab,"FP Hide Client Pos",function() return Config.FakePosHideClientPos end,function(v) Config.FakePosHideClientPos=v; FakePosState.HideClientPos=v end); mkToggle(PhysTab,"FP Dynamic Walk",function() return Config.FakePosWalkMode end,function(v) Config.FakePosWalkMode=v; FakePosState.WalkMode=v end); mkToggle(PhysTab,"FP Surface Camera",function() return Config.FakePosSurfaceCamera end,function(v) Config.FakePosSurfaceCamera=v; FakePosState.SurfaceCamera=v end); mkToggle(PhysTab,"FP Auto Noclip",function() return Config.FakePosAutoNoclip end,function(v) Config.FakePosAutoNoclip=v; FakePosState.AutoNoclip=v end); mkToggle(PhysTab,"FP Hide Meshes",function() return Config.FakePosHideMeshes end,function(v) Config.FakePosHideMeshes=v; FakePosState.SetHideMeshes(v) end); mkToggle(PhysTab,"FP Ghost Visualizer",function() return Config.FakePosVisualizer end,function(v) Config.FakePosVisualizer=v; FakePosState.VisualizerEnabled=v; FakePosUpdateGhost() end); mkToggle(PhysTab,"FP Panic Jitter",function() return Config.FakePosPanic end,function(v) Config.FakePosPanic=v; FakePosState.Panic=v end); mkToggle(PhysTab,"FP Zero Velocity",function() return Config.FakePosZeroVelocity end,function(v) Config.FakePosZeroVelocity=v; FakePosState.ZeroVelocity=v end)
        mkSection(PhysTab,"Ragebot (TP Under)"); mkToggle(PhysTab,"Ragebot",function() return Config.MainRagebotEnabled end,function(v) Config.MainRagebotEnabled=v end); mkCycle(PhysTab,"Attack Mode",function() return Config.RagebotMode or "Backstab" end,{"Backstab","Front","Random","Alternate"},function(v) Config.RagebotMode=v end); mkToggle(PhysTab,"Only TP On Attack",function() return Config.RagebotOnlyOnAttack end,function(v) Config.RagebotOnlyOnAttack=v end); mkToggle(PhysTab,"Wait God End",function() return Config.RagebotWaitGodEnd end,function(v) Config.RagebotWaitGodEnd=v end); mkToggle(PhysTab,"Pause On Reload",function() return Config.RagebotPauseOnReload~=false end,function(v) Config.RagebotPauseOnReload=v end); mkToggle(PhysTab,"Avoid Melee",function() return Config.RagebotAvoidMelee~=false end,function(v) Config.RagebotAvoidMelee=v end); mkToggle(PhysTab,"Anti-Bait",function() return Config.RagebotAntiBait~=false end,function(v) Config.RagebotAntiBait=v end); mkToggle(PhysTab,"Void Hunter",function() return Config.RagebotVoidHunter end,function(v) Config.RagebotVoidHunter=v end); mkToggle(PhysTab,"Aim Lead",function() return Config.RagebotAimLead end,function(v) Config.RagebotAimLead=v end); mkSlider(PhysTab,"Ragebot Distance",0,10,Config.RagebotDistance or 0,0.5,function(v) Config.RagebotDistance=v end); mkSlider(PhysTab,"Ragebot Height",1,12,Config.RagebotHeight or 1.5,0.5,function(v) Config.RagebotHeight=v end); mkSlider(PhysTab,"Jitter Strength",0,12,Config.RagebotJitterStrength or 4.5,0.5,function(v) Config.RagebotJitterStrength=v end); mkSlider(PhysTab,"Safe Margin",50,500,Config.RagebotSafeMargin or 100,10,function(v) Config.RagebotSafeMargin=v end); mkSlider(PhysTab,"Track Boost",1,8,Config.RagebotTrackBoost or 3,1,function(v) Config.RagebotTrackBoost=v end); mkSlider(PhysTab,"Snap Reps",1,12,Config.RagebotSnapReps or 6,1,function(v) Config.RagebotSnapReps=math.floor(v) end)
        mkSection(PhysTab,"Auto Pickup"); mkToggle(PhysTab,"Auto Heal",function() return Config.AutoHealEnabled end,function(v) Config.AutoHealEnabled=v end); mkSlider(PhysTab,"Heal Min Missing HP",0,200,Config.AutoHealMinMissing,5,function(v) Config.AutoHealMinMissing=math.floor(v) end); mkToggle(PhysTab,"Auto Ammo Pickup",function() return Config.AutoAmmoPickupEnabled end,function(v) Config.AutoAmmoPickupEnabled=v end); mkSlider(PhysTab,"Ammo Below This",0,100,Config.AutoAmmoMinAmmo,1,function(v) Config.AutoAmmoMinAmmo=math.floor(v) end)
        mkSection(PhysTab,"Auto Respawn"); mkToggle(PhysTab,"Auto Respawn",function() return Config.AutoRespawnEnabled end,function(v) Config.AutoRespawnEnabled=v end); mkSlider(PhysTab,"Respawn Interval (s)",0.2,5,Config.AutoRespawnInterval,0.1,function(v) Config.AutoRespawnInterval=v end)
    end

    do mkToggle(AuraTab,"Enable Aura",function() return Config.AuraEnabled end,function(v) Config.AuraEnabled=v; if v then rebuildAura(LocalPlayer.Character) else clearAura() end end); mkSlider(AuraTab,"Intensity",5,150,Config.AuraIntensity,5,function(v) Config.AuraIntensity=v; if auraMain then auraMain.Rate=v end; if auraRing then auraRing.Rate=math.floor(v*0.5) end; if auraGround then auraGround.Rate=math.floor(v*0.7) end end); mkSlider(AuraTab,"Size",2,25,Config.AuraSize,0.5,function(v) Config.AuraSize=v; if auraMain then auraMain.Size=buildAuraSize(v) end end); mkSlider(AuraTab,"Transparency",0.1,0.95,Config.AuraTransparency,0.05,function(v) Config.AuraTransparency=v; if auraMain then auraMain.Transparency=buildAuraTrans() end end); mkSlider(AuraTab,"Glow",0,15,Config.AuraGlowIntensity,0.5,function(v) Config.AuraGlowIntensity=v; if auraLight then auraLight.Brightness=v end end) end

    do mkToggle(ESPTab,"Enable ESP",function() return Config.ESPEnabled end,function(v) Config.ESPEnabled=v end); mkToggle(ESPTab,"Show Name",function() return Config.ESPShowName end,function(v) Config.ESPShowName=v end); mkToggle(ESPTab,"Show Health",function() return Config.ESPShowHealth end,function(v) Config.ESPShowHealth=v end); mkToggle(ESPTab,"Show Bar",function() return Config.ESPShowHealthBar end,function(v) Config.ESPShowHealthBar=v end); mkToggle(ESPTab,"Show Distance",function() return Config.ESPShowDistance end,function(v) Config.ESPShowDistance=v end); mkToggle(ESPTab,"Team Check",function() return Config.ESPTeamCheck end,function(v) Config.ESPTeamCheck=v end); mkSlider(ESPTab,"Box Thickness",0.5,5,Config.ESPBoxThickness,0.5,function(v) Config.ESPBoxThickness=v; for _,e in pairs(Boxes) do e.Stroke.Thickness=v end end); mkColorRow(ESPTab,{{c=Color3.fromRGB(255,255,255)},{c=Color3.fromRGB(255,80,80)},{c=Color3.fromRGB(100,255,100)},{c=Color3.fromRGB(100,220,255)},{c=Color3.fromRGB(180,120,255)},{c=Color3.fromRGB(255,120,200)}},function(c) Config.ESPColor=c; Config.ESPColorHex=colorToHex(c) end,function(c) for _,e in pairs(Boxes) do e.Stroke.Color=c; e.Name.TextColor3=c end end) end

    do mkToggle(WingsTab,"Enable Wings",function() return Config.WingsEnabled end,function(v) Config.WingsEnabled=v; if v then rebuildWings(LocalPlayer.Character) else clearWings() end end); mkSlider(WingsTab,"Beam Width",0.5,15,Config.WingsSize,0.5,function(v) Config.WingsSize=v; applyWingsAppearance() end); mkSlider(WingsTab,"Wingspan",1,10,Config.WingsSpread,0.25,function(v) Config.WingsSpread=v; if LocalPlayer.Character and Config.WingsEnabled then rebuildWings(LocalPlayer.Character) end end); mkSlider(WingsTab,"Height",1,10,Config.WingsHeight,0.25,function(v) Config.WingsHeight=v; if LocalPlayer.Character and Config.WingsEnabled then rebuildWings(LocalPlayer.Character) end end); mkSlider(WingsTab,"Flap Speed",0,8,Config.WingsFlapSpeed,0.25,function(v) Config.WingsFlapSpeed=v end); mkToggle(WingsTab,"Feathers",function() return Config.WingsShowFeathers end,function(v) Config.WingsShowFeathers=v; if LocalPlayer.Character and Config.WingsEnabled then rebuildWings(LocalPlayer.Character) end end); mkToggle(WingsTab,"Glow",function() return Config.WingsShowGlow end,function(v) Config.WingsShowGlow=v; if LocalPlayer.Character and Config.WingsEnabled then rebuildWings(LocalPlayer.Character) end end); mkColorRow(WingsTab,{{c=Color3.fromRGB(140,100,255)},{c=Color3.fromRGB(100,180,255)},{c=Color3.fromRGB(255,120,220)},{c=Color3.fromRGB(80,255,200)},{c=Color3.fromRGB(255,200,100)},{c=Color3.fromRGB(255,255,255)}},function(c) Config.WingsColor=c; Config.WingsColorHex=colorToHex(c) end,function() applyWingsAppearance() end) end

    do mkToggle(WorldTab,"Enable World Tint",function() return Config.WorldTintEnabled end,function(v) Config.WorldTintEnabled=v; applyWT() end); mkColorRow(WorldTab,{{c=Color3.fromRGB(156,124,255)},{c=Color3.fromRGB(90,140,255)},{c=Color3.fromRGB(255,100,200)},{c=Color3.fromRGB(120,255,180)},{c=Color3.fromRGB(255,200,120)},{c=Color3.fromRGB(255,255,255)},{c=Color3.fromRGB(200,60,60)},{c=Color3.fromRGB(60,60,60)}},function(c) Config.WorldTintColor=c; Config.WorldTintColorHex=colorToHex(c) end,function() applyWT() end); mkSlider(WorldTab,"Brightness",-1,1,Config.WorldBrightness,0.05,function(v) Config.WorldBrightness=v; if CC then CC.Brightness=v end end); mkSlider(WorldTab,"Contrast",-1,1,Config.WorldContrast,0.05,function(v) Config.WorldContrast=v; if CC then CC.Contrast=v end end); mkSlider(WorldTab,"Saturation",-1,1,Config.WorldSaturation,0.05,function(v) Config.WorldSaturation=v; if CC then CC.Saturation=v end end) end

    do mkSection(LuaTab,"Script Name"); local luaNameBox=Instance.new("TextBox"); luaNameBox.Size=UDim2.new(1,0,0,28); luaNameBox.BackgroundColor3=Color3.fromRGB(22,22,30); luaNameBox.BorderColor3=Color3.fromRGB(90,70,180); luaNameBox.BorderSizePixel=1; luaNameBox.Font=Enum.Font.Code; luaNameBox.TextSize=11; luaNameBox.TextColor3=Color3.fromRGB(230,220,255); luaNameBox.PlaceholderText="Script name"; luaNameBox.PlaceholderColor3=Color3.fromRGB(150,140,180); luaNameBox.Text=""; luaNameBox.ClearTextOnFocus=false; luaNameBox.TextXAlignment=Enum.TextXAlignment.Left; luaNameBox.ZIndex=9999; luaNameBox.Active=true; luaNameBox.Parent=LuaTab
        mkSection(LuaTab,"Script Code"); local luaCodeBox=Instance.new("TextBox"); luaCodeBox.Size=UDim2.new(1,0,0,90); luaCodeBox.BackgroundColor3=Color3.fromRGB(22,22,30); luaCodeBox.BorderColor3=Color3.fromRGB(90,70,180); luaCodeBox.BorderSizePixel=1; luaCodeBox.Font=Enum.Font.Code; luaCodeBox.TextSize=10; luaCodeBox.TextColor3=Color3.fromRGB(230,220,255); luaCodeBox.PlaceholderText="Paste script here..."; luaCodeBox.PlaceholderColor3=Color3.fromRGB(150,140,180); luaCodeBox.Text=""; luaCodeBox.ClearTextOnFocus=false; luaCodeBox.MultiLine=true; luaCodeBox.TextWrapped=true; luaCodeBox.TextXAlignment=Enum.TextXAlignment.Left; luaCodeBox.TextYAlignment=Enum.TextYAlignment.Top; luaCodeBox.ZIndex=9999; luaCodeBox.Active=true; luaCodeBox.Parent=LuaTab
        local luaScrollList=Instance.new("ScrollingFrame"); luaScrollList.Size=UDim2.new(1,0,0,160); luaScrollList.BackgroundColor3=Color3.fromRGB(25,25,35); luaScrollList.BorderColor3=Color3.fromRGB(90,70,180); luaScrollList.BorderSizePixel=1; luaScrollList.ScrollBarThickness=6; luaScrollList.CanvasSize=UDim2.new(0,0,0,0); luaScrollList.ZIndex=9999; luaScrollList.Active=true; luaScrollList.ClipsDescendants=true; luaScrollList.Parent=LuaTab
        local luaListLayout=Instance.new("UIListLayout"); luaListLayout.SortOrder=Enum.SortOrder.Name; luaListLayout.Padding=UDim.new(0,4); luaListLayout.Parent=luaScrollList
        local function rebuildLuaScriptList()
            for _,child in ipairs(luaScrollList:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
            local names={}; for name in pairs(LuaScriptStorage.Scripts) do table.insert(names,name) end; table.sort(names)
            for _,name in ipairs(names) do local data=LuaScriptStorage.Scripts[name]; local code=type(data)=="table" and data.Code or nil
                local entryFrame=Instance.new("Frame"); entryFrame.Name=name; entryFrame.Size=UDim2.new(1,-8,0,28); entryFrame.BackgroundTransparency=1; entryFrame.ZIndex=9999; entryFrame.Parent=luaScrollList
                local runAction=Instance.new("TextButton"); runAction.Size=UDim2.new(0.40,-2,1,0); runAction.BackgroundColor3=Color3.fromRGB(45,45,45); runAction.TextColor3=Color3.fromRGB(255,255,255); runAction.Text=name; runAction.Font=Enum.Font.Gotham; runAction.TextSize=11; runAction.ZIndex=9999; runAction.Parent=entryFrame; local rC=Instance.new("UICorner"); rC.CornerRadius=UDim.new(0,4); rC.Parent=runAction
                local editAction=Instance.new("TextButton"); editAction.Size=UDim2.new(0.20,0,1,0); editAction.Position=UDim2.new(0.40,0,0,0); editAction.BackgroundColor3=Color3.fromRGB(45,55,75); editAction.TextColor3=Color3.fromRGB(180,210,255); editAction.Text="✏"; editAction.Font=Enum.Font.GothamBold; editAction.TextSize=13; editAction.ZIndex=9999; editAction.Parent=entryFrame; local eCorner=Instance.new("UICorner"); eCorner.CornerRadius=UDim.new(0,4); eCorner.Parent=editAction
                local isAuto = Config.LuaAutoLoadScripts and Config.LuaAutoLoadScripts[name] == true
                local autoAction=Instance.new("TextButton"); autoAction.Size=UDim2.new(0.20,0,1,0); autoAction.Position=UDim2.new(0.60,0,0,0); autoAction.BackgroundColor3=isAuto and Color3.fromRGB(40,80,40) or Color3.fromRGB(45,45,45); autoAction.TextColor3=isAuto and Color3.fromRGB(120,255,120) or Color3.fromRGB(200,200,210); autoAction.Text=isAuto and "A●" or "A"; autoAction.Font=Enum.Font.GothamBold; autoAction.TextSize=11; autoAction.ZIndex=9999; autoAction.Parent=entryFrame; local AutoCorner=Instance.new("UICorner"); AutoCorner.CornerRadius=UDim.new(0,4); AutoCorner.Parent=autoAction
                local delAction=Instance.new("TextButton"); delAction.Size=UDim2.new(0.20,0,1,0); delAction.Position=UDim2.new(0.80,0,0,0); delAction.BackgroundColor3=Color3.fromRGB(70,40,40); delAction.TextColor3=Color3.fromRGB(255,130,130); delAction.Text="X"; delAction.Font=Enum.Font.GothamBold; delAction.TextSize=11; delAction.ZIndex=9999; delAction.Parent=entryFrame; local dC=Instance.new("UICorner"); dC.CornerRadius=UDim.new(0,4); dC.Parent=delAction
                TC(runAction.MouseButton1Click:Connect(function() if type(code)~="string" or #code==0 then notify("Lua","Script is empty.",3); return end; local ls = resolveLs(); if not ls then notify("Lua","No loadstring available.",3); return end; local fn,err=ls(code); if not fn then notify("Lua","Compile error: "..tostring(err),3); return end; task.spawn(function() local ok,runErr=pcall(fn); if not ok then warn("[Lua] Runtime: "..tostring(runErr)); pcall(function() notify("Lua","Runtime error: "..tostring(runErr),3) end) end end); notify("Lua","Running: "..name,3) end))
                TC(editAction.MouseButton1Click:Connect(function() if type(data)=="table" and type(data.Code)=="string" then luaNameBox.Text = name; luaCodeBox.Text = data.Code; notify("Lua","Loaded into editor: "..name, 3) end end))
                TC(autoAction.MouseButton1Click:Connect(function() Config.LuaAutoLoadScripts = Config.LuaAutoLoadScripts or {}; if Config.LuaAutoLoadScripts[name] then Config.LuaAutoLoadScripts[name] = nil; notify("Lua","Autoload OFF: "..name, 2) else Config.LuaAutoLoadScripts[name] = true; notify("Lua","Autoload ON: "..name, 2) end; SaveConfig(); rebuildLuaScriptList() end))
                TC(delAction.MouseButton1Click:Connect(function() LuaScriptStorage.Scripts[name]=nil; if Config.LuaAutoLoadScripts and Config.LuaAutoLoadScripts[name] then Config.LuaAutoLoadScripts[name]=nil end; LuaScriptStorageSave(); SaveConfig(); rebuildLuaScriptList(); notify("Lua","Deleted: "..name,3) end))
            end
            luaScrollList.CanvasSize=UDim2.new(0,0,0,math.max(luaListLayout.AbsoluteContentSize.Y+20,60))
        end
        local rowBtn = Instance.new("Frame"); rowBtn.Size=UDim2.new(1,0,0,30); rowBtn.BackgroundTransparency=1; rowBtn.ZIndex=9999; rowBtn.Parent=LuaTab; local rl = Instance.new("UIListLayout"); rl.FillDirection=Enum.FillDirection.Horizontal; rl.Padding=UDim.new(0,6); rl.Parent=rowBtn
        local newLuaBtn = Instance.new("TextButton"); newLuaBtn.Size=UDim2.new(0.5,-3,1,0); newLuaBtn.BackgroundColor3=Color3.fromRGB(35,65,40); newLuaBtn.BorderColor3=Color3.fromRGB(90,160,90); newLuaBtn.BorderSizePixel=1; newLuaBtn.Font=Enum.Font.Code; newLuaBtn.Text="💾 SAVE"; newLuaBtn.TextColor3=Color3.fromRGB(150,255,150); newLuaBtn.TextSize=12; newLuaBtn.ZIndex=9999; newLuaBtn.Active=true; newLuaBtn.Modal=false; newLuaBtn.Parent=rowBtn; local nlC = Instance.new("UICorner"); nlC.CornerRadius=UDim.new(0,4); nlC.Parent=newLuaBtn
        local overLuaBtn = Instance.new("TextButton"); overLuaBtn.Size=UDim2.new(0.5,-3,1,0); overLuaBtn.BackgroundColor3=Color3.fromRGB(70,40,100); overLuaBtn.BorderColor3=Color3.fromRGB(140,90,180); overLuaBtn.BorderSizePixel=1; overLuaBtn.Font=Enum.Font.Code; overLuaBtn.Text="✏️ OVERWRITE"; overLuaBtn.TextColor3=Color3.fromRGB(220,160,255); overLuaBtn.TextSize=12; overLuaBtn.ZIndex=9999; overLuaBtn.Active=true; overLuaBtn.Modal=false; overLuaBtn.Parent=rowBtn; local olC = Instance.new("UICorner"); olC.CornerRadius=UDim.new(0,4); olC.Parent=overLuaBtn
        TC(newLuaBtn.MouseButton1Click:Connect(function() local name = luaNameBox.Text; local code = luaCodeBox.Text; if name=="" then notify("Lua","Enter a script name.",3); return end; if code=="" then notify("Lua","Enter script code.",3); return end; if LuaScriptStorage.Scripts[name] ~= nil then notify("Lua","Name exists — use OVERWRITE.",3); return end; LuaScriptStorage.Scripts[name]={Code=code}; LuaScriptStorageSave(); notify("Lua","Saved: "..name,3); luaNameBox.Text=""; luaCodeBox.Text=""; rebuildLuaScriptList() end))
        TC(overLuaBtn.MouseButton1Click:Connect(function() local name = luaNameBox.Text; local code = luaCodeBox.Text; if name=="" then notify("Lua","Enter a script name.",3); return end; if code=="" then notify("Lua","Enter script code.",3); return end; if LuaScriptStorage.Scripts[name] == nil then notify("Lua","Nothing to overwrite — use SAVE.",3); return end; LuaScriptStorage.Scripts[name]={Code=code}; LuaScriptStorageSave(); notify("Lua","Overwritten: "..name,3); luaNameBox.Text=""; luaCodeBox.Text=""; rebuildLuaScriptList() end))
        rebuildLuaScriptList()
    end

    do mkSection(SettingsTab,"Profile Manager"); local profNameBox=Instance.new("TextBox"); profNameBox.Size=UDim2.new(1,0,0,28); profNameBox.BackgroundColor3=Color3.fromRGB(22,22,30); profNameBox.BorderColor3=Color3.fromRGB(90,70,180); profNameBox.BorderSizePixel=1; profNameBox.Font=Enum.Font.Code; profNameBox.TextSize=11; profNameBox.TextColor3=Color3.fromRGB(230,220,255); profNameBox.PlaceholderText="Profile name"; profNameBox.PlaceholderColor3=Color3.fromRGB(150,140,180); profNameBox.Text=acidGetActive() or ""; profNameBox.ClearTextOnFocus=false; profNameBox.TextXAlignment=Enum.TextXAlignment.Left; profNameBox.ZIndex=9999; profNameBox.Active=true; profNameBox.Parent=SettingsTab
        local profRow=Instance.new("Frame"); profRow.Size=UDim2.new(1,0,0,30); profRow.BackgroundTransparency=1; profRow.ZIndex=9999; profRow.Parent=SettingsTab; local prl=Instance.new("UIListLayout"); prl.FillDirection=Enum.FillDirection.Horizontal; prl.Padding=UDim.new(0,6); prl.Parent=profRow
        local profSave=mkButton(profRow,"💾 SAVE",Color3.fromRGB(35,65,40),Color3.fromRGB(90,160,90),Color3.fromRGB(150,255,150)); profSave.Size=UDim2.new(0.5,-3,1,0)
        local profOver=mkButton(profRow,"✏️ OVERWRITE",Color3.fromRGB(70,40,100),Color3.fromRGB(140,90,180),Color3.fromRGB(220,160,255)); profOver.Size=UDim2.new(0.5,-3,1,0)
        TC(profSave.MouseButton1Click:Connect(function() local n=profNameBox.Text; if n=="" then notify("Profile","Enter a name.",3); return end; if acidProfileExists(n) then notify("Profile","Exists — use OVERWRITE.",3); return end; local ok,msg=acidSaveProfile(n); notify("Profile",msg,3); RebuildConfigInventory() end))
        TC(profOver.MouseButton1Click:Connect(function() local n=profNameBox.Text; if n=="" then notify("Profile","Enter a name.",3); return end; if not acidProfileExists(n) then notify("Profile","Not found — use SAVE.",3); return end; local ok,msg=acidSaveProfile(n); notify("Profile",msg,3); RebuildConfigInventory() end))
        local profScroll=Instance.new("ScrollingFrame"); profScroll.Size=UDim2.new(1,0,0,150); profScroll.BackgroundColor3=Color3.fromRGB(25,25,35); profScroll.BorderColor3=Color3.fromRGB(90,70,180); profScroll.BorderSizePixel=1; profScroll.ScrollBarThickness=6; profScroll.CanvasSize=UDim2.new(0,0,0,0); profScroll.ZIndex=9999; profScroll.Active=true; profScroll.ClipsDescendants=true; profScroll.Parent=SettingsTab; local profList=Instance.new("UIListLayout"); profList.SortOrder=Enum.SortOrder.Name; profList.Padding=UDim.new(0,4); profList.Parent=profScroll
        RebuildConfigInventory=function()
            for _,c in ipairs(profScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
            local names=acidListProfiles(); local active=acidGetActive()
            for _,name in ipairs(names) do
                local ef=Instance.new("Frame"); ef.Name=name; ef.Size=UDim2.new(1,-8,0,28); ef.BackgroundTransparency=1; ef.ZIndex=9999; ef.Parent=profScroll
                local loadBtn=Instance.new("TextButton"); loadBtn.Size=UDim2.new(0.4,-2,1,0); loadBtn.BackgroundColor3=(active==name) and Color3.fromRGB(40,80,40) or Color3.fromRGB(45,45,45); loadBtn.TextColor3=(active==name) and Color3.fromRGB(120,255,120) or Color3.fromRGB(255,255,255); loadBtn.Text=name; loadBtn.Font=Enum.Font.Gotham; loadBtn.TextSize=11; loadBtn.ZIndex=9999; loadBtn.Parent=ef; local lc=Instance.new("UICorner"); lc.CornerRadius=UDim.new(0,4); lc.Parent=loadBtn
                local editBtn=Instance.new("TextButton"); editBtn.Size=UDim2.new(0.2,0,1,0); editBtn.Position=UDim2.new(0.4,0,0,0); editBtn.BackgroundColor3=Color3.fromRGB(45,55,75); editBtn.TextColor3=Color3.fromRGB(180,210,255); editBtn.Text="✏"; editBtn.Font=Enum.Font.GothamBold; editBtn.TextSize=13; editBtn.ZIndex=9999; editBtn.Parent=ef; local ec=Instance.new("UICorner"); ec.CornerRadius=UDim.new(0,4); ec.Parent=editBtn
                local isAuto=(active==name)
                local autoBtn=Instance.new("TextButton"); autoBtn.Size=UDim2.new(0.2,0,1,0); autoBtn.Position=UDim2.new(0.6,0,0,0); autoBtn.BackgroundColor3=isAuto and Color3.fromRGB(40,80,40) or Color3.fromRGB(45,45,45); autoBtn.TextColor3=isAuto and Color3.fromRGB(120,255,120) or Color3.fromRGB(200,200,210); autoBtn.Text=isAuto and "A●" or "A"; autoBtn.Font=Enum.Font.GothamBold; autoBtn.TextSize=11; autoBtn.ZIndex=9999; autoBtn.Parent=ef; local ac=Instance.new("UICorner"); ac.CornerRadius=UDim.new(0,4); ac.Parent=autoBtn
                local delBtn=Instance.new("TextButton"); delBtn.Size=UDim2.new(0.2,0,1,0); delBtn.Position=UDim2.new(0.8,0,0,0); delBtn.BackgroundColor3=Color3.fromRGB(70,40,40); delBtn.TextColor3=Color3.fromRGB(255,130,130); delBtn.Text="X"; delBtn.Font=Enum.Font.GothamBold; delBtn.TextSize=11; delBtn.ZIndex=9999; delBtn.Parent=ef; local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(0,4); dc.Parent=delBtn
                TC(editBtn.MouseButton1Click:Connect(function() profNameBox.Text=name; notify("Profile","Editing: "..name,2) end))
                TC(autoBtn.MouseButton1Click:Connect(function() if acidGetActive()==name then acidSetActive(nil); notify("Profile","Autoload cleared.",2) else acidSetActive(name); notify("Profile","Autoload: "..name,2) end; RebuildConfigInventory() end))
                local loadPending,loadTok=false,0
                TC(loadBtn.MouseButton1Click:Connect(function() if loadPending then loadPending=false; loadTok=loadTok+1; loadBtn.Text=name; loadBtn.BackgroundColor3=(acidGetActive()==name) and Color3.fromRGB(40,80,40) or Color3.fromRGB(45,45,45); local ok,msg=acidLoadProfile(name); if ok then refreshAllUI(); pcall(reapplyRuntimeState); notify("Profile",msg,3) else notify("Profile",msg,3) end else loadPending=true; loadTok=loadTok+1; local my=loadTok; loadBtn.Text="CONFIRM?"; loadBtn.BackgroundColor3=PURPLE_CONFIRM; task.delay(0.5,function() if loadPending and loadTok==my then loadPending=false; loadBtn.Text=name; loadBtn.BackgroundColor3=(acidGetActive()==name) and Color3.fromRGB(40,80,40) or Color3.fromRGB(45,45,45) end end) end end))
                local delPending,delTok=false,0
                TC(delBtn.MouseButton1Click:Connect(function() if delPending then delPending=false; delTok=delTok+1; delBtn.Text="X"; delBtn.BackgroundColor3=Color3.fromRGB(70,40,40); acidDeleteProfile(name); notify("Profile","Deleted: "..name,3); RebuildConfigInventory() else delPending=true; delTok=delTok+1; local my=delTok; delBtn.Text="?"; delBtn.BackgroundColor3=PURPLE_CONFIRM; task.delay(0.5,function() if delPending and delTok==my then delPending=false; delBtn.Text="X"; delBtn.BackgroundColor3=Color3.fromRGB(70,40,40) end end) end end))
            end
            profScroll.CanvasSize=UDim2.new(0,0,0,math.max(profList.AbsoluteContentSize.Y+20,60))
        end
        RebuildConfigInventory()
        mkSection(SettingsTab,"Overlay"); mkToggle(SettingsTab,"Enable Overlay",function() return Config.OverlayEnabled end,function(v) Config.OverlayEnabled=v; buildOverlay() end); mkSlider(SettingsTab,"Overlay Transparency",0,1,Config.OverlayTransparency,0.05,function(v) Config.OverlayTransparency=v; if Overlay then Overlay.BackgroundTransparency=v end end)
        local UnloadBtn=Instance.new("TextButton"); UnloadBtn.Size=UDim2.new(1,0,0,34); UnloadBtn.BackgroundColor3=Color3.fromRGB(60,25,25); UnloadBtn.BorderColor3=Color3.fromRGB(120,50,50); UnloadBtn.BorderSizePixel=1; UnloadBtn.Font=Enum.Font.Code; UnloadBtn.Text="UNLOAD ALL"; UnloadBtn.TextColor3=Color3.fromRGB(255,120,120); UnloadBtn.TextSize=13; UnloadBtn.ZIndex=9999; UnloadBtn.Active=true; UnloadBtn.Modal=false; UnloadBtn.Parent=SettingsTab
    end

    local AcidPickup={RetryActive=false,RetryDelay=0.05,RetryNonce=0,Observers=setmetatable({},{__mode="k"}),DropsByKind={Health={},Ammo={}}}
    local function AcidIsTargetGame() return game.GameId==6035872082 end
    local function AcidGetTouchPart() local char=LocalPlayer.Character; if not char then return nil end; local hum=char:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then return nil end; return char:FindFirstChild("HitboxBody") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart") end
    local function AcidKindOf(drop) if not drop or not drop:IsA("BasePart") or drop.Name~="_drop" then return nil end; if drop:FindFirstChild("Health") then return "Health" end; if drop:FindFirstChild("AmmoBalanced") or drop:FindFirstChild("Ammo") then return "Ammo" end; return nil end
    local function AcidClearKinds(drop) if not drop then return end AcidPickup.DropsByKind.Health[drop]=nil; AcidPickup.DropsByKind.Ammo[drop]=nil end
    local function AcidDisconnectObserver(drop) local obs=AcidPickup.Observers[drop]; if not obs then return end; pcall(function() if obs.added then obs.added:Disconnect() end end); pcall(function() if obs.removed then obs.removed:Disconnect() end end); AcidPickup.Observers[drop]=nil end
    local function AcidRefreshDrop(drop) AcidClearKinds(drop); if not drop or drop.Parent~=Workspace then return end; if not drop:IsA("BasePart") or drop.Name~="_drop" then return end; local kind=AcidKindOf(drop); local hasTouch=drop:FindFirstChildOfClass("TouchTransmitter")~=nil; if kind and hasTouch then AcidPickup.DropsByKind[kind][drop]=true end end
    local function AcidObserveDrop(drop) if not drop or not drop:IsA("BasePart") or drop.Name~="_drop" then return end; if AcidPickup.Observers[drop] then AcidRefreshDrop(drop); return end; local obs={}; AcidPickup.Observers[drop]=obs; obs.added=drop.ChildAdded:Connect(function() AcidRefreshDrop(drop) end); obs.removed=drop.ChildRemoved:Connect(function() AcidRefreshDrop(drop) end); AcidRefreshDrop(drop) end
    local function AcidUnobserveDrop(drop) AcidClearKinds(drop); AcidDisconnectObserver(drop) end
    local function AcidNearestDrop(kind,touchPart) if not touchPart or not touchPart.Parent then return nil end; local candidates=AcidPickup.DropsByKind[kind]; if not candidates then return nil end; local best,bestDist=nil,nil; for drop in pairs(candidates) do if drop.Parent~=Workspace then AcidClearKinds(drop); AcidDisconnectObserver(drop) else local stillKind=AcidKindOf(drop); local hasTouch=drop:FindFirstChildOfClass("TouchTransmitter")~=nil; if stillKind==kind and drop.CanTouch==true and hasTouch then local d=(drop.Position-touchPart.Position).Magnitude; if not bestDist or d<bestDist then best,bestDist=drop,d end end end end return best end
    local function AcidTouchDrop(drop,touchPart) if not drop or not drop.Parent or not touchPart or not touchPart.Parent then return false end; if type(firetouchinterest)~="function" then return false end; firetouchinterest(touchPart,drop,0); task.defer(function() if drop.Parent and touchPart.Parent then pcall(firetouchinterest,touchPart,drop,1) end end); return true end
    local function AcidCancelRetry() AcidPickup.RetryActive=false; AcidPickup.RetryNonce=AcidPickup.RetryNonce+1 end
    local function AcidSyncRetry(shouldRetry) if not shouldRetry then AcidCancelRetry(); return end; if AcidPickup.RetryActive then return end; AcidPickup.RetryActive=true; AcidPickup.RetryNonce=AcidPickup.RetryNonce+1; local nonce=AcidPickup.RetryNonce; task.spawn(function() while AcidPickup.RetryActive and AcidPickup.RetryNonce==nonce do task.wait(AcidPickup.RetryDelay); if AcidPickup.RetryNonce~=nonce or not AcidPickup.RetryActive then return end; if not AcidUpdatePickup() then AcidPickup.RetryActive=false; return end end end) end
    function AcidUpdatePickup() if not AcidIsTargetGame() then AcidCancelRetry(); return false end; if type(firetouchinterest)~="function" then AcidCancelRetry(); return false end; local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then AcidCancelRetry(); return false end; local touchPart=AcidGetTouchPart(); if not touchPart then AcidCancelRetry(); return false end; local touched,shouldRetry=false,false; local missing=math.max(hum.MaxHealth-hum.Health,0); if Config.AutoHealEnabled and missing>=(Config.AutoHealMinMissing or 25) then shouldRetry=true; local drop=AcidNearestDrop("Health",touchPart); if drop then touched=AcidTouchDrop(drop,touchPart) end end; if not touched and Config.AutoAmmoPickupEnabled then local ammo=nil; pcall(function() local ps=LocalPlayer:FindFirstChild("PlayerScripts"); local ctrl=ps and ps:FindFirstChild("Controllers"); local fc=ctrl and ctrl:FindFirstChild("FighterController"); if not fc then return end; local mod=require(fc); local fighter=mod and mod.LocalFighter; local item=fighter and fighter.EquippedItem; if item and type(item.Get)=="function" then ammo=item:Get("Ammo") end end); if type(ammo)=="number" and ammo<=(Config.AutoAmmoMinAmmo or 0) then shouldRetry=true; local drop=AcidNearestDrop("Ammo",touchPart); if drop then touched=AcidTouchDrop(drop,touchPart) end end end; AcidSyncRetry(shouldRetry); return shouldRetry end
    TC(Workspace.ChildAdded:Connect(function(child) if child:IsA("BasePart") and child.Name=="_drop" then AcidObserveDrop(child) end end))
    TC(Workspace.ChildRemoved:Connect(function(child) if child:IsA("BasePart") and child.Name=="_drop" then AcidUnobserveDrop(child) end end))
    for _,child in ipairs(Workspace:GetChildren()) do if child:IsA("BasePart") and child.Name=="_drop" then AcidObserveDrop(child) end end
    local AcidRespawn={LastFiredAt=0,BurstDelay=0.1}
    local function AcidResolveRespawnRemote() local remotes=ReplicatedStorage:FindFirstChild("Remotes"); local duels=remotes and remotes:FindFirstChild("Duels"); local r=duels and duels:FindFirstChild("RespawnNow"); if r and r:IsA("RemoteEvent") then return r end; return nil end
    local function AcidTryRespawn() if not Config.AutoRespawnEnabled then return end; if not AcidIsTargetGame() then return end; local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); if hum and hum.Health>0 then return end; local now=os.clock(); if now-AcidRespawn.LastFiredAt<(Config.AutoRespawnInterval or 1) then return end; local remote=AcidResolveRespawnRemote(); if not remote then return end; AcidRespawn.LastFiredAt=now; local count=math.max(1,math.floor(Config.AutoRespawnBurst or 5)); task.spawn(function() for i=1,count do pcall(function() remote:FireServer() end); if i<count then task.wait(AcidRespawn.BurstDelay) end end end) end

    local _hbFrame=0
    TC(RunService.Heartbeat:Connect(function(dt)
        if isUnloaded then return end; _hbFrame=_hbFrame+1; if _hbFrame%3==0 then pcall(UpdateMovement,dt*3) end
        pcall(UpdatePrediction, dt); pcall(UpdateEvasion, dt); pcall(UpdateTP, dt); pcall(UpdateVoid, dt); pcall(UpdateAntiAim, dt); pcall(UpdateRiot, dt); pcall(UpdateRiotAbuse, dt); pcall(UpdateOrbit, dt)
        if FakePosState.Enabled then pcall(UpdateFakePos,dt) else pcall(UpdateSink,dt) end
        if _hbFrame%2==0 then pcall(AcidUpdatePickup); pcall(AcidTryRespawn) end
    end))
    task.spawn(function() while not isUnloaded do task.wait(2); if Config.InfDoubleJumpEnabled then local fighter=nil; pcall(function() local ps=LocalPlayer:FindFirstChild("PlayerScripts"); local ctrl=ps and ps:FindFirstChild("Controllers"); local fc=ctrl and ctrl:FindFirstChild("FighterController"); if fc then local mod=require(fc); fighter=mod and mod.LocalFighter end end); if fighter and type(rawget(fighter,"Items"))=="table" then InfJumpApplyAll() end end end end)

    local function Unload()
        if isUnloaded then return end; isUnloaded=true
        pcall(function() RunService:UnbindFromRenderStep("AcidWallbang") end)
        local snapshot=Connections; for i=#snapshot,1,-1 do local c=snapshot[i]; if c and type(c.Disconnect)=="function" then pcall(function() c:Disconnect() end) end; snapshot[i]=nil end
        pcall(function() if table.clear then table.clear(Connections) end end)
        pcall(clearAura); pcall(clearWings); pcall(destroyWT); pcall(SinkDeactivate,true); pcall(function() FakePosState.SetEnabled(false) end); pcall(FlyStop); pcall(NoclipStop); FlyState.Enabled=false; NoclipState.Enabled=false
        pcall(function() if Overlay and Overlay.Parent then Overlay:Destroy() end; Overlay=nil; OverlayGradient=nil end)
        for p in pairs(Boxes or {}) do pcall(removeESP,p) end; pcall(function() if table.clear then table.clear(Boxes) end end)
        pcall(function() MainRagebotState.Alive=false; MainRagebotState.Enabled=false; MainRagebotRestore() end); pcall(function() if MainRagebotState.RestoreBound then RunService:UnbindFromRenderStep("MainRagebotRestore") end end)
        if MovementState.WalkSpeedHookLoaded and MovementState.WalkSpeedHookGetter and MovementState.WalkSpeedHookUpvalueIndex and MovementState.WalkSpeedHookOldUpvalue then pcall(debug.setupvalue,MovementState.WalkSpeedHookGetter,MovementState.WalkSpeedHookUpvalueIndex,MovementState.WalkSpeedHookOldUpvalue) end
        MovementState.WalkSpeedHookLoaded=false; MovementState.JumpPowerHookDestroyed=true
        if Config.InfDoubleJumpEnabled then Config.InfDoubleJumpEnabled=false; for item,original in pairs(InfDoubleJump.OriginalItemInfo or {}) do local info=original and original.Info or nil; if type(info)=="table" then if original.HasMaxDoubleJumps then pcall(function() rawset(info,"MaxDoubleJumps",original.MaxDoubleJumps) end) else pcall(function() rawset(info,"MaxDoubleJumps",nil) end) end end end; InfDoubleJump.OriginalItemInfo=setmetatable({},{__mode="k"}) end
        pcall(function() if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end end); pcall(function() if collectgarbage then collectgarbage("collect") end end)
    end
    for _,child in ipairs(SettingsTab:GetChildren()) do if child:IsA("TextButton") and child.Text=="UNLOAD ALL" then TC(child.MouseButton1Click:Connect(function() pcall(Unload) end)) end end

    task.defer(function()
        if isUnloaded then return end; local autoName = acidGetActive()
        if type(autoName)=="string" and autoName~="" and acidProfileExists(autoName) then local ok = acidLoadProfile(autoName); if ok then refreshAllUI(); pcall(reapplyRuntimeState); notify("Profile","Auto-loaded: "..autoName,3) end end
        if isUnloaded then return end; task.wait(0.4); if isUnloaded then return end; runAllLuaAutoloads("start")
    end)
end

local startPressed=false
local function onStart()
    if startPressed then return end
    startPressed=true
    if StartBtn then StartBtn:Destroy() end
    BuildAll()
end
StartBtn.MouseButton1Down:Connect(onStart)
StartBtn.TouchTap:Connect(onStart)
StartBtn.MouseButton1Click:Connect(onStart)
-- ===== ACID PACK END =====
]==]

local function getLoadstring()
    if type(loadstring)=="function" then return loadstring end
    if type(load)=="function" then return load end
    local env=getgenv and getgenv() or _G
    if env and type(env.loadstring)=="function" then return env.loadstring end
    if env and type(env.load)=="function" then return env.load end
    return nil
end

local ls=getLoadstring()
if not ls then warn("[Loader] No loadstring/load found in this executor.")
else
    local fn,compileErr=ls(RAW_LUA_CODE)
    if not fn then warn("[Loader] Compile error: "..tostring(compileErr))
    else
        local ok,runErr=pcall(fn)
        if not ok then warn("[Loader] Runtime error: "..tostring(runErr))
        else print("[Loader] Executed.") end
    end
end