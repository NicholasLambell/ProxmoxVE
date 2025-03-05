#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/NicholasLambell/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/NicholasLambell/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/leiweibau/Pi.Alert/

APP="PiAlert"
var_tags="network"
var_cpu="1"
var_ram="512"
var_disk="3"
var_os="debian"
var_version="12"
var_unprivileged="1"

header_info "$APP"
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources
    if [[ ! -d /opt/pialert ]]; then
        msg_error "No ${APP} Installation Found!"
        exit
    fi
    bash -c "$(wget -qLO - https://github.com/leiweibau/Pi.Alert/raw/main/install/pialert_update.sh)" -s --lxc
    msg_ok "Updated $APP"
    exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}/pialert${CL}"