import platform
import subprocess
import sys

if sys.version_info < (3, 11) and platform.system().lower().startswith("win"):
    pytest = "pytest==7.0.1"
    subprocess.check_call([sys.executable, "-m", "pip", "install", pytest])
