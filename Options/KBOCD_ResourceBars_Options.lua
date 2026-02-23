local function layoutTopLevelOptionsPane()
    KBOCDResourceBars.CreateOptionsDB()

    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.checkBox.viewBarsAboveOptions)

    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.sectionHeader.config)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.button.openHealthCategory)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.button.openPrimaryResourceCategory)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.button.openAdditionalResourceCategory)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.button.openExtrasCategory)

    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.OptionsDB.sectionHeader.version)
end

function KBOCDResourceBars.CreateOptionsHierarchyAndTopLevelPane()
    KBOCDResourceBars.topLevelCategory = Settings.RegisterVerticalLayoutCategory("KBOCD Resource Bars")
    Settings.RegisterAddOnCategory(KBOCDResourceBars.topLevelCategory)

    KBOCDResourceBars.healthBarCategory = Settings.RegisterVerticalLayoutSubcategory(KBOCDResourceBars.topLevelCategory, "Health Bar")
    Settings.RegisterAddOnCategory(KBOCDResourceBars.healthBarCategory)

    KBOCDResourceBars.primaryResourceCategory = Settings.RegisterVerticalLayoutSubcategory(KBOCDResourceBars.topLevelCategory, "Primary Resource Bar")
    Settings.RegisterAddOnCategory(KBOCDResourceBars.primaryResourceCategory, KBOCDResourceBars.topLevelCategory:GetID())

    KBOCDResourceBars.additionalResourceCategory = Settings.RegisterVerticalLayoutSubcategory(KBOCDResourceBars.topLevelCategory, "Additional Resource Bar")
    Settings.RegisterAddOnCategory(KBOCDResourceBars.additionalResourceCategory, KBOCDResourceBars.topLevelCategory:GetID())

    KBOCDResourceBars.extrasCategory = Settings.RegisterVerticalLayoutSubcategory(KBOCDResourceBars.topLevelCategory, "Extras")
    Settings.RegisterAddOnCategory(KBOCDResourceBars.extrasCategory, KBOCDResourceBars.topLevelCategory:GetID())

    layoutTopLevelOptionsPane()

end
