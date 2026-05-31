-- ==================== I7RB ====================
-- احصل على كودك: https://874263e1-4717-47da-906d-f696bb11d1ad-00-29rw4kg1em9sw.sisko.replit.dev/get

local HS = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function showError(msg)
    local g = Instance.new("ScreenGui"); g.Name="I7RBDeny"; g.ResetOnSpawn=false; g.Parent=game.CoreGui
    local f = Instance.new("Frame",g); f.Size=UDim2.new(0,300,0,65); f.Position=UDim2.new(0.5,-150,0.5,-32)
    f.BackgroundColor3=Color3.fromRGB(20,0,0); Instance.new("UICorner",f).CornerRadius=UDim.new(0,9)
    local t = Instance.new("TextLabel",f); t.Size=UDim2.new(1,0,1,0); t.Text="⚡ I7RB — "..msg
    t.TextColor3=Color3.fromRGB(255,80,80); t.BackgroundTransparency=1
    t.Font=Enum.Font.GothamBold; t.TextScaled=true
    task.delay(4,function() g:Destroy() end)
end

local reqFunc = syn and syn.request
             or (typeof(http_request)=="function" and http_request)
             or (http and http.request)
             or (typeof(request)=="function" and request)
             or fluxus_request
             or nil

if not reqFunc then showError("الإكسبلويت ما يدعم HTTP"); return end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name="I7RBKey"; KeyGui.ResetOnSpawn=false
KeyGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; KeyGui.Parent=game.CoreGui

local BG = Instance.new("Frame", KeyGui)
BG.Size=UDim2.new(0,320,0,160); BG.Position=UDim2.new(0.5,-160,0.5,-80)
BG.BackgroundColor3=Color3.fromRGB(15,15,15); BG.BorderSizePixel=0
Instance.new("UICorner",BG).CornerRadius=UDim.new(0,10)
local Stroke=Instance.new("UIStroke",BG)
Stroke.Color=Color3.fromRGB(0,200,100); Stroke.Thickness=1.5

local TitleLbl=Instance.new("TextLabel",BG)
TitleLbl.Size=UDim2.new(1,0,0,36); TitleLbl.Position=UDim2.new(0,0,0,0)
TitleLbl.Text="⚡ I7RB — أدخل الكود"
TitleLbl.TextColor3=Color3.fromRGB(0,220,110); TitleLbl.BackgroundTransparency=1
TitleLbl.Font=Enum.Font.GothamBold; TitleLbl.TextScaled=true

local SubLbl=Instance.new("TextLabel",BG)
SubLbl.Size=UDim2.new(1,-20,0,18); SubLbl.Position=UDim2.new(0,10,0,36)
SubLbl.Text="https://874263e1-4717-47da-906d-f696bb11d1ad-00-29rw4kg1em9sw.sisko.replit.dev/get"
SubLbl.TextColor3=Color3.fromRGB(100,100,100); SubLbl.BackgroundTransparency=1
SubLbl.Font=Enum.Font.Gotham; SubLbl.TextSize=11

local Box=Instance.new("TextBox",BG)
Box.Size=UDim2.new(1,-20,0,34); Box.Position=UDim2.new(0,10,0,60)
Box.PlaceholderText="الكود هنا..."; Box.Text=""
Box.TextColor3=Color3.fromRGB(255,255,255)
Box.PlaceholderColor3=Color3.fromRGB(100,100,100)
Box.BackgroundColor3=Color3.fromRGB(28,28,28); Box.BorderSizePixel=0
Box.Font=Enum.Font.GothamBold; Box.TextScaled=true; Box.ClearTextOnFocus=false
Instance.new("UICorner",Box).CornerRadius=UDim.new(0,6)

local RunBtn=Instance.new("TextButton",BG)
RunBtn.Size=UDim2.new(1,-20,0,36); RunBtn.Position=UDim2.new(0,10,0,104)
RunBtn.Text="تشغيل ✓"
RunBtn.TextColor3=Color3.fromRGB(0,0,0); RunBtn.BackgroundColor3=Color3.fromRGB(0,210,100)
RunBtn.Font=Enum.Font.GothamBold; RunBtn.TextScaled=true; RunBtn.BorderSizePixel=0
Instance.new("UICorner",RunBtn).CornerRadius=UDim.new(0,6)

