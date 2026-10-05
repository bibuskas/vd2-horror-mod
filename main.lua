return function()
    local Players = game:GetService("Players")

    local ALLOWED = {
        ["Unarmed"] = true,
        ["Sledge"] = true,
        ["Pistol"] = true,
        ["Explosive Charge"] = true,
        ["Detonator"] = true,
        ["Plank"] = true,
        ["Lantern"] = true,
        ["Flashlight"] = true
    }

    local function purge(container)
        if not container then return end
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and not ALLOWED[item.Name] then
                item:Destroy()
            end
        end
    end

    local function enforceLoadout(player)
        task.spawn(function()
            while player and player.Parent do
                if player.Character then purge(player.Character) end
                local backpack = player:FindFirstChild("Backpack")
                if backpack then purge(backpack) end
                task.wait(0.5)
            end
        end)
    end

    Players.PlayerAdded:Connect(enforceLoadout)
    for _, p in ipairs(Players:GetPlayers()) do
        enforceLoadout(p)
    end
end
