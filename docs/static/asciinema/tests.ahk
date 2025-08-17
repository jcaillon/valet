#n::
{
    SetKeyDelay 30, 25  ; 75ms between keys, 25ms between down/up.

    Sleep 1000
    SendEvent "valet self test"
    Sleep 1000
    Send "{Enter}"

    Sleep 5000
    SendEvent "vi /home/julien/.valet.d/showcase/commands.d/showcase.sh"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    Send "{PgDn}"
    Sleep 800
    Send "{PgDn}"
    Sleep 800
    Send "{Down}"
    Sleep 800
    Send "^{Right}"
    Sleep 800
    Send "^{Right}"
    Sleep 800
    Send "^{Right}"
    Sleep 800
    Send "i"

    Sleep 1000
    SendEvent "super "

    Sleep 2000
    Send "{Escape}"
    Sleep 800
    SendEvent ":wq"
    Sleep 1000
    Send "{Enter}"

    Sleep 2000
    SendEvent "valet self test"
    Sleep 1000
    Send "{Enter}"
}