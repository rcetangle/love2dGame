function table.merge( tDest, tSrc )
    for k, v in pairs( tSrc ) do
        tDest[k] = v
    end
end


function table.clone(org)
    local function copy(org, res)
        for k,v in pairs(org) do
            if type(v) ~= "table" then
                res[k] = v;
            else
                res[k] = {};
                copy(v, res[k])
            end
        end
    end
 
    local res = {}
    copy(org, res)
    return res
end

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

local txtLine = 0
function eh_append2Output(txt)
    if txtLine > 10 then
        txtLine = 0
        eh_outputTxt = "" -- clear it
    end
    eh_outputTxt = eh_outputTxt.."\n"..txt
    txtLine = txtLine + 1
end