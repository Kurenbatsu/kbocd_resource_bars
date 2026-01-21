--------------------------------------------------
-- Element Creator Functions
--------------------------------------------------
function KBOCDResourceBars:CreateColorSwatchFor(colorSwatch, parent, relativeTo)
    -- Button
    local swatchFrame = CreateFrame("Button", nil, parent)
    swatchFrame:SetSize(20, 20)
    swatchFrame:SetPoint(colorSwatch.point, relativeTo, colorSwatch.relativePoint, colorSwatch.xPos, colorSwatch.yPos)

    --------------------------------------------------
    -- Black border
    --------------------------------------------------
    swatchFrame.bg = swatchFrame:CreateTexture(nil, "BACKGROUND")
    swatchFrame.bg:SetAllPoints()
    swatchFrame.bg:SetColorTexture(0, 0, 0, 1)

    --------------------------------------------------
    -- Checkerboard (manual tiles for alpha)
    --------------------------------------------------
    swatchFrame.checker = CreateFrame("Frame", nil, swatchFrame)
    swatchFrame.checker:SetPoint("TOPLEFT", 1, -1)
    swatchFrame.checker:SetPoint("BOTTOMRIGHT", -1, 1)
    swatchFrame.checker:SetFrameLevel(swatchFrame:GetFrameLevel())

    local tileSize = 4.5
    swatchFrame.checker.tiles = {}

    for y = 0, 3 do
        for x = 0, 3 do
            local tile = swatchFrame.checker:CreateTexture(nil, "ARTWORK")
            tile:SetSize(tileSize, tileSize)
            tile:SetPoint("TOPLEFT", x * tileSize, -y * tileSize)
            tile:SetTexture("Interface\\Buttons\\WHITE8x8")

            if (x + y) % 2 == 0 then
                tile:SetVertexColor(0.75, 0.75, 0.75, 1)
            else
                tile:SetVertexColor(0.45, 0.45, 0.45, 1)
            end

            table.insert(swatchFrame.checker.tiles, tile)
        end
    end

    swatchFrame.checker:Hide()

    --------------------------------------------------
    -- Color fill (actual color with alpha)
    --------------------------------------------------
    swatchFrame.color = swatchFrame:CreateTexture(nil, "OVERLAY")
    swatchFrame.color:SetPoint("TOPLEFT", 1, -1)
    swatchFrame.color:SetPoint("BOTTOMRIGHT", -1, 1)

    --------------------------------------------------
    -- Label
    --------------------------------------------------
    local label = nil
    if colorSwatch.label then
        label = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        label:SetPoint("CENTER", swatchFrame, "CENTER", 0, 26)
        label:SetText(colorSwatch.label)
    end

    --------------------------------------------------
    -- Update function
    --------------------------------------------------
    local function UpdateSwatch()
        local c = colorSwatch.db[colorSwatch.dbKey]

        swatchFrame.color:SetColorTexture(c.red, c.green, c.blue, c.alpha or 1)

        if (c.alpha or 1) < 1 then
            swatchFrame.checker:Show()
        else
            swatchFrame.checker:Hide()
        end

        if colorSwatch.closure then colorSwatch.closure() end
    end

    UpdateSwatch()

    --------------------------------------------------
    -- OnClick handler for color picker
    --------------------------------------------------
    swatchFrame:SetScript("OnClick", function()
        if not ColorPickerFrame then
            UIParentLoadAddOn("Blizzard_ColorPicker")
        end

        local c = colorSwatch.db[colorSwatch.dbKey]

        local function ColorPickerCallback()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = ColorPickerFrame:GetColorAlpha()
            c.red, c.green, c.blue, c.alpha = r, g, b, a

            UpdateSwatch()
        end

        ColorPickerFrame:SetupColorPickerAndShow({
            r = c.red,
            g = c.green,
            b = c.blue,
            opacity = c.alpha or 1,
            hasOpacity = true,
            swatchFunc = ColorPickerCallback,
            opacityFunc = ColorPickerCallback,
            cancelFunc = function()
                local r, g, b, a = ColorPickerFrame:GetPreviousValues()
                c.red, c.green, c.blue, c.alpha = r, g, b, a

                UpdateSwatch()
            end,
        })
    end)

    return swatchFrame, label
end

function KBOCDResourceBars.CreateLabelFor(label, parent, anchor)
    local fontString = parent:CreateFontString(nil, "ARTWORK", label.style)
    fontString:SetPoint(label.point, anchor, label.relativePoint, label.xPos, label.yPos)
    fontString:SetText(label.string)

    return fontString
