# pandoc
markdown导出神器，pandoc,在导出时指定自己的样式/模板，通过lua脚本处理文档内容

## 导出html模板
pandoc导出htlm时的模板，能够让导出的文档渲染成你想要的格式 >>>>> template.html


# 目录
**-- filter-picture.lua**        >>>>>>>>>>   pandoc转换时使用lua脚本处理图片  
**-- filter-plantuml.lua**     >>>>>>>>>   pandoc转换时使用lua脚本处理plantuml图形  
**-- template.html**           >>>>>>>>>>>>   pandoc转换html的模板文件

# 执行
```bash
pandoc --template=/d/document/template.html --toc
--lua-filter=/d/document/filter-picture.lua,/d/document/filter-plantuml.lua 我的文档.md -o /d/doc/我的文档.html
```

