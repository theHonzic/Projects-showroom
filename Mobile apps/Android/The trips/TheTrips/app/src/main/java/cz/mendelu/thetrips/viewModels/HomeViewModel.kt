package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.model.Trip


class HomeViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    fun getTripsCount(): Int = repository.getCount()

    fun getLatest() : Trip {
        return repository.getClosest(DateUtils.getCurrentDateTime())
    }

}