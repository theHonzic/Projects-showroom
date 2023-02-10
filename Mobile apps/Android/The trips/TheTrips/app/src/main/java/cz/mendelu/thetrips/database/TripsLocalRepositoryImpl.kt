package cz.mendelu.thetrips.database

import androidx.lifecycle.LiveData
import cz.mendelu.thetrips.model.Trip

class TripsLocalRepositoryImpl(private val tripsDao: TripsDao) : ITripsLocalRepository{

    override fun getAll(): LiveData<MutableList<Trip>> {
        return tripsDao.getAll()
    }

    override fun findById(id: Long): Trip {
        return tripsDao.findById(id)
    }

    override fun getPast(date: Long): LiveData<MutableList<Trip>> {
        return tripsDao.getPast(date)
    }

    override fun getUpcoming(date: Long): LiveData<MutableList<Trip>> {
        return tripsDao.getUpcoming(date)
    }

    override fun getClosest(date: Long): Trip {
        return tripsDao.getClosest(date)
    }

    override fun getAllNotLive(): MutableList<Trip> {
        return tripsDao.getAllNotLive()
    }

    override fun getCount(): Int {
        return tripsDao.getCount()
    }

    override suspend fun deleteAll() {
        tripsDao.deleteALl()
    }

    override suspend fun insertTrip(trip: Trip): Long {
        return tripsDao.insertTrip(trip)
    }

    override suspend fun updateTrip(trip: Trip) {
        tripsDao.updateTrip(trip)
    }

    override suspend fun deleteTrip(trip: Trip) {
        tripsDao.deleteTrip(trip)
    }

}