---
title: "Vibe Coding Double Edged Sword"
date: 2025-11-23T02:17:05Z
draft: false
categories:
  - Reflections
tags:
  - Artificial Intelligence
  - Vibe coding
  - AI
---

[Vibe coding](https://www.ibm.com/think/topics/vibe-coding) is when a person
uses an LLM as an intermediate processor to transform intent expressed in
natural language to source code. This is usually done by a vague prompt
expressing what the person wants to achieve, followed by the LLM trying to
accommodate for that and generating the code. Oftentimes this results in not
what the vibe coder intended. Vibe coding is a double edged sword that empowers
programmers but is actually detremental to the average person.

## How LLMs Work

The easiest way to explain how large language models work is by imagining the
sum of most of human written text represented as a probability distribution
where the output is the next word to generate and the input is the sentence so
far. This is because LLMs are
[stochastic](https://en.wikipedia.org/wiki/Stochastic) and
[auto-regressive](https://en.wikipedia.org/wiki/Autoregressive_model) by design.

Of course there is the element of randomness in its generation, through clever
representation of words and their semantics (context around the words), we can
capture the semantic meaning of the words and represent it as embeddings. This
allows us to achieve a certain degree of "generalization"
([see more information](https://out-of-distribution-generalization.com/)). To
the layman, this means the model can output sentences that it hasn't seen
before.

By this design, when a generic prompt is used to task the LLM to output
something, the LLM will probably output the most likely thing has seen before
during training. In most cases, this works quite well, a prompt like "_create a
static website so I can write my blog inside it_" would yield expected results
as the prompt has little to no ambiguity.

## Detail vs. Time Tradeoff

There is a real tradeoff in prompt design where the person prompting needs to
decide between detail and time writing the prompt. A less specific prompt will
take less time to write, but will likely result in a response that is off-target
and more generic. A more explicit prompt will take time to write, but will most
likely be more accurate to the "intent" of the input prompt.

## Autoregressive Nature

When you code large projects, the LLM agent is not able to process the prompt
like a human does. A human may look over the instructions multiple times, then
decide how to act. LLMs as mentioned, use the previous text autoregressively,
however, the key difference is that an LLM generates text one token at a time,
and at each step it can only condition on what has already been written, not go
back and revise its past output. This makes its "reasoning" and forward-only:
once it has committed to an interpretation of the instructions and started down
a path, all later tokens are biased by that path, even if a human would pause,
reread the spec, and change course. This usually isn't a problem, however, it
can become one when you get intermediate prompt injection by LLM service
providers.

## LLM Service Providers and Their "Meddling"

Service providers (like OpenAI, Anthropic, and Google) often use specific system
messages to guide LLM behavior, which can sometimes negatively affect its
output. Other providers (such as Perplexity), inject their own intermediate
instructions to improve chain-of-thought reasoning and enable tool use. However,
these additional instructions designed to enhance accuracy can also cause the
model's output to not align with the intent of the user, resulting in less
accurate responses.

## Vibe Coding Guide

So far, this article discussed LLMs and thier sequence generation through
general terms. The purpose of this section is to provide a general guide for
vibe coders specifically. There's been plenty of examples online where someone
has incorrectly used vibe coding and has resulted in the destruction of the
codebase ([example 1](https://x.com/_kamal_sharma/status/1973402764077048263),
[example 2](https://x.com/dave_watches/status/1991651163071213706),
[example 3](https://x.com/tekbog/status/1923037639856230509), etc.). The issue
isn't that vibe coding is inherently bad, in fact, when used properly it can
boost your productivity as you act as the manager of a code generator that is
able to produce code at a much faster pace than any human can.

With vibe coding, **you** are the manager, this means you need to write into the
prompt not only _what_ you want, but also _how_ you want it done too. This means
that it's slightly harder for non-programmers to vibe code. You need to keep
track of micro and macro changes that the LLM does, understand them and also
correct any mistakes as soon as possible, because if missed will become a much
harder problem to fix later on. Take for example the following scenario: you are
designing a book store app and you prompt the LLM to implement an API endpoint
for managing stored books, the LLM suggests the following endpoints:

- `/api/v1/book-view&id=:id`
- `/api/v1/book-add&id=:id`
- `/api/v1/book-edit&id=:id`
- `/api/v1/book-delete&id=:id`

This quickly becomes unmanageable as numerous API endpoints connect to growing
backend code. A simpler solution is to define it through a RESTful API endpoint
such as:

- `/api/v1/book/:id`

As the LLM adds different endpoints for managing different resources throughout
the website, you will end up with a lot of endpoints and a lot of backend code.
The initial point where the code became unmaintainable probably came before
this, perhaps there were other endpoints that were implemented incrementally in
a similar fashion. The fault could also be the way the user specified it in the
prompt. But it's important to keep track of what you ask to be done in the
codebase and be critical of it. You are the manager.

Version control like git is fundumental in keeping track of long-term changes
through a project and being able to reference and roll-back previous changes. I
have spoken to multiple people personally that started a project, it got too
complicated and they ended up destroying it through a single vibe coding prompt
(although the problems probably started way before but reached a
breaking-point).

## Conclusion

To conclude, vibe coding is a double edged sword where if used improperly can do
more harm than good. It's important that the users of such tools keep track of
the changes made to their solutions and to course correct as early as possible
in order to avoid refactoring a messy codebase with hundreds of files later on.
Vibe coding has already redefined who can write software, however, it didn't
redefine who can maintain it.
