--------------------------------------------------
-- Local Aliases
--------------------------------------------------
local healthBarDB = nil
local healthBarFrame = nil
local healthBar = nil
local healthBarText = nil
local healthBarBG = nil

local primaryResourceBarDB = nil
local primaryResourceBarFrame = nil
local primaryResourceBar = nil
local primaryResourceBarText = nil
local primaryResourceBarBG = nil

local additionalResourceBarDB = nil
local additionalResourceBarFrame = nil
local additionalResourceBar = nil
local additionalResourceBarText = nil
local additionalResourceBarBG = nil

--------------------------------------------------
-- Init Aliases
--------------------------------------------------
function KBOCDResourceBars.InitializeConfigCoreAliases()
    healthBarDB = KBOCDResourceBarsDB.healthBar
    healthBarFrame = KBOCDResourceBars.healthBarFrameGlobal
    healthBar = KBOCDResourceBars.healthBarGlobal
    healthBarText = KBOCDResourceBars.healthBarTextGlobal
    healthBarBG = KBOCDResourceBars.healthBarBackgroundGlobal

    primaryResourceBarDB = KBOCDResourceBarsDB.primaryResourceBar
    primaryResourceBarFrame = KBOCDResourceBars.primaryResourceBarFrameGlobal
    primaryResourceBar = KBOCDResourceBars.primaryResourceBarGlobal
    primaryResourceBarText = KBOCDResourceBars.primaryResourceBarTextGlobal
    primaryResourceBarBG = KBOCDResourceBars.primaryResourceBarBackgroundGlobal

    additionalResourceBarDB = KBOCDResourceBarsDB.additionalResourceBar
    additionalResourceBarFrame = KBOCDResourceBars.additionalResourceBarFrameGlobal
    additionalResourceBar = KBOCDResourceBars.additionalResourceBarGlobal
    additionalResourceBarText = KBOCDResourceBars.additionalResourceBarTextGlobal
    additionalResourceBarBG = KBOCDResourceBars.additionalResourceBarBackgroundGlobal
end

