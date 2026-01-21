--------------------------------------------------
-- Element Creator Functions
--------------------------------------------------
function KBOCDResourceBars.CreateBarFrame(anchorFrame, barTable)
    local barFrame = CreateFrame("Frame", nil, anchorFrame, "BackdropTemplate")
    barFrame:SetSize(barTable.width, barTable.height)
    barFrame:SetPoint("CENTER", anchorFrame, "CENTER", barTable.xPosition, barTable.yPosition)
    barFrame:SetFrameStrata("MEDIUM")
    barFrame:SetFrameLevel(50)

    barFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
     barFrame:SetBackdropColor(
        barTable.backdropColor.red,
        barTable.backdropColor.green,
        barTable.backdropColor.blue,
        barTable.backdropColor.alpha
    )
    barFrame:SetBackdropBorderColor(
        barTable.backdropBorderColor.red,
        barTable.backdropBorderColor.green,
        barTable.backdropBorderColor.blue,
        barTable.backdropBorderColor.alpha
    )

    return barFrame
end

function KBOCDResourceBars.CreateBarContainer(anchorFrame)
    local barContainer = CreateFrame("Frame", nil, anchorFrame, "BackdropTemplate")
    barContainer:SetPoint("TOPLEFT", 4, -4)
    barContainer:SetPoint("BOTTOMRIGHT", -4, 4)
    barContainer:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    barContainer:SetBackdropColor(0, 0, 0, 0)
    barContainer:SetBackdropBorderColor(0, 0, 0, 0)

    return barContainer
end

function KBOCDResourceBars.CreateStatusBar(anchorFrame, barTable)
    local statusBar = CreateFrame("StatusBar", nil, anchorFrame)
    statusBar:SetAllPoints()
    statusBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusBar:SetMinMaxValues(0, 1)
    statusBar:SetValue(1)

    local bg = statusBar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    bg:SetVertexColor(
        barTable.missingColor.red,
        barTable.missingColor.green,
        barTable.missingColor.blue,
        barTable.missingColor.alpha
    )

    return statusBar, bg
end

function KBOCDResourceBars.CreateBarText(bar, barTable)
    local text = bar:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", barTable.fontSize)
    text:SetTextColor(
        barTable.fontColor.red,
        barTable.fontColor.green,
        barTable.fontColor.blue,
        barTable.fontColor.alpha
    )
    if barTable.fontDropShadowEnabled then
        text:SetShadowOffset(1, -1)
        text:SetShadowColor(0, 0, 0, 1)
    end
    local offsetX = 0
    if barTable.fontAlignment == "LEFT" then
        offsetX = 4
    elseif barTable.fontAlignment == "RIGHT" then
        offsetX = -4
    end
    text:SetPoint(barTable.fontAlignment, bar, barTable.fontAlignment, offsetX, 0)

    return text
end

function KBOCDResourceBars.CreatePlayerUnitFrameText(frameToAnchor, value, xPos, yPos)
    local frame = frameToAnchor
    local text = frame:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", 10.5)
    text:SetTextColor(1, 1, 1, 1)
    text:SetShadowOffset(1, -1)
    text:SetShadowColor(0, 0, 0, 1)
    text:SetPoint("TOP", frame, "BOTTOM", xPos, yPos)
    text:SetText(value)

    return text
end

function KBOCDResourceBars.CreateTargetUnitFrameText(frameToAnchor, value, xPos, yPos)
    local textFrame = CreateFrame("Frame", nil, frameToAnchor)
    textFrame:SetAllPoints(frameToAnchor)
    textFrame:SetFrameStrata("MEDIUM")
    textFrame:SetFrameLevel(100)
    textFrame:SetClipsChildren(false)
    local text = textFrame:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", 10.5)
    text:SetTextColor(1, 1, 1, 1)
    text:SetShadowOffset(1, -1)
    text:SetShadowColor(0, 0, 0, 1)
    text:SetPoint("TOP", frameToAnchor, "BOTTOM", xPos, yPos)
    text:SetJustifyH("CENTER")
    text:SetText(value)

    return text
end

