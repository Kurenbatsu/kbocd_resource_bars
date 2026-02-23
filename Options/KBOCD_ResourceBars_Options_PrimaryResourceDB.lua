local primaryResourceBarDB = nil
local primaryResourceBarFrame = nil
local primaryResourceBar = nil
local primaryResourceBarText = nil
local primaryResourceBarBG = nil
local defaultDB = nil

local function initializePrimaryResourceOptionAliases()
    primaryResourceBarDB = KBOCDResourceBarsDB.primaryResourceBar
    primaryResourceBarFrame = KBOCDResourceBars.primaryResourceBarFrameGlobal
    primaryResourceBar = KBOCDResourceBars.primaryResourceBarGlobal
    primaryResourceBarText = KBOCDResourceBars.primaryResourceBarTextGlobal
    primaryResourceBarBG = KBOCDResourceBars.primaryResourceBarBackgroundGlobal
    defaultDB = KBOCDResourceBars.DefaultValues.primaryResourceBar
end

function KBOCDResourceBars.CreatePrimaryResourceBarOptionsDB()
    local category = KBOCDResourceBars.primaryResourceCategory
    if not category then
        print("ERROR: Unable to create options DB - category nil")
        return
    end

    if not KBOCDResourceBars.didInitializePrimaryResourceOptionAliases then
        KBOCDResourceBars.didInitializePrimaryResourceOptionAliases = true
        initializePrimaryResourceOptionAliases()
    end

    KBOCDResourceBars.PrimaryResourceBarOptionsDB = {
        --------------------------------------------------
        -- Section Headers
        --------------------------------------------------
        sectionHeader = {
            resourceText = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_resourcePrimaryResourceBarTextHeader",
                label               = "Resource Text",
            },
            barColors = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barColorsPrimaryResourceBarHeader",
                label               = "Resource Colors",
            },
            barGradient = {
                elementType         = KBOCD_UI.elementType.sectionHeader,
                settingsCategory    = category,
                identifier          = "kbocd_barGradientPrimaryResourceBarHeader",
                label               = "Resource Color Gradient",
            },
            sizeAndPosition = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_sizeAndPositionPrimaryResourceBarHeader",
                label            = "Size & Position",
            },
            frameColors = {
                elementType      = KBOCD_UI.elementType.sectionHeader,
                settingsCategory = category,
                identifier       = "kbocd_frameColorsPrimaryResourceBarHeader",
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
                identifier       = "kbocd_enablePrimaryResourceBarCheckBox",
                label            = "Enable",
                defaultValue     = defaultDB.enabled,
                getter           = function()
                    return primaryResourceBarDB.enabled
                end,
                setter           = function(buttonEnabled)
                    primaryResourceBarDB.enabled = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "Enable the primary resource bar."
            },

            hideOutOfCombatAndFull = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_hideOutOfCombatAndFullPrimaryResourceBarCheckBox",
                label            = "Hide Out Of Combat & Idle",
                defaultValue     = defaultDB.hideOutOfCombatAndFull,
                getter           = function()
                    return primaryResourceBarDB.hideOutOfCombatAndFull
                end,
                setter           = function(buttonEnabled)
                    primaryResourceBarDB.hideOutOfCombatAndFull = buttonEnabled
                    KBOCDResourceBars.UpdateVisibility(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "The primary resource bar will be hidden when out of combat and when your primary resource is idle."
            },

            fontShadow = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_fontShadowPrimaryResourceBarCheckBox",
                label            = "Shadow",
                defaultValue     = defaultDB.fontDropShadowEnabled,
                getter           = function()
                    return primaryResourceBarDB.fontDropShadowEnabled
                end,
                setter           = function(buttonEnabled)
                    primaryResourceBarDB.fontDropShadowEnabled = buttonEnabled
                    KBOCD_UI.ApplyFontShadow(primaryResourceBarText, buttonEnabled)
                end,
                tooltip          = "Add a shadow to the text displaying your remaining primary resource."
            },

            enableGradientColors = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_enableGradientColorsPrimaryResourceBarCheckBox",
                label            = "Use Color Gradation",
                defaultValue     = defaultDB.useColorGradient,
                getter           = function()
                    return primaryResourceBarDB.useColorGradient
                end,
                setter           = function(buttonEnabled)
                    primaryResourceBarDB.useColorGradient = buttonEnabled
                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "When your primary resource depletes, the bar gradually changes from the bar color to the various gradient colors."
            },

            resourceDeterminesBarColor = {
                elementType      = KBOCD_UI.elementType.checkBox,
                settingsCategory = category,
                identifier       = "kbocd_resourceDeterminesBarColorPrimaryResourceBarCheckBox",
                label            = "Dynamic Resource Color",
                defaultValue     = defaultDB.dynamicBarColor,
                getter           = function()
                    return primaryResourceBarDB.dynamicBarColor
                end,
                setter           = function(buttonEnabled)
                    primaryResourceBarDB.dynamicBarColor = buttonEnabled
                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Your primary resource determines the resource color. Mana is blue, rage is red, energy is yellow, etc."
            },
        },

        --------------------------------------------------
        -- Dropdown menus
        --------------------------------------------------
        dropDown = {

            textValueDisplay = {
                elementType      = KBOCD_UI.elementType.dropDown,
                settingsCategory = category,
                identifier       = "kbocd_textValueDisplayPrimaryResourceBarDropDown",
                label            = "Format",
                defaultValue     = "percentage",
                getter           = function()
                    if primaryResourceBarDB.showPercentage then
                        return "percentage"
                    elseif primaryResourceBarDB.showNumericalValue then
                        return "number"
                    elseif primaryResourceBarDB.showMaxValue then
                        return "numberMax"
                    else
                        return "percentage"
                    end
                end,
                setter           = function(selectedValue)
                    primaryResourceBarDB.showPercentage = false
                    primaryResourceBarDB.showNumericalValue = false
                    primaryResourceBarDB.showMaxValue = false

                    if selectedValue == "percentage" then
                        primaryResourceBarDB.showPercentage = true
                    elseif selectedValue == "number" then
                        primaryResourceBarDB.showNumericalValue = true
                    elseif selectedValue == "numberMax" then
                        primaryResourceBarDB.showMaxValue = true
                    end

                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          =  "Adjusts the formatting of the text displaying your character's remaining primary resource.\n\nPercentage:\n50%\n\nNumber:\n50,000\n\nNumber & Maximum:\n50,000/100,000",
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
                identifier       = "kbocd_textAlignmentPrimaryResourceBarDropDown",
                label            = "Alignment",
                defaultValue     = defaultDB.fontAlignment,
                getter           = function()
                    if primaryResourceBarDB.fontAlignment == "LEFT" then
                        return "LEFT"
                    elseif primaryResourceBarDB.fontAlignment == "CENTER" then
                        return "CENTER"
                    elseif primaryResourceBarDB.fontAlignment == "RIGHT" then
                        return "RIGHT"
                    else
                        return "CENTER"
                    end
                end,
                setter           = function(selectedValue)
                    primaryResourceBarDB.fontAlignment = selectedValue

                    local offsetX = 0
                    if primaryResourceBarDB.fontAlignment == "LEFT" then
                        offsetX = 4
                    elseif primaryResourceBarDB.fontAlignment == "RIGHT" then
                        offsetX = -4
                    end
                    primaryResourceBarText:ClearAllPoints()
                    primaryResourceBarText:SetPoint(
                        primaryResourceBarDB.fontAlignment,
                        primaryResourceBar,
                        primaryResourceBarDB.fontAlignment, offsetX, 0
                    )
                end,
                tooltip          = "Adjusts the alignment of the text displaying your character's remaining primary resource.",
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
                identifier       = "kbocd_fontSizePrimaryResourceBarSlider",
                label            = "Size",
                defaultValue     = defaultDB.fontSize,
                getter           = function()
                    return primaryResourceBarDB.fontSize
                end,
                setter           = function(value)
                    primaryResourceBarDB.fontSize = value
                    local fontPath = primaryResourceBarText:GetFont()
                    primaryResourceBarText:SetFont(fontPath, value)
                end,
                tooltip          = "Adjusts the size of the text displaying your character's remaining primary resource.",
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
                identifier       = "kbocd_fontAlphaPrimaryResourceBarSlider",
                label            = "Opacity",
                defaultValue     = defaultDB.fontColor.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.fontColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.fontColor.alpha = alphaValue
                    KBOCD_UI.ApplyFontColor(primaryResourceBarText, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the text displaying your character's remaining primary resource.",
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
                identifier       = "kbocd_barColorAlphaPrimaryResourceBarSlider",
                label            = "Resource Color Opacity",
                defaultValue     = defaultDB.gradientColorValues.firstStop.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.gradientColorValues.firstStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.gradientColorValues.firstStop.alpha = alphaValue
                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the primary resource bar.",
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
                identifier       = "kbocd_barSecondStepColorAlphaPrimaryResourceBarSlider",
                label            = "50% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.secondStop.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.gradientColorValues.secondStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.gradientColorValues.secondStop.alpha = alphaValue
                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the primary resource bar as it approaches 50% remaining.",
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
                identifier       = "kbocd_barThirdStepColorAlphaPrimaryResourceBarSlider",
                label            = "0% Gradient Opacity",
                defaultValue     = defaultDB.gradientColorValues.thirdStop.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.gradientColorValues.thirdStop.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.gradientColorValues.thirdStop.alpha = alphaValue
                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the opacity of the color of the primary resource bar as it approaches 0% remaining.",
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
                identifier       = "kbocd_depletionColorAlphaPrimaryResourceBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.missingColor.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.missingColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.missingColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateDepletionColor(primaryResourceBarBG, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the primary resource bar.",
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
                identifier       = "kbocd_borderColorAlphaPrimaryResourceBarSlider",
                label            = "Depletion Color Opacity",
                defaultValue     = defaultDB.backdropBorderColor.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.backdropBorderColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.backdropBorderColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBorderColor(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the depleted portion of the primary resource bar.",
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
                identifier       = "kbocd_backdropColorAlphaPrimaryResourceBarSlider",
                label            = "Backdrop Color Opacity",
                defaultValue     = defaultDB.backdropColor.alpha * 100,
                getter           = function()
                    return primaryResourceBarDB.backdropColor.alpha * 100
                end,
                setter           = function(value)
                    local alphaValue = value / 100
                    primaryResourceBarDB.backdropColor.alpha = alphaValue
                    KBOCDResourceBars.UpdateBackdropColor(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the opacity of the backdrop of the primary resource bar.",
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
                identifier       = "kbocd_frameXPositionaPrimaryResourceBarSlider",
                label            = "Horizontal Position",
                defaultValue     = defaultDB.xPosition,
                getter           = function()
                    return primaryResourceBarDB.xPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = primaryResourceBarDB.xPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    primaryResourceBarDB.xPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, _, originalY = primaryResourceBarFrame:GetPoint()
                    primaryResourceBarFrame:ClearAllPoints()
                    primaryResourceBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, finalValue, originalY)
                end,
                tooltip          = "Moves the primary resource bar horizontally.",
                options          = function()
                    local maxX = KBOCDResourceBars.screenWidth / 2
                    local minX = -maxX
                    local sliderOptions = Settings.CreateSliderOptions(minX, maxX, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = primaryResourceBarDB.xPosition
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
                identifier       = "kbocd_frameYPositionaPrimaryResourceBarSlider",
                label            = "Vertical Position",
                defaultValue     = defaultDB.yPosition,
                getter           = function()
                    return primaryResourceBarDB.yPosition
                end,
                setter           = function(value, isDefaultValue)
                    local finalValue = nil
                    if isDefaultValue then
                        finalValue = value
                    else
                        local previousValue = primaryResourceBarDB.yPosition
                        finalValue = KBOCD_UI.PositionSliderSetterFinalValueCalculationForValue(value, previousValue)
                        finalValue = finalValue + (value < 0 and -0.33 or 0.33)
                    end
                    primaryResourceBarDB.yPosition = finalValue

                    local originalPoint, originalRelativeTo, originalRelativePoint, originalX, _ = primaryResourceBarFrame:GetPoint()
                    primaryResourceBarFrame:ClearAllPoints()
                    primaryResourceBarFrame:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, originalX, finalValue)
                end,
                tooltip          = "Moves the primary resource bar vertically.",
                options          = function()
                    local maxY = KBOCDResourceBars.screenHeight / 2
                    local minY = -maxY
                    local sliderOptions = Settings.CreateSliderOptions(minY, maxY, 1)
                    sliderOptions:SetLabelFormatter(
                        MinimalSliderWithSteppersMixin.Label.Right,
                        function(value)
                            local previousValue = primaryResourceBarDB.yPosition
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
                identifier       = "kbocd_frameWidthPrimaryResourceBarSlider",
                label            = "Width",
                defaultValue     = defaultDB.width,
                getter           = function()
                    return primaryResourceBarDB.width
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    primaryResourceBarDB.width = roundedValue
                    primaryResourceBarFrame:SetWidth(roundedValue)
                end,
                tooltip          = "Adjust the width of the primary resource bar.",
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
                identifier       = "kbocd_frameHeightPrimaryResourceBarSlider",
                label            = "Height",
                defaultValue     = defaultDB.height,
                getter           = function()
                    return primaryResourceBarDB.height
                end,
                setter           = function(value)
                    local roundedValue = math.floor(value)
                    primaryResourceBarDB.height = roundedValue
                    primaryResourceBarFrame:SetHeight(roundedValue)
                end,
                tooltip          = "Adjust the height of the primary resource bar.",
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
                identifier       = "kbocd_fontColorPrimaryResourceBarColorSwatch",
                label            = "Color",
                defaultValue     = CreateColor(
                    defaultDB.fontColor.red,
                    defaultDB.fontColor.green,
                    defaultDB.fontColor.blue,
                    defaultDB.fontColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.fontColor.red,
                        primaryResourceBarDB.fontColor.green,
                        primaryResourceBarDB.fontColor.blue,
                        primaryResourceBarDB.fontColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.fontColor.red = r
                    primaryResourceBarDB.fontColor.green = g
                    primaryResourceBarDB.fontColor.blue = b
                    primaryResourceBarDB.fontColor.alpha = a

                    KBOCD_UI.ApplyFontColor(primaryResourceBarText, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the text displaying your character's remaining primary resource.",
            },

            barColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_barColorPrimaryResourceBarColorSwatch",
                label            = "Resource Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.firstStop.red,
                    defaultDB.gradientColorValues.firstStop.green,
                    defaultDB.gradientColorValues.firstStop.blue,
                    defaultDB.gradientColorValues.firstStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.gradientColorValues.firstStop.red,
                        primaryResourceBarDB.gradientColorValues.firstStop.green,
                        primaryResourceBarDB.gradientColorValues.firstStop.blue,
                        primaryResourceBarDB.gradientColorValues.firstStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.gradientColorValues.firstStop.red = r
                    primaryResourceBarDB.gradientColorValues.firstStop.green = g
                    primaryResourceBarDB.gradientColorValues.firstStop.blue = b
                    primaryResourceBarDB.gradientColorValues.firstStop.alpha = a

                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the primary resource bar.",
            },

            gradientColorSecondStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorSecondStopPrimaryResourceBarColorSwatch",
                label            = "50% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.secondStop.red,
                    defaultDB.gradientColorValues.secondStop.green,
                    defaultDB.gradientColorValues.secondStop.blue,
                    defaultDB.gradientColorValues.secondStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.gradientColorValues.secondStop.red,
                        primaryResourceBarDB.gradientColorValues.secondStop.green,
                        primaryResourceBarDB.gradientColorValues.secondStop.blue,
                        primaryResourceBarDB.gradientColorValues.secondStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.gradientColorValues.secondStop.red = r
                    primaryResourceBarDB.gradientColorValues.secondStop.green = g
                    primaryResourceBarDB.gradientColorValues.secondStop.blue = b
                    primaryResourceBarDB.gradientColorValues.secondStop.alpha = a

                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the primary resource bar as it approaches 50% remaining. The color will be a gradient from your bars color and this color as it progresses to 50%.",
            },

            gradientColorThirdStop = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_gradientColorThirdStopPrimaryResourceBarColorSwatch",
                label            = "0% Gradient Color",
                defaultValue     = CreateColor(
                    defaultDB.gradientColorValues.thirdStop.red,
                    defaultDB.gradientColorValues.thirdStop.green,
                    defaultDB.gradientColorValues.thirdStop.blue,
                    defaultDB.gradientColorValues.thirdStop.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.gradientColorValues.thirdStop.red,
                        primaryResourceBarDB.gradientColorValues.thirdStop.green,
                        primaryResourceBarDB.gradientColorValues.thirdStop.blue,
                        primaryResourceBarDB.gradientColorValues.thirdStop.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.gradientColorValues.thirdStop.red = r
                    primaryResourceBarDB.gradientColorValues.thirdStop.green = g
                    primaryResourceBarDB.gradientColorValues.thirdStop.blue = b
                    primaryResourceBarDB.gradientColorValues.thirdStop.alpha = a

                    KBOCDResourceBars.Update(primaryResourceBar, primaryResourceBarDB, primaryResourceBarText, KBOCDResourceBars.BarTypeReferenceValues.resource)
                end,
                tooltip          = "Adjusts the color of the primary resource bar as it approaches 0% remaining. The color will be a gradient from your 50% color and this color as it progresses to 0%.",
            },

            depletionColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_depletionColorPrimaryResourceBarColorSwatch",
                label            = "Depletion Color",
                defaultValue     = CreateColor(
                    defaultDB.missingColor.red,
                    defaultDB.missingColor.green,
                    defaultDB.missingColor.blue,
                    defaultDB.missingColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.missingColor.red,
                        primaryResourceBarDB.missingColor.green,
                        primaryResourceBarDB.missingColor.blue,
                        primaryResourceBarDB.missingColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.missingColor.red = r
                    primaryResourceBarDB.missingColor.green = g
                    primaryResourceBarDB.missingColor.blue = b
                    primaryResourceBarDB.missingColor.alpha = a

                    KBOCDResourceBars.UpdateDepletionColor(primaryResourceBarBG, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the depleted portion of the primary resource bar.",
            },

            borderColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_borderColorPrimaryResourceBarColorSwatch",
                label            = "Border Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropBorderColor.red,
                    defaultDB.backdropBorderColor.green,
                    defaultDB.backdropBorderColor.blue,
                    defaultDB.backdropBorderColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.backdropBorderColor.red,
                        primaryResourceBarDB.backdropBorderColor.green,
                        primaryResourceBarDB.backdropBorderColor.blue,
                        primaryResourceBarDB.backdropBorderColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.backdropBorderColor.red = r
                    primaryResourceBarDB.backdropBorderColor.green = g
                    primaryResourceBarDB.backdropBorderColor.blue = b
                    primaryResourceBarDB.backdropBorderColor.alpha = a

                    KBOCDResourceBars.UpdateBorderColor(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the primary resource bar's border.",
            },

            backdropColor = {
                elementType      = KBOCD_UI.elementType.colorSwatch,
                settingsCategory = category,
                identifier       = "kbocd_backdropColorPrimaryResourceBarColorSwatch",
                label            = "Backdrop Color",
                defaultValue     = CreateColor(
                    defaultDB.backdropColor.red,
                    defaultDB.backdropColor.green,
                    defaultDB.backdropColor.blue,
                    defaultDB.backdropColor.alpha
                ):GenerateHexColor(),
                getter           = function()
                    return CreateColor(
                        primaryResourceBarDB.backdropColor.red,
                        primaryResourceBarDB.backdropColor.green,
                        primaryResourceBarDB.backdropColor.blue,
                        primaryResourceBarDB.backdropColor.alpha
                    ):GenerateHexColor()
                end,
                setter           = function(value)
                    local r, g, b, a = CreateColorFromHexString(value):GetRGBA()
                    primaryResourceBarDB.backdropColor.red = r
                    primaryResourceBarDB.backdropColor.green = g
                    primaryResourceBarDB.backdropColor.blue = b
                    primaryResourceBarDB.backdropColor.alpha = a

                    KBOCDResourceBars.UpdateBackdropColor(primaryResourceBarFrame, primaryResourceBarDB)
                end,
                tooltip          = "Adjusts the color of the primary resource bar's backdrop.",
            },
        }
    }
end
