package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class TripDetailViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    var id: Long? = null

    var trip: Trip? = null

    fun findTripById(): Trip = repository.findById(id!!)

    suspend fun deleteTrip(){
        trip?.let { repository.deleteTrip(it) }
    }
}