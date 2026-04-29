# git
alias gs="git status" # then run "gs" as `ghostscript`
alias gp="git pull"
alias gl="git log --oneline"
alias gb="git branch"
alias gd="git diff"
alias gout="git checkout"
alias gadd="git add"
alias gcomm="git commit -m"

# tmux
alias t="tmux kill-session -t temp 2>/dev/null; tmux new -A -s temp" # Create a temp workspace (ephemereal)
alias tm="tmux new -A -s main" # Attach to main workspace (persistent)
alias tmk='tmux kill-session -t main && echo "tmux: main killed (cleaned)"' # Kill (clean) the main workspace
alias tr='tmux source-file ~/.tmux.conf' # Reload config fast
alias tn="tmux rename-window" # Name the current tmux window/tab

# programs
# alias python3="python3.12"
alias py="python3"
alias pip="python3 -m pip"
alias pip3="python3 -m pip"
alias pycfg="sudo update-alternatives --config python3"
alias pyvenv="python3 -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"
alias nv="nvim"
alias pfetch='/home/alex/.pfetch/pfetch'
alias starcraft='cd ~/.wine/drive_c/Program\ Files/Starcraft/ && wine StarCraft.exe'

# run github actions locally (for testing CI)
alias ghact="act -l && act -n && act"

# docker
alias dpsa='docker ps -a'
alias dockers='docker ps && docker ps -a && docker images'
alias docker-compose='docker compose'

# util
alias ls="ls --color -h --group-directories-first"
alias rel="source ~/.profile"
# alias plasmash="killall plasmashell && kstart plasmashell"
# alias ress="xrandr --output eDP-1 --mode 1600x900" # -> .local/bin
# alias resl="xrandr --output eDP-1 --mode 1920x1080" # -> .local/bin
alias ldev="ll /dev/ | grep 'ACM\|USB\|stlink'"
#alias lmk="kdialog  --icon data-information --title 'FYI' 5 --passivepopup"
alias lmk='notify-send -u normal --icon data-information "FYI"'
alias cpy="xclip -selection clipboard"
alias aw="nvim ~/.config/awesome/rc.lua"

alias hostweb="npx http-server ."

# set terminal/tab title
function stt() {
    echo -ne "\033]30;${@}\007"
}

wapp() {
  google-chrome --app="$1"
}


# other/work
alias p2p='cd ~/Projects/cruschc/p2p/ && activate'
alias print="kinit j22ferna"
export OPENSCHC_DIR=/home/alex/Projects/openschc
alias reocd="sudo apt remove openocd -y && sudo dpkg -i /home/alex/Downloads/openocd_0.10.0-6build1_amd64.deb && openocd --version"
alias stm32prog_cli="/home/alex/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI"
alias sshschc="ssh alex-fddz@tests.openschc.net"
alias sshplido="ssh alex-fddz@user.plido.net"
alias sshoutils="ssh alex-fddz@outils.plido.net"
alias sshcours="ssh -i ~/.ssh/id_rsa_um alex-fddz@54.37.155.27"
alias sshemonpi="ssh pi@2001:660:7301:51:605d:f5da:a60d:bb52" # emonpi2016
alias sshchstackgway="sudo ifconfig enx98e743e455de 192.108.119.223/25 && ssh -o KexAlgorithms=+diffie-hellman-group14-sha1 -o HostkeyAlgorithms=+ssh-rsa root@192.108.119.149" # eu1ZoquaiePa8aeb
alias mpr0='mpremote connect /dev/ttyACM0'
alias mpr1='mpremote connect /dev/ttyACM1'

# fullsdk/openocd build and flash
export P_OCD_PLATFORM=STM32L476RG-Nucleo 
# platforms/.: STM32L476RG-Nucleo B-L072Z-LRWAN1

#export DEUI=0080e11511103603 # L476RG m4
#export DEUI=0080e11503800773 # B-L072Z-LRWAN1 m0plus
# export DEUI=fefffffffdff0000 # prebuilt atmodem 

# export P_OCD_STACK=semtech_4.4.7 # platforms/<platform>/.

#export P_OCD_TARGET=m4            # full-sdk/toolchains/<toolchain>/.
#export P_OCD_TARGET_CFG=stm32l4x.cfg   # openocd/.
#export NUCLEO_LORA_SHIELD=SX1261  # shield env var
        #-DPLATFORM_RADIO_SHIELD=SX1261 -DNUCLEO_LORA_SHIELD=${NUCLEO_LORA_SHIELD} \
#-DSYNC_ENABLED=1 \ -DMBED_RADIO_SHIELD="SX1261MBXBAS" 


