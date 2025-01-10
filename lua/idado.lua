local M = {}

-- Configuration parameters
M.config = {
	target_path = "~/Documents/images/", -- Defines the output path
	pattern = "%Y-%m-%d_%H-%M-%S", -- Defines the pattern which should be used
}

---Generate the new filename using a certain pattern
---@param extension string: file suffix of the given image file
---@return string: the final filename of the image
local generate_filename = function(extension)
	local timestamp = os.date(M.config.pattern)
	return timestamp .. "." .. extension
end

---Uses the os module copy the file from source to destination
---@param source string: Input filepath
---@param destination string: Output filepath
local copy_file = function(source, destination)
	local command = string.format("cp '%s' '%s'", source, destination)
	os.execute(command)
end

---Removes any escaped spaces from the filename
---@param path string: Input filepath
---@return string: Fixed filepath
local normalize_path = function(path)
	return path:gsub("\\", "")
end

---This is the main function for doing the whole job
M.process_image_path = function()
	-- Get the current buffer line
	local line = vim.fn.getline(".")
	local source_path = normalize_path(line)

	-- Check if the line is a valid file
	if not vim.fn.filereadable(source_path) then
		vim.notify("This is not a valid filepath: " .. line, vim.log.levels.ERROR)
		return
	end

	local extension = source_path:match("%.([^.]+)$")
	if not extension then
		vim.notify("Cannot find a valid file extension!", vim.log.levels.ERROR)
		return
	end

	local target_dir = vim.fn.expand(M.config.target_path)
	local new_filename = generate_filename(extension)
	local target_path = target_dir .. new_filename

	-- Create target path if it does not exist
	vim.fn.mkdir(target_dir, "p")

	copy_file(source_path, target_path)

	-- Generate Markdown line, and replace the filepath
	local markdown_image = string.format("![%s](%s)", new_filename, target_path)
	vim.fn.setline(".", markdown_image)

	vim.notify("Image successfully added: " .. target_path, vim.log.levels.INFO)
end

return M
