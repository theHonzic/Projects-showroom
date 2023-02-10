package cz.mendelu.thetrips.di

import android.content.Context
import cz.mendelu.thetrips.database.TripsDatabase
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val databaseModule = module {

    single {
        provideDatabase(androidContext())
    }

}

fun provideDatabase(context: Context): TripsDatabase = TripsDatabase.getDatabase(context)