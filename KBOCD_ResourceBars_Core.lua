--------------------------------------------------
-- Init
--------------------------------------------------
KBOCDResourceBars = KBOCDResourceBars or {}

--------------------------------------------------
-- Table Values
--------------------------------------------------
KBOCDResourceBars.DefaultValues = {
    --------------------------------------------------
    -- Global Values
    --------------------------------------------------
    moveAboveOptions                                        = false,
    displayHealthPercentageNextToPlayerFrame                = false,
    displayPrimaryResourcePercentageNextToPlayerFrame       = false,
    displayAdditionalResourcePercentageNextToPlayerFrame    = false,
    displayHealthPercentageOverTargetFrame                  = false,
    --------------------------------------------------
    -- Health Bar Values
    --------------------------------------------------
    healthBar = {
        enabled                 = true,
        hideOutOfCombatAndFull  = false,
        xPosition               = -187.33,
        yPosition               = -216.33,
        width                   = 138,
        height                  = 22,
        gradientColorValues   = {
            firstStop  = {
                red = 0.118,
                green = 0.75,
                blue = 0.004,
                alpha = 1
            },
            secondStop = {
                red = 1.0,
                green = 1.0,
                blue = 0.0,
                alpha = 1
            },
            thirdStop  = {
                red = 1.0,
                green = 0.043,
                blue = 0.0,
                alpha = 1
            },
        },
        backdropColor         = {
            red   = 0,
            green = 0,
            blue  = 0,
            alpha = 0.7,
        },
        backdropBorderColor   = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        useColorGradient      = true,
        missingColor          = {
            red   = 0.2,
            green = 0.2,
            blue  = 0.2,
            alpha = 0,
        },
        fontSize              = 12,
        fontAlignment         = "CENTER",
        fontDropShadowEnabled = true,
        fontColor             = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        showPercentage        = true,
        showMaxValue          = true,
        showNumericalValue    = false
    },
    --------------------------------------------------
    -- Primary Resource Values
    --------------------------------------------------
    primaryResourceBar = {
        enabled                 = true,
        hideOutOfCombatAndFull  = false,
        xPosition               = 187.33,
        yPosition               = -216.33,
        width                   = 138,
        height                  = 21.5,
        gradientColorValues   = {
            firstStop  = {
                red = 0,
                green = 0,
                blue = 0.9411765336990356,
                alpha = 1
            },
            secondStop = {
                red = 1.0,
                green = 1.0,
                blue = 0.0,
                alpha = 1
            },
            thirdStop  = {
                red = 1.0,
                green = 0.043,
                blue = 0.0,
                alpha = 1
            },
        },
        backdropColor         = {
            red   = 0,
            green = 0,
            blue  = 0,
            alpha = 0.7,
        },
        backdropBorderColor   = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        useColorGradient      = false,
        missingColor          = {
            red   = 0.2,
            green = 0.2,
            blue  = 0.2,
            alpha = 0,
        },
        fontSize              = 12,
        fontAlignment         = "CENTER",
        fontDropShadowEnabled = true,
        fontColor             = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        showPercentage        = true,
        showMaxValue          = true,
        showNumericalValue    = false,
        dynamicBarColor       = true,
    },
    --------------------------------------------------
    -- Additional Resource Values
    --------------------------------------------------
    additionalResourceBar = {
        enabled                 = false,
        hideOutOfCombatAndFull  = false,
        xPosition               = 0,
        yPosition               = -216.33,
        width                   = 138,
        height                  = 21.5,
        gradientColorValues   = {
            firstStop  = {
                red = 0,
                green = 0,
                blue = 0.9411765336990356,
                alpha = 1
            },
            secondStop = {
                red = 1.0,
                green = 1.0,
                blue = 0.0,
                alpha = 1
            },
            thirdStop  = {
                red = 1.0,
                green = 0.043,
                blue = 0.0,
                alpha = 1
            },
        },
        backdropColor         = {
            red   = 0,
            green = 0,
            blue  = 0,
            alpha = 0.7,
        },
        backdropBorderColor   = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        useColorGradient      = false,
        missingColor          = {
            red   = 0.2,
            green = 0.2,
            blue  = 0.2,
            alpha = 0,
        },
        fontSize              = 12,
        fontAlignment         = "CENTER",
        fontDropShadowEnabled = true,
        fontColor             = {
            red   = 1,
            green = 1,
            blue  = 1,
            alpha = 1,
        },
        showPercentage        = true,
        showMaxValue          = true,
        showNumericalValue    = false,
        dynamicBarColor       = true,
        resourceToken         = "MANA"
    }
}

