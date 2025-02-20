/*
    Database Seeding Script
    ----------------------------------------
    This script populates the database with sample data for testing and development purposes.
*/

USE ConferenceCenterDB;
GO

-- Table `Reservations.Customers`
INSERT INTO Reservations.Customers (CompanyName, TIN, RegistrationDate, ContactDetails, AdditionalInfo)
VALUES 
(
    'Energy Transfer Equity, L.P.',
    '2230924517',
    '2022-11-06 20:41:45',
    '<ContactDetails>
        <Address>
            <Street>41 Brown Court</Street>
            <PostalCode>78220</PostalCode>
            <City>San Antonio</City>
            <Country>United States</Country>
        </Address>
        <Phone>210-101-3858</Phone>
        <Email>zkenvin0@addtoany.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient preferuje kontakt e-mailowy w godzinach 9:00–12:00.</Notes>
        <Feedback>"Bardzo zadowoleni z jakości sali – przestronna, dobrze wyposażona i komfortowa dla uczestników."</Feedback>
    </AdditionalInfo>'
),
(
    'Crown Holdings, Inc.',
    '0372119211',
    '2022-07-21 04:24:01',
    '<ContactDetails>
        <Address>
            <Street>2 Browning Hill</Street>
            <PostalCode>27635</PostalCode>
            <City>Raleigh</City>
            <Country>United States</Country>
        </Address>
        <Phone>919-975-9302</Phone>
        <Email>vpirt1@friendfeed.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się produkcją filmów reklamowych – spotkania dotyczą głównie planowania kampanii i produkcji.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Bank of the Ozarks',
    '3451571678',
    '2024-06-14 05:28:16',
    '<ContactDetails>
        <Address>
            <Street>5840 Kedzie Way</Street>
            <PostalCode>32605</PostalCode>
            <City>Gainesville</City>
            <Country>United States</Country>
        </Address>
        <Phone>352-564-0670</Phone>
        <Email>agarland2@vistaprint.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się doradztwem biznesowym i organizuje regularne szkolenia dla swoich pracowników.</Notes>
        <Feedback>"Catering był świetny, szczególnie podobały się wegetariańskie opcje. Goście byli bardzo zadowoleni z przekąsek."</Feedback>
    </AdditionalInfo>'
),
(
    'Teekay LNG Partners L.P.',
    '6000039979',
    '2024-02-26 05:27:05',
    '<ContactDetails>
        <Address>
            <Street>5 Continental Point</Street>
            <PostalCode>76198</PostalCode>
            <City>Fort Worth</City>
            <Country>United States</Country>
        </Address>
        <Phone>682-921-8531</Phone>
        <Email>edensham3@answers.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się produkcją filmów reklamowych – spotkania dotyczą głównie planowania kampanii i produkcji.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Overseas Shipholding Group, Inc.',
    '0752980078',
    '2021-03-16 22:00:15',
    '<ContactDetails>
        <Address>
            <Street>2 Dennis Parkway</Street>
            <PostalCode>15240</PostalCode>
            <City>Pittsburgh</City>
            <Country>United States</Country>
        </Address>
        <Phone>412-181-3472</Phone>
        <Email>gbibbie4@boston.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to menedżer działu HR w dużej korporacji, organizuje spotkania dotyczące rozwoju kariery i szkoleń dla pracowników.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Gentex Corporation',
    '2376651094',
    '2022-06-28 21:04:21',
    '<ContactDetails>
        <Address>
            <Street>54 Hooker Circle</Street>
            <PostalCode>97229</PostalCode>
            <City>Portland</City>
            <Country>United States</Country>
        </Address>
        <Phone>971-338-0235</Phone>
        <Email>hbletsor5@sina.com.cn</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>"Temperatura w sali była trochę zbyt wysoka, mimo że prosiliśmy o dostosowanie. Może warto dodać indywidualną kontrolę temperatury dla każdej strefy."</Feedback>
    </AdditionalInfo>'
),
(
    'MarineMax, Inc.',
    '0299258435',
    '2021-09-22 00:09:56',
    '<ContactDetails>
        <Address>
            <Street>6210 Rusk Crossing</Street>
            <PostalCode>28405</PostalCode>
            <City>Wilmington</City>
            <Country>United States</Country>
        </Address>
        <Phone>910-549-1049</Phone>
        <Email>ddockreay6@google.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to CEO małej firmy marketingowej, często organizuje warsztaty z klientami na temat strategii marketingowych.</Notes>
        <Feedback>"Nagłośnienie działało bez zarzutu, ale projektor mógłby być nieco jaśniejszy w jasnym świetle dziennym."</Feedback>
    </AdditionalInfo>'
),
(
    'Cars.com Inc.',
    '6288606273',
    '2022-04-09 23:54:25',
    '<ContactDetails>
        <Address>
            <Street>25458 Mccormick Avenue</Street>
            <PostalCode>33345</PostalCode>
            <City>Fort Lauderdale</City>
            <Country>United States</Country>
        </Address>
        <Phone>754-975-5649</Phone>
        <Email>njenicek7@tinyurl.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Entergy Arkansas, Inc.',
    '3257283142',
    '2022-04-19 10:29:10',
    '<ContactDetails>
        <Address>
            <Street>606 Clyde Gallagher Park</Street>
            <PostalCode>73124</PostalCode>
            <City>Oklahoma City</City>
            <Country>United States</Country>
        </Address>
        <Phone>405-669-9073</Phone>
        <Email>kbranthwaite8@timesonline.co.uk</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się produkcją filmów reklamowych – spotkania dotyczą głównie planowania kampanii i produkcji.</Notes>
        <Feedback>"Zdecydowanie doceniamy, że sala była gotowa na czas, to naprawdę pomogło w płynnej organizacji spotkania."</Feedback>
    </AdditionalInfo>'
),
(
    'Gabelli Utility Trust (The)',
    '6116410780',
    '2022-05-12 14:06:24',
    '<ContactDetails>
        <Address>
            <Street>552 Anthes Road</Street>
            <PostalCode>20566</PostalCode>
            <City>Washington</City>
            <Country>United States</Country>
        </Address>
        <Phone>202-855-0707</Phone>
        <Email>kdethloff9@wisc.edu</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to lider zespołu sprzedażowego w dużej firmie konsultingowej – spotkania są głównie poświęcone strategii sprzedaży.</Notes>
        <Feedback>"Zespół obsługi był bardzo pomocny i reagował szybko na nasze potrzeby. Dziękujemy za elastyczność."</Feedback>
    </AdditionalInfo>'
),
(
    'Saratoga Investment Corp',
    '3233056927',
    '2023-11-10 21:17:02',
    '<ContactDetails>
        <Address>
            <Street>3 Truax Center</Street>
            <PostalCode>23277</PostalCode>
            <City>Richmond</City>
            <Country>United States</Country>
        </Address>
        <Phone>571-473-8675</Phone>
        <Email>sboothebiea@nasa.gov</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'National Holdings Corporation',
    '9920996474',
    '2021-08-18 03:13:09',
    '<ContactDetails>
        <Address>
            <Street>3 Northwestern Center</Street>
            <PostalCode>83727</PostalCode>
            <City>Boise</City>
            <Country>United States</Country>
        </Address>
        <Phone>208-947-9735</Phone>
        <Email>mfurstb@marketwatch.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to lider zespołu sprzedażowego w dużej firmie konsultingowej – spotkania są głównie poświęcone strategii sprzedaży.</Notes>
        <Feedback>"Wydarzenie przebiegło sprawnie, ale brakowało nam przestrzeni do przerw – kolejne spotkanie rozważymy salę z większą przestrzenią."</Feedback>
    </AdditionalInfo>'
),
(
    'NASDAQ TEST STOCK',
    '2745811334',
    '2021-08-06 04:29:04',
    '<ContactDetails>
        <Address>
            <Street>0 Almo Alley</Street>
            <PostalCode>75323</PostalCode>
            <City>Dallas</City>
            <Country>United States</Country>
        </Address>
        <Phone>214-241-9678</Phone>
        <Email>tsoanc@rambler.ru</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta specjalizuje się w rozwiązaniach IT, często organizują spotkania dla programistów i inżynierów.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Stanley Black & Decker, Inc.',
    '6040527166',
    '2024-07-14 12:06:04',
    '<ContactDetails>
        <Address>
            <Street>13464 Londonderry Plaza</Street>
            <PostalCode>11215</PostalCode>
            <City>Brooklyn</City>
            <Country>United States</Country>
        </Address>
        <Phone>917-610-5294</Phone>
        <Email>scestardd@gnu.org</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient preferuje kontakt e-mailowy w godzinach 9:00–12:00.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Nuveen Select Maturities Municipal Fund',
    '0549992900',
    '2024-10-22 05:13:30',
    '<ContactDetails>
        <Address>
            <Street>10 Banding Hill</Street>
            <PostalCode>85030</PostalCode>
            <City>Phoenix</City>
            <Country>United States</Country>
        </Address>
        <Phone>602-473-0432</Phone>
        <Email>dbalazote@umn.edu</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>"Proszę, aby przy rezerwacjach dla większych grup zapewniać więcej stolików na przerwy kawowe – goście mieli problem z miejscem."</Feedback>
    </AdditionalInfo>'
),
(
    'J & J Snack Foods Corp.',
    '7943457616',
    '2021-10-21 15:49:59',
    '<ContactDetails>
        <Address>
            <Street>1 Linden Junction</Street>
            <PostalCode>33673</PostalCode>
            <City>Tampa</City>
            <Country>United States</Country>
        </Address>
        <Phone>813-132-9084</Phone>
        <Email>jharkerf@privacy.gov.au</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient lubi korzystać z nowoczesnych narzędzi do prezentacji multimedialnych, zawsze wymaga sprzętu audio-wizualnego wysokiej jakości.</Notes>
        <Feedback>"Zadowoleni z opcji bufetu, jednak bardziej różnorodne desery byłyby mile widziane."</Feedback>
    </AdditionalInfo>'
),
(
    'Intuitive Surgical, Inc.',
    '7746878442',
    '2023-09-08 09:06:41',
    '<ContactDetails>
        <Address>
            <Street>97 Northfield Plaza</Street>
            <PostalCode>38161</PostalCode>
            <City>Memphis</City>
            <Country>United States</Country>
        </Address>
        <Phone>901-810-1365</Phone>
        <Email>bsayerg@slate.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się doradztwem biznesowym i organizuje regularne szkolenia dla swoich pracowników.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Peapack-Gladstone Financial Corporation',
    '1375929828',
    '2022-05-21 10:07:04',
    '<ContactDetails>
        <Address>
            <Street>52316 Green Court</Street>
            <PostalCode>92668</PostalCode>
            <City>Orange</City>
            <Country>United States</Country>
        </Address>
        <Phone>650-145-0338</Phone>
        <Email>blambotinh@tinyurl.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to CEO małej firmy marketingowej, często organizuje warsztaty z klientami na temat strategii marketingowych.</Notes>
        <Feedback>"Bardzo udana organizacja eventu, ale warto by było rozważyć większą ilość toalet, ponieważ w godzinach szczytu pojawiły się kolejki."</Feedback>
    </AdditionalInfo>'
),
(
    'GNC Holdings, Inc.',
    '4054105665',
    '2021-06-15 01:20:15',
    '<ContactDetails>
        <Address>
            <Street>872 Prentice Pass</Street>
            <PostalCode>25362</PostalCode>
            <City>Charleston</City>
            <Country>United States</Country>
        </Address>
        <Phone>304-683-6316</Phone>
        <Email>atrauti@gravatar.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Altisource Portfolio Solutions S.A.',
    '5849727144',
    '2022-08-04 17:56:56',
    '<ContactDetails>
        <Address>
            <Street>3913 Bluejay Crossing</Street>
            <PostalCode>11247</PostalCode>
            <City>Brooklyn</City>
            <Country>United States</Country>
        </Address>
        <Phone>212-978-2962</Phone>
        <Email>afearesj@senate.gov</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient to przedstawiciel organizacji non-profit, zajmującej się wspieraniem edukacji dzieci w krajach rozwijających się.</Notes>
        <Feedback>"Jakość internetu była doskonała – cała nasza ekipa była w stanie płynnie pracować online przez cały czas trwania wydarzenia."</Feedback>
    </AdditionalInfo>'
),
(
    'Skechers U.S.A., Inc.',
    '8025779673',
    '2021-10-19 23:24:27',
    '<ContactDetails>
        <Address>
            <Street>989 Novick Way</Street>
            <PostalCode>61105</PostalCode>
            <City>Rockford</City>
            <Country>United States</Country>
        </Address>
        <Phone>815-112-3993</Phone>
        <Email>jtunnickk@bizjournals.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta specjalizuje się w rozwiązaniach IT, często organizują spotkania dla programistów i inżynierów.</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Calix, Inc',
    '1065237792',
    '2021-10-19 05:38:10',
    '<ContactDetails>
        <Address>
            <Street>95536 Fremont Lane</Street>
            <PostalCode>33196</PostalCode>
            <City>Miami</City>
            <Country>United States</Country>
        </Address>
        <Phone>786-662-6414</Phone>
        <Email>zpowlesl@miibeian.gov.cn</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Advanced Semiconductor Engineering, Inc.',
    '4675319873',
    '2022-02-02 09:14:25',
    '<ContactDetails>
        <Address>
            <Street>5458 Marcy Park</Street>
            <PostalCode>53726</PostalCode>
            <City>Madison</City>
            <Country>United States</Country>
        </Address>
        <Phone>608-915-2815</Phone>
        <Email>mcoslittm@tamu.edu</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>"Podobała nam się pomoc techniczna, ale zbyt krótka przerwa pomiędzy sesjami sprawiła, że uczestnicy nie zdążyli się zrelaksować."</Feedback>
    </AdditionalInfo>'
),
(
    'Neustar, Inc.',
    '4791185898',
    '2022-05-12 02:11:56',
    '<ContactDetails>
        <Address>
            <Street>35020 Golf Park</Street>
            <PostalCode>62723</PostalCode>
            <City>Springfield</City>
            <Country>United States</Country>
        </Address>
        <Phone>217-283-6216</Phone>
        <Email>vschutzen@cam.ac.uk</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Klient preferuje kontakt e-mailowy w godzinach 9:00–12:00.</Notes>
        <Feedback>"Zdecydowanie bardziej przyjazne byłyby bardziej miękkie krzesła na długie sesje – niektórzy goście skarżyli się na dyskomfort."</Feedback>
    </AdditionalInfo>'
),
(
    'New York REIT, Inc.',
    '1291333219',
    '2021-06-28 00:04:43',
    '<ContactDetails>
        <Address>
            <Street>2105 Eagan Court</Street>
            <PostalCode>63143</PostalCode>
            <City>Saint Louis</City>
            <Country>United States</Country>
        </Address>
        <Phone>314-463-7406</Phone>
        <Email>amillingtono@photobucket.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Applied Optoelectronics, Inc.',
    '6907552040',
    '2022-11-30 13:04:50',
    '<ContactDetails>
        <Address>
            <Street>660 Stoughton Lane</Street>
            <PostalCode>37410</PostalCode>
            <City>Chattanooga</City>
            <Country>United States</Country>
        </Address>
        <Phone>423-214-0631</Phone>
        <Email>ifeathersp@istockphoto.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'IHS Markit Ltd.',
    '4994143838',
    '2021-01-24 22:06:36',
    '<ContactDetails>
        <Address>
            <Street>73963 Sugar Street</Street>
            <PostalCode>23277</PostalCode>
            <City>Richmond</City>
            <Country>United States</Country>
        </Address>
        <Phone>571-664-8678</Phone>
        <Email>mhabbertq@people.com.cn</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>"Ogólnie bardzo pozytywne wrażenie. Może warto byłoby zaoferować uczestnikom dodatkowe opcje transportu z hotelu do centrum konferencyjnego, zwłaszcza w okresie większego natężenia ruchu."</Feedback>
    </AdditionalInfo>'
),
(
    'National Holdings Corporation',
    '3380896459',
    '2022-09-09 11:37:09',
    '<ContactDetails>
        <Address>
            <Street>699 Ridgeview Trail</Street>
            <PostalCode>94291</PostalCode>
            <City>Sacramento</City>
            <Country>United States</Country>
        </Address>
        <Phone>916-687-7229</Phone>
        <Email>lshoreyr@shutterfly.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'UGI Corporation',
    '9887252702',
    '2024-10-17 06:23:24',
    '<ContactDetails>
        <Address>
            <Street>64 Barnett Circle</Street>
            <PostalCode>30061</PostalCode>
            <City>Marietta</City>
            <Country>United States</Country>
        </Address>
        <Phone>770-344-7040</Phone>
        <Email>gmandress@phpbb.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>null</Notes>
        <Feedback>null</Feedback>
    </AdditionalInfo>'
),
(
    'Barnes & Noble, Inc.',
    '6276370451',
    '2021-09-14 16:57:53',
    '<ContactDetails>
        <Address>
            <Street>1 Oakridge Drive</Street>
            <PostalCode>78715</PostalCode>
            <City>Austin</City>
            <Country>United States</Country>
        </Address>
        <Phone>512-615-1470</Phone>
        <Email>mtestot@tinypic.com</Email>
    </ContactDetails>',
    '<AdditionalInfo>
        <Notes>Firma klienta zajmuje się doradztwem biznesowym i organizuje regularne szkolenia dla swoich pracowników.</Notes>
        <Feedback>"Mogliśmy liczyć na pomoc w zakresie tłumaczeń symultanicznych, ale czasami opóźnienia w tłumaczeniu były nieco uciążliwe."</Feedback>
    </AdditionalInfo>'
);


