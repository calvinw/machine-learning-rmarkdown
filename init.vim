call plug#begin()
	" Plug 'jalvesaq/Nvim-R'
        Plug 'posva/vim-vue'
        Plug 'tomtom/tcomment_vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ConradIrwin/vim-bracketed-paste'
	Plug 'pangloss/vim-javascript'
	Plug 'luisjure/csound'
	Plug 'supercollider/scvim'
        Plug 'tidalcycles/vim-tidal'
call plug#end()

syntax on
filetype indent on
set background=dark
set expandtab 
set tabstop=4 
set softtabstop=0 
set shiftwidth=4
set smarttab

noremap <buffer> ,c :call LoadHtmlForCWord() <CR>

"set smartindent
":imap jk <Esc>
"Haskell
autocmd FileType haskell noremap <buffer> ,d :call Line() <CR>
autocmd FileType haskell xnoremap <buffer> ,d :<c-u>call Block() <CR>
autocmd FileType haskell noremap <buffer> ,f :call HaskellClear() <CR>
autocmd FileType haskell noremap <buffer> ,s :call LoadHaskellFile() <CR>
"autocmd BufReadPost,BufNewFile *.hs :call RunHaskell()  

"R
"autocmd FileType r noremap <buffer> ,d :call Line() <CR>
"autocmd FileType r xnoremap <buffer> ,d :<c-u>call Block() <CR>
"autocmd FileType r noremap <buffer> ,f :call RClear() <CR>
"autocmd BufReadPost,BufNewFile *.R :call RunR()
"
"R
autocmd FileType rmd noremap <buffer> ,d :call Line() <CR>
autocmd FileType rmd xnoremap <buffer> ,d :<c-u>call Block() <CR>
autocmd FileType rmd noremap <buffer> ,f :call RClear() <CR>
autocmd FileType rmd noremap <buffer> ,r :call LoadHtmlForRmd() <CR>
"autocmd BufReadPost,BufNewFile *.R :call RunR()

"octave
autocmd FileType matlab noremap <buffer> ,d :call Line() <CR>
autocmd FileType matlab xnoremap <buffer> ,d :<c-u>call Block() <CR>
autocmd FileType matlab noremap <buffer> ,f :call OctaveClear() <CR>
"autocmd BufReadPost,BufNewFile *.R :call RunR()

"python
autocmd FileType python noremap <buffer> ,d :call Line() <CR>
autocmd FileType python xnoremap <buffer> ,d :<c-u>call Block() <CR>
autocmd FileType python noremap <buffer> ,f :call PythonClear() <CR>
"autocmd BufReadPost,BufNewFile *.py :call RunPython()

"Tidal
autocmd FileType tidal noremap <buffer> ,d :call Line() <CR>
autocmd FileType tidal xnoremap <buffer> ,d :<c-u>call Block() <CR>
autocmd FileType tidal noremap <buffer> ,f :call TidalHush() <CR> 
"autocmd BufReadPost,BufNewFile *.tidal :call RunTidal()

"Csound
autocmd FileType csound xnoremap <buffer> ,d :<c-u>call CSoundScoreOrOrc() <CR>
autocmd FileType csound noremap <buffer> ,f :call StopCSound() <CR>
autocmd FileType csound noremap <buffer> ,c :call RestartCSound() <CR>
autocmd FileType csound noremap <buffer> ,r :call RunCSound() <CR>
autocmd FileType csound noremap <buffer> ,s :call CSoundHelp() <CR>
"autocmd BufReadPost,BufNewFile *.csd :call RunCSound()

"Supercollider
autocmd FileType supercollider noremap <buffer> ,d :call SCLineOrBlock() <CR>
autocmd FileType supercollider noremap <buffer> ,f :call SCCmdPeriod() <CR>
autocmd FileType supercollider noremap <buffer> ,s :call SCHelp() <CR>
"autocmd BufReadPost,BufNewFile *.scd :call RunSCLang()

autocmd BufRead,BufWritePre *.sh normal gg=G
"au BufReadPost,BufNewFile *.scd :call RunSCLang()  
"au BufReadPost,BufNewFile *.csd :call RunCSound()  

set tabstop=8
set softtabstop=0
set noexpandtab

function! LoadHtmlForRmd()
    let l:filename = expand('%:t:r').'.html'
    call system("nc -q .01 localhost 4000", l:filename)
endfunction

function! LoadHtmlForCWord()
    let l:filename = expand("<cword>").'.html'
    call system("nc -q .01 localhost 4000", l:filename)
endfunction

