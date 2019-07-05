# Clean up dangling images
`docker rmi $(docker images -f "dangling=true" -q)`