-- Table `Reservations.Services`
INSERT INTO Reservations.Services (ServiceType, ServiceName, RoomCapacity, Equipment, Description, Price)
VALUES
('conference room', 'Crystal Hall', 50, 'Projector, Audio/Video System, Whiteboards, Conference Phone', 'Modern conference room with panoramic windows and natural light. Ideal for small meetings or workshops.', 250.00),
('conference room', 'Sapphire Suite', 100, 'Projector, Audio/Video System, Whiteboards, Teleconferencing Equipment', 'Spacious room with flexible seating arrangements. Perfect for medium-sized conferences and seminars.', 450.00),
('conference room', 'Eclipse Chamber', 75, 'Projector, Audio/Video System, Flipcharts, Video Conferencing Equipment', 'Elegant room with dark tones and minimalistic design. Suitable for corporate meetings and presentations.', 300.00),
('conference room', 'Skyline Room', 40, 'Whiteboards, Audio/Video System, Video Conferencing', 'Cozy meeting room with a rooftop view. Best for small team discussions or brainstorming sessions.', 200.00),
('conference room', 'The Oasis', 60, 'Projector, Audio/Video System, Whiteboards', 'Room with a serene atmosphere and green plants. Ideal for creative meetings and team building activities.', 350.00),
('conference room', 'Sunset Retreat', 80, 'Projector, Audio/Video System, Flipcharts', 'Bright room with large windows, providing lots of natural light. Perfect for workshops and group discussions.', 400.00),
('conference room', 'The Vault', 120, 'Projector, Audio/Video System, Whiteboards, Video Conferencing Equipment', 'High-tech room with advanced equipment. Great for large conferences or company events.', 500.00),
('conference room', 'Innovation Hub', 55, 'Projector, Audio/Video System, Whiteboards, Conference Phone', 'Room designed for innovation and collaboration, featuring modern tech and flexible layouts.', 275.00),
('conference room', 'Lighthouse Studio', 90, 'Projector, Audio/Video System, Whiteboards', 'Room with creative ambiance, ideal for workshops and team activities.', 375.00),
('conference room', 'The Pavilion', 150, NULL, 'Spacious outdoor conference area. Perfect for events in a relaxed, open-air environment.', 600.00),
('coffee portion', 'Espresso Delight', NULL, NULL, 'Basic buffet and premium coffee service including espresso, cappuccino, and cookies.', 75.00),
('catering portion', 'Basic Buffet', NULL, NULL, 'We offer water (carbonated and non-carbonated), juices (orange, apple) and coca cola. ', 50.00);


