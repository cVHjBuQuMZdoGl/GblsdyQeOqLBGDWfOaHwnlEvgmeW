--[[ 
▓█████▄ ▓█████  ██▓     █    ██   ██████  ██▓ ▒█████   ███▄    █ 
▒██▀ ██▌▓█   ▀ ▓██▒     ██  ▓██▒▒██    ▒ ▓██▒▒██▒  ██▒ ██ ▀█   █ 
░██   █▌▒███   ▒██░    ▓██  ▒██░░ ▓██▄   ▒██▒▒██░  ██▒▓██  ▀█ ██▒
░▓█▄   ▌▒▓█  ▄ ▒██░    ▓▓█  ░██░  ▒   ██▒░██░▒██   ██░▓██▒  ▐▌██▒
░▒████▓ ░▒████▒░██████▒▒▒█████▓ ▒██████▒▒░██░░ ████▓▒░▒██░   ▓██░
 ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░▒▓▒ ▒ ▒ ▒ ▒▓▒ ▒ ░░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ 
 ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░░░▒░ ░ ░ ░ ░▒  ░ ░ ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░
 ░ ░  ░    ░     ░ ░    ░░░ ░ ░ ░  ░  ░   ▒ ░░ ░ ░ ▒     ░   ░ ░ 
   ░       ░  ░    ░  ░   ░           ░   ░      ░ ░           ░ 
    --]] 
