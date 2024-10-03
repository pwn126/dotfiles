#!/bin/zsh
# shellcheck shell=bash

yocto-builder() {
    local -r builder="${1}" # apps or helix

    if [[ "${builder}" != "helix" && "${builder}" != "apps" ]]; then
        echo "Invalid builder!"
        return 1
    fi

    shift

    local operation="exec"
    local proxy=false

    while getopts "aep" opt; do
        case "${opt}" in
            a)
                operation="attach"
                ;;
            e)
                operation="exec"
                ;;
            p)
                proxy=true
                ;;
            *)
                echo "Invalid option: ${opt}"
                return 1
                ;;
        esac
    done

    local -r apps_dir="${HOME}/src/apps"
    local -r images_dir="${HOME}/src/images"
    local -r git_config="/etc/gitconfig"
    local -r git_credentials="${HOME}/.git-credentials"
    local -r netrc="${HOME}/.netrc"
    local -r ssh_config="${HOME}/.ssh/config"
    local -r docker_dns="172.17.0.1"

    local image=""
    local label=""
    local container_name=""
    local container_user=""
    local container_user_home=""
    local -r workdir_base="/workdir"
    local workdir="${workdir_base}"

    if [[ "${builder}" == "helix" ]]; then
        image="jfrog.asux.aptiv.com/sva_mi-aptiv-10034593-docker-local/ubuntu_machine"
        image_label="20.04.13"
        container_name="helix-builder"
        container_user="sid_sva_mi"
        container_user_home="/home/sid_sva_mi"
        workdir+="/images/wrlinux/22.09"
    else
        image="jfrog.asux.aptiv.com/vw_bna_poc-volkswagen-10034131-docker-local/yocto-builder-agent"
        if [[ "${builder}" == "apps" ]]; then
            # image_label="20.10.7_kas" # apps
            image_label="22.04.44"
        else
            image_label="22.04.44"
        fi
        container_name="yocto-builder"
        container_user="jenkins"
        container_user_home="/home/jenkins"
        # workdir+="/apps/yocto"
        workdir+="/images/wrlinux/22.09_apps"
    fi

    local -a docker_parameters=()

    if [[ "${proxy}" == true ]]; then
        docker_parameters+=( "--env HTTP_PROXY='socks5://172.17.0.1:666'" )
        docker_parameters+=( "--env HTTPS_PROXY='socks5://172.17.0.1:666'" )
    fi

    if [[ "${operation}" == "attach" ]]; then
        eval "docker exec -t -i ${docker_parameters[*]} \"${container_name}\" /bin/bash"
        return
    fi

    docker_parameters+=( "--tty" )
    docker_parameters+=( "--interactive" )
    docker_parameters+=( "--rm" )
    docker_parameters+=( "--hostname ${container_name}" )
    docker_parameters+=( "--name ${container_name}" )
    docker_parameters+=( "--user ${container_user}" )
    docker_parameters+=( "--workdir ${workdir}" )
    docker_parameters+=( "--mount type=bind,src=\"${apps_dir}\",dst=${workdir_base}/apps" )
    docker_parameters+=( "--mount type=bind,src=\"${images_dir}\",dst=${workdir_base}/images" )
    docker_parameters+=( "--mount type=bind,src=\"${git_config}\",dst=/etc/gitconfig,ro=true" )
    docker_parameters+=( "--mount type=bind,src=\"${git_credentials}\",dst=${container_user_home}/.git-credentials,ro=true" )
    docker_parameters+=( "--mount type=bind,src=\"${netrc}\",dst=${container_user_home}/.netrc,ro=true" )
    docker_parameters+=( "--mount type=bind,src=\"${ssh_config}\",dst=/etc/ssh/ssh_config,ro=true" )
    docker_parameters+=( "--env KAS_NETRC_FILE=${workdir_base}/.netrc" )
    docker_parameters+=( "--env GIT_CREDENTIAL_HELPER=\"store --file=${container_user_home}/.git-credentials\"" )
    # docker_parameters+=( "--dns ${docker_dns}" )
    docker_parameters+=( "--dns 10.142.65.12" )


    local ca_bundle=""
    ca_bundle="$(readlink -f "$(curl-config --ca)")"
    local -r ca_bundle_dst="/etc/ssl/certs/ca-certificates.crt"

    # XXX
    # if [[ -e "${ca_bundle}" ]]; then
    if [[ false ]]; then
        docker_parameters+=( "--mount type=bind,src=\"${ca_bundle}\",dst=\"${ca_bundle_dst}\",ro=true" )
        # docker_parameters+=( "--env GIT_SSL_CAINFO=\"${ca_bundle_dst}\"" )
        docker_parameters+=( "--env GIT_SSL_CAINFO=\"/etc/ssl/certs/ca-certificates.crt\"" )
    else
        docker_parameters+=( "--env GIT_SSL_NO_VERIFY=1" )
    fi

    docker_parameters+=( "${image}:${image_label}" )

    echo "docker run \\"
    for parameter in "${docker_parameters[@]}"; do
        echo "${parameter} \\"
    done
    echo

    eval "docker run ${docker_parameters[*]} /bin/bash"
}
