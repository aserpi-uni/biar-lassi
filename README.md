# Istruzioni per l'uso
[![Build Status](https://travis-ci.org/aserpi/Tesi.svg?branch=master)](https://travis-ci.org/aserpi/Tesi)
[![Coverage Status](https://coveralls.io/repos/github/aserpi/Tesi/badge.svg?branch=master)](https://coveralls.io/github/aserpi/Tesi?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/beab3c583232e7da96d9/maintainability)](https://codeclimate.com/github/aserpi/Tesi/maintainability)

Installazione:
1. avviare il server PostgreSQL;
2. creare un superuser con la password desiderata
3. clonare la repository localmente
4. apire un terminale e:
   1. caricare le variabili d'ambiente:
       * `DB_PASSWORD` con la password impostata precedentemente
       * `DB_USER` con l'username impostato precedentemente
       * `SUPER_EMAIL` con l'email scelta per `Super@admin`
       * `SUPER_PASSWORD` con la password scelta per `Super@admin`
   2. `bin/rake db:setup`

Per avviare il server attraverso Intellij IDEA o RubyMine è necessario creare la configurazione:
   * tipologia: `Rails`
   * IP address: `127.0.0.1`
   * Environment: `development` o `production` a seconda dei casi
   * impostare le variabili d'ambiente:
       * `DB_PASSWORD` con la password impostata precedentemente
       * `DB_USER` con l'username impostato precedentemente
       * `FACEBOOK_APP_ID` con l'id fornito da Facebook
       * `FACEBOOK_SECRET` con il token fornito da Facebook
       * `HOST` con l'host del server
       * `RESERVED_NAMES` con tutti gli username riservati dal sistema
       * `SENDGRID_APIKEY` con il token fornito da SendGrid
Se si vuole utilizzare la riga di comando è necessario caricare tutte le variabili d'ambiente
manualmente.


Per aggiornare lo schema del database si devono caricare in un terminale le variabili d'ambiente
`DB_PASSWORD` e `DB_USER` ed eseguire `bin/rake db:migrate`.

Per eseguire i test attraverso Intellij IDEA o RubyMine è necessario cliccare con il tasto destro
sulla cartella `features`, dal menù `Run` scegliere la voce con il simbolo di Cucumber
(la scritta può variare), nella configurazione creatasi aggiungere le variabili d'ambiente
`DB_PASSWORD`, `DB_USER` e `HOST`.
Per eseguire i test da terminale si deve caricare le variabili d'ambiente ed eseguire `bin/bundle exec cucumber`.
