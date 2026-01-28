--------------------------------------------------
-- KBOCDResourceBars Config Panel Section Creation Functions
--------------------------------------------------
local function CreateConfigPanelFor(uiElementCategory, scrollChild, initialAnchorObj)
    local uiElement = uiElementCategory

    local barHeader = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.sectionHeader, scrollChild, initialAnchorObj
    )

    local enableBarButton = KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.enable, scrollChild, barHeader
    )

    local hideBarOutOfCombatAndFullButton = KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.hideOutOfCombatAndFull, scrollChild, enableBarButton
    )

    local displayAsPercentageButton = KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.displayAsPercentage, scrollChild, hideBarOutOfCombatAndFullButton
    )
    if uiElementCategory == KBOCDResourceBars.UIElementValues.healthBar then
        KBOCDResourceBars.displayHealthAsPercentageButton = displayAsPercentageButton
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.displayPrimaryResourceAsPercentageButton = displayAsPercentageButton
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.displayAdditionalResourceAsPercentageButton = displayAsPercentageButton
    end

    local displayMaxValueButton = KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.displayMaxValue, scrollChild, displayAsPercentageButton
    )
    local dividerRelativeAnchor = displayMaxValueButton
    if uiElementCategory == KBOCDResourceBars.UIElementValues.healthBar then
        KBOCDResourceBars.displayHealthMaxValueButton = displayMaxValueButton
        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(
            KBOCDResourceBars.displayHealthAsPercentageButton,
            KBOCDResourceBars.displayHealthMaxValueButton
        )
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.displayPrimaryResourceMaxValueButton = displayMaxValueButton
        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(
            KBOCDResourceBars.displayPrimaryResourceAsPercentageButton,
            KBOCDResourceBars.displayPrimaryResourceMaxValueButton
        )
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.displayAdditionalResourceMaxValueButton = displayMaxValueButton
        KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(
            KBOCDResourceBars.displayAdditionalResourceAsPercentageButton,
            KBOCDResourceBars.displayAdditionalResourceMaxValueButton
        )
    end

    if uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar or uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        local dynamicBarColor = KBOCDResourceBars.CreateCheckButtonFor(
            uiElement.checkBox.dynamicBarColor, scrollChild, displayMaxValueButton
        )
        dividerRelativeAnchor = dynamicBarColor
        if uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
            KBOCDResourceBars.primaryResourceDynamicBarColor = dynamicBarColor
        else
            KBOCDResourceBars.additionalResourceDynamicBarColor = dynamicBarColor
        end
    end

    if uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        local resourceDropdownLabel = KBOCDResourceBars.CreateLabelFor(
            uiElement.label.resourceDropDown, scrollChild, dividerRelativeAnchor
        )
        local resourceDropdown = KBOCDResourceBars.CreateResourceDropDownFor(
            uiElement.dropDownBox.resourceType, scrollChild, resourceDropdownLabel
        )
        dividerRelativeAnchor = resourceDropdown
    end

    KBOCDResourceBars.CreateHorizontalDivider(561.5, scrollChild, dividerRelativeAnchor, "TOPLEFT", "BOTTOMLEFT", 3,
        -12, 0.175)

    local textAlignmentLabel = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.textAlignment, scrollChild, dividerRelativeAnchor
    )
    local textAlignmentDropdown = KBOCDResourceBars.CreateFontAlignmentDropDownFor(
        uiElement.dropDownBox.fontAlignment, scrollChild, textAlignmentLabel
    )

    KBOCDResourceBars.CreateLabelFor(
        uiElement.label.fontSize, scrollChild, textAlignmentLabel
    )
    local textFontSizeBox = KBOCDResourceBars.CreateFontSizeBoxFor(
        uiElement.fontSizeBox.barFont, scrollChild, textAlignmentDropdown
    )

    local textColorSwatch = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.fontColor, scrollChild, textFontSizeBox
    )

    KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.showTextShadow, scrollChild, textColorSwatch
    )

    KBOCDResourceBars.CreateHorizontalDivider(561.5, scrollChild, textAlignmentDropdown, "TOPLEFT", "BOTTOMLEFT", -2,
        -14, 0.175)

    local gradientFirstStopColorSwatch, gradientFirstStopColorLabel = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.gradientFirstStop, scrollChild, textAlignmentDropdown
    )
    if uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.primaryResourceGradientFirstStopColorSwatch = gradientFirstStopColorSwatch
        KBOCDResourceBars.primaryResourceFirstStopColorlabel = gradientFirstStopColorLabel
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.primaryResourceDynamicBarColor:GetChecked(),
            KBOCDResourceBars.primaryResourceGradientFirstStopColorSwatch,
            KBOCDResourceBars.primaryResourceFirstStopColorlabel
        )
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.additionalResourceGradientFirstStopColorSwatch = gradientFirstStopColorSwatch
        KBOCDResourceBars.additionalResourceFirstStopColorlabel = gradientFirstStopColorLabel
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.additionalResourceDynamicBarColor:GetChecked(),
            KBOCDResourceBars.additionalResourceGradientFirstStopColorSwatch,
            KBOCDResourceBars.additionalResourceFirstStopColorlabel
        )
    end

    local gradientSecondStopColorSwatch, gradientSecondStopColorlabel = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.gradientSecondStop, scrollChild, gradientFirstStopColorSwatch
    )
    if uiElementCategory == KBOCDResourceBars.UIElementValues.healthBar then
        KBOCDResourceBars.healthGradientSecondStopColorSwatch = gradientSecondStopColorSwatch
        KBOCDResourceBars.healthGradientSecondStopColorlabel = gradientSecondStopColorlabel
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.primaryResourceGradientSecondStopColorSwatch = gradientSecondStopColorSwatch
        KBOCDResourceBars.primaryResourceSecondStopColorlabel = gradientSecondStopColorlabel
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.additionalResourceGradientSecondStopColorSwatch = gradientSecondStopColorSwatch
        KBOCDResourceBars.additionalResourceSecondStopColorlabel = gradientSecondStopColorlabel
    end

    local gradientThirdStopColorSwatch, gradientThirdStopColorlabel = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.gradientThirdStop, scrollChild, gradientSecondStopColorSwatch
    )
    if uiElementCategory == KBOCDResourceBars.UIElementValues.healthBar then
        KBOCDResourceBars.healthGradientThirdStopColorSwatch = gradientThirdStopColorSwatch
        KBOCDResourceBars.healthGradientThirdStopColorlabel = gradientThirdStopColorlabel
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.primaryResourceGradientThirdStopColorSwatch = gradientThirdStopColorSwatch
        KBOCDResourceBars.primaryResourceGradientThirdStopColorlabel = gradientThirdStopColorlabel
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.additionalResourceGradientThirdStopColorSwatch = gradientThirdStopColorSwatch
        KBOCDResourceBars.additionalResourceGradientThirdStopColorlabel = gradientThirdStopColorlabel
    end

    local useGradientColorsButton = KBOCDResourceBars.CreateCheckButtonFor(
        uiElement.checkBox.useGradientColors, scrollChild, gradientThirdStopColorSwatch
    )
    if uiElementCategory == KBOCDResourceBars.UIElementValues.healthBar then
        KBOCDResourceBars.healthUseGradientColorsButton = useGradientColorsButton
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.healthUseGradientColorsButton,
            KBOCDResourceBars.healthGradientSecondStopColorSwatch,
            KBOCDResourceBars.healthGradientSecondStopColorlabel
        )
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.healthUseGradientColorsButton,
            KBOCDResourceBars.healthGradientThirdStopColorSwatch,
            KBOCDResourceBars.healthGradientThirdStopColorlabel
        )
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.primaryResourceBar then
        KBOCDResourceBars.primaryResourceUseGradientColorsButton = useGradientColorsButton
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.primaryResourceUseGradientColorsButton,
            KBOCDResourceBars.primaryResourceGradientSecondStopColorSwatch,
            KBOCDResourceBars.primaryResourceSecondStopColorlabel
        )
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.primaryResourceUseGradientColorsButton,
            KBOCDResourceBars.primaryResourceGradientThirdStopColorSwatch,
            KBOCDResourceBars.primaryResourceGradientThirdStopColorlabel
        )
    elseif uiElementCategory == KBOCDResourceBars.UIElementValues.additionalResourceBar then
        KBOCDResourceBars.additionalResourceUseGradientColorsButton = useGradientColorsButton
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.additionalResourceUseGradientColorsButton,
            KBOCDResourceBars.additionalResourceGradientSecondStopColorSwatch,
            KBOCDResourceBars.additionalResourceSecondStopColorlabel
        )
        KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(
            KBOCDResourceBars.additionalResourceUseGradientColorsButton,
            KBOCDResourceBars.additionalResourceGradientThirdStopColorSwatch,
            KBOCDResourceBars.additionalResourceGradientThirdStopColorlabel
        )
    end
    KBOCDResourceBars.CreateHorizontalDivider(561.5, scrollChild, gradientFirstStopColorSwatch, "TOPLEFT",
        "BOTTOMLEFT", -21.1, -20, 0.175)

    local missingColorSwatch = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.depletionColor, scrollChild, gradientFirstStopColorSwatch
    )

    local borderColorSwatch = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.borderColor, scrollChild, missingColorSwatch
    )

    local backdropColorSwatch = KBOCDResourceBars:CreateColorSwatchFor(
        uiElement.colorSwatch.backdropColor, scrollChild, borderColorSwatch
    )

    KBOCDResourceBars.CreateHorizontalDivider(561.5, scrollChild, missingColorSwatch, "TOPLEFT", "BOTTOMLEFT", -39.5,
        -20, 0.175)

    local barWidthText = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.barWidth, scrollChild, missingColorSwatch
    )
    KBOCDResourceBars.CreateDimensionBoxFor(
        uiElement.dimensionBox.barWidth, scrollChild, barWidthText
    )

    local barHeightText = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.barHeight, scrollChild, barWidthText
    )
    KBOCDResourceBars.CreateDimensionBoxFor(
        uiElement.dimensionBox.barHeight, scrollChild, barHeightText
    )

    local barXPositionText = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.barXPosition, scrollChild, barHeightText
    )
    KBOCDResourceBars.CreatePositionBoxFor(
        uiElement.positionBox.barPositionX, scrollChild, barXPositionText
    )

    local barYPositionText = KBOCDResourceBars.CreateLabelFor(
        uiElement.label.barYPosition, scrollChild, barXPositionText
    )
    KBOCDResourceBars.CreatePositionBoxFor(
        uiElement.positionBox.barPositionY, scrollChild, barYPositionText
    )

    KBOCDResourceBars.CreateResetButtonFor(
        uiElement.resetButton, scrollChild, barYPositionText
    )

    return barWidthText
