SUMMARY = "Packages installed in the standard PseudoDesign runtime"
PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = "\
     openssh \
     python3 \
     packagegroup-core-buildessential \
     python3-pip \
     git \
     vim \
     init-ifupdown \
     python3-video-latency-test \
"
