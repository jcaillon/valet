#n::
{
    SetKeyDelay 30, 25  ; 75ms between keys, 25ms between down/up.

    Sleep 1000
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