"set softtabstop=4
"set shiftwidth=4
"set expandtab
"
function! CloseTerminal()
    only!
    sleep 200m
endfunction

function! RunBash()
    execute 'below 10new'
    let g:term_id = termopen(["bash"], {})
    normal G
    wincmd p
endfunction

function! RunMake()
    call s:sendCommand(g:term_id, "clear; make; ./build/ConsoleApp2")
endfunction

tnoremap <Esc> <C-\><C-n>

let g:term_id = 0
function! Line()
    let l:sel = getline(".")
    call s:sendCommand(g:term_id, l:sel)
    call s:flashLine()
endfunction

function! Block()
    let l:select = GetLines()
    call s:sendCommand(g:term_id, l:select)
    call s:flashBlock()
endfunction

function! s:flashBlock()
    execute "normal! gv"
    execute "normal! \<esc>"
    redraw
    sleep 100m
    execute "normal! gv"
    redraw
    sleep 300m
    execute "normal! \<esc>"
    redraw
endfunction

function! s:flashLine()
    execute "normal! V"
    redraw
    sleep 300m
    execute "normal! \<esc>"
    redraw
endfunction

function! s:sendCommand(term_id, cmd)
    call chansend(a:term_id, a:cmd) 
    call chansend(a:term_id, "\n") 
endfunction

function! s:SendDocUrl(url) 
        call system("nc -q .01 -u localhost 4000", a:url)
endfunction

function! GetLines()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    return join(lines, "\n")
endfunction

function! RunTidal()
    execute 'below 6new'
    let g:term_id = termopen(["tidal"], {})
    normal G
    wincmd p
endfunction

function! TidalHush()
    call s:sendCommand(g:term_id, "hush")
endfunction

function! RunPython()
    execute 'below 10new'
    let g:term_id = termopen(["python"], {})
    normal G
    wincmd p
endfunction

function! LoadHaskellFile()
    let filename = expand('%')
    let command = ":l ".filename
    call s:sendCommand(g:term_id, command)
endfunction

function! RunHaskell()
    execute 'below 12new'
    let g:term_id = termopen(["ghci"], {})
    normal G
    wincmd p
endfunction

function! HaskellClear()
    call s:sendCommand(g:term_id, ":! clear")
endfunction

function! PythonClear()
    call s:sendCommand(g:term_id, 'print("\033[H\033[J")')
endfunction

function! OctaveClear()
    call s:sendCommand(g:term_id, "clc")
endfunction

function! RunOctave()
    execute 'below 12new'
    let g:term_id = termopen(["octave-cli"], {})
    normal G
    wincmd p
endfunction

function! RunR()
    execute 'below 12new'
    let g:term_id = termopen(["R"], {})
    normal G
    wincmd p
endfunction

function! RClear()
    call s:sendCommand(g:term_id, "system('clear')")
endfunction

function! CSoundScoreOrOrc()
    "Save the current position and get the line we are on
    let g:save_pos = getpos(".")
    let g:cur_line=line('.')

    let l:begin_orc = search("<CsInstruments>","bnW") 
    let l:end_orc = search("</CsInstruments>","nW") 

    let l:begin_sco = search("<CsScore>","bnW") 
    let l:end_sco = search("</CsScore>","nW") 

    if g:cur_line > l:begin_orc && g:cur_line < l:end_orc
	    call CSoundOrcBlock() 
	    "echo "begin orc: ".l:begin_orc. " end orc: ".l:end_orc." cur_line: ".g:cur_line
    elseif g:cur_line > l:begin_sco && g:cur_line < l:end_sco
	    call CSoundScoBlock() 
	    "echo "begin sco: ".l:begin_sco. " end sco: ".l:end_sco." cur_line: ".g:cur_line
    else
            "echo "inside neither orc or sco"
    endif
endfunction

function! LinkNumber()
endfunction
	
function! SCLineOrBlock()
    "Save the current position and get the line we are on
    let g:save_pos = getpos(".")
    let g:cur_line=line('.')

    "Find the left paren of the block
    let l:left_paren = search("^(","bW") 

    "If the left paren is not 0 found the nearest block
    "Find the right paren and see if cursor is inside
    if l:left_paren > 0
        let l:right_paren = search("^)","W") 
        if l:right_paren >= g:cur_line 
            call setpos('.', g:save_pos)
            "echo "left paren: ".l:left_paren. " right paren: ".l:right_paren." cur_line ".g:cur_line
            call SCBlock()
        else
            call setpos('.', g:save_pos)
            "echo "left paren: ".l:left_paren. " right paren: ".l:right_paren." cur_line ".g:cur_line
            call Line()
        endif
    else
        let l:right_paren = 0
        call setpos('.', g:save_pos)
        "echo "left paren: ".l:left_paren. " right paren: ".l:right_paren." cur_line ".g:cur_line
        call Line()
    endif