local function validateAndRun()
    local KEY = Box.Text:gsub("%s+","")
    if KEY=="" then SubLbl.Text="❌ أدخل الكود أولاً"; SubLbl.TextColor3=Color3.fromRGB(255,80,80); return end
    RunBtn.Text="جاري التحقق..."; RunBtn.Active=false
    SubLbl.Text="يتصل بالسيرفر..."; SubLbl.TextColor3=Color3.fromRGB(180,180,180)
    local ok,res=pcall(reqFunc,{Url="https://874263e1-4717-47da-906d-f696bb11d1ad-00-29rw4kg1em9sw.sisko.replit.dev/api/validate?key="..KEY,Method="GET"})
    if not ok or not res or not res.Body then
        SubLbl.Text="❌ تعذّر الاتصال"; SubLbl.TextColor3=Color3.fromRGB(255,80,80)
        RunBtn.Text="تشغيل ✓"; RunBtn.Active=true; return
    end
    local dc,dt=pcall(function() return HS:JSONDecode(res.Body) end)
    if not dc then
        SubLbl.Text="❌ خطأ في الاستجابة"; SubLbl.TextColor3=Color3.fromRGB(255,80,80)
        RunBtn.Text="تشغيل ✓"; RunBtn.Active=true; return
    end
    if type(dt)~="table" or not dt.valid then
        SubLbl.Text=(type(dt)=="table" and dt.reason=="expired") and "❌ الكود انتهى — جدد من الموقع" or "❌ كود غير صحيح ✗"
        SubLbl.TextColor3=Color3.fromRGB(255,80,80)
        RunBtn.Text="تشغيل ✓"; RunBtn.Active=true; return
    end
    KeyGui:Destroy(); runMainScript()
end
RunBtn.MouseButton1Click:Connect(validateAndRun)

