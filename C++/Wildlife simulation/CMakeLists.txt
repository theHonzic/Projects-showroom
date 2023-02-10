cmake_minimum_required(VERSION 3.16)
project(zoo_ls2020_projekt)

set(CMAKE_CXX_STANDARD 14)

add_executable(zoo_ls2020_projekt main.cpp Field.cpp Field.h Water.cpp Water.h Grass.cpp Grass.h Animal.cpp Animal.h Herbivore.cpp Herbivore.h Predator.cpp Predator.h Map.cpp Map.h)