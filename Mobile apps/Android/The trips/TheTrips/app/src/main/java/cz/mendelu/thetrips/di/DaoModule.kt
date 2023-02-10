package cz.mendelu.thetrips.di

import cz.mendelu.thetrips.database.TripsDao
import cz.mendelu.thetrips.database.TripsDatabase
import org.koin.dsl.module

val daoModule = module {

    single {
        provideTripsDao(get())
    }
}

fun provideTripsDao(database: TripsDatabase): TripsDao = database.tripsDao()