# Replace sshd_config with the local copy and install project's public keys
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://pseudo-design/sshd_config \
            file://pseudo-design/authorized_keys "

USER = "root"

do_install:append() {
	install -m 0644 ${WORKDIR}/pseudo-design/sshd_config ${D}${sysconfdir}/ssh/
    install -d ${D}/home/${USER}/.ssh/
    install -m 0755 ${WORKDIR}/pseudo-design/authorized_keys ${D}/home/${USER}/.ssh
}

FILES_${PN}-ssh += "/home/${USER}/.ssh/authorized_keys"