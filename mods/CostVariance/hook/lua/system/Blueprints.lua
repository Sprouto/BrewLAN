--------------------------------------------------------------------------------
-- Hook File: /lua/system/blueprints.lua
--------------------------------------------------------------------------------
-- Modded By: Balthazar
--------------------------------------------------------------------------------
do

local OldModBlueprints = ModBlueprints

function ModBlueprints(all_blueprints)         
    OldModBlueprints(all_blueprints)
    
    CostVariance(all_blueprints.Unit)
end

--------------------------------------------------------------------------------
-- Allowing many buildings to be buildable in/on the water
--------------------------------------------------------------------------------

function CostVariance(all_bps)
    for id, bp in all_bps do
        if bp.Economy.BuildCostEnergy and bp.Economy.BuildCostMass and bp.Economy.BuildTime and not table.find(bp.Categories, 'ECONOMIC') then
            local rand1 = math.random(50000,150000)/100000
            local rand2 = math.random(50000,150000)/100000
            local rand3 = (rand1 + rand2)/2
            
            bp.Economy.BuildCostEnergy = math.floor((bp.Economy.BuildCostEnergy or 0) * rand1)
            bp.Economy.BuildCostMass = math.floor((bp.Economy.BuildCostMass or 0) * rand2)
            bp.Economy.BuildTime = math.floor((bp.Economy.BuildTime or 0) * rand3)
            if bp.Defense.Health and bp.Defense.MaxHealth then 
                bp.Defense.Health = math.floor((bp.Defense.Health or 0) * rand2)
                bp.Defense.MaxHealth = math.floor((bp.Defense.MaxHealth or 0) * rand2) 
            end
            if bp.Defense.Shield.ShieldMaxHealth then
                bp.Defense.Shield.ShieldMaxHealth = math.floor((bp.Defense.Shield.ShieldMaxHealth or 0) * rand2)            
            end
            if bp.Physics.MaxSpeed then
                bp.Physics.MaxSpeed = math.floor((bp.Physics.MaxSpeed or 0) * rand1)
            end
            if bp.Weapon then
                for i, weapon in bp.Weapon do
                    if weapon.MaxRadius then
                        bp.Weapon[i].MaxRadius = math.floor((bp.Weapon[i].MaxRadius or 0) * rand1)
                    end
                end
            end
        end
    end
end
    
end