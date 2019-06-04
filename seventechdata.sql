-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Giu 04, 2019 alle 08:55
-- Versione del server: 10.1.37-MariaDB
-- Versione PHP: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seventechdata`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `caratteristiche`
--

CREATE TABLE `caratteristiche` (
  `id` int(11) NOT NULL,
  `idProdotto` int(11) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `valore` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `caratteristiche`
--

INSERT INTO `caratteristiche` (`id`, `idProdotto`, `tipo`, `valore`) VALUES
(1, 1, 'Hot New Arrivals', ''),
(2, 2, 'Hot Best Sellers', ''),
(3, 1, 'Banner 2', ''),
(4, 2, 'Trend 2019', ''),
(5, 25, 'Hot New Arrivals', ''),
(6, 26, 'Hot New Arrivals', ''),
(7, 10, 'Hot New Arrivals', ''),
(8, 19, 'Hot New Arrivals', ''),
(9, 8, 'Hot New Arrivals', ''),
(10, 14, 'Hot New Arrivals', ''),
(11, 11, 'Hot New Arrivals', ''),
(12, 26, 'Hot New Arrivals', ''),
(13, 3, 'Hot New Arrivals', ''),
(14, 20, 'Hot New Arrivals', ''),
(15, 24, 'Hot Best Sellers', ''),
(16, 5, 'Hot Best Sellers', ''),
(17, 23, 'Hot Best Sellers', ''),
(18, 22, 'Hot Best Sellers', ''),
(19, 7, 'Hot Best Sellers', ''),
(20, 1, 'Hot Best Sellers', ''),
(21, 6, 'Hot Best Sellers', ''),
(22, 12, 'Hot Best Sellers', ''),
(23, 21, 'Hot Best Sellers', ''),
(24, 18, 'Hot Best Sellers', ''),
(25, 7, 'Banner 2', ''),
(26, 2, 'Banner 2', ''),
(27, 17, 'Trend 2019', ''),
(28, 21, 'Trend 2019', ''),
(29, 13, 'Trend 2019', ''),
(30, 16, 'Trend 2019', ''),
(31, 26, 'Trend 2019', ''),
(32, 24, 'Trend 2019', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `carrello`
--

CREATE TABLE `carrello` (
  `id` int(11) NOT NULL,
  `idUtente` int(11) NOT NULL,
  `idProdotto` int(11) NOT NULL,
  `quantita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`id`, `idUtente`, `idProdotto`, `quantita`) VALUES
