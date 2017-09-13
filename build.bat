@setlocal
call %~dp0environment.bat
pushd %ROCKSDB_DIR%

if exist "%THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%" rd /s/q "%THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%"
if exist "%THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%" rd /s/q "%THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%"
if exist "%THIRDPARTY_HOME%\lz4-%LZ4_VERSION%" rd /s/q "%THIRDPARTY_HOME%\lz4-%LZ4_VERSION%"
if exist "%THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%" rd /s/q "%THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%"
if exist "%THIRDPARTY_HOME%\jemalloc-cmake-jemalloc-cmake.%JEMALLOC_VERSION%"  rd /s/q "%THIRDPARTY_HOME%\jemalloc-cmake-jemalloc-cmake.%JEMALLOC_VERSION%"

git clean -xdf
git checkout .
git fetch
git checkout tags/%ROCKSDB_VERSION%

%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\gflags-%GFLAGS_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\snappy-%SNAPPY_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\lz4-%LZ4_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o %THIRDPARTY_PACKAGES_DIR%\zlib-%ZLIB_VERSION%.zip -d %THIRDPARTY_HOME%
%UNZIP_EXE% -o "%THIRDPARTY_PACKAGES_DIR%\jemalloc-cmake-jemalloc-cmake.%JEMALLOC_VERSION%.zip" -d %THIRDPARTY_HOME%

xcopy /e/s/v/y %~dp0mods_%ROCKSDB_VERSION% %ROCKSDB_DIR%

pushd %THIRDPARTY_HOME%\gflags-%GFLAGS_VERSION%
cmake -G %CMAKE_GENERATOR_PLATFORM% -T %PLATFORM_TOOLSET% -DCMAKE_SYSTEM_VERSION=%CMAKE_SYSTEM_VERSION%
msbuild gflags.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\snappy-%SNAPPY_VERSION%
cmake -G %CMAKE_GENERATOR_PLATFORM% -T %PLATFORM_TOOLSET% -DCMAKE_SYSTEM_VERSION=%CMAKE_SYSTEM_VERSION%
msbuild snappy.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\lz4-%LZ4_VERSION%\visual\VS2010
devenv lz4.sln /upgrade
msbuild lz4.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64 /p:TargetPlatformVersion=%WINSDK_VERSION%
popd

pushd %THIRDPARTY_HOME%\zlib-%ZLIB_VERSION%
cmake -G %CMAKE_GENERATOR_PLATFORM% -T %PLATFORM_TOOLSET% -DCMAKE_SYSTEM_VERSION=%CMAKE_SYSTEM_VERSION%
msbuild zlib.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64
popd

pushd %THIRDPARTY_HOME%\jemalloc-cmake-jemalloc-cmake.%JEMALLOC_VERSION%
cmake -G %CMAKE_GENERATOR_PLATFORM% -T %PLATFORM_TOOLSET% -DCMAKE_SYSTEM_VERSION=%CMAKE_SYSTEM_VERSION%
msbuild jemalloc.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64
popd

rem cmake -G %CMAKE_GENERATOR_PLATFORM% -DJNI=1 -DGFLAGS=1 -DSNAPPY=1 -DLZ4=1 -DZLIB=1 -DXPRESS=1 -DCMAKE_SYSTEM_VERSION=6.1 -T v140
cmake -G %CMAKE_GENERATOR_PLATFORM% -DJNI=1 -DGFLAGS=1 -DSNAPPY=1 -DLZ4=1 -DZLIB=1 -DXPRESS=1 -DJEMALLOC=1 -T %PLATFORM_TOOLSET% -DCMAKE_SYSTEM_VERSION=%CMAKE_SYSTEM_VERSION%
msbuild rocksdb.sln /property:PlatformToolset=%PLATFORM_TOOLSET% /p:Configuration=Release /p:Platform=x64

popd