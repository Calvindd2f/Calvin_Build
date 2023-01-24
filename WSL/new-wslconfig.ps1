ni "$env:USERPROFILE/.wslconfig"
echo "memory=4GB" >  "$env:USERPROFILE/.wslconfig"
Restart-Service LxssManager
