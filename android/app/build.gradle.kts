plugins {
    id("com.android.application")
    id("kotlin-android")
    // O plugin do Flutter deve ser aplicado após os plugins Android e Kotlin
    id("dev.flutter.flutter-gradle-plugin")
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

// Adiciona a dependência para o desugaring
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}