local healthBarDB = nil
local healthBarFrame = nil
local healthBar = nil
local healthBarText = nil
local healthBarBG = nil
local defaultDB = nil

local function initializeHealthOptionAliases()
    healthBarDB = KBOCDResourceBarsDB.healthBar
    healthBarFrame = KBOCDResourceBars.healthBarFrameGlobal
    healthBar = KBOCDResourceBars.healthBarGlobal
    healthBarText = KBOCDResourceBars.healthBarTextGlobal
    healthBarBG = KBOCDResourceBars.healthBarBackgroundGlobal
    defaultDB = KBOCDResourceBars.DefaultValues.healthBar
end

function KBOCDResourceBars.CreateHealthBarOptionsDB()
    local category = KBOCDResourceBars.healthBarCategory
    if not category then
        print("ERROR: Unable to create options DB - category nil")
        return
    end

    if not KBOCDResourceBars.didInitializeHealthOptionAliases then
        KBOCDResourceBars.didInitializeHealthOptionAliases = true
        initializeHealthOptionAliases()
    end

    KBOCDResourceBars.HealthBarOptionsDB = {
        --------------------------------------------------
        -- Section Headers
        --------------------------------------------------
        sectionHeader = {
            resourceText = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_resourceHealthBarTextHeader",
                label               = "Resource Text",
            },
            barColors = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barColorsHealthBarHeader",
                label               = "Resource Colors",
            },
            barGradient = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barGradientHealthBarHeader",
                label               = "Resource Color Gradient",
            },
            sizeAndPosition = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_sizeAndPositionHealthBarHeader",
                label            = "Size & Position",
            },
            frameColors = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_frameColorsHealthBarHeader",
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
                identifier       = "kbocd_enableHealthBarCheckBox",
                label            = "Enable",
                defaultValue     = defaultDB.enabled,
                getter           = function()
                    return healthBarDB.enabled
                end,
                setter           = function(buttonEnabled)
                    healthBarDB.enabled = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(healthBarFrame, healthBarDB)
                end,
                tooltip          = "Enable the health bar."
            },

            hideOutOfCombatAndFull = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_hideOutOfCombatAndFullHealthBarCheckBox",
                label            = "Hide Out Of Combat & Full",
                defaultValue     = defaultDB.hideOutOfCombatAndFull,
                getter           = function()
                    return healthBarDB.hideOutOfCombatAndFull
                end,
                setter           = function(buttonEnabled)
                    healthBarDB.hideOutOfCombatAndFull = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(healthBarFrame, healthBarDB)
                end,
                tooltip          = "The health bar will be hidden when out of combat and when your health is at its maximum value."
            },

            fontShadow = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_fontShadowHealthBarCheckBox",
                label            = "Shadow",
                defaultValue     = defaultDB.fontDropShadowEnabled,
                getter           = function()
                    return healthBarDB.fontDropShadowEnabled
                end,
                setter           = function(buttonEnabled)
                    healthBarDB.fontDropShadowEnabled = buttonEnabled
                    KBOCD_UI.ApplyFontShadow(healthBarText, buttonEnabled)
                end,
                tooltip          = "Add a shadow to the text displaying your remaining health."
            },

            enableGradientColors = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_enableGradientColorsHealthBarCheckBox",
                label            = "Use Color Gradation",
                defaultValue     = defaultDB.useColorGradient,
                getter           = function()
                    return healthBarDB.useColorGradient
                end,
                setter           = function(buttonEnabled)
                    healthBarDB.useColorGradient = buttonEnabled
                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "When your health depletes, the bar gradually changes from the bar color to the various gradient colors."
            },
        },

        --------------------------------------------------
        -- Dropdown menus
        --------------------------------------------------
        dropDown = {

            textValueDisplay = {
                elementType      = KBOCD_UI.elementType.dropDown,
                settingsCategory = category,
                identifier       = "kbocd_textValueDisplayHealthBarDropDown",
                label            = "Format",
                defaultValue     = "percentage",
                getter           = function()
                    if healthBarDB.showPercentage then
                        return "percentage"
                    elseif healthBarDB.showNumericalValue then
                        return "number"
                    elseif healthBarDB.showMaxValue then
                        return "numberMax"
                    else
                        return "percentage"
                    end
                end,
                setter           = function(selectedValue)
                    healthBarDB.showPercentage = false
                    healthBarDB.showNumericalValue = false
                    healthBarDB.showMaxValue = false

                    if selectedValue == "percentage" then
                        healthBarDB.showPercentage = true
                    elseif selectedValue == "number" then
                        healthBarDB.showNumericalValue = true
                    elseif selectedValue == "numberMax" then
                        healthBarDB.showMaxValue = true
                    end

                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          =  "Adjusts the formatting of the text displaying your character's remaining health.\n\nPercentage:\n50%\n\nNumber:\n50,000\n\nNumber & Maximum:\n50,000/100,000",
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
                identifier       = "kbocd_textAlignmentHealthBarDropDown",
                label            = "Alignment",
                defaultValue     = defaultDB.fontAlignment,
                getter           = function()
                    if healthBarDB.fontAlignment == "LEFT" then
                        return "LEFT"
                    elseif healthBarDB.fontAlignment == "CENTER" then
                        return "CENTER"
                    elseif healthBarDB.fontAlignment == "RIGHT" then
                        return "RIGHT"
                    else
                        return "CENTER"
                    end
                end,
                setter           = function(selectedValue)
                    healthBarDB.fontAlignment = selectedValue

                    local offsetX = 0
                    if healthBarDB.fontAlignment == "LEFT" then
                        offsetX = 4
                    elseif healthBarDB.fontAlignment == "RIGHT" then
                        offsetX = -4
                    end
                    healthBarText:ClearAllPoints()
                    healthBarText:SetPoint(
                        healthBarDB.fontAlignment,
                        healthBar,
                        healthBarDB.fontAlignment, offsetX, 0
                    )
                end,
                tooltip          = "Adjusts the alignment of the text displaying your character's remaining health.",
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
        },

        --------------------------------------------------
        -- Sliders
        --------------------------------------------------
        slider = {

            textSize = {
                elementType      = KBOCD_UI.elementType.slider,
                settingsCategory = category,
                identifier       = "kbocd_fontSizeHealthBarSlider",
                label            = "Size",
                defaultValue     = defaultDB.fontSize,
                getter           = function()
                    return healthBarDB.fontSize
                end,
                setter           = function(value)
                    healthBarDB.fontSize = value
                    local fontPath = healthBarText:GetFont()
                    healthBarText:SetFont(fontPath, value)
                end,
                tooltip          = "Adjusts the size of the text displaying your character's remaining health.",
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
                identifier       = "kbocd_fontAlphaHealthBarSlider",
                label            = "Opacity",
                defaultValue     = defaultDB.fontColor.alpha * 100,
                getter           = function()
                    return healthBarDB.fontColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.fontColor.alpha = alphaValue
                    KBOCD_UI.ApplyFontColor(healthBarText, healthBarDB)
                end,
                tooltip          = "Adjusts the opacity of the text displaying your character's remaining health.",
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
                identifier       = "kbocd_barColorAlphaHealthBarSlider",
                label            = "Resource Color Opacity",
                defaultValue     = defaultDB.gradientColorValues.firstStop.alpha * 100,
                getter           = function()
                    return healthBarDB.gradientColorValues.firstStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.gradientColorValues.firstStop.alpha = alphaValue
                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the opacity of the color of the health bar.",
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
                identifier       = "kbocd_barSecondStepColorAlphaHealthBarSlider",
                label            = "50% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.secondStop.alpha * 100,
                getter           = function()
                    return healthBarDB.gradientColorValues.secondStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.gradientColorValues.secondStop.alpha = alphaValue
                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the opacity of the color of the health bar as it approaches 50% remaining.",
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
                identifier       = "kbocd_barThirdStepColorAlphaHealthBarSlider",
                label            = "0% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.thirdStop.alpha * 100,
                getter           = function()
                    return healthBarDB.gradientColorValues.thirdStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.gradientColorValues.thirdStop.alpha = alphaValue
                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the opacity of the color of the health bar as it approaches 0% remaining.",
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
                identifier       = "kbocd_depletionColorAlphaHealthBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.missingColor.alpha * 100,
                getter           = function()
                    return healthBarDB.missingColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.missingColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateDepletionColor(healthBarBG, healthBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the health bar.",
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
                identifier       = "kbocd_borderColorAlphaHealthBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.backdropBorderColor.alpha * 100,
                getter           = function()
                    return healthBarDB.backdropBorderColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.backdropBorderColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBorderColor(healthBarFrame, healthBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the health bar.",
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
                identifier       = "kbocd_backdropColorAlphaHealthBarSlider",
                label            = "Backdrop Color Opacity",
                defaultValue     = defaultDB.backdropColor.alpha * 100,
                getter           = function()
                    return healthBarDB.backdropColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    healthBarDB.backdropColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBackdropColor(healthBarFrame, healthBarDB)
                end,
                tooltip          = "Adjusts the opacity of the backdrop of the health bar.",
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
                identifier       = "kbocd_frameXPositionaHealthBarSlider",
                label            = "Horizontal Position",
                defaultValue     = defaultDB.xPosition,
                getter           = function()
                    return healthBarDB.xPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = healthBarDB.xPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    healthBarDB.xPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, _, originalY = healthBarFrame:GetPoint()
                    healthBarFrame:ClearAllPoints()
                    healthBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, finalValue, originalY)
                end,
                tooltip          = "Moves the health bar horizontally.",
                options          = function()
                    local maxX = KBOCDResourceBars.screenWidth / 2
                    local minX = -maxX
                    local sliderOptions = Settings.CreateSliderOptions(minX, maxX, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = healthBarDB.xPosition
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
                identifier       = "kbocd_frameYPositionaHealthBarSlider",
                label            = "Vertical Position",
                defaultValue     = defaultDB.yPosition,
                getter           = function()
                    return healthBarDB.yPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = healthBarDB.yPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    healthBarDB.yPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, originalX, _ = healthBarFrame:GetPoint()
                    healthBarFrame:ClearAllPoints()
                    healthBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, originalX, finalValue)
                end,
                tooltip          = "Moves the health bar vertically.",
                options          = function()
                    local maxY = KBOCDResourceBars.screenHeight / 2
                    local minY = -maxY
                    local sliderOptions = Settings.CreateSliderOptions(minY, maxY, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = healthBarDB.yPosition
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
                identifier       = "kbocd_frameWidthHealthBarSlider",
                label            = "Width",
                defaultValue     = defaultDB.width,
                getter           = function()
                    return healthBarDB.width
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    healthBarDB.width = roundedValue
                    healthBarFrame:SetWidth(roundedValue)
                end,
                tooltip          = "Adjust the width of the health bar.",
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
                identifier       = "kbocd_frameHeightHealthBarSlider",
                label            = "Height",
                defaultValue     = defaultDB.height,
                getter           = function()
                    return healthBarDB.height
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    healthBarDB.height = roundedValue
                    healthBarFrame:SetHeight(roundedValue)
                end,
                tooltip          = "Adjust the height of the health bar.",
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
                identifier       = "kbocd_fontColorHealthBarColorSwatch",
                label            = "Color",
                defaultValue     = CreateColor(
                    defaultDB.fontColor.red,
                    defaultDB.fontColor.green,
                    defaultDB.fontColor.blue,
                    defaultDB.fontColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.fontColor.red,
                        healthBarDB.fontColor.green,
                        healthBarDB.fontColor.blue,
                        healthBarDB.fontColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.fontColor.red = r
                    healthBarDB.fontColor.green = g
                    healthBarDB.fontColor.blue = b
                    healthBarDB.fontColor.alpha = a

                    KBOCD_UI.ApplyFontColor(healthBarText, healthBarDB)
                end,
                tooltip          = "Adjusts the color of the text displaying your character's remaining health.",
            },

            barColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_barColorHealthBarColorSwatch",
                label            = "Resource Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.firstStop.red,
                    defaultDB.gradientColorValues.firstStop.green,
                    defaultDB.gradientColorValues.firstStop.blue,
                    defaultDB.gradientColorValues.firstStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.gradientColorValues.firstStop.red,
                        healthBarDB.gradientColorValues.firstStop.green,
                        healthBarDB.gradientColorValues.firstStop.blue,
                        healthBarDB.gradientColorValues.firstStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.gradientColorValues.firstStop.red = r
                    healthBarDB.gradientColorValues.firstStop.green = g
                    healthBarDB.gradientColorValues.firstStop.blue = b
                    healthBarDB.gradientColorValues.firstStop.alpha = a

                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the color of the health bar.",
            },

            gradientColorSecondStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorSecondStopHealthBarColorSwatch",
                label            = "50% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.secondStop.red,
                    defaultDB.gradientColorValues.secondStop.green,
                    defaultDB.gradientColorValues.secondStop.blue,
                    defaultDB.gradientColorValues.secondStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.gradientColorValues.secondStop.red,
                        healthBarDB.gradientColorValues.secondStop.green,
                        healthBarDB.gradientColorValues.secondStop.blue,
                        healthBarDB.gradientColorValues.secondStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.gradientColorValues.secondStop.red = r
                    healthBarDB.gradientColorValues.secondStop.green = g
                    healthBarDB.gradientColorValues.secondStop.blue = b
                    healthBarDB.gradientColorValues.secondStop.alpha = a

                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the color of the health bar as it approaches 50% remaining. The color will be a gradient from your bars color and this color as it progresses to 50%.",
            },

            gradientColorThirdStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorThirdStopHealthBarColorSwatch",
                label            = "0% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.thirdStop.red,
                    defaultDB.gradientColorValues.thirdStop.green,
                    defaultDB.gradientColorValues.thirdStop.blue,
                    defaultDB.gradientColorValues.thirdStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.gradientColorValues.thirdStop.red,
                        healthBarDB.gradientColorValues.thirdStop.green,
                        healthBarDB.gradientColorValues.thirdStop.blue,
                        healthBarDB.gradientColorValues.thirdStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.gradientColorValues.thirdStop.red = r
                    healthBarDB.gradientColorValues.thirdStop.green = g
                    healthBarDB.gradientColorValues.thirdStop.blue = b
                    healthBarDB.gradientColorValues.thirdStop.alpha = a

                    KBOCDResourceBars.Update(healthBar, healthBarDB, healthBarText, KBOCDResourceBars.BarTypeReferenceValues.health)
                end,
                tooltip          = "Adjusts the color of the health bar as it approaches 0% remaining. The color will be a gradient from your 50% color and this color as it progresses to 0%.",
            },

            depletionColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_depletionColorHealthBarColorSwatch",
                label            = "Depletion Color",
                defaultValue     = CreateColor(
                    defaultDB.missingColor.red,
                    defaultDB.missingColor.green,
                    defaultDB.missingColor.blue,
                    defaultDB.missingColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.missingColor.red,
                        healthBarDB.missingColor.green,
                        healthBarDB.missingColor.blue,
                        healthBarDB.missingColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.missingColor.red = r
                    healthBarDB.missingColor.green = g
                    healthBarDB.missingColor.blue = b
                    healthBarDB.missingColor.alpha = a

                    KBOCDResourceBars.UpdateDepletionColor(healthBarBG, healthBarDB)
                end,
                tooltip          = "Adjusts the color of the depleted portion of the health bar.",
            },

            borderColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_borderColorHealthBarColorSwatch",
                label            = "Border Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropBorderColor.red,
                    defaultDB.backdropBorderColor.green,
                    defaultDB.backdropBorderColor.blue,
                    defaultDB.backdropBorderColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.backdropBorderColor.red,
                        healthBarDB.backdropBorderColor.green,
                        healthBarDB.backdropBorderColor.blue,
                        healthBarDB.backdropBorderColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.backdropBorderColor.red = r
                    healthBarDB.backdropBorderColor.green = g
                    healthBarDB.backdropBorderColor.blue = b
                    healthBarDB.backdropBorderColor.alpha = a

                    KBOCDResourceBars.UpdateBorderColor(healthBarFrame, healthBarDB)
                end,
                tooltip          = "Adjusts the color of the health bar's border.",
            },

            backdropColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_backdropColorHealthBarColorSwatch",
                label            = "Backdrop Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropColor.red,
                    defaultDB.backdropColor.green,
                    defaultDB.backdropColor.blue,
                    defaultDB.backdropColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        healthBarDB.backdropColor.red,
                        healthBarDB.backdropColor.green,
                        healthBarDB.backdropColor.blue,
                        healthBarDB.backdropColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    healthBarDB.backdropColor.red = r
                    healthBarDB.backdropColor.green = g
                    healthBarDB.backdropColor.blue = b
                    healthBarDB.backdropColor.alpha = a

                    KBOCDResourceBars.UpdateBackdropColor(healthBarFrame, healthBarDB)
                end,
                tooltip          = "Adjusts the color of the health bar's backdrop.",
            },
        }
    }
end
