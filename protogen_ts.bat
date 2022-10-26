@echo off
echo -------------------------------------------------------
echo TYPESCRIPT SUB-DIRECTORY PROTOBUF COMPILER (Windows OS)
echo -------------------------------------------------------
echo This script relies on the command `protoc` which must be set in your system path variables.
echo `protoc` releases: https://github.com/protocolbuffers/protobuf/releases
echo This script will fail if npm module `ts-proto` is not installed in the working directory. This is the plugin which `protoc` uses to compile the typescript output.
echo To install `ts-proto`, run `npm i ts-proto --save-dev` while in the working directory containing `package.json`
echo:
echo:

set /p "rootDir=Enter Protobuf Root Directory (relative path): "
mkdir proto_ts

for /f %%G in ('dir /a /s /b "./%rootDir%" ^| findstr \.proto') do (
  set str=%%G
  call set str=%%str:%CD%=.\%%
  call echo %%str%%
  call protoc -I ./%rootDir% --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts_proto --ts_proto_opt=esModuleInterop=true --ts_proto_out=./proto_ts %%str%%
)