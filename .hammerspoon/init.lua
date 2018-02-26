hyper = hs.hotkey.modal.new()

-- Use Karabiner-Elements to map caps_lock to f18.
f18 = hs.hotkey.bind({}, 'f18', function () hyper:enter() end, function () hyper:exit() end)

-- Reload Hammerspoon
hyper:bind({}, 'r', hs.reload)

-- Position the current window
local function move(cb)
  local win = hs.window.focusedWindow()

  if win then
    local frame = win:frame()
    local screenFrame = win:screen():frame()
    frame.x, frame.y, frame.w, frame.h = cb(frame, screenFrame)
    win:setFrame(frame, 0)
  end
end

-- Set border gap sizes
local border = 32

-- Set the padding gap sizes
local padding = 16

-- Center window
hyper:bind({}, 'space', function()
  move(function(f, sf) return
    (sf.x + (sf.w * (1 / 6)) + border),
    (sf.y + border),
    ((sf.w * (2 / 3)) - (border + padding)),
    (sf.h - (border + border))
  end)
end);

-- Fullscreen window
hyper:bind({'shift'}, 'space', function()
  move(function(f, sf) return
    (sf.x + border),
    (sf.y + border),
    (sf.w - (border + border)),
    (sf.h - (border + border))
  end)
end);

-- Left 1/2
hyper:bind({}, 'left', function()
  move(function(f, sf) return
    (sf.x + border),
    (sf.y + border),
    ((sf.w / 2) - (border + padding)),
    (sf.h - (border + border))
  end)
end)

-- Left 1/3
hyper:bind({'alt'}, 'left', function()
  move(function(f, sf) return
    (sf.x + border),
    (sf.y + border),
    ((sf.w * (1 / 3)) - (border + padding)),
    (sf.h - (border + border))
  end)
end)

-- Left 2/3
hyper:bind({'shift'}, 'left', function()
  move(function(f, sf) return
    (sf.x + border),
    (sf.y + border),
    ((sf.w * (2 / 3)) - (border + padding)),
    (sf.h - (border + border))
  end)
end)

-- Right 1/2
hyper:bind({}, 'right', function()
  move(function(f, sf) return
    (sf.x + (sf.w / 2) + padding),
    (sf.y + border),
    ((sf.w / 2) - (border + padding)),
    (sf.h - (border + border))
  end)
end)

-- Right 1/3
hyper:bind({'alt'}, 'right', function()
  move(function(f, sf) return
    (sf.x + (sf.w * (2 / 3)) + padding),
    (sf.y + border),
    ((sf.w * (1 / 3)) - (border + padding)),
    (sf.h - (border + border))
  end)
end)

-- Right 2/3
hyper:bind({'shift'}, 'right', function()
  move(function(f, sf) return
    (sf.x + (sf.w * (1 / 3)) + padding),
    (sf.y + border),
    ((sf.w * (2 / 3)) - (border + padding)),
    (sf.h - (border + border))
  end)
end)
