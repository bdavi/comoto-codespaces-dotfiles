##################################
# From Local Machine
##################################
gh cs list
gh cs delete
gh cs create -R Comoto-Tech/dev-hub
gh cs logs

# To get clipboard support in terminals run with extra SSH arguments
gh cs ssh -- -XY

# Port forward for DataGrip
gh cs ports forward 5432:5432


##################################
# From inside codespace
##################################
# Logs
tail -f /workspaces/.codespaces/.persistedshare/EnvironmentLog.txt
cat /workspaces/.codespaces/.persistedshare/EnvironmentLog.txt

tail -f /workspaces/.codespaces/.persistedshare/creation.log
cat /workspaces/.codespaces/.persistedshare/creation.log

# Run setup
/workspaces/.codespaces/.persistedshare/dotfiles/script/setup
source ~/.zprofile
