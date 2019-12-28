## Replace default vimrc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " file://vimrc"

FILES_${PN} += "${sysconfdir}/vim/vimrc"

do_install_append() {

    install -d ${D}${sysconfdir}/vim
    install -m 0755 ${WORKDIR}/vimrc ${D}${sysconfdir}/vim/vimrc

}