#n::
{
    SetKeyDelay 30, 25  ; 75ms between keys, 25ms between down/up.

    Sleep 1000
    SendEvent "valet test-log"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet --verbose test-log"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendText 'export VALET_CONFIG_LOG_PATTERN="<colorFaded><time>{(%H:%M:%S)T} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{5s}:<subshell>{1s}] <levelColor><level><colorDefault> <colorFaded><function>{15s}<colorDefault> -- <message>"'
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet test-log"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "VALET_CONFIG_LOG_COLUMNS=100 VALET_CONFIG_ENABLE_COLORS=false valet test-log"
    Sleep 1000
    Send "{Enter}"
}