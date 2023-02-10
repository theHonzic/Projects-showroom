package cz.mendelu.thetrips.di

import cz.mendelu.thetrips.viewModels.*
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {

    viewModel {
        AddNewTripViewModel(get())
    }

    viewModel {
        HomeViewModel(get())
    }

    viewModel {
        MapsViewModel(get())
    }

    viewModel {
        PastTripsViewModel(get())
    }

    viewModel {
        TripDetailViewModel(get())
    }

    viewModel {
        UpcomingTripsViewModel(get())
    }

    viewModel {
        UpdateTripViewModel(get())
    }

    viewModel {
        TripDetailMapViewModel(get())
    }

    viewModel {
        AppInfoViewModel(get())
    }

    viewModel {
        ShareFragmentViewModel(get())
    }

}