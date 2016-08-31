-- Project: Going Cyrillic
-- Description: Just playing around with and getting used to Corona SDK
--

-- GLOBALS: math, timer, pairs, string, audio, display, table, native, os, Runtime

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
        local NUM_ROWS = 22
        local posX = math.random(-20, display.contentWidth)
        local posY = math.round(math.random(0, NUM_ROWS)) * display.contentHeight / (NUM_ROWS - 1)
        local fontSize = 16 -- math.random(14, 18)
        local text = randomString(12, 28)
        local textMessage = display.newText(text, posX, posY, native.systemFont, fontSize)
        textMessage:setFillColor(0, 255, 0) -- Green
        audio.play(beep, { duration=20 })
        table.insert(textItems, textMessage)
    end
end

local function removeAllText()
    for key in pairs(textItems) do
        textItems[key]:removeSelf()
        textItems[key] = nil
    end
end

local function main()
    math.randomseed(os.time())
    display.setStatusBar(display.HiddenStatusBar)
    local timerInterval = 20
    local timerIterations = 100
    local timerID = timer.performWithDelay(timerInterval, timerEvent, timerIterations)
    local function run(event)
        timer.cancel(timerID)
        removeAllText()
        timerID = timer.performWithDelay(timerInterval, timerEvent, timerIterations)
    end
    Runtime:addEventListener('touch', run)
    Runtime:addEventListener('system', function(event)
        if event.type == 'applicationResume' then
            run(event)
        end
    end)
end

main()