end

--------------------------------------------------
-- KBOCDResourceBars Config Panel
--------------------------------------------------
function KBOCDResourceBars:CreateConfigPanel()
    local panel = CreateFrame("Frame")
    panel.name = "KBOCD Resource Bars"

    local category = Settings.RegisterCanvasLayoutCategory(panel, "KBOCD Resource Bars")
    Settings.RegisterAddOnCategory(category)

    -- For some reason, trying to open the config pane after selecting a different addon will always fail
    -- Forcing it to hide once on initial load fixes this
    panel:SetScript("OnUpdate", function()
        panel:Hide()
        panel:SetScript("OnUpdate", nil)
    end)

    panel:SetScript("OnHide", function()
        KBOCDResourceBars.UpdateBarStrata(false, KBOCDResourceBars.healthBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(false, KBOCDResourceBars.primaryResourceBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(false, KBOCDResourceBars.additionalResourceBarFrameGlobal)
    end)

    panel:SetScript("OnShow", function(self)
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.healthBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.primaryResourceBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.additionalResourceBarFrameGlobal)
        if self.initialized then return end
        self.initialized = true

        local globalUIElement = KBOCDResourceBars.UIElementValues.global

        local title = KBOCDResourceBars.CreateLabelFor(
            globalUIElement.label.configHeader, self, panel
        )
        local subtitle = KBOCDResourceBars.CreateLabelFor(
            globalUIElement.label.configSubtitle, self, title
        )

        KBOCDResourceBars.CreateCheckButtonFor(
            globalUIElement.checkBox.viewBarsAboveOptions, self, subtitle
        )
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.healthBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.primaryResourceBarFrameGlobal)
        KBOCDResourceBars.UpdateBarStrata(KBOCDResourceBarsDB.moveAboveOptions, KBOCDResourceBars.additionalResourceBarFrameGlobal)

        local headerDivider = KBOCDResourceBars.CreateHorizontalDivider(610, self, subtitle, "TOPLEFT", "BOTTOMLEFT", 0, -6)

        local scrollFrame = CreateFrame("ScrollFrame", nil, self, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", headerDivider, "BOTTOMLEFT", 0, 0)
        scrollFrame:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -30, 10)

        local scrollChild = CreateFrame("Frame", nil, scrollFrame)
        scrollChild:SetPoint("TOPLEFT")
        scrollChild:SetSize(scrollFrame:GetWidth(), 1)
        scrollFrame:SetScrollChild(scrollChild)

        scrollChild:SetHeight(1800) -- Adjust to make scrolling go down further

        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local cur = self:GetVerticalScroll()
            local max = self:GetVerticalScrollRange()
            local step = 30 -- How many pixels to move per scroll notch

            if delta > 0 then
                -- Scroll Up
                self:SetVerticalScroll(math.max(0, cur - step))
            else
                -- Scroll Down
                self:SetVerticalScroll(math.min(max, cur + step))
            end
        end)

        local finalUIElementForHealthConfigPanelForRelativePoint = CreateConfigPanelFor(KBOCDResourceBars.UIElementValues.healthBar, scrollChild, scrollChild)

        local sectionOneDivider = KBOCDResourceBars.CreateHorizontalDivider(610, scrollChild, finalUIElementForHealthConfigPanelForRelativePoint, "TOPLEFT", "BOTTOMLEFT", -20, -50)

        local finalUIElementForPrimaryResourceConfigPanelForRelativePoint = CreateConfigPanelFor(KBOCDResourceBars.UIElementValues.primaryResourceBar, scrollChild, sectionOneDivider)

        local sectionTwoDivider = KBOCDResourceBars.CreateHorizontalDivider(610, scrollChild, finalUIElementForPrimaryResourceConfigPanelForRelativePoint, "TOPLEFT", "BOTTOMLEFT", -20, -50)

        local finalUIElementForAdditionalResourceConfigPanelForRelativePoint = CreateConfigPanelFor(KBOCDResourceBars.UIElementValues.additionalResourceBar, scrollChild, sectionTwoDivider)

        local sectionThreeDivider = KBOCDResourceBars.CreateHorizontalDivider(610, scrollChild, finalUIElementForAdditionalResourceConfigPanelForRelativePoint, "TOPLEFT", "BOTTOMLEFT", -20, -50)

        local extrasHeader = KBOCDResourceBars.CreateLabelFor(
            KBOCDResourceBars.UIElementValues.global.label.extrasHeader, scrollChild, sectionThreeDivider
        )
        local displayHealthPercentageNextToPlayerFrame = KBOCDResourceBars.CreateCheckButtonFor(
            KBOCDResourceBars.UIElementValues.global.checkBox.displayHealthPercentageNextToPlayerFrame, scrollChild, extrasHeader
        )
        local displayPrimaryResourcePercentageNextToPlayerFrame = KBOCDResourceBars.CreateCheckButtonFor(
            KBOCDResourceBars.UIElementValues.global.checkBox.displayPrimaryResourcePercentageNextToPlayerFrame, scrollChild, displayHealthPercentageNextToPlayerFrame
        )
        local displayAdditionalResourcePercentageNextToPlayerFrame = KBOCDResourceBars.CreateCheckButtonFor(
            KBOCDResourceBars.UIElementValues.global.checkBox.displayAdditionalResroucePercentageNextToPlayerFrame, scrollChild, displayPrimaryResourcePercentageNextToPlayerFrame
        )
        KBOCDResourceBars.CreateCheckButtonFor(
            KBOCDResourceBars.UIElementValues.global.checkBox.displayHealthPercentageOverTargetFrame, scrollChild, displayAdditionalResourcePercentageNextToPlayerFrame
        )

    end)