--------------------------------------------------
-- Config UI Elements Table
--------------------------------------------------
function KBOCDResourceBars.CreateUIElementValuesTable()
    KBOCDResourceBars.UIElementValues = {
    --------------------------------------------------
    -- Global Confg UI
    --------------------------------------------------
        global = {
            label = {
                configHeader = {
                    string        = "KBOCD Resource Bars",
                    style         = "GameFontNormalLarge",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 16,
                    yPos          = -16,
                },
                configSubtitle = {
                    string        = "Configure your resource bars.",
                    style         = "GameFontHighlight",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                },
                extrasHeader = {
                    string        = "Extras",
                    style         = "GameFontNormalLarge",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 0,
                    yPos          = -14,
                }
            },
            checkBox = {
                viewBarsAboveOptions = {
                    label         = "View bars above options while editing",
                    db            = KBOCDResourceBarsDB,
                    dbKey         = "moveAboveOptions",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 181,
                    yPos          = 0,
                    closure       = function(buttonEnabled)
                        KBOCDResourceBars.UpdateBarStrata(buttonEnabled, healthBarFrame)
                        KBOCDResourceBars.UpdateBarStrata(buttonEnabled, primaryResourceBarFrame)
                        KBOCDResourceBars.UpdateBarStrata(buttonEnabled, additionalResourceBarFrame)
                    end
                },
                displayHealthPercentageNextToPlayerFrame = {
                    label         = "Display health percentage next to player frame",
                    db            = KBOCDResourceBarsDB,
                    dbKey         = "displayHealthPercentageNextToPlayerFrame",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 15,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageNextToPlayerFrame")
                    end
                },
                displayPrimaryResourcePercentageNextToPlayerFrame = {
                    label         = "Display primary resource percentage next to player frame",
                    db            = KBOCDResourceBarsDB,
                    dbKey         = "displayPrimaryResourcePercentageNextToPlayerFrame",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFramePrimaryResourceText, KBOCDResourceBarsDB, "displayPrimaryResourcePercentageNextToPlayerFrame")
                    end
                },
                displayAdditionalResroucePercentageNextToPlayerFrame = {
                    label         = "Display selected additional resource percentage next to player frame",
                    db            = KBOCDResourceBarsDB,
                    dbKey         = "displayAdditionalResourcePercentageNextToPlayerFrame",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameAdditionalResourceText, KBOCDResourceBarsDB, "displayAdditionalResourcePercentageNextToPlayerFrame")
                    end
                },
                displayHealthPercentageOverTargetFrame = {
                    label         = "Display health percentage over target frame health bar",
                    db            = KBOCDResourceBarsDB,
                    dbKey         = "displayHealthPercentageOverTargetFrame",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(buttonEnabled)
                        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.targetUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageOverTargetFrame")
                        if buttonEnabled then
                            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(0)
                        else
                            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(1)
                        end
                    end
                }
            },
        },
    --------------------------------------------------
    -- Health Bar Confg UI
    --------------------------------------------------
        healthBar = {
            label = {
                sectionHeader = {
                    string        = "Health Bar",
                    style         = "GameFontNormalLarge",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 0,
                    yPos          = -12,
                },
                textAlignment = {
                    string        = "Text Alignment",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 5,
                    yPos          = -28,
                },
                fontSize = {
                    string        = "Font Size",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 203,
                    yPos          = 0,
                },
                barWidth = {
                    string        = "Bar Width",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = -38,
                    yPos          = -37,
                },
                barHeight = {
                    string        = "Bar Height",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 30,
                    yPos          = 0,
                },
                barXPosition = {
                    string        = "X Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
                barYPosition = {
                    string        = "Y Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
            },
            checkBox = {
                enable = {
                    label         = "Enable",
                    db            = healthBarDB,
                    dbKey         = "enabled",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 15,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(healthBarFrame, healthBarDB)
                    end
                },
                hideOutOfCombatAndFull = {
                    label         = "Hide when out of combat and health is full",
                    db            = healthBarDB,
                    dbKey         = "hideOutOfCombatAndFull",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(healthBarFrame, healthBarDB)
                    end
                },
                displayAsPercentage = {
                    label         = "Display remaining value as percentage",
                    db            = healthBarDB,
                    dbKey         = "showPercentage",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(not enabled, KBOCDResourceBars.displayHealthMaxValueButton)
                    end
                },
                displayMaxValue = {
                    label         = "Display max value",
                    db            = healthBarDB,
                    dbKey         = "showMaxValue",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                    end
                },
                showTextShadow = {
                    label         = "Show text shadow",
                    db            = healthBarDB,
                    dbKey         = "fontDropShadowEnabled",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 60,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.ApplyFontShadow(healthBarText, enabled)
                    end
                },
                useGradientColors = {
                    label         = "Use color gradation",
                    db            = healthBarDB,
                    dbKey         = "useColorGradient",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 83,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                         KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.healthGradientSecondStopColorSwatch, KBOCDResourceBars.healthGradientSecondStopColorlabel)
                        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.healthGradientThirdStopColorSwatch, KBOCDResourceBars.healthGradientThirdStopColorlabel)
                    end
                }
            },
            colorSwatch = {
                fontColor = {
                    label         = "Font Color",
                    db            = healthBarDB,
                    dbKey         = "fontColor",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 71,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.ApplyFontColor(healthBarText, healthBarDB)
                    end
                },
                gradientFirstStop = {
                    label         = "Bar Color",
                    db            = healthBarDB.gradientColorValues,
                    dbKey         = "firstStop",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 18.5,
                    yPos          = -52,
                    closure       = function()
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                    end
                },
                gradientSecondStop = {
                    label         = "50% Gradient Color",
                    db            = healthBarDB.gradientColorValues,
                    dbKey         = "secondStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 132,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                    end
                },
                gradientThirdStop = {
                    label         = "0% Gradient Color",
                    db            = healthBarDB.gradientColorValues,
                    dbKey         = "thirdStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 158,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                    end
                },
                depletionColor = {
                    label         = "Depletion Color",
                    db            = healthBarDB,
                    dbKey         = "missingColor",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 20,
                    yPos          = -60,
                    closure       = function()
                        KBOCDResourceBars.UpdateDepletionColor(healthBarBG, healthBarDB)
                    end
                },
                borderColor = {
                    label         = "Border Color",
                    db            = healthBarDB,
                    dbKey         = "backdropBorderColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 141,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBorderColor(healthBarFrame, healthBarDB)
                    end
                },
                backdropColor = {
                    label         = "Backdrop Color",
                    db            = healthBarDB,
                    dbKey         = "backdropColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 137,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBackdropColor(healthBarFrame, healthBarDB)
                    end
                }
            },
            dimensionBox = {
                barWidth = {
                    db            = healthBarDB,
                    dimension     = "WIDTH",
                    frameToAdjust = healthBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                },
                barHeight = {
                    db            = healthBarDB,
                    dimension     = "HEIGHT",
                    frameToAdjust = healthBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                }
            },
            positionBox = {
                barPositionX = {
                    db            = healthBarDB,
                    position      = "X",
                    frameToAdjust = healthBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                },
                barPositionY = {
                    db            = healthBarDB,
                    position      = "Y",
                    frameToAdjust = healthBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                }
            },
            fontSizeBox = {
                barFont = {
                    db            = healthBarDB,
                    textToSize    = healthBarText,
                    frameToAdjust = healthBarFrame,
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 37,
                    yPos          = 2,
                }
            },
            dropDownBox = {
                fontAlignment = {
                    db            = healthBarDB,
                    textToAlign   = healthBarText,
                    bar           = healthBar,
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -6,
                }
            },
            resetButton = {
                typeForConfirmationBox = "Health Bar",
                db                     = healthBarDB,
                defaultValuesTable     = KBOCDResourceBars.DefaultValues.healthBar,
                point                  = "CENTER",
                relativePoint          = "RIGHT",
                xPos                   = 100,
                yPos                   = -25.2,
            }
        },
    --------------------------------------------------
    -- Primary Resource Bar Confg UI
    --------------------------------------------------
        primaryResourceBar = {
            label = {
                sectionHeader = {
                    string        = "Primary Resource Bar",
                    style         = "GameFontNormalLarge",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 0,
                    yPos          = -14,
                },
                textAlignment = {
                    string        = "Text Alignment",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 5,
                    yPos          = -28,
                },
                fontSize = {
                    string        = "Font Size",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 203,
                    yPos          = 0,
                },
                barWidth = {
                    string        = "Bar Width",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = -38,
                    yPos          = -37,
                },
                barHeight = {
                    string        = "Bar Height",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 30,
                    yPos          = 0,
                },
                barXPosition = {
                    string        = "X Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
                barYPosition = {
                    string        = "Y Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
            },
            checkBox = {
                enable = {
                    label         = "Enable",
                    db            = primaryResourceBarDB,
                    dbKey         = "enabled",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 15,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(primaryResourceBarFrame, primaryResourceBarDB)
                    end
                },
                hideOutOfCombatAndFull = {
                    label         = "Hide when out of combat and resource is idle",
                    db            = primaryResourceBarDB,
                    dbKey         = "hideOutOfCombatAndFull",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(primaryResourceBarFrame, primaryResourceBarDB)
                    end
                },
                displayAsPercentage = {
                    label         = "Display remaining value as percentage",
                    db            = primaryResourceBarDB,
                    dbKey         = "showPercentage",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(not enabled, KBOCDResourceBars.displayPrimaryResourceMaxValueButton)
                    end
                },
                displayMaxValue = {
                    label         = "Display max value",
                    db            = primaryResourceBarDB,
                    dbKey         = "showMaxValue",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                showTextShadow = {
                    label         = "Show text shadow",
                    db            = primaryResourceBarDB,
                    dbKey         = "fontDropShadowEnabled",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 60,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.ApplyFontShadow(primaryResourceBarText, enabled)
                    end
                },
                useGradientColors = {
                    label         = "Use color gradation",
                    db            = primaryResourceBarDB,
                    dbKey         = "useColorGradient",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 83,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                         KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.primaryResourceGradientSecondStopColorSwatch, KBOCDResourceBars.primaryResourceSecondStopColorlabel)
                        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.primaryResourceGradientThirdStopColorSwatch, KBOCDResourceBars.primaryResourceGradientThirdStopColorlabel)
                    end
                },
                dynamicBarColor = {
                    label         = "Dynamically change bar color based on resource type",
                    db            = primaryResourceBarDB,
                    dbKey         = "dynamicBarColor",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(enabled, KBOCDResourceBars.primaryResourceGradientFirstStopColorSwatch, KBOCDResourceBars.primaryResourceFirstStopColorlabel)
                    end
                }
            },
            colorSwatch = {
                fontColor = {
                    label         = "Font Color",
                    db            = primaryResourceBarDB,
                    dbKey         = "fontColor",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 71,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.ApplyFontColor(primaryResourceBarText, primaryResourceBarDB)
                    end
                },
                gradientFirstStop = {
                    label         = "Bar Color",
                    db            = primaryResourceBarDB.gradientColorValues,
                    dbKey         = "firstStop",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 18.5,
                    yPos          = -52,
                    closure       = function()
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                gradientSecondStop = {
                    label         = "50% Gradient Color",
                    db            = primaryResourceBarDB.gradientColorValues,
                    dbKey         = "secondStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 132,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                gradientThirdStop = {
                    label         = "0% Gradient Color",
                    db            = primaryResourceBarDB.gradientColorValues,
                    dbKey         = "thirdStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 158,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                depletionColor = {
                    label         = "Depletion Color",
                    db            = primaryResourceBarDB,
                    dbKey         = "missingColor",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 20,
                    yPos          = -60,
                    closure       = function()
                        KBOCDResourceBars.UpdateDepletionColor(primaryResourceBarBG, primaryResourceBarDB)
                    end
                },
                borderColor = {
                    label         = "Border Color",
                    db            = primaryResourceBarDB,
                    dbKey         = "backdropBorderColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 141,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBorderColor(primaryResourceBarFrame, primaryResourceBarDB)
                    end
                },
                backdropColor = {
                    label         = "Backdrop Color",
                    db            = primaryResourceBarDB,
                    dbKey         = "backdropColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 137,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBackdropColor(primaryResourceBarFrame, primaryResourceBarDB)
                    end
                }
            },
            dimensionBox = {
                barWidth = {
                    db            = primaryResourceBarDB,
                    dimension     = "WIDTH",
                    frameToAdjust = primaryResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                },
                barHeight = {
                    db            = primaryResourceBarDB,
                    dimension     = "HEIGHT",
                    frameToAdjust = primaryResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                }
            },
            positionBox = {
                barPositionX = {
                    db            = primaryResourceBarDB,
                    position      = "X",
                    frameToAdjust = primaryResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                },
                barPositionY = {
                    db            = primaryResourceBarDB,
                    position      = "Y",
                    frameToAdjust = primaryResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                }
            },
            fontSizeBox = {
                barFont = {
                    db            = primaryResourceBarDB,
                    textToSize    = primaryResourceBarText,
                    frameToAdjust = primaryResourceBarFrame,
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 37,
                    yPos          = 2,
                }
            },
            dropDownBox = {
                fontAlignment = {
                    db            = primaryResourceBarDB,
                    textToAlign   = primaryResourceBarText,
                    bar           = primaryResourceBar,
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -6,
                }
            },
            resetButton = {
                typeForConfirmationBox = "Primary Resource Bar",
                db                     = primaryResourceBarDB,
                defaultValuesTable     = KBOCDResourceBars.DefaultValues.primaryResourceBar,
                point                  = "CENTER",
                relativePoint          = "RIGHT",
                xPos                   = 100,
                yPos                   = -25.2,
            }
        },
    --------------------------------------------------
    -- Additional Resource Bar Confg UI
    --------------------------------------------------
        additionalResourceBar = {
            label = {
                sectionHeader = {
                    string        = "Additional Resource Bar",
                    style         = "GameFontNormalLarge",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 0,
                    yPos          = -14,
                },
                textAlignment = {
                    string        = "Text Alignment",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 5,
                    yPos          = -28,
                },
                resourceDropDown = {
                    string        = "Resource",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 5,
                    yPos          = -12,
                },
                fontSize = {
                    string        = "Font Size",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPLEFT",
                    xPos          = 203,
                    yPos          = 0,
                },
                barWidth = {
                    string        = "Bar Width",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = -38,
                    yPos          = -37,
                },
                barHeight = {
                    string        = "Bar Height",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 30,
                    yPos          = 0,
                },
                barXPosition = {
                    string        = "X Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
                barYPosition = {
                    string        = "Y Position",
                    style         = "GameFontNormal",
                    point         = "TOPLEFT",
                    relativePoint = "TOPRIGHT",
                    xPos          = 70,
                    yPos          = 0,
                },
            },
            checkBox = {
                enable = {
                    label         = "Enable",
                    db            = additionalResourceBarDB,
                    dbKey         = "enabled",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 15,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(additionalResourceBarFrame, additionalResourceBarDB)
                    end
                },
                hideOutOfCombatAndFull = {
                    label         = "Hide when out of combat and resource is idle",
                    db            = additionalResourceBarDB,
                    dbKey         = "hideOutOfCombatAndFull",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function()
                        KBOCDResourceBars.UpdateVisibility(additionalResourceBarFrame, additionalResourceBarDB)
                    end
                },
                displayAsPercentage = {
                    label         = "Display remaining value as percentage",
                    db            = additionalResourceBarDB,
                    dbKey         = "showPercentage",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(not enabled, KBOCDResourceBars.displayAdditionalResourceMaxValueButton)
                    end
                },
                displayMaxValue = {
                    label         = "Display max value",
                    db            = additionalResourceBarDB,
                    dbKey         = "showMaxValue",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                showTextShadow = {
                    label         = "Show text shadow",
                    db            = additionalResourceBarDB,
                    dbKey         = "fontDropShadowEnabled",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 60,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.ApplyFontShadow(additionalResourceBarText, enabled)
                    end
                },
                useGradientColors = {
                    label         = "Use color gradation",
                    db            = additionalResourceBarDB,
                    dbKey         = "useColorGradient",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 83,
                    yPos          = 0,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                         KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.additionalResourceGradientSecondStopColorSwatch, KBOCDResourceBars.additionalResourceSecondStopColorlabel)
                        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(not enabled, KBOCDResourceBars.additionalResourceGradientThirdStopColorSwatch, KBOCDResourceBars.additionalResourceGradientThirdStopColorlabel)
                    end
                },
                dynamicBarColor = {
                    label         = "Dynamically change bar color based on resource type",
                    db            = additionalResourceBarDB,
                    dbKey         = "dynamicBarColor",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -8,
                    closure       = function(enabled)
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(enabled, KBOCDResourceBars.additionalResourceGradientFirstStopColorSwatch, KBOCDResourceBars.additionalResourceFirstStopColorlabel)
                    end
                }
            },
            colorSwatch = {
                fontColor = {
                    label         = "Font Color",
                    db            = additionalResourceBarDB,
                    dbKey         = "fontColor",
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 71,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.ApplyFontColor(additionalResourceBarText, additionalResourceBarDB)
                    end
                },
                gradientFirstStop = {
                    label         = "Bar Color",
                    db            = additionalResourceBarDB.gradientColorValues,
                    dbKey         = "firstStop",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 18.5,
                    yPos          = -52,
                    closure       = function()
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                gradientSecondStop = {
                    label         = "50% Gradient Color",
                    db            = additionalResourceBarDB.gradientColorValues,
                    dbKey         = "secondStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 132,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                gradientThirdStop = {
                    label         = "0% Gradient Color",
                    db            = additionalResourceBarDB.gradientColorValues,
                    dbKey         = "thirdStop",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 158,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                    end
                },
                depletionColor = {
                    label         = "Depletion Color",
                    db            = additionalResourceBarDB,
                    dbKey         = "missingColor",
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 20,
                    yPos          = -60,
                    closure       = function()
                        KBOCDResourceBars.UpdateDepletionColor(additionalResourceBarBG, additionalResourceBarDB)
                    end
                },
                borderColor = {
                    label         = "Border Color",
                    db            = additionalResourceBarDB,
                    dbKey         = "backdropBorderColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 141,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBorderColor(additionalResourceBarFrame, additionalResourceBarDB)
                    end
                },
                backdropColor = {
                    label         = "Backdrop Color",
                    db            = additionalResourceBarDB,
                    dbKey         = "backdropColor",
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 137,
                    yPos          = 0,
                    closure       = function()
                        KBOCDResourceBars.UpdateBackdropColor(additionalResourceBarFrame, additionalResourceBarDB)
                    end
                }
            },
            dimensionBox = {
                barWidth = {
                    db            = additionalResourceBarDB,
                    dimension     = "WIDTH",
                    frameToAdjust = additionalResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                },
                barHeight = {
                    db            = additionalResourceBarDB,
                    dimension     = "HEIGHT",
                    frameToAdjust = additionalResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 2,
                    yPos          = -25.5,
                }
            },
            positionBox = {
                barPositionX = {
                    db            = additionalResourceBarDB,
                    position      = "X",
                    frameToAdjust = additionalResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                },
                barPositionY = {
                    db            = additionalResourceBarDB,
                    position      = "Y",
                    frameToAdjust = additionalResourceBarFrame,
                    point         = "CENTER",
                    relativePoint = "CENTER",
                    xPos          = 3,
                    yPos          = -25.5,
                }
            },
            fontSizeBox = {
                barFont = {
                    db            = additionalResourceBarDB,
                    textToSize    = additionalResourceBarText,
                    frameToAdjust = additionalResourceBarFrame,
                    point         = "LEFT",
                    relativePoint = "RIGHT",
                    xPos          = 37,
                    yPos          = 2,
                }
            },
            dropDownBox = {
                fontAlignment = {
                    db            = additionalResourceBarDB,
                    textToAlign   = additionalResourceBarText,
                    bar           = additionalResourceBar,
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -6,
                },
                resourceType = {
                    db            = additionalResourceBarDB,
                    bar           = additionalResourceBar,
                    point         = "TOPLEFT",
                    relativePoint = "BOTTOMLEFT",
                    xPos          = 0,
                    yPos          = -6,
                }
            },
            resetButton = {
                typeForConfirmationBox = "Additional Resource Bar",
                db                     = additionalResourceBarDB,
                defaultValuesTable     = KBOCDResourceBars.DefaultValues.additionalResourceBar,
                point                  = "CENTER",
                relativePoint          = "RIGHT",
                xPos                   = 100,
                yPos                   = -25.2,
            }
        }
    }
end
