package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip

class PastTripsViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    fun getPast(): LiveData<MutableList<Trip>>{
        return repository.getPast(DateUtils.getCurrentDateTime())
    }
}