import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

with open("requirements.txt") as f:
    required_dependencies = f.read().splitlines()

setuptools.setup(
    name="DSML_Docker",
    version="0.4",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/sush4nt/DSML_Docker",
    packages=setuptools.find_packages(),
)