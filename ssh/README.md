SSH config
==========

In order to make logging into remote servers easier, its a good idea to define custom hosts in the `~/.ssh/hosts/*` file:

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
    Tag tmux # addds automatic Tmux Remote command (for interactive SSH)
```




