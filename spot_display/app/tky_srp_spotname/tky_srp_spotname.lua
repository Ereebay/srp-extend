if ac.getTrackID() ~= "shuto_revival_project_beta" then
    print("This app will not work outside of SRP.")
    return nil
end

local textView = true
ui.pushDWriteFont('c:\\windows\\fonts\\segoeuiz.ttf')
local screen = {}
screen.position = vec2(ac.getSim().windowWidth*0.9-450,300)
screen.sizeOriginal = vec2(500,100)
screen.size = screen.sizeOriginal
screen.ratio = 1

if io.fileExists(__dirname .. "\\screenposition.json") then
    io.loadAsync(__dirname .. "\\screenposition.json", function(err, data)
        screen = stringify.parse(data)
    end)
end

local spots
if io.fileExists(__dirname .. "\\spot.json") then
    io.loadAsync(__dirname .. "\\spot.json", function(err, data)
        spots = stringify.parse(data)
    end)
else
    return nil
end

local time = 0
local transparent = 0
local image, text
local sign = {}
function script.update(dt)    
    for spot in pairs(spots) do
        if spots[spot].distance > math.sqrt((spots[spot].position.x - ac.getCar().position.x)^2 + (spots[spot].position.y - ac.getCar().position.y)^2 + (spots[spot].position.z - ac.getCar().position.z)^2) then
            time = 3
            image = __dirname .. "\\img\\" .. spot .. ".png"
            text = spots[spot].text
            sign = spots[spot].sign
        end
    end

    if time > 0 then
        time = time - dt
        if transparent <= 1 and time > 1 then
            transparent = transparent + dt
        elseif time <= 1 then
            transparent = transparent - dt
        end
    elseif time < 0 then
        time = 0
        transparent = 0
        image = nil
        text = nil
    end

    ac.debug("time",time)
    ac.debug("transparent",transparent)
    ac.debug("spot",text)
    ac.debug("screen",screen.position)

end

local i,signPos
function script.fullscreenUI(dt)
    if textView and time > 0 then
        ui.drawRectFilled(screen.position, screen.position + screen.size,rgbm(0,0,0,0.2*transparent))
        ui.drawImage(image,screen.position + vec2(50,40)*screen.ratio, screen.position + screen.size + vec2(-50,-10)*screen.ratio,rgbm(1,1,1,transparent),vec2(0,0),vec2(1,1),ui.ImageFit.Fill)
        ui.dwriteDrawTextClipped(text, 32*screen.ratio, screen.position + vec2(0,5), screen.position + screen.size + vec2(0,-screen.size.y*0.65), ui.Alignment.Center, ui.Alignment.End, false, rgbm(1,1,1,transparent))
        signPos = screen.position + vec2(screen.size.x/2,screen.size.y) + vec2(-50*screen.ratio*#sign,0)
        if #sign > 0 then
            for i=1 , #sign do
                ui.drawImage(__dirname .. "\\img\\Shuto_Urban_Expwy_Sign_" .. sign[i] .. ".png",signPos+vec2(100*(i-1)*screen.ratio,0), signPos+vec2(100*i*screen.ratio,80*screen.ratio) ,rgbm(1,1,1,transparent),vec2(0,0),vec2(1,1),ui.ImageFit.Fit)
            end
        end
    end
end

local value, changed
function script.windowMain(dt)
    if ui.checkbox("Show spot name",textView) then
        textView = not textView
    end
    ui.setNextItemWidth(250)
    value, changed = ui.slider('screen.x', screen.position.x, 0, ac.getSim().windowWidth,'%.0f')
    if changed then
        screen.position.x = value
        time = 3
        transparent = 1
    end
    ui.setNextItemWidth(250)
    value, changed = ui.slider('screen.y', screen.position.y, 0, ac.getSim().windowHeight,'%.0f')
    if changed then
        screen.position.y = value
        time = 3
        transparent = 1
    end
    ui.setNextItemWidth(250)
    value, changed = ui.slider('screen size', screen.ratio, 0.1, 5.0,'%.1f')
    if changed then
        screen.ratio = value
        screen.size = screen.sizeOriginal * screen.ratio
        time = 3
        transparent = 1
    end
    if ui.button("SAVE") then
        io.save(__dirname .. "\\screenposition.json",stringify(screen))
    end
end
