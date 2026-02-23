function KBOCDResourceBars.layoutExtrasOptionsPane()
    KBOCDResourceBars.CreateExtrasOptionsDB()

    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.sectionHeader.playerFrame)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.checkBox.displayHealthPercentageNextToPlayerFrame)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.checkBox.displayPrimaryResourcePercentageNextToPlayerFrame)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.checkBox.displayAdditionalResourcePercentageNextToPlayerFrame)

    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.sectionHeader.targetFrame)
    KBOCD_UI.CreateUIElementFrom(KBOCDResourceBars.ExtrasOptionsDB.checkBox.displayHealthPercentageOverTargetFrame)

end