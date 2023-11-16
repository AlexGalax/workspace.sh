## workspace.sh

A little helper to organize and simplify development and tmux sessions.

Copy this repo into your dev directory:
```bash
git clone git@github.com:AlexGalax/workspace.sh.git /home/user/dev
```

Add an alias for your shell:
```bash
alias ws='/home/user/dev/workspace.sh' 
```

Every project should be in a separate directory. You can copy `null/`, wich includes example files, for a new project:

```bash
cp null/. ./new-project 
```

The tmux session name will be the same name as the project directory name ("new-project" in this example). Set up an initial tmux session configuration in `new-project/tmux.conf`:
```bash
rename-window src
send "cd /home/user/dev/new-project/src" C-m
new-window -n stage
send "ssh user@host -i ~/.ssh/aws.pem" C-m
new-window -n docker
send "docker exec -it container bash" C-m
select-window -t 0
```

### Start workspace
```bash
ws start new-project
```
This will execute `new-project/start.sh`, attach the tmux session _new-project_ and, if it's a new session, load its configuration `new-project/tmux.conf`. If you want to force to load the initial configuration on an existing session, run the command with the kill-flag. This will kill the session first:

```bash
ws start new-project -k
```

### End workspace:
```bash
ws end
```
This will execute `new-project/end.sh` and detach the tmux session _new-project_. If you want to kill the session, provide the kill-flag:

```bash
ws end -k
```

If you want to end a different session, provide the name:

```bash
ws end another-project [-k]
```

### Execute any command script

As seen in starting & ending workspace, any command will execute a script: `project-dir/<command>.sh`.
This way you can shortcut a sequence of commands, regardless your current location. E.g. check and edit the example `new-project/commit.sh`:
```bash
cd "${BASH_SOURCE%/*}/src"
git add .
echo -n "Commit description: "
read description
git commit -am "${description}"
git push origin master
```

To execute the script, in your tmux session just type:
```bash
ws commit
```

Easy :)

### Adapt
Every developer and her/his projects have different requirements. This is more of a start template to get the most out of your personal workflow.

###  Cheers

<a href="https://www.buymeacoffee.com/alexgalax" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>