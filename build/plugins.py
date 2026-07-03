from json import loads

about = loads(open("/srv/www/pi66.xyz/build/data/about.json", "r").read())

my_tools = loads(open("./build/data/my_tools.json", "r").read())
