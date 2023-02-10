package cz.mendelu.thetrips.di

import cz.mendelu.thetrips.database.ITripsLocalRepository
import cz.mendelu.thetrips.database.TripsDao
import cz.mendelu.thetrips.database.TripsLocalRepositoryImpl
import org.koin.dsl.module

val repositoryModule = module {

    single {
        provideLocalTripsRepository(get())
    }

}

fun provideLocalTripsRepository(dao: TripsDao): ITripsLocalRepository = TripsLocalRepositoryImpl(dao)