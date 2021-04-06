assert(not game.IsLoaded(game) and game.Loaded:Wait() or game)
if game.PlaceId == 3522803956 then
    getgenv().ui_options = {
        main_color = Color3.fromRGB(0, 21, 255),
        min_size = Vector2.new(400, 200),
        toggle_key = Enum.KeyCode.F8,
        can_resize = true
    }
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Enviie/Singularity-UI-Lib/main/Singularity%20UI%20Lib.lua", true))()
    local ESPLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Enviie/ESP-Library/main/Kiriot%20ESP%20Lib.lua", true))()
    local Window = library:AddWindow("Cypher X De Pride No Gay", {
        main_color = Color3.fromRGB(11, 158, 212),
        min_size = Vector2.new(850, 689),
        toggle_key = Enum.KeyCode.Home,
        can_resize = true
    })
    local Local = Window:AddTab("Local Player")
    local Visl = Window:AddTab("Visuals")
    local Setts = Window:AddTab("Settings")
    do
        local Key = {
            ["Jumping"] = true,
            ["Running"] = true
        }
        local RNames = {
            ["Ragdoll"] = true,
            ["Damage"] = true,
            ["Sickness"] = true
        }
        local mt = getrawmetatable(game)
        local OldCall = mt.__namecall
        local OldIndex = mt.__index
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local Method = string.lower(getnamecallmethod())
            local Args = {...}
            if Method == "fireserver" and self.IsA(self, "RemoteEvent") and self.Name == "Game" and Args[1] == "WalkSpeed" or Args[1] == "Vagour" and Key[Args[2]] then
                return warn("Attempt to Kick!:", getcallingscript().Name), nil
            end
            if Method == "fireserver" and self.IsA(self, "RemoteEvent") and RNames[self.Name] then
                return nil
            end
            return OldCall(self, ...)
        end)
        mt.__index = newcclosure(function(self, key)
            if not checkcaller() and tostring(self) == "Humanoid" and key == "WalkSpeed" then
                return 16
            end
            if not checkcaller() and tostring(self) == "Humanoid" and key == "JumpPower" then
                return 50
            end
            return OldIndex(self, key)
        end)
        setreadonly(mt, true)
        ESPLib.TeamColor = false
        Local:AddLabel("[Local Cheats]")
        local function FindPlayer1(PName)
            for k, v in next, game:GetService("Players"):GetPlayers() do
                if PName:lower() == v.Name:sub(1, PName:len()):lower() then
                    return v
                end
            end
            return nil
        end
        Local:AddTextBox("Teleport Player", function(text)
            warn(text)
            if FindPlayer1(text) == nil then
                return 
            end
            local Target = FindPlayer1(text)
            local Player = game:GetService("Players").LocalPlayer
            Player.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
        end, {
            ["clear"] = false
        })
        local yuh = Local:AddSlider("Walkspeed", function(x)
            print(x)
            local ME = game:GetService("Players").LocalPlayer
            ME.Character.Humanoid.WalkSpeed = x
        end, {
            ["min"] = 0,
            ["max"] = 500,
            ["readonly"] = false
        })
        yuh:Set(3)
        Local:AddButton("Reset Speed", function()
            yuh:Set(3)
        end)
        local noclip = true
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        game:GetService('RunService').Stepped:connect(function()
            player = game.Players.LocalPlayer
            character = player.Character
            if noclip then
                for _, v in pairs(character:GetDescendants()) do
                    pcall(function()
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end)
                end
            end
            game:GetService("RunService").Stepped:wait()
        end)
        local gay = Local:AddSwitch("Noclip", function(bool)
            warn(bool)
            noclip = not noclip
        end)
        gay:Set(false)
        Local:AddButton("Get Fly", function()
            local ME = game:GetService("Players").LocalPlayer
            local RS = game:GetService("RunService").RenderStepped
            local Mouse = ME.GetMouse(ME)
            local Flying = false
            shared.Fly = {
                Speed = 1
            }
            function shared.Fly.Set(FlyBoolean)
                if FlyBoolean then
                    local C1, C2, SPEED = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0,
                        Q = 0,
                        E = 0
                    }, {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0,
                        Q = 0,
                        E = 0
                    }, 0
                    local HRP = ME.Character:FindFirstChild("HumanoidRootPart")
                    local BG = Instance.new("BodyGyro")
                    BG.P = 9e4
                    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                    BG.CFrame = HRP.CFrame
                    BG.Parent = HRP
                    local BV = Instance.new("BodyVelocity")
                    BV.Velocity = Vector3.new(0, 0, 0)
                    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    BV.Parent = HRP
                    local FlyCon = RS.Connect(RS, function()
                        local cam = workspace.CurrentCamera
                        ME.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = true
                        if C1.L + C1.R ~= 0 or C1.F + C1.B ~= 0 or C1.Q + C1.E ~= 0 then
                            SPEED = 50
                        elseif not (C1.L + C1.R ~= 0 or C1.F + C1.B ~= 0 or C1.Q + C1.E ~= 0) and SPEED ~= 0 then
                            SPEED = 0
                        end
                        if (C1.L + C1.R) ~= 0 or (C1.F + C1.B) ~= 0 or (C1.Q + C1.E) ~= 0 then
                            BV.Velocity = ((cam.CFrame.LookVector * (C1.F + C1.B)) + ((cam.CFrame * CFrame.new(C1.L + C1.R, (C1.F + C1.B + C1.Q + C1.E) * .2, 0).p) - cam.CFrame.p)) * SPEED
                            C2 = {
                                F = C1.F,
                                B = C1.B,
                                L = C1.L,
                                R = C1.R
                            }
                        elseif (C1.L + C1.R) == 0 and (C1.F + C1.B) == 0 and (C1.Q + C1.E) == 0 and SPEED ~= 0 then
                            BV.Velocity = ((cam.CFrame.LookVector * (C2.F + C2.B)) + ((cam.CFrame * CFrame.new(C2.L + C2.R, (C2.F + C2.B + C1.Q + C1.E) * .2, 0).p) - cam.CFrame.p)) * SPEED
                        else
                            BV.Velocity = Vector3.new(0, 0, 0)
                        end
                        BG.CFrame = cam.CFrame
                    end)
                    local FlyCon1 = Mouse.KeyDown:Connect(function(Input)
                        Input = Input.lower(Input)
                        if Input == "w" then
                            C1.F = shared.Fly.Speed
                        elseif Input == "s" then
                            C1.B = -shared.Fly.Speed
                        elseif Input == "a" then
                            C1.L = -shared.Fly.Speed
                        elseif Input == "d" then
                            C1.R = shared.Fly.Speed
                        elseif Input == "e" then
                            C1.Q = shared.Fly.Speed * 2
                        elseif Input == "q" then
                            C1.E = -shared.Fly.Speed * 2
                        end
                    end)
                    local FlyCon2 = Mouse.KeyUp:Connect(function(Input)
                        Input = Input.lower(Input)
                        if Input == "w" then
                            C1.F = 0
                        elseif Input == "s" then
                            C1.B = 0
                        elseif Input == "a" then
                            C1.L = 0
                        elseif Input == "d" then
                            C1.R = 0
                        elseif Input == "e" then
                            C1.Q = 0
                        elseif Input == "q" then
                            C1.E = 0
                        end
                    end)
                    coroutine.wrap(function()
                        wait()
                        while Flying do
                            RS.Wait(RS)
                        end
                        FlyCon.Disconnect(FlyCon)
                        FlyCon1.Disconnect(FlyCon1)
                        FlyCon2.Disconnect(FlyCon2)
                        BG.Destroy(BG)
                        BV.Destroy(BV)
                        C1, C2, SPEED = nil, nil, nil
                        ME.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
                    end)()
                    Flying = true
                elseif not FlyBoolean then
                    Flying = false
                    ME.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
                end
            end
        end)
        local coon = true
        local anallick = Local:AddSwitch("Fly", function(bool)
            warn("Fly Toggled:", bool)
            if coon then
                coon = false
                shared.Fly.Set(false)
            else
                coon = true
                shared.Fly.Set(true)
            end
        end)
        anallick:Set(false)
        local flykey = true
        Local:AddKeybind("Fly Keybind", function(key)
            print(key)
            if flykey then
                flykey = false
                shared.Fly.Set(true)
            else
                flykey = true
                shared.Fly.Set(false)
            end
        end, {
            ["standard"] = Enum.KeyCode.X
        })
        Local:AddTextBox("FlySpeed", function(text)
            shared.Fly.Speed = tonumber(text)
        end, {
            ["clear"] = false
        })
        local ungran = Local:AddSwitch("Anti Ragdoll/Hit", function(bool)
            warn(bool)
            if bool then
                local Me = game:GetService("Players").LocalPlayer
                function RemoveRagDoll()
                    Me.Character:WaitForChild("Ragdoll"):Destroy()
                end
                RemoveRagDoll()
                cunt = Me.CharacterAdded:Connect(function()
                    RemoveRagDoll()
                end)
            else
                cunt:Disconnect()
            end
        end)
        ungran:Set(false)
        Visl:AddLabel("[ESP Settings]")
        local pussypic = Visl:AddSwitch("ESP", function(bool)
            warn("ESP Toggled:", bool)
            ESPLib:Toggle(bool)
        end)
        pussypic:Set(false)
        Visl:AddLabel("[ESP Color]")
        local feetsies = Visl:AddColorPicker(function(color)
            print(color)
            ESPLib.Color = color
        end)
        feetsies:Set(Color3.fromRGB(9, 183, 222))
        local NormColor = ESPLib.Color
        local gangbang = Visl:AddSwitch("Rainbow ESP", function(bool)
            warn("Rainbow ESP Toggled:", bool)
            if bool then
                _G.PogMoment = true
                local t = 0
                while _G.PogMoment and wait(.1) do
                    t = (t + .01) % 1
                    ESPLib.Color = Color3.fromHSV(t, 1, 1)
                end
            else
                _G.PogMoment = false
                ESPLib.Color = NormColor
            end
        end)
        gangbang:Set(false)
        local poggerman = Visl:AddSwitch("Tracers", function(bool)
            warn("Tracers Toggled:", bool)
            ESPLib.Tracers = bool
        end)
        poggerman:Set(true)
        local analbitch = Visl:AddSwitch("Boxes", function(bool)
            warn("Boxes Toggled:", bool)
            ESPLib.Boxes = bool
        end)
        analbitch:Set(true)
        Setts:AddLabel("[Change Key to your liking to Close UI]")
        Setts:AddKeybind("UI Toggle", function(key)
            print(key)
            getgenv().ui_options.toggle_key = key
        end, {
            ["standard"] = Enum.KeyCode.F8
        })
        Setts:AddLabel("[Credits]")
        Setts:AddLabel("--------------------------")
        Setts:AddLabel("[Cypher X Owner]")
        Setts:AddLabel("Enviie")
        Setts:AddLabel("Real Enviie#5273")
        Setts:AddLabel("[Cypher X Co-Owner]")
        Setts:AddLabel("Hunter")
        Setts:AddLabel("485856#0001")
    end
    Local:Show()
    library:FormatWindows()
    local synqueueontelesupport = (type(syn.queue_on_teleport) == "function" and syn.queue_on_teleport) or false
    local Me = game:GetService("Players").LocalPlayer
    if synqueueontelesupport then
        Me.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport('loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Enviie/Cypher-X-Lazarus-F-cker/main/Cypher%20X%20Lazarus%20F%23ucker%20Main.lua"))("Enviie Soo Hot!")')
            end
        end)
    else
        warn("Exploit doesn't support syn.queue_on_teleport.")
    end
else
    local Me = game:GetService("Players").LocalPlayer
    Me:Kick("Wrong Game Dumbass Retard!")
    wait(0.5)
    while true do
    end
end
