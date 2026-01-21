--------------------------------------------------
-- Create Health Bar
--------------------------------------------------
function KBOCDResourceBars.CreateHealthBar()
    local healthBarFrame = KBOCDResourceBars.CreateBarFrame(UIParent, KBOCDResourceBarsDB.healthBar)
    KBOCDResourceBars.healthBarFrameGlobal = healthBarFrame

    local healthBarContainer = KBOCDResourceBars.CreateBarContainer(healthBarFrame)

    local healthBar, healthBarBackground = KBOCDResourceBars.CreateStatusBar(healthBarContainer, KBOCDResourceBarsDB.healthBar)
    KBOCDResourceBars.healthBarGlobal = healthBar
    KBOCDResourceBars.healthBarBackgroundGlobal = healthBarBackground

    local text = KBOCDResourceBars.CreateBarText(healthBar, KBOCDResourceBarsDB.healthBar)
    KBOCDResourceBars.healthBarTextGlobal = text

    KBOCDResourceBars.RegisterEvents(
        healthBarFrame,
        healthBar,
        KBOCDResourceBarsDB.healthBar,
        text,
        KBOCDResourceBars.BarTypeReferenceValues.health,
        KBOCDResourceBars.EventTypeReferenceValues.health
    )
end

function KBOCDResourceBars.CreatePrimaryResourceBar()
    local primaryResourceBarFrame = KBOCDResourceBars.CreateBarFrame(UIParent, KBOCDResourceBarsDB.primaryResourceBar)
    KBOCDResourceBars.primaryResourceBarFrameGlobal = primaryResourceBarFrame

    local primaryResourceBarContainer = KBOCDResourceBars.CreateBarContainer(primaryResourceBarFrame)

    local primaryResourceBar, primaryResourceBarBackground = KBOCDResourceBars.CreateStatusBar(primaryResourceBarContainer, KBOCDResourceBarsDB.primaryResourceBar)
    KBOCDResourceBars.primaryResourceBarGlobal = primaryResourceBar
    KBOCDResourceBars.primaryResourceBarBackgroundGlobal = primaryResourceBarBackground

    local text = KBOCDResourceBars.CreateBarText(primaryResourceBar, KBOCDResourceBarsDB.primaryResourceBar)
    KBOCDResourceBars.primaryResourceBarTextGlobal = text

    KBOCDResourceBars.RegisterEvents(
        primaryResourceBarFrame,
        primaryResourceBar,
        KBOCDResourceBarsDB.primaryResourceBar,
        text,
        KBOCDResourceBars.BarTypeReferenceValues.resource,
        KBOCDResourceBars.EventTypeReferenceValues.resource
    )
end

function KBOCDResourceBars.CreateAdditionalResourceBar()
    local additionalResourceBarFrame = KBOCDResourceBars.CreateBarFrame(UIParent, KBOCDResourceBarsDB.additionalResourceBar)
    KBOCDResourceBars.additionalResourceBarFrameGlobal = additionalResourceBarFrame

    local additionalResourceBarContainer = KBOCDResourceBars.CreateBarContainer(additionalResourceBarFrame)

    local additionalResourceBar, additionalResourceBarBackground = KBOCDResourceBars.CreateStatusBar(additionalResourceBarContainer, KBOCDResourceBarsDB.additionalResourceBar)
    KBOCDResourceBars.additionalResourceBarGlobal = additionalResourceBar
    KBOCDResourceBars.additionalResourceBarBackgroundGlobal = additionalResourceBarBackground

    local text = KBOCDResourceBars.CreateBarText(additionalResourceBar, KBOCDResourceBarsDB.additionalResourceBar)
    KBOCDResourceBars.additionalResourceBarTextGlobal = text

    KBOCDResourceBars.RegisterEvents(
        additionalResourceBarFrame,
        additionalResourceBar,
        KBOCDResourceBarsDB.additionalResourceBar,
        text,
        KBOCDResourceBars.BarTypeReferenceValues.resource,
        KBOCDResourceBars.EventTypeReferenceValues.resource
    )
end

