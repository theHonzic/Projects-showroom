package cz.mendelu.thetrips.utils

import android.content.Context
import android.content.SharedPreferences

class SPUtils {

    companion object {
        private const val SP_FILE = "sp_file_name"

        private fun getSharedPreferences(context: Context): SharedPreferences{
            return context.getSharedPreferences(SP_FILE, Context.MODE_PRIVATE)
        }

        fun writeString(context: Context, key: String, value: String){
            with(getSharedPreferences(context).edit()) {
                putString(key,value)
                commit()
            }
        }

        fun readString(context: Context, key: String): String{
            return getSharedPreferences(context).getString(key, "").toString()
        }
    }
}