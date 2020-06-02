" To reload run :so %
let macvim_skip_colorscheme=1
set number
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set colorcolumn=80
set ruler
set nowrap
set backspace=indent,eol,start
set smartcase
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell
set noerrorbells
set nobackup
set noswapfile
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L
set nohlsearch
set laststatus=2
set guifont=Courier\ New:h18 
" show me tabs
set list
set listchars=tab:>-

nnoremap Q <nop>
colorscheme railscasts

syntax on
filetype plugin on

set wildmenu
" Map .bpt to .xml filetype
au BufNewFile,BufRead *.bpt set filetype=xml

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  silent %!xmllint --format - 
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  " 2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction

function! DoStripDeleteTrue()
  " deletes all lines that match the pattern delete="true"
  " good for cleaning up superflows with unnecessary parameters
  g/delete="true"/d
endfunction

function! DoInsertUUID()
  let uuid=system("ruby -e 'require \"securerandom\"; print SecureRandom.uuid'")
  exe 'normal a'  . uuid
endfunction

function! DoInsertRubyVIM()
  exe 'normal i# vim: ts=2 sts=2 et'
endfunction

function! DoStripDOS()
  :%s/\r//g 
endfunction


function! Rubocop()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    let rbc = 'rubocop '
    let log = system(rbc.fileName)
    echo log
  else
    echo "Not Ruby file"
  endif
endfunction

function! RubocopLight()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    silent !rubocop -x %
  else
    echo "Not a Ruby File"
  endif
endfunction

function! RubocopHeavy()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    silent !rubocop -a %
  else
    echo "Not a Ruby File"
  endif
endfunction


command! Rubocop call Rubocop()
command! RubocopLight call RubocopLight()
command! RubocopHeavy call RubocopHeavy()
command! StripDOS call DoStripDOS()
command! PrettyXML call DoPrettyXML()
command! PrettyJSON execute "%!python -m json.tool"
command! ValidateAssessment execute "!xmllint --noout --xinclude --schema ~/Perforce/ati-unstable/tests/bpslive/schemas/assessment.xsd %"
command! ValidateAudit execute "!xmllint --noout --xinclude --schema ~/Perforce/ati-unstable/tests/bpslive/schemas/audit.xsd %"
command! StripDeleteTrue call DoStripDeleteTrue()
command! InsertUUID call DoInsertUUID()
command! InsertRubyVIM call DoInsertRubyVIM()
command! HTMLEncode execute "%!perl -MHTML::Entities -pe 'encode_entities($_);'"
command! HTMLDecode execute "%!perl -MHTML::Entities -pe 'decode_entities($_);'"
command! URIDecode execute "%!python -c 'import sys, urllib as ul; [sys.stdout.write(ul.unquote_plus(line)) for line in sys.stdin]'"
command! URIEncode execute "%!python -c 'import sys, urllib as ul; [sys.stdout.write(ul.quote_plus(line)) for line in sys.stdin]'"
" To reload run :so %
let macvim_skip_colorscheme=1
set number
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set colorcolumn=80
set ruler
set nowrap
set backspace=indent,eol,start
set smartcase
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell
set noerrorbells
set nobackup
set noswapfile
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L
set nohlsearch
set laststatus=2
set guifont=Courier\ New:h18 
nnoremap Q <nop>
colorscheme railscasts

syntax on
filetype plugin on

set wildmenu
" Map .bpt to .xml filetype
au BufNewFile,BufRead *.bpt set filetype=xml

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format - 
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " Delete the stupid <?xml?> header. chuck
  " 1d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction

function! DoStripDeleteTrue()
  " deletes all lines that match the pattern delete="true"
  " good for cleaning up superflows with unnecessary parameters
  g/delete="true"/d
endfunction

function! DoInsertUUID()
  let uuid=system("ruby -e 'require \"securerandom\"; print SecureRandom.uuid'")
  exe 'normal a'  . uuid
endfunction

function! DoInsertRubyVIM()
  exe 'normal i# vim: ts=2 sts=2 et'
endfunction

function! DoStripDOS()
  :%s/\r//g 
endfunction


function! Rubocop()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    " let rbc = 'rubocop '
    " let log = system(rbc.fileName)
    new | 0read ! rubocop #
    "new | 0read ! rubocop 
  else
    echo "Not Ruby file"
  endif
endfunction

function! RubocopLight()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    silent !rubocop -x %
  else
    echo "Not a Ruby File"
  endif
endfunction

function! RubocopHeavy()
  let fileName = expand("%:p")
  if fileName =~ '.rb$'
    silent !rubocop -a %
  else
    echo "Not a Ruby File"
  endif
endfunction


command! Rubocop call Rubocop()
command! RubocopLight call RubocopLight()
command! RubocopHeavy call RubocopHeavy()
command! StripDOS call DoStripDOS()
command! PrettyXML call DoPrettyXML()
command! PrettyJSON execute "%!python -m json.tool"
command! ValidateAssessment execute "!xmllint --noout --xinclude --schema ~/Perforce/ati-unstable/tests/bpslive/schemas/assessment.xsd %"
command! ValidateAudit execute "!xmllint --noout --xinclude --schema ~/Perforce/ati-unstable/tests/bpslive/schemas/audit.xsd %"
command! StripDeleteTrue call DoStripDeleteTrue()
command! InsertUUID call DoInsertUUID()
command! InsertRubyVIM call DoInsertRubyVIM()
command! HTMLEncode execute "%!perl -MHTML::Entities -pe 'encode_entities($_);'"
command! HTMLDecode execute "%!perl -MHTML::Entities -pe 'decode_entities($_);'"
command! URIDecode execute "%!python -c 'import sys, urllib as ul; [sys.stdout.write(ul.unquote_plus(line)) for line in sys.stdin]'"
command! URIEncode execute "%!python -c 'import sys, urllib as ul; [sys.stdout.write(ul.quote_plus(line)) for line in sys.stdin]'"
