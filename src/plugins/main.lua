merodi.enable.Table()
merodi.enable.HTMLAttr()

merodi.jinja.set("about", dofile("src/data/about.lua"))
merodi.jinja.set("my_tools", dofile("src/data/my_tools.lua"))

merodi.watch.add("md")
merodi.watch.add("md/resume")
merodi.watch.add("src/templates")
merodi.watch.add("src/static")
merodi.watch.add("src/static/css")
merodi.watch.add("src/static/js")

merodi.hook("on_start_watching", function()
	merodi.log.info("Start watching")
end)

merodi.hook("on_file_changed", function(mode, filepath)
	if mode == "WRITE" then
		merodi.log.info("FILE: " .. filepath)
		if filepath:find("src/static/", 1, true) then
			merodi.log.info("Load static files")
			os.execute("cp -r src/static/ " .. merodi.config.tree.draft_dest)
		end
		os.execute("merodi build")
	end
end)
