FROM node:18-alpine
WORKDIR /app
COPY package.json bin/ lib/ skills/ LICENSE README.md ./
RUN ln -s /app/bin/tezgah.js /usr/local/bin/tezgah
ENTRYPOINT ["node", "/app/bin/tezgah.js"]
CMD ["help"]