--------------------------------------------------
-- Element Modification Functions
--------------------------------------------------
function KBOCDResourceBars.GradientCurve(barTable)
    local curve = C_CurveUtil.CreateColorCurve()
    curve:SetType(Enum.LuaCurveType.Linear)
    curve:AddPoint(0.25, CreateColor(
        barTable.gradientColorValues.thirdStop.red,
        barTable.gradientColorValues.thirdStop.green,
        barTable.gradientColorValues.thirdStop.blue,
        barTable.gradientColorValues.thirdStop.alpha)
    )
    curve:AddPoint(0.55, CreateColor(
        barTable.gradientColorValues.secondStop.red,
        barTable.gradientColorValues.secondStop.green,
        barTable.gradientColorValues.secondStop.blue,
        barTable.gradientColorValues.secondStop.alpha)
    )
    if barTable == KBOCDResourceBarsDB.primaryResourceBar and KBOCDResourceBarsDB.primaryResourceBar.dynamicBarColor then
        local _, powerToken = UnitPowerType("player")
        local resourceColor = KBOCDResourceBars.ResourceColor[powerToken]
        if resourceColor == nil then
            resourceColor = KBOCDResourceBars.ResourceColor.MANA
        end
        curve:AddPoint(1, CreateColor(
            resourceColor.red,
            resourceColor.green,
            resourceColor.blue,
            resourceColor.alpha)
        )
    elseif barTable == KBOCDResourceBarsDB.additionalResourceBar and KBOCDResourceBarsDB.additionalResourceBar.dynamicBarColor then
        local resourceColor = KBOCDResourceBars.ResourceColor[KBOCDResourceBarsDB.additionalResourceBar.resourceToken]
        if resourceColor == nil then
            resourceColor = KBOCDResourceBars.ResourceColor.MANA
        end
        curve:AddPoint(1, CreateColor(
            resourceColor.red,
            resourceColor.green,
            resourceColor.blue,
            resourceColor.alpha)
        )
    else
        curve:AddPoint(1, CreateColor(
            barTable.gradientColorValues.firstStop.red,
            barTable.gradientColorValues.firstStop.green,
            barTable.gradientColorValues.firstStop.blue,
            barTable.gradientColorValues.firstStop.alpha)
        )
    end

    return curve
end

function KBOCDResourceBars.Update(bar, barTable, barText, barType)
    local current = barType.current("player")
    local max = barType.max("player")
    if bar == KBOCDResourceBars.additionalResourceBarGlobal then
        current = barType.current("player", KBOCDResourceBars.PowerTokenToType[KBOCDResourceBarsDB.additionalResourceBar.resourceToken])
        max = barType.max("player", KBOCDResourceBars.PowerTokenToType[KBOCDResourceBarsDB.additionalResourceBar.resourceToken])
    end
    if max == 0 and bar ~= KBOCDResourceBars.additionalResourceBarGlobal then return end

    bar:SetMinMaxValues(0, max)
    bar:SetValue(current)

    local percentage = nil
    if bar == KBOCDResourceBars.healthBarGlobal then
        percentage = UnitHealthPercent(
            "player",
            true,
            CurveConstants.ScaleTo100
        )
        KBOCDResourceBars.playerUnitFrameHealthText:SetText(string.format("%.0f%%", percentage))
    elseif bar == KBOCDResourceBars.primaryResourceBarGlobal then
        percentage = UnitPowerPercent(
            "player",
            nil,
            true,
            CurveConstants.ScaleTo100
        )
        KBOCDResourceBars.playerUnitFramePrimaryResourceText:SetText(string.format("%.0f%%", percentage))
    elseif bar == KBOCDResourceBars.additionalResourceBarGlobal then
        percentage = UnitPowerPercent(
            "player",
            KBOCDResourceBars.PowerTokenToType[KBOCDResourceBarsDB.additionalResourceBar.resourceToken],
            true,
            CurveConstants.ScaleTo100
        )
        KBOCDResourceBars.playerUnitFrameAdditionalResourceText:SetText(string.format("%.0f%%", percentage))
    end

    local showPercentage = barTable.showPercentage
    local showMaxValue = barTable.showMaxValue
    if showPercentage then
        barText:SetText(string.format("%.0f%%", percentage))
    elseif showMaxValue then
        barText:SetText(BreakUpLargeNumbers(current).." / ".. BreakUpLargeNumbers(max))
    else
        barText:SetText(BreakUpLargeNumbers(current))
    end

    if barTable.useColorGradient then
        local gradientCurve = KBOCDResourceBars.GradientCurve(barTable)
        local color = nil
        if bar == KBOCDResourceBars.healthBarGlobal then
            color = UnitHealthPercent("player", true, gradientCurve)
        elseif bar == KBOCDResourceBars.primaryResourceBarGlobal then
            color = UnitPowerPercent("player", nil, true, gradientCurve)
        elseif bar == KBOCDResourceBars.additionalResourceBarGlobal then
            color = UnitPowerPercent("player", KBOCDResourceBars.PowerTokenToType[KBOCDResourceBarsDB.additionalResourceBar.resourceToken], true, gradientCurve)
        end

        bar:GetStatusBarTexture():SetVertexColor(color:GetRGBA())
    else
        if barTable == KBOCDResourceBarsDB.primaryResourceBar and KBOCDResourceBarsDB.primaryResourceBar.dynamicBarColor then
            local _, powerToken = UnitPowerType("player")
            local resourceColor = KBOCDResourceBars.ResourceColor[powerToken]
            if resourceColor == nil then
                resourceColor = KBOCDResourceBars.ResourceColor.MANA
            end
            bar:SetStatusBarColor(
                resourceColor.red,
                resourceColor.green,
                resourceColor.blue,
                resourceColor.alpha
            )
        elseif barTable == KBOCDResourceBarsDB.additionalResourceBar and KBOCDResourceBarsDB.additionalResourceBar.dynamicBarColor then
            local resourceColor = KBOCDResourceBars.ResourceColor[KBOCDResourceBarsDB.additionalResourceBar.resourceToken]
            if resourceColor == nil then
                resourceColor = KBOCDResourceBars.ResourceColor.MANA
            end
            bar:SetStatusBarColor(
                resourceColor.red,
                resourceColor.green,
                resourceColor.blue,
                resourceColor.alpha
            )
        else
            bar:SetStatusBarColor(
                barTable.gradientColorValues.firstStop.red,
                barTable.gradientColorValues.firstStop.green,
                barTable.gradientColorValues.firstStop.blue,
                barTable.gradientColorValues.firstStop.alpha
            )
        end
    end