-- Table `Reservations.Reservations`
INSERT INTO Reservations.Reservations (ReservationDate, ReservationDetails, TotalPrice, Discount)
VALUES 
(
    '2025-01-10 14:30:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Crystal Hall</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>50</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Presentation</Time>
            <Time>11:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    292.50, 10
),
(
    '2025-01-12 09:15:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sapphire Suite</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>100</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>11:00 AM - Workshop</Time>
            <Time>12:30 PM - Coffee Break</Time>
            <Time>02:00 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    630.00, 15
),
(
    '2025-01-11 13:40:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sunset Retreat</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>80</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>08:30 AM - Team Meeting</Time>
            <Time>10:00 AM - Coffee Break</Time>
            <Time>12:00 PM - Lunch Buffet</Time>
        </Schedule>
    </ReservationDetails>', 
    382.50, 10
),
(
    '2025-01-08 15:00:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>The Vault</Name>
            </Service>
            <Service>
                <Name>Basic Buffet</Name>
                <Quantity>120</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:30 AM - Brainstorming</Time>
            <Time>11:00 AM - Coffee Break</Time>
            <Time>01:00 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    337.50, 10
),
(
    '2025-01-15 12:00:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Skyline Room</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>40</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>10:00 AM - Networking</Time>
            <Time>12:00 PM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    320.00, 15
),
(
    '2025-01-16 09:45:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Innovation Hub</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>55</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>08:00 AM - Corporate Training</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    637.50, 15
),
(
    '2025-01-18 16:20:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Crystal Hall</Name>
            </Service>
            <Service>
                <Name>Basic Buffet</Name>
                <Quantity>35</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>10:00 AM - Presentation</Time>
            <Time>11:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    675.00, 10
),
(   
    '2025-01-20 10:00:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>The Pavilion</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>150</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Seminar</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>12:30 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    325.00, 0
),
(
    '2025-01-21 14:15:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sunset Retreat</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>40</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>08:00 AM - Workshop</Time>
            <Time>10:00 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    700.00, 0
),
(
    '2025-01-22 11:30:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>The Vault</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>100</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:30 AM - Team Discussion</Time>
            <Time>11:00 AM - Coffee Break</Time>
            <Time>12:30 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>',
    550.00, 0
),
(
    '2025-01-23 16:45:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sapphire Suite</Name>
            </Service>
            <Service>
                <Name>Basic Buffet</Name>
                <Quantity>80</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Keynote Speech</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    875.00, 0
),
(
    '2025-01-24 13:00:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Innovation Hub</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>55</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>07:30 AM - Training Session</Time>
            <Time>09:00 AM - Coffee Break</Time>
            <Time>12:00 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    350.00, 0
),
(  
    '2025-01-25 15:20:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Skyline Room</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>40</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>08:00 AM - Strategy Meeting</Time>
            <Time>10:00 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    750.00, 0
),
(
    '2025-01-26 11:00:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Crystal Hall</Name>
            </Service>
            <Service>
                <Name>Basic Buffet</Name>
                <Quantity>30</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Corporate Event</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>12:00 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    500.00, 0
),
(
    '2025-01-27 09:10:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sunset Retreat</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>50</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>08:30 AM - Morning Session</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    275.00, 0
),
(
    '2025-01-28 10:30:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>The Vault</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>100</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>09:00 AM - Leadership Workshop</Time>
            <Time>10:30 AM - Coffee Break</Time>
            <Time>12:30 PM - Buffet Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    525.00, 0
),
(
    '2025-01-28 11:45:00', 
    '<ReservationDetails>
        <Bookedservices>
            <Service>
                <Name>Sapphire Suite</Name>
            </Service>
            <Service>
                <Name>Espresso Delight</Name>
                <Quantity>95</Quantity>
            </Service>
        </Bookedservices>
        <Schedule>
            <Time>10:00 AM - Product Launch</Time>
            <Time>11:30 AM - Coffee Break</Time>
            <Time>01:00 PM - Lunch</Time>
        </Schedule>
    </ReservationDetails>', 
    750.00, 0
);


