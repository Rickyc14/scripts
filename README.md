# scripts




```bash
#!/usr/bin/env bash

set -o nounset -o errexit -o noclobber -o pipefail


# -o option-name
#
#    Set the option corresponding to option-name:

# nounset
#
#     Same as -u.

# errexit
#
#     Same as -e.

# noclobber
#
#     Same as -C.

# pipefail
#
#     If set, the return value of a pipeline is the value of the
#     last (rightmost) command to exit with a non-zero status, or
#     zero if all commands in the pipeline exit successfully. This
#     option is disabled by default.

# -u
#
#     Treat unset variables and parameters other than the special
#     parameters ‘@’ or ‘*’, or array variables subscripted with
#     ‘@’ or ‘*’, as an error when performing parameter expansion.
#     An error message will be written to the standard error, and
#     a non-interactive shell will exit.

# -e
#
#     Exit immediately if a pipeline (see Pipelines), which may consist of a single simple
#     command (see Simple Commands), a list (see Lists of Commands), or a compound command
#     (see Compound Commands) returns a non-zero status. The shell does not exit if the
#     command that fails is part of the command list immediately following a while or until
#     keyword, part of the test in an if statement, part of any command executed in a && or
#     || list except the command following the final && or ||, any command in a pipeline
#     but the last, or if the command’s return status is being inverted with !. If a
#     compound command other than a subshell returns a non-zero status because a command
#     failed while -e was being ignored, the shell does not exit. A trap on ERR, if set,
#     is executed before the shell exits.
#
#     This option applies to the shell environment and each subshell environment separately
#     (see Command Execution Environment), and may cause subshells to exit before executing
#     all the commands in the subshell.
#
#     If a compound command or shell function executes in a context where -e is being
#     ignored, none of the commands executed within the compound command or function body
#     will be affected by the -e setting, even if -e is set and a command returns a failure
#     status. If a compound command or shell function sets -e while executing in a context
#     where -e is ignored, that setting will not have any effect until the compound command
#     or the command containing the function call completes.

# -C
#
#     Prevent output redirection using ‘>’, ‘>&’, and ‘<>’ from overwriting existing files.
```


## References

- [The Set Builtin](https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin)
- [Bash Conditional Expressions](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)
- [Process Substitution](https://mywiki.wooledge.org/ProcessSubstitution)
- [Bash Pitfalls](https://mywiki.wooledge.org/BashPitfalls)
- [Bash Reference Sheet](https://mywiki.wooledge.org/BashSheet)
- [Bash Guide](https://mywiki.wooledge.org/BashGuide)
