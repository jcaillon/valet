#n::
{
    SetKeyDelay 75, 25  ; 75ms between keys, 25ms between down/up.

    Sleep 1000
    SendEvent "valet showcase command1 --help"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet help showcase command1 | less"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    Send "{PgDn}"
    Sleep 1000
    Send "{PgDn}"
    Sleep 1000
    Send "q"
}