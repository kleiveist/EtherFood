[← Documentation hub](../index.md)

# Documentation media

This directory stores documentation media and editable sources without adding a
publishing-platform dependency.

## Rules

- Embed images and diagrams through relative paths.
- Use lowercase English filenames in kebab-case.
- Store editable source files under [`source/`](source/README.md).
- Store exported images under [`images/`](images/README.md).
- Store diagram sources and exports under [`diagrams/`](diagrams/README.md).
- Prefer Mermaid for simple system flows that remain readable in Markdown.
- Excalidraw sources may be stored together with corresponding SVG or PNG
  exports.
- Do not commit large videos without an explicitly approved media strategy.
- Every video must record at least its date, build or concept version, and a
  description in [`videos/`](videos/README.md).
- Do not add media dependencies or Git LFS configuration as part of the current
  documentation restructure.

Do not create binary placeholder files. Use the German
[media entry template](../de/templates/media-entry-template.md) to record
purpose, provenance, license, and related documents.
