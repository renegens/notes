fun Context.addCalendarEvent(event: Event) {
    val startTime = event.date.toInstant().toEpochMilli()
    val endTime = event.date.plusHours(4).toInstant().toEpochMilli()

    Intent(Intent.ACTION_INSERT).apply {
        type = "vnd.android.cursor.item/event"
        putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startTime)
        putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endTime)
        putExtra(CalendarContract.EXTRA_EVENT_ALL_DAY, false)

        putExtra(Events.TITLE, event.title)
        putExtra(Events.DESCRIPTION, event.description)
        putExtra(Events.EVENT_LOCATION, "${event.location.name} ${event.location.street}")
    }.run {
        startActivity(this)
    }
}

fun downloadWithGlide() {
    Glide.with(this)
        .asBitmap()
        .load(url)
        .into(object : SimpleTarget<Bitmap>(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL) {
            override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                //do something with the bitmap
            }
        })
}

fun Context.shareImage(uri: Uri) {
    Intent(Intent.ACTION_SEND).apply {
        type = "image/jpg"
        putExtra(Intent.EXTRA_SUBJECT, getString(R.string.app_name))
        putExtra(Intent.EXTRA_TEXT, getString(R.string.general_moto))
        putExtra(Intent.EXTRA_STREAM, uri)
    }.run {
        startActivity(Intent.createChooser(this, getString(R.string.share_intent)))
    }
}

fun Context.bitmapToUri(bitmap: Bitmap): Uri {
    val file = File(ContextWrapper(this).cacheDir, "${UUID.randomUUID()}.jpg")
    try {
        val stream: OutputStream = FileOutputStream(file)
        bitmap.compress(Bitmap.CompressFormat.JPEG, 80, stream)
        stream.flush()
        stream.close()
    } catch (e: IOException) {
        e.printStackTrace()
    }
    return FileProvider.getUriForFile(
        this,
        this.getString(R.string.file_provider_authority),
        file
    )
}

fun Context.launchMap(location: Location) {
    val gmmIntentUri = Uri.parse("geo:${location.latitude},${location.longitude}")
    val mapIntent = Intent(Intent.ACTION_VIEW, gmmIntentUri)
    mapIntent.setPackage("com.google.android.apps.maps")
    startActivity(mapIntent)
}

fun animateInCarousel() {
    val animation = AnimationDrawable().apply {
        addFrame(ContextCompat.getDrawable(this@LoginActivity, R.drawable.background_login_pic_one)!!, 5000)
        addFrame(ContextCompat.getDrawable(this@LoginActivity, R.drawable.background_login_pic_two)!!, 5000)
        addFrame(ContextCompat.getDrawable(this@LoginActivity, R.drawable.background_login_pic_three)!!, 5000)
        isOneShot = false
        setEnterFadeDuration(400)
        setExitFadeDuration(400)
    }

    image.backgroundDrawable = animation
    animation.start()
}