local Env = getfenv();
        local Players = game:GetService("Players");
        local UserInputService = game:GetService("UserInputService");
        local TweenService = game:GetService("TweenService");
        local CollectionService = game:GetService("CollectionService");
        local CoreGui = game:GetService("CoreGui");
        local Workspace = game:GetService("Workspace");
        local ReplicatedStorage = game:GetService("ReplicatedStorage");
        local RunService = game:GetService("RunService");
        local LocalPlayer2 = Players.LocalPlayer;
        local function r34()
            local Character = LocalPlayer2.Character;
            return Character; 
        end;
        local function r35()
            local Character = LocalPlayer2.Character;
            return Character; 
        end;
        local r36 = {
            ["AutoFarmActive"] = false,
            ["NotifyActive"] = false,
            ["EspActive"] = false,
            ["InfinitySanityActive"] = false,
            ["AutoReviveActive"] = false,
            ["AutoClosePortal"] = false,
            ["SanityTarget"] = -100
        };
        local r37 = false;
        local r38 = {
            Vector3.new(-104.145, 3.458, -0.389),
            Vector3.new(-108.191, 3.458, -0.402),
            Vector3.new(-106.265, 3.458, -0.404),
            Vector3.new(-99.68, 3.458, -0.051)
        };
        local vector3 = Vector3.new(-104.553, 3.408, -7.166);
        local vector32 = Vector3.new(10, 6, 10);
        local vector33 = Vector3.new(-152.223, 3.458, -58.657);
        local vector34 = Vector3.new(-113.218, 3.458, -3.16);
        local r43 = {
            Vector3.new(-168.046, 5.806, -42.408),
            Vector3.new(-167.943, 5.806, -81.816),
            Vector3.new(-121.186, 5.806, -97.31),
            Vector3.new(-121.875, 5.806, -59.08),
            Vector3.new(-154.1, 5.806, -114.847),
            Vector3.new(-106.644, 5.854, 52.04)
        };
        local vector35 = Vector3.new(10, 12, 10);
        local actionMap2 = {
            ["Ervas medicinas"] = Vector3.new(-136.274, 3.458, -60.147),
            ["Kit medico"] = Vector3.new(-153.631, 3.519, -70.239),
            ["Xarope"] = Vector3.new(-136.154, 3.458, -79.113),
            ["Bandagens"] = Vector3.new(-152.551, 3.458, -81.845)
        };
        local overlapParams = OverlapParams.new();
        overlapParams.FilterType = Enum.RaycastFilterType.Exclude;
        local r48 = {
            ["Ervas medicinas"] = {
                "herb",
                "herbal",
                "erva",
                "maple",
                "plant",
                "medicine",
                "ervas"
            },
            ["Kit medico"] = {
                "medical",
                "medkit",
                "kit",
                "med kit",
                "medical kit"
            },
            ["Xarope"] = {
                "syrup",
                "cough",
                "xarope",
                "cough syrup"
            },
            ["Bandagens"] = {
                "bandage",
                "wrap",
                "band",
                "curativo",
                "atadura",
                "bandages"
            }
        };
        local function hasTag(arg1_2)
            return CollectionService:HasTag(arg1_2, "Skinwalker"); 
        end;
        do
            game = Workspace;
            p = game[2];
            game = game[1];
            for _, game in ipairs(game:GetDescendants()) do
                if game:IsA("ProximityPrompt") then
                    Config.HoldDuration = 0;
                end; 
            end;
            Workspace.DescendantAdded:Connect(function(arg1_3, ...)
                if arg1_3:IsA("ProximityPrompt") then
                    p.HoldDuration = 0;
                end;
                return; 
            end); 
        end;
        local function r50(arg1_4)
            if not arg1_4 or not arg1_4:IsA("ProximityPrompt") then
                return;
            end;
            if not p.Enabled then
                return;
            end;
            p.HoldDuration = 0;
            arg1_4:InputHoldBegin();
            task.wait(.05);
            arg1_4:InputHoldEnd(); 
        end;
        local function r51(arg1_5, arg2_5, arg3_5)
            game = u[j];
            j = arg2_5 or 12;
            game = arg3_5 or 2.5;
            while tick() < tick() + game do
                game = Workspace;
                for l, game in game[1], ipairs(game:GetDescendants()) do
                    game = l;
                    instance = game:IsA("ProximityPrompt");
                    if instance and v12.Enabled then
                        game = v12.Parent;
                        if game then
                            game = game:IsA("BasePart");
                        end;
                        if game then
                            if (v13.Position - arg1_5).Magnitude <= list2 then
                                r50(game);
                            end;
                        end;
                    end; 
                end;
                task.wait(.1); 
            end; 
        end;
        local function r52(arg1_6, arg2_6, arg3_6)
            game = u[j];
            j = arg2_6 or 10;
            game = arg3_6 or 10;
            game = arg3_6 or 10;
            for w = 1, game do
                game = game;
                game = math.huge;
                for tv, q in ipairs(q:GetDescendants()) do
                    game = tv;
                    G = q:IsA("ProximityPrompt");
                    if G and q.Enabled then
                        A = "Parent";
                        Y = q[actionMap[A]];
                        if Y then
                            m = (Y.Position - arg1_6).Magnitude;
                            A = m < math.huge;
                            if Y then
                                game = m;
                                game = q;
                            end;
                        end;
                    end; 
                end;
                if nil then
                    r50(nil);
                    return true;
                else
                    print("[Vexus] Tentativa " .. game .. " - Prompt não encontrado, aguardando...");
                    task.wait(0.5);
                end; 
            end;
            warn("[Vexus] Nenhum prompt encontrado após " .. game .. " tentativas.");
            return false; 
        end;
        local r53 = false;
        local function r54(arg1_7, arg2_7, arg3_7)
            if r53 then
                warn("[Vexus GetObject] Sistema ocupado, aguardando...");
                task.wait(0.5);
                if r53 then
                    warn("[Vexus GetObject] Ainda ocupado, abortando.");
                    return false;
                end;
            end;
            T = type(arg1_7) == "string";
            game = arg3_7 or 20;
            r35();
            game = T;
            game = LocalPlayer2.Character;
            if game then
                game = LocalPlayer2.Character;
                game = game:FindFirstChild("Head");
            end;
            l = not r34();
            game = game;
            game = l; 
        end;
        local function r55(arg1_8)
            game = Workspace[3];
            z = z[1];
            for game, game in z, ipairs(z:GetDescendants()) do
                game:IsA("MeshPart");
                game = game;
                if (game:IsA("BasePart") or ) and v8.Name == arg1_8 then
                    return game;
                else
                    
                end; 
            end;
            return nil; 
        end;
        local function r56(arg1_9, arg2_9)
            T = type(arg1_9) == "string";
            game = r34();
            game = T;
            game = game;
            if game then
                game = v6.Position;
            end;
            if game then
                game = game;
                game = game;
                game = {};
                game = l.GetDescendants;
                game = {
                    game(Workspace)
                };
                game = Workspace[3];
                game = Workspace[2];
                for game, game in ipairs(S(game)) do
                    game = v12.Name;
                    game = game:lower();
                    for tv, Y in ipairs(arg1_9) do
                        if game:find(Y:lower(), 1, true) then
                            game = true;
                        else
                            
                        end;
                        if false then
                            if game:IsA("Model") then
                                game = game;
                            else
                                game:IsA("MeshPart");
                                game = game;
                                if nil then
                                    tv = (nil.Position - game).Magnitude;
                                    print(string.format("[Vexus FindObj] 📦 Candidato: '%s' | Caminho: %s | Distância: %.1f studs", v12.Name, game:GetFullName(), tv));
                                    table.insert({}, {
                                        ["part"] = nil,
                                        ["model"] = game,
                                        ["dist"] = tv
                                    });
                                end;
                            end;
                        end; 
                    end; 
                end;
                if #game == 0 then
                    warn("[Vexus FindObj] ❌ Nenhum objeto encontrado para keywords: [" .. table.concat(arg1_9, ", ") .. "]");
                    return nil, nil;
                end;
                game = game[1];
                if arg2_9 then
                    game = game[3];
                    for game, game in ipairs(game) do
                        game = game;
                        if v13.dist < game[game].dist then
                            game = game;
                        end; 
                    end;
                    print(string.format("[Vexus FindObj] ✅ Mais próximo escolhido: '%s' | Distância: %.1f studs", v8.model.Name, v8.dist));
                else
                    print("[Vexus FindObj] ✅ Primeiro encontrado: '" .. v8.model.Name .. "'");
                end;
                return v8.part, v8.model;
            else
                game = Vector3.new(0, 0, 0);
            end; 
        end;
        local function r57(...)
            local function game()
                return Workspace.Rooms.Medical.Room1.Minigame.TV.Screen; 
            end;
            game = game[1];
            for z, game in game, ipairs({
                function(...)
                    return Workspace.Rooms.Medical.Room1.Minigame.TV.Screen.UI; 
                end,
                function(...)
                    return Workspace.Rooms.Medical.Room1.Minigame.TV.SurfaceGui; 
                end,
                function(...)
                    return Workspace.Rooms.Medical.Room1.Minigame.TV.Screen.SurfaceGui; 
                end,
                function(...)
                    return Workspace.Rooms.Medical.Room1.Minigame.TV.BillboardGui; 
                end,
                game
            }) do
                game = z;
                game = {
                    pcall(game)
                };
                game = pcall(game);
                if game then
                    game = game[2];
                end;
                if game then
                    print("[Vexus TV DEBUG] ✅ TV UI encontrada pelo caminho #" .. z .. ": " .. l:GetFullName());
                else
                    
                end;
                if not nil then
                    print("[Vexus TV DEBUG] ⚠️  Caminhos fixos falharam. Buscando TV dinamicamente...");
                    game = Workspace;
                    game = game[3];
                    for game, game in game[1], ipairs(game:GetDescendants()) do
                        game = actionMap;
                        game = game;
                        if game:IsA("ScreenGui") or game then
                            instance2 = 7193259265301;
                            game = game;
                            game = game[actionMap[r16("O\\\x94Qr", instance2)]];
                            pcall = actionMap;
                            if game then
                                instance2 = v11.Name:lower();
                                tv = "tv";
                                pcall = instance2:find(tv, 1, true) or tv;
                                pcall = pcall;
                            end;
                            pcall = r16;
                            if pcall then
                                print("[Vexus TV DEBUG] ✅ TV UI encontrada dinamicamente: " .. game:GetFullName());
                            else
                                
                            end;
                            if not nil then
                                warn("[Vexus TV DEBUG] ❌ TV UI não encontrada em nenhum caminho.");
                                return nil;
                            end;
                            r58 = 0;
                            local function r59(arg1_10, arg2_10)
                                string.rep("  ", arg2_10);
                                game = p.GetChildren;
                                game = {
                                    game(arg1_10)
                                };
                                game = game[3];
                                game = game[1];
                                for game, game in game, ipairs(S(game)) do
                                    game = actionMap;
                                    game = game;
                                    instance2 = "Frame";
                                    if game:IsA(game[instance2]) or (game or instance2) then
                                        print(string.format("[Vexus TV DEBUG] %s📁 Container | Nome: '%s' | Visible: %s | LayoutOrder: %s | AbsPos: %s | Caminho: %s", string.rep("  ", arg2_10), v11.Name, tostring(v11.Visible), tostring(v11.LayoutOrder), tostring(v11.AbsolutePosition), game:GetFullName()));
                                    end;
                                    game:IsA("TextButton");
                                    if game:IsA("TextLabel") or  then
                                        pcall = r58 + 1;
                                        pcall = pcall;
                                        print(string.format("[Vexus TV DEBUG] %s🏷️  Label #%d | Nome: '%s' | Texto: '%s' | Visible: %s | LayoutOrder: %s | AbsPos: %s | TextColor3: RGB(%d,%d,%d) | Caminho: %s", string.rep("  ", arg2_10), pcall, v11.Name, v11.Text or "", tostring(v11.Visible), tostring(v11.LayoutOrder), tostring(v11.AbsolutePosition), math.floor(v11.TextColor3.R * 255), math.floor(v11.TextColor3.G * 255), math.floor(v11.TextColor3.B * 255), game:GetFullName()));
                                    end;
                                    r59(game, arg2_10 + 1); 
                                end; 
                            end;
                            print("=============================================================");
                            print("[Vexus TV DEBUG] 📺 INÍCIO DA VARREDURA DA TV");
                            print("[Vexus TV DEBUG] Raiz: " .. nil.GetFullName(nil));
                            print("=============================================================");
                            r59(nil, 0);
                            print("=============================================================");
                            print("[Vexus TV DEBUG] 📺 FIM DA VARREDURA | Total de labels: " .. r58);
                            print("=============================================================");
                            warn("[Vexus TV DEBUG] ⚠️  Detecção DESATIVADA. Envie os logs acima para corrigir.");
                            return nil;
                        end; 
                    end;
                end; 
            end; 
        end;
        local function r60(arg1_11, arg2_11)
            game = r34();
            if not game then
                return false;
            end;
            v6.CFrame = CFrame.new(arg1_11);
            T = task.wait;
            game = T;
            T(arg2_11 or .8);
            return true; 
        end;
        local list = {};
        local auto = "Auto";
        local function r64()
            local Character = LocalPlayer2.Character;
            if Character then
                game = {
                    Character
                };
            end;
            z = OverlapParams.new();
            z.FilterType = Enum.RaycastFilterType.Exclude;
            list2 = Character or ;
            z.FilterDescendantsInstances = list2;
            game = r43;
            game = 34116843732494[3];
            game = 34116843732494[2];
            for game, l in ipairs("ipairs") do
                game = game;
                q = "new";
                game = actionMap[2];
                game = actionMap[1];
                for instance, tv in ipairs(Workspace:GetPartBoundsInBox(CFrame[actionMap[q]](l), vector35, z)) do
                    q = tv:FindFirstAncestorOfClass(instance["Model"]);
                    if q then
                        local Humanoid = q:FindFirstChildOfClass("Humanoid");
                        if Humanoid then
                            q:FindFirstChildOfClass(instance[g]);
                        end;
                        if Humanoid then
                            if not ({})[q.Name] then
                                ({})[q.Name] = q;
                            end;
                        end;
                    end; 
                end; 
            end; 
        end;
        local function r65()
            p = {
                "Auto"
            };
            z = 16156929465699[1];
            for game, game in pairs(z) do
                table.insert(p, game); 
            end;
            return p; 
        end;
        local function r66(arg1_12, arg2_12, arg3_12, arg4_12, arg5_12)
            game = u[arg2_12];
            game = arg5_12 or 12;
            print("[Vexus Interact] 🎯 Tentando Get Object com keywords: [" .. table.concat(arg1_12, ", ") .. "]");
            if r54(arg1_12, arg2_12, arg3_12 or 15) then
                print("[Vexus Interact] ✅ Get Object bem-sucedido.");
                return true;
            end;
            print("[Vexus Interact] ⚠️  Get Object falhou. Usando Auto Grab como fallback...");
            if arg4_12 then
                if arg4_12 then
                    r51(arg4_12, game, 2.5);
                    return true;
                end;
                warn("[Vexus Interact] ❌ Sem posição para Auto Grab fallback.");
                return false;
            else
                game = arg2_12;
            end; 
        end;
        local r67 = false;
        local function r68(...)
            if r67 then
                warn("[Vexus] Sequência já está rodando.");
                return;
            end;
            game = "\xaf\x00ri";
            local function p(arg1_13)
                print("[Vexus AutoTreat] " .. arg1_13); 
            end;
            r64();
            game = r16;
            if not r69 then
                game = {
                    pairs(list)
                };
                game = game[3];
                z = pairs(list);
                game = game[2];
                game, game = z(game, game);
            end;
            if not r69 then
                warn("[Vexus AutoTreat] ❌ Nenhum paciente encontrado.");
                return;
            end;
            p("Paciente selecionado: " .. r69.Name);
            local function z()
                local HumanoidRootPart = r69:FindFirstChild("HumanoidRootPart");
                if HumanoidRootPart then
                    return HumanoidRootPart;
                else
                    
                end; 
            end;
            game = z();
            if not game then
                warn("[Vexus AutoTreat] ❌ NPC sem HumanoidRootPart.");
                return;
            end;
            p("Teleportando até NPC: " .. r69.Name);
            if not r60(Config.Position + Vector3.new(0, 2, 0), 1) then
                return;
            end;
            p("Interagindo com NPC via Get Object...");
            r66({
                "examine",
                "check",
                "interact",
                "patient",
                "inspect",
                "talk",
                "use"
            }, Config.Position, 12, Config.Position, 12);
            task.wait(0.5);
            p("Procurando Analyzer mais próximo no Workspace...");
            game = r56({
                "analyzer",
                "analyser",
                "analyse",
                "analyze",
                "analysis"
            }, true);
            if not game then
                r55("Analyser");
                game = r55("Analyzer") or ;
            end;
            if not game then
                warn("[Vexus AutoTreat] ❌ Analyzer não encontrado!");
                return;
            end;
            p("Analyzer encontrado em: " .. tostring(v14.Position));
            if not r60(v14.Position + Vector3.new(0, 2, 0), 1) then
                return;
            end;
            p("Interagindo com Analyzer via Get Object...");
            r66({
                "analyze",
                "analyse",
                "scan",
                "use",
                "interact",
                "analyzer",
                "check"
            }, v14.Position, 15, v14.Position, 12);
            task.wait(0.5);
            p("Procurando Monitor mais próximo no Workspace...");
            G = r56({
                "monitor",
                "screen",
                "display",
                "tv",
                "results"
            }, true);
            if not G then
                r55("Screen");
            end;
            if not G then
                warn("[Vexus AutoTreat] ❌ Monitor não encontrado!");
                return;
            end;
            p("Monitor encontrado em: " .. tostring(G.Position));
            if not r60(G.Position + Vector3.new(0, 2, 0), 1) then
                return;
            end;
            p("Interagindo com Monitor via Get Object...");
            r66({
                "view",
                "check",
                "read",
                "use",
                "monitor",
                "results",
                "interact"
            }, G.Position, 15, G.Position, 12);
            task.wait(1);
            p("Lendo TV para detectar medicamento...");
            y = r57();
            if not y then
                warn("[Vexus AutoTreat] ❌ Medicamento não detectado (modo debug ativo). Verifique os logs da TV.");
                return;
            end;
            p("💊 Medicamento necessário: " .. y);
            R = actionMap2[y];
            if not R then
                warn("[Vexus AutoTreat] ❌ Posição não encontrada para: " .. y);
                return;
            end;
            p("Teleportando para pegar: " .. y);
            if not r60(R, 1.5) then
                return;
            end;
            p("Pegando medicamento via Get Object...");
            a = r48[y] or ;
            print("[Vexus AutoTreat] 🔑 Keywords do medicamento: [" .. table.concat(a, ", ") .. "]");
            if not r54(a, R, 25) then
                p("⚠️  Get Object falhou para medicamento. Usando Auto Grab fallback...");
                r51(R, 12, 2.5);
            else
                p("✅ Medicamento coletado via Get Object!");
            end;
            game = z();
            if not game then
                warn("[Vexus AutoTreat] ❌ NPC sumiu antes de entregar.");
                return;
            end;
            p("Voltando ao NPC para entregar " .. y .. "...");
            if not r60(Config.Position + Vector3.new(0, 2, 0), 1) then
                return;
            end;
            p("Entregando medicamento ao NPC via Get Object...");
            if r54({
                "give",
                "deliver",
                "use",
                "apply",
                "administer",
                "dispense",
                "treat"
            }, Config.Position, 15) then
                p("✅ Medicamento entregue ao NPC via Get Object!");
            else
                p("⚠️  Get Object falhou na entrega. Usando Auto Grab fallback...");
                r51(Config.Position, 12, 2.5);
            end;
            p("✅ Sequência completa para " .. r69.Name .. "!"); 
        end;
        local function r70(...)
            if r37 then
                return;
            end;
            p = r34();
            if not p then
                return;
            end;
            p.CFrame = CFrame.new(vector34);
            task.wait(0.5);
            r52(vector34, 15, 3);
            task.delay(3, function(...)
                return; 
            end); 
        end;
        local vexusNotifGUI_v1 = "VexusNotifGUI_v1";
        if CoreGui:FindFirstChild(vexusNotifGUI_v1) then
            local v18 = CoreGui[vexusNotifGUI_v1];
            v18:Destroy();
        end;
        local instance3 = Instance.new("ScreenGui");
        instance3.Name = vexusNotifGUI_v1;
        instance3.ResetOnSpawn = false;
        pcall(function(...)
            instance3.Parent = CoreGui;
            return; 
        end);
        if not v19.Parent then
            instance3.Parent = LocalPlayer2:WaitForChild("PlayerGui");
        end;
        local items = {};
        local r74 = 58;
        local r76 = 20;
        local r77 = -234;
        local r78 = 24;
        local function r79()
            return os.date("%H:%M"); 
        end;
        local function r80(arg1_14, arg2_14, ...)
            if arg2_14 then
                game = game and "ANOMALY";
                if arg2_14 then
                    if arg2_14 then
                        game = Color3.fromRGB(220, 50, 50);
                    end;
                    arg2_14 = arg2_14;
                    if arg2_14 then
                        game = items;
                        game = l[2];
                        game = l[1];
                        for game, game in ipairs(game) do
                            pcall(function(...)
                                z = u[z];
                                z:TweenPosition(UDim2.new(1, r77, 0, u[z].Position.Y.Offset + r74 + 6), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .3, true);
                                return; 
                            end); 
                        end;
                        instance4 = Instance.new("Frame");
                        instance4.Size = UDim2.new(0, 220, 0, r74);
                        instance4.Position = UDim2.new(1, r76, 0, r78);
                        instance4.BackgroundColor3 = Color3.fromRGB(20, 14, 30);
                        instance4.BackgroundTransparency = .18;
                        instance4.BorderSizePixel = 0;
                        instance4.ClipsDescendants = true;
                        instance4.Parent = instance3;
                        Instance.new("UICorner", instance4).CornerRadius = UDim.new(0, 14);
                        game = Instance.new("UIStroke", instance4);
                        game = z;
                        v8.Color = game;
                        v8.Thickness = 1.4;
                        v8.Transparency = 0.25;
                        game = Instance.new("TextLabel", instance4);
                        v11.Size = UDim2.new(1, -54, 0, 26);
                        v11.Position = UDim2.new(0, 12, 0, 4);
                        v11.BackgroundTransparency = 1;
                        v11.Font = Enum.Font.GothamBold;
                        v11.TextSize = 11;
                        v11.TextColor3 = Color3.fromRGB(200, 170, 255);
                        v11.TextXAlignment = Enum.TextXAlignment.Left;
                        v11.Text = "Vexus Hub";
                        l = Instance.new("TextLabel", instance4);
                        l.Size = UDim2.new(0, 44, 0, 26);
                        l.Position = UDim2.new(1, -50, 0, 4);
                        l.BackgroundTransparency = 1;
                        l.Font = Enum.Font.Gotham;
                        l.TextSize = 10;
                        l.TextColor3 = Color3.fromRGB(160, 130, 200);
                        l.TextXAlignment = Enum.TextXAlignment.Right;
                        l.Text = r79();
                        game = Instance.new("Frame", instance4);
                        v12.Size = UDim2.new(1, -16, 0, 1);
                        v12.Position = UDim2.new(0, 8, 0, 30);
                        v12.BackgroundColor3 = z;
                        v12.BackgroundTransparency = .7;
                        v12.BorderSizePixel = 0;
                        game = Instance.new("TextLabel", instance4);
                        v13.Size = UDim2.new(1, -84, 0, 22);
                        v13.Position = UDim2.new(0, 12, 0, 33);
                        v13.BackgroundTransparency = 1;
                        v13.Font = Enum.Font.Gotham;
                        v13.TextSize = 10;
                        v13.TextColor3 = Color3.fromRGB(230, 220, 255);
                        v13.TextXAlignment = Enum.TextXAlignment.Left;
                        v13.TextTruncate = Enum.TextTruncate.AtEnd;
                        v13.Text = arg1_14.Name or "?";
                        game = Instance.new("Frame", instance4);
                        v14.Size = UDim2.new(0, 66, 0, 16);
                        v14.Position = UDim2.new(1, -72, 0, 36);
                        v14.BackgroundColor3 = game;
                        v14.BackgroundTransparency = .35;
                        v14.BorderSizePixel = 0;
                        Instance.new("UICorner", game).CornerRadius = UDim.new(0, 6);
                        instance = Instance.new("UIStroke", game);
                        instance.Color = game;
                        instance.Thickness = 1;
                        instance.Transparency = .2;
                        instance2 = Instance.new("TextLabel", game);
                        instance2.Size = UDim2.new(1, 0, 1, 0);
                        instance2.BackgroundTransparency = 1;
                        instance2.Font = Enum.Font.GothamBold;
                        instance2.TextSize = 9;
                        instance2.TextColor3 = Color3.fromRGB(255, 255, 255);
                        instance2.TextXAlignment = Enum.TextXAlignment.Center;
                        tv = game and "ANOMALY";
                        instance2.Text = tv;
                        table.insert(items, 1, instance4);
                        instance4:TweenPosition(UDim2.new(1, r77, 0, r78), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, .4, true);
                        task.delay(5, function(...)
                            if not instance4 or not instance4.Parent then
                                return;
                            end;
                            instance4:TweenPosition(UDim2.new(1, r76, 0, instance4.Position.Y.Offset), Enum.EasingDirection.In, Enum.EasingStyle.Quint, .3, true);
                            instance4 = "wait";
                            task[actionMap[instance4]](.35);
                            game = items;
                            for arg2_14, game in ipairs(game) do
                                local function instance4(...)
                                    instance4 = u[149];
                                    instance4:Destroy();
                                    return; 
                                end;
                                if game == instance4 then
                                    table.remove(items, arg2_14);
                                    break;
                                else
                                    
                                end;
                                pcall(function(...)
                                    instance4 = u[149];
                                    instance4:Destroy();
                                    return; 
                                end); 
                            end; 
                        end);
                        return;
                    else
                        arg2_14 = Color3.fromRGB(50, 190, 110);
                    end;
                else
                    arg2_14 = Color3.fromRGB(130, 80, 255);
                end;
            else
                
            end; 
        end;
        local function r83()
            local Character = LocalPlayer2.Character;
            if not Character then
                return false;
            end;
            overlapParams.FilterDescendantsInstances = {
                Character
            };
            game = "\x846 ";
            game = actionMap;
            game = game[2];
            game = game[1];
            for z, game in ipairs(Workspace:GetPartBoundsInBox(CFrame[game[r16(game, 5415144655321)]](vector3), vector32, overlapParams)) do
                game = z;
                game = "Model";
                game = game:FindFirstAncestorOfClass(actionMap[game]);
                if game then
                    game = Players;
                    game = not game:GetPlayerFromCharacter(game);
                end;
                if game then
                    game = game:FindFirstChildOfClass("Humanoid");
                    if game then
                        game = game:IsA("Humanoid") and l.Health > 0;
                        game:FindFirstChildOfClass(actionMap[game]);
                    end;
                    if game then
                        return true;
                    else
                        
                    end;
                end; 
            end;
            return false; 
        end;
        local function r84(arg1_15, arg2_15)
            if not arg1_15 then
                return;
            end;
            p.CFrame = CFrame.new(p.Position, Vector3.new(j.v12, p.Position.Y, j.Z)); 
        end;
        local function r87(arg1_16, ...)
            z = {
                pcall(function()
                    list2 = ReplicatedStorage:WaitForChild("Util", 5);
                    T = list2:WaitForChild("Net", 5);
                    list2 = T:WaitForChild("RE", 5);
                    return list2:WaitForChild(arg1_16, 5); 
                end)
            };
            j = z[2];
            game = pcall(function()
                list2 = ReplicatedStorage:WaitForChild("Util", 5);
                T = list2:WaitForChild("Net", 5);
                list2 = T:WaitForChild("RE", 5);
                return list2:WaitForChild(arg1_16, 5); 
            end);
            if game then
                
            end;
            if game then
                return j;
            end;
            game = ReplicatedStorage;
            game = game[3];
            game = "ipairs";
            for game, game in ipairs(game:GetDescendants()) do
                game:IsA("RemoteFunction");
                game = game;
                game = game:IsA("RemoteEvent");
                l = game or ;
                if l then
                    l = v11.Name:lower();
                    game = arg1_16;
                    if l:find(game:lower()) then
                        return game;
                    else
                    end;
                end; 
            end; 
        end;
        task.spawn(function(...)
            while task.wait(3) do
                 
            end;
            return; 
        end);
        task.spawn(function(...)
            while task.wait(1) do
                if r36.InfinitySanityActive and (r85 and r85.Parent) then
                    pcall(function(...)
                        r85:FireServer(r36.SanityTarget);
                        return; 
                    end);
                end; 
            end;
            return; 
        end);
        task.spawn(function(...)
            while task.wait(2) do
                if r36.AutoReviveActive then
                    p = r35();
                    if (not p or p.Health <= 0) and (r86 and r86.Parent) then
                        pcall(function(...)
                            r86:FireServer();
                            return; 
                        end);
                    end;
                end; 
            end;
            return; 
        end);
        task.spawn(function(...)
            while task.wait(.3) do
                p = "AutoFarmActive";
                if r36[p] then
                    p = r34();
                    if p then
                        r83();
                    end;
                    if p then
                        for game, game in z, ipairs(z) do
                            game = game;
                            if not (not r36.AutoFarmActive or not r83()) then
                                game = r34();
                                if not not game then
                                    r84(game, game);
                                    task.wait(.05);
                                    game = r34();
                                    if not not game then
                                        v9.CFrame = CFrame.new(game, Vector3.new(v8.v12, v8.Y, v8.Z - 1));
                                        if game == 1 then
                                            task.wait(9);
                                        else
                                            if game == #r38 then
                                                task.wait(5);
                                            else
                                                task.wait(0.5);
                                            end;
                                        end;
                                    end;
                                end;
                            end; 
                        end;
                    end;
                end; 
            end;
            return; 
        end);
        local v21 = game:GetService("ProximityPromptService").PromptShown;
        v21:Connect(function(arg1_17, ...)
            task.spawn(function(...)
                if r36.AutoFarmActive and actionMap then
                    r50(arg1_17);
                end;
                return; 
            end);
            return; 
        end);
        task.spawn(function(...)
            j = 1;
            while task.wait(j) do
                j = r36.NotifyActive;
                if j then
                    if j then
                        l = 32956694166514;
                        if LocalPlayer2[actionMap[r16("\xbc\xd3\xf5I\xe0i]f-", l)]] then
                            overlapParams.FilterDescendantsInstances = {
                                z
                            };
                            game = 30292122842905;
                            game = {};
                            game = r16[3];
                            l = l[1];
                            for game, game in l, ipairs(Workspace:GetPartBoundsInBox(CFrame[actionMap[l("J\xb0\xca", game)]](vector3), vector32, overlapParams)) do
                                game = game;
                                game = game:FindFirstAncestorOfClass("Model");
                                if game then
                                    Humanoid = game:FindFirstChildOfClass("Humanoid");
                                    if Humanoid then
                                        game:FindFirstChildOfClass(actionMap[q]);
                                    end;
                                    if Humanoid then
                                        ({})[game] = true;
                                    end;
                                end; 
                            end;
                            game = {
                                pairs(game)
                            };
                            l = pairs(game)(game[2], game[3]);
                            while l do
                                game = l;
                                if not ({})[game] then
                                    game = hasTag(l);
                                    if r36.NotifyActive then
                                        r80(l, game);
                                    end;
                                    if game then
                                        game = Workspace(game);
                                    end;
                                    if game then
                                        task.spawn(r70);
                                    end;
                                end; 
                            end;
                        end;
                    else
                        
                    end;
                else
                    
                end; 
            end;
            return; 
        end);
        task.spawn(function(...)
            while task.wait(2) do
                r64();
                if r63 then
                    game = "ipairs";
                    for z, game in ipairs(r65()) do
                        game = z;
                        if not (game == auto) then
                            
                        end;
                        if not false then
                            pcall(function(...)
                                r63.Text = "Paciente: Auto";
                                return; 
                            end);
                        end; 
                    end;
                end; 
            end;
            return; 
        end);
        local list3 = {};
        local function r91(arg1_18, ...)
            if list3[arg1_18] then
                game = list3;
                game = game[3];
                for game, game in ipairs(list2) do
                    game = game;
                    game:Remove(); 
                end;
                list3[arg1_18] = nil;
            end; 
        end;
        local function r93()
            z = {
                pairs(list3)
            };
            j = pairs(list3)(z[2], z[3]);
            while j do
                r91(j); 
            end; 
        end;
        local function r94(arg1_19, arg2_19, ...)
            game = actionMap;
            game = {
                pcall(Drawing.new, arg1_19)
            };
            r95 = game[2];
            if not pcall(Drawing.new, arg1_19) then
                return nil;
            end;
            game = game[3];
            game = game[1];
            for game, l in game, pairs(arg2_19) do
                pcall(function(...)
                    r95[game] = l;
                    return; 
                end); 
            end;
            return r95; 
        end;
        local function r98(arg1_20)
            game = workspace.CurrentCamera:WorldToViewportPoint(arg1_20);
            return Vector2.new(v6.v12, v6.Y), game[2], v6.Z; 
        end;
        local function r99(arg1_21)
            j = Vector3.new(math.huge, math.huge, math.huge);
            game = p.GetDescendants;
            game = {
                game(arg1_21)
            };
            game = game[3];
            for game, game in ipairs(S(list2)) do
                game = game;
                if game:IsA("BasePart") then
                    l = v11.Size / 2;
                    tv = -1;
                    game = v11.CFrame;
                    game = tv[2];
                    for instance, tv in ipairs({
                        tv,
                        1
                    }) do
                        for _, g in g[1], ipairs({
                            g,
                            1
                        }) do
                            for _, y in ipairs({
                                y,
                                1
                            }) do
                                R = (v11.CFrame * CFrame.new(l.v12 * tv, l.Y * g, l.Z * y)).Position;
                                game = Vector3.new(math.max(v6.v12, R.v12), math.max(v6.Y, R.Y), math.max(v6.Z, R.Z)); 
                            end; 
                        end; 
                    end;
                end; 
            end;
            if j.v12 == math.huge then
                return nil;
            end;
            return j, Vector3.new(-math.huge, -math.huge, -math.huge); 
        end;
        local function r100(arg1_22, arg2_22, ...)
            z = {
                r99(arg1_22)
            };
            game = z[2];
            z = r99(arg1_22);
            if not z then
                r91(arg1_22);
                return;
            end;
            game = -math.huge;
            game = -math.huge;
            game = math.huge;
            l = math.huge;
            instance2 = instance2[1];
            for instance, q in ipairs({
                Vector3.new(z.v12, z.Y, z.Z),
                Vector3.new(v6.v12, z.Y, z.Z),
                Vector3.new(z.v12, v6.Y, z.Z),
                Vector3.new(v6.v12, v6.Y, z.Z),
                Vector3.new(z.v12, z.Y, v6.Z),
                Vector3.new(v6.v12, z.Y, v6.Z),
                Vector3.new(z.v12, v6.Y, v6.Z),
                Vector3.new(v6.v12, v6.Y, v6.Z)
            }) do
                g = {
                    r98(q)
                };
                Y = r98(q);
                G = g[3];
                if G > 0 then
                    game = true;
                    math.min(math.huge, Y.v12);
                    math.min(math.huge, Y.Y);
                    math.max(-math.huge, Y.v12);
                    math.max(-math.huge, Y.Y);
                    math.min(math[actionMap[instance2]], G);
                end; 
            end;
            if not false or math[actionMap[instance2]] <= 0 then
                if list3[arg1_22] then
                    for tv, q in list3[1], ipairs(q) do
                        r101 = q;
                        game = tv;
                        pcall(function(...)
                            r101.Visible = false;
                            return; 
                        end); 
                    end;
                end;
                return;
            end;
            game = arg2_22 and ;
            if arg2_22 then
                if arg2_22 then
                    arg2_22 = game - 2;
                    tv = l - 2;
                    q = -math.huge - game + 4;
                    Y = -math.huge - l + 4;
                    m = math.min(q, Y) * .22;
                    if not list3[arg1_22] then
                        G = {};
                        table.insert(G, r94("Square", {
                            ["Visible"] = true,
                            ["Filled"] = true,
                            ["Color"] = Color3.fromRGB(0, 0, 0),
                            ["Transparency"] = .55,
                            ["Thickness"] = 1
                        }));
                        table.insert(G, r94("Square", {
                            ["Visible"] = false,
                            ["Filled"] = false,
                            ["Color"] = arg2_22 and ,
                            ["Thickness"] = 1.5,
                            ["Transparency"] = 1
                        }));
                        for R = 1, 8 do
                            table.insert(G, r94("Line", {
                                ["Visible"] = true,
                                ["Color"] = arg2_22 and ,
                                ["Thickness"] = 2,
                                ["Transparency"] = 1
                            })); 
                        end;
                        cW = arg2_22;
                        table.insert(G, r94("Text", {
                            ["Visible"] = true,
                            ["Center"] = true,
                            ["Outline"] = true,
                            ["Color"] = Color3.fromRGB(255, 255, 255),
                            ["OutlineColor"] = Color3.fromRGB(0, 0, 0),
                            ["Size"] = 13,
                            ["Font"] = Drawing.Fonts.GothamBold or 3
                        }));
                        zW = arg2_22;
                        table.insert(G, r94("Text", {
                            ["Visible"] = true,
                            ["Center"] = true,
                            ["Outline"] = true,
                            ["Color"] = tv,
                            ["OutlineColor"] = Color3.fromRGB(0, 0, 0),
                            ["Size"] = 11,
                            ["Font"] = Drawing.Fonts.GothamBold or 3
                        }));
                        list3[arg1_22] = G;
                    end;
                    G = list3[arg1_22];
                    if G[1] then
                        G[1].Size = Vector2.new(q, Y);
                        G[1].Position = Vector2.new(arg2_22, tv);
                        G[1].Visible = true;
                    end;
                    if G[2] then
                        G[2].Size = Vector2.new(q, Y);
                        G[2].Position = Vector2.new(arg2_22, tv);
                        SW = arg2_22 and ;
                        G[2].Color = SW;
                        G[2].Visible = true;
                    end;
                    TW = tv + m;
                    Vector2.new(arg2_22, tv + Y);
                    FW = {
                        Vector2.new(arg2_22 + m, tv + Y)
                    };
                    TW = {
                        Vector2.new(arg2_22, tv + Y),
                        Vector2.new(arg2_22, tv + Y - m)
                    };
                    WW = {
                        Vector2.new(arg2_22 + q, tv + Y),
                        Vector2.new(arg2_22 + q - m, tv + Y)
                    };
                    for a, E in ipairs({
                        {
                            Vector2.new(arg2_22, tv),
                            Vector2.new(arg2_22 + m, tv)
                        },
                        {
                            Vector2.new(arg2_22, tv),
                            S(E)
                        },
                        {
                            Vector2.new(arg2_22 + q, tv),
                            Vector2.new(arg2_22 + q - m, tv)
                        },
                        {
                            Vector2.new(arg2_22 + q, tv),
                            E(arg2_22 + q, tv + m)
                        },
                        E,
                        TW,
                        WW,
                        {
                            Vector2.new(arg2_22 + q, tv + Y),
                            Vector2.new(arg2_22 + q, tv + Y - m)
                        }
                    }), WW, E[2](arg2_22, TW) do
                        TW = G[2 + a];
                        if TW then
                            TW.From = E[1];
                            TW.To = E[2];
                            FW = arg2_22 and ;
                            TW.Color = FW;
                            TW.Visible = true;
                        end; 
                    end;
                    if G[11] then
                        G[11].Text = arg1_22.Name;
                        G[11].Position = Vector2.new(arg2_22 + q / 2, tv - 16);
                        G[11].Visible = true;
                    end;
                    if G[12] then
                        arg2_22 = arg2_22;
                        arg2_22 = arg2_22;
                        G[12].Text = arg2_22 or "✓ NORMAL";
                        G[12].Color = tv;
                        G[12].Position = Vector2.new(arg2_22 + q / 2, tv + Y + 2);
                        G[12].Visible = true;
                    end;
                    return;
                else
                    arg2_22 = Color3.fromRGB(180, 140, 255);
                end;
            else
                game = Color3.fromRGB(130, 80, 255);
            end; 
        end;
        task.spawn(function(...)
            while task.wait(0) do
                if r36.EspActive then
                    r102 = {};
                    game = Workspace;
                    game = game[2];
                    game = game[1];
                    for z, game in ipairs(game:GetChildren()) do
                        game:IsA("Model");
                        (function(object, ...)
                            if not object:IsA("Model") then
                                return;
                            end;
                            if Players:GetPlayerFromCharacter(object) then
                                return;
                            end;
                            Humanoid = object:FindFirstChildOfClass("Humanoid");
                            if Humanoid then
                                object:FindFirstChildOfClass(actionMap[z]);
                            end;
                            if Humanoid then
                                r102[object] = true;
                                r100(object, hasTag(object));
                            end;
                            return; 
                        end)(game);
                        game = z;
                        if game:IsA("Folder") or  then
                            game = v9.GetDescendants;
                            for game, game in ipairs(game(game)) do
                                game = game;
                                if game:IsA("Model") then
                                    (function(object2, ...)
                                        if not object2:IsA("Model") then
                                            return;
                                        end;
                                        if Players:GetPlayerFromCharacter(object2) then
                                            return;
                                        end;
                                        Humanoid = object2:FindFirstChildOfClass("Humanoid");
                                        if Humanoid then
                                            object2:FindFirstChildOfClass(actionMap[z]);
                                        end;
                                        if Humanoid then
                                            r102[object2] = true;
                                            r100(object2, hasTag(object2));
                                        end;
                                        return; 
                                    end)(game);
                                end; 
                            end;
                        end; 
                    end;
                    game = {
                        pairs(list3)
                    };
                    game = pairs(list3)(game[2], game[3]);
                    while game do
                        game = game(z, game[3]);
                        if not r102[game] then
                            u[v21](game);
                        end; 
                    end;
                    RunService.RenderStepped:Wait();
                else
                    u[DW]();
                end; 
            end;
            return; 
        end);
        local v22 = {};
        local r103 = LocalPlayer2:WaitForChild("PlayerGui");
        local r104 = {
            ["Background"] = Color3.fromRGB(18, 18, 22),
            ["Panel"] = Color3.fromRGB(26, 26, 32),
            ["Element"] = Color3.fromRGB(36, 36, 44),
            ["Accent"] = Color3.fromRGB(110, 60, 220),
            ["AccentDim"] = Color3.fromRGB(70, 35, 160),
            ["Text"] = Color3.fromRGB(235, 235, 235),
            ["SubText"] = Color3.fromRGB(130, 130, 145),
            ["Speed"] = .12
        };
        local function r105(arg1_25, arg2_25, arg3_25)
            game = arg3_25;
            Instance.new(arg1_25);
            game = pairs;
            game = arg2_25;
            if arg2_25 then
                game = game[2];
                for game, l in game(game[1]) do
                    Instance[game[game("\xdeN_", l)]](p)[game] = l; 
                end;
                if game then
                    game = ipairs[3];
                    game = ipairs[2];
                    for game, ipairs in ipairs(game) do
                        l.Parent = Instance[game[game("\xdeN_", ipairs)]](p); 
                    end;
                    return Instance[game[game("\xdeN_", ipairs)]](p);
                else
                    
                end;
            else
                
            end; 
        end;
        local function r106(arg1_26, arg2_26, arg3_26)
            game = arg3_26;
            game = TweenService;
            if game then
                list2 = T:Create(arg1_26, TweenInfo.new(game, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), arg2_26);
                list2:Play();
                return;
            else
                game = r104.Speed;
            end; 
        end;
        aW.CreateWindow = function(arg1_27, ...)
            j = "VexusHubUI";
            if CoreGui:FindFirstChild(j) then
                CoreGui = CoreGui[j];
                CoreGui:Destroy();
            end;
            r107 = r105("ScreenGui", {
                ["Name"] = j,
                ["ResetOnSpawn"] = false,
                ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
            });
            if not pcall(function(...)
                r107.Parent = CoreGui;
                return; 
            end) then
                r107.Parent = r103;
            end;
            r108 = r105("Frame", {
                ["Name"] = "Main",
                ["Size"] = UDim2.new(0, 300, 0, 330),
                ["Position"] = UDim2.new(0.5, -150, .35, -165),
                ["BackgroundColor3"] = r104.Background,
                ["BackgroundTransparency"] = .04,
                ["BorderSizePixel"] = 0,
                ["Active"] = true
            });
            r108.Parent = r107;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(0, 12)
            }).Parent = r108;
            r105("UIStroke", {
                ["Color"] = r104.Accent,
                ["Thickness"] = 1.2,
                ["Transparency"] = .4
            }).Parent = r108;
            U = r105("Frame", {
                ["Size"] = UDim2.new(1, 0, 0, 32),
                ["BackgroundColor3"] = r104.Panel,
                ["BorderSizePixel"] = 0
            });
            U.Parent = r108;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(0, 12)
            }).Parent = U;
            r105("Frame", {
                ["Size"] = UDim2.new(1, 0, 0.5, 0),
                ["Position"] = UDim2.new(0, 0, 0.5, 0),
                ["BackgroundColor3"] = r104.Panel,
                ["BorderSizePixel"] = 0
            }).Parent = U;
            k = r105("Frame", {
                ["Size"] = UDim2.new(0, 6, 0, 6),
                ["Position"] = UDim2.new(0, 10, 0.5, -3),
                ["BackgroundColor3"] = r104.Accent,
                ["BorderSizePixel"] = 0
            });
            k.Parent = U;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(1, 0)
            }).Parent = k;
            r105("TextLabel", {
                ["Size"] = UDim2.new(1, -80, 1, 0),
                ["Position"] = UDim2.new(0, 22, 0, 0),
                ["BackgroundTransparency"] = 1,
                ["Font"] = Enum.Font.GothamBold,
                ["Text"] = arg1_27.Title or "Hub",
                ["TextSize"] = 12,
                ["TextColor3"] = r104.Text,
                ["TextXAlignment"] = Enum.TextXAlignment.Left,
                ["ZIndex"] = 2
            }).Parent = U;
            r109 = r105("TextButton", {
                ["Size"] = UDim2.new(0, 22, 0, 18),
                ["Position"] = UDim2.new(1, -48, 0.5, -9),
                ["BackgroundColor3"] = r104.Element,
                ["AutoButtonColor"] = false,
                ["Font"] = Enum.Font.GothamBold,
                ["Text"] = "—",
                ["TextSize"] = 10,
                ["TextColor3"] = Color3.fromRGB(200, 200, 80),
                ["BorderSizePixel"] = 0,
                ["ZIndex"] = 3
            });
            r109.Parent = U;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(0, 4)
            }).Parent = r109;
            H = r105("TextButton", {
                ["Size"] = UDim2.new(0, 22, 0, 18),
                ["Position"] = UDim2.new(1, -24, 0.5, -9),
                ["BackgroundColor3"] = r104.Element,
                ["AutoButtonColor"] = false,
                ["Font"] = Enum.Font.GothamBold,
                ["Text"] = "✕",
                ["TextSize"] = 10,
                ["TextColor3"] = Color3.fromRGB(220, 80, 80),
                ["BorderSizePixel"] = 0,
                ["ZIndex"] = 3
            });
            H.Parent = U;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(0, 4)
            }).Parent = H;
            H.MouseButton1Click:Connect(function(...)
                r107:Destroy();
                return; 
            end);
            r110 = r105("Frame", {
                ["Size"] = UDim2.new(1, 0, 1, 0),
                ["BackgroundTransparency"] = 1
            });
            r110.Parent = r108;
            r111 = r105("Frame", {
                ["Size"] = UDim2.new(0, 80, 1, -32),
                ["Position"] = UDim2.new(0, 0, 0, 32),
                ["BackgroundTransparency"] = 1,
                ["BorderSizePixel"] = 0
            });
            r111.Parent = r110;
            r105("UIListLayout", {
                ["Padding"] = UDim.new(0, 0),
                ["SortOrder"] = Enum.SortOrder.LayoutOrder
            }).Parent = r111;
            r105("UIPadding", {
                ["PaddingTop"] = UDim.new(0, 6),
                ["PaddingLeft"] = UDim.new(0, 4)
            }).Parent = r111;
            r105("Frame", {
                ["Size"] = UDim2.new(0, 1, 1, -32),
                ["Position"] = UDim2.new(0, 80, 0, 32),
                ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
                ["BackgroundTransparency"] = .88,
                ["BorderSizePixel"] = 0
            }).Parent = r110;
            r112 = r105("Frame", {
                ["Size"] = UDim2.new(1, -84, 1, -32),
                ["Position"] = UDim2.new(0, 83, 0, 32),
                ["BackgroundTransparency"] = 1,
                ["ClipsDescendants"] = true
            });
            r112.Parent = r110;
            r113 = r105("Frame", {
                ["Size"] = UDim2.new(1, 0, 0, 28),
                ["Position"] = UDim2.new(0, 0, 1, -28),
                ["BackgroundColor3"] = r104.Panel,
                ["BackgroundTransparency"] = .3,
                ["BorderSizePixel"] = 0,
                ["ZIndex"] = 5
            });
            r113.Parent = r108;
            r105("UICorner", {
                ["CornerRadius"] = UDim.new(0, 10)
            }).Parent = r113;
            r105("Frame", {
                ["Size"] = UDim2.new(1, 0, 0.5, 0),
                ["Position"] = UDim2.new(0, 0, 0, 0),
                ["BackgroundColor3"] = r104.Panel,
                ["BackgroundTransparency"] = .3,
                ["BorderSizePixel"] = 0,
                ["ZIndex"] = 5
            }).Parent = r113;
            r105("TextLabel", {
                ["Size"] = UDim2.new(0.5, 0, 1, 0),
                ["Position"] = UDim2.new(0, 8, 0, 0),
                ["BackgroundTransparency"] = 1,
                ["Font"] = Enum.Font.GothamBold,
                ["Text"] = "By cuzaoo28ejwj",
                ["TextSize"] = 9,
                ["TextColor3"] = Color3.fromRGB(160, 130, 220),
                ["TextXAlignment"] = Enum.TextXAlignment.Left,
                ["ZIndex"] = 6
            }).Parent = r113;
            r105("TextLabel", {
                ["Size"] = UDim2.new(.55, 0, 1, 0),
                ["Position"] = UDim2.new(.45, -4, 0, 0),
                ["BackgroundTransparency"] = 1,
                ["Font"] = Enum.Font.Gotham,
                ["Text"] = "Next update tomorrow",
                ["TextSize"] = 9,
                ["TextColor3"] = Color3.fromRGB(110, 90, 160),
                ["TextXAlignment"] = Enum.TextXAlignment.Right,
                ["ZIndex"] = 6
            }).Parent = r113;
            r114 = false;
            r109.MouseButton1Click:Connect(function(...)
                r114 = not r114;
                if r114 then
                    r106(r108, {
                        ["Size"] = UDim2.new(0, 300, 0, 32)
                    });
                    r110.Visible = false;
                    r113.Visible = false;
                    r109.Text = "□";
                else
                    r106(r108, {
                        ["Size"] = UDim2.new(0, 300, 0, 330)
                    });
                    r110.Visible = true;
                    r113.Visible = true;
                    r109.Text = "—";
                end;
                return; 
            end);
            r115 = false;
            r117 = Vector2.zero;
            uDim2 = UDim2.new();
            U.InputBegan:Connect(function(arg1_28, arg2_28, ...)
                if arg2_28 then
                    return;
                end;
                if p.UserInputType == Enum.UserInputType.MouseButton1 or p.UserInputType == Enum.UserInputType.Touch then
                    r115 = true;
                    r116 = arg1_28;
                    r117 = p.Position;
                    uDim2 = r108.Position;
                end;
                return; 
            end);
            U.InputEnded:Connect(function(arg1_29, ...)
                if arg1_29 == r116 then
                    r115 = false;
                end;
                return; 
            end);
            T = UserInputService.InputChanged;
            T:Connect(function(arg1_30, ...)
                if not r115 or arg1_30 ~= r116 then
                    return;
                end;
                j = p.Position - r117;
                r108.Position = UDim2.new(uDim2.X.Scale, uDim2.X.Offset + j.X, uDim2.Y.Scale, uDim2.Y.Offset + j.Y);
                return; 
            end);
            r119 = {
                ["ScreenGui"] = r107,
                ["_curPage"] = nil,
                ["_curTabLbl"] = nil
            };
            r119.CreateTab = function(arg1_31, arg2_31, ...)
                N = r105("TextButton", {
                    ["Size"] = UDim2.new(1, 0, 0, 28),
                    ["BackgroundTransparency"] = 1,
                    ["AutoButtonColor"] = false,
                    ["Text"] = ""
                });
                N.Parent = r111;
                r120 = r105("TextLabel", {
                    ["Size"] = UDim2.new(1, -4, 1, 0),
                    ["Position"] = UDim2.new(0, 4, 0, 0),
                    ["BackgroundTransparency"] = 1,
                    ["Font"] = Enum.Font.GothamBold,
                    ["Text"] = arg2_31,
                    ["TextSize"] = 10,
                    ["TextColor3"] = r104.SubText,
                    ["TextXAlignment"] = Enum.TextXAlignment.Left
                });
                r120.Parent = N;
                r121 = r105("ScrollingFrame", {
                    ["Size"] = UDim2.new(1, 0, 1, -28, 0),
                    ["BackgroundTransparency"] = 1,
                    ["BorderSizePixel"] = 0,
                    ["ScrollBarThickness"] = 2,
                    ["ScrollBarImageColor3"] = r104.Accent,
                    ["CanvasSize"] = UDim2.new(0, 0, 0, 0),
                    ["Visible"] = false
                });
                r121.Parent = r112;
                r105("UIPadding", {
                    ["PaddingTop"] = UDim.new(0, 5),
                    ["PaddingLeft"] = UDim.new(0, 3),
                    ["PaddingRight"] = UDim.new(0, 4)
                }).Parent = r121;
                r122 = r105("UIListLayout", {
                    ["Padding"] = UDim.new(0, 4),
                    ["SortOrder"] = Enum.SortOrder.LayoutOrder
                });
                r122.Parent = r121;
                e = r122:GetPropertyChangedSignal("AbsoluteContentSize");
                e:Connect(function(...)
                    r121.CanvasSize = UDim2.new(0, 0, 0, r122.AbsoluteContentSize.Y + 10);
                    return; 
                end);
                if not r119._curPage then
                    r121.Visible = true;
                    r120.TextColor3 = r104.Text;
                    r119._curPage = r121;
                    r119._curTabLbl = r120;
                end;
                N.MouseButton1Click:Connect(function(...)
                    if r119._curPage then
                        r119._curPage.Visible = false;
                    end;
                    if r119._curTabLbl then
                        r119._curTabLbl.TextColor3 = r104.SubText;
                    end;
                    r121.Visible = true;
                    r119._curPage = r121;
                    r120.TextColor3 = r104.Text;
                    r119._curTabLbl = r120;
                    return; 
                end);
                r123 = {
                    ["_ord"] = 1,
                    ["Page"] = r121
                };
                r123.CreateToggle = function(arg1_32, arg2_32, arg3_32, ...)
                    r124 = arg3_32;
                    arg1_31 = arg1_32;
                    r125 = false;
                    r123["_ord"] = r123["_ord"] + 1;
                    H = r105("TextButton", {
                        ["LayoutOrder"] = r123._ord,
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundColor3"] = r104.Element,
                        ["BackgroundTransparency"] = .2,
                        ["AutoButtonColor"] = false,
                        ["Text"] = "",
                        ["BorderSizePixel"] = 0
                    });
                    H.Parent = r121;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 6)
                    }).Parent = H;
                    r105("TextLabel", {
                        ["Size"] = UDim2.new(1, -34, 1, 0),
                        ["Position"] = UDim2.new(0, 8, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = arg2_32,
                        ["TextSize"] = 10,
                        ["TextColor3"] = r104.Text,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    }).Parent = H;
                    r126 = r105("Frame", {
                        ["Size"] = UDim2.new(0, 13, 0, 13),
                        ["Position"] = UDim2.new(1, -18, 0.5, -6.5),
                        ["BackgroundColor3"] = Color3.fromRGB(18, 18, 22),
                        ["BorderSizePixel"] = 0
                    });
                    r126.Parent = H;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 3)
                    }).Parent = r126;
                    r105("UIStroke", {
                        ["Color"] = r104.Accent,
                        ["Thickness"] = 1.2,
                        ["Transparency"] = .2
                    }).Parent = r126;
                    H.MouseButton1Click:Connect(function(...)
                        r123 = not r125;
                        r125 = r123;
                        w = r125 and r104.Accent;
                        r123 = r123;
                        if w then
                            r106(r126, {
                                ["BackgroundColor3"] = w
                            });
                            r123 = r123;
                            r124(r125);
                            return;
                        else
                            
                        end; 
                    end); 
                end;
                r123.CreateActionButton = function(arg1_33, arg2_33, arg3_33, arg4_33, ...)
                    arg1_31 = arg1_33;
                    r127 = arg4_33;
                    r123["_ord"] = r123["_ord"] + 1;
                    H = r105("Frame", {
                        ["LayoutOrder"] = r123._ord,
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundColor3"] = r104.Element,
                        ["BackgroundTransparency"] = .2,
                        ["BorderSizePixel"] = 0
                    });
                    H.Parent = r121;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 6)
                    }).Parent = H;
                    r105("TextLabel", {
                        ["Size"] = UDim2.new(1, -66, 1, 0),
                        ["Position"] = UDim2.new(0, 8, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = arg2_33,
                        ["TextSize"] = 10,
                        ["TextColor3"] = r104.Text,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    }).Parent = H;
                    r128 = r105("TextButton", {
                        ["Size"] = UDim2.new(0, 50, 0, 18),
                        ["Position"] = UDim2.new(1, -54, 0.5, -9),
                        ["BackgroundColor3"] = r104.Accent,
                        ["AutoButtonColor"] = false,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = arg3_33,
                        ["TextSize"] = 9,
                        ["TextColor3"] = r104.Text,
                        ["BorderSizePixel"] = 0
                    });
                    r128.Parent = H;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 4)
                    }).Parent = r128;
                    r128.MouseButton1Click:Connect(function(...)
                        r106(r128, {
                            ["BackgroundColor3"] = r104.AccentDim
                        });
                        task.delay(.12, function(...)
                            r106(r128, {
                                ["BackgroundColor3"] = r104.Accent
                            });
                            return; 
                        end);
                        r127();
                        return; 
                    end); 
                end;
                r123.CreateDynamicDropdown = function(arg1_34, arg2_34, arg3_34, arg4_34, arg5_34, ...)
                    arg1_31 = arg1_34;
                    r129 = arg2_34;
                    r130 = arg3_34;
                    r131 = arg5_34;
                    r123["_ord"] = r123["_ord"] + 1;
                    r132 = false;
                    r133 = r105("Frame", {
                        ["LayoutOrder"] = r123._ord,
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundColor3"] = r104.Element,
                        ["BackgroundTransparency"] = .2,
                        ["ClipsDescendants"] = true,
                        ["BorderSizePixel"] = 0
                    });
                    r133.Parent = r121;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 6)
                    }).Parent = r133;
                    r134 = r105("TextLabel", {
                        ["Size"] = UDim2.new(1, -24, 0, 28),
                        ["Position"] = UDim2.new(0, 8, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = r129 .. ": " .. arg4_34(),
                        ["TextSize"] = 9,
                        ["TextColor3"] = r104.Text,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    });
                    r134.Parent = r133;
                    r135 = r105("TextLabel", {
                        ["Size"] = UDim2.new(0, 18, 0, 28),
                        ["Position"] = UDim2.new(1, -20, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = "v",
                        ["TextSize"] = 9,
                        ["TextColor3"] = r104.SubText
                    });
                    r135.Parent = r133;
                    i = r105("TextButton", {
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundTransparency"] = 1,
                        ["Text"] = ""
                    });
                    i.Parent = r133;
                    r136 = r105("Frame", {
                        ["Position"] = UDim2.new(0, 4, 0, 28),
                        ["BackgroundTransparency"] = 1,
                        ["Size"] = UDim2.new(1, -8, 0, 0)
                    });
                    r136.Parent = r133;
                    r105("UIListLayout", {
                        ["Padding"] = UDim.new(0, 2)
                    }).Parent = r136;
                    local function r137(...)
                        N = N[1];
                        for _, U in N, ipairs(N:GetChildren()) do
                            if U:IsA("TextButton") then
                                U:Destroy();
                            end; 
                        end;
                        arg1_31 = r130();
                        r123 = ipairs;
                        for _, k in U[1], r123(arg1_31) do
                            r138 = k;
                            w = r105("TextButton", {
                                ["Size"] = UDim2.new(1, 0, 0, 18),
                                ["BackgroundColor3"] = r104.Panel,
                                ["BackgroundTransparency"] = .3,
                                ["Font"] = Enum.Font.GothamBold,
                                ["Text"] = r138,
                                ["TextSize"] = 9,
                                ["TextColor3"] = r104.SubText,
                                ["AutoButtonColor"] = false
                            });
                            w.Parent = r136;
                            r105("UICorner", {
                                ["CornerRadius"] = UDim.new(0, 3)
                            }).Parent = w;
                            r123 = w.MouseButton1Click;
                            r123:Connect(function(...)
                                r131(r138);
                                r134.Text = r129 .. ": " .. r138;
                                r132 = false;
                                r106(r133, {
                                    ["Size"] = UDim2.new(1, 0, 0, 28)
                                });
                                r135.Text = "v";
                                return; 
                            end); 
                        end;
                        j = #arg1_31 * 20 + (#arg1_31 - 1) * 2;
                        r136.Size = UDim2.new(1, -8, 0, j);
                        if r132 then
                            r106(r133, {
                                ["Size"] = UDim2.new(1, 0, 0, 28 + j + 4)
                            });
                        end; 
                    end;
                    i.MouseButton1Click:Connect(function(...)
                        r123 = not r132;
                        r132 = r123;
                        r137();
                        arg1_31 = r130();
                        r106(r133, {
                            ["Size"] = UDim2.new(1, 0, 0, r132 and 28 + #arg1_31 * 20 + math.max(0, #arg1_31 - 1) * 2 + 4 or 28)
                        });
                        r123 = r123;
                        r123 = r123;
                        r135.Text = r132 and "^" or "v";
                        return; 
                    end); 
                end;
                r123.CreateDropdown = function(arg1_35, arg2_35, arg3_35, arg4_35, arg5_35, ...)
                    arg1_31 = arg1_35;
                    r139 = arg2_35;
                    r140 = arg3_35;
                    r141 = arg5_35;
                    r123["_ord"] = r123["_ord"] + 1;
                    r142 = false;
                    r143 = r105("Frame", {
                        ["LayoutOrder"] = r123._ord,
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundColor3"] = r104.Element,
                        ["BackgroundTransparency"] = .2,
                        ["ClipsDescendants"] = true,
                        ["BorderSizePixel"] = 0
                    });
                    r143.Parent = r121;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 6)
                    }).Parent = r143;
                    r144 = r105("TextLabel", {
                        ["Size"] = UDim2.new(1, -24, 0, 28),
                        ["Position"] = UDim2.new(0, 8, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = r139 .. ": " .. arg4_35,
                        ["TextSize"] = 9,
                        ["TextColor3"] = r104.Text,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    });
                    r144.Parent = r143;
                    r145 = r105("TextLabel", {
                        ["Size"] = UDim2.new(0, 18, 0, 28),
                        ["Position"] = UDim2.new(1, -20, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = "v",
                        ["TextSize"] = 9,
                        ["TextColor3"] = r104.SubText
                    });
                    r145.Parent = r143;
                    n = r105("TextButton", {
                        ["Size"] = UDim2.new(1, 0, 0, 28),
                        ["BackgroundTransparency"] = 1,
                        ["Text"] = ""
                    });
                    n.Parent = r143;
                    i = r105("Frame", {
                        ["Size"] = UDim2.new(1, -8, 0, #r140 * 21),
                        ["Position"] = UDim2.new(0, 4, 0, 28),
                        ["BackgroundTransparency"] = 1
                    });
                    i.Parent = r143;
                    r105("UIListLayout", {
                        ["Padding"] = UDim.new(0, 2)
                    }).Parent = i;
                    G = ")ez\xaf\x8b\x88\xd3;(\x0c\x8d\x86\xc6|\x987`";
                    L = n[actionMap[r16(G, 34448096181929)]];
                    L:Connect(function(...)
                        r123 = not r142;
                        r142 = r123;
                        r106(r143, {
                            ["Size"] = UDim2.new(1, 0, 0, r142 or 28)
                        });
                        r123 = r123;
                        r123 = r123;
                        r145.Text = r142 and "^" or "v";
                        return; 
                    end);
                    for _, m in G[1], ipairs(m) do
                        r146 = m;
                        g = r105("TextButton", {
                            ["Size"] = UDim2.new(1, 0, 0, 18),
                            ["BackgroundColor3"] = r104.Panel,
                            ["BackgroundTransparency"] = .3,
                            ["Font"] = Enum.Font.GothamBold,
                            ["Text"] = r146,
                            ["TextSize"] = 9,
                            ["TextColor3"] = r104.SubText,
                            ["AutoButtonColor"] = false
                        });
                        A = r105("Frame", {
                            ["Size"] = UDim2.new(1, -8, 0, #u[N] * 21),
                            ["Position"] = UDim2[actionMap[r16("q\x12\xf7", SW)]](0, 4, 0, 28),
                            ["BackgroundTransparency"] = 1
                        });
                        g.Parent = A;
                        r105("UICorner", {
                            ["CornerRadius"] = UDim.new(0, 3)
                        }).Parent = g;
                        g.MouseButton1Click:Connect(function(...)
                            r144.Text = r139 .. ": " .. r146;
                            r142 = false;
                            r106(r143, {
                                ["Size"] = UDim2.new(1, 0, 0, 28)
                            });
                            r145.Text = "v";
                            r141(r146);
                            return; 
                        end); 
                    end; 
                end;
                r123.CreateSlider = function(arg1_36, arg2_36, arg3_36, arg4_36, arg5_36, arg6_36, ...)
                    r147 = arg3_36;
                    arg1_31 = arg1_36;
                    r148 = arg6_36;
                    r123["_ord"] = r123["_ord"] + 1;
                    r149 = math.clamp(arg5_36, r147, arg4_36);
                    C = r105("Frame", {
                        ["LayoutOrder"] = r123._ord,
                        ["Size"] = UDim2.new(1, 0, 0, 46),
                        ["BackgroundColor3"] = r104.Element,
                        ["BackgroundTransparency"] = .2,
                        ["BorderSizePixel"] = 0
                    });
                    C.Parent = r121;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(0, 6)
                    }).Parent = C;
                    L = r105("Frame", {
                        ["Size"] = UDim2.new(1, 0, 0, 20),
                        ["BackgroundTransparency"] = 1
                    });
                    L.Parent = C;
                    r105("TextLabel", {
                        ["Size"] = UDim2.new(1, -42, 1, 0),
                        ["Position"] = UDim2.new(0, 8, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = arg2_36,
                        ["TextSize"] = 10,
                        ["TextColor3"] = r104.Text,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    }).Parent = L;
                    r150 = r105("TextLabel", {
                        ["Size"] = UDim2.new(0, 38, 1, 0),
                        ["Position"] = UDim2.new(1, -42, 0, 0),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.GothamBold,
                        ["Text"] = tostring(r149),
                        ["TextSize"] = 10,
                        ["TextColor3"] = r104.Accent,
                        ["TextXAlignment"] = Enum.TextXAlignment.Right
                    });
                    r150.Parent = L;
                    r105("TextLabel", {
                        ["Size"] = UDim2.new(0, 26, 0, 10),
                        ["Position"] = UDim2.new(0, 8, 0, 20),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.Gotham,
                        ["Text"] = tostring(r147),
                        ["TextSize"] = 8,
                        ["TextColor3"] = r104.SubText,
                        ["TextXAlignment"] = Enum.TextXAlignment.Left
                    }).Parent = C;
                    r105("TextLabel", {
                        ["Size"] = UDim2.new(0, 26, 0, 10),
                        ["Position"] = UDim2.new(1, -34, 0, 20),
                        ["BackgroundTransparency"] = 1,
                        ["Font"] = Enum.Font.Gotham,
                        ["Text"] = tostring(arg4_36),
                        ["TextSize"] = 8,
                        ["TextColor3"] = r104.SubText,
                        ["TextXAlignment"] = Enum.TextXAlignment.Right
                    }).Parent = C;
                    r151 = r105("Frame", {
                        ["Size"] = UDim2.new(1, -16, 0, 4),
                        ["Position"] = UDim2.new(0, 8, 0, 36),
                        ["BackgroundColor3"] = Color3.fromRGB(40, 40, 50),
                        ["BorderSizePixel"] = 0
                    });
                    r151.Parent = C;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(1, 0)
                    }).Parent = r151;
                    r152 = arg4_36 - r147;
                    r153 = r105("Frame", {
                        ["Size"] = UDim2.new((r149 - r147) / r152, 0, 1, 0),
                        ["BackgroundColor3"] = r104.Accent,
                        ["BorderSizePixel"] = 0
                    });
                    r153.Parent = r151;
                    r105("UICorner", {
                        ["CornerRadius"] = UDim.new(1, 0)
                    }).Parent = r153;
                    if r147 < 0 and arg4_36 > 0 then
                        r105("Frame", {
                            ["Size"] = UDim2.new(0, 2, 1, 4),
                            ["Position"] = UDim2.new((0 - r147) / r152, -1, 0, -2),
                            ["BackgroundColor3"] = Color3.fromRGB(200, 200, 200),
                            ["BackgroundTransparency"] = 0.5,
                            ["BorderSizePixel"] = 0
                        }).Parent = r151;
                    end;
                    r154 = false;
                    local function r155(arg1_37)
                        r149 = math.round(r147 + math.clamp((arg1_37.X - r151.AbsolutePosition.X) / r151.AbsoluteSize.X, 0, 1) * r152);
                        r153.Size = UDim2.new((r149 - r147) / r152, 0, 1, 0);
                        r150.Text = tostring(r149);
                        r148(r149); 
                    end;
                    r151.InputBegan:Connect(function(arg1_38, ...)
                        arg1_31 = arg1_38;
                        if p.UserInputType == Enum.UserInputType.MouseButton1 or p.UserInputType == Enum.UserInputType.Touch then
                            r154 = true;
                            r155(p.Position);
                        end;
                        return; 
                    end);
                    r151.InputEnded:Connect(function(arg1_39, ...)
                        arg1_31 = arg1_39;
                        if p.UserInputType == Enum.UserInputType.MouseButton1 or p.UserInputType == Enum.UserInputType.Touch then
                            r154 = false;
                        end;
                        return; 
                    end);
                    UserInputService.InputChanged:Connect(function(arg1_40, ...)
                        arg1_31 = arg1_40;
                        if r154 and p.UserInputType == Enum.UserInputType.MouseMovement then
                            r155(p.Position);
                        end;
                        return; 
                    end); 
                end;
                return r123; 
            end;
            return r119; 
        end;
        local v24 = v22.CreateWindow({
            ["Title"] = "Vexus Hub v2.5"
        });
        local v25 = v24:CreateTab("Dashboard");
        v25:CreateToggle("Auto Farm", function(arg1_41, ...)
            r36.AutoFarmActive = arg1_41;
            return; 
        end);
        v25:CreateToggle("Notify Patient", function(arg1_42, ...)
            r36.NotifyActive = arg1_42;
            return; 
        end);
        v25:CreateToggle("Auto Close Portal", function(arg1_43, ...)
            r36.AutoClosePortal = arg1_43;
            return; 
        end);
        v25:CreateToggle("Infinity Sanity", function(arg1_44, ...)
            r36.InfinitySanityActive = arg1_44;
            return; 
        end);
        v25:CreateSlider("Sanity Target", -200, 0, -100, function(arg1_45, ...)
            r36.SanityTarget = arg1_45;
            return; 
        end);
        v25:CreateToggle("Auto Revive (Beta)", function(arg1_46, ...)
            r36.AutoReviveActive = arg1_46;
            return; 
        end);
        v25:CreateActionButton("Take Eye Drop", "Click", function(...)
            p = r34();
            if p then
                p.CFrame = CFrame.new(vector33);
            end;
            return; 
        end);
        v25:CreateToggle("ESP NPCs & Anomaly", function(arg1_47, ...)
            r36.EspActive = arg1_47;
            if not arg1_47 then
                r93();
            end;
            return; 
        end);
        v25:CreateDropdown("Item", {
            "Ervas medicinas",
            "Kit medico",
            "Xarope",
            "Bandagens"
        }, "Ervas medicinas", function(arg1_48, ...)
            return; 
        end);
        v25:CreateActionButton("Teleport to Item", "Click", function(...)
            p = actionMap2["Ervas medicinas"];
            j = r34();
            if j then
                j.CFrame = CFrame.new(p);
            end;
            return; 
        end);
        v25:CreateDynamicDropdown("Paciente", r65, function(...)
            return auto; 
        end, function(arg1_49, ...)
            return; 
        end);
        v25:CreateActionButton("Auto Treat Patient", "Click", function(...)
            task.spawn(r68);
            return; 
        end);
        print("[VEXUS HUB v2.5]: Carregado! TV em modo DEBUG — execute Auto Treat e verifique o console F9.");
        return;
    end;
end;