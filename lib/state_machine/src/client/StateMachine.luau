--!optimize 2
--!strict

local StateMachine = {}
StateMachine.__index = StateMachine

type TransitionSet = { [number]: { [number]: true } }
export type Machine = typeof(setmetatable({
    _currentState = 0,
    _set = { [1] = { [2] = true }, [2] = { [3] =  true }, [3] = { [1] = true } } :: TransitionSet
}, StateMachine))

function StateMachine.new(state: number, set: TransitionSet): Machine
    local self = setmetatable({}, StateMachine)
    self._currentState = state
    self._set = set
    return self
end

function StateMachine.__CanTransition(self: Machine, toState: number): boolean
    local transitions = self._set[self._currentState]
    return transitions and transitions[toState] == true or false
end

function StateMachine.Transition(self: Machine, toState: number)
    if self:__CanTransition(toState) then
        self._currentState = toState
        return true
    else
        warn("Invalid state transition from", self._currentState, "to", toState)
        return false
    end
end

function StateMachine.GetState(self: Machine): number
    return self._currentState
end

return StateMachine
