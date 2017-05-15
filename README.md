# Istruzioni per l'uso

Installazione:
1. avviare il server MySQL
2. creare un utente con la password desiderata
3. concedere all'utente i privilegi sui database `Tesi_development`, `Tesi_production` e `Tesi_test`
4. clonare la repository localmente
5. apire un terminale e:
   1. caricare le variabili d'ambiente:
       * `DB_PASSWORD` con la password impostata precedentemente
       * `DB_USER` con l'username impostato precedentemente
       * `SUPER_EMAIL` con l'email scelta per `SuperAdmin`
       * `SUPER_PASSWORD` con la password scelta per `SuperAdmin`
   2. `bin/rake db:setup`

Per avviare il server attraverso Intellij IDEA o RubyMine è necessario creare la configurazione:
   * tipologia: `Rails`
   * IP address: `127.0.0.1`
   * Environment: `development` o `production` a seconda dei casi
   * impostare le variabili d'ambiente:
       * `DB_PASSWORD` con la password impostata precedentemente
       * `DB_USER` con l'username impostato precedentemente
       * `DEVISE_SECRET` con la key usata da Devise (necessaria solo per avviare il server in
       modalità `production`)
       * `FACEBOOK_APP_ID` con l'id fornito da Facebook
       * `FACEBOOK_SECRET` con il token fornito da Facebook
       * `HOST` con l'host del server
       * `SECRET_KEY_BASE` con la chiave base (necessaria solo per avviare ilm erver in modalità
       `production`)
       * `TESI_MAILER_TOKEN` con il token fornito da SendGrid
Se si vuole utilizzare la riga di comando è necessario caricare tutte le variabili d'ambiente
manualmente.


Per aggiornare lo schema del database si devono caricare in un terminale le variabili d'ambiente
`DB_PASSWORD` e `DB_USER` ed eseguire `bin/rake db:migrate`.

Per eseguire i test attraverso Intellij IDEA 0 RubyMine è necessario cliccare con il tasto destro
sulla cartella `features`, dal menù `Run` scegliere la voce con il simbolo di Cucumber
(la scritta può variare), nella configurazione creatasi aggiungere le variabili d'ambiente
`DB_PASSWORD`, `DB_USER` e `HOST`.
Per eseguire i test da terminale si deve caricare le variabili d'ambiente `DB_PASSWORD` e
`DB_USER` ed eseguire `bin/bundle exec cucumber`.
