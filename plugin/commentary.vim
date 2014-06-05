if exists('g:commentary_plugin_loaded')
    finish
endif

let g:commentary_plugin_loaded = 1

let s:savecpo = &cpo
set cpo&vim

function! s:cmt(fl, ll, char)
    execute a:fl . ',' . a:ll . 's:^:' . a:char . ':e'
    if (a:fl != a:ll)
        call feedkeys("\<cr>")
    endif
    noh
    echo ''
endfunction

function! s:uncmt(fl, ll, char)
    execute a:fl . ',' . a:ll . 's:' . a:char . '::e'
    if (a:fl != a:ll)
        call feedkeys("\<cr>")
    endif
    noh
    echo ''
endfunction

function! s:Commentary() range
    let ft = &filetype

    if (ft ==# "javascript" || ft ==# "php" || ft ==# "c" || ft ==# "cpp" || ft ==# "java")
        call <SID>cmt(a:firstline, a:lastline, '//')
    endif

    if (ft ==# "ruby" || ft ==# "perl" || ft ==# "sh" || ft ==# "apache")
        call <SID>cmt(a:firstline, a:lastline, '#')
    endif

    if (ft ==# "vim")
        call <SID>cmt(a:firstline, a:lastline, '"')
    endif

    if (ft ==# "css" || ft ==# "html")
        let cs = '/*'
        let ce = '*/'

        if (ft ==# 'html')
            let cs = '<!--'
            let ce = '-->'
        endif

        call feedkeys(':' . a:firstline . "\<cr>")
        call feedkeys('I')
        call feedkeys(cs)
        call feedkeys("\<esc>")
        call feedkeys(':' . a:lastline . "\<cr>")
        call feedkeys('A')
        call feedkeys(ce)
        call feedkeys("\<esc>")
    endif

endfunction

function! s:Uncommentary() range
    let ft = &filetype

    if (ft ==# "javascript" || ft ==# "php" || ft ==# "c" || ft ==# "cpp" || ft ==# "java")
        call <SID>uncmt(a:firstline, a:lastline, '//')
    endif

    if (ft ==# "ruby" || ft ==# "perl" || ft ==# "sh" || ft ==# "apache")
        call <SID>uncmt(a:firstline, a:lastline, '#')
    endif

    if (ft ==# "vim")
        call <SID>uncmt(a:firstline, a:lastline, '"')
    endif

    if (ft ==# "css" || ft ==# "html")
        let cs = '/\*'
        let ce = '.*\zs\*/'

        if (ft ==# 'html')
            let cs = '<!--'
            let ce = '-->'
        endif

        let ln = a:firstline
        while ln < (a:lastline + 1)
            call <SID>uncmt(ln, ln, cs)
            call <SID>uncmt(ln, ln, ce)
            let ln = ln + 1
        endwhile
    endif

endfunction

command! -nargs=* -range Commentary   <line1>,<line2>call <SID>Commentary()
command! -nargs=* -range Uncommentary <line1>,<line2>call <SID>Uncommentary()

let &cpo = s:savecpo
unlet s:savecpo
