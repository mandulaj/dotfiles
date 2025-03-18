SSH config
==========

In order to make logging into remote servers easier, its a good idea to define custom hosts in the `~/.ssh/config` file:

```ssh_config
Host server_name
    HostName server.example.com
    User username
    ForwardAgent yes
    ForwardX11 yes
    ForwardX11Trusted yes
    #.....
```

## Tmux

If you want to start a remote Tmux session automatically include this for the given hosts:

```ssh_config
Host tmux_host
    # ....
    Include ~/.ssh/config.d/tmux_config
```

In order to include it for several matching hosts, one can do this:

```ssh_config
Match Host host1,host2*,host3 exec "[[ $(ps h o args p $PPID | grep -Ev 'rsync|-t|-T|-C' | wc -w) -gt 1 ]]"
    Include ~/.ssh/config.d/tmux_config
```

This also avoids issues when uring rsync or other commands.



