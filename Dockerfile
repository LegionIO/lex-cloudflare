FROM legionio/legion

COPY . /usr/src/app/lex-cloudflare

WORKDIR /usr/src/app/lex-cloudflare
RUN bundle install