end

function KBOCDResourceBars.UpdateVisibility(barFrame, barTable)
    if not barTable.enabled then
        barFrame:SetAlpha(0)
        return
    end

    local inCombat = UnitAffectingCombat("player")
    if not inCombat and barTable.hideOutOfCombatAndFull then
        if barFrame == KBOCDResourceBars.healthBarFrameGlobal then
            barFrame:SetAlpha(UnitHealthMissing("player"))
        elseif barFrame == KBOCDResourceBars.primaryResourceBarFrameGlobal then
            local _, powerToken = UnitPowerType("player")
            if KBOCDResourceBars.ResourceIdlesAtFull[powerToken] then
                barFrame:SetAlpha(UnitPowerMissing("player"))
            else
                barFrame:SetAlpha(UnitPower("player"))
            end
        elseif barFrame == KBOCDResourceBars.additionalResourceBarFrameGlobal then
            if KBOCDResourceBars.ResourceIdlesAtFull[barTable.resourceToken] then
                barFrame:SetAlpha(UnitPowerMissing("player", KBOCDResourceBars.PowerTokenToType[barTable.resourceToken]))
            else
                barFrame:SetAlpha(UnitPower("player", KBOCDResourceBars.PowerTokenToType[barTable.resourceToken]))
            end
        end
    else
        barFrame:SetAlpha(1)
    end
end

function KBOCDResourceBars.UpdateDepletionColor(bar, barTable)
    bar:SetVertexColor(
        barTable.missingColor.red,
        barTable.missingColor.green,
        barTable.missingColor.blue,
        barTable.missingColor.alpha
    )
end

function KBOCDResourceBars.UpdateBorderColor(barFrame, barTable)
    barFrame:SetBackdropBorderColor(
        barTable.backdropBorderColor.red,
        barTable.backdropBorderColor.green,
        barTable.backdropBorderColor.blue,
        barTable.backdropBorderColor.alpha
    )
end

function KBOCDResourceBars.UpdateBackdropColor(barFrame, barTable)
    barFrame:SetBackdropColor(
        barTable.backdropColor.red,
        barTable.backdropColor.green,
        barTable.backdropColor.blue,
        barTable.backdropColor.alpha
    )
end

--------------------------------------------------
-- Event Handling
--------------------------------------------------
function KBOCDResourceBars.RegisterEvents(barFrame, bar, barTable, barText, barType, eventType)
    barFrame:RegisterEvent(eventType.change)
    if eventType.change ~= eventType.maxChange then
        barFrame:RegisterEvent(eventType.maxChange)
    end
    barFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    barFrame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- left combat
    barFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- entered combat

    barFrame:SetScript("OnEvent", function(self, event, unit)
        if unit and unit ~= "player" then return end
        if event == eventType.change or event == eventType.maxChange or event == "PLAYER_ENTERING_WORLD" then
            KBOCDResourceBars.Update(bar, barTable, barText, barType)
            KBOCDResourceBars.UpdateVisibility(barFrame, barTable)
        elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
            KBOCDResourceBars.UpdateVisibility(barFrame, barTable)
        end
    end)
end