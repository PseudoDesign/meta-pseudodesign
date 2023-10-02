# Replace use the network interfaces script with the one in .../files/pseudodesign/interfaces
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://pseudodesign/interfaces "

do_install:append() {
    sed -i -e 's#[@]PSEUDODESIGN_WIFI_INTERFACE[@]#${PSEUDODESIGN_WIFI_INTERFACE}#' ${WORKDIR}/pseudodesign/interfaces
	install -m 0644 ${WORKDIR}/pseudodesign/interfaces ${D}${sysconfdir}/network/interfaces
    
}

CONFFILES_${PN} += "${sysconfdir}/network/interfaces"