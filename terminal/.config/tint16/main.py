import json
import os
import sys

from palette import Palette

tint16_dir = os.path.dirname(os.path.abspath(__file__))


def save_to_file(filename, content):
    with open(filename, "w") as f:
        f.write(content)


def load_templates():
    template_dir = os.path.join(tint16_dir, "templates")
    templates = {}
    for filename in os.listdir(template_dir):
        with open(os.path.join(template_dir, filename), "r") as template_file:
            templates[filename] = template_file.read()
    return templates


def generate_config_from_template(template, color_scheme):
    color_values = color_scheme.to_dict()
    # format converts any `{{` to `{`, this is useful for rofi
    return template.format(**color_values)


def main(json_input):
    color_scheme = Palette.from_json(json.loads(json_input))
    templates = load_templates()

    palettes_dir = os.path.join(tint16_dir, "palettes")
    os.makedirs(palettes_dir, exist_ok=True)

    # Generate configuration files from each template
    for template_name, template_content in templates.items():
        terminal_config = generate_config_from_template(template_content, color_scheme)
        save_to_file(os.path.join(palettes_dir, template_name), terminal_config)
    print(f"Configuration files generated for {color_scheme.name} successfuly")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python main.py <path_to_json_file>")
        sys.exit(1)

    json_file_path = sys.argv[1]

    with open(json_file_path, "r") as json_file:
        json_input = json_file.read()

    main(json_input)
