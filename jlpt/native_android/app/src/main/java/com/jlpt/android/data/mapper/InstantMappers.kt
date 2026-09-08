package com.jlpt.android.data.mapper

import java.time.Instant

/** Backend sends ISO-8601 instant strings; falls back to epoch if somehow unparsable. */
fun String?.toInstantOrNull(): Instant? = this?.let {
    runCatching { Instant.parse(it) }.getOrNull()
}

fun String.toInstant(): Instant = toInstantOrNull() ?: Instant.EPOCH
