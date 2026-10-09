---
name: research
description: Conduct deep research on a topic and report findings, writing a research doc only when the findings are long or must be kept for later sessions. Use when the user asks to research, investigate, or compare options. Invoked explicitly, not automatically.
---

# Research

## When to use

Invoked explicitly when a decision needs information gathering. Always spawn a subagent to execute this skill. Not every question needs a full research doc — if a quick web search answers it, just answer in chat. Use this skill when the topic is complex, has multiple options to weigh, or will be referenced later.

## Doc or chat

**Default: report the findings in chat and write no file.** Write a doc only when one of these is true:

- The findings need a lot of reading, so a chat reply would be too long.
- A future session needs them recorded.

If unsure, answer in chat. Everything below about the doc applies only when one is written.

A research doc is standalone. It does not contain status markers, links to open questions, or links to plans. Other docs in the same plan link to it; it links to nothing upstream. Nothing outside `.cursor/plans/` links to it, because the plan folder moves when the plan finishes.

**File location:** `.cursor/plans/<plan-name>/research/<topic>.md`.

## Process

1. Clarify what the user is asking. A research doc can cover multiple related questions if they naturally group together — it is organized around a topic, not rigidly one-question-per-file.
2. Gather local context before searching, unless the question is general or the invoker already has it. Read what the project already says about the topic (docs, rules, skills, `docs/decisions.md`, plans, related earlier work) so the research fits what exists and does not repeat it. This skill runs as a subagent: the invoker puts what it knows in the subagent prompt, and the subagent reads the rest.
3. Search broadly (multiple queries, different angles).
4. Fetch and read promising sources before citing them. If a source looks relevant but cannot be read (paywall, video, etc.), move on unless nothing else covers that ground — then link it with a note.
5. Discard junk. A source earns its place by directly informing the user's question. Do not pad with tangentially related links.
6. If a doc is warranted (see Doc or chat), write it.
7. Tell the user what you found.

## Search strategy

- Multiple web searches with different framing. Include the current year in searches — information must be current. Do not cite old sources unless nothing has changed in that area (rare for tech topics).
- Fetch and read article full text before citing. Summarize what the article argues, not what the title says.
- Videos: include when the topic is better explained visually or the user asks for videos. Search for short (<20 min), recent, popular results. Provide link, duration, channel. Do not over-explain that you cannot watch them — the user knows.
- If web search is not surfacing YouTube results, try `youtube <topic> <year>`. If that fails, give the user search terms.
- Quality over quantity. 2 good sources beat 10 unvetted ones.
- Credibility: for every named standard, tool, or framework, find who uses or backs it and put a few words next to its name, such as "used by Cloudflare" or "Microsoft's standard". Check it against a source you read. One short phrase, not a sentence, in chat and in docs alike.

## Research doc format

Structure like a newspaper or short whitepaper: most important information first, detail below.

**Top: summary.** 2-4 sentences. State the finding or recommendation with reasoning. If there is one clear best option, say so. If there are tradeoffs, name them. Embed key source references inline if they directly support the recommendation ("According to X, ...").

**Middle: detail organized by content, not by source.** Group by topic, option, or concept — whatever fits. Each section covers a point with relevant source material woven in. Sources appear naturally in the prose, not in a separate section. If comparing options, each option gets its own section with pros/cons for the user's specific situation.

**Bottom (optional): context.** If the doc needs background to stand alone for future readers, add brief context at the end. Skip if the topic is self-evident.

**End: source URLs.** Flat list of everything cited.

Do not use separate "What I read", "Videos", "Gaps" sections unless the doc is long enough to need them. Short docs just weave everything into the detail sections.

## Anti-patterns

- Dumping search results with titles as descriptions
- Sources unrelated to the research question
- Tables for comparisons
- Status markers or links to open questions / plans
- Repeating the same point across sections
- "I cannot watch this video" disclaimers — just provide the link
