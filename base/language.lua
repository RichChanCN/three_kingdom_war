function T(text, ...)
    if not text then return end
    local n = select("#", ...)
    return (n==0) and text or string_format(text, ...) 
end