-- Table `Reservations.booked`
INSERT INTO Reservations.booked (EventDate, $from_id, $to_id)
VALUES
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 1), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 1)),
('2025-02-02', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 2), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 2)),
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 3), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 3)),
('2025-02-03', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 4), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 4)),
('2025-02-04', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 5), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 5)),
('2025-02-02', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 6), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 6)),
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 7), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 7)),
('2025-02-03', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 8), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 8)),
('2025-02-05', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 9), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 9)),
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 10), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 10)),
('2025-02-06', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 11), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 11)),
('2025-02-04', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 12), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 12)),
('2025-02-02', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 13), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 13)),
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 14), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 14)),
('2025-02-05', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 15), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 15)),
('2025-02-06', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 16), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 16)),
('2025-02-01', (SELECT $node_id FROM Reservations.Customers WHERE CustomerID = 17), (SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 17));


-- Table `Reservations.includes`
INSERT INTO Reservations.includes ($from_id, $to_id, Quantity)
VALUES
-- Reservation 1
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 1), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Crystal Hall'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 1), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 50),

-- Reservation 2
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 2), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sapphire Suite'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 2), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 100),

-- Reservation 3
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 3), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sunset Retreat'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 3), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 80),

-- Reservation 4
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 4), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'The Vault'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 4), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Basic Buffet'), 120),

