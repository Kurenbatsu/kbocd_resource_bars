local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:RegisterEvent("PLAYER_LOGIN")
addonLoadedFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
addonLoadedFrame:RegisterEvent("UNIT_DISPLAYPOWER")
addonLoadedFrame:RegisterUnitEvent("UNIT_HEALTH", "target")
addonLoadedFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

addonLoadedFrame:SetScript("OnEvent", function(_, event, eventValue)
    if event == "ADDON_LOADED" and eventValue == "KBOCDResourceBars" then
        KBOCDResourceBars.InitializeUserValues()

    elseif event == "PLAYER_LOGIN" then
        KBOCDResourceBars.CreateHealthBar()
        KBOCDResourceBars.CreatePrimaryResourceBar()
        KBOCDResourceBars.CreateAdditionalResourceBar()
        KBOCDResourceBars.playerUnitFrameHealthText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 55)
        KBOCDResourceBars.playerUnitFramePrimaryResourceText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 38.5)
        KBOCDResourceBars.playerUnitFrameAdditionalResourceText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 26.5)
        KBOCDResourceBars.targetUnitFrameHealthText = KBOCDResourceBars.CreateTargetUnitFrameText(TargetFrame, "", -25, 55)

    elseif event == "PLAYER_ENTERING_WORLD" and not KBOCDResourceBars.initialEnteringWorldCompleted then
        KBOCDResourceBars.Update(KBOCDResourceBars.healthBarGlobal, KBOCDResourceBarsDB.healthBar, KBOCDResourceBars.healthBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.health)
        KBOCDResourceBars.Update(KBOCDResourceBars.primaryResourceBarGlobal, KBOCDResourceBarsDB.primaryResourceBar, KBOCDResourceBars.primaryResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.Update(KBOCDResourceBars.additionalResourceBarGlobal, KBOCDResourceBarsDB.additionalResourceBar, KBOCDResourceBars.additionalResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.UpdateVisibility(KBOCDResourceBars.healthBarFrameGlobal, KBOCDResourceBarsDB.healthBar)
        KBOCDResourceBars.UpdateVisibility(KBOCDResourceBars.primaryResourceBarFrameGlobal, KBOCDResourceBarsDB.primaryResourceBar)
        KBOCDResourceBars.UpdateVisibility(KBOCDResourceBars.additionalResourceBarFrameGlobal, KBOCDResourceBarsDB.additionalResourceBar)

        KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageNextToPlayerFrame")
        KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFramePrimaryResourceText, KBOCDResourceBarsDB, "displayPrimaryResourcePercentageNextToPlayerFrame")
        KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameAdditionalResourceText, KBOCDResourceBarsDB, "displayAdditionalResourcePercentageNextToPlayerFrame")
        KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.targetUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageOverTargetFrame")
        if KBOCDResourceBarsDB.displayHealthPercentageOverTargetFrame then
            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(0)
        else
            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(1)
        end

        KBOCDResourceBars.screenWidth = UIParent:GetWidth()
        KBOCDResourceBars.screenHeight = UIParent:GetHeight()
        KBOCDResourceBars.CreateOptionsHierarchyAndTopLevelPane()
        KBOCDResourceBars.layoutHealthOptionsPane()
        KBOCDResourceBars.layoutPrimaryResourceOptionsPane()
        KBOCDResourceBars.layoutAdditionalResourceOptionsPane()
        KBOCDResourceBars.layoutExtrasOptionsPane()

        -- DEFAULT_CHAT_FRAME:AddMessage("|cfff2e147KBOCDResourceBars |cffa19d78loaded.|r")

        KBOCDResourceBars.initialEnteringWorldCompleted = true

    elseif event == "UNIT_DISPLAYPOWER" then
        if eventValue and eventValue ~= "player" then return end
        KBOCDResourceBars.Update(KBOCDResourceBars.primaryResourceBarGlobal, KBOCDResourceBarsDB.primaryResourceBar, KBOCDResourceBars.primaryResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.Update(KBOCDResourceBars.additionalResourceBarGlobal, KBOCDResourceBarsDB.additionalResourceBar, KBOCDResourceBars.additionalResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)

    elseif event == "UNIT_HEALTH" or event == "PLAYER_TARGET_CHANGED" then
        KBOCDResourceBars.UpdateTargetHealthPercentage()

    elseif eventValue == "Blizzard_Settings" then
        if not KBOCDResourceBars.LoadedHookLogicForOptionPanes then
            KBOCDResourceBars.LoadedHookLogicForOptionPanes = true

            hooksecurefunc(SettingsPanel, "DisplayCategory", function(_, category)
                if category == KBOCDResourceBars.topLevelCategory
                or category == KBOCDResourceBars.healthBarCategory
                or category == KBOCDResourceBars.primaryResourceCategory
                or category == KBOCDResourceBars.additionalResourceCategory then
                    KBOCD_UI.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.healthBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.primaryResourceBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.additionalResourceBarFrameGlobal)

                else
                    KBOCD_UI.UpdateBarStrata(false, KBOCDResourceBars.healthBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(false, KBOCDResourceBars.primaryResourceBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(false, KBOCDResourceBars.additionalResourceBarFrameGlobal)
                end
            end)
        end
    end

end)
