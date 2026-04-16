# 🏥 CureBay: Empowerment for Rural Healthcare

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![AI-Powered](https://img.shields.io/badge/AI--Powered-FF6F00?style=for-the-badge&logo=google-cloud&logoColor=white)](#)

**CureBay** is a high-fidelity, offline-first diagnostic assistant specifically designed for ASHA (Accredited Social Health Activist) workers in rural environments. It bridges the gap between remote villages and modern medical intelligence, providing instant, uncertainty-aware diagnostic support without requiring an active internet connection.

---

## ✨ Key Features

### 🔍 Intelligence & Diagnostics
*   **AI-Driven Disease Prediction:** Powered by an edge-optimized XGBoost model to provide clinical-grade diagnostic suggestions.
*   **Uncertainty Awareness:** Unlike standard apps, CureBay flags results with low confidence, ensuring ASHA workers know when a professional referral is non-negotiable.
*   **TTS Integration:** Voice-based result delivery for improved accessibility and patient communication.

### 📊 Real-time Monitoring
*   **Epidemic Tracking:** Localized monitoring of disease outbreaks to trigger early community warnings.
*   **Seasonal Risk Assessment:** Dynamic alerts based on weather patterns and seasonal trends (e.g., Malaria during monsoon).
*   **Vitals Guide:** A comprehensive visual and instructional guide for capturing accurate patient vitals.

### 🛠️ Practical Field Tools
*   **Drug Database:** An offline-accessible repository of essential medicines and dosages.
*   **WhatsApp Export & PDF:** Seamlessly share diagnostic reports with doctors or district hospitals via PDF or standardized WhatsApp messages.
*   **Voice-to-Text (STT):** Powered by Vosk for hands-free symptom logging in noisy rural settings.

---

## 🚀 Technology Stack

- **Framework:** [Flutter](https://flutter.dev) (Cross-platform excellence)
- **Local Intelligence:** ONNX Runtime with XGBoost (Offline AI)
- **Voice Engine:** Vosk (Offline Speech-to-Text)
- **Database:** SQLite (Secure, local patient history)
- **Design:** Modern, high-contrast UI designed for field legibility.

---

## 🛠️ Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/MAsTeRlssPd/CureBay.git
    ```
2.  **Environment Setup:** Ensure you have Flutter installed and configured.
    ```bash
    flutter doctor
    ```
3.  **Fetch Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the App:**
    ```bash
    flutter run
    ```

---

## 📁 Project Structure

```text
lib/
├── screens/    # Feature-specific UI (Dashboard, Epidemic, Vitals)
├── services/   # AI Orchestration (ONNX), Speech (Vosk), PDF Generation
├── widgets/    # Reusable UI components
├── main.dart   # App entry point
└── routes.dart # Navigation mapping
```

---

## 🛡️ Privacy & Security

CureBay is built with privacy at its core. Patient data remains strictly on the device unless explicitly exported by the health worker. No data is automatically synced to the cloud, ensuring compliance with local healthcare privacy norms in rural connectivity zones.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

Developed with ❤️ for ASHA Workers.
