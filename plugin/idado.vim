if exists("g:loaded_image_drag_and_drop")
	finish
endif

let g:loaded_image_drag_and_drop = 1

command! ProcessImage lua require("idado").process_image_path()
