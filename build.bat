@setlocal
call %~dp0environment.bat

if exist "%THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%" rd /s/q "%THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%"
if exist "%THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%" rd /s/q "%THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%"
if exist "%THIRDPARTY_HOME%\lz4-%LZ4_VERSION%" rd /s/q "%THIRDPARTY_HOME%\lz4-%LZ4_VERSION%"
if exist "%THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%" rd /s/q "%THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%"

%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\gflags-%GFLAGS_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\snappy-%SNAPPY_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\lz4-%LZ4_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\zlib-%ZLIB_VERSION%.zip -d %THIRDPARTY_HOME%

pushd %ROCKSDB_DIR%
git clean -xdf
git checkout .
git fetch
git checkout tags/%ROCKSDB_VERSION%

xcopy /e/s/v/y %~dp0mods_%ROCKSDB_VERSION% %ROCKSDB_DIR%

pushd %THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%
cmake -G "Visual Studio 14 Win64" -T v140
msbuild gflags.sln /property:PlatformToolset=v140 /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%
cmake -G "Visual Studio 14 Win64" -T v140
msbuild snappy.sln /property:PlatformToolset=v140 /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\lz4-%LZ4_VERSION%\visual\VS2010
devenv lz4.sln /upgrade
msbuild lz4.sln /property:PlatformToolset=v140 /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%
cmake -G "Visual Studio 14 Win64" -T v140
msbuild zlib.sln /property:PlatformToolset=v140 /p:Configuration=Release /p:Platform=x64
popd

rem cmake -G "Visual Studio 14 Win64" -DJNI=1 -DGFLAGS=1 -DSNAPPY=1 -DLZ4=1 -DZLIB=1 -DXPRESS=1 -DCMAKE_SYSTEM_VERSION=6.1 -T v140
cmake -G "Visual Studio 14 Win64" -DJNI=1 -DGFLAGS=1 -DSNAPPY=1 -DLZ4=1 -DZLIB=1 -DXPRESS=1 -T v140
msbuild rocksdb.sln /property:PlatformToolset=v140 /p:Configuration=Release /p:Platform=x64

popd