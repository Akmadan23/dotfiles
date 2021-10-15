" Compile function for C, C++, Go, Rust and Java
function! Compile()
    let l:ext = expand('%:e')
    if ext == 'c'
        exec '!gcc % -o %:r'
    elseif ext == 'cpp'
        exec '!g++ % -o %:r'
    elseif ext == 'go'
        exec '!go build %'
    elseif ext == 'rs'
        exec '!rustc %'
    elseif ext == 'java'
        exec '!javac %'
    else
        echo 'Nothing to compile.'
    endif
endfunction

" Run function for C, C++, Go, Rust, Java compiled code and any script
function! Run()
    if getline(1) =~# '^#!.*/bin/.*$'
        silent exec '![ -x % ]'
        if v:shell_error == 1
            silent exec '!chmod +x %'
        endif
        tabnew term://%:p
    else
        let l:ext = expand('%:e')
        if l:ext == 'c' || l:ext == 'cpp' || l:ext == 'go' || l:ext == 'rs'
            tabnew term://%:p:r
        elseif l:ext == 'java'
            cd %:h
            tabnew term://java %:r
        else
            echo 'Nothing to execute.'
        endif
    endif
endfunction

" Calling functions
nno <F5> :call Compile()<CR>
nno <F6> :call Run()<CR>
