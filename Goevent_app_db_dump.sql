-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Ápr 07. 20:30
-- Kiszolgáló verziója: 10.4.27-MariaDB
-- PHP verzió: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `event`
CREATE DATABASE event;
--

-- --------------------------------------------------------
USE event;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `eventproperties`
--

CREATE TABLE `eventproperties` (
  `id` int(11) NOT NULL,
  `name` varchar(35) NOT NULL,
  `date` datetime NOT NULL,
  `category` varchar(30) NOT NULL,
  `agelimit` int(3) DEFAULT NULL,
  `loc_id` int(11) DEFAULT NULL,
  `url_link` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `eventproperties`
--

INSERT INTO `eventproperties` (`id`, `name`, `date`, `category`, `agelimit`, `loc_id`, `url_link`, `description`) VALUES
(38, 'Szombathelyi Haladás - ETO FC Győr', '2023-04-09 17:00:00', 'Sport', 0, 46, 'https://upload.wikimedia.org/wikipedia/commons/f/fd/Szombathelyi_Halad%C3%A1s_stadion_-_l%C3%A9gi_fot%C3%B3.jpg', 'szurkolj kedvenc csapatodnak az NB2 meccsein.'),
(40, 'Fermentálás workshop', '2023-06-03 17:00:00', 'Egyéb kategória', 0, 48, 'https://gyogyszernelkul.com/wp-content/uploads/2015/01/fermentalt-elelmiszerek-miert-hasznosak.jpg', 'Mi is az a fermentálás? Ősi tartósítási eljárás, mely által erősítheted az immunrendszered, javíthatod az emésztésed, és még a hangulatodra is jótékony hatással lesz. A workshop során a fermentálás elméletével és gyakorlatával fogunk megismerkedni, illetv'),
(42, 'Ágfalvi csata emlékséta', '2023-09-08 20:00:00', 'Zene (koncert)', 0, 50, 'https://www.visitsopron.com/msite/197/tematikus_seta_agfalva.2.jpg', 'Támadhatnak minket jobbról, támadhatnak minket balról, mi akkor is megemlékezünk a Sopron városát az osztrák megszállástól megmentő második ágfalvi csatáról!\r\n\r\nEzért neveztük el mozgalmunkat a csata egyik parancsnokáról, a Kárpátok kommandósáról, Madersp'),
(43, 'NEMZET-KÖZTI MAGYAR FOTÓS', '2023-03-11 09:00:00', 'Egyéb kategória', 0, 51, 'https://budapeste.yee.org.tr/sites/default/files/galeri/190321_bpf_yunusemre-46.jpg', 'A jól komponált, igényes technikával készült fotók hűen mutatják be a pannon táj természeti szépségeit, a nemzeti kultúránk gazdagságát, az emberközpontú fotográfia szépségét, humánumát. Ha mondhatjuk, hogy a fotózás korunk népművészete, akkor azt látható'),
(44, 'A gyáva c. színdarab', '2023-07-10 17:00:00', 'Film', 16, 52, 'https://nezomuveszeti.hu/sites/default/files/eloadas-galeria/ordogkat11_gyava_1.jpg', 'A Nézőművészeti Kft. és a Manna Kulturális Egyesület közös előadása, 60 perc, szünet nélkül. Az előadást a középiskolás korosztálynak 14 éves kortól ajánljuk.\r\n\r\nEgy fiatal fiú mesél a gondolatairól, érzéseiről, a családjával lévő ellentmondásos kapcsolat'),
(45, ' Janklovics Péter önálló ', '2023-06-17 18:00:00', 'Egyéb kategória', 18, 53, 'https://pathalia.hu/files/img/d20397214626ff5b2239ad2c9f365624.jpg', 'Dumaszínház est.\r\n\r\nVajon mi viszi az embert arra, hogy a vészjósló szülői ábrázatok ellenére és egy valamirevaló béterv nélkül, ellenben kínkeserves munka árán megtanuljon egy mesterséget, a színészetet, hogy aztán reményekkel telve, megveszekedett türel'),
(59, 'Borkóstoló Bock Valérral', '2023-06-06 18:00:00', 'Egyéb kategória', 18, 66, 'https://hellogyor.hu/wp-content/themes/yootheme/cache/Borkostolo-Bock-Valerral_hellogyor-62867539.webp', 'lyen még nem volt! Április 6-ai kóstolónkra Bock Valért hívtuk el, hogy bemutassa Nektek saját sorozatát a Bock Pincészeten belül és meséljen a borászat mindennapjairól, Édesapjával való közös munkáról, munkamegosztásról.'),
(60, 'Áprilisi Gyermekkuckó', '2023-04-14 14:00:00', 'Egyéb kategória', 0, 67, 'https://hellogyor.hu/wp-content/themes/yootheme/cache/202304_Aprilis_Gyermekkucko_hellogyor-4075d8d0.webp', '14:00 Társasjáték\n17:00 és 19:45 Kézműves foglalkozás – Készítsünk robotot! '),
(61, 'RÁBARANGOLÁS', '2023-05-31 17:00:00', 'Kultúra', 16, 68, 'https://hellogyor.hu/wp-content/themes/yootheme/cache/Vendegsegben-45d06c67.webp', 'Kezdődjön új programunk egy kis időutazással! Először egy rövid séta során az elmúlt évszázad fordulóját, a város régi képét és a polgári élet történeteit elevenítjük\nA program részvételi díja, ami egy kávé, tea elfogyasztását is tartalmazza: 4.000,- Ft\n\n'),
(62, 'Litera-Túra', '2023-05-20 16:30:00', 'Irodalom', 16, 69, 'https://hellogyor.hu/wp-content/themes/yootheme/cache/Litera-Tura-2c0aa5fb.webp', 'Különleges “irodalomóra” részesei lehetnek vendégeink a Költészet Napja alkalmából.\nEzzel a programmal az irodalmi élet Győr-Moson-Sopron vármegye szereplőiről emlékezünk meg egy irodalmi sétán.\n'),
(63, 'VASI VASEMBER 2023', '2023-07-08 10:00:00', 'Sport', 0, 70, 'https://www.frisss.hu/img/3019_8193_vasivasember.jpg', 'Miután eldördül a rajtpisztoly, több százan újra vasi vasemberekké válhatnak. Az 1500 m úszás, 40 km kerékpározás és a 10 km futás teljesítése igazán embert próbáló feladat. Az úszótávot Szombathely zöld szívében,a Csónakázó -tóban teljesítik a versenyzői'),
(64, 'HEADS WILL ROLL ✘ Never Say Never', '2023-07-01 21:00:00', 'Zene (koncert)', 16, 71, 'https://www.teleelettel.hu/files/frontend/events/cover/6184cc2f6b4d2da3222fa496e5e99fb4.jpg', 'Ha bármikor is buliztál már Fehérvár szórakozóhelyein, ezzel a 3 sráccal már biztosan összefutottál… Most pedig elhozzuk neked Székesfehérvár legnagyobb házibuliját, ahol mindhárman a pult mögé állnak! '),
(70, 'Winter Fest', '2024-11-30 19:00:00', 'Fesztivál,tematikus napok', 16, 81, 'https://oneticket.hu/uploads/winter-festival-hall-221217.png', 'Bulizz egy hatalmasat a Winter Fest-en Dunaújvárosban. A jó hangulatot DJ-ink és BSW biztosítja!\nItt a helyed!');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `events_perfomers`
--

CREATE TABLE `events_perfomers` (
  `performs_id` int(11) NOT NULL,
  `events_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `events_perfomers`
--

INSERT INTO `events_perfomers` (`performs_id`, `events_id`) VALUES
(38, 38),
(40, 40),
(42, 42),
(43, 43),
(44, 44),
(45, 45),
(59, 59),
(60, 60),
(61, 61),
(62, 62),
(63, 63),
(64, 64),
(74, 70);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `city` varchar(25) NOT NULL,
  `street` varchar(30) NOT NULL,
  `house_number` varchar(5) DEFAULT NULL,
  `capacity` int(6) NOT NULL,
  `applied` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `locations`
--

INSERT INTO `locations` (`id`, `city`, `street`, `house_number`, `capacity`, `applied`) VALUES
(40, 'Győr', 'Egyetem tér', '1', 2500, 0),
(46, 'Szombathely', 'Haladás sportkomplexum', '', 9000, 1),
(48, 'Fertőszéplak', 'Petőfi Sándor utca', '1/A', 10, 0),
(50, 'Sopron', 'Luther Márton tér', '1', 70, 3),
(51, 'Szombathely', 'Március 15. tér', '5', 1000, 0),
(52, 'Szombathely', 'Ady tér', '3', 200, 0),
(53, 'Mosonmagyaróvár', 'Erkel Ferenc utca', '14', 450, 1),
(66, 'Győr', 'Teleki László utca ', '42', 400, 2),
(67, 'Győr', 'Kisfaludy Károly Könyvtár', NULL, 100, 1),
(68, 'Győr', 'Baross út, Csónakos szobor', NULL, 120, 0),
(69, 'Mosonmagyaróvár', 'Deák Ferenc tér', '5', 130, 1),
(70, 'Szombathely ', 'Kenderesi út', '1', 3000, 0),
(71, 'Székesfehérvár', 'Rákóczi utca ', '1', 1200, 1),
(81, 'Dunaújváros', 'Kossuth utca', '123', 1000, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `performers`
--

CREATE TABLE `performers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `performers`
--

INSERT INTO `performers` (`id`, `name`) VALUES
(38, '-'),
(40, '-'),
(42, 'DJ Regán Lili'),
(43, 'Szénás Dóra'),
(44, 'Kovács Krisztián, Scherer Péter, Gyulay Eszter, Su'),
(45, ' Janklovics Péter'),
(59, 'Bock Valér'),
(60, '-'),
(61, 'Dr. Dézsi Csaba András'),
(62, 'Kisbakonyiné Hollósi Emese'),
(63, 'Kattus Attila, Jakabos Zsuzsanna'),
(64, 'CROTTER, VARNING, TAKIGABO, DJ PARAFA'),
(74, 'Ed Sheeran');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(65) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `permission` varchar(15) NOT NULL,
  `birthdate` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `nationality` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `gender`, `permission`, `birthdate`, `email`, `nationality`) VALUES
(4, 'Fekete Klaudia', '$2b$10$GZAbb1MqmNu.kCCwqQq7HubJy7m4tQGIrM5KyX5fforAeyYWf7plK', 'Nő', 'user', '2007-04-15', 'feketeklaudia01@gmail.com', 'Magyar'),
(11, 'GOEVENT! Hungary', '$2b$10$gN2iSQ5d0XHPn9UBiKajselpKIn1lThkrwqkc0S.E2y.j2Tqzv0M.', 'Férfi', 'admin', '2001-01-15', 'goeventhungary@gmail.com', 'Magyar'),
(22, 'Dernóczi Balázs', '$2b$10$zLcqIqm4xhYcYKX9mOmxj.tKzoNTkMNi1xd2/xJxH/jEOXQqmDf8K', 'Férfi', 'admin', '2001-06-18', 'dernoczi.balazs@students.jedlik.eu', 'Magyar'),
(23, 'Kiss Maja', '$2b$10$lW7R818fPlt224FARmRaN..sc6iBtAlXoq1Z2AHlly5VHI7GbkM6y', 'Nő', 'user', '2005-12-09', 'kissmaja2005@gmail.com', 'Magyar'),
(24, 'Ferenczy Kata', '$2b$10$LcJO97fU/I9kwX1bCDsCqeQfyfxzvaZtGODs4gcwV/EuWD1tahz3a', 'Nő', 'user', '2000-06-22', 'ferenczykata@smr.hu', 'Magyar'),
(25, 'Soós Liza', '$2b$10$J50AlOfotQEmFw2mw96mDePglaGVFTsNPVC/u3HTYtPVeQFZBguhy', 'Nő', 'user', '2004-07-12', 'soosliza0712@freemail.hu', 'Magyar'),
(26, 'Kovács Péter', '$2b$10$GpItHumkg71k5vmZU.rAdeVrFl4z0ILgOlULXSXXKVoG1LEpHsmnq', 'Férfi', 'user', '1992-10-04', 'kvts.peter92@gmail.com', 'Magyar'),
(27, 'Lukas Neumüller', '$2b$10$x4YcmH/6FohgOqIOR0Tw8e4RycB4tjD0UM0s5KtFfT5C0B0eoLqIe', 'Férfi', 'user', '2000-11-15', 'lukasneumuller2000@gmx.at', 'Osztrák'),
(28, 'Nagy Zoltán', '$2b$10$MMlGoYzCOrcDajOUHkYKhuMtMG2/EobPWRRM6CJVLliuNOd2Qe4YK', 'Férfi', 'user', '1971-02-21', 'Nagy.Zoltan1971@gmail.com', 'Magyar'),
(29, 'Fehér Sára', '$2b$10$720Y4woQj1MO1qTvbxljveaE5q1QmvKfvFrmC30.R2.Z6hfHaWF8q', 'Nő', 'user', '2007-03-20', 'fehersara20070320@gmail.com', 'Magyar');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users_events`
--

CREATE TABLE `users_events` (
  `events_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `event_pass_code` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users_events`
--

INSERT INTO `users_events` (`events_id`, `users_id`, `event_pass_code`) VALUES
(45, 11, 'e56bcc34-93af-4fbd-b1cb-2d0b5ee430ca'),
(60, 4, 'ede577c7-43a7-4916-95f6-ac41b45862e2'),
(62, 4, 'e69e6574-d7b1-411e-acbf-5ad2bcd0a34a'),
(64, 11, '174e1af0-9e09-4de2-b096-6ae8c6c4eae1');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `eventproperties`
--
ALTER TABLE `eventproperties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_eventproperties_loc_id` (`loc_id`);

--
-- A tábla indexei `events_perfomers`
--
ALTER TABLE `events_perfomers`
  ADD PRIMARY KEY (`performs_id`,`events_id`),
  ADD KEY `FK_events_perfomers_events_id` (`events_id`);

--
-- A tábla indexei `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `performers`
--
ALTER TABLE `performers`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users_events`
--
ALTER TABLE `users_events`
  ADD PRIMARY KEY (`events_id`,`users_id`),
  ADD KEY `FK_users_events_users_id` (`users_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `eventproperties`
--
ALTER TABLE `eventproperties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT a táblához `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT a táblához `performers`
--
ALTER TABLE `performers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `eventproperties`
--
ALTER TABLE `eventproperties`
  ADD CONSTRAINT `FK_eventproperties_loc_id` FOREIGN KEY (`loc_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION;

--
-- Megkötések a táblához `events_perfomers`
--
ALTER TABLE `events_perfomers`
  ADD CONSTRAINT `FK_events_perfomers_events_id` FOREIGN KEY (`events_id`) REFERENCES `eventproperties` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_events_perfomers_performs_id` FOREIGN KEY (`performs_id`) REFERENCES `performers` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Megkötések a táblához `users_events`
--
ALTER TABLE `users_events`
  ADD CONSTRAINT `FK_users_events_events_id` FOREIGN KEY (`events_id`) REFERENCES `eventproperties` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `FK_users_events_users_id` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
