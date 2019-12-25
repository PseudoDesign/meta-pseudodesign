PACKAGECONFIG += "networkd resolved"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " file://wireless.network"


FILES_${PN} += "${sysconfdir}/systemd/network/wireless.network"


do_install_append() {
  if ${@bb.utils.contains('PACKAGECONFIG','networkd','true','false',d)}; then
   if [ -n "$PSEUDODESIGN_WIFI_SSID" ] && [ -n "$PSEUDODESIGN_WIFI_PSK" ] && [ -n "$PSEUDODESIGN_WIFI_INTERFACE" ] 
    then
        sed -i -e 's#[@]PSEUDODESIGN_WIFI_INTERFACE[@]#${PSEUDODESIGN_WIFI_INTERFACE}#' ${WORKDIR}/wireless.network

        install -d ${D}${sysconfdir}/systemd/network
        install -m 0755 ${WORKDIR}/wireless.network ${D}${sysconfdir}/systemd/network
    fi
  fi
}
