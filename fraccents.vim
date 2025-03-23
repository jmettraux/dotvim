
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

nnoremap f'a rá

nnoremap f-a rā
nnoremap f-e rē
nnoremap f-i rī
nnoremap f-o rō
nnoremap f-u rū
nnoremap f-O rŌ

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
  elseif c == 'ê' | exe 'normal! re' |
  elseif c == 'a' | exe 'normal! rà' |
  elseif c == 'à' | exe 'normal! râ' |
  elseif c == 'â' | exe 'normal! rä' |
  elseif c == 'ä' | exe 'normal! rá' |
  elseif c == 'á' | exe 'normal! ra' |
  elseif c == 'o' | exe 'normal! rô' |
  elseif c == 'ô' | exe 'normal! rö' |
  elseif c == 'ö' | exe 'normal! ro' |
  elseif c == 'u' | exe 'normal! rù' |
  elseif c == 'ù' | exe 'normal! rû' |
  elseif c == 'û' | exe 'normal! rú' |
  elseif c == 'ú' | exe 'normal! rü' |
  elseif c == 'ü' | exe 'normal! ru' |
  elseif c == 'i' | exe 'normal! rî' |
  elseif c == 'î' | exe 'normal! rì' |
  elseif c == 'ì' | exe 'normal! rï' |
  elseif c == 'ï' | exe 'normal! ri' |
  elseif c == 'c' | exe 'normal! rç' |
  elseif c == 'ç' | exe 'normal! rc' |
  endif
endfunction " ToggleAccent
nnoremap <silent> ff :call <SID>ToggleAccent()<CR>

