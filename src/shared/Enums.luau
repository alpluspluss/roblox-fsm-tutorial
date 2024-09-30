local stateId: number = 0
-- Macros for adding enum dynamically
local function ADD_ENUM(): number
	stateId += 1
	return stateId
end

return {
	StateMachine = {
		Idle = ADD_ENUM(),
		Attacking = ADD_ENUM(),
		Stunned = ADD_ENUM(),
		Blocking = ADD_ENUM()
	}
}