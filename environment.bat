set CMAKE_HOME=D:\QGIS_Dev\cmake-3.9.2-win64-x64
set GIT_HOME=C:\Program Files\Git
set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_79
set UNZIP_EXE="D:\Tools\unz600xn\unzip.exe"

set PATH=C:\Windows;C:\Windows\System32;C:\Windows\System32\Wbem;%JAVA_HOME%\bin;%CMAKE_HOME%\bin;%GIT_HOME%\bin

rem Visual Studio 2017 C++ build tools using Windows SDK 8.1
rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 8.1

rem Visual Studio 2017 C++ build tools using Windows SDK 10.0.14393.0
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 10.0.14393.0

set ROCKSDB_DIR=D:\Work\test\rocksdb
set ROCKSDB_VERSION=v5.7.2
set THIRDPARTY_PACKAGES_DIR=D:\QGIS_Dev\packages
set THIRDPARTY_HOME=%ROCKSDBDIR%\third-party

set GFLAGS_VERSION=2.2.1
set SNAPPY_VERSION=1.1.7
set LZ4_VERSION=1.8.0
set ZLIB_VERSION=1.2.11