logLine "Configuring .ssh keys"

info "removing: $home/.ssh\c"
runCmd rm -rf "$home/.ssh"
link "$dev/ssh" "$home/.ssh"

info "deleting all the ssh agent keys\c"
runCmd ssh-add -D

info "ensuring the keys have proper permissions\c"
runCmd chmod -R 700 "$home/.ssh"

info "adding your key to the os x key chain\c"
runCmd ssh-add -K "$home/.ssh/id_rsa_minancio"