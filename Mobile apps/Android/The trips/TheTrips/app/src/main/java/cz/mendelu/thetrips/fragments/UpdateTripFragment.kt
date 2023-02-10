package cz.mendelu.thetrips.fragments

import android.app.DatePickerDialog
import android.location.Geocoder
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.DatePicker
import android.widget.Spinner
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.navArgs
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentUpdateTripBinding
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.UpdateTripViewModel
import cz.mendelu.thetrips.views.TextInputView
import kotlinx.coroutines.launch
import java.util.*

class UpdateTripFragment: BaseFragment<FragmentUpdateTripBinding, UpdateTripViewModel>(UpdateTripViewModel::class){

    val arguments: UpdateTripFragmentArgs by navArgs()

    private lateinit var option : Spinner
    private lateinit var spinnerValue: String
    private lateinit var vehicleOptions: Array<String>

    override fun initViews() {
        viewModel.id = if (arguments.id != -1L) arguments.id else null

        vehicleOptions = arrayOf(
            getString(R.string.car),
            getString(R.string.bus),
            getString(R.string.train),
            getString(R.string.plane),
            getString(R.string.ship))

        option = binding.vehicleSpinner
        option.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_list_item_1, vehicleOptions)
        option.onItemSelectedListener = object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long){
                spinnerValue = vehicleOptions.get(p2)
            }

            override fun onNothingSelected(p0: AdapterView<*>?){
                spinnerValue = ""
            }
        }

        lifecycleScope.launch {
            viewModel.trip = viewModel.findTripById()
        }.invokeOnCompletion {
            fillLayout()
        }

        setInteractionListeners()

    }

    private fun fillLayout(){
        if (!viewModel.trip.description.isNullOrEmpty()){
            binding.descriptionText.text = viewModel.trip.description!!
        }

        if (!viewModel.trip.destination.isNullOrEmpty()){
            binding.destinationText.text = viewModel.trip.destination!!
        }

        if (!viewModel.trip.departure.isNullOrEmpty()){
            binding.departureText.text = viewModel.trip.departure!!
        }

        if (!viewModel.trip.vehicle.isNullOrEmpty()){
            swap(vehicleOptions, 0, vehicleOptions.indexOf(UIUtils.checkStringNotNullOrBlank(viewModel.trip.vehicle)))
        }

        setStartDate()
        setEndDate()

    }

    private fun setInteractionListeners(){

        binding.endDate.setOnClickListener{
            openEndDatePickerDialog()
        }

        binding.startDate.setOnClickListener{
            openStartDatePickerDialog()
        }

        binding.departureText.addTextChangeListener(object: TextWatcher{
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun afterTextChanged(p0: Editable?){
                viewModel.trip.departure = p0.toString()
            }
        })
        binding.destinationText.addTextChangeListener(object: TextWatcher{
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun afterTextChanged(p0: Editable?){
                viewModel.trip.destination = p0.toString()
            }
        })

        binding.descriptionText.addTextChangeListener(object: TextWatcher{
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){

            }

            override fun afterTextChanged(p0: Editable?){
                viewModel.trip.description = p0.toString()
            }
        })

        binding.saveButton.setOnClickListener{
            viewModel.trip.vehicle = spinnerValue

            if (!binding.departureText.text.isNullOrBlank() && !binding.destinationText.text.isNullOrBlank()){

                val geocoder = Geocoder(requireContext())

                val address = geocoder.getFromLocationName(viewModel.trip.destination, 1).get(0)

                viewModel.trip.latitude = address.latitude
                viewModel.trip.longitude = address.longitude

                if (UIUtils.getLong(viewModel.trip.endDate) < UIUtils.getLong(viewModel.trip.startDate) && UIUtils.getLong(viewModel.trip.endDate) != 0L){
                    showDateDialog()
                } else {
                    lifecycleScope.launch {
                        if (viewModel.trip.startDate == null){
                            viewModel.trip.startDate = 0L
                        }

                        if (viewModel.trip.endDate == null){
                            viewModel.trip.endDate = 0L
                        }

                        viewModel.updateTrip()
                    }.invokeOnCompletion {
                        finishCurrentFragment()
                    }
                }
            } else{
                setTextInputErrors(viewModel.trip.destination, binding.destinationText)
                setTextInputErrors(viewModel.trip.departure, binding.departureText)
            }
        }

        binding.startDate.setOnClearClickListener(object: View.OnClickListener{
            override fun onClick(p0: View?){
                viewModel.trip.startDate = null
                setStartDate()
            }
        })

        binding.endDate.setOnClearClickListener(object: View.OnClickListener{
            override fun onClick(p0: View?){
                viewModel.trip.endDate = null
                setEndDate()
            }
        })
    }

    private fun setTextInputErrors(string: String?, textInputView: TextInputView){
        if (string.isNullOrBlank()){
            textInputView.setError("${getText(R.string.text_input_error)}")
        }
    }

    private fun showDateDialog(){
        AlertDialog.Builder(requireContext(), R.style.alert_dialog)
            .setMessage(getString(R.string.date_dialog_text))
            .setTitle(getString(R.string.date_dialog_title))
            .setIcon(R.drawable.ic_info)
            .setNeutralButton(getString(R.string.okay), null)
            .show()
    }

    private fun setStartDate(){
        if (viewModel.trip.startDate != null){

            if (viewModel.trip.startDate == 0L){
                binding.startDate.value = "Not set"
                binding.startDate.hideClearButton()
            } else {
                binding.startDate.value = DateUtils.getDateString(viewModel.trip.startDate!!)
                binding.startDate.showClearButton()
            }

        } else {
            binding.startDate.value = "Not set"
            binding.startDate.hideClearButton()
        }
    }

    private fun setEndDate(){
        if (viewModel.trip.endDate != null){

            if (viewModel.trip.endDate == 0L){
                binding.endDate.value = "Not set"
                binding.endDate.hideClearButton()
            } else {
                binding.endDate.value = DateUtils.getDateString(viewModel.trip.endDate!!)
                binding.endDate.showClearButton()
            }

        } else {
            binding.endDate.value = "Not set"
            binding.endDate.hideClearButton()
        }
    }


    private fun openStartDatePickerDialog(){
        val calendar: Calendar = Calendar.getInstance()

        if (viewModel.trip.startDate != null){
            calendar.timeInMillis = DateUtils.getCurrentDateTime()
        }

        val y = calendar.get(Calendar.YEAR)
        val m = calendar.get(Calendar.MONTH)
        val d = calendar.get(Calendar.DAY_OF_MONTH)

        val dialog = DatePickerDialog(
            requireContext(),
            object : DatePickerDialog.OnDateSetListener{
                override fun onDateSet(p0: DatePicker?, year: Int, month: Int, day: Int){
                    viewModel.trip.startDate = DateUtils.getUnixTime(year, month, day)
                    setStartDate()
                }
            }, y, m, d
        )

        dialog.show()
    }

    private fun openEndDatePickerDialog(){
        val calendar: Calendar = Calendar.getInstance()

        if (viewModel.trip.endDate != null){
            calendar.timeInMillis = DateUtils.getCurrentDateTime()
        }

        val y = calendar.get(Calendar.YEAR)
        val m = calendar.get(Calendar.MONTH)
        val d = calendar.get(Calendar.DAY_OF_MONTH)

        val dialog = DatePickerDialog(
            requireContext(),
            object : DatePickerDialog.OnDateSetListener{
                override fun onDateSet(p0: DatePicker?, year: Int, month: Int, day: Int){
                    viewModel.trip.endDate = DateUtils.getUnixTime(year, month, day)
                    setEndDate()
                }
            }, y, m, d
        )

        dialog.show()
    }

    fun <T> swap(arr: Array<T>, i: Int, j: Int){
        val t = arr[i]
        arr[i] = arr[j]
        arr[j] = t
    }

    override fun onActivityCreated(){}

    override val bindingInflater: (LayoutInflater) -> FragmentUpdateTripBinding
        get() = FragmentUpdateTripBinding::inflate
}