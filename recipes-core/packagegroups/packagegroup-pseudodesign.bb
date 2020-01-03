SUMMARY = "Packages installed in the standard PseudoDesign runtime"
PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = "\
     openssh \
     docker \
     git \
     vim \
     init-ifupdown \
     sshd \
"