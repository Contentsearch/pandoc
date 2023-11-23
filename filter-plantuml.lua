-- filter_plantuml.lua
local function base64Encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do
            r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r;
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then
            return ''
        end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
        end
        return b:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

local function convertToHex(str)
    local hexString = {}
    for i = 1, #str do
        local byte = string.byte(str, i)
        table.insert(hexString, string.format("%02X", byte))
    end
    hexString = table.concat(hexString)
    return hexString
end
-- pandoc lua 语法,
function CodeBlock(block)
    -- 检查代码块是否为 PlantUML 代码
    if block.classes[1] == "plantuml" then
        -- 提取 PlantUML 代码
        local code = block.text
        print((code))
        print(convertToHex(code))

        local url = "https://www.plantuml.com/plantuml/png/~h" .. convertToHex(code)
        -- 通过 Pandoc 的 mediabag.fetch() 将图片嵌入到文档中
        local img, contents = pandoc.mediabag.fetch(url, ".png")
        -- 将二进制数据转换为 Base64 编码的字符串
        local base64_contents = base64Encode(contents)
        -- 构建 HTML 标签
        local img_html = pandoc.RawBlock('html', string.format('<img src="data:image/png;base64,%s">', base64_contents))
        return img_html
    end
    return block
end

return {
    { CodeBlock = CodeBlock }
}
