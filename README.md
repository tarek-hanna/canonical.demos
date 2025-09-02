# Anbox Cloud Demos

A repository to showcase how Android applications can use the Anbox Cloud Appliance for local development, and to demo how it can be used as part of GitHub workflows for running UI screenshot tests and generating test reports.

It includes [nowinandroid](https://github.com/android/nowinandroid) (**'nia'** for short) as an example of a typical android project.

- To add `nowinandroid` to anbox-cloud-demos repository as a subtree, run `git subtree add --prefix=nowinandroid https://github.com/android/nowinandroid.git main --squash`
`
- To pull latest changes from `nowinandroid` subtree, run `git subtree pull --prefix=nowinandroid https://github.com/android/nowinandroid.git main --squash`
`
## Installation

- Install [Android Studio](https://developer.android.com/studio) or VScode with all relevant dependencies and extensions, also make sure to add the following to your `~/.bashrc`

```
export PATH="~$PATH:~/Android/Sdk/platform-tools"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
```

## Development

- Clone the repository and open the root directory in Android Studio or VScode.
- Run `make nia-build | nia-install` to buil and generate nia app apk or install the apk - as 'DemoDebug' flavor - directly on the connected device.
- For more options you can run `make help` which will show all available make targets and commands.
- Make sure to connect an android device with `adb connect`, by following this guide on how to [Access an Android instance](https://documentation.ubuntu.com/anbox-cloud/howto/android/access-android-instance/#access-the-android-instance-using-anbox-connect) running in Anbox.

 
## Testing

- Write integration test/screenshot tests or use existing tests from `nowinandroid`

## GitHub Workflow

- Create a PR in GitHub with committed changes in any UI element
- This will trigger `nia-pr.yaml` workflow that will:
```
    1- Install JDK and Gradle dependencies

    2- Run lint checks and unit tests

    3- Build the Demo APK

    4- Install the Anbox Cloud Appliance w/ runner (w/o AWS)

     a- Connect to the remote AMS

     b- Spin up a new instance

     c- Connect ADB link

     d- Run UI screenshot tests

     e- Link to Deployment / APK and Test Report
```
`
     