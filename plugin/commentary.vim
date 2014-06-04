if exists('g:commentary_plugin_loaded')
    finish
endif

let g:commentary_plugin_loaded = 1

let s:savecpo = &cpo
set cpo&vim

function! s:Commentary() range
    let ft = &filetype

    if (ft ==# "javascript" || ft ==# "php" || ft ==# "c" || ft ==# "cpp" || ft ==# "java")
        execute a:firstline . ',' . a:lastline . 's:^://:g'
        noh
    endif

    if (ft ==# "ruby" || ft ==# "perl" || ft ==# "sh" || ft ==# "apache")
        execute a:firstline . ',' . a:lastline . 's:^:#:g'
        noh
    endif

    if (ft ==# "vim")
        execute a:firstline . ',' . a:lastline . 's:^:":g'
        noh
    endif

    if (ft ==# "css")
        call feedkeys(':' . a:firstline . "\<cr>")
        call feedkeys('I')
        call feedkeys('/*')
        call feedkeys("\<esc>")
        call feedkeys(':' . a:lastline . "\<cr>")
        call feedkeys('A')
        call feedkeys('*/')
        call feedkeys("\<esc>")
    endif

    if (ft ==# "html")
        call feedkeys(':' . a:firstline . "\<cr>")
        call feedkeys('I')
        call feedkeys('<!--')
        call feedkeys("\<esc>")
        call feedkeys(':' . a:lastline . "\<cr>")
        call feedkeys('A')
        call feedkeys('-->')
        call feedkeys("\<esc>")
    endif

    echo ''

endfunction

function! s:Uncommentary() range
    let ft = &filetype

    if (ft ==# "javascript" || ft ==# "php" || ft ==# "c" || ft ==# "cpp" || ft ==# "java")
        execute a:firstline . ',' . a:lastline . 's://::e'
        noh
    endif

    if (ft ==# "ruby" || ft ==# "perl" || ft ==# "sh" || ft ==# "apache")
        execute a:firstline . ',' . a:lastline . 's:#::e'
        noh
    endif

    if (ft ==# "vim")
        execute a:firstline . ',' . a:lastline . 's:"::e'
        noh
    endif

    if (ft ==# "css")
        execute a:firstline . ',' . a:firstline . 's:/\*::e'
        execute a:lastline . ',' . a:lastline . 's:.*\zs\*/::e'
        noh
    endif

    if (ft ==# "html")
        execute a:firstline . ',' . a:firstline . 's:<!--::e'
        execute a:lastline . ',' . a:lastline . 's:.*\zs-->::e'
        noh
    endif

    echo ''

endfunction

command! -nargs=* -range Commentary   <line1>,<line2>call <SID>Commentary()
command! -nargs=* -range Uncommentary <line1>,<line2>call <SID>Uncommentary()

let &cpo = s:savecpo
unlet s:savecpo
