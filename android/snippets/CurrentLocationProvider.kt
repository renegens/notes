package de.umlaut.thccorehelper.library.location

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.os.Looper
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationResult
import de.umlaut.thccorehelper.library.LocationServiceApp
import de.umlaut.thccorehelper.library.error.LocationNotAvailableException
import de.umlaut.thccorehelper.library.error.NoLocationPermissionException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.TimeoutCancellationException
import kotlinx.coroutines.cancelChildren
import kotlinx.coroutines.launch
import kotlinx.coroutines.withTimeout
import kotlin.coroutines.CoroutineContext

@SuppressLint("MissingPermission")
class CurrentLocationProvider(
    context: Context,
    lifecycle: Lifecycle
) : LifecycleObserver, CoroutineScope {

    companion object {
        private const val TAG = "CurrentLocationProvider"
    }

    override val coroutineContext: CoroutineContext
        get() = Job() + Dispatchers.Main

    private val locationClient = context.fusedLocationProviderClient

    init {
        lifecycle.addObserver(this)
    }

    fun onLocationUpdate(func: ((Location) -> Unit)) {
        onLocationUpdate = func
    }

    fun onLocationError(func: (Exception) -> Unit) {
        onLocationNotAvailable = func
    }

    fun onLocationTimeOut(func: (Exception) -> Unit) {
        onLocationTimeout = func
    }

    private var onLocationUpdate: ((Location) -> Unit)? = null
    private var onLocationNotAvailable: ((Exception) -> Unit)? = null
    private var onLocationTimeout: ((Exception) -> Unit)? = null

    private val locationCallback = object : LocationCallback() {
        override fun onLocationResult(result: LocationResult) {
            super.onLocationResult(result)

            if (result.lastLocation != null) {
                onLocationUpdate?.invoke(result.lastLocation)
            } else {
                onLocationNotAvailable?.invoke(LocationNotAvailableException())
            }
        }
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    private fun start() {
        Log.d(TAG, "Start location updates")
        launch {
            try {
                withTimeout(LocationServiceApp.locationTimeoutInMillis) {
                    try {
                        locationClient.requestLocationUpdates(
                            getLocationRequest(),
                            locationCallback,
                            Looper.getMainLooper()
                        )
                    } catch (e: SecurityException) {
                        onLocationNotAvailable?.invoke(NoLocationPermissionException())
                    }
                }
            } catch (timeout: TimeoutCancellationException) {
                this@CurrentLocationProvider.onLocationTimeout?.invoke(timeout)
            }
        }
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    private fun stop() {
        Log.d(TAG, "Remove location updates")
        locationClient.removeLocationUpdates(locationCallback)
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
    private fun destroy() {
        coroutineContext.cancelChildren()
    }
}