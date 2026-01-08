# Flex OTP

A Flutter package built with **Clean Architecture** to handle OTP (One-Time Password) flows seamlessly.

## Features
- Provider-agnostic design (Easily switch between Twilio, Firebase, etc.)
- Clean Architecture (Domain, Data, and Core separation)
- Easy to integrate and test.

## Getting Started
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  flex_otp: ^0.0.1


---

### 4. Final Hosting Commands

Now that the files are fixed, follow these steps in order:

1.  **Format your code:** (Pub.dev checks for this)
    ```bash
    dart format .
    ```
2.  **Analyze for errors:**
    ```bash
    flutter analyze
    ```
3.  **Dry Run:** (This will now pass because we fixed the LICENSE)
    ```bash
    flutter pub publish --dry-run
    ```
4.  **Publish for real:**
    ```bash
    flutter pub publish
    ```



### What happens next?
* Once you run the final command, it will give you a **Google login link**. 
* After you sign in, your package will be live at: `https://pub.dev/packages/flex_otp`
* Any developer in the world can now use your package by adding it to their `pubspec.yaml`.

**Would you like me to help you write a real HTTP implementation for the `sendOtp` method using a specific provider like Twilio?**  