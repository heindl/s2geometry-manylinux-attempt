s2geometry_version = '2.2.1'

import os
import setuptools

with open(os.path.join(os.path.dirname(__file__), '../README.md')) as r_file:
    readme = r_file.read()

module1 = setuptools.Extension('demo',
                    define_macros = [('MAJOR_VERSION', '1'),
                                     ('MINOR_VERSION', '0')],
                    include_dirs = ['/usr/local/include'],
                    libraries = ['tcl83'],
                    library_dirs = ['/usr/local/lib'],
                    sources = ['demo.c'])

setuptools.setup(
    name='s2geometry',
    version='0.0.1',
    description='A package for manipulating geometric shapes, primarily designed to work with spherical geometry',
    long_description=readme,
    license='Apache',
    packages=setuptools.find_packages(),
    include_package_data=True,
)