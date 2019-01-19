#!/bin/bash
#
# command:
# sh release.sh <app-name> <tag-name>
#
# release differnet platform execution file
# 處理步驟:

# git tag release:
#   add tag : commit/push all/add new tag name
#            - git tag -a <tag-name> -m "message"
#   check out tag: git checkout <tag-name>
#   sync remote repository: git push origin <tag_name>

#  build local tag release via git shell:
#  build host-os-app procedure:
#   - build host-os-app
#       - commit/push sync 
#       - local build tag release: sh ./release.sh <app-name> <tag-name>
#       - add git tag        
#       - git tag/push 
#
#  release download & execution
#   - download release files github release
#   - execution
#     - host-os-app:
#          - windows: rename to <file-name>.exe
#          - linux: rename <file-name>; chmod +x <rename file name>
#          - darwin: ????
#   正式版本: 必須另外附加 .git ,不可放在 release 目錄下,否則 .git 會起作用
#   
 app="$1"
 tag="$2"
 
 window_build="./release/$app/$tag/${app}_windows_amd64" 
 linux_build="./release/$app/$tag/${app}_linux_amd64"  
 darwin_build="./release/$app/$tag/${app}_darwin_amd64"  
 
 # os-host-app release , Inject build-time variables 
export GIT_COMMIT=$(git rev-list -1 HEAD)  &&  GOOS=windows GOARCH=amd64 go build -ldflags "-X main.GitCommit=$GIT_COMMIT"  -o $window_build

export GIT_COMMIT=$(git rev-list -1 HEAD)  &&  GOOS=linux GOARCH=amd64 go build -ldflags "-X main.GitCommit=$GIT_COMMIT" -o $linux_build 

export GIT_COMMIT=$(git rev-list -1 HEAD)  &&  GOOS=darwin GOARCH=amd64 go build -ldflags "-X main.GitCommit=$GIT_COMMIT" -o $darwin_build



#  tar -zxvf <tar-file> 
#  after change directory , then extract
#  tar -zxvf <tar-file> -C "D:\Apps" 
# cp <app-name>_windows_amd64 <app-name>.exe
