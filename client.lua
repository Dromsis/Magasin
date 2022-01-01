ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RMenu.Add("magasin", "main", RageUI.CreateMenu("Carrefour","Bienvenue"))
RMenu.Add("magasin", "apple", RageUI.CreateMenu("APPLE","pret à perdre un max d'argent"))
RMenu.Add('magasin', 'payer', RageUI.CreateSubMenu(RMenu:Get('magasin', 'main'), "Nouritures", "Rayon nouriture"))
-----------sous menu---------------
RMenu.Add('magasin', 'bouf', RageUI.CreateSubMenu(RMenu:Get('magasin', 'main'), "Nouritures", "Rayon nouriture"))
RMenu.Add('magasin', 'eau', RageUI.CreateSubMenu(RMenu:Get('magasin', 'main'), "Boisson", "Rayon boisson"))
------------fin sous menu-----------
RMenu:Get("magasin", "main").Closed = function()end
RMenu:Get("magasin", "apple").Closed = function()end

Citizen.CreateThread(function()

    while true do 
    
        Citizen.Wait(1)

        RageUI.IsVisible(RMenu:Get("magasin","apple"),true,true,true,function()
            
            RageUI.ButtonWithStyle("IPHONE 13", nil, {RightLabel = "~b~250€"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local prixuni = 250
                    local item = 'bread'
                    local quant = 1
                    montant = tonumber(quant)
                    if not montant then
                        RageUI.Popup({message = "Quantité invalide"})
                    else   
                        selectprix = prixuni
                        selectitem = item
                        selectquant = quant
                    end
                end
            end,RMenu:Get('magasin', 'payer'))

        end)

        RageUI.IsVisible(RMenu:Get("magasin","main"),true,true,true,function()

            RageUI.ButtonWithStyle("Nouritures", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('magasin', 'bouf'))

            RageUI.ButtonWithStyle("Boisson", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('magasin', 'eau'))

        end)


        RageUI.IsVisible(RMenu:Get("magasin","bouf"),true,true,true,function()

            RageUI.ButtonWithStyle("Pain", nil, {RightLabel = "~b~15€"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local prixuni = 15
                    local item = 'bread'
                    local quant = KeyboardInput('Quantité', '', 2)
                    montant = tonumber(quant)
                    if not montant then
                        RageUI.Popup({message = "Quantité invalide"})
                    else   
                        selectprix = prixuni*quant
                        selectitem = item
                        selectquant = quant
                    end
                end
            end,RMenu:Get('magasin', 'payer'))
 
        end)

        ---------------pas touche !!!!!!!!!!!!!!!!!!!--------------
        RageUI.IsVisible(RMenu:Get("magasin","payer"),true,true,true,function()

            RageUI.ButtonWithStyle("Espéce", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local prx = selectprix
                    local itm = selectitem
                    local qtn = selectquant
                    TriggerServerEvent("dromsis:vente",prx,itm,qtn,1)
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("CB", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local prx = selectprix
                    local itm = selectitem
                    local qtn = selectquant
                    if Config.EnableCard then
                        ESX.TriggerServerCallback('carte', function(data)
                            if data then
                                TriggerServerEvent("dromsis:vente",prx,itm,qtn,2)
                                RageUI.CloseAll()
                            else
                                ESX.ShowNotification('Vous n\'avez pas de carte bancaire!')
                            end
                        end)
                    else
                        TriggerServerEvent("dromsis:vente",prx,itm,qtn,2)
                        RageUI.CloseAll()
                    end
                end
            end)
            --------------- fin de pas toucher------------------------

        end)
    end

end)



---------------pas toucher apres ca --------------------

RegisterNetEvent("magasin:bipbip")
AddEventHandler("magasin:bipbip", function()
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    Citizen.Wait(350)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    Citizen.Wait(350)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    Citizen.Wait(350)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    Citizen.Wait(350)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Config.Apple) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local distApple = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Apple[k].x, Config.Apple[k].y, Config.Apple[k].z)

            if distApple <= 1.0 then
                RageUI.Text({message = "~b~[E]~s~ | Parler à un vendeur",time_display = 1})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('magasin', 'apple'), true)
                end
            end
        end

        for k in pairs(Config.position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.position[k].x, Config.position[k].y, Config.position[k].z)
            

            if dist <= 1.0 then
                RageUI.Text({message = "~b~[E]~s~ | Acceder au magasin",time_display = 1})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('magasin', 'main'), true)
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    for _, pos in pairs(Config.blips) do
        pos.blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(pos.blip, 59)
        SetBlipDisplay(pos.blip, 2)
        SetBlipScale(pos.blip, 0.6)
        SetBlipColour(pos.blip, pos.colour)
        SetBlipAsShortRange(pos.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(pos.title)
        EndTextCommandSetBlipName(pos.blip)
    end
end)
---------------------------

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end  
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end