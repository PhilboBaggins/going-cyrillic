-- Project: Going Cyrillic
-- Description: Just playing around with and getting used to Corona SDK
--

local beep = audio.loadSound('beep.wav')
local textItems = {}

local function randomString(minLen, maxLen)
    local length = math.random(minLen, maxLen)
    local retVal = ""
    for i = 1, length do
        retVal = retVal .. string.char(math.random(0, 128))
    end
    return retVal
end

local function timerEvent(event)
    if math.random() >= 0.23 then
        local posX = math.random(-20, display.contentWidth)
        local posY = math.random(0, display.contentHeight)
        local fontSize = 16 -- math.random(14, 18)
        local text = randomString(12, 28)
        local textMessage = display.newText(text, posX, posY, native.systemFont, fontSize)
        textMessage:setTextColor(0, 255, 0) -- Green
        audio.play(beep, { duration=20 })
        table.insert(textItems, textMessage)
    end
end

local function removeAllText()
    for key in pairs (textItems) do
        textItems[key]:removeSelf()
        textItems[key] = nil
    end
end

local function main()
    display.setStatusBar(display.HiddenStatusBar)
    local timerInterval = 15
    local timerIterations = 150
    local timerID = timer.performWithDelay(timerInterval, timerEvent, timerIterations)
    Runtime:addEventListener('touch', function(event)
        timer.cancel(timerID)
        removeAllText()
        timerID = timer.performWithDelay(timerInterval, timerEvent, timerIterations)
    end)
end

main()
