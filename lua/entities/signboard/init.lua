AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("Signboard_write")

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetModelScale(0.7)
	self:SetFlexScale(0.2)
	self:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNWString("Text","Text Write.")
	self:CPPISetOwner(self:Getowning_ent()) 
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles(Angle(0,ply:EyeAngles().y,0))
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use (act, caller, useType, integ)
	local owner = self:Getowning_ent()
	if (!IsValid(owner) and owner != caller) then return end
	if (owner != caller) then return end
	local ent = caller:GetEyeTrace().Entity
	if (!IsValid(ent)) then return end
	if caller:GetPos():Distance(self:GetPos()) < 200  then
        net.Start( "Signboard_write" )
          net.WriteEntity(self)
        net.Send(caller)
	end
end

concommand.Add("signboard_text", function (ply, cmd, args)
	if (args[1] != "sedjkfgdjkewfuijhwer124sak") then return end
	local ent = ents.GetByIndex(args[2])
	ent:SetNWString("Text",args[3])
end)

function ENT:CanTool (ply, tr, tool)
	if ( tool == "remover" and IsValid( tr.Entity ) and ply == tr.Entity:Getowning_ent()) then
    	return true
   	end
end
 
function ENT:PhysgunPickup (ply, tr, tool)
	if (IsValid( tr.Entity ) and ply == tr.Entity:Getowning_ent()) then
    	return true
   	end
end