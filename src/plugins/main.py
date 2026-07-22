from json import loads

about = loads(open("./src/data/about.json", "r").read())

my_tools = loads(open("./src/data/my_tools.json", "r").read())