-- Reservation 5
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 5), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Skyline Room'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 5), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 40),

-- Reservation 6
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 6), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Innovation Hub'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 6), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 55),

-- Reservation 7
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 7), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Crystal Hall'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 7), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Basic Buffet'), 35),

-- Reservation 8
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 8), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'The Pavilion'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 8), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 150),

-- Reservation 9
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 9), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sunset Retreat'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 9), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 40),

-- Reservation 10
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 10), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'The Vault'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 10), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 100),

-- Reservation 11
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 11), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sapphire Suite'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 11), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Basic Buffet'), 80),

-- Reservation 12
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 12), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Innovation Hub'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 12), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 55),

-- Reservation 13
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 13), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Skyline Room'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 13), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 40),

-- Reservation 14
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 14), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Crystal Hall'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 14), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Basic Buffet'), 30),

-- Reservation 15
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 15), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sunset Retreat'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 15), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 50),

-- Reservation 16
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 16), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'The Vault'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 16), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 100),

-- Reservation 17
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 17), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Sapphire Suite'), 1),
((SELECT $node_id FROM Reservations.Reservations WHERE ReservationID = 17), (SELECT $node_id FROM Reservations.Services WHERE ServiceName = 'Espresso Delight'), 95);


-- Table `Inventory.Inventory`
INSERT INTO Inventory.Inventory (MaterialName, CurrentStock, MinimumLevel, Unit, ConversionFactor, SuggestedOrderQuantity)
VALUES
('Coffee', 30.00, 2, 'kg', 50, 10),                -- 1 kg = 50 event portions (200 ml = 20 g)
('Tea', 20.00, 5, 'pack', 10, 30),                 -- 1 pack = 10 event portions
('Cookies', 50.00, 10, 'pack', 4, 50),             -- 1 pack = 4 event portions
('Coca-Cola', 100.00, 40, 'bottle', 1, 300),       -- 1 bottle = 1 event portion
('Still Water', 200.00, 80, 'bottle', 1, 500),     -- 1 bottle = 1 event portion
('Sparkling Water', 200.00, 80, 'bottle', 1, 500), -- 1 bottle = 1 event portion
('Orange Juice', 80.00, 50, 'bottle', 1, 300),     -- 1 bottle = 1 event portion
('Apple Juice', 100.00, 10, 'bottle', 1, 300),     -- 1 bottle = 1 event portion
('Whiteboard Paper', 5.00, 3, 'pack', 30, 10),     -- 1 pack = 30 sheets, used in pieces
('Whiteboard Marker', 6.00, 5, 'pack', 5, 10),     -- 1 pack = 5 markers, used in pieces
('Drink Cup', 100.00, 20, 'pack', 50, 5),          -- 1 pack = 50 pieces, consumed 1 per person
('Disposable Plate', 100.00, 20, 'pack', 50, 5);   -- 1 pack = 50 pieces, consumed 1 per person


