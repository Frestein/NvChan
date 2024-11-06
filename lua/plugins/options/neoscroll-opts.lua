return {
	easing = "quadratic",
	pre_hook = function(info)
		if info == "cursorline" then
			vim.wo.cursorline = false
		end
	end,
	post_hook = function(info)
		if info == "cursorline" then
			vim.wo.cursorline = true
		end
	end,
}
