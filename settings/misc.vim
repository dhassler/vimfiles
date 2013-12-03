""" ctags, ctrlp, NERDTree refresh

function Refresh()
  echo "refreshing tags and files..."

  silent !if [ -d .git ]; then git ls-files -c -o --exclude-standard | ctags -L -; else ctags -R; fi

  if exists(":CtrlPClearAllCaches") == 2
    CtrlPClearAllCaches
  endif

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      wincmd p
    endif
  endif
endfunction

map <silent> <Leader>r :call Refresh()<CR>

""" Clojure nREPL bindings
nnoremap <C-e> :Eval<CR>
nnoremap E :%Eval<CR>
nnoremap cpt :w<CR>:Require<CR>:Eval (run-tests)<CR>


""" ctrl-p exclusions
set wildignore+=*/\.git/*,*/vendor/*,tags,*/gen-java/*