-- Table `Inventory.LowStockRecords`
INSERT INTO Inventory.LowStockRecords (MaterialID, MaterialName, DetectedDate, IsProcessed)
VALUES
    (1, 'Coffee', '2025-02-19 11:00:00', 0),
    (4, 'Coca-Cola', '2025-02-19 10:30:00', 1),
    (7, 'Orange Juice', '2025-02-19 9:45:00', 0);


-- Table `Events.CompletedEvents`
INSERT INTO Events.CompletedEvents (ReservationID, EventDate, Description)
VALUES 
(1, '2025-02-01 10:00:00', '50 participants, 50 coffee servings, 0 basic servings'),
(2, '2025-02-02 14:30:00', '100 participants, 100 coffee servings, 0 basic servings'),
(3, '2025-02-03 09:15:00', '80 participants, 80 coffee servings, 0 basic servings'),
(4, '2025-02-04 16:45:00', '120 participants, 0 coffee servings, 120 basic servings'),
(5, '2025-02-05 11:00:00', '40 participants, 40 coffee servings, 0 basic servings'),
(8, '2025-02-06 13:20:00', '150 participants, 150 coffee servings, 0 basic servings'),
(10, '2025-02-06 18:00:00', '100 participants, 100 coffee servings, 0 basic servings'),
(11, '2025-02-07 08:45:00', '80 participants, 0 coffee servings, 80 basic servings'),
(12, '2025-02-07 12:10:00', '55 participants, 55 coffee servings, 0 basic servings'),
(17, '2025-02-07 17:30:00', '95 participants, 95 coffee servings, 0 basic servings');


