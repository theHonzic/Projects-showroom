//
// Created by honzi on 02.06.2020.
//

#include "Map.h"
Map::Map() {
    for (int x=0; x < m_map.size(); x++){
        for (int y=0; y < m_map.size(); y++){
            if ((rand()%2)==0){
                m_map[x][y] = new Water((rand() % 100 + 1));
            }else{
                m_map[x][y] = new Grass((rand() % 100 + 1));
            }
        }
    }
}

void Map::printMap() {
    for (int x=0; x<m_map.size(); x++){
        for (int y=0; y<m_map.size(); y++){
            std::cout<<m_map[x][y]->getMark()<<"\t";
        }
        std::cout<<"\n";
    }
    std::cout<<"\n";
}