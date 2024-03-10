local actions = {}

function actions.build()
    actions.list = {}

    -- Atacar com a espada
    local swordAttack = {

        description = "Atacar com a espada.",
        requirement = nil,

        execute = function (playerData, creatureData)
            -- Definir chance de sucesso
            local sucessChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local sucess = creatureData.speed < 0 or math.random() <= sucessChance

            -- Calcular dano
            local rawDamage = playerData.attack - math.random() * creatureData.defense
            local damage = math.max(1, math.ceil(rawDamage))

            -- Feedback do ataque
            if sucess then
                print()
                print(string.format("Seu ataque deu %d de dano.", damage))

                -- Aplica dano a criatura
                creatureData.health = creatureData.health - damage
            else
                print("Seu ataque falhou miseravelmente.")
            end

        end
     }

     local regenPotion = {

        description = "Usa uma poção de regeneração.",
        requirement = function (playerData)
            return playerData.potions >= 1
        end,

        execute = function (playerData)

            -- Diminuir número de poções do jogador
            playerData.potions = playerData.potions - 1

            -- Regenerar a vida do jogador
            local regenPoints = 5
            playerData.health = math.min(playerData.maxHealth, playerData.health + regenPoints)
            print()
            print(string.format("Voce se regenerou"))
            
        end




     }

     -- Populate List
     actions.list[#actions.list + 1] = swordAttack
     actions.list[#actions.list + 1] = regenPotion

end

---retorna lista de ações válidas
---@param playerData table
---@param creatureData table
---@return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}

    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions
end


return actions

