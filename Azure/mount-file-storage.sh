#!/bin/bash

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    help)
      usage
      shift
      shift
      ;;
    --resource-group-name)
      resourceGroupName="$2"
      shift # past argument
      shift # past value
      ;;
    --storage-account-name)
      storageAccountName="$2"
      shift # past argument
      shift # past value
      ;;
    --uid)
      LOCAL_UID="$2"
      shift # past argument
      shift # past value
      ;;
    --gid)
      LOCAL_GID="$2"
      shift # past argument
      shift # past value
      ;;
    --file-mode)
      FILEMODE="$2"
      shift # past argument
      shift # past value
      ;;
    --dir-mode)
      DIRMODE="$2"
      shift # past argument
      shift # past value
      ;;
    --file-share-name)
      fileShareName="$2"
      shift # past argument
      shift # past value
      ;;
  esac
done

function usage {
    echo "Usage: $0 --resource-group-name <resource group name> --storage-account-name <storage account name> --file-share-name <file share name> --uid <user id> --gid <group id> --file-mode <file permissions> --dir-mode <directory permissions>"
    exit 0
}

if [[ -z ${resourceGroupName} || -z ${storageAccountName} || -z ${LOCAL_UID} || -z ${LOCAL_GID} || -z ${FILEMODE} || -z ${DIRMODE} || -z ${fileShareName} ]]; then
    usage
fi

# The remainder of the script assumes you have logged in with az login
httpEndpoint=$(az storage account show \
    --resource-group $resourceGroupName \
    --name $storageAccountName \
    --query "primaryEndpoints.file" | tr -d '"')
echo "httpEndpoint=$httpEndpoint"

smbPath=$(echo $httpEndpoint | cut -c7-$(expr length $httpEndpoint))
echo "smbPath=$smbPath"

fileHost=$(echo $smbPath | tr -d "/")
echo "fileHost=$fileHost"

# Ensure port 445 is open
echo "Ensure port 445 is open"
nc -zvw3 $fileHost 445

# Mount the Azure file share on-demand with mount

mntPath="/mnt/$storageAccountName/$fileShareName"
echo "Mount the Azure file share on-demand with mount on $mntPath ..."

sudo mkdir -p $mntPath

smbPath=$(echo $httpEndpoint | cut -c7-$(expr length $httpEndpoint))$fileShareName
echo "smbPath=$smbPath"

storageAccountKey=$(az storage account keys list \
    --resource-group $resourceGroupName \
    --account-name $storageAccountName \
    --query "[0].value" | tr -d '"')
echo "storageAccountKey=$storageAccountKey"

MOUNT_OPTIONS="vers=3.0,username=$storageAccountName,password=$storageAccountKey,uid=${LOCAL_UID},gid=${LOCAL_GID},file_mode=${FILEMODE},dir_mode=${DIRMODE},serverino"
echo "MOUNT_OPTIONS=$MOUNT_OPTIONS"

sudo mount -t cifs $smbPath $mntPath -o $MOUNT_OPTIONS
