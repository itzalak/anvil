#!/usr/bin/env python3

"""
Decorate environment using templates with provided colorscheme.
Color schemes can be exported as json from terminal.sexy, examples can be found under decorate/colorschemes.

This script loads a json source file, used to replace in memory the {{variables}} for all files inside
decorator/template folder and replacing decorator/output resources.


Template files:
* Xresources
* rofi
* alacritty
* wezterm - //Reloads by shortcut https://wezfurlong.org/wezterm/config/lua/keyassignment/ReloadConfiguration.html

"""

import argparse
import glob
import json
import os
import platform
import sys

__version__ = "3.0.1"

HOME = os.getenv("HOME")
SESSION = os.getenv("$XDG_SESSION_DESKTOP")
WMANAGER = os.getenv("XDG_CURRENT_DESKTOP")
DECORATOR = f"{os.getenv('XDG_CONFIG_HOME')}/decorator"
COLORSCHEMES = f"{DECORATOR}/colorschemes"
TEMPLATE_DIR = f"{DECORATOR}/templates"
OUTPUT_DIR = f"{DECORATOR}/output"


def define_arguments():
    """
    Define allowed arguments.
    Refer to https://docs.python.org/3/library/argparse.html for documentation
    """
    parser = argparse.ArgumentParser("Decorate environment")
    parser.add_argument(
        "-v", "--version", action="version", version="%(prog)s " + __version__
    )
    parser.add_argument(
        "-s",
        "--source",
        type=str,
        help="Full path to JSON configuration file",
        required=False,
    )
    parser.add_argument(
        "-c",
        "--colorscheme",
        type=str,
        help="color cheme name",
        required=False,
    )
    parser.add_argument(
        "-l",
        "--list",
        action="store_true",
        help="Returns list of available color schemes",
    )
    return parser


def parse_args(parser: argparse.ArgumentParser):
    """Process command line arguments"""
    args = parser.parse_args()

    if len(sys.argv) <= 1:
        sys.exit("No arguments given, run decorate -h")

    if args.list:
        return decorator_colorschemes()

    if args.colorscheme:
        return colorscheme(args.colorscheme)

    elif args.source:
        return assert_file_exists(args.source)


def assert_directory_exists(directory):
    if os.path.exists(directory) is False:
        sys.exit(f"Required {directory} does not exist")
    if not os.listdir(directory):
        sys.exit(f"Required {directory} is empty")


def assert_file_exists(colorscheme):
    if colorscheme is None or os.path.exists(colorscheme) is False:
        sys.exit(f"File {colorscheme} does not exist")
    return colorscheme


def decorator_colorschemes():
    """Print all available color schemes"""
    for scheme in glob.glob(f"{COLORSCHEMES}/*"):
        print(os.path.splitext(os.path.basename(scheme))[0])
    sys.exit()


def colorscheme(name: str):
    """Gets all colorscheme in decorator and validates the given input corresponds to a filename"""
    colorscheme_path = None
    for scheme in glob.glob(f"{COLORSCHEMES}/*"):
        filename = os.path.splitext(os.path.basename(scheme))[0]
        if name == filename:
            colorscheme_path = scheme
    if colorscheme_path is not None:
        return colorscheme_path
    else:
        sys.exit(f"Colorscheme {name} is not present in decorator folder")


def terminal_sexy_json(filename):
    """Opens file and returns a json"""
    with open(filename) as json_file:
        return json.load(json_file)


def parse_colors(json_file: dict) -> dict:
    """Parse terminal sexy colorscheme"""

    terminal_sexy = {
        "foreground": json_file["foreground"],
        "background": json_file["background"],
    }

    for index, color in enumerate(json_file["color"]):
        terminal_sexy[f"color{index}"] = color

    return terminal_sexy


def get_lines(filename: str) -> list:
    """Open file and return list of lines"""
    with open(filename, "rt") as data:
        return list(data)


def replace_template(line: str, colorscheme_dict: dict) -> str:
    """Replace {variables} in template line"""
    for key, value in colorscheme_dict.items():
        handlebars = "{{%s}}" % key
        if handlebars in line:
            new_line = line.replace(handlebars, value)
            return new_line
    return line


def get_component(color_hex, component):
    """Convert hex colors to rgb components"""
    color_hex = color_hex.lstrip("#")
    num = 0.0
    if component == "r":
        num = int("0x" + color_hex[0:2], 16) / 255
    elif component == "g":
        num = int("0x" + color_hex[2:4], 16) / 255
    elif component == "b":
        num = int("0x" + color_hex[4:6], 16) / 255
    return f"{num:.16f}"


def get_iterm_colors(color_dict: dict):
    """Return dict with rgb component colors"""
    iterm_colors = {}
    for color, hex in color_dict.items():
        iterm_colors[f"{color}.r"] = get_component(hex, "r")
        iterm_colors[f"{color}.g"] = get_component(hex, "g")
        iterm_colors[f"{color}.b"] = get_component(hex, "b")
    return iterm_colors


def replace_colors(lines: list, colorscheme_dict: dict) -> list:
    """Replace line placeholder variables with colors"""
    new_lines = []
    for line in lines:
        res = replace_template(line, colorscheme_dict)
        new_lines.append(res)
    return new_lines


def write_new_file(filepath: str, lines: list):
    filename = os.path.basename(filepath)
    schema = open(f"{OUTPUT_DIR}/{filename}", "w", newline="", encoding="utf-8")
    for entry in lines:
        schema.write(entry)


def reload_xresources():
    # Reload linux system colors, needed for rofi, urxvt, etc...
    os.system(f"xrdb {HOME}/.Xresources")


# Validate required directories exist
assert_directory_exists(TEMPLATE_DIR)
assert_directory_exists(OUTPUT_DIR)
assert_directory_exists(COLORSCHEMES)

# Load templates
template_files = glob.glob(f"{TEMPLATE_DIR}/*")

# Evaluate arguments for loading color schemes
arguments = define_arguments()
parsed_arguments = parse_args(arguments)

# Parse colors from given file argument
parsed_colorscheme = parse_colors(terminal_sexy_json(parsed_arguments))

# Create output files
for path in template_files:
    file_lines = get_lines(path)
    if "iterm.itermcolors" in path:
        iterm = get_iterm_colors(parsed_colorscheme)
        new_file_lines = replace_colors(file_lines, iterm)
    else:
        new_file_lines = replace_colors(file_lines, parsed_colorscheme)
    write_new_file(path, new_file_lines)

# Reload environment
if platform.system() == "Linux":
    reload_xresources()
