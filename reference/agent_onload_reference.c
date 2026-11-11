/*
 * Readable reference reconstruction from the supplied SJT native binary.
 * This is explanatory pseudocode, not vendor source and not a drop-in build.
 */
#include <jni.h>
#include <jvmti.h>
#include <string.h>
#include <stdio.h>

extern int virbox_initialize(void);
extern void JNICALL sjt_ClassFileLoadHook(jvmtiEnv *, JNIEnv *, jclass,
    jobject, const char *, jobject, jint, const unsigned char *, jint *,
    unsigned char **);

static int initialized;

static jint sjt_initialize(JavaVM *vm) {
    jvmtiEnv *jvmti = NULL;
    jvmtiCapabilities caps;
    jvmtiEventCallbacks callbacks;
    jvmtiError err;

    if (initialized) return JNI_OK;
    if (virbox_initialize() != 0) return JNI_ERR;

    err = (*vm)->GetEnv(vm, (void **)&jvmti, JVMTI_VERSION_1_1);
    if (err != JVMTI_ERROR_NONE) return err;

    memset(&caps, 0, sizeof(caps));
    /* Preserve the vendor's other capability bits as appropriate. */
    caps.can_tag_objects = 1;
    caps.can_get_bytecodes = 1;
    /* Compatibility fix: do not request either retransformation capability. */
    caps.can_retransform_classes = 0;
    caps.can_retransform_any_class = 0;

    err = (*jvmti)->AddCapabilities(jvmti, &caps);
    if (err != JVMTI_ERROR_NONE && err != JVMTI_ERROR_NOT_AVAILABLE)
        return err;

    memset(&callbacks, 0, sizeof(callbacks));
    callbacks.ClassFileLoadHook = sjt_ClassFileLoadHook;
    err = (*jvmti)->SetEventCallbacks(jvmti, &callbacks, sizeof(callbacks));
    if (err != JVMTI_ERROR_NONE) return err;

    err = (*jvmti)->SetEventNotificationMode(
        jvmti, JVMTI_ENABLE, JVMTI_EVENT_CLASS_FILE_LOAD_HOOK, NULL);
    if (err != JVMTI_ERROR_NONE) return err;

    initialized = 1;
    return JNI_OK;
}

JNIEXPORT jint JNICALL Agent_OnLoad(JavaVM *vm, char *options, void *reserved) {
    (void)options;
    (void)reserved;
    return sjt_initialize(vm);
}
