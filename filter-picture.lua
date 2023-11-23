-- filter-picture.lua 图片转换
local function convertImageToBase64(imagePath)
    print("convertImageToBase64 =>: " .. imagePath)
    local handle = io.popen('base64 -w 0 ' .. imagePath)  -- 使用系统命令 base64 将图片转换为 base64
    local base64Image = handle:read('*a')
    handle:close()
    return base64Image
end

local function urlDecode(s)
    s = string.gsub(s, '%%(%x%x)', function(h)
        return string.char(tonumber(h, 16))
    end)
    return s
end
 -- 处理图片元素，将其本地文件转换为base64
function Image(elem)
    print("----")
    print(elem.src)
    local imagePath = elem.src:gsub('../../..', '')  
    print("D:/document/hong" .. imagePath)
    local path = "D:/document/iPhase2" .. imagePath
    print("add longpath: == " .. urlDecode(path))
    local base64Image = convertImageToBase64(urlDecode(path))
    elem.src = 'data:image/png;base64,' .. base64Image  -- 更新图片链接为 base64 编码
    return elem
end

return {
    { Image = Image }
}

