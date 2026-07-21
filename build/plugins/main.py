from json import loads

about = loads(open("./build/data/about.json", "r").read())

my_tools = loads(open("./build/data/my_tools.json", "r").read())
