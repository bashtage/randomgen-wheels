if "%CONDA_BUILD%" == "true" (
    :: Needed for building extensions in python2.7 x64 with cmake.
    :: Since python version and arch is not known at this point, install it everywhere.
    set CPU_COUNT=2
    set PYTHONUNBUFFERED=1

    conda install -c conda-forge vs2008_express_vc_python_patch
    call setup_x64

    conda install conda-build anaconda-client conda-verify
    if "%CONDA_UPLOAD%" == "true" (
        conda config --set anaconda_upload yes
    ) else (
        conda config --set anaconda_upload no
    )
    echo conda build --python %PY_VER% --numpy %CONDA_NUMPY_VERSION% ./conda-recipe
    conda build --python %PY_VER% --numpy %CONDA_NUMPY_VERSION% --user %ANACONDA_USERNAME% --token %ANACONDA_TOKEN% ./conda-recipe
) else (
    echo "conda build is disabled"
)
