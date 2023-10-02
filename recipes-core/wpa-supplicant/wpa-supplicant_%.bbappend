## Add a wifi network to wpa_supplicant

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " file://wpa_supplicant-pseudodesign.conf \
             file://wireless.network"

FILES_${PN} += "${sysconfdir}/wpa_supplicant/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf \
                ${sysconfdir}/systemd/network/wireless.network"

do_install:append() {

    sed -i -e 's#[@]PSEUDODESIGN_WIFI_PSK[@]#${PSEUDODESIGN_WIFI_PSK}#' ${WORKDIR}/wpa_supplicant-pseudodesign.conf
    sed -i -e 's#[@]PSEUDODESIGN_WIFI_SSID[@]#${PSEUDODESIGN_WIFI_SSID}#' ${WORKDIR}/wpa_supplicant-pseudodesign.conf
    sed -i -e 's#[@]PSEUDODESIGN_WIFI_INTERFACE[@]#${PSEUDODESIGN_WIFI_INTERFACE}#' ${WORKDIR}/wireless.network

    install -d ${D}${sysconfdir}/wpa_supplicant
    install -m 0755 ${WORKDIR}/wpa_supplicant-pseudodesign.conf ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -sf ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@${PSEUDODESIGN_WIFI_INTERFACE}.service

    install -d ${D}${sysconfdir}/systemd/network/
    install -m 0755 ${WORKDIR}/wireless.network ${D}${sysconfdir}/systemd/network/wireless.network
}