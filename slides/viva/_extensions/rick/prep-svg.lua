function prepSvg(src, commands)
  local temp_filename = os.tmpname()
  -- pandoc.pipe("python", {"-u", "prep_svg.py", src, temp_filename},
  --             commands)
  local p = assert(io.popen("python -u _extensions/rick/prep_svg.py " .. src .. " " .. temp_filename, "w"))
  p:write(commands)
  assert(p:close())
  local temp_f = io.open(temp_filename, "rb")
  local output = ""
  while true do
    -- if p:read(0) ~= "" then break end
    local block = temp_f:read(10)
    if not block then break end
    output = output .. block
    -- for line in io.lines(temp_filename, 1000) do
    -- quarto.log.output(block .. "\n")
  end
  temp_f:close()
  -- local output = p:read(1)
  -- temp_filename = "/private/tmp/lua_saDz5g"
  -- -- local output = temp_f:read("*L")
  -- quarto.log.output(temp_filename)
  -- local temp_f = io.open(temp_filename, "rb")
  -- local output = temp_f:read("*all")
  return output
end


function CodeBlock(el)
  if el.attr.classes:find("prep-svg") then
    local src = el.attr.attributes["src"]
    quarto.log.output("prep-svg: " .. src)
    local commands = el.text
    local output = prepSvg(src, commands)
    return pandoc.RawBlock("html", output)
    -- quarto.log.output(commands)
    -- local temp_filename = os.tmpname()
    -- pandoc.pipe("python", {"-u", "prep_svg.py", src, temp_filename},
    --             commands)
    -- quarto.log.output(temp_filename)
    -- local temp_f = io.open(temp_filename, "rb")
    -- local output = temp_f:read("*all")
    -- temp_f:write(commands)
    -- temp_f:close()
    -- local p = io.popen("python prep_svg.py " .. src .. " < " .. temp_filename, "r")
    -- -- local output = p:read(1)
    -- -- temp_filename = "/private/tmp/lua_saDz5g"
    -- -- -- local output = temp_f:read("*L")
    -- while true do
    --   if p:read(0) ~= "" then break end
    --   local block = p:read(1)
    --   if not block then break end
    --   -- for line in io.lines(temp_filename, 1000) do
    --   quarto.log.output(block .. "\n")
    -- end
    -- quarto.log.output(p:close())
    -- -- temp_f:close()
    -- quarto.log.output(output)
  end
end
