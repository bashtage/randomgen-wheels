Building and uploading randomgen wheels
========================================

We automate wheel building using this custom github repository that builds ousing GitHub actions and cibuildwheel.

Triggering a build
------------------
You will likely want to edit the `build-wheels.yml` file to specify the `BUILD_COMMIT` before triggering a build - see below.

You can trigger a build by making a commit to the randomgen-wheels repository (e.g. with git commit --allow-empty).

Which randomgen commit does the repository build?
-------------------------------------------------

The randomgen-wheels repository will build the commit specified in the `BUILD_COMMIT` at the top of `.github/workflows/build-wheels.yml`. This can be any naming of a commit, including branch name, tag name or commit hash.

Uploading the built wheels to pypi
----------------------------------

Wheels are are automatically uploaded using [twine](https://pypi.python.org/pypi/twine), but only when all of these hold:

* The build runs after a merge (a push) to `main`. Builds for pull requests never upload, so a pull request can be used to test a build.
* `PYPI_UPLOAD` (or `TESTPYPI_UPLOAD` for Test PyPI) is `true` in `build-wheels.yml`.
* The wheels have a release version, such as `2.5.0` from `BUILD_COMMIT: "v2.5.0"`. Pre-releases such as `2.5.0rc1` count as releases. Development versions such as `2.3.1.dev0+g3df479ce1`, which a `BUILD_COMMIT` that is not a release tag produces, and other local versions such as `2.3.1+abc` are never uploaded. `check-release-version.py` makes this check.

Of course, you will need permissions to upload to PyPI, for this to work.
