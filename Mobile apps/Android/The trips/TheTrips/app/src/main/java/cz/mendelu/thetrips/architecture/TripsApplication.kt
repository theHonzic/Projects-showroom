package cz.mendelu.thetrips.architecture

import android.app.Application
import cz.mendelu.thetrips.di.daoModule
import cz.mendelu.thetrips.di.databaseModule
import cz.mendelu.thetrips.di.repositoryModule
import cz.mendelu.thetrips.di.viewModelModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class TripsApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidContext(applicationContext)
            modules(databaseModule, daoModule, repositoryModule, viewModelModule)
        }
    }

}