# 🧪 MolChef — Game Rules

> An educational molecular kitchen adventure | InNOGame Hackathon 2025

---

## 🎯 Objective

You are a Chef-Scientist locked in a molecular kitchen lab. Explore 5 rooms, interact with scientific equipment, and solve chemistry & physics challenges to unlock each exit door.

**ARIA** — your AI mentor — guides you with Socratic hints. She never gives the answer. She teaches you to find it.

---

## 🕹️ Controls

| Key | Action |
|-----|--------|
| `Arrow keys` / `WASD` | Move around the room |
| `E` | Interact with objects / Enter exit door |
| `Mouse drag` *(Level 3 only)* | Draw wires between circuit nodes |
| `Right-click` *(Level 3 only)* | Remove last wire |
| `R` *(Level 3 only)* | Reset all wires |
| `Enter` *(Level 3 only)* | Confirm solved circuit |
| `Esc` / `✕ button` | Close challenge panel |

---

## 🔁 How to Play

1. Enter the lab room and explore freely
2. Walk up to any interactive object — a `[E]` prompt appears
3. Press `E` to open the challenge panel
4. Read the scientific scenario and pick one of 4 answers
5. **Wrong answer** → −15 points, ARIA gives a hint, try again
6. **Correct answer** → object glows green ✓, click "Mark Complete"
7. Solve **ALL objects** in the room → EXIT door appears
8. Walk to EXIT and press `E` to go to the next level
9. After Level 5 → receive your personalized **Science Passport**

---

## 📊 Scoring

| Event | Points |
|-------|--------|
| Start of game | **100 pts** |
| Wrong answer | **−15 pts** |
| Asking ARIA for a hint | **−5 pts** |
| Correct answer | no change |
| Score floor | **0 pts** (never goes negative) |

### Final Score Ranks

| Score | Rank |
|-------|------|
| 100 pts | 🏆 Perfect — Molecular Expert |
| 70–99 pts | ⭐ Very good — Confirmed Chef-Scientist |
| 40–69 pts | ✅ Good progress — Chef in training |
| 1–39 pts | 📚 Keep learning — replay to improve! |

---

## 🗺️ The 5 Levels

| Level | Theme | Science |
|-------|-------|---------|
| 1 | 🧪 Molecular Kitchen | pH, acids/bases, neutralization, Maillard reaction |
| 2 | 🥚 Emulsion Lab | Molecular polarity, emulsifiers, protein denaturation |
| 3 | ⚡ Circuit Wiring | Series/parallel circuits, Ohm's Law, short circuits *(interactive wiring)* |
| 4 | 🌡️ Thermodynamics | Conductivity, boiling point, latent heat, entropy |
| 5 | 💡 Optics Lab | Refraction, color absorption, total internal reflection, interference |

---

## 🤖 ARIA — Your AI Mentor

- Powered by **LLaMA 3.1** running locally via Ollama
- Gives **Socratic hints** — never the direct answer
- Adapts to your mistakes:
  - 1st wrong → light guiding question
  - 2nd wrong → addresses your misconception
  - 3rd wrong → near-direct clue
- Celebrates correct answers with a science-cooking insight
- Generates your **Science Passport** at the end

---

## ⚡ Level 3 — Circuit Wiring (Special)

Instead of multiple choice, you **physically draw wires** by clicking and dragging between circuit nodes on a workbench.

- **3 puzzles:** Series circuit → Parallel circuit → Short circuit detection
- Correct wiring → wires glow green + physics fact displayed
- Short circuit attempt → red warning + danger explanation
- Ohm's Law reference panel always visible on the right

---

## 🎓 Science Passport

After completing all 5 levels, ARIA generates a personalized report:

- Score per scientific domain
- Your strengths and weak areas
- Personalized study recommendation
- Official certification from ARIA

---

## 🔀 Randomization

Every interactive object has a **pool of multiple questions**. At the start of each game session, one question is randomly selected per object. No two playthroughs are identical.

---

## ✅ Win Condition

Complete all 5 levels and receive your Science Passport. There is **no fail state** — wrong answers trigger teaching moments, not elimination.

---

## ⚙️ Requirements

- Godot 4 (to run from source)
- [Ollama](https://ollama.ai) running locally with `llama3.1` model
- Start Ollama before launching: `ollama serve`

---

*MolChef — InNOGame Hackathon 2025 — InNOScEnce Project*
*"Les sciences deviennent plus vivantes lorsqu'elles se manipulent, se questionnent et se jouent."*