end

function KBOCDResourceBars.CreateHorizontalDivider(width, parent, anchor, point, relativePoint, xPos, yPos, alpha)
    local divider = parent:CreateTexture(nil, "ARTWORK")
    divider:SetPoint(point, anchor, relativePoint, xPos, yPos)
    divider:SetSize(width, 1)
    divider:SetColorTexture(1, 1, 1, alpha or 0.4)

    return divider
end

function KBOCDResourceBars.CreateCheckButtonFor(checkBox, parent, anchor)
    local checkBoxFrame = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkBoxFrame:SetPoint(checkBox.point, anchor, checkBox.relativePoint, checkBox.xPos, checkBox.yPos)

    checkBoxFrame.Text:SetFontObject("GameFontNormal")
    checkBoxFrame.Text:SetText(checkBox.label)
    checkBoxFrame:SetChecked(checkBox.db[checkBox.dbKey])

    checkBoxFrame:SetScript("OnClick", function(btn)
        local enabled = btn:GetChecked()
        checkBox.db[checkBox.dbKey] = enabled
        if checkBox.closure then
            checkBox.closure(enabled)
        end
    end)

    return checkBoxFrame
end

function KBOCDResourceBars.CreateFontAlignmentDropDownFor(dropDownMenu, parent, anchor)
    local dropDownFrame = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropDownFrame:SetPoint(dropDownMenu.point, anchor, dropDownMenu.relativePoint, dropDownMenu.xPos, dropDownMenu.yPos)

    local alignmentOptions = { "LEFT", "CENTER", "RIGHT" }
    UIDropDownMenu_Initialize(dropDownFrame,
        function()
            for i, align in ipairs(alignmentOptions) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = align
                info.checked = (dropDownMenu.db.fontAlignment == align)
                info.func = function()
                    dropDownMenu.db.fontAlignment = align     -- save selection
                    if dropDownMenu.textToAlign then
                        local offsetX = 0
                        if dropDownMenu.db.fontAlignment == "LEFT" then
                            offsetX = 4
                        elseif dropDownMenu.db.fontAlignment == "RIGHT" then
                            offsetX = -4
                        end

                        dropDownMenu.textToAlign:ClearAllPoints()
                        dropDownMenu.textToAlign:SetPoint(
                            dropDownMenu.db.fontAlignment,
                            dropDownMenu.bar,
                            dropDownMenu.db.fontAlignment, offsetX, 0
                        )
                    end
                    UIDropDownMenu_SetSelectedID(dropDownFrame, i)
                end
                UIDropDownMenu_AddButton(info)
            end
        end)
    UIDropDownMenu_SetWidth(dropDownFrame, 120)
    UIDropDownMenu_SetText(dropDownFrame, dropDownMenu.db.fontAlignment)

    return dropDownFrame
end

function KBOCDResourceBars.CreateResourceDropDownFor(dropDownMenu, parent, anchor)
    local dropDownFrame = CreateFrame("Frame", "ResourceDropDown", parent, "UIDropDownMenuTemplate")
    dropDownFrame:SetPoint(dropDownMenu.point, anchor, dropDownMenu.relativePoint, dropDownMenu.xPos, dropDownMenu.yPos)

    local resourceOptions = {
        "MANA",
        "RAGE",
        "FOCUS",
        "ENERGY",
        "RUNIC_POWER",
        "LUNAR_POWER",
        "MAELSTROM",
        "INSANITY",
        "CHI",
        "FURY",
    }

    UIDropDownMenu_Initialize(dropDownFrame,
        function()
            for i, resource in ipairs(resourceOptions) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = resource
                info.checked = (dropDownMenu.db.resourceToken == resource)
                info.func = function()
                    dropDownMenu.db.resourceToken = resource     -- save selection
                    KBOCDResourceBars.Update(
                        KBOCDResourceBars.additionalResourceBarGlobal,
                        KBOCDResourceBarsDB.additionalResourceBar,
                        KBOCDResourceBars.additionalResourceBarTextGlobal,
                        KBOCDResourceBars.BarTypeReferenceValues.resource
                    )
                    UIDropDownMenu_SetSelectedID(dropDownFrame, i)
                end
                UIDropDownMenu_AddButton(info)
            end
        end)
    UIDropDownMenu_SetWidth(dropDownFrame, 120)
    UIDropDownMenu_SetText(dropDownFrame, dropDownMenu.db.resourceToken)

    return dropDownFrame
end

