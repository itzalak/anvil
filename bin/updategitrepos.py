#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys
from datetime import datetime

__version__ = "0.2.0"

HOME = os.getenv("HOME", os.getenv("USERPROFILE"))


# TODO: Broken, remove automatic anvil update and logs need to be updated they are ugly
def define_arguments():
    """
    Define allowed arguments.
    Refer to https://docs.python.org/3/library/argparse.html for documentation
    """
    parser = argparse.ArgumentParser("Update git repositories")
    parser.add_argument(
        "-v", "--version", action="version", version="%(prog)s " + __version__
    )
    parser.add_argument(
        "-s",
        "--source",
        type=str,
        metavar="/home/user/path/to/folder",
        help="Full path to repositories folder",
    )
    parser.add_argument(
        "-f",
        "--foundry",
        action="store_true",
        help="Update foundry repositories",
    )
    parser.add_argument(
        "-i",
        "--ignore",
        nargs="*",
        type=str,
        metavar="/home/user/folder /home/user/other/folder",
        help="Directories to ignore separated by space",
    )
    parser.add_argument(
        "-r",
        "--run",
        action="store_true",
        default=False,
        help="Execute git repositories update",
    )

    return parser


def parse_arguments(parser: argparse.ArgumentParser):
    """The handling of parameters from the command line"""

    args, unknowns = parser.parse_known_args()

    if len(sys.argv) <= 1:
        sys.exit("No arguments given, run updategitrepos -h")

    if args.foundry:
        args.source = os.path.join(HOME, "foundry")

    if args.source is not None and not os.path.exists(args.source):
        sys.exit(f"Directory not found: {args.source}")

    if type(args) == argparse.Namespace:
        args = vars(args)
    print(f"Config: {args}")
    return args


def print_result(result: subprocess.CompletedProcess):
    """Print command results in a readable form"""

    if result.returncode != 0:
        print("[ERROR]")
        print(f"Previous git command not successful with code {result.returncode}")

    if result.stdout != "":
        print("[STDOUT]")
        print(result.stdout)

    if (
        result.stderr != ""
        and result.stderr != "Already on 'master'}"
        and result.stderr != "Already on 'main'"
    ):
        print("[STDERR]")
        print(f"{result.stderr}")


def run_subprocess(command: list, exception_check: bool = True):
    """
    Executes subprocess run with given arguments and returns the result.
    If exception_check is True and process exist with a non 0 value an exception will be raised.
    """
    print("[COMMAND]")
    print(" ".join(command))
    print("\n")

    return subprocess.run(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=exception_check,
    )


def resolve_repository_changes():
    """
    Validates if uncommitted changes exist in the repository.
    If there are, stashes all changes with a message.
    """
    status = run_subprocess(["git", "status", "-s"])
    print_result(status)
    if status.returncode != 0 or status.stderr != "" or status.stdout != "":
        # Stashes all changes including untracked files with a date message
        date = str(datetime.now()).split(".")[0]
        stash = run_subprocess(
            [
                "git",
                "stash",
                "push",
                "--include-untracked",
                "--message",
                f"GIT AUTO UPDATE {date}",
            ]
        )
        print_result(stash)


def resolve_default_branch():
    """
    Validates on remote which branch is default - between master and main
    Checks if current branch corresponds to default.
    If not, checks out default branch.
    """
    # Checks if default branch is master or main
    default = run_subprocess(
        ["git", "ls-remote", "--exit-code", "--heads", "origin", "main"], False
    )
    if default.returncode == 0:
        default_branch = "main"
    else:
        default_branch = "master"

    # Checks current branch
    current_branch = run_subprocess(["git", "branch", "--show-current"])
    if current_branch.stdout.strip() != f"{default_branch}":
        # Checkout master or main, any other will return an error and stop script
        checkout_default_branch = run_subprocess(["git", "checkout", default_branch])
        print_result(checkout_default_branch)


def ignore_repo(directory_path: str, ignore_list: list) -> bool:
    for ignore in ignore_list:
        if ignore in directory_path:
            return True
    return False


def update_repos(repositories_dir: str, execute_command: bool, ignore_list: list):
    """
    Validates directory is a git repository,
    changes to said directory
    stashes any present changes including untracked files,
    checks out master or main
    pulls all changes from origin
    """
    if repositories_dir is not None and not os.path.exists(repositories_dir):
        sys.exit(f"ERROR: Directory not found: {repositories_dir}")

    for dir_path, dir_names, filenames in os.walk(repositories_dir):
        ignore = ignore_repo(dir_path, ignore_list)
        # Validates directory is a git repository and not in ignore list
        if ".git" in dir_names and not ignore:
            repo = os.path.abspath(dir_path)
            # Change to given directory
            os.chdir(repo)
            if execute_command is False:
                print(f"{repo}")

            else:
                print(
                    "\n#############################################################\n"
                )
                print("[REPOSITORY]")
                print(f"{repo}")
                print("\n")

                resolve_repository_changes()
                resolve_default_branch()

                # Pull any changes from origin
                pull = run_subprocess(["git", "pull"])
                print_result(pull)


arguments = define_arguments()
directory_to_update = parse_arguments(arguments)
update_repos(
    directory_to_update.get("source"),
    directory_to_update.get("run"),
    directory_to_update.get("ignore"),
)
