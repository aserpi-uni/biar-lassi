# Istruzioni per l'uso
I passi per avviare il server usando Intellij IDEA o RubyMine da zero sono:
1. avviare il server MYSQL
2. creare l'utente `tesi` con la password desiderata
3. avviare l'IDE
4. clonare la repository localmente
5. creare la configurazione:
   * tipologia: `Rails`
   * IP address: `127.0.0.1`
   * aggiungere la variabile d'ambiente `TESI_DATABASE_PASSWORD` con la password impostata precedentemente
6. apire un terminale e:
   1. caricare la variabile d'ambiente `TESI_DATABASE_PASSWORD` con la password impostata precedentemente
   2. caricare la variabile d'ambiente `SUPER_PASSWORD` con la password scelta per `SuperAdmin`
   3. caricare la variabile d'ambiente `SUPER_EMAIL` con l'email scelta per `SuperAdmin`
   4. `bin/rake db:setup`
7. avviare il server premendo il tasto `Debug` o premendo `Shift + F9`


Se invece si devono solo eseguire modifiche incrementali si deve eseguire in
un terminale:
1. caricare la variabile d'ambiente `TESI_DATABASE_PASSWORD`
2. `bin/rake db:migrate`
