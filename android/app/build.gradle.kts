plugins {
    id("com.android.application")
    id("kotlin-android")
    // O plugin do Flutter deve ser aplicado após os plugins Android e Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.compras_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Definido explicitamente para atender aos plugins

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8 // Alterei para 1_8 por compatibilidade com desugaring
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true // Habilita o desugaring
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString() // Alinhado com compileOptions
    }

    defaultConfig {
        applicationId = "com.example.compras_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Adicione sua própria configuração de assinatura para o release
            // Por enquanto, usando chaves de debug para `flutter run --release`
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

<<<<<<< HEAD
dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.10.0"))

  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")

  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
=======
// Adiciona a dependência para o desugaring
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
>>>>>>> main
}