#n::
{
    SendText 'unset VALET_CONFIG_LOG_PATTERN'
    Send "{Enter}"
    Sleep 2000

    SetKeyDelay 100, 25  ; 75ms between keys, 25ms between down/up.
    SendEvent "valet"

    Sleep 1000
    Send "{Enter}"

    Sleep 1000
    SendEvent "exte"

    Sleep 1000
    Send "{PgDn}"
    Sleep 200
    Send "{Right}"
    Sleep 200
    Send "{Right}"
    Sleep 200
    Send "{Right}"

    Sleep 1000
    SendEvent "{BS}{BS}{BS}help"

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


    SetKeyDelay 40, 25  ; 75ms between keys, 25ms between down/up.

    Sleep 2000
    SendEvent "VALET_CONFIG_LOG_COLUMNS=100 VALET_CONFIG_ENABLE_COLORS=false valet test-log"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet showcase command1"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet showcase command1 positional-argument-1 arg2"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent 'valet showcase command1 --option1 "first option" -2 second positional-argument-1 more1 more2'
    Sleep 1000
    Send "{Enter}"
}