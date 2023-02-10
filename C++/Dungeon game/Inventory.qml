import QtQuick 2.0

Grid{


        Grid {
            id: inventoryGrid
            columns: 3
            rows: 2
            spacing: 3

            Repeater {
                model: 6

                InventoryTile {
                    inventoryTileIndex: index
                }
            }
        }


}
