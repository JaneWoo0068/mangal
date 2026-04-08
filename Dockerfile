FROM alpine:latest

ENV KOMA_DOWNLOADER_PATH=/downloads
ENV KOMA_USER=abc
ENV KOMA_UID=1000
ENV KOMA_GID=1000

WORKDIR "/config"
RUN mkdir -p "${KOMA_DOWNLOADER_PATH}" && addgroup -g "${KOMA_GID}" "${KOMA_USER}" && adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "${KOMA_USER}" \
    --no-create-home \
    --uid "${KOMA_UID}" \
    "${KOMA_USER}" && \
    chown abc:abc /config "${KOMA_DOWNLOADER_PATH}"

COPY koma /usr/local/bin/koma
RUN chmod +x /usr/local/bin/koma
USER "${KOMA_USER}"
ENTRYPOINT ["/usr/local/bin/koma"]
