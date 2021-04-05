set number
syntax on

set showmode "在底部显示，当前处于命令模式还是插入模式。
set showcmd  "显示命令
set mouse=a  "支持鼠标操作
set encoding=utf-8  
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,gb2312

set t_Co=256  "支持256色

filetype indent on  "开启文件类型检查，并且载入与该类型对应的缩进规则

"缩进
set autoindent  "按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致。

set tabstop=4  "按下 Tab 键时,Vim 显示的空格数。
set shiftwidth=4 "在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数。
set expandtab   "由于 Tab 键在不同的编辑器缩进不一致，该设置自动将 Tab 转为空格。
set softtabstop=4 " Tab 转为多少个空格。

set cursorline  "光标所在的当前行高亮。

set wrap  "自动折行，即太长的行分成几行显示。
set linebreak " 只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行。也就是说，不会在单词内部折行。
set softtabstop=4 " Tab 转为多少个空格。

set cursorline "当前行高亮

set nowrap "关闭自动折行
set linebreak "只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行

set ruler "在状态栏显示光标的当前位置（位于哪一行哪一列）

set showmatch "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号。

set hlsearch "搜索时，高亮显示匹配结果。

set spell spelllang=en_us  "打开英语单词的拼写检查。

set autoread "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。

colorscheme default

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
"nnoremap $ <nop>
"nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV `[v`]

inoremap jj <C-c><LEFT><LEFT>  " jk 替代esc

"括号自动补全
inoremap (( ()<LEFT>
inoremap [[ []<LEFT>
inoremap {{ {<CR>}<ESC>O

"删掉成对的括号
"nnoremap xx %x<C-O>x

"自动注释
autocmd BufNewFile *.cc,*.sh,*.java,*.cpp,*.h,*.hpp,*.py,*.lua exec ":call SetTitle()"
"新建.cc,.java,.sh,.cpp,.h, .hpp,
"""定义函数SetTitle，自动插入文件头
func SetTitle()
    let filetype_name = strpart(expand("%"), stridx(expand("%"), "."))
    let file_name = strpart(expand("%"), 0, stridx(expand("%"), "."))
    if file_name =~ "\/"
        let file_name = strpart(file_name, strridx(file_name, "/") + 1)
    endif
    let time_value = strftime("%Y-%m-%d %H:%M:%S")
    if filetype_name == ".sh"
        call setline(1, "\#!/bin/bash")
        call append(line("."), "")
        call append(line(".")+1, "\#########################################################################")
        call append(line(".")+2, "\# File Name: ". file_name . filetype_name)
        call append(line(".")+3, "\# Created on: ".time_value)
        call append(line(".")+4, "\# Author: kangheng")
        call append(line(".")+5, "\# Last Modified: ".time_value)
        call append(line(".")+6, "\# Description: ")
        call append(line(".")+7, "\#########################################################################")
        call append(line(".")+8, "")
    else
        if filetype_name == ".lua"
            call setline(1, "\--lua")
            call append(line("."), "") 
            call append(line(".")+1, "\--#########################################################################")
            call append(line(".")+2, "\--# File Name: ". file_name . filetype_name)
            call append(line(".")+3, "\--# Created on: ".time_value)
            call append(line(".")+4, "\--# Author: kangheng")
            call append(line(".")+5, "\--# Last Modified: ".time_value)
            call append(line(".")+6, "\--# Description: ")
            call append(line(".")+7, "\--#########################################################################")
            call append(line(".")+8, "") 
            call append(line(".")+9, file_name . " = {}")
            call append(line(".")+10, file_name .".__index = ". file_name)
            call append(line(".")+11, "function ". file_name .":new()")
            call append(line(".")+12, "    local o = {}")
            call append(line(".")+13, "    self.__index = self")
            call append(line(".")+14, "    setmetatable(o, self)")
            call append(line(".")+15, "    \-- construct function code here")
            call append(line(".")+16, "    return o")
            call append(line(".")+17, "end")
            call append(line(".")+18, "function ". file_name .":hotfix()")
            call append(line(".")+19, "    setmetatable(self, ". file_name .")")
            call append(line(".")+20, "end")
            call append(line(".")+21, "") 
            call append(line(".")+22, "return ". file_name)
        else
            if filetype_name == ".py"
                call setline(1, "\# -*- coding: utf-8 -*-")
                call append(line("."), "") 
                call append(line(".")+1, "\#########################################################################") 
                call append(line(".")+2, "\# File Name: ". file_name . filetype_name)  
                call append(line(".")+3, "\# Created on : ".time_value)  
                call append(line(".")+4, "\# Author: kangheng")
                call append(line(".")+5, "\# Last Modified: ".time_value)
                call append(line(".")+6, "\# Description:")  
                call append(line(".")+7, "\#########################################################################")
                call append(line(".")+8, "")
            else
                call setline(1, "\/*")
                call append(line("."), " * File Name: ". file_name . filetype_name)
                call append(line(".")+1, " * ")
                call append(line(".")+2, " * Created on: ".time_value)
                call append(line(".")+3, " * Author: kangheng")
                call append(line(".")+4, " * ")
                call append(line(".")+5, " * Last Modified: ".time_value)
                call append(line(".")+6, " * Description: ")
                call append(line(".")+7, " */")
                call append(line(".")+8, "")
                if filetype_name == ".h"
                    call append(line(".")+9, "#ifndef _". toupper(file_name) . substitute(toupper(filetype_name), ".", "_", "") ."_")
                    call append(line(".")+10, "#define _". toupper(file_name) . substitute(toupper(filetype_name), ".", "_", "") ."_")
                    call append(line(".")+11, "")
                    call append(line(".")+12, "class " . file_name)
                    call append(line(".")+13, "{")
                    call append(line(".")+14, "public:")
                    call append(line(".")+15, "")
                    call append(line(".")+16, "protected:")
                    call append(line(".")+17, "")
                    call append(line(".")+18, "};")
                    call append(line(".")+19, "")
                    call append(line(".")+20, "#endif //". toupper(file_name) . substitute(toupper(filetype_name), ".", "_", "") ."_")
                endif
            endif
        endif
    endif
endfunc
" 自动更新文件修改的时间
" modify the last modified time of a file  
function SetLastModifiedTime(lineno)  
    let modif_time = strftime("%Y-%m-%d %H:%M:%S")
    if a:lineno == "-1"  
            let line = getline(7)  
    else  
            let line = getline(a:lineno)  
    endif
    if line =~ '\sLast Modified:'
            let line = strpart(line, 0, stridx(line, ":")) . ": " . modif_time
    endif  
    if a:lineno == "-1"  
            call setline(7, line)  
    else  
            call append(a:lineno, line)  
    endif  
endfunc

" map the SetLastModifiedTime command automatically  
autocmd BufWrite *.cc,*.sh,*.java,*.cpp,*.h,*.hpp,*.py,*.lua call SetLastModifiedTime(-1)

" 关闭拼写检查
set nospell 







 














