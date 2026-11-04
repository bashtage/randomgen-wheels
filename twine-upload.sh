#!/usr/bin/env bash
# Sourced by the "Upload wheels" step of build-wheels.yml, which only runs after
# a merge to main.

echo "PWD: ${PWD}"
echo ls ./wheelhouse/
ls ./wheelhouse/

if [[ ${TESTPYPI_UPLOAD} == true  || ${PYPI_UPLOAD} == true ]]; then
    python -m pip install twine packaging

    # Only upload release versions, such as 2.5.0. Development versions, such as
    # 2.3.1.dev0+g3df479ce1 when BUILD_COMMIT is not a release tag, are never
    # uploaded.
    if python check-release-version.py wheelhouse; then
        if [[ ${TESTPYPI_UPLOAD} == true ]]; then
            echo twine upload --skip-existing --repository-url https://test.pypi.org/legacy/ -u __token__ -p TESTPYPI_TOKEN ./wheelhouse/*.whl
            twine upload --skip-existing --repository-url https://test.pypi.org/legacy/ -u __token__ -p $TESTPYPI_TOKEN ./wheelhouse/*.whl
        else
            echo "Test PyPi upload is disabled"
        fi

        if [[ ${PYPI_UPLOAD} == true ]]; then
            echo twine upload --skip-existing -u __token__ -p PYPI_TOKEN ./wheelhouse/*.whl
            twine upload --skip-existing -u __token__ -p $PYPI_TOKEN ./wheelhouse/*.whl
        else
            echo "PyPi upload is disabled"
        fi
    else
        echo "All PyPi uploading is disabled: the wheels do not have a release version"
    fi
else
    echo "All PyPi uploading is disabled"
fi
