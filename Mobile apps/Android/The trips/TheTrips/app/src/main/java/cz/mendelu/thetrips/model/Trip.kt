package cz.mendelu.thetrips.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "trips")
data class Trip (@ColumnInfo(name = "destination") var destination: String){

    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id") var id: Long? = null

    @ColumnInfo(name = "departure") var departure: String? = null

    @ColumnInfo(name = "startDate") var startDate: Long? = null

    @ColumnInfo(name = "endDate") var endDate: Long? = null

    @ColumnInfo(name = "description") var description: String? = null

    @ColumnInfo(name = "longitude") var longitude: Double? = null

    @ColumnInfo(name = "latitude") var latitude: Double? = null

    @ColumnInfo(name = "vehicle") var vehicle: String? = null

}