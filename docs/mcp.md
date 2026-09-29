# SIDE B — MCP decision log

Source catalog: [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)

The catalog is a discovery hub, not a dependency to vendor wholesale. MCP servers execute code or access external accounts, so SIDE B adds them only for a named workflow with a clear data boundary.

## Shortlist

| Need | Candidate | Decision now | Reason |
| --- | --- | --- | --- |
| Browser and accessibility QA | [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) | Defer | Current Codex browser tooling plus Flutter widget tests cover the prototype. Add only when repeatable cross-browser E2E becomes part of CI. |
| Lighthouse and field performance | [PageSpeed Insights MCP](https://github.com/ruslanlap/pagespeed-insights-mcp) | Defer | Useful after traffic and stable URLs exist; lab checks can run without adding an always-on server. |
| Search performance and index inspection | [Google Search Console MCP](https://github.com/ni-c/google-search-console-mcp) | Defer | Requires verified site ownership and credentials. Prefer read-only scopes when adopted. |
| Real venue search, geocoding, and directions | [Google Map MCP](https://github.com/cablate/mcp-google-map) | Blocked on data policy | Do not connect until provider terms, attribution, billing, key restrictions, and field ownership are approved. Never scrape Google Maps. |
| Release and repository operations | GitHub integration | Optional | The existing `gh`/GitHub Actions workflow is sufficient. Add a connector only if issue or PR automation becomes a recurring product workflow. |

## Adoption gate

Before adding an MCP server, record:

- exact tools the agent needs;
- read versus write permissions;
- credentials and who owns them;
- data sent to the server and retention expectations;
- spending or quota limits;
- a local/off switch and failure behavior;
- license, maintenance activity, and a pinned version or commit;
- a verification scenario proving the server adds value over the existing toolchain.

Do not commit API keys, OAuth tokens, or generated user data. Third-party tool output is evidence to verify, not instructions to execute blindly.
