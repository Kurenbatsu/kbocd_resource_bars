local additionalResourceBarDB = nil
local additionalResourceBarFrame = nil
local additionalResourceBar = nil
local additionalResourceBarText = nil
local additionalResourceBarBG = nil
local defaultDB = nil

local function initializeAdditionalResourceOptionAliases()
    additionalResourceBarDB = KBOCDResourceBarsDB.additionalResourceBar
    additionalResourceBarFrame = KBOCDResourceBars.additionalResourceBarFrameGlobal
    additionalResourceBar = KBOCDResourceBars.additionalResourceBarGlobal
    additionalResourceBarText = KBOCDResourceBars.additionalResourceBarTextGlobal
    additionalResourceBarBG = KBOCDResourceBars.additionalResourceBarBackgroundGlobal
    defaultDB = KBOCDResourceBars.DefaultValues.additionalResourceBar
end

function KBOCDResourceBars.CreateAdditionalResourceBarOptionsDB()
    local category = KBOCDResourceBars.additionalResourceCategory
    if not category then
        print("ERROR: Unable to create options DB - category nil")
        return
    end

    if not KBOCDResourceBars.didInitializeExtrasOptionAliases then
        KBOCDResourceBars.didInitializeExtrasOptionAliases = true
        initializeAdditionalResourceOptionAliases()
    end

    KBOCDResourceBars.AdditionalResourceBarOptionsDB = {
        --------------------------------------------------
        -- Section Headers
        --------------------------------------------------
        sectionHeader = {
            resourceText = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_resourceAdditionalResourceBarTextHeader",
                label               = "Resource Text",
            },
            barColors = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barColorsAdditionalResourceBarHeader",
                label               = "Resource Colors",
            },
            barGradient = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barGradientAdditionalResourceBarHeader",
                label               = "Resource Color Gradient",
            },
            sizeAndPosition = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_sizeAndPositionAdditionalResourceBarHeader",
                label            = "Size & Position",
            },
            frameColors = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_frameColorsAdditionalResourceBarHeader",
                label            = "Frame Colors",
            }
        },
        --------------------------------------------------
        -- Checkboxes
        --------------------------------------------------
        checkBox = {

            enable = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_enableAdditionalResourceBarCheckBox",
                label            = "Enable",
                defaultValue     = defaultDB.enabled,
                getter           = function()
                    return additionalResourceBarDB.enabled
                end,
                setter           = function(buttonEnabled)
                    additionalResourceBarDB.enabled = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "Enable the additional resource bar."
            },

            hideOutOfCombatAndFull = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_hideOutOfCombatAndFullAdditionalResourceBarCheckBox",
                label            = "Hide Out Of Combat & Idle",
                defaultValue     = defaultDB.hideOutOfCombatAndFull,
                getter           = function()
                    return additionalResourceBarDB.hideOutOfCombatAndFull
                end,
                setter           = function(buttonEnabled)
                    additionalResourceBarDB.hideOutOfCombatAndFull = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "The additional resource bar will be hidden when out of combat and when your additional resource is idle."
            },

            fontShadow = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_fontShadowAdditionalResourceBarCheckBox",
                label            = "Shadow",
                defaultValue     = defaultDB.fontDropShadowEnabled,
                getter           = function()
                    return additionalResourceBarDB.fontDropShadowEnabled
                end,
                setter           = function(buttonEnabled)
                    additionalResourceBarDB.fontDropShadowEnabled = buttonEnabled
                    KBOCD_UI.ApplyFontShadow(additionalResourceBarText, buttonEnabled)
                end,
                tooltip          = "Add a shadow to the text displaying your remaining additional resource."
            },

            enableGradientColors = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_enableGradientColorsAdditionalResourceBarCheckBox",
                label            = "Use Color Gradation",
                defaultValue     = defaultDB.useColorGradient,
                getter           = function()
                    return additionalResourceBarDB.useColorGradient
                end,
                setter           = function(buttonEnabled)
                    additionalResourceBarDB.useColorGradient = buttonEnabled
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "When your additional resource depletes, the bar gradually changes from the bar color to the various gradient colors."
            },

            resourceDeterminesBarColor = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_resourceDeterminesBarColorAdditionalResourceBarCheckBox",
                label            = "Dynamic Resource Color",
                defaultValue     = defaultDB.dynamicBarColor,
                getter           = function()
                    return additionalResourceBarDB.dynamicBarColor
                end,
                setter           = function(buttonEnabled)
                    additionalResourceBarDB.dynamicBarColor = buttonEnabled
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Your additional resource determines the resource color. Mana is blue, rage is red, energy is yellow, etc."
            },
        },

        --------------------------------------------------
        -- Dropdown menus
        --------------------------------------------------
        dropDown = {

            textValueDisplay = {
                elementType      = KBOCD_UI.elementType.dropDown,
                settingsCategory = category,
                identifier       = "kbocd_textValueDisplayAdditionalResourceBarDropDown",
                label            = "Format",
                defaultValue     = "percentage",
                getter           = function()
                    if additionalResourceBarDB.showPercentage then
                        return "percentage"
                    elseif additionalResourceBarDB.showNumericalValue then
                        return "number"
                    elseif additionalResourceBarDB.showMaxValue then
                        return "numberMax"
                    else
                        return "percentage"
                    end
                end,
                setter           = function(selectedValue)
                    additionalResourceBarDB.showPercentage = false
                    additionalResourceBarDB.showNumericalValue = false
                    additionalResourceBarDB.showMaxValue = false

                    if selectedValue == "percentage" then
                        additionalResourceBarDB.showPercentage = true
                    elseif selectedValue == "number" then
                        additionalResourceBarDB.showNumericalValue = true
                    elseif selectedValue == "numberMax" then
                        additionalResourceBarDB.showMaxValue = true
                    end

                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          =  "Adjusts the formatting of the text displaying your character's remaining additional resource.\n\nPercentage:\n50%\n\nNumber:\n50,000\n\nNumber & Maximum:\n50,000/100,000",
                options          = {
                    {
                        value = "percentage",
                        text = "Percentage",
                        label = "Percentage",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "number",
                        text = "Number",
                        label = "Number",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "numberMax",
                        text = "Number & Maximum",
                        label = "Number & Maximum",
                        controlType = Settings.ControlType.Radio
                    },
                },
            },

            textAlignment = {
                elementType      = KBOCD_UI.elementType.dropDown,
                settingsCategory = category,
                identifier       = "kbocd_textAlignmentAdditionalResourceBarDropDown",
                label            = "Alignment",
                defaultValue     = defaultDB.fontAlignment,
                getter           = function()
                    if additionalResourceBarDB.fontAlignment == "LEFT" then
                        return "LEFT"
                    elseif additionalResourceBarDB.fontAlignment == "CENTER" then
                        return "CENTER"
                    elseif additionalResourceBarDB.fontAlignment == "RIGHT" then
                        return "RIGHT"
                    else
                        return "CENTER"
                    end
                end,
                setter           = function(selectedValue)
                    additionalResourceBarDB.fontAlignment = selectedValue

                    local offsetX = 0
                    if additionalResourceBarDB.fontAlignment == "LEFT" then
                        offsetX = 4
                    elseif additionalResourceBarDB.fontAlignment == "RIGHT" then
                        offsetX = -4
                    end
                    additionalResourceBarText:ClearAllPoints()
                    additionalResourceBarText:SetPoint(
                        additionalResourceBarDB.fontAlignment,
                        additionalResourceBar,
                        additionalResourceBarDB.fontAlignment, offsetX, 0
                    )
                end,
                tooltip          = "Adjusts the alignment of the text displaying your character's remaining additional resource.",
                options          = {
                    {
                        value = "LEFT",
                        text = "Left",
                        label = "Left",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "CENTER",
                        text = "Center",
                        label = "Center",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "RIGHT",
                        text = "Right",
                        label = "Right",
                        controlType = Settings.ControlType.Radio
                    },
                },
            },

            additionalResource = {
                elementType      = KBOCD_UI.elementType.dropDown,
                settingsCategory = category,
                identifier       = "kbocd_resourceSelectorAdditionalResourceBarDropDown",
                label            = "Resource Type",
                defaultValue     = defaultDB.resourceToken,
                getter           = function()
                    return additionalResourceBarDB.resourceToken
                end,
                setter           = function(selectedValue)
                    additionalResourceBarDB.resourceToken = selectedValue
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)

                end,
                tooltip          = "Adjusts the alignment of the text displaying your character's remaining additional resource.",
                options          = {
                    {
                        value = "MANA",
                        text = "Mana",
                        label = "Mana",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "RAGE",
                        text = "Rage",
                        label = "Rage",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "FOCUS",
                        text = "Focus",
                        label = "Focus",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "ENERGY",
                        text = "Energy",
                        label = "Energy",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "RUNIC_POWER",
                        text = "Runic Power",
                        label = "Runic Power",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "LUNAR_POWER",
                        text = "Lunar Power",
                        label = "Lunar Power",
                        controlType = Settings.ControlType.Radio
                    },
                         {
                        value = "MAELSTROM",
                        text = "Maelstrom",
                        label = "Maelstrom",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "INSANITY",
                        text = "Insanity",
                        label = "Insanity",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "CHI",
                        text = "Chi",
                        label = "Chi",
                        controlType = Settings.ControlType.Radio
                    },
                    {
                        value = "FURY",
                        text = "Fury",
                        label = "Fury",
                        controlType = Settings.ControlType.Radio
                    },
                },
            },
        },

        --------------------------------------------------
        -- Sliders
        --------------------------------------------------
        slider = {

            textSize = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_fontSizeAdditionalResourceBarSlider",
                label            = "Size",
                defaultValue     = defaultDB.fontSize,
                getter           = function()
                    return additionalResourceBarDB.fontSize
                end,
                setter           = function(value)
                    additionalResourceBarDB.fontSize = value
                    local fontPath = additionalResourceBarText:GetFont()
                    additionalResourceBarText:SetFont(fontPath, value)
                end,
                tooltip          = "Adjusts the size of the text displaying your character's remaining additional resource.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(6, 120, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d pt", value)
                        end
                    )
                    return sliderOptions
                end
            },

            textAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_fontAlphaAdditionalResourceBarSlider",
                label            = "Opacity",
                defaultValue     = defaultDB.fontColor.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.fontColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.fontColor.alpha = alphaValue
                    KBOCD_UI.ApplyFontColor(additionalResourceBarText, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the text displaying your character's remaining additional resource.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            barColorAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_barColorAlphaAdditionalResourceBarSlider",
                label            = "Resource Color Opacity",
                defaultValue     = defaultDB.gradientColorValues.firstStop.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.gradientColorValues.firstStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.gradientColorValues.firstStop.alpha = alphaValue
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the additional resource bar.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            barSecondStepAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_barSecondStepColorAlphaAdditionalResourceBarSlider",
                label            = "50% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.secondStop.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.gradientColorValues.secondStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.gradientColorValues.secondStop.alpha = alphaValue
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the additional resource bar as it approaches 50% remaining.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            barThirdStepAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_barThirdStepColorAlphaAdditionalResourceBarSlider",
                label            = "0% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.thirdStop.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.gradientColorValues.thirdStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.gradientColorValues.thirdStop.alpha = alphaValue
                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the additional resource bar as it approaches 0% remaining.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            depletionColorAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_depletionColorAlphaAdditionalResourceBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.missingColor.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.missingColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.missingColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateDepletionColor(additionalResourceBarBG, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the additional resource bar.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            borderColorAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_borderColorAlphaAdditionalResourceBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.backdropBorderColor.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.backdropBorderColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.backdropBorderColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBorderColor(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the additional resource bar.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            backdropColorAlpha = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_backdropColorAlphaAdditionalResourceBarSlider",
                label            = "Backdrop Color Opacity",
                defaultValue     = defaultDB.backdropColor.alpha * 100,
                getter           = function()
                    return additionalResourceBarDB.backdropColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    additionalResourceBarDB.backdropColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBackdropColor(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the backdrop of the additional resource bar.",
                options          = function()
                    local sliderOptions = Settings.CreateSliderOptions(0, 100, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            return string.format("%d%%", value)
                        end
                    )
                    return sliderOptions
                end
            },

            frameXPosition = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_frameXPositionaAdditionalResourceBarSlider",
                label            = "Horizontal Position",
                defaultValue     = defaultDB.xPosition,
                getter           = function()
                    return additionalResourceBarDB.xPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = additionalResourceBarDB.xPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    additionalResourceBarDB.xPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, _, originalY = additionalResourceBarFrame:GetPoint()
                    additionalResourceBarFrame:ClearAllPoints()
                    additionalResourceBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, finalValue, originalY)
                end,
                tooltip          = "Moves the additional resource bar horizontally.",
                options          = function()
                    local maxX = KBOCDResourceBars.screenWidth / 2
                    local minX = -maxX
                    local sliderOptions = Settings.CreateSliderOptions(minX, maxX, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = additionalResourceBarDB.xPosition
                            local finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                            return string.format("%d", finalValue)
                        end
                    )
                    return sliderOptions
                end
            },

            frameYPosition = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_frameYPositionaAdditionalResourceBarSlider",
                label            = "Vertical Position",
                defaultValue     = defaultDB.yPosition,
                getter           = function()
                    return additionalResourceBarDB.yPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = additionalResourceBarDB.yPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    additionalResourceBarDB.yPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, originalX, _ = additionalResourceBarFrame:GetPoint()
                    additionalResourceBarFrame:ClearAllPoints()
                    additionalResourceBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, originalX, finalValue)
                end,
                tooltip          = "Moves the additional resource bar vertically.",
                options          = function()
                    local maxY = KBOCDResourceBars.screenHeight / 2
                    local minY = -maxY
                    local sliderOptions = Settings.CreateSliderOptions(minY, maxY, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = additionalResourceBarDB.yPosition
                            local finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                            return string.format("%d", finalValue)
                        end
                    )
                    return sliderOptions
                end
            },

            frameWidth = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_frameWidthAdditionalResourceBarSlider",
                label            = "Width",
                defaultValue     = defaultDB.width,
                getter           = function()
                    return additionalResourceBarDB.width
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    additionalResourceBarDB.width = roundedValue
                    additionalResourceBarFrame:SetWidth(roundedValue)
                end,
                tooltip          = "Adjust the width of the additional resource bar.",
                options          = function()
                    local maxWidth = KBOCDResourceBars.screenWidth
                    local sliderOptions = Settings.CreateSliderOptions(20, maxWidth, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local roundedValue = math.floor(value)
                            return string.format("%d", roundedValue)
                        end
                    )
                    return sliderOptions
                end
            },

            frameHeight = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_frameHeightAdditionalResourceBarSlider",
                label            = "Height",
                defaultValue     = defaultDB.height,
                getter           = function()
                    return additionalResourceBarDB.height
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    additionalResourceBarDB.height = roundedValue
                    additionalResourceBarFrame:SetHeight(roundedValue)
                end,
                tooltip          = "Adjust the height of the additional resource bar.",
                options          = function()
                    local maxHeight = KBOCDResourceBars.screenHeight
                    local sliderOptions = Settings.CreateSliderOptions(20, maxHeight, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local roundedValue = math.floor(value)
                            return string.format("%d", roundedValue)
                        end
                    )
                    return sliderOptions
                end
            },
        },

        --------------------------------------------------
        -- Color Swatches
        --------------------------------------------------
        colorSwatch = {

            textColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_fontColorAdditionalResourceBarColorSwatch",
                label            = "Color",
                defaultValue     = CreateColor(
                    defaultDB.fontColor.red,
                    defaultDB.fontColor.green,
                    defaultDB.fontColor.blue,
                    defaultDB.fontColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.fontColor.red,
                        additionalResourceBarDB.fontColor.green,
                        additionalResourceBarDB.fontColor.blue,
                        additionalResourceBarDB.fontColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.fontColor.red = r
                    additionalResourceBarDB.fontColor.green = g
                    additionalResourceBarDB.fontColor.blue = b
                    additionalResourceBarDB.fontColor.alpha = a

                    KBOCD_UI.ApplyFontColor(additionalResourceBarText, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the text displaying your character's remaining additional resource.",
            },

            barColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_barColorAdditionalResourceBarColorSwatch",
                label            = "Resource Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.firstStop.red,
                    defaultDB.gradientColorValues.firstStop.green,
                    defaultDB.gradientColorValues.firstStop.blue,
                    defaultDB.gradientColorValues.firstStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.gradientColorValues.firstStop.red,
                        additionalResourceBarDB.gradientColorValues.firstStop.green,
                        additionalResourceBarDB.gradientColorValues.firstStop.blue,
                        additionalResourceBarDB.gradientColorValues.firstStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.gradientColorValues.firstStop.red = r
                    additionalResourceBarDB.gradientColorValues.firstStop.green = g
                    additionalResourceBarDB.gradientColorValues.firstStop.blue = b
                    additionalResourceBarDB.gradientColorValues.firstStop.alpha = a

                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the additional resource bar.",
            },

            gradientColorSecondStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorSecondStopAdditionalResourceBarColorSwatch",
                label            = "50% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.secondStop.red,
                    defaultDB.gradientColorValues.secondStop.green,
                    defaultDB.gradientColorValues.secondStop.blue,
                    defaultDB.gradientColorValues.secondStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.gradientColorValues.secondStop.red,
                        additionalResourceBarDB.gradientColorValues.secondStop.green,
                        additionalResourceBarDB.gradientColorValues.secondStop.blue,
                        additionalResourceBarDB.gradientColorValues.secondStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.gradientColorValues.secondStop.red = r
                    additionalResourceBarDB.gradientColorValues.secondStop.green = g
                    additionalResourceBarDB.gradientColorValues.secondStop.blue = b
                    additionalResourceBarDB.gradientColorValues.secondStop.alpha = a

                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the additional resource bar as it approaches 50% remaining. The color will be a gradient from your bars color and this color as it progresses to 50%.",
            },

            gradientColorThirdStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorThirdStopAdditionalResourceBarColorSwatch",
                label            = "0% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.thirdStop.red,
                    defaultDB.gradientColorValues.thirdStop.green,
                    defaultDB.gradientColorValues.thirdStop.blue,
                    defaultDB.gradientColorValues.thirdStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.gradientColorValues.thirdStop.red,
                        additionalResourceBarDB.gradientColorValues.thirdStop.green,
                        additionalResourceBarDB.gradientColorValues.thirdStop.blue,
                        additionalResourceBarDB.gradientColorValues.thirdStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.gradientColorValues.thirdStop.red = r
                    additionalResourceBarDB.gradientColorValues.thirdStop.green = g
                    additionalResourceBarDB.gradientColorValues.thirdStop.blue = b
                    additionalResourceBarDB.gradientColorValues.thirdStop.alpha = a

                    KBOCDResourceBars.Update(additionalResourceBar, additionalResourceBarDB, additionalResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the additional resource bar as it approaches 0% remaining. The color will be a gradient from your 50% color and this color as it progresses to 0%.",
            },

            depletionColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_depletionColorAdditionalResourceBarColorSwatch",
                label            = "Depletion Color",
                defaultValue     = CreateColor(
                    defaultDB.missingColor.red,
                    defaultDB.missingColor.green,
                    defaultDB.missingColor.blue,
                    defaultDB.missingColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.missingColor.red,
                        additionalResourceBarDB.missingColor.green,
                        additionalResourceBarDB.missingColor.blue,
                        additionalResourceBarDB.missingColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.missingColor.red = r
                    additionalResourceBarDB.missingColor.green = g
                    additionalResourceBarDB.missingColor.blue = b
                    additionalResourceBarDB.missingColor.alpha = a

                    KBOCDResourceBars.UpdateDepletionColor(additionalResourceBarBG, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the depleted portion of the additional resource bar.",
            },

            borderColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_borderColorAdditionalResourceBarColorSwatch",
                label            = "Border Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropBorderColor.red,
                    defaultDB.backdropBorderColor.green,
                    defaultDB.backdropBorderColor.blue,
                    defaultDB.backdropBorderColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.backdropBorderColor.red,
                        additionalResourceBarDB.backdropBorderColor.green,
                        additionalResourceBarDB.backdropBorderColor.blue,
                        additionalResourceBarDB.backdropBorderColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.backdropBorderColor.red = r
                    additionalResourceBarDB.backdropBorderColor.green = g
                    additionalResourceBarDB.backdropBorderColor.blue = b
                    additionalResourceBarDB.backdropBorderColor.alpha = a

                    KBOCDResourceBars.UpdateBorderColor(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the additional resource bar's border.",
            },

            backdropColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_backdropColorAdditionalResourceBarColorSwatch",
                label            = "Backdrop Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropColor.red,
                    defaultDB.backdropColor.green,
                    defaultDB.backdropColor.blue,
                    defaultDB.backdropColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        additionalResourceBarDB.backdropColor.red,
                        additionalResourceBarDB.backdropColor.green,
                        additionalResourceBarDB.backdropColor.blue,
                        additionalResourceBarDB.backdropColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    additionalResourceBarDB.backdropColor.red = r
                    additionalResourceBarDB.backdropColor.green = g
                    additionalResourceBarDB.backdropColor.blue = b
                    additionalResourceBarDB.backdropColor.alpha = a

                    KBOCDResourceBars.UpdateBackdropColor(additionalResourceBarFrame, additionalResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the additional resource bar's backdrop.",
            },
        }
    }
end
