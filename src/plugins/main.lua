merodi.enable.Table()
merodi.enable.HTMLAttr()

merodi.jinja.set("about", dofile("src/plugins/data/about.lua"))
merodi.jinja.set("my_tools", dofile("src/plugins/data/my_tools.lua"))

merodi.watch.add("md")
merodi.watch.add("md/resume")
merodi.watch.add("src/templates")
merodi.watch.add("md/static")
merodi.watch.add("md/static/css")
merodi.watch.add("md/static/js")

merodi.hook("before_read", function()
    merodi.log.info("building: " .. merodi.build.md_path.get())
end)

merodi.hook("on_start_watching", function()
	merodi.log.info("Start watching")
end)

merodi.hook("on_file_changed", function(mode, filepath)
	if mode == "WRITE" then
		merodi.log.info("FILE: " .. filepath)
		os.execute("merodi build")
	end
end)
