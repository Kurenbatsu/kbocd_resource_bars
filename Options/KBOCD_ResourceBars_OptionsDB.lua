function KBOCDResourceBars.CreateOptionsDB()
    local category = KBOCDResourceBars.topLevelCategory
    if not category then
        print("ERROR: Unable to create options DB - category nil")
    end

    KBOCDResourceBars.OptionsDB = {
        sectionHeader = {
            config = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_topLevelResourceBarHeader",
                label               = "Configure",
            },
            version = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_versionHeader",
                label               = string.format("Version: %s",  C_AddOns.GetAddOnMetadata("KBOCDResourceBars", "Version") or ""),
            }
        },
        button = {
            openHealthCategory = {
                elementType         = KBOCD_UI.elementType.button,
                settingsCategory    = category,
                identifier          = "kbocd_openHealthCategoryButton",
                label               = "Health Bar",
                setter              = function() Settings.OpenToCategory(KBOCDResourceBars.healthBarCategory.ID) end
            },
            openPrimaryResourceCategory = {
                elementType         = KBOCD_UI.elementType.button,
                settingsCategory    = category,
                identifier          = "kbocd_openPrimaryResourceCategoryButton",
                label               = "Primary Resource Bar",
                setter              = function() Settings.OpenToCategory(KBOCDResourceBars.primaryResourceCategory.ID) end
            },
            openAdditionalResourceCategory = {
                elementType         = KBOCD_UI.elementType.button,
                settingsCategory    = category,
                identifier          = "kbocd_openAdditionalResourceCategoryButton",
                label               = "Additional Resource Bar",
                setter              = function() Settings.OpenToCategory(KBOCDResourceBars.additionalResourceCategory.ID) end
            },
            openExtrasCategory = {
                elementType         = KBOCD_UI.elementType.button,
                settingsCategory    = category,
                identifier          = "kbocd_openExtrasCategoryButton",
                label               = "Extras",
                setter              = function() Settings.OpenToCategory(KBOCDResourceBars.extrasCategory.ID) end
            },
        },
        checkBox = {
            viewBarsAboveOptions = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_viewBarsAboveOptionsCheckBox",
                label            = "View Bars Above Options",
                defaultValue     = KBOCDResourceBars.DefaultValues.moveAboveOptions,
                getter           = function()
                    return KBOCDResourceBarsDB.moveAboveOptions
                end,
                setter           = function(buttonEnabled)
                    KBOCDResourceBarsDB.moveAboveOptions = buttonEnabled
                    KBOCD_UI.UpdateBarStrata(buttonEnabled, KBOCDResourceBars.healthBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(buttonEnabled, KBOCDResourceBars.primaryResourceBarFrameGlobal)
                    KBOCD_UI.UpdateBarStrata(buttonEnabled, KBOCDResourceBars.additionalResourceBarFrameGlobal)
                end,
                tooltip          = "Changes the strata level of all resource bars while within options pane."
            }
        },
    }
end
