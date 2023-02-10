package cz.mendelu.thetrips.views

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.databinding.ViewInfoMessageBinding

class InfoMessageView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, defStyleAttrs: Int = 0
): FrameLayout(context, attrs, defStyleAttrs){

    private lateinit var binding: ViewInfoMessageBinding

    init{
        init(context, attrs)
    }

    private fun init(context: Context, attrs: AttributeSet?){
        binding = ViewInfoMessageBinding.inflate(LayoutInflater.from(context),
            this,
            true)

        if (attrs != null){
            loadAttributes(attrs)
        }
    }

    private fun loadAttributes(attrs: AttributeSet){
        val attributes = context.obtainStyledAttributes(attrs, R.styleable.InfoMessageView)
        val message = attributes.getString(R.styleable.InfoMessageView_message)
        binding.message.text = message
        attributes.recycle()
    }

    var message: String
        get() = binding.message.toString()
        set(message){
            binding.message.setText(message)
        }
}