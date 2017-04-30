___COMMAND_NAME__()
{
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"

    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$(__COMMAND_NAME__ commands)" -- "$word") )
    else
        local words=("${COMP_WORDS[@]}")

        case x${words[1]} in
            xe|xls|xrm|xcopy|xlink)
                unset words[0]
                unset words[$COMP_CWORD]
                local completions=$(__COMMAND_NAME__ keys "${words[@]}")
                COMPREPLY=( $(compgen -W "$completions" -- "$word") )
            ;;
            xcp|xln)
                unset words[0]
                unset words[$COMP_CWORD]
                local completions=$(__COMMAND_NAME__ x "${words[@]}")
                COMPREPLY=( $(compgen -W "$completions" -- "$word") )
            ;;
            xadd)
                unset words[0]
                unset words[$COMP_CWORD]
                local completions=$( find . -maxdepth 1 -type f -printf "%P\n" )
                COMPREPLY=( $(compgen -W "$completions" -- "$word") )
            ;;
        esac

    fi
}
complete -F ___COMMAND_NAME__ __COMMAND_NAME__
