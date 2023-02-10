package cz.mendelu.thetrips.database

import androidx.lifecycle.LiveData
import cz.mendelu.thetrips.model.Trip

interface ITripsLocalRepository {

    fun getAll(): LiveData<MutableList<Trip>>
    fun findById(id: Long): Trip
    fun getPast(date: Long): LiveData<MutableList<Trip>>
    fun getUpcoming(date: Long): LiveData<MutableList<Trip>>
    fun getClosest(date: Long): Trip
    fun getAllNotLive(): MutableList<Trip>
    fun getCount(): Int

    suspend fun deleteAll()
    suspend fun insertTrip(trip: Trip): Long
    suspend fun updateTrip(trip: Trip)
    suspend fun deleteTrip(trip: Trip)

}