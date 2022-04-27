---------------
-- RESOURCES --
---------------

-- SERVICES
local collectionServ = game:GetService("CollectionService")
local debrisServ = game:GetService("Debris")
-- ASSETS
local missile = game:GetService("ServerStorage").Missile

----------------------------------
-- MAIN MISSLE SPAWNER FUNCTION --
----------------------------------
function setupMissleSpawner(spawner)
	spawn(function()
		while true do
			local missileClone = missile:Clone()
			missileClone.Position = spawner.Position + Vector3.new(math.random(-spawner.Size.X/2+missile.Size.X/2,spawner.Size.X/2-missile.Size.X/2),math.random(-spawner.Size.Y/2+missile.Size.Y/2,spawner.Size.Y/2-missile.Size.Y/2),math.random(-spawner.Size.Z/2+missile.Size.Z/2,spawner.Size.Z/2-missile.Size.Z/2))
			missileClone.Parent = workspace
			debrisServ:AddItem(missileClone,10)
			wait(1)
		end
	end)
end

---------------
-- MAIN CODE --
---------------

-- Setup current missle spawners
for _, spawner in ipairs(collectionServ:GetTagged("MissileSpawner")) do
	setupMissleSpawner(spawner)
end

-- Setup if any new objects are added
collectionServ:GetInstanceAddedSignal("MissileSpawner"):Connect(setupMissleSpawner)
