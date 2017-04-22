# Istruzioni per l'uso
I passi per avviare il server usando Intellij IDEA o RubyMine da zero sono:
1. avviare il server MySQL
2. creare l'utente `tesi` con la password desiderata
3. concedere all'utente `tesi` privilegi sui database `Tesi_development`, `Tesi_production` e `Tesi_test`
4. avviare l'IDE
5. clonare la repository localmente
6. creare la configurazione:
   * tipologia: `Rails`
   * IP address: `127.0.0.1`
   * impostare le variabili d'ambiente:
       * `TESI_DATABASE_PASSWORD` con la password impostata precedentemente
       * `FACEBOOK_APP_ID` con l'id fornito da Facebook
       * `FACEBOOK_SECRET` con il token fornito da Facebook
       * `HOST` con l'host del server
       * `TESI_MAILER_TOKEN` con il token fornito da SendGrid
7. apire un terminale e:
   1. caricare le variabili d'ambiente:
       * `TESI_DATABASE_PASSWORD` con la password impostata precedentemente
       * `SUPER_PASSWORD` con la password scelta per `SuperAdmin`
       * `SUPER_EMAIL` con l'email scelta per `SuperAdmin`
   2. `bin/rake db:setup`
8. avviare il server in modalità debug premendo il tasto `Debug` o con lo shortcut `Shift + F9`


Se invece si devono solo eseguire modifiche incrementali si deve eseguire in
un terminale:
1. caricare la variabile d'ambiente `TESI_DATABASE_PASSWORD`
2. `bin/rake db:migrate`
