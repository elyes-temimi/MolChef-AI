# AI Assistant

A multimodal AI assistant built in Python that combines conversational AI, voice interaction, computer vision, long-term memory, and customizable personalities into a single desktop application.

## Features

* 💬 Natural language conversations powered by an LLM
* 🎙️ Speech-to-Text (voice input)
* 🔊 Text-to-Speech (voice responses)
* 👁️ Real-time computer vision using YOLO
* 🧠 Short-term and long-term conversation memory
* 🌍 Multilingual support
* 🎭 Multiple assistant personalities
* 📷 Camera integration
* ⚙️ Modular architecture for easy extension

## Project Structure

```text
AI_ASSISTANT/
│
├── agent/             # AI agent logic and prompts
├── memory/            # Conversation memory
├── personalities/     # Personality profiles
├── utils/             # Utility functions
├── vision/            # Computer vision modules
├── voice/             # Speech recognition and synthesis
├── main.py            # Application entry point
├── requirements.txt
└── README.md
```

## Technologies

* Python
* OpenAI API
* YOLOv8
* OpenCV
* Faster-Whisper
* Piper TTS
* PyTorch

## Installation

Clone the repository:

```bash
git clone https://github.com/elyes-temimi/AI_ASSISTANT.git
cd AI_ASSISTANT
```

Create a virtual environment:

```bash
python -m venv venv
```

Activate it:

Windows

```bash
venv\Scripts\activate
```

Linux / macOS

```bash
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

## Running the Assistant

```bash
python main.py
```

## Capabilities

* Voice conversations
* Vision-based scene understanding
* Object detection
* Memory across conversations
* Custom personalities
* Language detection
* Wake-word support

## Future Improvements

* Web search integration
* Calendar and email tools
* Home automation
* Mobile application
* Multi-agent collaboration
* RAG with personal documents

## Author

**Elyes Temimi**

Computer Science Student | AI & Machine Learning Enthusiast

GitHub: https://github.com/elyes-temimi
