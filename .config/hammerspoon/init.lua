hs.window.filter.new():subscribe(hs.window.filter.windowFocused, function(window)
  if window:application():name() == 'Firefox' then
    hs.execute '/opt/homebrew/bin/macism jp.sourceforge.inputmethod.aquaskk'
  end
end)
