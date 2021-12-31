runtime macros/matchit.vim  " enable extended % matching

let g:NERDTreeShowHidden=1
let g:NERDTreeAtoDeleteBuffer=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.idea$[[dir]]', '\.sass-cache$', '\.pyc$', '__pycache__']
let g:NERDTreeMapCustomOpen = "l"
let g:NERDTreeMapCloseDir = "h"
let g:NERDTreeMapCloseChildren = "H"

let bufferline = get(g:, 'bufferline', {})
let bufferline.add_in_buffer_number_order = v:true
let bufferline.animation = v:true
let bufferline.auto_hide = v:false
let bufferline.tabpages = v:true
let bufferline.closable = v:true
let bufferline.clickable = v:true
let bufferline.icons = v:true
let bufferline.icon_custom_colors = v:false
let bufferline.icon_separator_active = '▎'
let bufferline.icon_separator_inactive = '▎'
let bufferline.icon_close_tab = ''
let bufferline.icon_close_tab_modified = '●'
let bufferline.icon_pinned = '車'
let bufferline.insert_at_start = v:false
let bufferline.insert_at_end = v:true
let bufferline.maximum_padding = 4
let bufferline.maximum_length = 30
let bufferline.semantic_letters = v:true
let bufferline.letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'
let bufferline.no_name_title = v:null

let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 1

let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
let g:ctrlp_match_current_file = 1 " to include current file in matches