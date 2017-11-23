FROM centos:7

WORKDIR /clR

RUN yum -y install epel-release \\
        && yum -y groupinstall "Development Tools" \\
        && yum -y install R \\
        && yum -y install libcurl-devel openssl-devel libssh2-devel udunits2-devel libxml2-devel gsl-devel \\
        && yum clean all

# CRAN mirror is set to Uni Göttingen (Germany), choose as appropriate
# Install the udunits2 package with appropriate include path to fix install errors
RUN R -e 'chooseCRANmirror(graphics=FALSE, ind=29);' \\
        -e 'install.packages("udunits2",configure.args="--with-udunits2-include=/usr/include/udunits2");' \\
        -e 'install.packages("devtools");' \\
        -e 'devtools::install_github("rvidgen/clr")'

ENTRYPOINT R
