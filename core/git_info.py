import subprocess
from typing import Optional


def get_git_revision_hash() -> Optional[str]:
    try:
        return (
            subprocess.check_output(
                ["git", "rev-parse", "HEAD"], stderr=subprocess.DEVNULL
            )
            .decode("ascii")
            .strip()
        )
    except subprocess.CalledProcessError:
        return None


def get_git_revision_short_hash() -> Optional[str]:
    try:
        return (
            subprocess.check_output(
                ["git", "rev-parse", "--short", "HEAD"],
                stderr=subprocess.DEVNULL,
            )
            .decode("ascii")
            .strip()
        )
    except subprocess.CalledProcessError:
        return None


def get_git_checked_out_branch() -> Optional[str]:
    try:
        return (
            subprocess.check_output(
                ["git", "branch", "--show-current"], stderr=subprocess.DEVNULL
            )
            .decode("ascii")
            .strip()
        )
    except subprocess.CalledProcessError:
        return None


def get_all_git_info():
    try:
        return f"Short Git commit hash: {get_git_revision_short_hash()}, Checked Out Branch= {get_git_checked_out_branch()}"
    except Exception:
        return ""


if __name__ == "__main__":
    # Usage
    full_hash = get_git_revision_hash()
    short_hash = get_git_revision_short_hash()
    git_branch = get_git_checked_out_branch()

    print(f"Full Git commit hash: {full_hash}")
    print(f"Short Git commit hash: {short_hash}")
    print(f"Git Checked Out Branch: {git_branch}")
