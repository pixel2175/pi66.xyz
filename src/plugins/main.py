from json import loads
import subprocess, os

@hook("on_end")
def sync_static():
    if api.mode == "release":
        try:
            subprocess.run([
                "rsync", "-a",
                api.config.tree.static + "/",
                os.path.join(os.path.dirname(api.config.tree.release_dest), "static")
            ])
            api.log.info("Static files synced successfully.")
        except Exception as e:
            api.log.die(f"Failed to sync static files: {e}")

about = loads(open("./src/data/about.json", "r").read())

my_tools = loads(open("./src/data/my_tools.json", "r").read())
