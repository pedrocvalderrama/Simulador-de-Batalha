local actions = {}

function actions.build()
    actions.list = {}

    -- Atacar com pisão
    local stompAttack = {

        description = "Atacar com pisão.",
        requirement = nil,

        execute = function (playerData, creatureData)
            -- Definir chance de sucesso
            local sucessChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed
            local sucess = playerData.speed < 0 or math.random() <= sucessChance

            -- Calcular dano
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage - 0.5))

            -- Feedback do ataque
            if sucess then
                print()
                print(string.format("%s usou pisão e causou %d de dano.", creatureData.name, damage))

                -- Aplica dano a criatura
                playerData.health = playerData.health - damage
            else
                print(string.format("%s errou o ataque.", creatureData.name))
            end

        end
     }

    -- Atacar com olhos brilhantes
    local eyeAttack = {

        description = "Atacar raio de luz de seus olhos.",
        requirement = nil,

        execute = function (playerData, creatureData)
            -- Definir chance de sucesso
            local sucessChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed + 3
            local sucess = playerData.speed < 0 or math.random() <= sucessChance

            -- Calcular dano
            local rawDamage = creatureData.attack - math.random() * playerData.defense - 1
            local damage = math.max(1, math.ceil(rawDamage - 0.5))

            -- Feedback do ataque
            if sucess then
                print()
                print(string.format("%s usou raio de luz e causou %d de dano.", creatureData.name, damage))

                -- Aplica dano a criatura
                playerData.health = playerData.health - damage
            else
                print(string.format("%s errou o ataque.", creatureData.name))
            end

        end
     }

    -- Descansar
    local rest = {

        description = "Descansar.",
        requirement = nil,

        execute = function (playerData, creatureData)

                print(string.format("%s Descansou.", creatureData.name))
            

        end
     }







     

     -- Populate List
     actions.list[#actions.list + 1] = rest
     actions.list[#actions.list + 1] = eyeAttack
     actions.list[#actions.list + 1] = stompAttack

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