KBOCDResourceBars.BarTypeReferenceValues = {
    health = {
        current = UnitHealth,
        max     = UnitHealthMax,
    },
    resource = {
        current     = UnitPower,
        max         = UnitPowerMax,
    }
}

KBOCDResourceBars.EventTypeReferenceValues = {
    health = {
        change      = "UNIT_HEALTH",
        maxChange   = "UNIT_MAXHEALTH"
    },
    resource = {
        change      = "UNIT_POWER_UPDATE",
        maxChange   = "UNIT_POWER_UPDATE" -- There's no max event type but we need to mirror health to allow for a generic method
    }
}

KBOCDResourceBars.ResourceColor = {
    MANA = {
        red   = 0,
        green = 0,
        blue  = 0.9411765336990356,
        alpha = 1,
    },
    RAGE = {
        red   = 1.00,
        green = 0.00,
        blue  = 0.00,
        alpha = 1,
    },
    FOCUS = {
        red   = 1.00,
        green = 0.50,
        blue  = 0.25,
        alpha = 1,
    },
    ENERGY = {
        red   = 1.00,
        green = 1.00,
        blue  = 0.00,
        alpha = 1,
    },
    RUNIC_POWER = {
        red   = 0.00,
        green = 0.82,
        blue  = 1.00,
        alpha = 1,
    },
    LUNAR_POWER = {
        red   = 0.30,
        green = 0.52,
        blue  = 0.90,
        alpha = 1,
    },
    MAELSTROM = {
        red   = 0.00,
        green = 0.50,
        blue  = 1.00,
        alpha = 1,
    },
    INSANITY = {
        red   = 0.40,
        green = 0.00,
        blue  = 0.80,
        alpha = 1,
    },
    CHI = {
        red   = 0.71,
        green = 1.00,
        blue  = 0.92,
        alpha = 1,
    },
    FURY = {
        red   = 0.788,
        green = 0.259,
        blue  = 0.992,
        alpha = 1,
    },
    PAIN = {
        red   = 1.00,
        green = 0.61,
        blue  = 0.00,
        alpha = 1,
    },
}

KBOCDResourceBars.PowerTokenToType = {
    MANA         = 0,
    RAGE         = 1,
    FOCUS        = 2,
    ENERGY       = 3,
    RUNIC_POWER  = 6,
    LUNAR_POWER  = 8,
    MAELSTROM    = 11,
    INSANITY     = 13,
    CHI          = 12,
    FURY         = 17,
}

KBOCDResourceBars.ResourceIdlesAtFull = {
    MANA         = true,
    RAGE         = false,
    FOCUS        = true,
    ENERGY       = true,
    RUNIC_POWER  = false,
    LUNAR_POWER  = false,
    MAELSTROM    = false,
    INSANITY     = false,
    CHI          = true,
    FURY         = false,
}

--------------------------------------------------
-- User Defined Values (Uses 'DefaultValues' values if user defined values do not exist)
--------------------------------------------------
function KBOCDResourceBars.CopyDefaultValues(src, dest, resetToDefaults)
    for key, value in pairs(src) do
        if type(value) == "table" then
            if type(dest[key]) ~= "table" or resetToDefaults then
                dest[key] = {}
            end
            KBOCDResourceBars.CopyDefaultValues(value, dest[key])
        else
            if dest[key] == nil or resetToDefaults then
                dest[key] = value
            end
        end
    end
end

--------------------------------------------------
-- Initialize DB (set values)
--------------------------------------------------
function KBOCDResourceBars.InitializeUserValues()
    KBOCDResourceBarsDB = KBOCDResourceBarsDB or {}
    KBOCDResourceBars.CopyDefaultValues(KBOCDResourceBars.DefaultValues, KBOCDResourceBarsDB)
end

--------------------------------------------------
-- Reset DB Values
--------------------------------------------------
function KBOCDResourceBars.ResetUserValuesFor(dbTable, defaultValuesTable)
    KBOCDResourceBarsDB = KBOCDResourceBarsDB or {}
    KBOCDResourceBars.CopyDefaultValues(defaultValuesTable, dbTable, true)
end
