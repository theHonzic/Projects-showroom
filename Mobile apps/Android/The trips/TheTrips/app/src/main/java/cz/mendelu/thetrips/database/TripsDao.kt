package cz.mendelu.thetrips.database

import androidx.lifecycle.LiveData
import androidx.room.*
import cz.mendelu.thetrips.model.Trip

@Dao interface TripsDao {

    @Query("SELECT * FROM trips")
    fun getAll(): LiveData<MutableList<Trip>>

    @Query("SELECT * FROM trips")
    fun getAllNotLive(): MutableList<Trip>

    @Query("DELETE FROM trips")
    suspend fun deleteALl()

    @Query("SELECT * FROM trips WHERE id = :id")
    fun findById(id: Long): Trip

    @Insert
    suspend fun insertTrip(trip: Trip): Long

    @Update
    suspend fun updateTrip(trip: Trip)

    @Query("SELECT COUNT(*) FROM trips")
    fun getCount(): Int

    @Delete
    suspend fun deleteTrip(trip: Trip)

    @Query("SELECT * FROM trips WHERE endDate < :date AND startDate < :date ORDER BY endDate DESC")
    fun getPast(date: Long): LiveData<MutableList<Trip>>

    @Query("SELECT * FROM trips WHERE startDate >= :date OR endDate >= :date ORDER BY startDate ASC")
    fun getUpcoming(date: Long): LiveData<MutableList<Trip>>

    @Query("SELECT * FROM trips WHERE startDate >= :date ORDER BY startDate ASC LIMIT 1")
    fun getClosest(date: Long): Trip

}