(6, 2, 14, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `categorie`
--

CREATE TABLE `categorie` (
  `idCategoria` int(11) NOT NULL,
  `nomeCategoria` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `categorie`
--

INSERT INTO `categorie` (`idCategoria`, `nomeCategoria`) VALUES
(1, 'Smartphone'),
(2, 'Tablet'),
(3, 'Smartwatch'),
(4, 'Accessori'),
(5, 'Audio/Video'),
(6, 'Fotografia');

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE `ordine` (
  `idOrdine` int(11) NOT NULL,
  `idUtente` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `totale` float NOT NULL,
  `indirizzoSpedizione` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `ordine`
--

INSERT INTO `ordine` (`idOrdine`, `idUtente`, `data`, `totale`, `indirizzoSpedizione`) VALUES
(1, 2, '2019-05-27 00:00:00', 300, 'Via Roma 17, TN 38123'),
(2, 2, '2019-05-26 00:00:00', 250, 'Via Roma 17, TN 38123');

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `prezzo` decimal(10,0) NOT NULL,
  `prezzoScontato` decimal(10,0) NOT NULL,
  `descrizione` text NOT NULL,
  `foto1` text NOT NULL,
  `foto2` text NOT NULL,
  `foto3` text NOT NULL,
  `foto4` text NOT NULL,
  `data` datetime NOT NULL,
  `categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`id`, `nome`, `prezzo`, `prezzoScontato`, `descrizione`, `foto1`, `foto2`, `foto3`, `foto4`, `data`, `categoria`) VALUES
(1, 'IPhone 7', '350', '300', 'Apple iPhone 7 Nero (Nero Opaco) 128GB (Ricondizionato)', 'images/iphone7a.jpg', 'images/iphone7b.jpg', 'images/iphone7c.jpg', '', '2019-05-22 00:00:00', 1),
(2, 'Samsung Galaxy S9', '899', '505', 'Samsung Galaxy S9 Smartphone, Blu/Coral Blue, Display 5.8\", 64 GB Espandibili, Dual SIM [Versione Italiana]', 'images/s9a.jpg', 'images/s9b.jpg', 'images/s9c.jpg', 'images/s9d.jpg', '2019-05-27 00:00:00', 1),
(3, 'Huawei P30', '600', '530', 'Huawei P30 15,5 cm (6.1\") 6 GB 128 GB Dual SIM ibrida 4G Nero 3650 mAh', 'images/P30a.jpg', 'images/P30b.jpg', 'images/P30c.jpg', '', '2019-05-22 00:00:00', 1),
(4, 'Samsung Galaxy A7 ', '499', '220', 'Samsung Galaxy A7 Smartphone, 64 GB, Dual SIM, Nero [Versione Italiana]', 'images/a7a.jpg', 'images/a7b.jpg', 'images/a7c.jpg', '', '2019-05-22 00:00:00', 1),
(5, 'Wiko Jerry 3', '89', '75', 'Wiko Jerry 3 Smartphone, 16 GB, Cherry Red [Italia]', 'images/wika.jpg', 'images/wikb.jpg', 'images/wikc.jpg', '', '2019-05-27 00:00:00', 1),
(6, ' Tablet WiFi, CPU Quad-', '200', '120', 'Huawei Mediapad T3 Tablet WiFi, CPU Quad-Core A53, 2 GB RAM, 16 GB, Display da 10\",', 'images/tabhwa.jpg', 'images/tabhwb.jpg', 'images/tabhwc.jpg', '', '2019-05-27 00:00:00', 2),
(7, 'iPad mini 4 Wi-Fi 128GB', '599', '400', 'iPad mini 4 Wi-Fi 128GB', 'images/ipa.jpg', 'images/ipb.jpg', 'images/ipc.jpg', 'images/ipd.jpg', '2019-05-21 00:00:00', 2),
(8, 'Samsung Galaxy Tab S5e', '799', '350', 'Samsung Galaxy Tab S5e (2019) Tablet, 10.5\" SuperAMOLED, 64 GB Espandibili, Batteria 7040 mAh, Ricarica Rapida, LTE, Black, [Versione Italiana]', 'images/tab5ea.jpg', 'images/tab5eb.jpg', 'images/tab5ec.jpg', 'images/tab5ed.jpg', '2019-05-16 00:00:00', 2),
(9, 'Lenovo Tab E10', '250', '140', 'Lenovo Tab E10 25,5 cm (10, 1 pollici HD IPS Touch) Tablet PC (Qualcomm APQ8009 Quad-Core, 2 GB RAM, 32 GB eMCP, Wi-Fi, Android 8.1)', 'images/lene10a.jpg', 'images/lene10b.jpg', 'images/lene10c.jpg', '', '2019-05-01 00:00:00', 2),
(10, 'ASUS ZenPad 10', '699', '550', 'ASUS ZenPad 10 Z301MFL-1B009A tablet Mediatek MT8735A 32 GB 3G 4G', 'images/asa.jpg', 'images/asb.jpg', 'images/asc.jpg', '', '2019-04-23 00:00:00', 2),
(11, 'EsportsMJJ', '89', '49', 'sportsMJJ Da Polso Smart Watch Sport Fitness Impermeabile Bluetooth Orologio Per iPhone Ios Android Di Samsung Xiaomi-Nero', 'images/sportsMJJa.jpg', 'images/sportsMJJb.jpg', 'images/sportsMJJc.jpg', '', '2019-05-08 00:00:00', 3),
(12, 'Samsung Gear S3 Frontier Front', '499', '179', 'Samsung Gear S3 Frontier Smartwatch, Display 1.3\" SAMOLED, Memoria Interna 4 GB, 768 MB RAM', 'images/gear3a.jpg', 'images/gear3b.jpg', 'images/gear3c.jpg', 'images/gear3d.jpg', '2019-05-26 00:00:00', 3),
(13, 'Asus VivoWatch', '230', '130', 'Asus VivoWatch Orologio da Fitness, Cardiofrequenzimetro, Durata Batteria Fino a 10 Giorni', 'images/asusa.jpg', 'images/asusb.jpg', 'images/asusc.jpg', '', '2019-05-13 00:00:00', 3),
(14, 'Smartwatch e Fitness Orologio ', '15', '13', 'Smartwatch e Fitness Orologio Uomo Bracciale Orologio Sport Smart Orologio Digitale Multifunzione Polso Fitness Orologio Bluetooth Frequenza Cardiaca Fitness Braccialetto Orologio Digitale Uomo NBAA', 'images/faka.jpg', 'images/fakb.jpg', '', '', '2019-05-09 00:00:00', 3),
(15, 'Apple Watch Series 4', '499', '359', 'Apple Watch Series 4 smartwatch Grigio OLED GPS (satellitare)', 'images/apwa.jpg', 'images/apwb.jpg', '', '', '2019-05-08 00:00:00', 3),
(16, 'Custodia a Samsung Galaxy s9', '19', '9', 'CIRRYS Custodie Custodia a Samsung Galaxy s9 Case Cover originale a 360 gradi Protezione Leggero Bumper Protettiva Caso+Non incluso Proteggi schermo - Nero rosso', 'images/cosa.jpg', 'images/cosb.jpg', 'images/cosc.jpg', '', '2019-05-08 00:00:00', 4),
(17, 'Cinturino in Pelle', '39', '29', 'Cinturino in vera pelle gear s3 frontier - globalqi-electron -  Cinturino in Pelle con Stampa a Coda Rotonda', 'images/cpsa.jpg', '', '', '', '2019-03-06 00:00:00', 4),
(18, 'Pellicola Protettiva Iphone7', '15', '8', 'SUERW [3-Pack] Pellicola Protettiva Compatibile per iPhone 8/7 Pellicola Vetro Temperato, Anti-graffio, Anti-Olio, Anti-Bolle [0,25 mm, Durezza 9H, 3D Touch]', 'images/plia.jpg', 'images/plib.jpg', 'images/plic.jpg', 'images/plid.jpg', '2019-05-01 00:00:00', 4),
(19, 'Logitech Powerplay', '149', '110', 'Logitech Powerplay Tappetino per Mouse con Sistema di Ricarica Wireless, per Logitech G903 e G703', 'images/lga.jpg', 'images/lgb.jpg', 'images/lgc.jpg', '', '2019-05-05 00:00:00', 4),
(20, ' Cavo USB Type-C', '9', '6', 'Rampow Cavo USB Type-C [ Carica Rapida 3A ] Cavo Tipo C Compatibile per Samsung S9 / Note 8 / S8, Huawei P10 / P9, Xiaomi, Google Chromebook Pixel ed Dispositivi USB C - 1M/3,3ft, Grigio Siderale', 'images/cca.jpg', 'images/ccb.jpg', 'images/ccc.jpg', 'images/ccd.jpg', '2019-05-08 00:00:00', 4),
(21, 'Trust Leto', '9', '7', 'Trust Leto Set Altoparlanti 2.0, Nero', 'images/tra.jpg', 'images/trb.jpg', 'images/trc.jpg', '', '2019-05-01 00:00:00', 5),
(22, 'Razer Nommo Pro', '499', '400', 'Razer Nommo Pro THX Certified Premium Audio, Dolby Virtual Surround Sound, Subwoofer con Accensione verso il Basso, Alimentato da Razer Chroma, Altoparlanti da Gioco per PC', 'images/raza.jpg', 'images/razb.jpg', 'images/razc.jpg', '', '2019-05-12 00:00:00', 5),
(23, 'Samsung U28H750', '499', '299', 'Samsung U28H750 Monitor 4K Ultra HD 28\'\', UHD, 3840 x 2160, Premium Quantum Dot, 1.07 Miliardi di Colori, 60 Hz, 1 ms, 2 HDMI, 1 Display Port, Base Semplice, Nero', 'images/mosa.jpg', 'images/mosb.jpg', 'images/mosc.jpg', 'images/mosd.jpg', '2019-05-01 00:00:00', 5),
(24, 'Acer Predator Z650', '1399', '1020', 'Acer Predator Z650 Proiettore, Risoluzione Full HD, Connessione HDMI, VGA, MHL, USB, DLP 3D, Contrasto 20.000:1', 'images/praa.jpg', 'images/prab.jpg', 'images/prac.jpg', 'images/prad.jpg', '2019-05-02 00:00:00', 5),
(25, 'Nikon D3500', '600', '450', 'Nikon D3500 Fotocamera Reflex Digitale con Obiettivo Nikkor AF-P 18/55VR, 24.2 Megapixel, LCD 3\", SD da 16 GB 300x Premium Lexar,[Nital Card: 4 Anni di Garanzia]', 'images/nika.jpg', 'images/nikb.jpg', 'images/nikc.jpg', '', '2019-02-12 00:00:00', 6),
(26, 'Canon EOS 4000D', '499', '235', 'Canon Italia EOS 4000D + EF-S DC III Fotocamera Reflex, Lunghezza Focale 18-55 mm', 'images/caa.jpg', 'images/cab.jpg', 'images/cac.jpg', '', '2019-03-06 00:00:00', 6);

-- --------------------------------------------------------

--
-- Struttura della tabella `storico`
--

CREATE TABLE `storico` (
  `id` int(11) NOT NULL,
  `idOrdine` int(11) NOT NULL,
  `idProdotto` int(11) NOT NULL,
  `quantita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `storico`
--

INSERT INTO `storico` (`id`, `idOrdine`, `idProdotto`, `quantita`) VALUES
(1, 1, 2, 1),
(2, 1, 24, 1),
(3, 2, 20, 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(30) NOT NULL,
  `numeroTelefono` int(11) DEFAULT NULL,
  `indirizzo` varchar(30) DEFAULT NULL,
  `numeroCartaDiCredito` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `nome`, `cognome`, `username`, `password`, `email`, `numeroTelefono`, `indirizzo`, `numeroCartaDiCredito`) VALUES
(2, 'mario', 'rossi', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'admin@gmail.com', NULL, 'Via Roma 17, TN 38123', NULL),
(8, 'client', 'client', 'client', '23eacca368b0620d532a2aa3ee501eeac9003667', 'client@gmail.com', NULL, NULL, NULL);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `caratteristiche`
--
ALTER TABLE `caratteristiche`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idProdotto` (`idProdotto`);

--
-- Indici per le tabelle `carrello`
--
ALTER TABLE `carrello`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUtente` (`idUtente`),
  ADD KEY `idProdotto` (`idProdotto`);

--
-- Indici per le tabelle `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indici per le tabelle `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`idOrdine`),
  ADD KEY `utente` (`idUtente`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria` (`categoria`);

--
-- Indici per le tabelle `storico`
--
ALTER TABLE `storico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idOrdine` (`idOrdine`),
  ADD KEY `idProdotto` (`idProdotto`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `caratteristiche`
--
ALTER TABLE `caratteristiche`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT per la tabella `carrello`
--
ALTER TABLE `carrello`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `categorie`
--
ALTER TABLE `categorie`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `ordine`
--
ALTER TABLE `ordine`
  MODIFY `idOrdine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT per la tabella `storico`
--
ALTER TABLE `storico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `caratteristiche`
--
ALTER TABLE `caratteristiche`
  ADD CONSTRAINT `caratteristiche_ibfk_1` FOREIGN KEY (`idProdotto`) REFERENCES `prodotti` (`id`);

--
-- Limiti per la tabella `carrello`
--
ALTER TABLE `carrello`
  ADD CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`id`),
  ADD CONSTRAINT `carrello_ibfk_2` FOREIGN KEY (`idProdotto`) REFERENCES `prodotti` (`id`);

--
-- Limiti per la tabella `ordine`
--
ALTER TABLE `ordine`
  ADD CONSTRAINT `utente` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`id`);

--
-- Limiti per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  ADD CONSTRAINT `categoria` FOREIGN KEY (`categoria`) REFERENCES `categorie` (`idCategoria`);

--
-- Limiti per la tabella `storico`
--
ALTER TABLE `storico`
  ADD CONSTRAINT `idOrdine` FOREIGN KEY (`idOrdine`) REFERENCES `ordine` (`idOrdine`),
  ADD CONSTRAINT `idProdotto` FOREIGN KEY (`idProdotto`) REFERENCES `prodotti` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
