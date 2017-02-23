# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
rp_module_id="golang"
rp_module_desc="Golang binary install"
rp_module_section="opt"

function _get_goroot_golang() {
    echo "$rootdir/supplementary/golang/go"
}

function install_bin_golang() {
    local version=""
    local goroot="$(_get_goroot_golang)"
    if [[ -e "${md_inst}/go/bin/go" ]]; then
        local version=$(GOROOT=$goroot $goroot/bin/go version | sed -e 's/.*\(go1[^ ]*\).*/\1/')
    fi
    printMsgs "console" "Current Go version: $version"
    if [[ ! "${version}" < "go1.8" ]]; then
        return 0
    fi
    if [[ -d "${goroot}" ]]; then
        rm -rf "$goroot"
    fi
    local arch="armv6l"
    if isPlatform "x86"; then
        if isPlatform "64bit"; then
            arch="amd64"
        else
            arch="386"
        fi
    fi
    printMsgs "console" "Downloading go1.8.linux-$arch.tar.gz"
    wget -O- "https://storage.googleapis.com/golang/go1.8.linux-$arch.tar.gz" | tar -xz -C "$md_inst"
}
