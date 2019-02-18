FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://pseudodesign/issue "

do_install_append () {
    install -m 644 ${WORKDIR}/pseudodesign/issue  ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/pseudodesign/issue  ${D}${sysconfdir}/issue.net
    if [ -n "${DISTRO_NAME}" ]; then
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue.net
        if [ -n "${DISTRO_VERSION}" ]; then
            echo -n "${DISTRO_VERSION} " >> ${D}${sysconfdir}/issue
            echo -e "${DISTRO_VERSION} \n" >> ${D}${sysconfdir}/issue.net
        fi
        echo "- Kernel \r" >> ${D}${sysconfdir}/issue
        echo >> ${D}${sysconfdir}/issue
    fi
    echo "Version: ${BSP_VERSION} Build: ${BSP_BUILD_NUMBER}" >> ${D}${sysconfdir}/issue
    echo "Version: ${BSP_VERSION} Build: ${BSP_BUILD_NUMBER}" >> ${D}${sysconfdir}/issue.net

}