function KBOCDResourceBars.CreateFontSizeBoxFor(fontSizeBox, parent, anchor)
    local fontSizeBoxFrame = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    fontSizeBoxFrame:SetPoint(fontSizeBox.point, anchor, fontSizeBox.relativePoint, fontSizeBox.xPos, fontSizeBox.yPos)
    fontSizeBoxFrame:SetSize(54, 24)
    fontSizeBoxFrame:SetAutoFocus(false)
    fontSizeBoxFrame:SetMaxLetters(3)
    fontSizeBoxFrame:SetJustifyH("RIGHT")
    fontSizeBoxFrame:SetTextInsets(2, 7, 0, 0)
    fontSizeBoxFrame:SetText(fontSizeBox.db.fontSize)

    local function ApplyFontSize(value)
        value = tonumber(value)
        if not value or value < 8 then value = 8 end
        if value > 120 then value = 120 end

        fontSizeBoxFrame:SetText(value)  -- sanitize input
        fontSizeBox.db.fontSize = value    -- save to DB

        if fontSizeBox.textToSize then
            local fontPath = fontSizeBox.textToSize:GetFont()
            fontSizeBox.textToSize:SetFont(fontPath, value)
        end
    end

    fontSizeBoxFrame:SetScript("OnEnterPressed", function(selfBox)
        ApplyFontSize(selfBox:GetText())
        selfBox:ClearFocus()
    end)

    fontSizeBoxFrame:SetScript("OnEditFocusLost", function(selfBox)
        ApplyFontSize(selfBox:GetText())
    end)

    return fontSizeBoxFrame
end

function KBOCDResourceBars.CreateDimensionBoxFor(dimensionBox, parent, anchor)
    local dimensionBoxFrame = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    dimensionBoxFrame:SetPoint(dimensionBox.point, anchor, dimensionBox.relativePoint, dimensionBox.xPos, dimensionBox.yPos)
    dimensionBoxFrame:SetSize(54, 24)
    dimensionBoxFrame:SetAutoFocus(false)
    dimensionBoxFrame:SetMaxLetters(5)
    dimensionBoxFrame:SetJustifyH("CENTER")
    dimensionBoxFrame:SetTextInsets(2, 7, 0, 0)
    if dimensionBox.dimension == "WIDTH" then
        dimensionBoxFrame:SetText(dimensionBox.db.width)
    else
        dimensionBoxFrame:SetText(dimensionBox.db.height)
    end

    local function ApplyDimension(value)
        value = tonumber(value)
        if not value or value < 20 then value = 20 end

        dimensionBoxFrame:SetText(value)  -- sanitize input
        if dimensionBox.dimension == "WIDTH" then
            dimensionBox.db.width = value    -- save to DB
            dimensionBox.frameToAdjust:SetWidth(value)
        else
            dimensionBox.db.height = value    -- save to DB
            dimensionBox.frameToAdjust:SetHeight(value)
        end
    end

    dimensionBoxFrame:SetScript("OnEnterPressed", function(selfBox)
        ApplyDimension(selfBox:GetText())
        selfBox:ClearFocus()
    end)

    dimensionBoxFrame:SetScript("OnEditFocusLost", function(selfBox)
        ApplyDimension(selfBox:GetText())
    end)

    return dimensionBoxFrame
end

function KBOCDResourceBars.CreatePositionBoxFor(positionBox, parent, anchor)
    local positionBoxFrame = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    positionBoxFrame:SetPoint(positionBox.point, anchor, positionBox.relativePoint, positionBox.xPos, positionBox.yPos)
    positionBoxFrame:SetSize(100, 24)
    positionBoxFrame:SetAutoFocus(false)
    positionBoxFrame:SetMaxLetters(10)
    positionBoxFrame:SetJustifyH("CENTER")
    positionBoxFrame:SetTextInsets(2, 7, 0, 0)
    if positionBox.position == "X" then
        positionBoxFrame:SetText(positionBox.db.xPosition)
    else
        positionBoxFrame:SetText(positionBox.db.yPosition)
    end


    local function ApplyPosition(value)
        value = tonumber(value)

        positionBoxFrame:SetText(value)  -- sanitize input

        local originalPoint, originalRelativeTo, originalRelativePoint, originalX, originalY = positionBox.frameToAdjust:GetPoint()
        positionBox.frameToAdjust:ClearAllPoints()
        if positionBox.position == "X" then
            positionBox.db.xPosition = value    -- save to DB
            positionBox.frameToAdjust:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, value, originalY)
        else
            positionBox.db.yPosition = value    -- save to DB
            positionBox.frameToAdjust:SetPoint(originalPoint, originalRelativeTo, originalRelativePoint, originalX, value)
        end
    end

    positionBoxFrame:SetScript("OnEnterPressed", function(selfBox)
        ApplyPosition(selfBox:GetText())
        selfBox:ClearFocus()
    end)

    positionBoxFrame:SetScript("OnEditFocusLost", function(selfBox)
        ApplyPosition(selfBox:GetText())
    end)

    return positionBoxFrame
