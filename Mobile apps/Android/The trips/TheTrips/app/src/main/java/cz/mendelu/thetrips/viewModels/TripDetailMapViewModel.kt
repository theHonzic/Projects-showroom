package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class TripDetailMapViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    var id: Long? = null

    fun findTripById(): Trip{
        return repository.findById(id!!)
    }
}