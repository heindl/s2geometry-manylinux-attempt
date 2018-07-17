s2geometry_version = '2.2.1'

import os
import setuptools

with open(os.path.join(os.path.dirname(__file__), '../README.md')) as r_file:
    readme = r_file.read()

setuptools.setup(
    name='s2geometry',
    version='0.0.1',
    description='A package for manipulating geometric shapes, primarily designed to work with spherical geometry',
    long_description=readme,
    license='Apache',
    packages=setuptools.find_packages(),
    include_package_data=True,
)