package cz.mendelu.thetrips.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import cz.mendelu.thetrips.model.Trip


@Database(entities = [Trip::class], version = 3, exportSchema = true) abstract class TripsDatabase : RoomDatabase(){

        abstract fun tripsDao(): TripsDao

        companion object {
            private var INSTANCE: TripsDatabase? = null

            fun getDatabase(context: Context): TripsDatabase {
                if (INSTANCE == null) {
                    synchronized(TripsDatabase::class.java) {
                        if (INSTANCE == null) {
                            INSTANCE = Room.databaseBuilder(
                                context.applicationContext,
                                TripsDatabase::class.java, "trips_database"
                            ).fallbackToDestructiveMigration()
                                .allowMainThreadQueries().build()
                        }
                    }
                }
                return INSTANCE!!
            }

        }
    }
