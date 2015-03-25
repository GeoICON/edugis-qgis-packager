import sys
import os
import re

base_path = sys.argv[1]

default_state_file = open(os.path.join(base_path, ".config\QGIS\state.default"), "r")
default_state_text = default_state_file.read()
default_state_file.close()

config_path = os.path.join(base_path, ".config\QGIS\QGIS2.ini")

input_file = open(config_path, 'r')
input_text = input_file.read()
input_file.close()

output_text = re.sub(r'(state\=\@ByteArray\().*(\))', r'\1' + '{{EDUGIS_WINDOW_STATE}}' +  r'\2', input_text)
output_text = output_text.replace('{{EDUGIS_WINDOW_STATE}}', default_state_text)

output_file = open(config_path, 'w')
output_file.write(output_text)
output_file.close()
