#!/usr/bin/env python3

"""
Generates `git clone` commands based on given input file.
Uses name to define the directory and subdirectories.

Input yaml file should be in the following structure:
directory_one:
- git@github.com:user/repository_one.git

directory_two:
- git@github.com:user/repository_two.git
- subdirectory_one:
  - git@github.com:user/repository_three.git
  - git@github.com:user/repository_four.git
- subdirectory_two:
  - git@github.com:user/repository_five.git
  - nested_subdirectory_one:
    - git@github.com:user/orepository_six.git

Environment variable $HOME must be defined.
"""

import os
import sys
from argparse import ArgumentParser, Namespace

__version__ = "1.0.1"

from typing import Dict, Any

import yaml

parser = ArgumentParser()


def define_arguments():
    """
    Define allowed arguments.
    Refer to https://docs.python.org/3/library/argparse.html for documentation
    """
    parser.add_argument(
        "-v", "--version", action="version", version="%(prog)s " + __version__
    )
    parser.add_argument(
        "-s", "--source", type=str, help="YAML configuration file", required=True
    )
    parser.add_argument(
        "-r",
        "--run",
        action="store_true",
        default=False,
        help="Execute commands - will attempt to create git repos",
    )


def get_arguments() -> Dict[str, Any]:
    """The handling of parameters from the command line"""
    args, unknowns = parser.parse_known_args()

    if args.source is not None and not os.path.exists(args.source):
        sys.exit(f"File not found: {args.source}")
    if type(args) is Namespace:
        args = vars(args)

    print(f"Arguments: {args}")
    return args


HOME = os.getenv("HOME")


def read_yaml(filepath: str):
    """Returns a yaml object from given file"""
    with open(filepath) as read_file:
        try:
            yaml_file = yaml.safe_load(read_file)
        except ValueError as err:
            sys.exit(f"Failure reading file: {err}")
    return yaml_file


def parse_repositories(yaml_obj: Any, directory: str = ""):
    """
    Returns a flat dict composed of directory and repository lists based on the yaml structure.
    Directory is a composite of root node plus subdirectory, if it exists.
    """
    repository_dt = {}
    for key, value in yaml_obj.items():
        current_path = os.path.join(directory, key)
        if isinstance(value, list):
            for item in value:
                if isinstance(item, str):
                    repository_dt.setdefault(current_path, []).append(item)
                elif isinstance(item, dict):
                    # Recursive call for nested dictionaries
                    repository_dt.update(parse_repositories(item, current_path))
    return repository_dt


def create_commands(repository_structure: dict, destination: str):
    """
    Creates git clone command for all git repositories in a given dict
    generating a destination folder based on given arguments and
    git repository name

    If destination folder exists, does not clone that repository

    Returns string commands for cloning
    """
    commands = []
    for folder in repository_structure:
        for repo in repository_structure[folder]:
            name = repo.split(".git")[0].split("/")[-1]
            directory = f"{destination}/{folder}/{name}"
            if os.path.exists(directory):
                print(f"\n[WARN] {directory} exists, repo will not be cloned")
            else:
                command = f"git clone {repo} {destination}/{folder}/{name}"
                commands.append(command)
    return commands


def execute_commands(commands: list, run_command: bool = False):
    """Executes passed command list"""
    for command in commands:
        print(f"\n[COMMAND] {command}")
        if run_command:
            os.system(command)


def main(args):
    yaml_object = read_yaml(args.get("source"))
    repos = parse_repositories(yaml_object)
    command_list = create_commands(repos, f"{HOME}")

    execute_commands(command_list, args.get("run"))


if __name__ == "__main__":
    define_arguments()
    arguments = get_arguments()
    main(arguments)
