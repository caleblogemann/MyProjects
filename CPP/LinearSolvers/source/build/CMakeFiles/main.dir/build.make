# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.9.0/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.9.0/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build

# Include any dependencies generated for this target.
include CMakeFiles/main.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/main.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/main.dir/flags.make

CMakeFiles/main.dir/main.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/main.dir/main.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/main.dir/main.cpp.o -c /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/main.cpp

CMakeFiles/main.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/main.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/main.cpp > CMakeFiles/main.dir/main.cpp.i

CMakeFiles/main.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/main.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/main.cpp -o CMakeFiles/main.dir/main.cpp.s

CMakeFiles/main.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/main.dir/main.cpp.o.requires

CMakeFiles/main.dir/main.cpp.o.provides: CMakeFiles/main.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/main.dir/main.cpp.o.provides

CMakeFiles/main.dir/main.cpp.o.provides.build: CMakeFiles/main.dir/main.cpp.o


CMakeFiles/main.dir/ConjugateGradient.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/ConjugateGradient.cpp.o: ../ConjugateGradient.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/main.dir/ConjugateGradient.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/main.dir/ConjugateGradient.cpp.o -c /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/ConjugateGradient.cpp

CMakeFiles/main.dir/ConjugateGradient.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/ConjugateGradient.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/ConjugateGradient.cpp > CMakeFiles/main.dir/ConjugateGradient.cpp.i

CMakeFiles/main.dir/ConjugateGradient.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/ConjugateGradient.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/ConjugateGradient.cpp -o CMakeFiles/main.dir/ConjugateGradient.cpp.s

CMakeFiles/main.dir/ConjugateGradient.cpp.o.requires:

.PHONY : CMakeFiles/main.dir/ConjugateGradient.cpp.o.requires

CMakeFiles/main.dir/ConjugateGradient.cpp.o.provides: CMakeFiles/main.dir/ConjugateGradient.cpp.o.requires
	$(MAKE) -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/ConjugateGradient.cpp.o.provides.build
.PHONY : CMakeFiles/main.dir/ConjugateGradient.cpp.o.provides

CMakeFiles/main.dir/ConjugateGradient.cpp.o.provides.build: CMakeFiles/main.dir/ConjugateGradient.cpp.o


CMakeFiles/main.dir/MultiGrid.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/MultiGrid.cpp.o: ../MultiGrid.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/main.dir/MultiGrid.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/main.dir/MultiGrid.cpp.o -c /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/MultiGrid.cpp

CMakeFiles/main.dir/MultiGrid.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/MultiGrid.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/MultiGrid.cpp > CMakeFiles/main.dir/MultiGrid.cpp.i

CMakeFiles/main.dir/MultiGrid.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/MultiGrid.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/MultiGrid.cpp -o CMakeFiles/main.dir/MultiGrid.cpp.s

CMakeFiles/main.dir/MultiGrid.cpp.o.requires:

.PHONY : CMakeFiles/main.dir/MultiGrid.cpp.o.requires

CMakeFiles/main.dir/MultiGrid.cpp.o.provides: CMakeFiles/main.dir/MultiGrid.cpp.o.requires
	$(MAKE) -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/MultiGrid.cpp.o.provides.build
.PHONY : CMakeFiles/main.dir/MultiGrid.cpp.o.provides

CMakeFiles/main.dir/MultiGrid.cpp.o.provides.build: CMakeFiles/main.dir/MultiGrid.cpp.o


CMakeFiles/main.dir/vector_math.cpp.o: CMakeFiles/main.dir/flags.make
CMakeFiles/main.dir/vector_math.cpp.o: ../vector_math.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/main.dir/vector_math.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/main.dir/vector_math.cpp.o -c /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/vector_math.cpp

CMakeFiles/main.dir/vector_math.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/vector_math.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/vector_math.cpp > CMakeFiles/main.dir/vector_math.cpp.i

CMakeFiles/main.dir/vector_math.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/vector_math.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/vector_math.cpp -o CMakeFiles/main.dir/vector_math.cpp.s

CMakeFiles/main.dir/vector_math.cpp.o.requires:

.PHONY : CMakeFiles/main.dir/vector_math.cpp.o.requires

CMakeFiles/main.dir/vector_math.cpp.o.provides: CMakeFiles/main.dir/vector_math.cpp.o.requires
	$(MAKE) -f CMakeFiles/main.dir/build.make CMakeFiles/main.dir/vector_math.cpp.o.provides.build
.PHONY : CMakeFiles/main.dir/vector_math.cpp.o.provides

CMakeFiles/main.dir/vector_math.cpp.o.provides.build: CMakeFiles/main.dir/vector_math.cpp.o


# Object files for target main
main_OBJECTS = \
"CMakeFiles/main.dir/main.cpp.o" \
"CMakeFiles/main.dir/ConjugateGradient.cpp.o" \
"CMakeFiles/main.dir/MultiGrid.cpp.o" \
"CMakeFiles/main.dir/vector_math.cpp.o"

# External object files for target main
main_EXTERNAL_OBJECTS =

main: CMakeFiles/main.dir/main.cpp.o
main: CMakeFiles/main.dir/ConjugateGradient.cpp.o
main: CMakeFiles/main.dir/MultiGrid.cpp.o
main: CMakeFiles/main.dir/vector_math.cpp.o
main: CMakeFiles/main.dir/build.make
main: CMakeFiles/main.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable main"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/main.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/main.dir/build: main

.PHONY : CMakeFiles/main.dir/build

CMakeFiles/main.dir/requires: CMakeFiles/main.dir/main.cpp.o.requires
CMakeFiles/main.dir/requires: CMakeFiles/main.dir/ConjugateGradient.cpp.o.requires
CMakeFiles/main.dir/requires: CMakeFiles/main.dir/MultiGrid.cpp.o.requires
CMakeFiles/main.dir/requires: CMakeFiles/main.dir/vector_math.cpp.o.requires

.PHONY : CMakeFiles/main.dir/requires

CMakeFiles/main.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/main.dir/cmake_clean.cmake
.PHONY : CMakeFiles/main.dir/clean

CMakeFiles/main.dir/depend:
	cd /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build /Users/caleblogemann/Documents/MyProjects/CPP/LinearSolvers/source/build/CMakeFiles/main.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/main.dir/depend

