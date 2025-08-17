#n::
{
    SetKeyDelay 100, 25  ; 75ms between keys, 25ms between down/up.
    SendEvent "valet"

    Sleep 1000
    Send "{Enter}"

    Sleep 1000
    SendEvent "gen"

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
}