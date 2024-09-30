--!optimize 2
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Shared = ReplicatedStorage:WaitForChild("Shared")

local Enums = require(Shared:WaitForChild("Enums"))
local StateMachine = require(script:WaitForChild("StateMachine"))

local Machine = StateMachine.new(Enums.StateMachine.Idle, {
    [Enums.StateMachine.Idle] = {
        [Enums.StateMachine.Attacking] = true,
        [Enums.StateMachine.Blocking] = true,
        [Enums.StateMachine.Stunned] = true
    },
    [Enums.StateMachine.Blocking] = {
        [Enums.StateMachine.Idle] = true,
        [Enums.StateMachine.Stunned] = true
    },
    [Enums.StateMachine.Attacking] = {
        [Enums.StateMachine.Idle] = true,
        [Enums.StateMachine.Stunned] = true
    },
    [Enums.StateMachine.Stunned] = {
        [Enums.StateMachine.Idle] = true
    }
})

local function HandleAttack(): ()
    if Machine:Transition(Enums.StateMachine.Attacking) then
        print("Slash")
        --[[
            Example:

            Remote:Fire({ state = Enums.StateMachine.Attacking })
        ]]
    end
end

local function HandleBlock(): ()
    if Machine:Transition(Enums.StateMachine.Blocking) then
        print("Block")
        --[[
            Example:

            Remote:Fire({ state = Enums.StateMachine.Blocking })
        ]]
    end
end

UserInputService.InputBegan:Connect(function(input: InputObject, gPE: boolean)
    if gPE then 
        return 
    end

    if Machine:GetState() == Enums.StateMachine.Idle then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            HandleAttack()

        elseif input.KeyCode == Enum.KeyCode.F then
            HandleBlock()
        end
    end
end)

UserInputService.InputEnded:Connect(function(input: InputObject, gPE: boolean)
    if gPE then 
        return
    end

    -- I know this is kind of unacceptable for some people, but it have little to none performance impact.
    -- You might want to refactor this part because there will be so many combinations of states thus it's
    -- going to get a little more messy
    if input.KeyCode == Enum.KeyCode.F and Machine:GetState() == Enums.StateMachine.Blocking then
        Machine:Transition(Enums.StateMachine.Idle)
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 and Machine:GetState() == Enums.StateMachine.Attacking then
        Machine:Transition(Enums.StateMachine.Idle)
    end
end)

-- Suppose this is a remote that will listen to data packets if
-- the server deems you stunned
ReplicatedStorage.StatePacket.OnClientEvent:Connect(function(): ()
    Machine:Transition(Enums.StateMachine.Stunned)
    print("You are stunned!!111!!!")
end)
