---
title: Let's talk about Rubrics
author: "narmaku"
date: 2025-12-08 14:26:58 +0900
categories: [Development]
tags: [testing,ai,vibe-coding,llm]
---
## 🤖 Let's talk about Rubrics: Consistent Evaluation of AI Agents

Hello there! 👋 I'm excited to share some of the interesting things I’ve been cooking up recently. As part of my job, I focus on creating innovative solutions and filling technical gaps in the industry, and lately, my attention has been on rigorously testing the behavior of **AI Agents**, especially those interacting with systems using  **Model Context Protocol (MCP)** tools.

The usual battery of tests for these agents includes verifying a few key things:
* Did the model choose the **right tools**?
* Did it use the correct **parameters**?
* Were the tools called an **expected number of times**?
* Was the chat session outcome the expected one, and did it contain information **synthesized correctly** from the tool call outputs?

While digging into this, I stumbled upon a fantastic methodology (if you can call it that) straight from the academic world: **Rubrics**.

---

### What Exactly is a Rubric?

By definition, a **rubric** is a set of criteria designed for the **consistent, thorough, and multi-dimensional evaluation** of assessments. You know, the kind of detailed checklist teachers use to fairly evaluate a student's essay or exam response, ensuring every student is measured against the *exact same* standard.

This concept, I realized, is incredibly powerful for AI evaluations. Think of a rubric as a customizable **checklist** that can be used to evaluate *any* kind of content. Of course, if the content is completely irrelevant to what the rubric measures, you’ll get a poor score, and that's the beauty of it.

With rubrics, you can be as **granular and thorough** as you need. You can evaluate different **dimensions** (aspects or areas) using multiple, atomic **criteria**.

#### Dimensions: The "How"

**Dimensions** define the *how* for a Judge (be it an LLM or a human). They describe the aspects that must be considered. Think of a dimension as a **testing domain**.

For example, you might have a **"Factual Accuracy"** dimension. Its descriptor could be: *"Evaluate the correctness and accuracy of the data provided in the final response, in comparison with the original data source."* (In the AI Agent context, the "data source" usually refers to a tool's output).

The good thing about dimensions is that, unlike rubric criteria, they are generic enough to be reused across your entire collection of rubrics.

#### Criteria: The Atomic Test

A **criterion** must be **atomic, self-contained, and only assess a specific thing**. You should strictly avoid combining criteria into one. It must also be understood without the need of reading the prompt, question or chat session that is about to be evaluated.

For example, instead of a vague check, you could have two very specific criteria:
1.  **Criterion 1:** "The response must state that the total amount of RAM of the system is 54.5 GB."
2.  **Criterion 2:** "The response must state that the free RAM of the system is 15.3 GB."

This way, if the model messes up one specific value, you don't compromise the overall evaluation score for an entirely different metric. Also, by reading the above criteria, you understand that what is being evaluated is a set of values obtained from a system's specifications. You didn't need anything else to actually understand what is being evaluated.

In the end, I like to think about rubrics as a **test suite** for your prompts, Q&A pairs, or chat sessions. A test suite (the **rubric**) that contains **unit tests** (the **criteria**) and a guide on what is being verified for each of them (the **dimensions**).

---

### Introducing `rubric-kit`

As I wanted to try something new and provide some solid foundation when testing our systems within my team, I developed a framework: **rubric-kit**.

This little project is designed to help you **generate/refine rubrics** and **run evaluations** from Q&A pairs or exported chat sessions. I genuinely didn't find anything exactly like it, though I saw some similarities in the approach of frameworks like DeepEval (especially their arena mode for evaluation comparisons).

You can check it out on GitHub: [https://github.com/narmaku/rubric-kit](https://github.com/narmaku/rubric-kit)
Or just install it via PyPI:
```bash
pip install rubric-kit
```

The project currently works really well with exported chat sessions from **Goose CLI** or with basic Q&A pairs defined in a `yaml` format. You can dive deeper into the methodology in the `RUBRICS.md` file in the repo.

### The Beauty of Deterministic Evaluation

Thanks to this framework, I was able to uncover multiple **hallucinations** and subtle **behavior inconsistencies** that were hidden within the models' final responses. The process is simple:

1.  Run the evaluation with a specific rubric.
2.  See the score and detailed criteria breakdown.
3.  Adjust parameters like the model’s temperature, the prompt or other settings.
4.  **Re-run the evaluation with exactly the same rubric.**

That's the beauty of it! I believe the Rubrics approach brings back the much-needed **determinism** that we often miss when we rely on an LLM as a Judge or similar subjective evaluation methods.

#### My Panel of Judges: Good, Better, Best

For my evaluation process, I like to use a panel of **3 LLMs**, following a "the good, the better, and the best" approach. For example:

  * **Judge 1 (Good):** A lighter, cheaper model, perhaps **Gemini-2.5-flash-lite**.
  * **Judge 2 (Better):** A faster, high-performing model, like **Gemini-2.5-flash**.
  * **Judge 3 (Best):** A top-tier, complex model, such as **Gemini-2.5-pro**.

By setting the temperature to `0.0` for all of them, the results when assessing the **atomicity and specificity** of a rubric criterion are incredibly consistent. Plus, I've had great results even with open-source models like `llama3.1`, `granite4`, and `gpt-oss:20b`. This means the framework allows for powerful, consistent evaluations using **cheap models**, many even capable of running on your laptop (maybe a little slow, but it still works!).

#### A Note on Development  🎸

Full disclosure: it's heavily **vibe-coded** 😜.

Vibe coding is a double-edged sword, like many tools in life, but I see it as an **accelerator** for projects like this. It allows you to create a fully functional framework in much less time, which can then be refined in multiple iterations later. If a project isn't aiming to be a production-grade or customer-facing product/service right out of the gate, relying on **AI coding assistance** to accelerate the initial creation process makes perfect sense to me.

-----

I genuinely hope you enjoy creating rubrics and running evaluations with it! Try it out, and let me know what you think! Feel free to open an issue or feature request on GitHub!

*Thanks for reading, and I’ll see you in the next post!*

