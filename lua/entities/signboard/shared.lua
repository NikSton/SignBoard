ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName = "Signboard"
ENT.Author = "NikSton"
ENT.Category = "RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end