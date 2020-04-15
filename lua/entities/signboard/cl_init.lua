include("shared.lua")

function ENT:OnRemove()
end

surface.CreateFont ("Signboard_Font", {
	size = 30,
	weight = 600,
	antialias = false,
	shadow = true,
	font = "TargetID"})

function ENT:Draw()
	self.Entity:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	local text = self:GetNWString("Text","Text Write.")
	
	surface.SetFont("Signboard_Font")
	local TextWidth = surface.GetTextSize(text)
	
	Ang:RotateAroundAxis(Ang:Up(), 90)
	
	cam.Start3D2D(Pos + Ang:Up() * 2, Ang, 0.4)
		draw.WordBox(0, -TextWidth*0.5, -15, text, "Signboard_Font", Color(0, 0, 0, 200), Color(255,255,255,255))
	cam.End3D2D()
end

net.Receive( "Signboard_write", function( len )
	local ent = net.ReadEntity()
	if (IsValid(CustomTableMenu)  ) then return end
			local CustomTableMenu = vgui.Create( "DFrame" )
			CustomTableMenu:SetTitle( "Signboard" )
			CustomTableMenu:SetSize( 400,150 )
			CustomTableMenu:Center()	
			CustomTableMenu:SetBackgroundBlur(false)		
			CustomTableMenu:MakePopup()
		    CustomTableMenu.btnMinim:SetVisible( false )
            CustomTableMenu.btnMaxim:SetVisible( false )
            CustomTableMenu.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 180 ) ) 
			end
			
			local DLabel = vgui.Create( "DLabel", CustomTableMenu )
				DLabel:SetPos( 126, 50 )
				DLabel:SetFont("Trebuchet18")      
				DLabel:SetTextColor(Color(255,255,255,255))
				DLabel:SetText( "Signboard (Max 60 symbols)" )
				DLabel:SizeToContents(true)
				
			local TextWrite = vgui.Create( "DTextEntry", CustomTableMenu )
				TextWrite:SetPos( 70, 80 )
				TextWrite:SetSize( 275, 25 )
				TextWrite:SetText(ent:GetNWString("Text","Text Write."))

			local AcceptButton = vgui.Create("DButton", CustomTableMenu) 
				AcceptButton:SetText( "Write" ) 
				AcceptButton:SetTextColor( Color(255,255,255) )
				AcceptButton:SetPos( 130, 111 )
				AcceptButton:SetSize( 150, 30 )
				AcceptButton.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 200 ) ) 
				end

				AcceptButton.DoClick = function()
					if (string.len(TextWrite:GetText()) > 60) then return end
					local ent = LocalPlayer():GetEyeTrace().Entity
					if LocalPlayer():GetPos():Distance(ent:GetPos()) < 200  then
					RunConsoleCommand("signboard_text", "sedjkfgdjkewfuijhwer124sak", ent:EntIndex(), TextWrite:GetText())
					CustomTableMenu:Close()
			    end
		end
end )