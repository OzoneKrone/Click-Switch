# 🛒 eCommerce Web Application – Tecnologie Software Web

Questo progetto è stato sviluppato come parte del corso di **Tecnologie Software Web** presso l'Università di Salerno (Fisciano). L'applicazione è un sito di e-commerce completo, progettato per essere **dinamico**, **responsive**, con **persistenza dei dati** e **interfacce distinte per utenti e amministratori**.

---

## 📌 Funzionalità principali

### 👤 Utente
- Registrazione e login
- Navigazione del catalogo prodotti
- Aggiunta, modifica e rimozione di prodotti dal carrello
- Acquisto con generazione ordine e dettaglio ricevuta
- Visualizzazione storico ordini

### 🛠️ Amministratore
- Login e dashboard riservata
- Inserimento, modifica e cancellazione prodotti
- Gestione immagini prodotto
- Visualizzazione ordini filtrabili per cliente o data

---

## 🗂️ Architettura

Il progetto segue il pattern **MVC** ed è organizzato nei seguenti package:
- `model`: classi Java per il modello dei dati (JavaBeans, DAO)
- `control`: Servlet per la gestione della logica di controllo
- `view`: Pagine JSP per la presentazione

Altri elementi chiave:
- Connessione al database via **JDBC** (DriverManager)
- DAO pattern per l’accesso ai dati
- **Session token** per la gestione degli accessi
- Uso di **AJAX** per alcune funzionalità asincrone
- Controllo input con **JavaScript** + **Espressioni Regolari**

---

## 🧱 Tecnologie utilizzate

- **Java EE** (Servlet, JSP)
- **HTML5 / CSS3 / JavaScript**
- **AJAX**
- **MySQL**
- **Apache Tomcat**
- **Git**

---

## 🖼️ Interfaccia grafica

- Layout responsive con CSS personalizzato
- Uso di **frammenti JSP** per header e footer
- Organizzazione risorse:
  - `/styles` → Fogli di stile
  - `/scripts` → JavaScript esterni
  - `/images` → Immagini prodotto

---

## 🔒 Sicurezza & Validazioni

- Controllo accessi su tutte le pagine riservate
- Validazione client-side con JavaScript
- Focus automatico sui campi attivi
- Gestione errori e feedback utente via DOM

---

## 📐 Database

Il database è progettato secondo uno **schema ER normalizzato** e include:
- Tabelle per utenti, prodotti, ordini, dettagli ordini
- Meccanismi per:
  - Mantenere il prezzo storico degli ordini
  - Gestire la rimozione logica dei prodotti (senza perdere la cronologia)

---

## 🧪 Ambiente di produzione

Il progetto è stato testato in ambiente di produzione su Tomcat, come richiesto dall’esame, ed è **pronto per la demo finale**.

