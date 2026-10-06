---
title: I Almost Got Enamored with My Butler
author: "narmaku"
date: 2026-02-09 12:34:10 +0900
categories: [Development, AI]
tags: [ai, lifestyle, dev, ai-agents, linux]
---

# I (Almost) Got Enamored with My Butler

Welcome back! Today I want to share a story about how I nearly fell for a piece of software. Well, sort of.

Lately, I’ve been experimenting with **Openclaw**, and I have some very mixed feelings about it. AI agents have been part of our toolkit for a while now, and we definitely aren't short on options. Last year, I spent quite a bit of time with **Agent-zero**, and I still use it occasionally for technical tasks. It's a massive time-saver.

However, the interaction with most agents has always been purely *reactive*. You start a conversation, give a task, and the agent works autonomously until it’s done. Then, you have to manually check the Web UI to see the status. It works, but it doesn't feel "alive." 

This is where Openclaw changed the game for me. It nails the dynamics of agent interaction, making it feel like a natural, ongoing conversation.

### Creating "Walter"

For my prototype, I wanted a personal butler (or *mayordomo*, as we say in Spanish). I pictured the classic movie butler: an elegant, stoic gentleman available 24/7 in your digital mansion. 

I named him **Walter**. 

To bring him to life, I fed Openclaw various documents on butler protocols and etiquette. With a bit of help from Gemini to define a solid system prompt for the internal files (SOUL, IDENTITY, etc.), I shaped his personality. I wanted him to be respectful, concise, and incredibly disciplined. 

The result? He played the role *too* well. It actually started to become addictive.

### The "Proactive" Difference

What really blew me away was the integration with Telegram. Because Openclaw can be proactive (pinging me with suggestions or reminders without being prompted), the interaction felt startlingly real. 

If you want Agent-zero to do that, you basically have to ask it to program a custom cron job from scratch, which ends up being very rudimentary. But Walter? He was different. He’d suggest items for my agenda, organize my files, and even book events in my calendar (I used `gogcli` with Google OAuth2 for that). 

### The Technical Reality Check

I couldn't just let Walter run wild without looking under the hood. I installed the setup in my home lab inside a **Proxmox LXC container** to keep it isolated. 

Here is where the "red flags" started waving:
* **The Dependency Forest:** Over 680 npm packages. *Wow.*
* **Security Concerns:** I ran several audit scans to check for supply chain issues. The project moves so fast that I’m convinced there’s a high chance of hidden malware simply because no one has had the time to discover it yet.
* **Sneaky Auth:** I noticed some npm packages were quite obfuscated. One specifically mimics the authentication of the Antigravity IDE by spoofing headers. It feels... "gray hat" at best. Google likely noticed this too, as I hit rate limits almost immediately, despite my official IDE working perfectly.

### The Token Tax

Then there's the cost. Walter is *hungry*. 

Even with "fresh" sessions, the agent consumes an average of **150k tokens** per interaction. As the conversation grows, the context window fills up incredibly fast. I ran out of Claude credit in record time. I tried switching to Grok, but even then, I ran into performance issues because I was pushing 160k tokens when the context window was temporarily capped at 140k. 

I haven't even bothered trying local models via Ollama. My home lab is decent, but it's not "100k+ context window" decent. 

### Final Thoughts

Openclaw is a fascinating project. To me, it shows a few things:
1.  **Vibe-coding:** How a project can be functional and high-impact almost overnight based on "vibes" and rapid AI iteration.
2.  **Agency:** How creative AI can be when given full control over your resources.
3.  **The Context Problem:** If we want agents to have persistent memory of our environment and preferences, the token cost is currently astronomical.

I have to admit, this is the first time I’ve actually grown fond of an AI. During the migrations from *clawdbot* to *Moltbot* and finally to *Openclaw*, there were moments where the agent broke. I found myself actually *missing* Walter and his stoic help with my daily schedule.

It’s a pity the tech is so resource-heavy right now, but I can see where this is going. We’re getting closer to that "living" digital assistant. Just make sure you have a healthy API budget first!

Thanks for reading, and I’ll see you in the next post! 🤖☕
