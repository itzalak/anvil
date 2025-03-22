#!/usr/bin/env python3


import os
import hashlib
import sys


def calculate_sha256(file_path):
    """Calculate the SHA-256 hash of a file."""
    sha256 = hashlib.sha256()
    try:
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                sha256.update(chunk)
    except IOError:
        print(f"Error reading file: {file_path}")
        return None
    return sha256.hexdigest()


def get_all_files(directory, exclude_dir=None):
    """Recursively get all files in a directory, excluding a specified directory."""
    all_files = {}
    for root, dirs, files in os.walk(directory):
        ## TODO: here
        if exclude_dir and os.path.abspath(root).startswith(
            os.path.abspath(exclude_dir)
        ):
            continue
        for file in files:
            file_path = os.path.join(root, file)
            relative_path = os.path.relpath(file_path, directory)
            all_files[relative_path] = file_path
    return all_files


def compare_directories(dir1, dir2, exclude_dir=None):
    """Compare two directories and return files that differ."""
    files_dir1 = get_all_files(dir1, exclude_dir)
    files_dir2 = get_all_files(dir2, exclude_dir)

    differing_files = []
    only_in_dir1 = []
    only_in_dir2 = []

    # Check for files that are in both directories
    common_files = set(files_dir1.keys()).intersection(set(files_dir2.keys()))
    for file in common_files:
        hash1 = calculate_sha256(files_dir1[file])
        hash2 = calculate_sha256(files_dir2[file])
        if hash1 != hash2:
            differing_files.append(file)

    # Check for files that are only in one directory
    only_in_dir1 = set(files_dir1.keys()) - set(files_dir2.keys())
    only_in_dir2 = set(files_dir2.keys()) - set(files_dir1.keys())

    return differing_files, list(only_in_dir1), list(only_in_dir2)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(
            "Usage: python compare_directories.py <directory1> <directory2> [--exclude <exclude_directory>]"
        )
        sys.exit(1)

    dir1 = sys.argv[1]
    dir2 = sys.argv[2]
    ## TODO: exclude by looking for partial path
    exclude_dir = None

    if len(sys.argv) == 5 and sys.argv[3] == "--exclude":
        exclude_dir = sys.argv[4]

    differing_files, only_in_dir1, only_in_dir2 = compare_directories(
        dir1, dir2, exclude_dir
    )

    print("Files that exist in both directories but are different:")
    for file in differing_files:
        print(file)

    print("\nFiles that only exist in the first directory:")
    for file in only_in_dir1:
        print(file)

    print("\nFiles that only exist in the second directory:")
    for file in only_in_dir2:
        print(file)
