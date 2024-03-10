--[[


    O que você vai fazer?
    1. Atacar com a espada.
    2. Usar poção de regeneração.
    3. Atirar uma pedra.
    4. Se esconder.
    > 2

]]


--Dependências
local player = require("player.player")
local colossus = require("colossus.colossus")
local utils = require("utils")
local playerActions = require("player.actions")
local colossusActions = require("colossus.actions")


local boss = colossus
local bossActions = colossusActions



-- Habilita o UTF8
utils.enableUTF8()

-- Imprime o cabeçalho
utils.printHeader()

-- Imprime as informações da Criatura
utils.printCreature(boss)

-- Player build
playerActions.build()
colossusActions.build()

-- Loop do simulador de batalha

while true do
    
-- Ofecere as ações para o jogador escolher
    print()
    print("Qual sua ação?")
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
        
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil


-- Simula o turno de ação do jogador.
if isActionValid then
    chosenAction.execute(player, boss)
else
    print("Ação inválida, você perdeu seu turno.")
end




-- POnto de sáida, Criatura fica sem vida
    if colossus.health <= 0 then
        break
    end

-- Simula o turno de ação da criatura
print()
local bossValidActions = bossActions.getValidActions(player, boss)
local bossAction = bossValidActions[math.random(#bossValidActions)]
bossAction.execute(player, boss)

-- Feedback dos Lifes Atuais do Boss e Player
print()
utils.printActualLifes(player, boss)



-- Ponto de saída, jogador fica sem vida
    if player.health <= 0 then
        break
    end


end

-- Processar condiçõies de vitória e derrota
if player.health <= 0 then
    print()
    print()
    print("-----------------------------------------------------------------------")
    print()
    print(string.format("%s bateu as botas, %s saiu vitorioso. 😱😱", player.name, boss.name))
    print()
    print("-----------------------------------------------------------------------")
    print()
end

if boss.health <= 0 then
    print()
    print()
    print("-----------------------------------------------------------------------")
    print()
    print(string.format("%s bateu as botas, %s saiu vitorioso. 🤩🤩", boss.name, player.name))
    print()
    print("-----------------------------------------------------------------------")
    print()
end
