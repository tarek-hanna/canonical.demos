# Anbox Cloud Demos

A repository to showcase how Android applications can use the Anbox Cloud Appliance for local development, and to demo how it can be used as part of GitHub workflows for running UI screenshot tests and generating test reports.

It includes [nowinandroid](https://github.com/android/nowinandroid) (**'nia'** for short) as an example of a typical android project.

- To add `nowinandroid` to anbox-cloud-demos repository as a subtree, run `git subtree add --prefix=nowinandroid https://github.com/android/nowinandroid.git main --squash`.
`
- To pull latest changes from `nowinandroid` subtree, run `git subtree pull --prefix=nowinandroid https://github.com/android/nowinandroid.git main --squash`.
`
## Installation

- Install [Android Studio](https://developer.android.com/studio) or VScode with all relevant dependencies and extensions, also make sure to add the following to your `~/.bashrc`.

```
export PATH="~$PATH:~/Android/Sdk/platform-tools"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
```

## Development

- Clone the repository and open the root directory in Android Studio or VScode.
- Run `make nia-build | nia-install` to buil and generate nia apk or install the apk - as 'DemoDebug' flavor - directly on the connected device.
- For more options you can run `make help` which will show all available make targets and commands.
- Make sure to connect an android device with `adb connect`, by following this guide on how to [Access an Android instance](https://documentation.ubuntu.com/anbox-cloud/howto/android/access-android-instance/#access-the-android-instance-using-anbox-connect) running in Anbox.

 
## Testing

- Run `make nia-ui-test` and `make nia-screenshot-test`
- This will generate test `outputs`, `reports` and `test-results` in `app/build/` directory.   

## GitHub Workflow

- Create a PR in GitHub with committed changes in any UI element.
- This will trigger `./workflows/nia-pr.yaml` workflow that uses:

    1- `./workflows/nia-ci.yaml`:
    
    - Runs `ubuntu-latest` on GitHub hosted runner.
    
    - Runs `./actions/setup-android/action.yaml` to install JDK, Gradle and Android SDK dependencies.
    
    - Runs lint checks, unit tests and roborazzi screenshot tests.
    
    - Builds the Demo APK.
    
    - Uploads the lint, unit test and screenshot test reports, as well as the demo APK as artifacts.
    