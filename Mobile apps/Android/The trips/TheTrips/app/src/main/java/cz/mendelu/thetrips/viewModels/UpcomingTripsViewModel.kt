package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class UpcomingTripsViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    fun getUpcoming(): LiveData<MutableList<Trip>>{
        return repository.getUpcoming(DateUtils.getCurrentDateTime())
    }
}