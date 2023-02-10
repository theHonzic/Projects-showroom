package cz.mendelu.thetrips.viewModels

import androidx.lifecycle.ViewModel
import cz.mendelu.thetrips.database.ITripsLocalRepository

class AppInfoViewModel(private val repository: ITripsLocalRepository): ViewModel(){

    var name: String? = null

    fun getTripsCount(): Int = repository.getCount()

    suspend fun deletAll(){
        repository.deleteAll()
    }
}