package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class UpdateTripViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    var id: Long? = null

    var trip: Trip = Trip("")


    suspend fun updateTrip(){
        repository.updateTrip(trip)
    }

    fun findTripById(): Trip = repository.findById(id!!)

}