-- Table `Feedback.Reviews`
INSERT INTO Feedback.Reviews (CustomerID, EventID, Review, Comment)
VALUES 
    (1, 1, 5, 'Everything was perfect! Great service, delicious coffee, and well-organized event.'),
    (2, 2, 4, 'Very good experience. The event was well planned, but the coffee could have been hotter.'),
    (3, 3, 3, 'Average experience. The venue was nice, but there were some delays in service.'),
    (4, 4, 2, 'Not the best experience. The food was cold, and the event started late.'),
    (5, 5, 1, 'Very disappointed! The service was slow, and the event was poorly managed.'),
    (8, 6, 5, 'Fantastic event! Everything was smooth, and the refreshments were excellent.'),
    (10, 7, 4, 'Great experience! The only issue was a lack of seating in the conference hall.'),
    (11, 8, 3, 'It was okay. Nothing special, but nothing too bad either.'),
    (12, 9, 2, 'The organization was not good. We waited too long for refreshments.'),
    (17, 10, 1, 'Worst event I have attended. Poor service and very disorganized.');


-- Table `Events.EventMaterials`
INSERT INTO Events.EventMaterials
VALUES 
    -- Event 1:
    (1, 1, 50), (1, 2, 50), (1, 3, 50), (1, 4, 50), (1, 5, 50), 
    (1, 6, 50), (1, 7, 50), (1, 8, 50), (1, 11, 50), (1, 12, 50),
    (1, 9, 3), (1, 10, 4),

    -- Event 2:
    (2, 1, 100), (2, 2, 100), (2, 3, 100), (2, 4, 100), (2, 5, 100), 
    (2, 6, 100), (2, 7, 100), (2, 8, 100), (2, 11, 100), (2, 12, 100),
    (2, 9, 5), (2, 10, 2),

    -- Event 3:
    (3, 1, 80), (3, 2, 80), (3, 3, 80), (3, 4, 80), (3, 5, 80), 
    (3, 6, 80), (3, 7, 80), (3, 8, 80), (3, 11, 80), (3, 12, 80),
    (3, 9, 2), (3, 10, 3),

    -- Event 4:
    (4, 4, 120), (4, 5, 120), (4, 6, 120), (4, 7, 120), (4, 8, 120), 
    (4, 11, 120),
    (4, 9, 4), (4, 10, 1),

    -- Event 5:
    (5, 1, 40), (5, 2, 40), (5, 3, 40), (5, 4, 40), (5, 5, 40), 
    (5, 6, 40), (5, 7, 40), (5, 8, 40), (5, 11, 40), (5, 12, 40),
    (5, 9, 1), (5, 10, 2),

    -- Event 6:
    (6, 1, 150), (6, 2, 150), (6, 3, 150), (6, 4, 150), (6, 5, 150), 
    (6, 6, 150), (6, 7, 150), (6, 8, 150), (6, 11, 150), (6, 12, 150),
    (6, 9, 3), (6, 10, 5),

    -- Event 7:
    (7, 1, 100), (7, 2, 100), (7, 3, 100), (7, 4, 100), (7, 5, 100), 
    (7, 6, 100), (7, 7, 100), (7, 8, 100), (7, 11, 100), (7, 12, 100),
    (7, 9, 2), (7, 10, 4),

    -- Event 8:
    (8, 4, 80), (8, 5, 80), (8, 6, 80), (8, 7, 80), (8, 8, 80), 
    (8, 11, 80),
    (8, 9, 3), (8, 10, 2),

    -- Event 9:
    (9, 1, 55), (9, 2, 55), (9, 3, 55), (9, 4, 55), (9, 5, 55), 
    (9, 6, 55), (9, 7, 55), (9, 8, 55), (9, 11, 55), (9, 12, 55),
    (9, 9, 5), (9, 10, 3),

    -- Event 10:
    (10, 1, 95), (10, 2, 95), (10, 3, 95), (10, 4, 95), (10, 5, 95), 
    (10, 6, 95), (10, 7, 95), (10, 8, 95), (10, 11, 95), (10, 12, 95),
    (10, 9, 1), (10, 10, 4);


