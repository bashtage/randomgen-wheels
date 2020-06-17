# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]


function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    if [ -n "$IS_OSX" ]; then
        # Only x86_64 by default
        ARCH_FLAGS=${ARCH_FLAGS:-"-arch x86_64"}
    fi
}

function pip_opts {
    # Define extra pip arguments
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    export PYTHONHASHSEED=$(python -c 'import random; print(random.randint(1, 4294967295))')
    echo $PATH
    which -a python
    pip list
    python -c 'import randomgen; randomgen.test(extra_args=["--skip-slow", "-n=2"])'
}