function runMainScript()
    repeat task.wait() until game:IsLoaded() and Players.LocalPlayer
    local LP=Players.LocalPlayer; local Cam=workspace.CurrentCamera
    getgenv().Lock={Enabled=false,FOV=150,ShowFOV=true,WallCheck=false,ESP=true,NPCesp=false,ShowDist=true,ShowHP=true,TeamColor=true,AimPart="Head",TeamCheck=false,Key=Enum.KeyCode.CapsLock}
    local S=getgenv().Lock; local Target=nil; local ESPs={}; local NPCESPs={}
    for _,v in pairs(game.CoreGui:GetChildren()) do if v.Name=="I7RBGUI" then v:Destroy() end end
    local FOVcircle=Drawing.new("Circle"); FOVcircle.Visible=S.ShowFOV; FOVcircle.Radius=S.FOV; FOVcircle.Filled=false; FOVcircle.Color=Color3.fromRGB(255,255,255); FOVcircle.Thickness=1.5; FOVcircle.Transparency=0.7
    local GUI=Instance.new("ScreenGui"); GUI.Name="I7RBGUI"; GUI.ResetOnSpawn=false; GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; GUI.Parent=game.CoreGui
    local Main=Instance.new("Frame",GUI); Main.Size=UDim2.new(0,195,0,290); Main.Position=UDim2.new(0,10,0,80); Main.BackgroundColor3=Color3.fromRGB(18,18,18); Main.BorderSizePixel=0; Instance.new("UICorner",Main).CornerRadius=UDim.new(0,8)
    local Title=Instance.new("TextLabel",Main); Title.Size=UDim2.new(1,0,0,26); Title.Position=UDim2.new(0,0,0,2); Title.Text="⚡ I7RB"; Title.TextScaled=true; Title.TextColor3=Color3.fromRGB(200,200,255); Title.BackgroundTransparency=1; Title.Font=Enum.Font.GothamBold
    local yPos=32
    local function btn(txt,func) local b=Instance.new("TextButton",Main); b.Size=UDim2.new(1,-10,0,26); b.Position=UDim2.new(0,5,0,yPos); b.Text=txt; b.TextScaled=true; b.TextColor3=Color3.new(1,1,1); b.BackgroundColor3=Color3.fromRGB(38,38,52); b.Font=Enum.Font.Gotham; Instance.new("UICorner",b).CornerRadius=UDim.new(0,5); b.MouseButton1Click:Connect(func); yPos=yPos+30; return b end
    local LockB=btn("Lock: OFF [CapsLock]",function() S.Enabled=not S.Enabled; LockB.Text="Lock: "..(S.Enabled and "ON ✔" or "OFF").." [CapsLock]"; if not S.Enabled then Target=nil end end)
    local WallB=btn("WallCheck: OFF",function() S.WallCheck=not S.WallCheck; WallB.Text="WallCheck: "..(S.WallCheck and "ON" or "OFF") end)
    local ESPB=btn("Player ESP: ON",function() S.ESP=not S.ESP; ESPB.Text="Player ESP: "..(S.ESP and "ON" or "OFF") end)
    local NPCB=btn("NPC ESP: OFF",function() S.NPCesp=not S.NPCesp; NPCB.Text="NPC ESP: "..(S.NPCesp and "ON" or "OFF") end)
    local DistB=btn("Distance: ON",function() S.ShowDist=not S.ShowDist; DistB.Text="Distance: "..(S.ShowDist and "ON" or "OFF") end)
    local HPB=btn("HP Bar: ON",function() S.ShowHP=not S.ShowHP; HPB.Text="HP Bar: "..(S.ShowHP and "ON" or "OFF") end)
    btn("Hide [RShift / Insert]",function() Main.Visible=not Main.Visible end)
    local function CanSee(char) if not S.WallCheck then return true end; local part=char:FindFirstChild(S.AimPart) or char:FindFirstChild("HumanoidRootPart"); if not part then return false end; local p=RaycastParams.new(); p.FilterDescendantsInstances={LP.Character,char}; p.FilterType=Enum.RaycastFilterType.Exclude; local r=workspace:Raycast(Cam.CFrame.Position,part.Position-Cam.CFrame.Position,p); return r==nil or r.Instance:IsDescendantOf(char) end
    local function GetClosest() local closest,bestDist=nil,S.FOV; local center=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2); for _,plr in pairs(Players:GetPlayers()) do if plr==LP or not plr.Character then continue end; local hum=plr.Character:FindFirstChildOfClass("Humanoid"); local part=plr.Character:FindFirstChild(S.AimPart); if not hum or hum.Health<=0 or not part then continue end; if S.TeamCheck and LP.Team and plr.Team==LP.Team then continue end; local pos,onScreen=Cam:WorldToViewportPoint(part.Position); if not onScreen then continue end; local mag=(Vector2.new(pos.X,pos.Y)-center).Magnitude; if mag<bestDist and CanSee(plr.Character) then bestDist=mag; closest=plr end end; return closest end
    local function MakeDrawings() local box=Drawing.new("Square"); box.Visible=false; box.Filled=false; box.Thickness=1.5; local outline=Drawing.new("Square"); outline.Visible=false; outline.Filled=false; outline.Thickness=3; outline.Color=Color3.fromRGB(0,0,0); outline.Transparency=0.5; local nameTxt=Drawing.new("Text"); nameTxt.Visible=false; nameTxt.Color=Color3.fromRGB(255,255,255); nameTxt.Size=13; nameTxt.Center=true; nameTxt.Outline=true; local toolTxt=Drawing.new("Text"); toolTxt.Visible=false; toolTxt.Color=Color3.fromRGB(255,220,0); toolTxt.Size=12; toolTxt.Center=true; toolTxt.Outline=true; local distTxt=Drawing.new("Text"); distTxt.Visible=false; distTxt.Color=Color3.fromRGB(160,255,160); distTxt.Size=11; distTxt.Center=true; distTxt.Outline=true; local hpBg=Drawing.new("Square"); hpBg.Visible=false; hpBg.Filled=true; hpBg.Color=Color3.fromRGB(50,0,0); local hpBar=Drawing.new("Square"); hpBar.Visible=false; hpBar.Filled=true; hpBar.Color=Color3.fromRGB(0,220,80); return {box=box,outline=outline,name=nameTxt,tool=toolTxt,dist=distTxt,hpBg=hpBg,hpBar=hpBar} end
    local function HideAll(d) d.box.Visible=false; d.outline.Visible=false; d.name.Visible=false; d.tool.Visible=false; d.dist.Visible=false; d.hpBg.Visible=false; d.hpBar.Visible=false end
    local function RemoveAll(d) d.box:Remove(); d.outline:Remove(); d.name:Remove(); d.tool:Remove(); d.dist:Remove(); d.hpBg:Remove(); d.hpBar:Remove() end
    local function NewESP(plr) if plr==LP or ESPs[plr] then return end; ESPs[plr]=MakeDrawings() end
    for _,v in pairs(Players:GetPlayers()) do NewESP(v) end
    Players.PlayerAdded:Connect(NewESP)
    Players.PlayerRemoving:Connect(function(v) if ESPs[v] then RemoveAll(ESPs[v]); ESPs[v]=nil end end)
    local function ScanNPCs() for model,data in pairs(NPCESPs) do if not model or not model.Parent then RemoveAll(data); NPCESPs[model]=nil end end; if not S.NPCesp then return end; for _,obj in pairs(workspace:GetDescendants()) do if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) and obj~=LP.Character and not NPCESPs[obj] then local hum=obj:FindFirstChildOfClass("Humanoid"); local hrp=obj:FindFirstChild("HumanoidRootPart"); if hum and hrp then NPCESPs[obj]=MakeDrawings() end end end end
    local function UpdateESP(d,char,label,isPlayer,plr) local hum=char:FindFirstChildOfClass("Humanoid"); local hrp=char:FindFirstChild("HumanoidRootPart"); if not hum or hum.Health<=0 or not hrp then HideAll(d); return end; local pos,vis=Cam:WorldToViewportPoint(hrp.Position); if not vis then HideAll(d); return end; local head=char:FindFirstChild("Head") or hrp; local topP=Cam:WorldToViewportPoint(head.Position+Vector3.new(0,0.7,0)); local botP=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3.2,0)); local h=math.abs(topP.Y-botP.Y); local w=h*0.55; local bx=pos.X-w/2; local by=topP.Y; local col; if not isPlayer then col=Color3.fromRGB(255,165,0) elseif S.TeamColor and LP.Team and plr and plr.Team==LP.Team then col=Color3.fromRGB(0,210,100) else col=Color3.fromRGB(255,50,50) end; d.outline.Visible=true; d.outline.Size=Vector2.new(w+3,h+3); d.outline.Position=Vector2.new(bx-1.5,by-1.5); d.box.Visible=true; d.box.Color=col; d.box.Size=Vector2.new(w,h); d.box.Position=Vector2.new(bx,by); local hpPct=math.clamp(hum.Health/hum.MaxHealth,0,1); d.name.Visible=true; d.name.Position=Vector2.new(pos.X,by-15); d.name.Text=label.." ["..math.floor(hum.Health).."/"..math.floor(hum.MaxHealth).."]"; if S.ShowDist and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then local dist=math.floor((hrp.Position-LP.Character.HumanoidRootPart.Position).Magnitude); d.dist.Visible=true; d.dist.Position=Vector2.new(pos.X,by+h+4); d.dist.Text=dist.." m" else d.dist.Visible=false end; if isPlayer then local items={}; for _,v in pairs(char:GetChildren()) do if v:IsA("Tool") then table.insert(items,"▶"..v.Name) end end; local plrObj=Players:GetPlayerFromCharacter(char); if plrObj then local bp=plrObj:FindFirstChildOfClass("Backpack"); if bp then for _,v in pairs(bp:GetChildren()) do if v:IsA("Tool") then table.insert(items,v.Name) end end end end; if #items>0 then d.tool.Visible=true; d.tool.Position=Vector2.new(pos.X,by+h+(S.ShowDist and 16 or 4)); d.tool.Text=table.concat(items," | ") else d.tool.Visible=false end else d.tool.Visible=false end; if S.ShowHP then local barH=h*hpPct; local barX=bx-7; d.hpBg.Visible=true; d.hpBg.Size=Vector2.new(4,h); d.hpBg.Position=Vector2.new(barX,by); d.hpBar.Color=hpPct>0.6 and Color3.fromRGB(0,220,80) or hpPct>0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,50,50); d.hpBar.Visible=true; d.hpBar.Size=Vector2.new(4,math.max(barH,1)); d.hpBar.Position=Vector2.new(barX,by+(h-barH)) else d.hpBg.Visible=false; d.hpBar.Visible=false end end
    RunService.RenderStepped:Connect(function() FOVcircle.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2); FOVcircle.Radius=S.FOV; FOVcircle.Visible=S.ShowFOV; if not S.Enabled then return end; if not Target or not Target.Character or not Target.Character:FindFirstChildOfClass("Humanoid") or Target.Character.Humanoid.Health<=0 then Target=GetClosest() end; if Target and Target.Character then local part=Target.Character:FindFirstChild(S.AimPart); if part then Cam.CFrame=CFrame.new(Cam.CFrame.Position,part.Position) end end end)
    task.spawn(function() while true do task.wait(0.05); for plr,d in pairs(ESPs) do if S.ESP and plr.Character then UpdateESP(d,plr.Character,plr.DisplayName,true,plr) else HideAll(d) end end; for model,d in pairs(NPCESPs) do if S.NPCesp and model and model.Parent then UpdateESP(d,model,model.Name,false,nil) elseif d then HideAll(d) end end end end)
    task.spawn(function() while true do task.wait(5); ScanNPCs() end end)
    UserInputService.InputBegan:Connect(function(inp,gpe) if gpe then return end; if inp.KeyCode==S.Key then S.Enabled=not S.Enabled; LockB.Text="Lock: "..(S.Enabled and "ON ✔" or "OFF").." [CapsLock]"; if not S.Enabled then Target=nil end end; if inp.KeyCode==Enum.KeyCode.Insert or inp.KeyCode==Enum.KeyCode.RightShift then Main.Visible=not Main.Visible end end)
    ScanNPCs()
end