end

StaticPopupDialogs["RESTORE_DEFAULTS"] = {
    text = "Are you sure you want to reset all of the values of\n'%s'\nto their default values?\n\nThis will triger a UI reload\nand cannot be undone.",
    button1 = YES,
    button2 = NO,
    OnAccept = function(self)
        local data = self.data
        if data.dbTable and data.defaultValuesTable then
            KBOCDResourceBars.ResetUserValuesFor(data.dbTable, data.defaultValuesTable)
        end
        ReloadUI()
    end,
    OnCancel = function()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function StaticPopupHelper(dataTypeToReset, dbTable, defaultValuesTable)
    StaticPopup_Show("RESTORE_DEFAULTS", dataTypeToReset, nil, {
        dbTable = dbTable,
        defaultValuesTable = defaultValuesTable
    })
end

function KBOCDResourceBars.CreateResetButtonFor(resetButton, parent, anchor)
    local resetButtonFrame = CreateFrame("Button", resetButton.typeForConfirmationBox, parent, "UIPanelButtonTemplate")
    resetButtonFrame:SetSize(92, 25)
    resetButtonFrame:SetPoint(resetButton.point, anchor, resetButton.relativePoint, resetButton.xPos, resetButton.yPos)
    resetButtonFrame:SetText("Defaults")

    local text = _G[resetButtonFrame:GetName() .. "Text"]
    text:SetJustifyH("CENTER")
    text:ClearAllPoints()
    text:SetPoint("LEFT", resetButtonFrame, "LEFT", 8, -0.65)
    text:SetPoint("RIGHT", resetButtonFrame, "RIGHT", -8, 0)

    resetButtonFrame:SetScript("OnClick", function()
        StaticPopupHelper(resetButton.typeForConfirmationBox, resetButton.db, resetButton.defaultValuesTable)
    end)

    return resetButtonFrame
end

--------------------------------------------------
-- Element Modification Functions
--------------------------------------------------
function KBOCDResourceBars.ChangeButtonEnableStateBasedOnOtherButton(otherButtonChecked, buttonTochange)
    if (type(otherButtonChecked) == "table" and otherButtonChecked:GetChecked()) or (type(otherButtonChecked) == "boolean" and not otherButtonChecked) then
        buttonTochange:Disable()
        buttonTochange.Text:SetFontObject("GameFontDisable")
    else
        buttonTochange:Enable()
        buttonTochange.Text:SetFontObject("GameFontNormal")
    end
end

function KBOCDResourceBars.ChangeSwatchEnableStateBasedOn(button, swatchToChange, swatchLabelToChange)
    if (type(button) == "table" and button:GetChecked()) or (type(button) == "boolean" and not button) then
        swatchLabelToChange:SetFontObject("GameFontNormal")
        swatchToChange:Enable()
        swatchToChange:SetAlpha(1.0)
    else
        swatchLabelToChange:SetFontObject("GameFontDisable")
        swatchToChange:Disable()
        swatchToChange:SetAlpha(0.4)
    end
end

function KBOCDResourceBars.ApplyFontShadow(textObj, enabled)
    if not textObj then return end

    if enabled then
        textObj:SetShadowOffset(1, -1)
        textObj:SetShadowColor(0, 0, 0, 1)
    else
        textObj:SetShadowOffset(0, 0)
    end
end

function KBOCDResourceBars.ApplyFontColor(textObj, dbTable)
    if not textObj or not dbTable then return end

    textObj:SetTextColor(
        dbTable.fontColor.red,
        dbTable.fontColor.green,
        dbTable.fontColor.blue,
        dbTable.fontColor.alpha
    )
end

function KBOCDResourceBars.UpdateBarStrata(enabled, frame)
    if not frame then return end

    if enabled then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(50)
    else
        frame:SetFrameStrata("MEDIUM")
        frame:SetFrameLevel(50)
    end
end

function KBOCDResourceBars.UpdateExtrasFrameVisibility(frame, db, key)
    if db[key] == true then
        frame:Show()
    else
        frame:Hide()
    end
end