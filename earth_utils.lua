function eh_safeCallFunc(func, ...)
    if func and type(func) == "function" then
        func(...)
    end
end

-- 
function eh_getPosInWorld(curPos, size, targetPos)
    local ret = targetPos - curPos - size/2
    return ret
end
