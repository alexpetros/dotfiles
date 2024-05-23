inoremap <leader>for {% for VARIABLE in VARIABLE %}<cr>{% endfor %}<esc>O
inoremap <leader>if {% if VARIABLE %}<cr>{% endif %}<esc>O
inoremap <leader>elif {% elif VARIABLE %}<cr>
inoremap <leader>inc {% include 'FILEPATH' %}<esc>hhhi
inoremap <leader>bl {% block VARIABLE %}<cr>{% endblock %}<esc>O