endfunction

function! RunSCLang()
    execute 'below 10new'
    let g:term_id = termopen(["sclang"], {})
    normal G
    wincmd p
endfunction

function! SCCmdPeriod()
    call s:sendCommand(g:term_id, "CmdPeriod.run")
endfunction

function! SCBlock()
    let l:save = getpos(".")
    execute "normal! ?^(\<cr>v%"
    redraw
    sleep 400m
    execute "normal! \<esc>"
    let l:select = GetLines()
    let l:lins = split(l:select,"\n")
    let l:scstring = join(l:lins," ")
    call s:sendCommand(g:term_id, l:scstring)
    call setpos('.', l:save)
endfunction

function! s:sendCSoundCode(code)
    call system("nc -q .01 -u localhost 1234", a:code)
endfunction

"function! CSoundHelp()
"	let l:url = "https://csound.com/docs/manual/"
"	let l:word = expand("<cword>") 
"	let l:helpurl = l:url . l:word
"	let l:thiswind = system("xdotool getactivewindow")
"	let l:winid = system("wmctrl -l | grep -oP '(?<=)(0x\\w+)(?=.*Chrome)'")
"	let l:winid = string(l:winid)
"	call system("echo '". l:helpurl . "'| xclip -selection clipboard")
"	call system("xdotool windowactivate ". l:winid)
"	call system("xdotool key --window ". l:winid ." 'ctrl+l'")
"	call system("xdotool key --window ". l:winid ." 'ctrl+v'")
"	call system("xdotool key --window ". l:winid ." 'Return'")
"	call system("xdotool windowactivate ". l:thiswind)
"endfunction

function! SCHelp()
	let l:url = "http://doc.sccode.org/"
	let l:word = expand("<cword>") 
	let l:helpurl = l:url . "Classes/" . l:word . ".html"
        "call system("nc -q .01 -u localhost 41234", l:helpurl)
	call s:SendDocUrl(l:helpurl)
endfunction

function! CSoundHelp()
	let l:url = "https://csound.com/docs/manual/"
	let l:word = expand("<cword>") 
	let l:helpurl = l:url . l:word
        "call system("nc -q .01 -u localhost 41234", l:helpurl)
	call s:SendDocUrl(l:helpurl)
endfunction

function! CSoundOpCodeExample()
	let l:url = "https://csound.com/docs/manual/"
	let l:opcode = expand("<cword>") 
	let l:sourcefile = l:opcode . ".csd"
	let l:helpurl = l:url . l:sourcefile
	call s:SendDocUrl(l:helpurl)
endfunction

function! CSoundOrcBlock()
    let l:select = GetLines()
    call s:sendCSoundCode(l:select)
    call s:flashBlock()
endfunction

function! CSoundScoBlock()
    let l:select = GetLines()
    " $ sign indicates its a score block of code
    let l:score = "$ ". l:select
    call s:sendCSoundCode(l:score)
    call s:flashBlock()
endfunction

function! RestartCSound()
	call CloseTerminal()
	call RunCSound()
endfunction

function! StopCSound()
	call CloseTerminal()
endfunction

" :function! RunCSound()
" 	:let csd_filename = expand('%')
" 	This is the old command that took the filename
" 	:let command = ["csound",
" 	                "-B4096",
" 	                "-b4096",
" 	                "-d",
" 	                "-o",
" 	                "devaudio", 
" 	                csd_filename]

"      1) Run jackd: 
"      >/usr/bin/jackd -dalsa -dhw:0 -r44100 -p1024 -n2
"      2) Run csound as udp server with jack realtime: 
"      >csound -b4096 -B4096 -+rtaudio=jack -odac --port=1234
"      Then in vim we netcat like this !nc -q .01 -u localhost 1234 < %   
"      \ "-+rtaudio=jack",
"      \ "-d", 
"      \ "-odac",
"      \ "--port=1234", 

function! RunCSound()
    let csd_filename = expand('%')
    let command = ["csound", 
      \ "-B4096", 
      \ "-b2048", 
      \ "-odac",
      \ "--port=1234", 
      \ csd_filename ]
    execute 'below 5new'
    let g:term_id = termopen(command, {})
    normal G
    wincmd p
endfunction

