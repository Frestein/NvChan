local M = {}

M.plain_text = function(symbol)
  local fragments = {}

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(fragments, ("%s %s"):format(num, usage))
  end

  if symbol.definition then
    table.insert(fragments, symbol.definition .. " defs")
  end

  if symbol.implementation then
    table.insert(fragments, symbol.implementation .. " impls")
  end

  return table.concat(fragments, ", ") .. stacked_functions
end

M.plain_text_symbol = function(symbol)
  local res = {}

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
  end

  if stacked_functions_content ~= "" then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { " ", "SymbolUsageImpl" })
    table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
  end

  return res
end

M.opts = {
  vt_position = "end_of_line",
  definition = { enabled = false },
  implementation = { enabled = false },
  text_format = M.plain_text_symbol,
}

return M