end

--------------------------------------------------
-- Event Handling
--------------------------------------------------
local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:RegisterEvent("PLAYER_LOGIN")
addonLoadedFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
addonLoadedFrame:RegisterEvent("UNIT_DISPLAYPOWER")
addonLoadedFrame:RegisterUnitEvent("UNIT_HEALTH", "target")
addonLoadedFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

addonLoadedFrame:SetScript("OnEvent", function(_, event, eventValue)
    if event == "ADDON_LOADED" and eventValue == "KBOCDResourceBars" then
        KBOCDResourceBars.InitializeUserValues()
    elseif event == "PLAYER_LOGIN" then
        KBOCDResourceBars.CreateHealthBar()
        KBOCDResourceBars.CreatePrimaryResourceBar()
        KBOCDResourceBars.CreateAdditionalResourceBar()
        KBOCDResourceBars.playerUnitFrameHealthText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 55)
        KBOCDResourceBars.playerUnitFramePrimaryResourceText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 38.5)
        KBOCDResourceBars.playerUnitFrameAdditionalResourceText = KBOCDResourceBars.CreatePlayerUnitFrameText(PlayerFrame, "", 112.5, 26.5)
        KBOCDResourceBars.targetUnitFrameHealthText = KBOCDResourceBars.CreateTargetUnitFrameText(TargetFrame, "", -25, 55)

        KBOCDResourceBars.InitializeConfigCoreAliases() -- Must call after global values are created with bar creation function calls
        KBOCDResourceBars.CreateUIElementValuesTable()
    elseif event == "PLAYER_ENTERING_WORLD" and not KBOCDResourceBars.initialEnteringWorldCompleted then
        KBOCDResourceBars.Update(KBOCDResourceBars.healthBarGlobal, KBOCDResourceBarsDB.healthBar, KBOCDResourceBars.healthBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.health)
        KBOCDResourceBars.Update(KBOCDResourceBars.primaryResourceBarGlobal, KBOCDResourceBarsDB.primaryResourceBar, KBOCDResourceBars.primaryResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.Update(KBOCDResourceBars.additionalResourceBarGlobal, KBOCDResourceBarsDB.additionalResourceBar, KBOCDResourceBars.additionalResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.UpdateVisibility(KBOCDResourceBars.healthBarFrameGlobal, KBOCDResourceBarsDB.healthBar)
        KBOCDResourceBars.UpdateVisibility(KBOCDResourceBars.primaryResourceBarFrameGlobal, KBOCDResourceBarsDB.primaryResourceBar)

        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageNextToPlayerFrame")
        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFramePrimaryResourceText, KBOCDResourceBarsDB, "displayPrimaryResourcePercentageNextToPlayerFrame")
        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.playerUnitFrameAdditionalResourceText, KBOCDResourceBarsDB, "displayAdditionalResourcePercentageNextToPlayerFrame")
        KBOCDResourceBars.UpdateExtrasFrameVisibility(KBOCDResourceBars.targetUnitFrameHealthText, KBOCDResourceBarsDB, "displayHealthPercentageOverTargetFrame")
        if KBOCDResourceBarsDB.displayHealthPercentageOverTargetFrame then
            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(0)
        else
            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBarText:SetAlpha(1)
        end

        KBOCDResourceBars:CreateConfigPanel()
        DEFAULT_CHAT_FRAME:AddMessage("|cfff2e147KBOCDResourceBars |cffa19d78loaded.|r")

        KBOCDResourceBars.initialEnteringWorldCompleted = true
    elseif event == "UNIT_DISPLAYPOWER" then
        if eventValue and eventValue ~= "player" then return end
        KBOCDResourceBars.Update(KBOCDResourceBars.primaryResourceBarGlobal, KBOCDResourceBarsDB.primaryResourceBar, KBOCDResourceBars.primaryResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
        KBOCDResourceBars.Update(KBOCDResourceBars.additionalResourceBarGlobal, KBOCDResourceBarsDB.additionalResourceBar, KBOCDResourceBars.additionalResourceBarTextGlobal, KBOCDResourceBars.BarTypeReferenceValues.resource)
    elseif event == "UNIT_HEALTH" or event == "PLAYER_TARGET_CHANGED" then
        KBOCDResourceBars.UpdateTargetHealthPercentage()
    end
end)
