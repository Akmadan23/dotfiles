" All credits to jdhao
" https://jdhao.github.io/2020/11/23/neovim_better_mapping_for_leaving_insert_mode/

inoremap <expr> k EscapeInsertOrNot()

function! EscapeInsertOrNot() abort
    " If k is preceded by j, then remove j and go to normal mode.
    let line_text = getline('.')
    let cur_ch_idx = GetCursorCharIdx()
    let pre_char = strcharpart(line_text, cur_ch_idx-1, 1)
    echom 'pre_char is:' pre_char

    if pre_char ==# 'j'
        return "\<BS>\<ESC>"
    else
        return 'k'
    endif
endfunction

" This function returns the character-based index for character under cursor.
function! GetCursorCharIdx() abort
    " Get the character under cursor
    let line_text = getline('.')
    let cur_byte_idx = col('.')
    echo 'cur_byte_idx:' cur_byte_idx

    if cur_byte_idx == 1
        echomsg 'cursor char idx:' 0
        return 0
    endif

    " character index starts from zero
    let [ch_idx, byte_idx] = [-1, 0]

    for c in split(line_text, '\zs')
        let ch_idx += 1
        let byte_idx += byteidx(c, 1)
        echomsg ch_idx c byte_idx

        if byte_idx+1 == cur_byte_idx
            let pre_char = strcharpart(line_text, ch_idx, 1)
            echomsg 'pre char is:' pre_char 'pre char index:' ch_idx

            let cursor_char = strcharpart(line_text, ch_idx+1, 1)
            echomsg 'cursor char' cursor_char 'index:' ch_idx+1

            return ch_idx + 1
        endif
    endfor
endfunction
