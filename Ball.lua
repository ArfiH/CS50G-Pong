Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    -- self.dy = math.random(2) == 1 and -100 or 100
    -- self.dx = math.random(-50, 50)
    self.dy = 0
    self.dx = 0
end

--[[
    Places the ball in the middle of the screen, with an initial random velocity
    on both axes.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    -- self.dy = math.random(2) == 1 and -60 or 60
    -- self.dx = math.random(-100, 100)
    self.dy = 0
    self.dx = 0 
end

function Ball:collides(paddle)
    if paddle == player1 then
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, self.width, self.height)    
    end

    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    if love.keyboard.isDown('d') then
        FACTOR = 1.5
    elseif love.keyboard.isDown('a') then
        FACTOR = 0.6
    else
        FACTOR = 1
    end

    if FACTOR > 1.3 then
        FACTOR = FACTOR - (0.2 * FACTOR)
    elseif FACTOR < 0.8 then
        FACTOR = FACTOR + (0.3 * FACTOR)
    end
    return true
end

--[[
    Simply applies velocity to position, scaled by deltaTime.
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end