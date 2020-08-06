
" loading it from time to time when typing in French
" :source ~/.vim/fraccents.vim

nnoremap fa rà
nnoremap fe ré
nnoremap fy rè
nnoremap fw rè
nnoremap fu rù

nnoremap fc rç

nnoremap fA râ
nnoremap fE rê
nnoremap fI rî
nnoremap fO rô
nnoremap fU rû

nnoremap f-a rā
nnoremap f-e rē
nnoremap f-i rī
nnoremap f-o rō
nnoremap f-u rū

nnoremap f:a rä
nnoremap f:e rë
nnoremap f:i rï
nnoremap f:o rö
nnoremap f:u rü

" CTRL-K + , + c  pour la cédille

" :set dg --> e <BS> :

"nnoremap <leader>] :hi ColorColumn ctermbg=16<CR>:echo<CR>
"hi ColorColumn ctermbg=16

function! s:ToggleAccent()
  let c = nr2char(strgetchar(getline('.')[col('.') - 1:], 0))
  if     c == 'e' | exe 'normal! ré' |
  elseif c == 'é' | exe 'normal! rè' |
  elseif c == 'è' | exe 'normal! rê' |
  elseif c == 'a' | exe 'normal! rà' |
  elseif c == 'à' | exe 'normal! râ' |
  elseif c == 'o' | exe 'normal! rô' |
  elseif c == 'u' | exe 'normal! rû' |
  elseif c == 'i' | exe 'normal! rî' |
  elseif c == 'c' | exe 'normal! rç' |
  endif
endfunction " ToggleAccent
nnoremap <silent> ff :call <SID>ToggleAccent()<CR>

