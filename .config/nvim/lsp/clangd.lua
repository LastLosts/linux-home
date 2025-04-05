return {
	cmd = { 'clangd', '--background-index', '--clang-tidy' },
	filetypes = { 'cpp', 'cxx', 'hpp', 'h' },
	root_markers = { 'compile_commands.json' },
}
