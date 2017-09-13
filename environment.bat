set CMAKE_HOME=C:\Tools\CMake
set GIT_HOME=C:\Tools\Git
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_144
set UNZIP_EXE="C:\Tools\Unzip\unzip.exe"

set PATH=C:\Windows;C:\Windows\System32;C:\Windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0
set PATH=%PATH%;%JAVA_HOME%\bin;%CMAKE_HOME%\bin;%GIT_HOME%\bin

rem Visual Studio 2017 C++ build tools
rem set WINSDK_VERSION=10.0.15063.0
set WINSDK_VERSION=8.1
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 %WINSDK_VERSION%

set ROCKSDB_DIR=D:\Work\rocksdb
set ROCKSDB_VERSION=v5.7.2
set THIRDPARTY_PACKAGES_DIR=D:\work\packages
set THIRDPARTY_HOME=%ROCKSDB_DIR%\third-party

set GFLAGS_VERSION=2.2.1
set SNAPPY_VERSION=1.1.7
set LZ4_VERSION=1.8.0
set ZLIB_VERSION=1.2.11
set JEMALLOC_VERSION=4.3.1

rem set PLATFORM_TOOLSET=v141
set PLATFORM_TOOLSET=v140
set CMAKE_GENERATOR_PLATFORM="Visual Studio 15 2017 Win64"
set CMAKE_SYSTEM_VERSION=%WINSDK_VERSION%