# wokku-hermes-agent

[Hermes Agent](https://github.com/nousresearch/hermes-agent) (Nous Research's open-source self-hosted AI agent) adapted for one-click deploy on **[wokku](https://wokku.cloud)** (managed Dokku).

Thin adapter over the published upstream image (`nousresearch/hermes-agent`): runs the **auth-protected dashboard** on the app's domain and the **agent gateway** (Telegram & other connectors) as a supervised service, configured entirely from environment variables.

Deployed via the **Hermes Agent** template in the wokku gallery — you don't run this repo directly; wokku builds it for you.

- **Required:** an LLM key (`OPENROUTER_API_KEY`) + `HERMES_MODEL`.
- **Default connector:** Telegram (`TELEGRAM_BOT_TOKEN`).
- **Resources:** Medium box (1 GB) min, Large (2 GB) recommended, + a persistent volume.

See `CLAUDE.md` for the architecture, config, and how to bump the pinned upstream version.

Hermes Agent is AGPL/open-source by Nous Research; this repo only adds Dokku packaging.