function ocdbuild () {
    if [[ ${P_OCD_PLATFORM} == "B-L072Z-LRWAN1" ]]; then
        export P_OCD_TARGET=m0plus
        export P_OCD_TARGET_CFG=stm32l0.cfg
        export DEUI=0080e11503800773 
        export P_OCD_STACK=semtech_4.4.7 # platforms/<platform>/.
    else
        export P_OCD_TARGET=m4
        export P_OCD_TARGET_CFG=stm32l4x.cfg
        export DEUI=0080e11511103603 
        export P_OCD_STACK=semtech # platforms/<platform>/.
    fi
    export DEBUG_ENABLED=1

    echo "Building full-sdk sample $1: on $P_OCD_PLATFORM + $P_OCD_STACK ($P_OCD_TARGET / $P_OCD_TARGET_CFG):"
    cmake -S . -B ./build/ -DAPP_NAME=$1 -DAPP_VERSION=4.0.0 -DFULLSDK_VERSION=3.0.0 \
        -DPLATFORM=${P_OCD_PLATFORM} -DL2_STACK=${P_OCD_STACK} -DTOOLCHAIN=gcc-arm-none \
        -DTARGET=${P_OCD_TARGET} -DDEBUG_ENABLED=1 -DPLATFORM_TRACE_ENABLED=0 \
        -DLORAWAN_DEVEUI=${DEUI} -DLORAWAN_APPEUI=0000000000000000 \
        -DLORAWAN_APPKEY=11111111111111111111111111111111 -DNUCLEO_LORA_SHIELD=SX1272 \
        -DEXTENSION_API=template -DTEMPLATE_ID=dynamic -DCORE=IPCORE -DSYNC_ENABLED=0 && make -C ./build;
        #-DNUCLEO_LORA_SHIELD=SX1261 -DBOARD=NucleoL476 -DPLATFORM_RADIO_SHIELD=SX1261MB2BAS  -DMBED_RADIO_SHIELD="SX1261MBXBAS" 
}

function ocdflash () {
    if [[ ${P_OCD_PLATFORM} == "B-L072Z-LRWAN1" ]]; then
        export P_OCD_TARGET=m0plus
        export P_OCD_TARGET_CFG=stm32l0.cfg
    else
        export P_OCD_TARGET=m4
        export P_OCD_TARGET_CFG=stm32l4x.cfg
    fi
    echo "Erasing device & flashing full-sdk sample $1 for ${P_OCD_TARGET}:"
    OPENOCD_TARGET=${P_OCD_TARGET_CFG} make -C openocd/ erase
    OPENOCD_TARGET=${P_OCD_TARGET_CFG} BIN_FILE=build/gcc-arm-none/${P_OCD_TARGET}/$1.bin make -C openocd/ flash;
}

# build full-sdk for tests
alias fsdktest='cmake -S . -B ./build/ -DTOOLCHAIN=gcc-native -DTARGET=default -DEXTENSION_API=template -DTEMPLATE_ID=ipv6udp -DRUN_UNIT_TESTS=1 && make -C ./build && ctest --test-dir build'


export FSDK_APP=Demo
alias b='rel && ocdbuild ${FSDK_APP}'
alias rb='rm -rf ./build && rel && ocdbuild ${FSDK_APP}'
alias bf='ocdbuild ${FSDK_APP} && rel && ocdflash ${FSDK_APP}'
alias rbf='rm -rf ./build && rel && ocdbuild ${FSDK_APP} && ocdflash ${FSDK_APP}'
alias f='rel && ocdflash ${FSDK_APP}'

# function instamost() {
#     curl -X PUT https://nodered.lenuage.io/pictures/ -d '{"url":$1, "description":$2}' -H 'Content-Type: application/json'
# }

# ipcore setup
function ipcore1 () {
    echo "Run VPN / tunneling agent (creat tun iface)..."
    cd ~/Downloads/vpn2/
    sudo ./ipcore-nw-binding-agent-x86 --agent-server-addr=nba.ipcore.acklio.cloud:9995;
}

function ipcore2 () {
    echo "Create APP IPv6 addr on tun-agent interface..."
    sudo ip -6 address add abcd::1 dev tun-agent;
}

function ipcore3 () {
    echo "Run cloud application on tun-agent/abcd::1 :22222..."
    cd ~/Projects/lab-schc-gitlab/examples/at-modem/udp-client
    sudo python3.10 -m cloud -ip abcd::1 -port 22222;
}

alias cdatmodem="cd ~/Projects/lab-schc-gitlab/examples/at-modem/udp-client/"

function ipcore4 () {
    echo "Run device ATModem controller..."
    cd ~/Projects/lab-schc-gitlab/examples/at-modem/udp-client
    python3.10 -m device --template device/myrules/compression_rules.bin --dev-eui 0080e11511103603 --app-eui 0000000000000000 --app-key 11111111111111111111111111111111 --ipv6-dev-prefix 2001:7301:0001:007b
}

# balloon
export RIOTBASE=/home/alex/Projects/balloon/RIOT
export BALLOON_DEUI=33323431007f1234

