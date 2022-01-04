runtime macros/matchit.vim  " enable extended % matching

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

let g:coq_settings = { 'auto_start': 'shut-up' }

let g:suda_smart_edit = v:true

let g:chadtree_settings = {
    'keymap.toggle_hidden': ["."]
}

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'firefox'
let g:mkdp_echo_preview_url = 1
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']