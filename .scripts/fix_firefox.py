import shutil
import os
import os.path

PATH = os.path.expanduser("~/.mozilla/firefox/")
custom_css = """
input {
  border: 2px inset white;
  background-color: white;
  color: black;
  -moz-appearance: none !important;
}

textarea {
  border: 2px inset white;
  background-color: white;
  color: black;
  -moz-appearance: none !important;
}

select {
  border: 2px inset white;
  background-color: white;
  color: black;
  -moz-appearance: none !important;
}

input[type="radio"],
input[type="checkbox"] {
  border: 2px inset white !important;
  background-color: white !important;
  color: ThreeDFace !important;
  -moz-appearance: none !important;
}

*|*::-moz-radio {
  background-color: white;
  -moz-appearance: none !important;
}

button,
input[type="reset"],
input[type="button"],
input[type="submit"] {
  border: 2px outset white;
  background-color: #eee;
  color: black;
  -moz-appearance: none !important;
}

body {
  background-color: white;
  color: black;
  display: block;
  margin: 8px;
  -moz-appearance: none !important;
}"""

for folder in os.listdir(PATH):
    if ".default" in folder:
        chrome_dir = os.path.join(PATH, folder, "chrome")
        try:
            os.mkdir(chrome_dir)
        except FileExistsError:
            pass

        css_path = os.path.join(chrome_dir, "userContent.css")

        print(f'>> Using path: {css_path}')
        try:
            existing_size = os.stat(css_path).st_size
        except FileNotFoundError:
            existing_size = 0
        if existing_size == 0:
            print(f"Creating custom CSS.")
        elif existing_size == len(custom_css):
            print(f"Fix is already present.")
        else:
            print(f"Not overwriting existing custom CSS file of size: {existing_size}")
