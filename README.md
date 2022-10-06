
[Flutter version ]: 2.10.4 (Stable)

[Android BundleId]: com.example.xyz
[iOS BundleId]: com.example.xyz

[iOS - minimum deployment target is]: 10

[Do changes for credential of Firebase]:
    - change the google json files of Android & iOS

[Do changes for credential of Google-Map]:
    - change google map key :
         --------------------------------------------------------------
         -  (Android) ( [path] : app/src/main/AndroidManifest.xml)
            android:name="com.google.android.geo.API_KEY"
            android:value="[PUT_YOUR_GOOGLE_MAP_KEY_HERE]"
         --------------------------------------------------------------
         -  (iOS) ( [path] : ios/Runner/AppDelegate.swift)
            GMSServices.provideAPIKey("[PUT_YOUR_GOOGLE_MAP_KEY_HERE]")
         --------------------------------------------------------------

