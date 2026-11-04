"""Exit with 0 if every wheel in a directory has a release version, 1 otherwise.

Release versions, such as 2.5.0, 2.5.0rc1 or 2.5.0.post1, are uploaded to PyPI.
Development versions, such as 2.3.1.dev0+g3df479ce1, which setuptools_scm gives
a commit that is not a release tag, and other local versions, such as
2.3.1+abc, are not.

Usage: python check-release-version.py [directory]   (default: wheelhouse)
"""

import pathlib
import sys

from packaging.utils import parse_wheel_filename

directory = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "wheelhouse")
wheels = sorted(directory.glob("*.whl"))
if not wheels:
    print(f"No wheels found in {directory}")
    sys.exit(1)

all_release = True
for wheel in wheels:
    version = parse_wheel_filename(wheel.name)[1]
    release = not version.is_devrelease and version.local is None
    kind = "a release version" if release else "not a release version"
    print(f"{wheel.name}: {version} is {kind}")
    all_release = all_release and release

sys.exit(0 if all_release else 1)
