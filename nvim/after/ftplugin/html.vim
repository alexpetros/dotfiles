nnoremap j gj
nnoremap k gk

" See help html-indent
let g:html_indent_script1 = "zero"
let g:html_indent_style1 = "zero"

let g:html_indent_autotags = "th,td,tr,tfoot,thead,p,q,f-note"

set textwidth=0

inoremap <leader>for {% for VARIABLE in VARIABLE %}<cr>{% endfor %}<esc>O
inoremap <leader>if {% if VARIABLE %}<cr>{% endif %}<esc>O
inoremap <leader>elif {% elif VARIABLE %}<cr>
inoremap <leader>inc {% include 'FILEPATH' %}<esc>hhhi
inoremap <leader>bl {% block VARIABLE %}<cr>{% endblock %}<esc>O
