merodi.enable.Table()
merodi.enable.HtmlAttr()

merodi.jinja.set("about", dofile("src/data/about.lua"))
merodi.jinja.set("my_tools", dofile("src/data/my_tools.lua"))

merodi.watch.add("md")
merodi.watch.add("src/templates")
merodi.watch.add("src/static")
merodi.watch.add("src/static/css")
merodi.watch.add("src/static/js")

merodi.hook("on_start_watching", function()
	merodi.log.info("Start watching")
end)

merodi.hook("on_file_changed", function(mode, filepath)
	-- this is for development only
	if mode == "WRITE" then
		merodi.log.info("FILEPATH: " .. filepath)
		if filepath:find("src/static/", 1, true) then
			merodi.log.info("Load static files")
			os.execute("cp -r src/static/ draft/")
		end
		os.execute("merodi build")
	end
end)
