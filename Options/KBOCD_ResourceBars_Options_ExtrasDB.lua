function KBOCDResourceBars.CreateExtrasOptionsDB()
    local category = KBOCDResourceBars.extrasCategory
    if not category then
        print("ERROR: Unable to create options DB - category nil")
        return
    end

    KBOCDResourceBars.ExtrasOptionsDB = {
        --------------------------------------------------
        -- Section Headers
        --------------------------------------------------
        sectionHeader = {
            playerFrame = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_extrasPlayerFrameTextHeader",
                label               = "Player Frame",
            },
            targetFrame = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_extrasTargetFrameTextHeader",
                label               = "Target Frame",
            },
        },
        --------------------------------------------------
        -- Checkboxes
        --------------------------------------------------
        checkBox = {

            displayHealthPercentageNextToPlayerFrame = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_displayHealthPercentageNextToPlayerFrameExtrasCheckBox",
                label            = "Health Percentage",
                defaultValue     = false,
                getter           = function()
                    return KBOCDResourceBarsDB.displayHealthPercentageNextToPlayerFrame
                end,
                setter           = function(buttonEnabled)
                    KBOCDResourceBarsDB.displayHealthPercentageNextToPlayerFrame = buttonEnabled
                    KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageNextToPlayerFrame")
                end,
                tooltip          = "Displays remaining health percentage next to the player frame."
            },

            displayPrimaryResourcePercentageNextToPlayerFrame = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_displayPrimaryResourcePercentageNextToPlayerFrameExtrasCheckBox",
                label            = "Primary Resource Percentage",
                defaultValue     = false,
                getter           = function()
                    return KBOCDResourceBarsDB.displayPrimaryResourcePercentageNextToPlayerFrame
                end,
                setter           = function(buttonEnabled)
                    KBOCDResourceBarsDB.displayPrimaryResourcePercentageNextToPlayerFrame = buttonEnabled
                    KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFramePrimaryResourceText, KBOCDResourceBarsDB, "displayPrimaryResourcePercentageNextToPlayerFrame")
                end,
                tooltip          = "Displays remaining primary resource percentage next to the player frame."
            },

            displayAdditionalResourcePercentageNextToPlayerFrame = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_displayAdditionalResourcePercentageNextToPlayerFrameExtrasCheckBox",
                label            = "Additional Resource Percentage",
                defaultValue     = false,
                getter           = function()
                    return KBOCDResourceBarsDB.displayAdditionalResourcePercentageNextToPlayerFrame
                end,
                setter           = function(buttonEnabled)
                    KBOCDResourceBarsDB.displayAdditionalResourcePercentageNextToPlayerFrame = buttonEnabled
                    KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameAdditionalResourceText, KBOCDResourceBarsDB, "displayAdditionalResourcePercentageNextToPlayerFrame")
                end,
                tooltip          = "Displays remaining additional resource percentage next to the player frame."
            },

            displayHealthPercentageOverTargetFrame = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_displayHealthPercentageOverTargetFrameExtrasCheckBox",
                label            = "Target Health Percentage",
                defaultValue     = false,
                getter           = function()
                    return KBOCDResourceBarsDB.displayHealthPercentageOverTargetFrame
                end,
                setter           = function(buttonEnabled)
                    KBOCDResourceBarsDB.displayHealthPercentageOverTargetFrame = buttonEnabled
                    KBOCD_UI.UpdateExtrasFrameVisibility(KBOCDResourceBars.targetUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageOverTargetFrame")
                    if buttonEnabled then
                        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(0)
                    else
                        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(1)
                    end
                end,
                tooltip          = "Displays remaining health percentage of the target over the target health bar."
            },

        },

    }
end
