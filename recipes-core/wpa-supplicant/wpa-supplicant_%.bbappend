## Add a wifi network to wpa_supplicant

SRC_URI += " file://wpa_supplicant.conf"

FILES_${PN} += "${sysconfdir}/wpa_supplicant/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf"

do_install_append() {
	
    if [ -n "$PSEUDODESIGN_WIFI_SSID" ] && [ -n "$PSEUDODESIGN_WIFI_PSK" ] && [ -n "$PSEUDODESIGN_WIFI_INTERFACE" ] 
    then
        sed -i -e 's#[@]PSEUDODESIGN_WIFI_PSK[@]#${PSEUDODESIGN_WIFI_PSK}#' ${WORKDIR}/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf
        sed -i -e 's#[@]PSEUDODESIGN_WIFI_SSID[@]#${PSEUDODESIGN_WIFI_SSID}#' ${WORKDIR}/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf

        install -d ${D}${sysconfdir}/wpa_supplicant
        install -m 0755 ${WORKDIR}/wpa_supplicant-${PSEUDODESIGN_WIFI_INTERFACE}.conf ${D}${sysconfdir}/wpa_supplicant

        install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
        ln -sf ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@${PSEUDODESIGN_WIFI_INTERFACE}.service
    fi
}