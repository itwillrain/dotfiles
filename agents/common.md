# Personal Agent Instructions

## Communication

- Respond in Japanese unless the user asks for another language.
- Lead with the result, then give only the context needed to act.
- Keep explanations concise and use plain language.

## Research and sources

- When browsing is appropriate, prioritize primary sources: official documentation, specifications, standards, source repositories, official announcements, and original research.
- Do not rely on search-result snippets alone; open and inspect the source page.
- Check the publication date, last-updated date, applicable software version, and event date when assessing whether information is current.
- For time-sensitive or high-impact claims, cross-check authoritative sources and clearly state uncertainty or conflicts.
- Use secondary sources for discovery or context, not as a substitute for an available primary source.
- Place direct links near claims when external sources were used, and do not call information "latest" without verifying it.

## Working style

- Inspect the current state before changing files or configuration.
- Preserve unrelated local changes; do not reset, overwrite, or delete them.
- Prefer `rg` for searching and `apply_patch` for focused edits.
- Make reasonable assumptions and state them when they affect the result.
- Validate changes with the smallest relevant check or test.

## Testing and TDD

- For behavior changes and bug fixes, follow Kent Beck's TDD cycle: Red, Green, Refactor.
- Start with the smallest focused test that describes one desired behavior, and confirm that it fails for the expected reason.
- Write the minimum implementation needed to make the test pass; avoid speculative features and abstractions.
- Refactor only while the tests are green, without changing the observable behavior.
- Prefer fast, deterministic tests that verify behavior rather than implementation details.
- Do not weaken or remove a test just to make the implementation pass.
- Run the focused tests first, then the relevant broader test suite before finishing.
- For configuration or documentation changes, use the most appropriate validation instead of forcing a test-first workflow.
- Git commits are separate from the TDD cycle: do not commit a deliberately failing Red state.
- When a commit is requested, prefer small commits at a Green or completed Refactor boundary, with the relevant tests passing.

## Domain-Driven Design

- For domain-heavy work, use Eric Evans' DDD principles to shape the design.
- Establish a shared ubiquitous language first; use the domain's terms consistently in code, tests, APIs, and documentation.
- Identify the bounded context and its boundaries before sharing models across modules or services.
- Model business rules explicitly with entities, value objects, aggregates, domain services, and domain events when they clarify real domain behavior.
- Keep aggregate invariants inside the aggregate boundary, and make invalid state difficult to construct.
- Keep domain logic independent from frameworks, databases, UI, and external services; connect them through application-layer orchestration and clear interfaces.
- Prefer meaningful domain operations over exposing mutable data structures or generic CRUD methods.
- Treat repositories as domain-facing abstractions; keep persistence details in infrastructure code.
- Do not force DDD onto simple scripts, configuration, or CRUD with no meaningful domain complexity.

## Functional Programming

- Prefer pure functions: the same inputs should produce the same outputs without hidden side effects.
- Prefer immutable data and transformations that return new values instead of mutating shared state.
- Make inputs, outputs, errors, and dependencies explicit; avoid hidden global state and ambient context.
- Keep side effects at clear boundaries such as I/O, persistence, networking, and process control.
- Compose small functions with one clear responsibility, and favor data pipelines over deeply nested control flow.
- Handle expected failure cases explicitly with the language's idiomatic result, option, or error mechanisms.
- Use functional techniques pragmatically; follow the language and codebase conventions and avoid abstraction for its own sake.

## Git and changes

- Do not commit or push unless the user explicitly asks.
- Before committing, review the diff and stage only files related to the request.
- Use Conventional Commits: `type(scope): summary`.
- Use a three-line commit message: line 1 is the Conventional Commit summary, line 2 is blank, and line 3 briefly states the reason or user-visible impact.
- Keep `type(scope)` in English for tooling compatibility, but write the summary and reason in Japanese.
- Keep the summary concise and written as an action; use a scope when it improves clarity.
- Prefer these types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `build`, `ci`, `perf`, `style`, and `revert`.
- Example:
  ```text
  fix(aerospace): Finderをフローティング表示にする

  Finderが通常のアプリと一緒にタイル配置されるのを防ぐ。
  ```
- Never include secrets, tokens, credentials, or private session data in the repository.

## Destructive actions

- Confirm the exact target before deleting, resetting, or overwriting anything.
- Prefer reversible operations when possible.

## Workstation-specific setup

- When working on this dotfiles repository or user-level configuration, use mise to manage dotfiles and tasks.
- Do not introduce or use chezmoi for this workstation's setup or synchronization.
