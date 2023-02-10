package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip
import cz.mendelu.thetrips.utils.DateUtils

class MapsViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    fun getAll(): MutableList<Trip>{
        return repository.getAllNotLive()
    }

    fun getClosest(): Trip{
        return repository.getClosest(DateUtils.getCurrentDateTime())
    }
}