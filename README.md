# PaperInsight-Word

> An automated local AI Agent based on OpenAI Codex + DeepSeek for scientific literature interpretation and Word document polishing.

**Author**: [@DaColumbidae24](https://github.com/DaColumbidae24)  
**License**: MIT

---

## 📖 Project Overview
Reading and interpreting scientific literature is time-consuming. Existing AI chatbots often struggle to strictly follow formatting rules, manage multi-template integration, or save outputs directly to your file system with visual validation. 

**PaperInsight-Word** is a local AI Agent designed to solve this. Powered by OpenAI's Codex CLI and DeepSeek's extremely cost-effective API, this agent runs securely on your local machine. It automatically:
- Categorizes papers into **Research** or **Review**.
- Fuses multiple reference templates.
- Generates beginner-friendly Chinese interpretations.
- Outputs polished `.docx` files with visual PDF validation.

## ✨ Key Features
- **Auto-Classification**: Automatically identifies whether a paper is a Research or Review article and uses the corresponding template pool.
- **Multi-Template Fusion**: Aggregates the strengths and structures of all provided templates in the matched category.
- **Idempotency & Resume**: Checks `Outputs/` to skip already processed papers, saving your API credits and time.
- **Safety First**: Includes directory restrictions, auto-backups, and an iteration limit to prevent infinite loops.
- **Low Cost**: Utilizes DeepSeek API (extremely cheap) instead of expensive OpenAI API billing.
- **Clean Output**: Only Word (.docx) files are placed in `Outputs/`; all intermediate PDFs and scripts stay in `temp/`.

## 🏗️ Architecture & How It Works
1. You place your paper PDFs in the `Inputs/` folder.
2. You prepare your Word templates in `Templates/Research/` and `Templates/Review/`.
3. The `start_PaperInsight.bat` script launches CC Switch (for local routing) and Codex.
4. The Agent reads `AGENTS.md` for strict behavioral rules.
5. It generates interpretations, validates pagination by converting to PDF, and places the final `.docx` in `Outputs/`.

## 🚀 Quick Start

### Prerequisites
- **OS**: Windows 10 / 11
- **Node.js**: v18 or higher (`npm install -g @openai/codex`)
- **Python**: 3.x with `python-docx` and `pypdf` installed
- **CC Switch**: [Download here](https://ccswitch.io) (for routing Codex requests to DeepSeek)
- **DeepSeek API Key**: [Get one here](https://platform.deepseek.com)

### Setup Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/DaColumbidae24/PaperInsight-Word.git
   cd PaperInsight-Word
   ```
2. **Install Python dependencies**:
   ```bash
   pip install python-docx pypdf pdfplumber -i https://pypi.tuna.tsinghua.edu.cn/simple
   ```
3. **Configure CC Switch**:
   - Open CC Switch, add DeepSeek as a provider, and input your API Key.
   - Enable Local Routing and ensure `codex -> DeepSeek` is active.
4. **Prepare Folders**:
   - Create `Templates/Research` and `Templates/Review` folders, then put your reference Word templates inside.
   - Put your paper PDFs into the `Inputs/` folder.
5. **Run the Agent**:
   - Double-click `start_PaperInsight.bat`.
   - **IMPORTANT**: When Codex prompts `Do you trust the contents of this directory?`, press `1` (Yes, continue).
   - In the Codex window, press `Ctrl+V` and `Enter` to send the predefined instruction.

## 📂 Directory Structure
```text
PaperInsight-Word/
├── AGENTS.md                 # Core Agent rules and safety guidelines
├── start_PaperInsight.bat    # One-click Windows launcher
├── README.md                 # Project documentation
├── LICENSE                   # MIT License
├── .gitignore                # Git ignore rules
├── scripts/                  # Auxiliary Python scripts
│   └── README.md
├── Templates/                # Your personal Word templates (Ignored by Git)
│   ├── Research/
│   │   └── .gitkeep
│   └── Review/
│       └── .gitkeep
├── Inputs/                   # Place your paper PDFs here
│   └── .gitkeep
├── Outputs/                  # Final .docx interpretations
│   └── .gitkeep
├── temp/                     # Intermediate files, scripts, and validation PDFs
│   └── .gitkeep
└── Backups/                  # Auto-generated backups
    └── .gitkeep
```

## ⚙️ Configuration & Customization
- **Behavior Rules**: Modify `AGENTS.md` to adjust content rules, font preferences, and acceptance criteria.
- **API Routing**: This project relies on CC Switch to route Codex's API calls to DeepSeek. Ensure CC Switch is running in the background.
- **Templates**: The `.gitignore` file intentionally excludes the `Templates/` folder. You **MUST** provide your own templates for the agent to work correctly.

## ⚠️ Important Notes & Safety
- **Data Safety**: The `start_PaperInsight.bat` script automatically backs up your `Inputs/` and `AGENTS.md` before every run into the `Backups/` folder.
- **Token Consumption**: Reading multiple PDFs and generating Word documents consumes tokens. DeepSeek is very cheap, but keep an eye on your balance.
- **Human-in-the-Loop**: The agent is configured to confirm the article type (Research/Review) with you before generating the final Word document.

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/DaColumbidae24/PaperInsight-Word/issues).

## 📄 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.