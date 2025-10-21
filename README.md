# Anbox Cloud Demos

A repository to showcase how Android applications can use the Anbox Cloud Appliance for local development, and to demo how it can be used as part of GitHub workflows for running UI screenshot tests and generating test reports.

It includes [nowinandroid](https://github.com/android/nowinandroid) (**'nia'** for short) as an example of a typical Android project.

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
- Make sure to connect an Android device with `adb connect`, by following this guide on how to [Access an Android instance](https://documentation.ubuntu.com/anbox-cloud/howto/android/access-android-instance/#access-the-android-instance-using-anbox-connect) running in Anbox.

 
## Testing

- Run `make nia-ui-test` and `make nia-screenshot-test`
- This will generate test `outputs`, `reports` and `test-results` in `app/build/` directory.   

## GitHub Workflow

- Create a PR in GitHub with committed changes in any UI element in `./nowinandroid/` project.
- This will trigger `./workflows/nia-pr.yaml` workflow that runs on GitHub hosted runner or [on AWS](https://documentation.ubuntu.com/anbox-cloud/howto/install-appliance/install-on-aws/), and calls the following workflows:

1. `./workflows/nia-ci.yaml`:
            
    - Runs lint checks, unit tests and roborazzi screenshot tests.
    
    - Builds the DemoDebug APK.
    
    - Uploads the lint, unit test and screenshot test reports, as well as the APK as artifacts.
    
2. And `./workflows/nia-e2e.yaml`:
 
    - Runs `canonical/anbox-cloud-github-action` to install LXD and the Anbox Cloud Appliance.
    
    - Restores cached Android image, launch it and connects the instance with ADB.

    - Runs E2E tests (Equivalent to running make nia-e2e-test)

    - Uploads the e2e test report to the artifacts
    
    - Cleans up the created Android instance after finishing all tests

**Notes**
- Another workflow is `cache-images.yaml` to download and cache Android images, that is scheduled to run every day at 10:00 AM, or can manually be dispatched.

- To add a remote amc where you launch the Android image, and connect to adb for running e2e tests, you must provide the following in the repos variables and secrets: otherwise the runner's internal ip will be used as the remote url.
1. `vars.REMOTE_AMC_URL `: in this format `https://<remote-amc-ip>:8444`
2. `secrets.REMOTE_SERVER_CERT`: content found in `/var/snap/anbox-cloud-appliance/common/ams/server/ams.crt`
3. `secrets.GH_RUNNER_CERT`: content found in `$HOME"/snap/anbox-cloud-appliance/current/client/client.crt`
4. `secrets.GH_RUNNER_KEY`: content found in `$HOME"/snap/anbox-cloud-appliance/current/client/client.key`