hide_guake
command "python -c 'import pty; pty.spawn(\"/bin/bash\")'"
ctrl Z
command "stty raw -echo"
command "fg"
command "export TERM=xterm"
