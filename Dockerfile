# wokku-hermes-agent — Hermes Agent (Nous Research) adapted for wokku / Dokku.
#
# Upstream ships an s6-overlay image meant for `network_mode: host` + an
# interactive `hermes setup`. This image adapts it for a managed-Dokku
# one-click deploy:
#   - dashboard runs as the always-up main process, bound 0.0.0.0:9119,
#     auth-protected (NOT --insecure), routed to the app's *.wokku.app domain;
#   - the gateway (agent + messaging connectors, e.g. Telegram) runs as a
#     SUPERVISED s6 service so it can't crash-loop the container;
#   - first-boot seeds a minimal config.yaml from $HERMES_MODEL if provided.
#
# Pinned to an upstream CalVer tag — bump deliberately (see CLAUDE.md).
FROM nousresearch/hermes-agent:v2026.6.19

# Enable the gateway s6 service (our added service reads this). The dashboard
# runs as CMD, so we do NOT enable the s6 dashboard service (avoids a double
# dashboard). Dashboard binds 0.0.0.0:9119; Dokku routes the domain to it.
ENV HERMES_GATEWAY=1 \
    HERMES_DASHBOARD_HOST=0.0.0.0 \
    HERMES_DASHBOARD_PORT=9119

# Our additions: the supervised gateway service + the first-boot config seed.
COPY rootfs/ /

# Dokku routes http/https → this port (the auth-protected dashboard).
EXPOSE 9119

# The dashboard is the long-running main process (keeps the container healthy
# and is the web URL); the gateway runs alongside under s6.
CMD ["dashboard", "--host", "0.0.0.0", "--port", "9119"]
