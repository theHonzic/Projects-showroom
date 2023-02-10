package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class AddNewTripViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    var trip: Trip = Trip("")

    suspend fun saveTrip(){
        repository.insertTrip(trip)
    }
}