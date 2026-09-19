# Scripts Directory

## Purpose
This directory is intended for auxiliary Python scripts for the **PaperInsight-Word** project.

## Current Status
Currently, the main workflow (PDF parsing, Word generation, rendering validation) is dynamically generated into the `temp/` directory by the Codex Agent based on the rules defined in `AGENTS.md`. 

Because of this dynamic generation approach, this `scripts/` directory remains empty for now.

## Future Plans
If you (or future contributors) develop generic, reusable utility scripts that do not fit the dynamic generation workflow, please place them in this directory.

Examples of potential scripts:
- Batch file renaming utilities.
- Standalone document format validators.
- PDF text extraction testing tools.

## Usage
If you add a new script here, please ensure it uses relative paths so it can be executed safely, and document its usage in the main project `README.md`.