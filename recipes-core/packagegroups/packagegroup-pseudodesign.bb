SUMMARY = "Packages installed in the standard PseudoDesign runtime"
PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = "\
     openssh \
     python3 \
     python3-pip \
     git \
     vim \
     init-ifupdown \
"
