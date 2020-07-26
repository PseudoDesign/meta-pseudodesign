SUMMARY = "PseudoDesign Development Image"

IMAGE_FEATURES += "splash"

LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "tools-debug"

CORE_IMAGE_EXTRA_INSTALL += "packagegroup-pseudodesign"

ENABLE_UART = "1" 