-- Table `Orders.Orders`
INSERT INTO Orders.Orders (OrderDate, OrderStatus) 
VALUES
('2025-01-14 12:31:33', 'Completed'),
('2025-01-30 12:31:33', 'New'),
('2025-01-27 12:31:33', 'In progress'),
('2025-01-22 12:31:33', 'New'),
('2025-02-02 12:31:33', 'Completed'),
('2025-02-05 12:31:33', 'In progress'),
('2025-01-31 12:31:33', 'Cancelled'),
('2025-01-20 12:31:33', 'Completed'),
('2025-02-05 12:31:33', 'Completed'),
('2025-01-14 12:31:33', 'New');


-- Table `Orders.OrderDetails`
INSERT INTO Orders.OrderDetails (OrderID, MaterialID, MaterialName, Quantity) 
VALUES
    -- Order 1:
    (1, 6, 'Sparkling Water', 5),
    (1, 3, 'Cookies', 5),
    (1, 12, 'Disposable Plate', 2),

    -- Order 2:
    (2, 4, 'Coca-Cola', 4),
    (2, 5, 'Still Water', 1),
    (2, 10, 'Whiteboard Marker', 5),

    -- Order 3:
    (3, 6, 'Sparkling Water', 3),
    (3, 10, 'Whiteboard Marker', 1),
    (3, 1, 'Coffee', 2),

    -- Order 4:
    (4, 3, 'Cookies', 3),
    (4, 4, 'Coca-Cola', 5),
    (4, 7, 'Orange Juice', 5),

    -- Order 5:
    (5, 8, 'Apple Juice', 2),
    (5, 12, 'Disposable Plate', 2),
    (5, 1, 'Coffee', 5),

    -- Order 6:
    (6, 4, 'Coca-Cola', 5),
    (6, 7, 'Orange Juice', 2),
    (6, 8, 'Apple Juice', 1),

    -- Order 7:
    (7, 11, 'Drink Cup', 4),
    (7, 6, 'Sparkling Water', 2),
    (7, 5, 'Still Water', 1),

    -- Order 8:
    (8, 5, 'Still Water', 1),
    (8, 3, 'Cookies', 3),
    (8, 1, 'Coffee', 4),

    -- Order 9:
    (9, 8, 'Apple Juice', 1),
    (9, 3, 'Cookies', 2),
    (9, 1, 'Coffee', 5),

    -- Order 10:
    (10, 6, 'Sparkling Water', 3),
    (10, 9, 'Whiteboard Paper', 1),
    (10, 2, 'Tea', 3);