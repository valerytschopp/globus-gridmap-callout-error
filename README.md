globus-gridmap-callout-error
============================

Debian 6 port of the missing globus-gridmap-callout-error 0.3 package for EMI.

Original Source
---------------
The original debian control files comes from Nordugrid:

    SVN: http://svn.nordugrid.org/repos/packaging/debian/globus-gridmap-callout-error
    Revision: 558

The upstream version is:

    globus_gridmap_callout_error-0.3


Building the Debian package
--------------------------

Get the upstream source:

    make -f debian/rules get-orig-source

Prepare the build:

    mkdir debbuild
    cp -v globus-gridmap-callout-error_0.3.orig.tar.gz debbuild
    tar -C debbuild -xvf globus-gridmap-callout-error_0.3.orig.tar.gz
    cp -vr debian debbuild/globus-gridmap-callout-error-0.3

To build the source package:

    cd debbuild
    dpkg-source -b globus-gridmap-callout-error-0.3
    
    
To build the binary packages:

    cd debbuild/globus-gridmap-callout-error-0.3
    debuild -us -uc
