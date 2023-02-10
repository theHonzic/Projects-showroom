package cz.mendelu.thetrips.fragments

import android.graphics.Color
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.lifecycleScope
import cz.mendelu.thetrips.BuildConfig
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentAppInfoBinding
import cz.mendelu.thetrips.utils.SPUtils
import cz.mendelu.thetrips.viewModels.AppInfoViewModel
import kotlinx.coroutines.launch


class AppInfoFragment: BaseFragment<FragmentAppInfoBinding, AppInfoViewModel>(AppInfoViewModel::class){

    override val bindingInflater: (LayoutInflater) -> FragmentAppInfoBinding
        get() = FragmentAppInfoBinding::inflate

    override fun initViews(){
        val name = SPUtils.readString(requireContext(), "name")

        if (name == ""){
            binding.nameText.message = getString(R.string.add_name)
        } else {
            binding.nameText.message = getString(R.string.change_name)
        }

        setInteractionListeners()

        if (!name.isNullOrBlank()){
            binding.name.text = name
        }

        val count = viewModel.getTripsCount()

        binding.version.setText("${BuildConfig.VERSION_CODE}-${BuildConfig.VERSION_NAME}")
        binding.tripsCount.setText(count.toString())

        binding.deleteButton.setOnClickListener{
            showDeleteDialog()
        }
    }

    private fun setInteractionListeners(){
        binding.name.addTextChangeListener(object: TextWatcher{
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){}

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int){}

            override fun afterTextChanged(p0: Editable?){
                viewModel.name = p0.toString()
            }
        })

        binding.saveName.setOnClickListener{
            if (!viewModel.name.isNullOrBlank()){
                lifecycleScope.launch{
                    SPUtils.writeString(requireContext(), "name", viewModel.name.toString())
                }.invokeOnCompletion {
                    finishCurrentFragment()
                }
            }
        }
    }

    private fun showDeleteDialog(){
        AlertDialog.Builder(requireContext(), R.style.alert_dialog)
            .setMessage("${getString(R.string.delete_all_dialog)}?")
            .setTitle(getString(R.string.delete_all))
            .setIcon(R.drawable.ic_warning)
            .setPositiveButton(getString(R.string.yes)) { _, _ ->

                lifecycleScope.launch {
                    viewModel.deletAll()
                }.invokeOnCompletion {
                    finishCurrentFragment()
                }
            }
            .setNegativeButton(getString(R.string.no), null)
            .show()
            .getButton(AlertDialog.BUTTON_POSITIVE).setTextColor(Color.BLACK)
    }

    override fun onActivityCreated() {}

}