# Find Pangolin (https://github.com/stevenlovegrove/Pangolin)
find_package(Pangolin 0.4 REQUIRED)
set(CMAKE_CXX_FLAGS "-std=c++11")
include_directories(${Pangolin_INCLUDE_DIRS})

add_executable(HelloPangolin main.cpp)
target_link_libraries(HelloPangolin pango_display pango_python)
