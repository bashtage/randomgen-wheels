Building and uploading randomgen wheels
========================================

We automate wheel building using this custom github repository that builds ousing GitHub actions and cibuildwheel.

Triggering a build
------------------
You will likely want to edit the `build-wheels.yml` file to specify the `BUILD_COMMIT` before triggering a build - see below.

You can trigger a build by making a commit to the randomgen-wheels repository (e.g. with git commit --allow-empty).

Which randomgen commit does the repository build?
-------------------------------------------------

The randomgen-wheels repository will build the commit specified in the `BUILD_COMMIT` at the top of the `.travis.yml` file. This can be any naming of a commit, including branch name, tag name or commit hash.

Uploading the built wheels to pypi
----------------------------------

Wheels are are automatically uploaded using [twine](https://pypi.python.org/pypi/twine). 

Of course, you will need permissions to upload to PyPI, for this to work.
